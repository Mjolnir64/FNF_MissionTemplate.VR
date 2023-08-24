/*
	Author: Mallen

	Description:
		Updates the contents of the Orbat tab

	Parameter(s):
		0: DIARY RECORD -  the diary record to be updated

	Returns:
		None
*/
params["_orbatRecord"];

_orbatContent = "";

_validGroups = [];

//get all groups with players in them and on players side
{
  if (count (units _x) == 0) then
  {
    continue;
  };
  if (side _x != playerSide) then
  {
    continue;
  };
  _validGroups pushBack _x;
} forEach allGroups;

{
  _currentGroup = _x;
  _groupName = groupId _currentGroup;
  _leader = leader _currentGroup;
  _units = units _currentGroup;

  _playerFound = false;

  //check if group consists entirely of AI, if so dont include it in the ORBAT
  {
    if (isPlayer _x) then
    {
      _playerFound = true;
      break;
    };
  } forEach _units;

  if (not _playerFound) then
  {
    continue;
  };

  _units = _units - [_leader];

  //make sure Leader is always at the top of the ORBAT by doing them first
  _leaderRole = "AI";
  //used to handle issues where AI dont have role descriptions and can break string logic
  if (isPlayer _leader) then
  {
    _leaderRoleDescription = roleDescription _leader;
    _leaderRole = ((_leaderRoleDescription splitString "@") select 0);
  };
  _leaderName = name _leader;

  _stringToAdd = "<font size='20' face='RobotoCondensedBold'>" + _groupName + "<font face='RobotoCondensed'> (" + str((count _units) + 1) + ")</font></font><br/><font size='14' face='RobotoCondensed'>    " + _leaderRole + ": " + _leaderName + "</font><br/>";

  {
    _unitRole = "AI";

    if (isPlayer _x) then
    {
      _unitRoleDescription = roleDescription _x;
      _unitRole = ((_unitRoleDescription splitString "@") select 0);
    };

    _unitName = name _x;
    _stringToAdd = _stringToAdd + "<font size='14' face='RobotoCondensed'>    " + _unitRole + ": " + _unitName + "</font><br/>";
  } forEach _units;

  _stringToAdd = _stringToAdd + "<br/>";

  _orbatContent = _orbatContent + _stringToAdd;
} forEach _validGroups;

//trims the ending breaks to keep tab size to a minimum
_orbatContent = _orbatContent trim ["<br/>", 2];
_orbatContent = _orbatContent + ">";

player setDiaryRecordText [["orbat", _orbatRecord], ["My Orbat", _orbatContent]];