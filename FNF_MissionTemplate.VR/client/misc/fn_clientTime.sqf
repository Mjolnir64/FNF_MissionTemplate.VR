/*
Creates and update mission time remaining display
*/

if (!hasInterface || missionNamespace getVariable ["fnf_mapTimeShown",false] || isNil "fnf_safetyEndTime") exitWith {};

disableSerialization;
private _missionTime = (fnf_missionTimelimit * 60) + fnf_safetyEndTime;
//Create displays in bottom left
("timeRsc" call BIS_fnc_rscLayer) cutRsc ["timeleftStructText", "PLAIN"];
//If displays weren't created then exit the script
if (uiNameSpace getVariable "timeleftStructText" isEqualTo displayNull) exitWith {hint "TIMELEFT display not defined in description.ext"};

fnf_missionTimeUI_PFH = [{
  params ["_missionTime", "_handle"];

  //Update text in the displays to match the points markers
  _display = uiNameSpace getVariable "timeleftStructText";
  _setText = _display displayCtrl 1003;
  if !(missionNamespace getVariable ["fnf_overTime",false]) then {
    _setText ctrlSetStructuredText parseText (format ["Mission Time Remaining: %1", [_missionTime - CBA_missionTime, "MM:SS"] call BIS_fnc_secondsToString]);
  } else {
    _setText ctrlSetStructuredText parseText (format ["Mission Overtime: +%1", [CBA_missionTime - _missionTime, "MM:SS"] call BIS_fnc_secondsToString]);
  };
}, 1, _missionTime] call CBA_fnc_addPerFrameHandler;
