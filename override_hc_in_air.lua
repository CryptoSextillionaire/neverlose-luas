local AimbotHitChance = Menu.FindVar("Aimbot", "Ragebot", "Accuracy", "Hit Chance", "SSG-08")
local OverrideValue = Menu.SliderInt("Jumpscout", "In Air Hitchance", 60, 0, 100, "Hitchance Override Value")
local CachedScoutHitChance = AimbotHitChance:Get()

Cheat.RegisterCallback("draw", function()
		if not EngineClient.IsConnected() then return end
		local LocalPlayer = EntityList.GetLocalPlayer()
		local ClientEntity = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
		local GetPlayer = ClientEntity:GetPlayer()
		local ActiveWeapon = LocalPlayer:GetActiveWeapon()

		if LocalPlayer and GetPlayer:IsAlive() then
				local InAir = bit.band(LocalPlayer:GetProp("m_fFlags"), bit.lshift(1, 0)) == 0
				if InAir and ActiveWeapon:GetWeaponID() == 40 then
						AimbotHitChance:Set(OverrideValue:Get())
				else
						AimbotHitChance:Set(CachedScoutHitChance)
				end
		end
end)
