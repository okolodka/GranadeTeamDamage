#pragma semicolon 1
#pragma newdecls required

#include <sdkhooks>
#include <sdktools_gamerules>

public Plugin myinfo =
{
	name = "Granade Team Damage",
	author = "Nek.'a 2x2 (Fork by PSIH :{ )",
	description = "Includes teammate grenade damage.",
	version = "1.2.1",
	url = "https://github.com/0RaKlE19"
};

public void OnPluginStart()
{
	for(int i = 1; i <= MaxClients; i++)
    {
        if(IsClientInGame(i))
            OnClientPutInServer(i);
    }
}

public void OnClientPutInServer(int iClient)
{
	SDKHook(iClient, SDKHook_OnTakeDamage, OnTakeDamage);
}

public Action OnTakeDamage(int iVictim, int &iAttacker, int &iInflictor, float &fDamage, int &iDamageType, int &Weapon, float fDamageForce[3], float fDamagePosition[3], int iDamageCustom)
{
	if(0 < iAttacker < MaxClients && IsClientInGame(iAttacker) && GetClientTeam(iVictim) == GetClientTeam(iAttacker) && !(iDamageType & DMG_BURN || iDamageType == 64) && !GameRules_GetProp("m_bWarmupPeriod"))
		return Plugin_Stop;

	return Plugin_Continue;
}