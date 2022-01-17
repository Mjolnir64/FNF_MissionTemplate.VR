phx_loadout_roles = [
  ["PL",["Platoon Leader","LIEUTENANT"]],
  ["SGT",["Platoon Sergeant","SERGEANT"]],
  ["SL",["Squad Leader","SERGEANT"]],
  ["TL",["Team Leader","CORPORAL"]],
  ["AR",["Autorifleman","PRIVATE"]],
  ["ARA",["Asst. Autorifleman","PRIVATE"]],
  ["GR",["Grenadier","PRIVATE"]],
  ["GRIR",["Sr. Grenadier","CORPORAL"]],
  ["MG",["Machine Gunner","PRIVATE"]],
  ["MGA",["Asst. Machine Gunner","PRIVATE"]],
  ["CE",["Combat Engineer","PRIVATE"]],
  ["LAT",["AT Rifleman","PRIVATE"]],
  ["MAT1",["AT Specialist","PRIVATE"]],
  ["MATA1",["Asst. AT Specialist","PRIVATE"]],
  ["MAT2",["AT Specialist","PRIVATE"]],
  ["MATA2",["Asst. AT Specialist","PRIVATE"]],
  ["RI",["Rifleman","PRIVATE"]],
  ["RIS",["Sr. Rifleman","CORPORAL"]],
  ["DM",["Marksman","PRIVATE"]],
  ["SNP",["Sniper","CORPORAL"]],
  ["CRL",["Vehicle Cmdr","SERGEANT"]],
  ["CR",["Crewman","CORPORAL"]],
  ["PI",["Pilot","LIEUTENANT"]],
  ["MED",["Medic","CORPORAL"]],
  ["SHQAUX",["Crew/Wpn Operator","PRIVATE"]],
  ["BASE",["Crew/Wpn Operator","PRIVATE"]]
];

//Determine if client can play the round, if not, spectate
if !(call phx_client_fnc_canplay) exitWith {
  diag_log formatText [
    "[FNF] (clientInit) typeOf ""%1"" player %2 was placed in spectator at join. Safestart %3",
    typeOf player,
    name player,
    (if (missionNamespace getVariable ["phx_safetyEnabled", true]) then {"is active"} else {"is not active"})
  ];
  call phx_fnc_contactStaffInit; // Init handling for player reports
  call phx_briefing_fnc_createBriefSpec; // Set up briefing for UI panel
  call phx_briefing_fnc_assetDiaryStruct; // Add diary entries for assets
  call phx_spectator_fnc_init;
};
player enableSimulation false;


call phx_client_fnc_setupGame; //Client portion of game modes
[{missionNamespace getVariable ["phx_markCustomObjs_done", false]}, {
  call phx_restrictions_fnc_hideMarkers; //Hide markers player shouldn't see
  call phx_briefing_fnc_init; //Briefing
  call phx_briefing_fnc_createBriefSpec; // Set up briefing for UI panel
  call phx_briefing_fnc_assetDiary; // Add diary entries for assets
}] call CBA_fnc_waitUntilAndExecute;
call phx_safety_fnc_init; //Enable safety
call phx_client_fnc_staggeredLoad; //Start staggered load timer
call phx_radio_fnc_waitGear; //Start radio preset functions
call phx_fnc_contactStaffInit; // Init handling for player reports

[{missionNamespace getVariable ["phx_briefCreated", false]}, {
  call phx_briefing_fnc_assetDiaryStruct; // Prep global vars for UI info panel
}] call CBA_fnc_waitUntilAndExecute;

call phx_ui_fnc_drawStaffIcons; // Draw labels over staff members
call phx_ui_fnc_drawCmdIcons; // Draw labels over CMD, PL
call phx_ui_fnc_drawSLIcons; // Draw labels over squad leaders

call phx_server_fnc_populateORBATS;
call phx_fnc_teleportInit; // Add leadership teleport options
call phx_client_fnc_initMSPTeleport; // Add MSP teleport option to flagpole if sustainedAssault

//Set player loadout after stagger time
[{missionNamespace getVariable ["phx_staggeredLoaded",false]}, {
  call phx_fnc_showTimeOnMap;
  [player getVariable "phxLoadout"] call phx_loadout_fnc_applyLoadout;
}] call CBA_fnc_waitUntilAndExecute;

// Wait for mission to start, then execute various restrictions and make sure player has gear
[{time > 0}, {
  call phx_restrictions_fnc_init;
  call phx_loadout_fnc_checkLoadout;
  [false] call phx_briefing_fnc_parseGear;
  [] spawn {sleep 0.1; enableEnvironment [false, true]};

  // Compile Date text
  date params ["_year", "_month", "_day", "_hour", "_minute"];

  if (_month < 10) then {_month = format ["0%1", _month]};
  if (_day < 10) then {_day = format ["0%1", _day]};
  if (_hour < 10) then {_hour = format ["0%1", _hour]};
  if (_minute < 10) then {_minute = format ["0%1", _minute]};

  private ["_time", "_date"];
  _time = format ["%1:%2", _hour, _minute];
  _date = format ["%1-%2-%3", _year, _month, _day];

  private _locationTypes = [
    "NameCity",
    "NameCityCapital",
    "NameLocal",
    "NameMarine",
    "NameVillage"
  ];
  private _locationText = "In the middle of nowhere";
  private _locations = nearestLocations [player, _locationTypes, 2000, player];
  if (count _locations > 0) then {
    _locationText = format["Near %1", text (_locations select 0)];
  };

  private _showText = composeText [
    "Welcome to ", serverName, lineBreak,
    briefingName, lineBreak,
    _date, " ", _time, " ", _locationText, lineBreak,
    "Game mode: ", (toUpper phx_gameMode), lineBreak
  ];

  [
    _showText, // content
    true, // position
    10, // tileSize
    10, // duration
    3 // fadeInOutTime
  ] spawn BIS_fnc_textTiles;
}] call CBA_fnc_waitUntilAndExecute;

//Client-side fortify, and gear selector
[{missionNamespace getVariable ["phx_loadoutAssigned",false]}, {
  if !(phx_gameMode == "sustainedAssault") then {
    call phx_fnc_fortifyClient;
  };
  player enableSimulation true;
}] call CBA_fnc_waitUntilAndExecute;


phx_showMissionStatusHandleMap = ["visibleMap", {call BIS_fnc_showMissionStatus}, true] call CBA_fnc_addPlayerEventHandler;

if !(phx_gameMode == "sustainedAssault") then {
  //Start kill counter when game ends or player is dead
  //[{missionNamespace getVariable ["phx_gameEnd",false] || !alive player}, {call phx_fnc_killCounter}] call CBA_fnc_waitUntilAndExecute;
  //Start spectator fnc when player is killed
  player addEventHandler ["Killed", {[{call phx_spectator_fnc_init}, [], 3] call cba_fnc_waitAndExecute;}];


  player addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
    if (!isNull _instigator && (side (group _instigator) == playerSide) && (_unit != _instigator)) exitWith {
      ["TeamkillDetected", [_unit, _instigator]] call CBA_fnc_serverEvent;
    };
    if (side (group _killer) == playerSide && (_unit != _killer)) exitWith {
      ["TeamkillDetected", [_unit, _killer]] call CBA_fnc_serverEvent;
    };
  }];
} else {
  player setVariable ["ACE_canMoveRallypoint", false, true];
};

if (getPlayerUID player in (missionNamespace getVariable ["fnf_staffInfo",[]]) || serverCommandAvailable "#kick") then {
  ["FNF_UIPanelAdmin_ReturnStatus", {
    [
      format [
        "<t align='center' size='1.4' color='#FFFF00'>ADMIN ACTION</t><br/>%1",
        _this
      ],
      "warning",
      10
    ] call phx_ui_fnc_notify;

    if (isNil "phx_adminDisplay") exitWith {};
    private _display = (phx_adminDisplay select 0);
    private "_resultBox";
    if (_display == displayNull) exitWith {
      // [_thisType, _thisId] call CBA_fnc_removeEventHandler;
    };

    _resultBox = _display displayCtrl 10020;
    _resultBox ctrlSetStructuredText (parseText _this);
  }] call CBA_fnc_addEventHandlerArgs;
};

//Marking
[] execVM "client\icons\QS_icons.sqf";
//Unflip - by KiloSwiss (https://steamcommunity.com/sharedfiles/filedetails/?id=1383176987)
[] spawn phx_fnc_unflipVehicleAddAction;

// adds ACE Self-interact to fix uniform bug
private _action = [
  "FixUniformBug",
  "Fix ""No Uniform"" Bug",
  "",
  {[player] call phx_fnc_fixUniformBug},
  {true}
] call ace_interact_menu_fnc_createAction;
[
  player,
  1,
  ["ACE_SelfActions"],
  _action
] call ace_interact_menu_fnc_addActionToObject;


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
    [(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment", "ace_trenches_digEnvelopeSmall"]] call ace_interact_menu_fnc_removeActionFromClass;
  };
}, [], 5] call CBA_fnc_waitUntilAndExecute;

// Zeus actions
_action = [
  "Zeus_GoToLastReport",
  "Zoom to Last Admin Report",
  "\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa",
  {
    [] spawn {
      (missionNamespace getVariable ["phx_lastAdminReporter", [objNull, [0,0,0]]]) params ["_player", "_pos"];
      if (!isNull _player && !(_player in ([] call ace_spectator_fnc_players))) then {
        [
          ((_player getPos [50, 180]) vectorAdd [0,0,30]),
          _player,
          true
        ] spawn BIS_fnc_setCuratorCamera;
      } else {
        if (_pos isEqualTo [0,0,0]) exitWith {
          ["Last Player Report", "Player/location not saved. Have any reports been sent?", 5] call BIS_fnc_curatorHint;
        };
        [
          ((_pos getPos [50, 180]) vectorAdd [0,0,30]),
          _pos,
          true
        ] spawn BIS_fnc_setCuratorCamera;
      };
    };
  },
  {true}
] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _action] call ace_interact_menu_fnc_addActionToZeus;