// Lock unoccupied vehicles in safe start areas
#define MISSIONVICS (entities[["Air", "Truck", "Car", "Motorcycle", "Tank", "StaticWeapon", "Ship"], [], false, true] select {(_x call BIS_fnc_objectType select 0) == "Vehicle"})

private _vics = MISSIONVICS;

if (phx_gameMode != "sustainedAssault") then {
  (_vics select {[_x, west] call phx_fnc_inSafeZone})
    select { count crew _x == 0 }
    apply { _x setVehicleLock "LOCKED" };

  (_vics select {[_x, east] call phx_fnc_inSafeZone})
    select { count crew _x == 0 }
    apply { _x setVehicleLock "LOCKED" };

  (_vics select {[_x, independent] call phx_fnc_inSafeZone})
    select { count crew _x == 0 }
    apply { _x setVehicleLock "LOCKED" };
};
