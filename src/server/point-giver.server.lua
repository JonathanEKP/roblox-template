local part = workspace:WaitForChild("TouchPart")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerState = require(game:GetService("ReplicatedStorage").Shared:WaitForChild("player-state"))

local pointEvent = ReplicatedStorage:WaitForChild("PointGiver")

local tocuhedPlayers = {}

part.Touched:Connect(function(hit)
	local character = hit.Parent
	local player = Players:GetPlayerFromCharacter(character)

	if player and not tocuhedPlayers[player] then
		tocuhedPlayers[player] = true

		local total = PlayerState.add(player, 10)

		print("➕", player.Name, "Earned 10 points. Total:", total)
		pointEvent:FireClient(player, 10, total)

		-- Reset afeter 3 seconds to allow re-touching
		task.delay(3, function()
			tocuhedPlayers[player] = nil
		end)
	end
end)
