local EntityList_GetLocalPlayer, EngineClient_GetNetChannelInfo, EngineClient_ExecuteClientCmd, EngineClient_IsConnected, Cheat_RegisterCallback = EntityList.GetLocalPlayer, EngineClient.GetNetChannelInfo, EngineClient.ExecuteClientCmd, EngineClient.IsConnected, Cheat.RegisterCallback

local called_medic = false

local match_club_ips = {
    "51.79.163.118:27015", -- scout only
    "51.79.137.204:27066" -- mirage only
}

local function table_find(tbl, val)
    if type(tbl) ~= "table" then
        return
    end

    for i = 1, #tbl do
        local index = tbl[i]
        if index == val then
            return true
        end
    end

    return false
end

local function on_draw()
    if called_medic or not EngineClient_IsConnected() then
        return
    end

    local net_channel_info = EngineClient_GetNetChannelInfo()
    local server_ip = net_channel_info:GetAddress()
    
    if not table_find(match_club_ips, server_ip) then
        return
    end

    local local_player = EntityList_GetLocalPlayer()
    local health = local_player:GetProp("m_iHealth")

    if health > 40 or not local_player:IsAlive() then
        return
    end

    EngineClient_ExecuteClientCmd("say !medic")
    called_medic = true
end

local function on_round_start(event)
    if event ~= "round_start" then
        return
    end

    called_medic = false
end

Cheat_RegisterCallback("draw", on_draw)
Cheat_RegisterCallback("events", on_round_start)