/*
Prevents player from going into video settings to increase gamma beyond a certain threshold (1.3) during night missions.
Not a perfect solution, but best that can be done via scripting, afaik.
*/
if (sunOrMoon == 1) exitWith {};

phx_gammaWarn = false;
phx_gammaMax = 1.3;
[{
  if (isNull findDisplay 5) exitWith {};
  _gamma = parseNumber (ctrlText (findDisplay 5 displayCtrl 109));
  if (_gamma > phx_gammaMax && !phx_gammaWarn) then {
    _msg = format ["Gamma setting cannot exceed %1 for this mission, please go into settings and lower the value", phx_gammaMax];
    cutText [_msg, "BLACK"];
    phx_gammaWarn = true;
  } else {
    if (_gamma <= phx_gammaMax && phx_gammaWarn) then {
      cutText ["", "BLACK IN"];
      phx_gammaWarn = false;
    };
  };
} , 0.2] call CBA_fnc_addPerFrameHandler;