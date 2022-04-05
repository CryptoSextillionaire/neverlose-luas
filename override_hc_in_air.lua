local AimbotHitChance = Menu.FindVar("Aimbot", "Ragebot", "Accuracy", "Hit Chance", "SSG-08")
local OverrideValue = Menu.SliderInt("Jumpscout", "In Air Hitchance", 60, 0, 100, "Hitchance Override Value")
local CachedScoutHitChance = AimbotHitChance:Get()

Cheat.RegisterCallback("draw", function()
		local LocalPlayer = EntityList.GetLocalPlayer()
	
		if not LocalPlayer or not LocalPlayer:IsAlive() then
				if  AimbotHitChance:Get() ~= CachedHitChance then
						AimbotHitChance:Set(CachedScoutHitChance)
						return
				end
		end
	
		local ActiveWeapon = LocalPlayer:GetActiveWeapon()
	
		if not ActiveWeapon or ActiveWeapon:GetWeaponID() ~= 40 then
				return
		end

		local InAir = bit.band(LocalPlayer:GetProp("m_fFlags"), bit.lshift(1, 0)) == 0
		if InAir then
				AimbotHitChance:Set(OverrideValue:Get())
		elseif not InAir then
				AimbotHitChance:Set(CachedScoutHitChance)
		end
end)
