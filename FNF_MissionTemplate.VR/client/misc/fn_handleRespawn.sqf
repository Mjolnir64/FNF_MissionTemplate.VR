params [
  ["_newUnit", objNull, [objNull], 1],
  ["_oldUnit", objNull, [objNull], 1]
];

if (typeOf player == "ace_spectator_virtual") exitWith {};

// loadout
[player getVariable ["fnfLoadout", "BASE"]] call fnf_loadout_fnc_applyLoadout;
[{time > 2}, {call fnf_admin_fnc_setAdminPatch}] call CBA_fnc_waitUntilAndExecute; // Admin player patch
// [false] call ace_spectator_fnc_setSpectator;

if (missionNamespace getVariable ["ace_spectator_isset", false]) then {
  [false] call ace_spectator_fnc_setSpectator;
};

if !(fnf_gameMode == "sustainedAssault") then {
  // teleport to safe start if able
  private _pos = missionNamespace getVariable ["fnf_startGoodPos", [0,0,0]];
  if (surfaceIsWater _pos) then {
    player setPosASLW _pos;
  } else {
    player setPosATL _pos;
  };

  // fn_checkAlive
  [player, {
  if (!isNil "fnf_playersInMission") then {
    fnf_playersInMission pushBack _this;
  };
  }] remoteExecCall ["call", 2];
};




if (fnf_gameMode == "sustainedAssault") then {
  _newUnit setVariable ["ACE_canMoveRallypoint", false, true];
  if (isNil {fnf_ui getVariable ["fnf_drawHelpersHandle",nil]}) then {
    call fnf_ui_fnc_drawHelpers;
  };
};

call fnf_restrictions_fnc_init;
call fnf_safety_fnc_init;

// remove ACE SOG Compat digging additions of small trench and spiderholes that doesn't require ETool
// remove ETool-less trench from all
// remove spiderholes from non-NVA loadouts
[{!isNil "mySideGearSelection" && !is3DEN}, {
  if (isClass ((configOf player) >> "ACE_SelfActions" >> "ACE_Equipment" >> "ace_compat_sog_digSpiderhole")) then {
    if !(["NVA", mySideGearSelection] call BIS_fnc_inString) then {
      [(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment", "ace_compat_sog_digSpiderhole"]] call ace_interact_menu_fnc_removeActionFromClass;
      [(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment", "ace_compat_sog_digSpiderholeAngled"]] call ace_interact_menu_fnc_removeActionFromClass;
      [(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment", "ace_compat_sog_digSpiderholeDual"]] call ace_interact_menu_fnc_removeActionFromClass;
    };
    // [(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment", "ace_trenches_digEnvelopeSmall"]] call ace_interact_menu_fnc_removeActionFromClass;
  };
}, [], 10] call CBA_fnc_waitUntilAndExecute;
