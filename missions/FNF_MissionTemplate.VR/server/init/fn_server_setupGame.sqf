#include "..\..\shared\definitions.hpp"

missionNamespace setVariable ["phx_gameEnd", false, true];

switch (phx_gameMode) do {
  case destroy: {
    execVM "shared\modes\destroy.sqf";
  };
  case uplink: {
    execVM "shared\modes\uplink_server.sqf";
  };
};

if !(phx_gameMode isEqualTo destroy) then {
  {if (!isNull _x) then {deleteVehicle _x};} forEach [destroy_obj1,destroy_obj2];
  {if !(getMarkerColor _x isEqualTo "") then {_x remoteExec ["deleteMarkerLocal", 0, true]};} forEach ["destroy_obj1Mark","destroy_obj2Mark"];
};

if !(phx_gameMode isEqualTo uplink) then {
  {if (!isNull _x) then {deleteVehicle _x};} forEach [term1,term2,term3];
};
