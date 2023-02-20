#include "..\undef.hpp" // Reset defines

#define UNIFORM "UK3CB_LNM_B_U_CombatUniform_02"

#define VEST "UK3CB_LDF_B_V_RIF_ALT_Vest_KKZ10_OLI"
#define VEST_LEADER "UK3CB_LDF_B_V_SL_Vest_KKZ10_OLI", "UK3CB_LDF_B_V_GREN_Vest_KKZ10_OLI"
#define VEST_AR "UK3CB_LDF_B_V_MG_Vest_KKZ10_OLI"
#define VEST_MEDIC "UK3CB_LDF_B_V_MD_Vest_KKZ10_OLI"
#define VEST_CREWMAN "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI"
#define VEST_PILOT "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI"

#define HELMET "rhsgref_helmet_pasgt_flecktarn"
#define HELMET_CMDR "UK3CB_NFA_B_H_M88_Field_Cap_FLK"
#define HELMET_RECON "UK3CB_NFA_B_H_BoonieHat_FLK"
#define HELMET_CREWMAN "H_HelmetCrew_I"
#define HELMET_PILOT "rhsusf_hgu56p_visor_mask"

#define BACKPACK "B_TacticalPack_blk"
#define BACKPACK_RADIO "TFAR_rt1523g_bwmod"
#define BACKPACK_AR "B_Carryall_oli"
#define BACKPACK_AT "B_Carryall_oli"
#define BACKPACK_MEDIC "B_Kitbag_rgr"
#define BACKPACK_CREWMAN BACKPACK_RADIO
#define BACKPACK_PILOT BACKPACK_RADIO


class RHS_UNI_NATO_GER_BUNDESWEHR_2010 {
  author = "Mazz38";
  description = "DE: Modern German BUNDESWEHR Flecktarn Camouflage";

  class BASE {
    uniform[] = {UNIFORM};
    vest[] = {VEST};
    headgear[] = {HELMET};
    backpack[] = {BACKPACK};
  };

  class RI : BASE {};

  class TL : BASE {
    vest[] = {VEST_LEADER};
    backpack[] = {BACKPACK_RADIO};
  };

  class SL : TL {};
  class SGT : SL {};
  class PL : SGT {};

  class ARA : BASE {
    backpack[] = {BACKPACK_AR};
  };
  class AR : ARA {
    vest[] = {VEST_AR};
  };

  class AB: BASE {};

  class GR : BASE {};

  class GRIR : BASE {};

  class MGA : BASE {
    backpack[] = {BACKPACK_AR};
  };

  class MG : MGA {
    backpack[] = {BACKPACK_AR};
  };

  class CE : BASE {};

  class LAT : BASE {};

  class MATA1 : BASE {
    backpack[] = {BACKPACK_AT};
  };
  class MAT1 : MATA1 {};
  class MATA2 : BASE {
    backpack[] = {BACKPACK_AT};
  };
  class MAT2 : MATA2 {};

  class RIS : BASE {
    headgear[] = {HELMET_RECON};
  };

  class DM : BASE {};

  class SNP : BASE {
    headgear[] = {HELMET_RECON};
    uniform[] = {UNIFORM};
  };

  class CR : BASE {
    uniform[] = {UNIFORM};
    vest[] = {VEST_CREWMAN};
    headgear[] = {HELMET_CREWMAN};
  };

  class CRL : CR {
    backpack[] = {BACKPACK_RADIO};
  };

  class PI : BASE {
    vest[] = {VEST_PILOT};
    headgear[] = {HELMET_PILOT};
    backpack[] = {BACKPACK_RADIO};
  };

  class MED : BASE {
    vest[] = {VEST_MEDIC};
    backpack[] = {BACKPACK_MEDIC};
  };
};
