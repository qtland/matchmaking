#!!! This file is outdated but looks almost the exact way as today release. !!!

#pragma semicolon 1
#include <tf2>
#include <sdkhooks>
#include <sdktools>
#pragma newdecls required

enum
{
	MM_DISCONNECTED = 0,
	MM_CONNECTED,
	MM_CONNECTING,
	MM_LOADING,
	MM_WAITING_FOR_PLAYER
};

public Plugin myinfo =
{
	name = "Backend Coordinator (PlayerMan)",
	author = "qtland",
	description = "Coordinates players",
	version = "1.5",
}

public void OnPluginStart()
{
	LogMessage("[Backend Coordinator] Backend Coordinator 1.5 started.");
}

public void OnMapStart(int client)
{
    int playerManager = FindEntityByClassname(-1, "tf_player_manager");

    if (playerManager != -1) {
        SDKHook(playerManager, SDKHook_ThinkPost, Hook_OnPlayerManagerThinkPost);
    }
}

public void Hook_OnPlayerManagerThinkPost(int entity) {
    for (int i = 1; i <= MaxClients; i++) {
    SetEntProp(entity, Prop_Send, "m_iConnectionState", MM_WAITING_FOR_PLAYER, _, i); //i
    }
}
