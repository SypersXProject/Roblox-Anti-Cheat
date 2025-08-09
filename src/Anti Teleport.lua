--[[
Anti Teleport

  How To Use
local HttpService = game:GetService("HttpService")
local url = "https://raw.githubusercontent.com/SypersXProject/Roblox-Anti-Cheat/refs/heads/main/src/Anti%20Teleport.lua"
loadstring(url)

]]--

--[[
Made by Tweakified, Neonblox Games
YouTube Tutorial: https://youtu.be/dtl-pD3Ui6E
Discord Support: https://discord.com/invite/JdaFf7p
 
Script Type: Regular Script
Script Parent: ServerScriptService
--]]

local Players = game:GetService("Players")
local LastPosition = {}

local function NewPlayer(player)
	player.CharacterAdded:Connect(function()
		LastPosition[player.UserId] = nil
	end)
	spawn(function()
		while true do
			wait(1)
			local char = player.Character
			if char ~= nil then
				local humanoid = char:FindFirstChildOfClass("Humanoid")
				if humanoid ~= nil and char.PrimaryPart ~= nil then
					local CurrentPosition = char:GetPrimaryPartCFrame()
					local TempLastPosition = LastPosition[player.UserId]
					if TempLastPosition ~= nil then
						local BeforePosition = Vector3.new(TempLastPosition.X, 0, TempLastPosition.Z)
						local NewPosition = Vector3.new(CurrentPosition.X, 0, CurrentPosition.Z)

						local Distance = (BeforePosition - NewPosition).magnitude
						local MaxDistance = humanoid.WalkSpeed * 2
						if Distance > MaxDistance then
							char:SetPrimaryPartCFrame(TempLastPosition)
							continue
						end
					end
					LastPosition[player.UserId] = CurrentPosition
				end
			end
		end
	end)
end

Players.PlayerAdded:Connect(NewPlayer)
for _, player in pairs(Players:GetPlayers()) do
	NewPlayer(player)
end
