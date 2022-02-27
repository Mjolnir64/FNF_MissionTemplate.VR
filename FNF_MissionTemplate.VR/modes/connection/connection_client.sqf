#include "..\..\mode_config\connection.sqf"

//Terminal 1 actions
if !(isNull term1) then {
  fnf_term1HackingSide = sideEmpty;

  [
    term1,
    "Connect",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "(_this distance _target < 3) && !(playerSide == fnf_term1HackingSide) && !(playerSide == civilian)",
    "_caller distance _target < 3",
    {},
    {},
    {
      [term1, playerSide] remoteExec ["fnf_serverTerminalAction", 2, false];
    },
    {},
    [],
    2,
    0,
    false,
    false
  ] call BIS_fnc_holdActionAdd;
};

//Terminal 2 actions
if !(isNull term2) then {
  fnf_term2HackingSide = sideEmpty;

  [
    term2,
    "Connect",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "(_this distance _target < 3) && !(playerSide == fnf_term2HackingSide) && !(playerSide == civilian)",
    "_caller distance _target < 3",
    {},
    {},
    {
      [term2, playerSide] remoteExec ["fnf_serverTerminalAction", 2, false];
    },
    {},
    [],
    2,
    0,
    false,
    false
  ] call BIS_fnc_holdActionAdd;
};

//Terminal 3 actions
if !(isNull term3) then {
  fnf_term3HackingSide = sideEmpty;

  [
    term3,
    "Connect",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "(_this distance _target < 3) && !(playerSide == fnf_term3HackingSide) && !(playerSide == civilian)",
    "_caller distance _target < 3",
    {},
    {},
    {
      [term3, playerSide] remoteExec ["fnf_serverTerminalAction", 2, false];
    },
    {},
    [],
    2,
    0,
    false,
    false
  ] call BIS_fnc_holdActionAdd;
};
