if (!isServer) exitWith {};

phx_adminChannelId = radioChannelCreate [
	[1,1,0,1], // RGBA color
	"Staff Channel", // channel name
	"[STAFF] %UNIT_SIDE %UNIT_GRP_NAME %UNIT_NAME", // callsign
  []
];
publicVariable "phx_adminChannelId";

missionNamespace setVariable [
  "TFAR_DefaultRadio_Personal_Guer",
  TFAR_DefaultRadio_Personal_Independent,
  true
];
missionNamespace setVariable [
  "TFAR_DefaultRadio_Backpack_Guer",
  TFAR_DefaultRadio_Backpack_Independent,
  true
];

call phx_fnc_serverSafety;
call phx_fnc_radio_genFreqs;
call phx_fnc_sendUniforms;
call phx_fnc_fortifyServer;
call phx_fnc_markCustomObjs;
call phx_fnc_server_setupGame;
call phx_admin_fnc_adminPatch;
call phx_fnc_webhook_roundPrep;

call phx_fnc_populateORBATs;
call phx_fnc_keyVehicles;
call phx_fnc_vehicleRadios;


[{!(missionNamespace getVariable ["phx_safetyEnabled",true])}, {call phx_fnc_checkAlive}] call CBA_fnc_waitUntilAndExecute;
[{!isNil "phx_safetyEndTime"}, {call phx_fnc_checkTime}] call CBA_fnc_waitUntilAndExecute;

//Create map cover for zone boundary
private _zoneArea = triggerArea zoneTrigger;
zoneTrigger setVariable ["objectArea", [_zoneArea select 0, _zoneArea select 1, _zoneArea select 2]];
[zoneTrigger,[],true] call BIS_fnc_moduleCoverMap;

// Create respawn markers in bottom left corner of map
{
    private _marker = createMarker [_x, [-1000,-1000,0]];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "Empty";
} forEach ["respawn","respawn_west","respawn_east","respawn_guerrila","respawn_civilian"];

//Clear vehicle inventories
["AllVehicles", "init", {
  private _vic = (_this select 0);
  if (_vic isKindOf "Man") exitWith {}; //Exit so the code below doesn't run for infantry units

  if (_vic getVariable ["fnf_clearInventory", true]) then {
    clearBackpackCargoGlobal _vic;
    clearWeaponCargoGlobal _vic;
    clearItemCargoGlobal _vic;
    clearMagazineCargoGlobal _vic;
  };
}, true, [], true] call CBA_fnc_addClassEventHandler;


["TeamkillDetected", {
  params ["_killed", "_killer"];

  if (isNil "DiscordEmbedBuilder_fnc_buildCfg") exitWith {diag_log text "Failed to send Teamkill webhook -- mod not loaded!"};
  // if (count allPlayers < 14) exitWith {diag_log text "Less than 14 players connected -- skipping RoundPrep Discord post"};

  private _systemTimeFormat = ["%1-%2-%3 %4:%5:%6"];
  _systemTimeFormat append (systemTimeUTC apply {if (_x < 10) then {"0" + str _x} else {str _x}});
  private _inVehicle = "N/A";
  if (vehicle _killer != _killer) then {
    _inVehicle = getText(configFile >> "CfgVehicles" >> (typeOf (vehicle _killer)) >> "displayName");
  };

  private _killerOrgGroup = groupId (group _killer);
  if ((roleDescription _killer) find '@' > -1) then {
    _killerOrgGroup = (roleDescription _killer) splitString '@' select 1;
  };
  private _killedOrgGroup = groupId (group _killed);
  if ((roleDescription _killed) find '@' > -1) then {
    _killedOrgGroup = (roleDescription _killed) splitString '@' select 1;
  };

  [
    "BotNotifications",
    // "Testing",
    "",
    "",
    "",
    false,
    [
      [
        format["TEAMKILL [%1]",[side (group _killer)] call BIS_fnc_sideName],
        format[
          "KILLER: `%1 (%2)`
VICTIM: `%4 (%5)`
VEH: %3 | WEP: `%6` | RNG: `%7m`
ELAPSED: `%8`
UTC: `%9`
MISSION: `%10`",
          name _killer,
          // groupId (group _killer),
          _killerOrgGroup,
          format["`%1`", _inVehicle],
          name _killed,
          // groupId (group _killed),
          _killedOrgGroup,
          getText(configFile >> "CfgWeapons" >> (weaponState _killer select 0) >> "displayName"),
          str(ceil(_killer distance _killed)),
          cba_missionTime,
          format _systemTimeFormat,
          missionName
        ],
        "",
        "00FF00",
        false,
        "",
        "",
        [],
        [],
        []
      ]
    ]
	] call DiscordEmbedBuilder_fnc_buildSqf;
}] call CBA_fnc_addEventHandler;

//Delete player bodies during safe start
phx_server_disconnectBodies = addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];

  if (phx_safetyEnabled) then {
    deleteVehicle _unit;
  } else {
    //Not needed with ace_respawn_removeDeadBodiesDisconnected = false
    //After safety ends, keep player bodies by transfering ownership of the unit to the server and then killing it
    //[{owner (_this select 0) == 2}, {(_this select 0) setDamage 1;}, [_unit], 15] call CBA_fnc_waitUntilAndExecute;
    //true;
  };
}];

// Receives event when a player submits a report
// Determines logged-in admin and sends Discord embed with contents of report and the admin @'ed
phxAdminMessageReceiver = ["phxAdminMessageServer", {
  private _arr = +_this;

  _loggedInAdmins = allPlayers select {
    (admin owner _x) isEqualTo 2 &&
    (getPlayerUID _x) in fnf_staffInfo;
  };
  private _adminDiscordID = "";
  if (count _loggedInAdmins > 0) then {
    _loggedInAdmin = fnf_staffInfo get (getPlayerUID (_loggedInAdmins # 0));
    _adminDiscordID = _loggedInAdmin # 2;
    _arr set [0, _adminDiscordID];
  };

  ["AdminMsg", _arr] call DiscordEmbedBuilder_fnc_buildCfg;
}] call CBA_fnc_addEventHandler;

//Let clients know that server is done setting up
missionNamespace setVariable ["phx_serverGameSetup",true,true];
