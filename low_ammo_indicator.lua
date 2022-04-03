-- @note: need this font: https://anonfiles.com/jff1w0Pax3/verdana-font-family_zip
-- imported straight from skeet/gamesense
local PositionX = Menu.SliderInt("Text Position", "X", 960, 0, 2000)
local PositionY = Menu.SliderInt("Text Position", "Y", 500, 0, 2000)

local alpha = 255

local FONT = Render.InitFont("Verdana", 20, {"b"})

Cheat.RegisterCallback("draw", function()
		if not EngineClient.IsConnected() then return end
		local LocalPlayer = EntityList.GetLocalPlayer()
		local ClientEntity = EntityList.GetClientEntity(EngineClient.GetLocalPlayer())
		local GetPlayer = ClientEntity:GetPlayer()
		local Timer = GlobalVars.curtime
	
		if GlobalVars.curtime >= Timer then
				alpha = alpha - 1
				if alpha <= 0 then
						alpha = 255
					end
		    end
	
		if LocalPlayer and GetPlayer:IsAlive() then
		    local Weapon =  LocalPlayer:GetActiveWeapon()
		    local Ammo = Weapon ~= nil and Weapon:GetProp("m_iClip1")
	
		        if Ammo < 3 and Ammo > 0 then
				    Render.Text("RELOAD", Vector2.new(PositionX:Get(), PositionY:Get()), Color.RGBA(255, 0, 0, alpha), 20, FONT)
				end
		end
end)
