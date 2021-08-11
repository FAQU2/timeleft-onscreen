#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

Handle g_Sync;
Handle g_Timer;

public Plugin myinfo = 
{
	name = "Timeleft on screen",
	author = "FAQU"
};

public void OnMapStart()
{
	g_Sync = CreateHudSynchronizer();
	g_Timer = CreateTimer(1.00, Timer_Timeleft, _, TIMER_REPEAT);
}

public void OnMapEnd()
{
	delete g_Sync; 
	delete g_Timer;
}

public Action Timer_Timeleft(Handle timer)
{
	static int time;
	static char timeleft[32];
	
	GetMapTimeLeft(time);
	
	if (time > -1)
	{
		if (time > 3600)
		{
			FormatEx(timeleft, sizeof(timeleft), "Timeleft: %ih %02im", time / 3600, (time / 60) % 60);
		}
		else if (time < 60)
		{
			FormatEx(timeleft, sizeof(timeleft), "Timeleft: %02is", time);
		}
		else FormatEx(timeleft, sizeof(timeleft), "Timeleft: %im %02is", time / 60, time % 60);	
	}
			
	SetHudTextParams(-1.0, 0.06, 1.10, 255, 255, 255, 255, 0, 0.0, 0.0, 0.0);	
	
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientConnected(i) && IsClientInGame(i) && !IsFakeClient(i))
		{
			ShowSyncHudText(i, g_Sync, timeleft);
		}
	}
}