#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Timeleft on screen",
	author = "FAQU"
};

public void OnMapStart()
{
	CreateTimer(1.00, Timer_Timeleft, _, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_Timeleft(Handle timer)
{
	int iTimeleft;
	GetMapTimeLeft(iTimeleft);
			
	char sTimeleft[32];
	FormatTime(sTimeleft, sizeof(sTimeleft), "%M:%S", iTimeleft);
			
	SetHudTextParams(-1.0, 0.06, 1.05, 255, 255, 255, 255, 0, 0.0, 0.0, 0.0);
	
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientConnected(i) && IsClientInGame(i) && !IsFakeClient(i))
		{
			ShowHudText(i, -1, "Timeleft: %s", sTimeleft);
		}
	}
}