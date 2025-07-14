local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerState = require(game:GetService("ReplicatedStorage").Shared:WaitForChild("player-state"))

local pointEvent = ReplicatedStorage:WaitForChild("PointGiver")
local pointStore = DataStoreService:GetDataStore("PlayerPoints") -- Table name for storing points

Players.PlayerAdded:Connect(function(player)
	local success, data = pcall(function()
		return pointStore:GetAsync(player.UserId) -- Fetch points from the datastore
	end)

	local points = success and data or 0
	PlayerState.set(player, points)

	pointEvent:FireClient(player, 0, points)
end)

Players.PlayerRemoving:Connect(function(player)
	local points = PlayerState.get(player)

	pcall(function()
		pointStore:SetAsync(player.UserId, points) -- Save points to the datastore
	end)

	PlayerState.clear(player)
end)
