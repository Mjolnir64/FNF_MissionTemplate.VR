//====================================================================================================
// Server Scripts
if !(isServer) exitWith {};

// Initialize Variables - End Conditions
phx_missionSafeTime = ["f_param_mission_timer",0] call BIS_fnc_getParamValue; //Default - 0 minute safestart
phx_missionRunTime = ["phx_missionTimelimit",45] call BIS_fnc_getParamValue; //Default - 45 minute battle phase
phx_missionRuntimeMins = phx_missionRunTime + phx_missionSafeTime;
phx_alertOver = 1; // Time elapsed warning
phx_alertEnd = 0; // Time elapsed warning
phx_alertSoon = 0; // 15 minute warning
phx_alertSoon1 = 0; //10 minute warning
phx_alertSoon2 = 0; //5 minute warning
phx_gameEnd = false;
call phx_fnc_init_vars;

//Set INDFOR friends
call phx_fnc_init_setIndforFriends;

// Start check ending conditions
phx_end_checkTime = [phx_fnc_end_checkTime, 10, []] call CBA_fnc_addPerFrameHandler;

//Run check to see if side is eliminated
[] spawn phx_fnc_end_checkAlive;

//Fortify Sets
if (phx_allowFortify) then {
  execVM "f\init\fortify_server.sqf";
};

f_param_radios = ["phx_param_radios",0] call BIS_fnc_getParamValue;
if (f_param_radios isEqualTo 1) then {
  // Generate frequencies for preset radios
  call phx_fnc_radio_genFreqs;
};
/*
// Create respawn markers in bottom left corner of map
{
    private _marker = createMarker [_x, [-1000,-1000,0]];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "Empty";
} forEach ["respawn", "respawn_west","respawn_east","respawn_guerrila","respawn_civilian"];
*/

//Set all vehicles invincible during safe start
[] spawn {
  waitUntil {!isNil "phx_safeStartEnabled"};
  while {phx_safeStartEnabled} do {
    {_x allowDamage false;} forEach vehicles;
    sleep 5;
  };
  {_x allowDamage true;} forEach vehicles;
};

//Setup the game
call phx_fnc_init_setupGame;
//====================================================================================================
phx_serverInitFinished = true;
publicVariable "phx_serverInitFinished";

// Call mixed scripts, but only if server is not a player
if !(hasInterface) then {
    call phx_fnc_init_shared;
};
