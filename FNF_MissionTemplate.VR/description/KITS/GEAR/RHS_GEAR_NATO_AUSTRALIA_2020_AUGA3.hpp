#include "..\undef.hpp" // Reset defines

// put all rifle weapons
#define RIFLE "uk3cb_auga3_blu"
// put all mags for the weapons above -- only the compatible ones for the player's weapon will be given
#define RIFLE_MAG "rhs_mag_30Rnd_556x45_M855A1_PMAG:7","rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red:4"
// give Riflemen extra mags
#define RIFLE_MAG_RI "rhs_mag_30Rnd_556x45_M855A1_PMAG:12","rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red:6"

#define SIDEARM "rhsusf_weap_glock17g4"
#define SIDEARM_MAG "rhsusf_mag_17Rnd_9x19_JHP:2"

// put all GL weapons
#define RIFLE_GL "uk3cb_auga3_gl_blu"
#define RIFLE_GL_MAG RIFLE_MAG

// UGL types - these should be classnames of items compatible with RIFLE_GL
// note: "type" here, if using a definition, MUST not have quotes around it. only the classname.
#define UGL_MAGS(_type,_count) _type##:##_count
#define UGL_FRAG 1Rnd_HE_Grenade_shell
#define UGL_SMOKEWHITE 1Rnd_Smoke_Grenade_shell
#define UGL_FLAREWHITE UGL_FlareWhite_F

// put all Carbine-style (shorter) weapons
#define CARBINE "rhs_weap_hk416d10"
#define CARBINE_MAG "rhs_mag_30Rnd_556x45_M855A1_Stanag:7","rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red:4"
#define CARBINE_MAG_RI "rhs_mag_30Rnd_556x45_M855A1_Stanag:12","rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red:6"
#define CARBINE_MAG_CREW "rhs_mag_30Rnd_556x45_M855A1_Stanag:4","rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red:2"

#define SMG_RIFLE "SMG_03C_TR_khaki"
#define SMG_MAG "50Rnd_570x28_SMG_03:8"
#define SMG_MAG_CREW "50Rnd_570x28_SMG_03:4"

#define AR_RIFLE "rhs_weap_minimi_para_railed"
#define AR_MAG "rhsusf_200rnd_556x45_mixed_box:6"
#define AR_MAG_ASST "rhsusf_200rnd_556x45_mixed_box:5"

#define AT_LAUNCHER AT4(1)

#define MAT1_LAUNCHER CARLG(2,0)
#define MAT2_LAUNCHER CARLG(2,0)

#define DM_RIFLE "rhs_weap_sr25_ec"
#define DM_MAG "rhsusf_20Rnd_762x51_SR25_m118_special_Mag:8", "rhsusf_20Rnd_762x51_SR25_m62_Mag:4"

#define MMG_RIFLE "rhs_weap_fnmag"
#define MMG_MAG "rhsusf_100Rnd_762x51_m80a1epr:8"
#define MMG_MAG_ASST "rhsusf_100Rnd_762x51_m80a1epr:6"

#define SPOTTER_RIFLE "rhs_weap_m14ebrri", "SMG_03C_TR_khaki"
#define SPOTTER_MAG "ACE_20Rnd_762x51_Mag_SD:11", "50Rnd_570x28_SMG_03:8"

#define SNP_RIFLE "rhs_weap_m24sws_d"
#define SNP_MAG "rhsusf_5Rnd_762x51_m118_special_Mag:12"

// [player getVariable "phxLoadout", (configProperties [_cfgPath, "true", true]) apply {configName _x}]

class RHS_GEAR_NATO_AUSTRALIA_2020_AUGA3 {
  author = "Mazz38";
  description = "AUS: Australia ARMY AUGA3 Kits";

  class BASE {
    backpackItems[] = {};
    sidearms[] = {
      {{SIDEARM},{SIDEARM_MAG}}
    };
    weaponChoices[] = {
      {{RIFLE},{RIFLE_MAG}},
      {{CARBINE},{CARBINE_MAG}}
    };
    launchers[] = {};
    defaultMAT[] = {};
    magazines[] = {BASE_GRENADES};
    items[] = {TOOLS,GRUNT_MEDICAL};
    linkedItems[] = {LINKED};
    attachments[] = {};
    launcherAttachments[] = {};
    explosiveChoices[] = {};
    grenadeChoices[] = {};
    giveSideKey = 0; // 0 for no key, 1 for side key, 2 for GLOBAL key
    giveSilencer = 0; // 0 for no silencer, 1 to equip silencer on primary weapon
    giveSRRadio = 1;
    giveLRRadio = 0;
  };

  class RI : BASE {
    weaponChoices[] = {
      {{RIFLE},{RIFLE_MAG_RI}},
      {{CARBINE},{CARBINE_MAG_RI}}
    };
  };

  class TL : BASE {
    /*weaponChoices[] = {
      {
        {RIFLE_GL},
        {
          RIFLE_GL_MAG,
          MARKING_SMOKES,
          UGL_MAGS(UGL_FLAREWHITE,4)
        }
      }
    };*/
    magazines[] += {
      LEADER_SMOKES
    };
    items[] += {LEADER_TOOLS};
    linkedItems[] += {VECTOR};
    giveSideKey = 1;
    giveLRRadio = 1;
  };

  class SL : TL {};
  
  class PL : TL {};

  class ARA : BASE {
    magazines[] += {AR_MAG_ASST};
  };
  class AB: BASE {};
  class AR : BASE {
    weapons[] = {AR_RIFLE};
    weaponChoices[] = {
      {{AR_RIFLE},{AR_MAG}}
    };
    attachments[] = {};
  };

  class GR : BASE {
    weaponChoices[] = {
      {
        {RIFLE_GL},
        {
          RIFLE_GL_MAG,
          UGL_MAGS(UGL_FRAG,GR_GRENADECOUNT),
          UGL_MAGS(UGL_SMOKEWHITE,UGL_SMOKECOUNT),
          MARKING_SMOKES,
          UGL_MAGS(UGL_FLAREWHITE,UGL_FLARECOUNT)
        }
      }
    };
  };

  class SGT : TL {
    weaponChoices[] = {
      {
        {RIFLE_GL},
        {
          RIFLE_GL_MAG,
          UGL_MAGS(UGL_FRAG,GRIR_GRENADECOUNT),
          UGL_MAGS(UGL_SMOKEWHITE,UGL_SMOKECOUNT),
          MARKING_SMOKES,
          UGL_MAGS(UGL_FLAREWHITE,UGL_FLARECOUNT),
          UGL_MAGS(BASE_UGL_HUNTIR,3)
        }
      }
    };
    items[] += {HUNTIR_MONITOR};
  };

  class MGA : BASE {
    backpackItems[] += {MMG_MAG_ASST,TRIPOD,SHOVEL};
  };

  class MG : BASE {
    weaponChoices[] = {
      {{MMG_RIFLE},{MMG_MAG}}
    };
  };

  class CE : BASE {
    magazines[] = {SMOKE_GRENADES};
    items[] += {CE_TRIGGER,CE_DEFUSE};
    backpackItems[] += {CE_DETECTOR,CE_FORTIFYTOOL,SHOVEL};
    explosiveChoices[] = {{CE_SATCHEL},{CE_MINEAP},{CE_MINEAT},{CE_DEMOCHARGE}};
    grenadeChoices[] = {{CE_FRAG_GRENADES},{CE_INCEN_GRENADES}};
  };

  class LAT : BASE {
    launchers[] = {AT_LAUNCHER};
  };

  class MATA1 : BASE {
    defaultMAT[] = {MAT1_LAUNCHER};
  };
  class MAT1 : MATA1 {};
  class MATA2 : BASE {
    defaultMAT[] = {MAT2_LAUNCHER};
  };
  class MAT2 : MATA2 {};

  class RIS : BASE {
    weaponChoices[] = {
      {{SPOTTER_RIFLE},{SPOTTER_MAG}}
    };
    backpackItems[] += {SPOTTER_TOOLS};
    giveSilencer = 1;
  };

  class DM : BASE {
    weaponChoices[] = {
      {{DM_RIFLE},{DM_MAG}}
    };
  };

  class SNP : BASE {
    weaponChoices[] = {
      {{SNP_RIFLE},{SNP_MAG}}
    };
    backpackItems[] += {SNIPER_TOOLS};
  };

  class CR : BASE {
    weaponChoices[] = {
      {{SMG_RIFLE},{SMG_MAG_CREW}},
      {{CARBINE},{CARBINE_MAG_CREW}}
    };
    giveSideKey = 1;
  };
  class CRL : CR {
    giveLRRadio = 1;
  };
  class PI : CR {
    giveLRRadio = 1;
  };

  class MED : BASE {
    backpackItems[] += {MEDIC_MEDICAL};
    magazines[] += {
      MEDIC_SMOKES
    };
  };
};
