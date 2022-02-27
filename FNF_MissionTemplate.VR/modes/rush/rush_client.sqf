//Terminal 1 actions
if !(isNull term1) then {
  fnf_term1Hacking = false;

  //Start
  [
    term1,
    "Start Hack",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "(_this distance _target < 3) && (playerSide == fnf_attackingSide) && !fnf_term1Hacking",
    "_caller distance _target < 3",
    {["Terminal", "Configuring Hack"] call BIS_fnc_showSubtitle},
    {},
    {
      ["Terminal", "Hack Started"] call BIS_fnc_showSubtitle;
      [term1, true] remoteExec ["fnf_serverTerminalAction", 2, false];
    },
    {["Terminal", ""] call BIS_fnc_showSubtitle},
    [],
    0,
    0,
    false,
    false
  ] call BIS_fnc_holdActionAdd;

  //Stop
  [
    term1,
    "Stop Hack",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "(_this distance _target < 3) && (playerSide == fnf_defendingSide) && fnf_term1Hacking",
    "_caller distance _target < 3",
    {["Terminal", "Stopping Hack"] call BIS_fnc_showSubtitle},
    {},
    {
      ["Terminal", "Hack Paused"] call BIS_fnc_showSubtitle;
      [term1, false] remoteExec ["fnf_serverTerminalAction", 2, false];
    },
    {["Terminal", ""] call BIS_fnc_showSubtitle},
    [],
    0,
    0,
    false,
    false
  ] call BIS_fnc_holdActionAdd;
};

waitUntil {isNull term1};

//Terminal 2 actions
if !(isNull term2) then {
  fnf_term2Hacking = false;

  //Start
  [
    term2,
    "Start Hack",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "(_this distance _target < 3) && (playerSide == fnf_attackingSide) && !fnf_term2Hacking",
    "_caller distance _target < 3",
    {["Terminal", "Configuring Hack"] call BIS_fnc_showSubtitle},
    {},
    {
      ["Terminal", "Hack Started"] call BIS_fnc_showSubtitle;
      [term2, true] remoteExec ["fnf_serverTerminalAction", 2, false];
    },
    {["Terminal", ""] call BIS_fnc_showSubtitle},
    [],
    0,
    0,
    false,
    false
  ] call BIS_fnc_holdActionAdd;

  //Stop
  [
    term2,
    "Stop Hack",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "(_this distance _target < 3) && (playerSide == fnf_defendingSide) && fnf_term2Hacking",
    "_caller distance _target < 3",
    {["Terminal", "Stopping Hack"] call BIS_fnc_showSubtitle},
    {},
    {
      ["Terminal", "Hack Paused"] call BIS_fnc_showSubtitle;
      [term2, false] remoteExec ["fnf_serverTerminalAction", 2, false];
    },
    {["Terminal", ""] call BIS_fnc_showSubtitle},
    [],
    0,
    0,
    false,
    false
  ] call BIS_fnc_holdActionAdd;
};

waitUntil {isNull term2};

//Terminal 3 actions
if !(isNull term3) then {
  fnf_term3Hacking = false;

  //Start
  [
    term3,
    "Start Hack",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "(_this distance _target < 3) && (playerSide == fnf_attackingSide) && !fnf_term3Hacking",
    "_caller distance _target < 3",
    {["Terminal", "Configuring Hack"] call BIS_fnc_showSubtitle},
    {},
    {
      ["Terminal", "Hack Started"] call BIS_fnc_showSubtitle;
      [term3, true] remoteExec ["fnf_serverTerminalAction", 2, false];
    },
    {["Terminal", ""] call BIS_fnc_showSubtitle},
    [],
    0,
    0,
    false,
    false
  ] call BIS_fnc_holdActionAdd;

  //Stop
  [
    term3,
    "Stop Hack",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "(_this distance _target < 3) && (playerSide == fnf_defendingSide) && fnf_term3Hacking",
    "_caller distance _target < 3",
    {["Terminal", "Stopping Hack"] call BIS_fnc_showSubtitle},
    {},
    {
      ["Terminal", "Hack Paused"] call BIS_fnc_showSubtitle;
      [term3, false] remoteExec ["fnf_serverTerminalAction", 2, false];
    },
    {["Terminal", ""] call BIS_fnc_showSubtitle},
    [],
    0,
    0,
    false,
    false
  ] call BIS_fnc_holdActionAdd;
};
