-- TODO: add support for picking up weapons, maybe doors aswell. can plant, defuse, and pickup hostages.
local PitchReference = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Pitch")
local YawBaseReference = Menu.FindVar("Aimbot", "Anti Aim", "Main", "Yaw Base")

local Cached = {
	Pitch = PitchReference:Get(),
	Yaw = YawBaseReference:Get()
}

local function HostageAndDefuseCheck()
		if EntityList.GetEntitiesByName("CHostage") or EntityList.GetEntitiesByName("CPlantedC4") then
				local Ents = EntityList.GetEntitiesByName("CHostage") or EntityList.GetEntitiesByName("CPlantedC4")
				local LocalPlayer = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
				local LocalPlayerOrigin = LocalPlayer:GetRenderOrigin()
				for i = 1, #Ents do
						if Ents[i] then
								local Ent = Ents[i]
								local EntsOrigin = Ent:GetRenderOrigin()
								local Distance = LocalPlayerOrigin:DistTo(EntsOrigin)
								if Distance < 65 and LocalPlayer:GetProp("m_iTeamNum") == 3 then
										return true
								end
						end
				end
		end
end

local function IsPlanting()
		local LocalPlayer = EntityList.GetLocalPlayer()
		local Weapon = LocalPlayer:GetActiveWeapon()
		local HasBombInHand = Weapon ~= nil and Weapon:GetClassName() == "CC4"
		local InBombZone = LocalPlayer:GetProp("m_bInBombZone")
		local Planting = HasBombInHand and InBombZone
	
		if Planting then
				return true
		end
end

local function onPrediction(cmd)
		local LocalPlayer = EntityList.GetLocalPlayer()
		if not LocalPlayer then return end
		local HoldingUseKey = bit.band(cmd.buttons, 32) == 32
	
		if HoldingUseKey and not HostageAndDefuseCheck() and not IsPlanting() then
				cmd.buttons = bit.band(cmd.buttons, bit.bnot(32)) -- unbind use key
				PitchReference:Set(0)
				YawBaseReference:Set(0)
		else
				PitchReference:Set(Cached.Pitch)
				YawBaseReference:Set(Cached.Yaw)
		end
end

Cheat.RegisterCallback("prediction", onPrePrediction)
