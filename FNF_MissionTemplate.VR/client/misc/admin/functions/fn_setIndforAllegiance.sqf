/*
  Author: IndigoFox

  Description:
    Used to change Independent allegiance on the fly during FNF, in case they're improperly set by MM.

  Arguments:
    0: side that independent should be friendly to <SIDE>

  Returns:
    true on success <BOOLEAN>
*/

params [["_sideFriendly", sideEmpty, [sideEmpty]], ["_adminId", "", [""]]];

// establish correct code based on _sideFriendly, and assume other sides should be hostile
private _fixedEncryptionCode = ""; // the side indfor should be able to talk to
switch (_sideFriendly) do {
  case west: {
    _fixedEncryptionCode = "_bluefor";
  };
  case east: {
    _fixedEncryptionCode = "_opfor"
  };
  case sideEmpty: {
    _fixedEncryptionCode = "_independent";
  };
};

// figure out the players whose radios need adjusting
private _playersToFix = (allPlayers select {alive _x && side _x == independent});

// apply the radio changes clientside
[_fixedEncryptionCode, {
  if (call TFAR_fnc_haveSwRadio) then {
    [(call TFAR_fnc_activeSwRadio), _this] call TFAR_fnc_setSwRadioCode;
  };
  if (call TFAR_fnc_haveLRRadio) then {
    [(call TFAR_fnc_activeLrRadio), _this] call TFAR_fnc_setLrRadioCode;
  };
  diag_log formatText["[FNF] (admin) Fixed radio codes due to Independent side association change."];
}] remoteExecCall ["call", _playersToFix];


// apply friendlySides changes serverside

// make enemy Side hostile to independent and vice versa
private _enemySide = [west, east] select {_x != _sideFriendly};
{
  _x setFriend [independent, 0];
  independent setFriend [_x, 0];
} forEach _enemySide;

// make independent friendly to _sideFriendly
if !(_sideFriendly isEqualTo sideEmpty) then {
  independent setFriend [_sideFriendly, 1];
  _sideFriendly setFriend [independent, 1];
  [
    format[
      "<t align='center'>The Independent faction is now allied with<br/>%1<br/>and hostile to<br/>%2</t>",
      _sideFriendly call BIS_fnc_sideName,
      (_enemySide # 0) call BIS_fnc_sideName
    ],
    "info",
    10
  ] remoteExecCall ["phx_ui_fnc_notify", 0];
} else {
  [
    format[
      "<t align='center'>The Independent faction is now hostile to BLUFOR and OPFOR.</t>"
    ],
    "info",
    10
  ] remoteExecCall ["phx_ui_fnc_notify", 0];
};

(getUserInfo _adminId) params ["_networkId","_owner","_playerUID","_soldierName","_soldierNameInclSquad","_steamProfileName","_clientStateNumber","_isHeadless","_adminState","_netPerf","_playerObject"];

private _out = [];
_out pushBack format["ACTOR: %1", _soldierName];
_out pushBack format["ACTION: SetIndforAllegiance"];
_out pushBack format["Adjusted Independent side association."];
_out pushBack format["Friendly to %1,", _sideFriendly call BIS_fnc_sideName];
_out pushBack format["hostile to %1", _enemySide apply {_x call BIS_fnc_sideName}];



[
  "FNF_UIPanelAdmin_ReturnStatus",
  _out joinString "<br/>"
] call CBA_fnc_globalEvent;


// sends event to server w/ information
// used for Discord report
["phxAdminMessageServer", [
  "",
  name player,
  (_out joinString "\n"),
  (playerSide call BIS_fnc_sideID) call BIS_fnc_sideName,
  format [
    "%1 in %2",
    ((roleDescription player) splitString '@') # 0,
    groupId (group player)
  ],
  briefingName,
  worldName,
  _grid,
  // cba_missionTime
  [cba_missionTime / 60, "HH:MM"] call BIS_fnc_timeToString
]] call CBA_fnc_serverEvent;
