#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

Handle Timers[MAXPLAYERS + 1];

public Plugin myinfo = 
{
	name = "Timeleft on screen",
	author = "FAQU"
};

public void OnClientPutInServer(int client)
{
	if (!IsFakeClient(client))
	{
		Timers[client] = CreateTimer(1.00, Timer_Timeleft, client, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	}
}

public void OnClientDisconnect(int client)
{
	if (!IsFakeClient(client))
	{
		delete Timers[client];
	}
}

public Action Timer_Timeleft(Handle timer, int client)
{
	int iTimeleft;
	GetMapTimeLeft(iTimeleft);
			
	char sTimeleft[32];
	FormatTime(sTimeleft, sizeof(sTimeleft), "%M:%S", iTimeleft);
			
	SetHudTextParams(-1.0, 0.06, 1.05, 255, 255, 255, 255, 0, 0.0, 0.0, 0.0);
	ShowHudText(client, -1, "Timeleft: %s", sTimeleft);
}