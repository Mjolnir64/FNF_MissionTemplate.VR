/*
	Author: Mallen

	Description:
		Respawns the player and puts them in limbo until admin TP's them

	Parameter(s):
		None

	Returns:
		None
*/

if (alive player) exitWith {};

setPlayerRespawnTime -1;

[false, false, false] call ace_spectator_fnc_setSpectator;
["<t align='center' size='1.4' color='#FFFF00'>ADMIN ACTION</t><t align='center'><br/><br/>You have been respawned, you are currently hidden and set to invincible until an admin teleports you to a safe location near to your death spot, please wait...</t>", "deep-purple", 10] call FNF_ClientSide_fnc_notificationSystem;

[{
	player setUnitLoadout [fnf_playerLoadout, false];
	[player, true] remoteExec ["hideObjectGlobal", 2];
	player allowDamage false;
	player enableSimulationGlobal false;
	setPlayerRespawnTime 9999;
	_playerPos = getPos player;
	[{
		params["_playerPos"];
		getPos player isNotEqualTo _playerPos;
	},{
		player allowDamage true;
		[player, false] remoteExec ["hideObjectGlobal", 2];
		player enableSimulationGlobal true;
		["<t align='center' size='1.4' color='#FFFF00'>ADMIN ACTION</t><t align='center'><br/><br/>You have been teleported to a reletivly safe space, take in your surroundings and play on!</t>", "deep-purple"] call FNF_ClientSide_fnc_notificationSystem;
		[{
			[true, true, true] call ace_spectator_fnc_setSpectator;
			[{
				[false, false, false] call ace_spectator_fnc_setSpectator;
			},[],1] call CBA_fnc_waitAndExecute;
		},[],1] call CBA_fnc_waitAndExecute;
	},[_playerPos], 30, {
		player allowDamage true;
		[player, false] remoteExec ["hideObjectGlobal", 2];
		player enableSimulationGlobal true;
		["<t align='center' size='1.4' color='#FFFF00'>ADMIN ACTION</t><t align='center'><br/><br/>No Admin has Teleported you in 30 seconds, take in your surroundings and play on!</t>", "deep-purple"] call FNF_ClientSide_fnc_notificationSystem;
		[{
			[true, true, true] call ace_spectator_fnc_setSpectator;
			[{
				[false, false, false] call ace_spectator_fnc_setSpectator;
			},[],1] call CBA_fnc_waitAndExecute;
		},[],1] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_waitUntilAndExecute
},[],0.1] call CBA_fnc_waitAndExecute;
