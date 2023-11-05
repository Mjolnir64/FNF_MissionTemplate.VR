/*
	Author: Mallen

	Description:
		Shows a screen directly simulating the map screen icons to allow viewing of info

	Parameter(s):
	  None

	Returns:
		None
*/

disableSerialization;

_display = findDisplay 60000 createDisplay "RscDisplayEmpty";

_background = _display ctrlCreate ["RscBackgroundGUI", 4251];
_background ctrlSetPosition [0,0,1,1];
_background ctrlCommit 0;

_allSubjects = allDiarySubjects player;

_indexForTree = 1;
_recordDataStorage = ["NONE FOUND"];

_tree = _display ctrlCreate ["RscTree", 4252];
_tree ctrlSetPosition [0,0,0.3,1];
{
  _name = _x select 0;
  _displayName = _x select 1;
  _picture = _x select 2;
  if (_name != "Units" and _name != "Players" and _name != "Statistics" and _name != "radio" and _name != "cba_help_docs" and _name != "Tasks") then
  {
    _tree tvAdd [[], _displayName];

    _allRecords = player allDiaryRecords _name;

    _currentSubjectCount = _tree tvCount [];
    _correctTreePath = [0];
    for "_i" from 0 to _currentSubjectCount do
    {
      _text = _tree tvText [_i];
      if (_text == _displayName) then
      {
        _correctTreePath = [_i];
      };
    };

    _tree tvSetPicture [_correctTreePath, _picture];
    _tree tvSetPictureColorSelected [_correctTreePath, [1,1,1,0.9]];
    _tree tvSetValue [_correctTreePath, _indexForTree];
    _recordDataStorage pushBack "NONE FOUND";
    _indexForTree = _indexForTree + 1;

    {
      _recordName = (_x select 1);
      _tree tvAdd [_correctTreePath, _recordName];
      _currentSubjectCount = _tree tvCount _correctTreePath;
      _correctTreePathRecord = [(_correctTreePath select 0),0];

      for "_i" from 0 to _currentSubjectCount do
      {
        _text = _tree tvText [(_correctTreePath select 0),_i];
        if (_text == _recordName) then
        {
          _correctTreePathRecord = [(_correctTreePath select 0),_i];
        };
      };

      _tree tvSetValue [_correctTreePathRecord, _indexForTree];
      _recordDataStorage pushBack (_x select 2);
      _indexForTree = _indexForTree + 1;
    } forEach _allRecords;
  };

  if (_name == "Tasks") then
  {
    _tree tvAdd [[], _displayName];

    _currentSubjectCount = _tree tvCount [];
    _correctTreePath = [0];
    for "_i" from 0 to _currentSubjectCount do
    {
      _text = _tree tvText [_i];
      if (_text == _displayName) then
      {
        _correctTreePath = [_i];
      };
    };

  };
} forEach _allSubjects;
_tree ctrlCommit 0;
_controlGroup = _display ctrlCreate ["RscControlsGroup", 4253];
_controlGroup ctrlSetPosition [0.3,0,0.7,1];
_controlGroup ctrlCommit 0;

_structuredText = _display ctrlCreate ["RscStructuredText", 4254, _controlGroup];
_structuredText ctrlSetPosition [0,0,0.1,0.1];
_structuredText ctrlCommit 0;

_handle = [{
  (_this select 0) params ["_tree","_structuredText","_recordDataStorage"];

  _selection = tvSelection _tree;

  _value = _tree tvValue (_selection select 0);

  _currentText = _recordDataStorage select _value;
  if (_currentText != "NONE FOUND") then
  {
    _splitString = [_currentText, "font", true] call BIS_fnc_splitString;
    _editedStringFontChanged = _splitString select 0;
    _splitString deleteAt 0;
    {
      _editedStringFontChanged = _editedStringFontChanged + "t" + _x;
    } forEach _splitString;

    _splitString = [_editedStringFontChanged, "'"] call BIS_fnc_splitString;
    _editedStringSizeFixed = _splitString select 0;
    _prevText = _splitString select 0;
    _splitString deleteAt 0;
    {
      if (["size=", _prevText] call BIS_fnc_inString) then
      {
        _num = parseNumber _x;
        if (_num != 0) then
        {
          _num = _num * 0.1;
          _editedStringSizeFixed = _editedStringSizeFixed + "'" + str(_num);
          _prevText = _x;
          continue;
        };
      };
      if (["width=", _prevText] call BIS_fnc_inString) then
      {
        _num = parseNumber _x;
        if (_num != 0) then
        {
          _num = _num * 0.025;
          _editedStringSizeFixed = _editedStringSizeFixed + "'" + str(_num);
          _prevText = _x;
          continue;
        };
      };
      _editedStringSizeFixed = _editedStringSizeFixed + "'" + _x;
      _prevText = _x;
    } forEach _splitString;

    _splitString = [_editedStringSizeFixed, "width=", true] call BIS_fnc_splitString;
    _editedStringWidthChanged = _splitString select 0;
    _splitString deleteAt 0;
    {
      _editedStringWidthChanged = _editedStringWidthChanged + "size=" + _x;
    } forEach _splitString;

    _structuredText ctrlSetStructuredText (parseText _editedStringWidthChanged);
    _structuredText ctrlSetPosition [0,0,0.7,ctrlTextHeight _structuredText];
    _structuredText ctrlCommit 0;
  };
},0,[_tree, _structuredText, _recordDataStorage]] call CBA_fnc_addPerFrameHandler;

fnf_missionDetailsPFH = _handle;

_display displayAddEventHandler ["Unload", {
  [fnf_missionDetailsPFH] call CBA_fnc_removePerFrameHandler;
}];

//Take those and put them through some automation to directly simulate the map screen

//display to player