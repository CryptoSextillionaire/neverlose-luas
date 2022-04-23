local EntityList_GetLocalPlayer, EngineClient_GetScreenSize, Cheat_RegisterCallback, EntityList_GetPlayerForUserID, EngineClient_IsConnected, Render_InitFont, table_insert, Render_Text, Vector2, tostring, table_remove = EntityList.GetLocalPlayer, EngineClient.GetScreenSize, Cheat.RegisterCallback, EntityList.GetPlayerForUserID, EngineClient.IsConnected, Render.InitFont, table.insert, Render.Text, Vector2.new, tostring, table.remove

local players_killed = {}

local FONT = Render_InitFont("Verdana", 20, {"b"})

local function on_player_hurt(event)
    if event:GetName() ~= "player_hurt" then
        return
    end

    local local_player = EntityList_GetLocalPlayer()
    local attacker = EntityList_GetPlayerForUserID(event:GetInt("attacker"))
    local victim = EntityList_GetPlayerForUserID(event:GetInt("userid"))
    local remaining_health = event:GetInt("health")
    local dmg_health = event:GetInt("dmg_health")

    if victim == attacker or attacker ~= local_player or remaining_health ~= 0 then
        return
    end

    local victim_name = victim:GetName()
    table_insert(players_killed, {victim = victim_name, damaged_value = dmg_health, time_killed = GlobalVars.realtime})
end

local function on_draw()
    if not EngineClient_IsConnected() then
        return
    end

    local local_player = EntityList_GetLocalPlayer()

    if not local_player then
        return
    end

    if #players_killed > 0 then
        for k, v in pairs(players_killed) do
            local screen_size = EngineClient_GetScreenSize()

            Render_Text("ELIMINATED", Vector2(screen_size.x / 2 + -160, screen_size.y / 2 + 15), Color.RGBA(255, 255, 255 ,255), 20, FONT)
            Render_Text(v.victim, Vector2(screen_size.x / 2 + 30, screen_size.y / 2 + 15), Color.RGBA(255, 0, 0, 255), 20, FONT)
            Render_Text(tostring(v.damaged_value), Vector2(screen_size.x / 2 + -15, screen_size.y / 2 + -35), Color.RGBA(255, 255, 255, 255), 20, FONT)

            local realtime = GlobalVars.realtime
            local time_killed = v.time_killed

            if realtime - 1 >= time_killed then
                table_remove(players_killed, k)
            end
        end
    end
end

Cheat_RegisterCallback("events", on_player_hurt)
Cheat_RegisterCallback("draw", on_draw)