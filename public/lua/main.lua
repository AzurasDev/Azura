local plr = game.Players.LocalPlayer

if syn and syn.cache_replace and syn.cache_invalidate and syn.is_cached and syn.write_clipboard and syn.set_thread_identity then
	
	local dwids = {4111023553,5735553160,6032399813,6473861193,6832934465,6832944305,8668476218,8712356310,9528956055,9598091549,9854906953}
	if table.find(dwids,game.PlaceId) then
		--Load
		local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
		
		--Main
		local Window = OrionLib:MakeWindow({Name = "InnerConnect - DeepWoken", HidePremium = false, SaveConfig = true, ConfigFolder = "InnerConnectconfig", IntroText = "InnerConnect"})
		

		--flyfunction
		function flyfunction()
		end

		--Jogador
		local JogadorTab = Window:MakeTab({
			Name = "Jogador",
			Icon = "rbxassetid://4483345998",
			PremiumOnly = false
		})
		local Section = JogadorTab:AddSection({
			Name = "Movement"
		})

		JogadorTab:AddBind({
			Name = "FlyBind",
			Default = Enum.KeyCode.G,
			Hold = false,
			Flag = "flybind",
			Save = true,
			Callback = function()
					print("leap")
					local InputClient = plr.Character.CharacterHandler.InputClient
					syn.secure_call(getsenv(InputClient).GaleLeap, InputClient)
					wait(0.9)
			end    
		})
		
		--[[
		Name = <string> - The name of the toggle.
		Default = <bool> - The default value of the toggle.
		Callback = <function> - The function of the toggle.
		]]
		end
else
plr:Kick("Only SynaspeX!");
while true do end;
end