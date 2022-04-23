local bit = require("bit")

local EntityList_GetLocalPlayer, EntityList_GetPlayers = EntityList.GetLocalPlayer, EntityList.GetPlayers
local Cheat_RegisterCallback, Cheat_FireBullet = Cheat.RegisterCallback, Cheat.FireBullet
local Exploits_GetCharge, Exploits_ForceTeleport = Exploits.GetCharge, Exploits.ForceTeleport
local Menu_FindVar = Menu.FindVar
local bit_band, bit_lshift, math_floor = bit.band, bit.lshift, math.floor

local function on_prediction()
    local local_player = EntityList_GetLocalPlayer()

    if not local_player then
        return
    end

    local all_players = EntityList_GetPlayers()

    if #all_players < 1 then
        return
    end

    local in_air = bit_band(local_player:GetProp("m_fFlags"), bit_lshift(1, 0)) == 0
    local dt_enabled = Menu_FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap"):Get()

    if not in_air or not dt_enabled or Exploits_GetCharge() ~= 1 then
        return
    end

    for k, v in pairs(all_players) do
        if v:IsDormant() or not v:IsAlive() or v:IsTeamMate() or v == local_player or not v then
            goto skip
        end

        local bullet_trace = Cheat_FireBullet(v, v:GetEyePosition(), local_player:GetRenderOrigin())
        local damage = math_floor(bullet_trace.damage)
        if damage > 0 then
        --    print("[auto_teleport_in_air] " .. v:GetName() .. " can shoot you with " .. damage .. " damage")
            Exploits_ForceTeleport()
        end
        ::skip::
    end
end

Cheat_RegisterCallback("prediction", on_prediction)
