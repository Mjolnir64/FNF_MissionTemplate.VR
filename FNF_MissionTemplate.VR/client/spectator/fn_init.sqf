/*
Sets player as ACE spectator if not already.
Draws 3D icons on alive objectives.
*/

["featureCamera", {
  disableSerialization;
  _display = findDisplay 60000;
  if (isNull _display) exitWith {};

  _infoButton = _display ctrlCreate ["FNF_MissionInfoPanelSpectatorButton", 2524];
  _infoButton ctrlAddEventHandler ["ButtonClick", {
    if (!dialog) then {
      [] spawn fnf_ui_fnc_missionInfoPanel;
    };
  }];
}] call CBA_fnc_addPlayerEventHandler;

[{!isNull findDisplay 60000}, {
  disableSerialization;
  _display = findDisplay 60000;
  if (isNull _display) exitWith {};

  _infoButton = _display ctrlCreate ["FNF_MissionInfoPanelSpectatorButton", 2524];
  _infoButton ctrlAddEventHandler ["ButtonClick", {
    if (!dialog) then {
      [] spawn fnf_ui_fnc_missionInfoPanel;
    };
  }];
}] call CBA_fnc_waitUntilAndExecute;


if (!(typeOf player == "ace_spectator_virtual") && !ace_spectator_isset) then {
  [true, true, true] call ace_spectator_fnc_setSpectator;
};

//Set camera focus to killer if they exist
private _lastDamage = player getVariable ["ace_medical_lastDamageSource",objNull];
if (!isNull _lastDamage) then {
  [2, _lastDamage] call ace_spectator_fnc_setCameraAttributes;
} else {
  _aliveFriendlyUnits = allUnits select {side (group _x) isEqualTo playerSide && alive _x};
  if (count _aliveFriendlyUnits > 0) then {
    [2, selectRandom(_aliveFriendlyUnits)] call ace_spectator_fnc_setCameraAttributes;
  } else {
    [2, objNull] call ace_spectator_fnc_setCameraAttributes;
  };
};

//Set up objectives for 3d icon draws
// MOVED TO GAMEMODES

call BIS_fnc_showMissionStatus; //show tickets etc. to spectators
//[{!isNull findDisplay 60000}, {call fnf_spectator_fnc_muteSpectators}] call CBA_fnc_waitUntilAndExecute;

//Draw 3d icons for objectives
[{!isNil "fnf_specObjectives"}, {
  {
    [{
      params ["_obj"];

      drawIcon3D ["a3\ui_f\data\map\Markers\Military\objective_CA.paa", [1,0,0,0.8], ASLToAGL getPosASL _obj, 0.6, 0.6, 45];

      if (!alive _obj || !ace_spectator_isSet) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
      };
    } , 0, _x] call CBA_fnc_addPerFrameHandler;
  } forEach fnf_specObjectives;
}, [], 60] call CBA_fnc_waitUntilAndExecute;

fnf_spectatorVisiblePrevinput = true;
fnf_spectatorPrevVisibleCtrls = [];

[{
  private _missionRuntimeSecs = (fnf_missionTimelimit * 60) + fnf_safetyEndTime;
  private _visible = ace_spectator_uiVisible;
  if (_visible != fnf_spectatorVisiblePrevinput) then {
    fnf_spectatorVisiblePrevinput = _visible;
    if !(_visible) then {
      showChat false;

      fnf_spectatorPrevVisibleCtrls = [];
      {
        if (ctrlShown _x) then {
          _x ctrlShow false;
          fnf_spectatorPrevVisibleCtrls append [_x];
        };
      } forEach allControls findDisplay 60000;

      showHUD [false,false,false,false,false,false,false,false,false,false,false];

      if ((_missionRuntimeSecs - (15 * 60)) <= CBA_missionTime) then {
      	[fnf_missionTimeUI_PFH] call CBA_fnc_removePerFrameHandler;
        uiNameSpace getVariable "timeleftStructText" closeDisplay 1;
  		};
    } else {
      showChat true;

      {
        _x ctrlShow true;
      } forEach fnf_spectatorPrevVisibleCtrls;

      showHUD [true,true,true,true,true,true,false,true,true,true,false];

      fnf_spectatorPrevVisibleCtrls = [];

      if ((_missionRuntimeSecs - (15 * 60)) <= CBA_missionTime) then {
      	call fnf_fnc_clientTime;
  		};
    };
  };
}] call CBA_fnc_addPerFrameHandler;

true
