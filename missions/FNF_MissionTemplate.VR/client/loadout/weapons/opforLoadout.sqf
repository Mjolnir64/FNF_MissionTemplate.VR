giveOPFORLoadout = {
  phx_loadout_rifle_mag_tracer = "rhs_30Rnd_545x39_AK_plum_green:4";
  phx_loadout_rifle_mag = "rhs_30Rnd_545x39_7N10_AK:7";
  phx_loadout_sidearm_weapon = "rhs_weap_pya";
  phx_loadout_sidearm_mag = "rhs_mag_9x19_17:2";
  phx_allowedOptics = ["rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_ekp8_02", "rhs_acc_okp7_dovetail", "rhs_acc_pkas"];
  phx_allowedMagOptics = ["rhs_acc_1p29", "rhs_acc_1p78", "rhs_acc_nita", "rhs_acc_pso1m2_ak"];
  if (pRole == ROLE_PL || pRole == ROLE_SL || pRole == ROLE_TL || pRole == ROLE_MGTL) then {
    phx_loadout_rifle_weapon = "rhs_weap_ak74m_gp25";
    phx_loadout_rifle_gl_he = "rhs_VOG25:6";
    phx_loadout_rifle_gl_smoke = "rhs_GRD40_White:3";
    phx_loadout_rifle_gl_flare = "rhs_VG40OP_white:3";
    phx_loadout_rifle_mag_tracer = "rhs_30Rnd_545x39_AK_plum_green:7";
    phx_loadout_rifle_mag = "rhs_30Rnd_545x39_7N10_AK:4";
    _nightvision = "phx_loadout_nightvision" call BIS_fnc_getParamValue;
    if (_nightvision isEqualTo 1 || _nightvision isEqualTo 2) then {
      phx_loadout_rifle_weapon = "rhs_weap_ak74mr_gp25";
    };
  } else {
    phx_loadout_rifle_weapon = "rhs_weap_ak74m";
  };
  if (pRole == ROLE_AR) then {
    phx_loadout_automaticrifle_weapon = "rhs_weap_pkm";
    phx_loadout_automaticrifle_mag = "rhs_100Rnd_762x54mmR_green:5";
  };
  if (pRole == ROLE_AAR) then {
    phx_loadout_automaticrifle_mag = "rhs_100Rnd_762x54mmR_green:4";
  };
  if (pRole == ROLE_MG) then {
    phx_loadout_mmg_weapon = "rhs_weap_pkp";
    phx_loadout_mmg_mag = "rhs_100Rnd_762x54mmR_green:4";
  };
  if (pRole == ROLE_AM) then {
    phx_loadout_rifle_mag_tracer = "rhs_30Rnd_545x39_AK_plum_green:5";
    phx_loadout_rifle_mag = "rhs_30Rnd_545x39_7N10_AK:4";
    phx_loadout_mmg_mag = "rhs_100Rnd_762x54mmR_green:4";
  };
  if (pRole == ROLE_RAT) then {
    phx_loadout_antitank_weapon = "rhs_weap_rpg7";
    phx_loadout_antitank_mag = "rhs_rpg7_PG7VL_mag";
    phx_loadout_antitank_mag_1 = "rhs_rpg7_PG7VR_mag";
  };
  if (pRole == ROLE_AT) then {
    phx_loadout_mediumantitank_weapon = "rhs_weap_rpg7";
    phx_loadout_mediumantitank_mag = "rhs_rpg7_PG7VR_mag:2";
    phx_loadout_mediumantitank_mag_1 = "rhs_rpg7_PG7VL_mag:2";
    phx_loadout_mediumantitank_optic = "rhs_acc_pgo7v3";
  };
  if (pRole == ROLE_AAT) then {
    phx_loadout_mediumantitank_mag = "rhs_rpg7_PG7V_mag:2";
  };
  if (pRole == ROLE_MK) then {
    phx_loadout_rifle_weapon = "rhs_weap_svdp_npz";
    phx_loadout_rifle_mag = "ACE_10Rnd_762x54_Tracer_mag:9";
    phx_loadout_rifle_optic = "optic_SOS";
    phx_allowedWeapons = [];
    phx_allowedOptics = [];
    phx_allowedMagOptics = [];
  };
  if (pRole == ROLE_P) then {
    phx_loadout_rifle_weapon = "rhs_weap_aks74un";
    phx_loadout_rifle_mag = "rhs_30Rnd_545x39_7N10_AK:4";
    phx_allowedWeapons = [];
  };
  phx_loadout_flare = "rhs_weap_rsp30_white:3";
};
