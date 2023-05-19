#include <sourcemod>
#include <sdktools>
#include <cstrike>

#pragma newdecls required
#pragma semicolon 1

public Plugin myinfo = 
{
	name = "",
	author = "",
	description = "",
	version = "",
	url = ""
};

public void OnPluginStart()
{
	AddCommandListener( Lstnr_Drop, "drop" );
}

public Action Lstnr_Drop( int client, const char[] command, int argc )
{
	if (!client && !IsPlayerAlive(client)) return Plugin_Handled;

	int wep = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");

	if (wep > 0)
	{
		CS_DropWeapon(client, wep, true, true);

		return Plugin_Handled;
	}

	return Plugin_Continue;
}