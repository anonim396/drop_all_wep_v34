#include <sourcemod>
#include <sdktools>
#include <cstrike>

#pragma newdecls required
#pragma semicolon 1

// Структура информации о плагине
public Plugin myinfo =
{
    name = "Drop Weapon Plugin",
    author = "Your Name",
    description = "Plugin to drop the active weapon",
    version = "1.0",
    url = "https://example.com"
};

// Функция, вызываемая при старте плагина
public void OnPluginStart()
{
    // Добавляем команду "drop" для вызова функции Lstnr_Drop
    if (!AddCommandListener(Lstnr_Drop, "drop"))
    {
        LogError("Failed to add command listener for 'drop'");
    }
}

// Функция для сброса активного оружия игрока
public Action Lstnr_Drop(int client, const char[] command, int argc)
{
    // Проверка наличия игрока в игре и его живучести
    if (!IsClientInGame(client) || !IsPlayerAlive(client))
    {
        return Plugin_Handled;
    }

    // Получение дескриптора активного оружия
    int weaponEntity = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");

    // Проверка дескриптора оружия на валидность
    if (weaponEntity != 0)
    {
        // Попытка сброса оружия
        if (!CS_DropWeapon(client, weaponEntity, true, true))
        {
            // Логирование ошибки при сбросе оружия
            LogError("Failed to drop weapon for client %d", client);
            return Plugin_Handled;
        }

        // Оружие успешно сброшено
        return Plugin_Handled;
    }

    // Если дескриптор оружия недействителен, продолжаем выполнение плагина
    return Plugin_Continue;
}
