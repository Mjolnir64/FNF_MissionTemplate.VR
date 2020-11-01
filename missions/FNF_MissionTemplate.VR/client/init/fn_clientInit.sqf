//Make sure client mission time is synced with server
[{(CBA_missionTime > 1)}, {
  46 spawn phx_fnc_disableTyping;
  [clientOwner] remoteExec ["phx_server_updateMissionTime", 2];
}] call CBA_fnc_waitUntilAndExecute;

//Remove player from server kick list once loadout is set
[] spawn phx_fnc_removeKick;

//Exit if player is spectator
if (typeOf player == "ace_spectator_virtual") exitWith {call phx_fnc_spectatorInit};

//Hide markers player shouldn't see
call phx_fnc_markerVisibility;

//Call safety if mission hasn't started yet. If mission has started, call JIP function
if (phx_safetyEnabled) then {call phx_fnc_safety};
if (!phx_safetyEnabled) exitWith {call phx_fnc_clientJIP};

// Set the group IDs
call phx_fnc_setGroupIDs;

// Create briefing
[] execVM "client\briefing\briefing.sqf";

//Make sure player stays within boundaries
call phx_fnc_startBoundary;
call phx_fnc_zoneBoundary;

//Unflip - by KiloSwiss (https://steamcommunity.com/sharedfiles/filedetails/?id=1383176987)
[] spawn phx_fnc_unflipVehicleAddAction;

//Preset radios
call phx_fnc_radio_waitGear;

//Wait for the server to finish setting up the game then call client setup
[{!isNil "phx_serverGameSetup"}, {call phx_fnc_client_setupGame}] call CBA_fnc_waitUntilAndExecute;

//Platoon lead menu
call phx_fnc_platoonActions;

//Marker System
[] execVM "client\QS_icons.sqf";

// Generate ORBAT page
[] execVM "client\briefing\f_orbatNotes.sqf";

//TFAR set volume to whisper
[] spawn {
  waitUntil {sleep 1; !isNil "TF_speak_volume_meters"};
  5 call TFAR_fnc_setVoiceVolume;
  TF_speak_volume_level = "whispering";
};

//[] spawn phx_fnc_getKeys;

//Stop high gamma setting if phx_antiGammaDoping = true in config
phx_gammaWarn = false;
if (phx_antiGammaDoping) then {
  [{
    if (isNull findDisplay 5) exitWith {};
    _gamma = parseNumber (ctrlText (findDisplay 5 displayCtrl 109));
    if (_gamma > 1.3 && !phx_gammaWarn) then {
      cutText ["Gamma setting cannot exceed 1.3 for this mission, please go into settings and lower the value", "BLACK"];
      phx_gammaWarn = true;
    } else {
      if (_gamma <= 1.3 && phx_gammaWarn) then {
        cutText ["", "BLACK IN"];
        phx_gammaWarn = false;
      };
    };
  } , 0.1] call CBA_fnc_addPerFrameHandler;
};

//Force grass on if player setting is too low
[{
  if (getTerrainGrid > 25) then {
    setTerrainGrid 25;
  };
} , 1] call CBA_fnc_addPerFrameHandler;

//Force view distance <= phx_maxViewDistance
[{
  if (viewDistance > phx_maxViewDistance) then {
    setViewDistance phx_maxViewDistance;
  };
} , 1] call CBA_fnc_addPerFrameHandler;

// Wait for mission to start, then execute post briefing init
[{CBA_missionTime > 0}, {
    call phx_fnc_postBriefing;
}, []] call CBA_fnc_waitUntilAndExecute;

//Set loadout
call phx_fnc_setLoadout;

//Client-side fortify
[{missionNamespace getVariable ["phx_loadoutAssigned",false]}, {call phx_fnc_fortifyClient}] call CBA_fnc_waitUntilAndExecute;

//Reenable simulation if it was disabled
player enableSimulation true;
[] spawn {
  player playMove "amovpercmstpslowwrfldnon";
  uisleep 2;
  cutText ["", "PLAIN"];
};

//Weapon selector
[] spawn phx_fnc_gearSelection;

//Make sure player gets assigned gear, if not then kick back to lobby
call phx_fnc_checkLoadout;
