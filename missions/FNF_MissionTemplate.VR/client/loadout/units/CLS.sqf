// Add clothing
call phx_fnc_handleClothing; // Add clothing variables above this line!

// Add gear
[phx_loadout_aid, "uniform"] call phx_fnc_handleGear;
[phx_loadout_smoke, "uniform"] call phx_fnc_handleGear;
[phx_loadout_grenade, "uniform"] call phx_fnc_handleGear;
[phx_loadout_cuffs, "item"] call phx_fnc_handleGear;
[phx_loadout_maptools, "item"] call phx_fnc_handleGear;
[phx_loadout_rifle_mag_tracer, "vest"] call phx_fnc_handleGear;
[phx_loadout_rifle_mag, "vest"] call phx_fnc_handleGear;
[phx_loadout_PAK, "backpack"] call phx_fnc_handleGear;
[phx_loadout_bandage, "backpack"] call phx_fnc_handleGear;
[phx_loadout_morphine, "backpack"] call phx_fnc_handleGear;
[phx_loadout_epinephrine, "backpack"] call phx_fnc_handleGear;
[phx_loadout_blood, "backpack"] call phx_fnc_handleGear;
player addWeapon phx_loadout_rifle_weapon;
[phx_loadout_sidearm_mag, "vest"] call phx_fnc_handleGear;
player addWeapon phx_loadout_sidearm_weapon;
// Add items
call phx_fnc_handleItems; // Add binocular/nvg variables above this line!

missionNamespace setVariable ["phx_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.
