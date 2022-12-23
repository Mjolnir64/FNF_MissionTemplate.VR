fnf_trianglesToDraw = [];

[{!isNull findDisplay 12},{
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",
{
  _map = _this select 0;
  {
    _pos1 = getMarkerPos ((_x select 0) select 0);
    _pos2 = getMarkerPos ((_x select 0) select 1);
    _pos3 = getMarkerPos ((_x select 0) select 2);
	  _map drawTriangle [[_pos1, _pos2, _pos3], _x select 1, _x select 2];
  } forEach fnf_trianglesToDraw;
}];
}] call CBA_fnc_waitUntilAndExecute;

[{!isNull findDisplay 52},{
findDisplay 52 displayCtrl 51 ctrlAddEventHandler ["Draw",
{
  _map = _this select 0;
  {
    _pos1 = getMarkerPos ((_x select 0) select 0);
    _pos2 = getMarkerPos ((_x select 0) select 1);
    _pos3 = getMarkerPos ((_x select 0) select 2);
	  _map drawTriangle [[_pos1, _pos2, _pos3], _x select 1, _x select 2];
  } forEach fnf_trianglesToDraw;
}];
}] call CBA_fnc_waitUntilAndExecute;

[{!isNull findDisplay 53},{
findDisplay 53 displayCtrl 51 ctrlAddEventHandler ["Draw",
{
  _map = _this select 0;
  {
    _pos1 = getMarkerPos ((_x select 0) select 0);
    _pos2 = getMarkerPos ((_x select 0) select 1);
    _pos3 = getMarkerPos ((_x select 0) select 2);
	  _map drawTriangle [[_pos1, _pos2, _pos3], _x select 1, _x select 2];
  } forEach fnf_trianglesToDraw;
}];
}] call CBA_fnc_waitUntilAndExecute;

[{
  _gps = controlNull;
  {
	if (['311',(str _x),FALSE] call BIS_fnc_inString) then {
		if (!isNull (_x displayCtrl 101)) then {
			_gps = (_x displayCtrl 101);
		  };
	  };
  } forEach (uiNamespace getVariable 'IGUI_displays');
  not (_gps isEqualTo controlNull);
},{
  {
	  if (['311',(str _x),FALSE] call BIS_fnc_inString) then {
		  if (!isNull (_x displayCtrl 101)) exitWith {
			  _gps = (_x displayCtrl 101);
			  _gps ctrlAddEventHandler ['Draw',{
          _map = _this select 0;
          {
            _pos1 = getMarkerPos ((_x select 0) select 0);
            _pos2 = getMarkerPos ((_x select 0) select 1);
            _pos3 = getMarkerPos ((_x select 0) select 2);
	          _map drawTriangle [[_pos1, _pos2, _pos3], _x select 1, _x select 2];
          } forEach fnf_trianglesToDraw;
        }];
		  };
	  };
  } forEach (uiNamespace getVariable 'IGUI_displays');
}] call CBA_fnc_waitUntilAndExecute;

[{!isNull findDisplay 60000},{
findDisplay 60000 displayCtrl 60014 ctrlAddEventHandler ["Draw",
{
  _map = _this select 0;
  {
    _pos1 = getMarkerPos ((_x select 0) select 0);
    _pos2 = getMarkerPos ((_x select 0) select 1);
    _pos3 = getMarkerPos ((_x select 0) select 2);
	  _map drawTriangle [[_pos1, _pos2, _pos3], _x select 1, _x select 2];
  } forEach fnf_trianglesToDraw;
}];
}] call CBA_fnc_waitUntilAndExecute;
