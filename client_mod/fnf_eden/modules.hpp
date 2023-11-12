class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;
			class Combo;
			class Checkbox;
			class CheckboxNumber;
			class ModuleDescription;
			class Units;
		};

		class ModuleDescription
		{
			class AnyBrain;
		};
	};

  class fnf_module_init: Module_F
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Init";
    scope = 2;

    class Attributes: AttributesBase
    {
      class GameTime: Edit
      {
        property = "fnf_gameTime";
        expression = "_this setVariable ['fnf_gameTime',_value, true];";
        displayName = "Time Limit";
        typeName = "NUMBER";
				defaultValue = "65";
      };
      class ViewDistance: Edit
      {
        property = "fnf_viewDistance";
        expression = "_this setVariable ['fnf_viewDistance',_value, true];";
        displayName = "View Distance";
        typeName = "NUMBER";
				defaultValue = "1000";
      };
      class FortifyPoints: Edit
      {
        property = "fnf_fortifyPoints";
        expression = "_this setVariable ['fnf_fortifyPoints',_value, true];";
        displayName = "Fortify Points";
        typeName = "NUMBER";
				defaultValue = "100";
      };
      class FortifyColour: Combo
      {
        property = "fnf_fortifyColour";
        expression = "_this setVariable ['fnf_fortifyColour',_value, true];";
        displayName = "Fortify Colour";
        typeName = "STRING";
				defaultValue = Green;
        class Values
        {
          class Green { name = "Green"; value = "Green";};
          class Tan { name = "Tan"; value = "Tan";};
        };
      };
      class DisableFortifyBlufor: Checkbox
      {
        property = "fnf_disableFortifyBlufor";
        expression = "_this setVariable ['fnf_disableFortifyBlufor',_value, true];";
        displayName = "Disable Fortify Blufor";
        tooltip = "If checked, fortify will be disabled for Blufor";
        typeName = "BOOL";
        defaultValue = "false";
      };
      class DisableFortifyOpfor: Checkbox
      {
        property = "fnf_disableFortifyOpfor";
        expression = "_this setVariable ['fnf_disableFortifyOpfor',_value, true];";
        displayName = "Disable Fortify Opfor";
        tooltip = "If checked, fortify will be disabled for Opfor";
        typeName = "BOOL";
        defaultValue = "false";
      };
      class DisableFortifyIndfor: Checkbox
      {
        property = "fnf_disableFortifyIndfor";
        expression = "_this setVariable ['fnf_disableFortifyIndfor',_value, true];";
        displayName = "Disable Fortify Independent";
        tooltip = "If checked, fortify will be disabled for Independent";
        typeName = "BOOL";
        defaultValue = "false";
      };
      class BreifingNotes
      {
        control = "EditMulti5";
				property = "fnf_breifingNotes";
        expression = "_this setVariable ['fnf_breifingNotes',_value, true];";
				displayName = "Notes";
				typeName = "STRING";
				defaultValue = "";
      };
      class BreifingAO
      {
        control = "EditMulti5";
				property = "fnf_breifingAO";
        expression = "_this setVariable ['fnf_breifingAO',_value, true];";
				displayName = "Area of Operations";
				typeName = "STRING";
				defaultValue = "";
      };
      class BreifingBackground
      {
        control = "EditMulti5";
				property = "fnf_breifingBackground";
        expression = "_this setVariable ['fnf_breifingBackground',_value, true];";
				displayName = "Background";
				typeName = "STRING";
				defaultValue = "";
      };
      class BreifingRules
      {
        control = "EditMulti5";
				property = "fnf_breifingRules";
        expression = "_this setVariable ['fnf_breifingRules',_value, true];";
				displayName = "Mission Rules";
				typeName = "STRING";
				defaultValue = "";
      };
      class Debug: Checkbox
      {
        property = "fnf_debug";
        expression = "_this setVariable ['fnf_debug',_value, true];";
        displayName = "Debug";
        tooltip = "If checked, debug data will be shown";
        typeName = "BOOL";
        defaultValue = "false";
      };
    };
	};
	class fnf_module_playZone: Module_F
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Play Zone";
    scope = 2;
    class Attributes: AttributesBase
    {
      class Prefix: Edit
      {
        property = "fnf_prefix";
        expression = "_this setVariable ['fnf_prefix',_value, true];";
        displayName = "Marker Prefix";
        typeName = "STRING";
				defaultValue = "fnf_marker_playzone_";
      };
    };
	};
  class fnf_module_safeZone: Module_F
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Safe Zone";
    scope = 2;
    class Attributes: AttributesBase
    {
      class Prefix: Edit
      {
        property = "fnf_prefix";
        expression = "_this setVariable ['fnf_prefix',_value, true];";
        displayName = "Marker Prefix";
        typeName = "STRING";
				defaultValue = "fnf_marker_safezone_";
      };
      class TimeToBeDeleted: Edit
      {
        property = "fnf_timeZoneIsDeleted";
        expression = "_this setVariable ['fnf_timeZoneIsDeleted',_value, true];";
        displayName = "Time until Zone is Deleted";
        typeName = "NUMBER";
				defaultValue = "15";
      };
      class VisibleToAllies: Checkbox
      {
        property = "fnf_visibleToAllies";
        expression = "_this setVariable ['fnf_visibleToAllies',_value, true];";
        displayName = "Visible to Allies";
        typeName = "BOOL";
        defaultValue = "true";
      };
      class VisibleToEnemies: Checkbox
      {
        property = "fnf_visibleToEnemies";
        expression = "_this setVariable ['fnf_visibleToEnemies',_value, true];";
        displayName = "Visible to Enemies";
        typeName = "BOOL";
        defaultValue = "true";
      };
    };
	};
  class fnf_module_teleportPoles: Module_F
  {
    author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Teleport Poles";
    scope = 2;
    class Attributes: AttributesBase
    {
      class TimeToBeDeleted: Edit
      {
        property = "fnf_timePolesAreDeleted";
        expression = "_this setVariable ['fnf_timePolesAreDeleted',_value, true];";
        displayName = "Time until Poles is Deleted";
        typeName = "NUMBER";
				defaultValue = "15";
      };
    };
  };
  class fnf_module_hidingZone: Module_F
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Hiding Zone";
    scope = 2;
    class Attributes: AttributesBase
    {
      class Prefix: Edit
      {
        property = "fnf_prefix";
        expression = "_this setVariable ['fnf_prefix',_value, true];";
        displayName = "Marker Prefix";
        typeName = "STRING";
				defaultValue = "fnf_marker_hidingzone_";
      };
    };
	};
  class fnf_module_selectorHost: Module_F
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Selector";
    scope = 2;
    class Attributes: AttributesBase
    {
      class SelectorName: Edit
      {
        property = "fnf_selectorName";
        expression = "_this setVariable ['fnf_selectorName',_value, true];";
        displayName = "Selector Name";
        typeName = "STRING";
				defaultValue = "";
      };
      class ObjectiveType: Combo
      {
        property = "fnf_selectorType";
        expression = "_this setVariable ['fnf_selectorType',_value, true];";
        displayName = "Selector Type";
        typeName = "STRING";
				defaultValue = Item;
        class Values
        {
          class Item { name = "Item"; value = "itm";};
          class Optic { name = "Optic"; value = "opt";};
          class PrimaryWeapon { name = "Primary Weapon"; value = "pri";};
          class SecondaryWeapon { name = "Launcher"; value = "sec";};
          class Handgun { name = "Handgun"; value = "hnd";};
        };
      };
    };
	};
  class fnf_module_selectorOption: Module_F
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Selector Option";
    scope = 2;
    class Attributes: AttributesBase
    {
      class OptionName: Edit
      {
        property = "fnf_optionName";
        expression = "_this setVariable ['fnf_optionName',_value, true];";
        displayName = "Option Name";
        typeName = "STRING";
				defaultValue = "";
      };
      class DefaultSelection: Checkbox
      {
        property = "fnf_defaultSelection";
        expression = "_this setVariable ['fnf_defaultSelection',_value, true];";
        displayName = "Default?";
        tooltip = "If checked, this option will be treated as already selected";
        typeName = "BOOL";
        defaultValue = "false";
      };
    };
  };
  class fnf_module_breifingAssets: Module_F
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Breifing Assets";
    scope = 2;
	};
  class fnf_module_kitInformation: Module_F
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Kit Information";
    scope = 2;
    class Attributes: AttributesBase
    {
      class KitName: Edit
      {
        property = "fnf_kitName";
        expression = "_this setVariable ['fnf_kitName',_value, true];";
        displayName = "Name";
        typeName = "STRING";
				defaultValue = "Unknown Kit";
      };
      class KitAuthor: Edit
      {
        property = "fnf_kitAuthor";
        expression = "_this setVariable ['fnf_kitAuthor',_value, true];";
        displayName = "Author";
        typeName = "STRING";
				defaultValue = "Unknown Author";
      };
    };
	};
  class fnf_module_objective: Module_F {};
  class fnf_module_destroyObj: fnf_module_objective
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Destroy Objective";
    scope = 2;
    class Attributes: AttributesBase
    {
      class ObjectiveType: Combo
      {
        property = "fnf_objectiveType";
        expression = "_this setVariable ['fnf_objectiveType',_value, true];";
        displayName = "Objective Type";
        typeName = "STRING";
				defaultValue = Destroy;
        class Values
        {
          class Destroy { name = "Destroy Object"; value = "des";};
          class Protect { name = "Protect Object"; value = "pro";};
        };
      };
      class ZoneKnown: Checkbox
      {
        property = "fnf_zoneKnown";
        expression = "_this setVariable ['fnf_zoneKnown',_value, true];";
        displayName = "Is hiding zone known";
        tooltip = "If checked, when object is in a linked hiding zone the zone it is in will have the task attached to it";
        typeName = "BOOL";
        defaultValue = "true";
      };
    };
	};
  class fnf_module_sectorCaptureObj: fnf_module_objective
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Capture Sector Objective";
    scope = 2;
    class Attributes: AttributesBase
    {
      class ObjectiveType: Combo
      {
        property = "fnf_objectiveType";
        expression = "_this setVariable ['fnf_objectiveType',_value, true];";
        displayName = "Objective Type";
        typeName = "STRING";
				defaultValue = "cap";
        class Values
        {
          class Capture { name = "Capture Sector"; value = "cap";};
          class Defend { name = "Defend Sector"; value = "def";};
        };
      };
      class Prefix: Edit
      {
        property = "fnf_prefix";
        expression = "_this setVariable ['fnf_prefix',_value, true];";
        displayName = "Marker Prefix";
        typeName = "STRING";
				defaultValue = "fnf_marker_sector_";
      };
      class TimeToCapture: Edit
      {
        property = "fnf_TimeToCapture";
        expression = "_this setVariable ['fnf_TimeToCapture',_value, true];";
        displayName = "Time to Capture";
        typeName = "NUMBER";
				defaultValue = "60";
      };
    };
	};
  class fnf_module_terminalObj: fnf_module_objective
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Terminal Objective";
    scope = 2;
    class Attributes: AttributesBase
    {
      class ObjectiveType: Combo
      {
        property = "fnf_objectiveType";
        expression = "_this setVariable ['fnf_objectiveType',_value, true];";
        displayName = "Objective Type";
        typeName = "STRING";
				defaultValue = Capture;
        class Values
        {
          class Capture { name = "Hack Terminal"; value = "hck";};
          class Defend { name = "Defend Terminal"; value = "def";};
        };
      };
      class HackingTime: Edit
      {
        property = "fnf_hackingTime";
        expression = "_this setVariable ['fnf_hackingTime',_value, true];";
        displayName = "Time to Hack";
        typeName = "NUMBER";
				defaultValue = "90";
      };
      class ZoneKnown: Checkbox
      {
        property = "fnf_zoneKnown";
        expression = "_this setVariable ['fnf_zoneKnown',_value, true];";
        displayName = "Is hiding zone known";
        tooltip = "If checked, when object is in a linked hiding zone the zone it is in will have the task attached to it";
        typeName = "BOOL";
        defaultValue = "true";
      };
    };
	};
  class fnf_module_sectorHoldObj: fnf_module_objective
	{
		author = "Mallen";
    category = "fnf_standardCategory";
    displayName = "FNF Hold Sector Objective";
    scope = 2;
    class Attributes: AttributesBase
    {
      class ObjectiveType: Combo
      {
        property = "fnf_objectiveType";
        expression = "_this setVariable ['fnf_objectiveType',_value, true];";
        displayName = "Objective Type";
        typeName = "STRING";
				defaultValue = "cap";
        class Values
        {
          class Capture { name = "Capture Sector"; value = "cap";};
          class Defend { name = "Defend Sector"; value = "def";};
        };
      };
    };
	};
};
