phx_loadout_backpack = "rhs_assault_umbts";

if (pRole == ROLE_CLS) then {
  phx_loadout_backpack = "rhs_medic_bag";
};
if (pRole == ROLE_AAR || pRole == ROLE_AM || pRole == ROLE_AAT) then {
  phx_loadout_backpack = "B_Carryall_oli";
};
if (pRole == ROLE_CE) then {
  phx_loadout_backpack = "rhs_assault_umbts_engineer_empty";
};

if (pRole == ROLE_P) then {
  phx_loadout_headgear = "H_PilotHelmetHeli_O";
  phx_loadout_vest = "V_TacVest_oli";
};
