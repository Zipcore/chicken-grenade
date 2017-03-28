//include
#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <sdkhooks>

//chicken model
#define CHICKEN_MODEL "models/chicken/chicken.mdl"

public Plugin myinfo = 
{
	name = "Chicken Grenade",
	author = "Kento",
	description = "Replace thrown hegrenade to chicken.",
	version = "1.1",
	url = "https://github.com/rogeraabbccdd/chicken-grenade"
};

public void OnPluginStart()
{
}

public OnMapStart() 
{ 
	//precache
	PrecacheModel(CHICKEN_MODEL, true);
}

stock bool:IsValidClient(client, bool:nobots = true)
{ 
    if (client <= 0 || client > MaxClients || !IsClientConnected(client) || (nobots && IsFakeClient(client)))
    {
        return false; 
    }
    return IsClientInGame(client); 
}

public OnEntityCreated(entity, const String:classname[])
{
	if(IsValidEntity(entity)) SDKHook(entity, SDKHook_SpawnPost, OnEntitySpawned);
}

public OnEntitySpawned(entity)
{
	decl String:class_name[64];
	GetEntityClassname(entity, class_name, 64);
	
	new ownernade = GetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity");
	
	if(StrContains(class_name, "projectile") != -1 && IsValidEntity(entity) && IsClientInGame(ownernade))
	{
		if(StrContains(class_name, "hegrenade") != -1)
		{
			SetEntityModel(entity, CHICKEN_MODEL);
		}
	}
}