#include "..\undef.hpp" // Reset defines

#define UNIFORM "rhs_uniform_m88_patchless"

#define VEST "rhs_6b5_rifleman_khaki", "rhs_chicom_khk"
#define VEST_LEADER "rhs_lifchik_vog"
#define VEST_AR VEST
#define VEST_MEDIC VEST
#define VEST_CREWMAN VEST
#define VEST_PILOT "rhsgref_6b23_khaki"

#define HELMET "rhs_ssh68_2"
#define HELMET_CMDR "UK3CB_CW_SOV_O_EARLY_H_FieldCap_KHK"
#define HELMET_RECON "rhs_pilotka"
#define HELMET_CREWMAN "rhs_tsh4"
#define HELMET_PILOT "rhs_zsh7a_mike"

#define BACKPACK "rhs_sidor"
#define BACKPACK_RADIO "UK3CB_B_O_Tactical_Backpack_Radio"
#define BACKPACK_AR "B_Carryall_khk"
#define BACKPACK_AT "rhs_rpg_empty"
#define BACKPACK_MEDIC "rhs_medic_bag"
#define BACKPACK_CREWMAN BACKPACK_RADIO
#define BACKPACK_PILOT BACKPACK_RADIO


class RHS_UNI_RU_ARMY_1980 {
  author = "Mazz38";
  description = "RU: 1980s Russian ARMY Khaki";

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
  class PL : SGT {
    headgear[] = {HELMET_CMDR};
    uniform[] = {"UK3CB_CW_SOV_O_Late_U_JNR_OFFICER_Uniform_01_KHK"};
  };

  class ARA : BASE {
    backpack[] = {BACKPACK_AR};
  };
  class AR : ARA {
    vest[] = {VEST_AR};
  };

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
  };

  class CR : BASE {
    uniform[] = {"UK3CB_CW_SOV_O_Early_U_Crew_Uniform_01_KHK"};
    vest[] = {VEST_CREWMAN};
    headgear[] = {HELMET_CREWMAN};
  };

  class CRL : CR {
    backpack[] = {BACKPACK_RADIO};
    uniform[] = {"UK3CB_CW_SOV_O_Early_U_Crew_Uniform_03_KHK"};
  };

  class PI : BASE {
    vest[] = {VEST_PILOT};
    headgear[] = {HELMET_PILOT};
    backpack[] = {BACKPACK_RADIO};
    uniform[] = {"UK3CB_CW_SOV_O_Early_U_H_Pilot_Uniform_01_KHK"};
  };

  class MED : BASE {
    vest[] = {VEST_MEDIC};
    backpack[] = {BACKPACK_MEDIC};
  };
};