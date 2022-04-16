local function on_prediction(cmd)
	local local_player = EntityList.GetLocalPlayer()
	local in_air = bit.band(local_player:GetProp("m_fFlags"), bit.lshift(1, 0)) == 0
	
	if not local_player or not in_air then
        return
    end
	
	local wpn = local_player:GetActiveWeapon()
	
	if not wpn or wpn:GetWeaponID() ~= 40 then
        return
    end
	
	for i = 1, 64 do
		RageBot.OverrideHitchance(i, 60)
    end
end

Cheat.RegisterCallback("prediction", on_prediction)
