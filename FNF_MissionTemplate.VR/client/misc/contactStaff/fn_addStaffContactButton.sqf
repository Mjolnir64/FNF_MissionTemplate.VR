private _adminMsgButton = _display ctrlCreate ["PauseMenuSendAdminMsg", -1];
_adminMsgButton ctrlAddEventHandler ["ButtonClick", {
	[] spawn fnf_fnc_contactStaff;
}];
