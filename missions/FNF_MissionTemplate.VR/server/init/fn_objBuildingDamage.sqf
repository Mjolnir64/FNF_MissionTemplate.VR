//disallow damage for whatever building objects the objective is under or over
_obj = _this select 0;
_pos = getPosASL _obj;

_buildings = lineIntersectsObjs [_pos, [_pos select 0, _pos select 1, (_pos select 2) + 20]];
_buildings = _buildings + (lineIntersectsObjs [_pos, [_pos select 0, _pos select 1, (_pos select 2) - 20]]);

if !(count _buildings == 0) then {
  {
    if !(_x == _obj) then {_x allowDamage false;};
  } forEach _buildings;
};
