#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

Handle hTimer;

public Plugin myinfo = 
{
	name = "Timeleft on screen",
	author = "FAQU"
};

public void OnMapStart()
{
	hTimer = CreateTimer(1.00, Timer_Timeleft, _, TIMER_REPEAT);
}

public void OnMapEnd()
{
	delete hTimer;
}

public Action Timer_Timeleft(Handle timer)
{
	int iTimeleft;
	GetMapTimeLeft(iTimeleft);
	
	if (iTimeleft < 0) // prevents FormatTime error at the end of the map
	{
		return;
	}
			
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