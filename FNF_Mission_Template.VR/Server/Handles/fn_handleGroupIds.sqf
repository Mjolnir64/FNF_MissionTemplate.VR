/*
	Author: Mallen

	Description:
		starts waiting for players to enter groups, and sets group ID's based on this

	Parameter(s):
		None

	Returns:
		None
*/

//if (!isDedicated) exitWith {};

{
  _currentGroup = _x;
  [{
    params["_currentGroup"];
    not isNull (leader _currentGroup);
  },{
    params["_currentGroup"];
    _roleDescription = roleDescription (leader _currentGroup);
    _splitString = _roleDescription splitString "@";
    if (count _splitString isNotEqualTo 2) then
    {
      _groupName = "Unknown Group: " + str(_currentGroup);
      _currentGroup setGroupIdGlobal [_groupName];
    } else {
      _groupName = (_splitString select 1);
      _currentGroup setGroupIdGlobal [_groupName];
    };
  }, [_currentGroup]] call CBA_fnc_waitUntilAndExecute;
} forEach allGroups;
