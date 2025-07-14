local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("PointGiver")

local player = Players.LocalPlayer
local points = 0

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PointsUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 200, 0, 50)
textLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
textLabel.TextSize = 24
textLabel.Text = "Points: 0"
textLabel.Parent = screenGui

-- Listen points from server
remote.OnClientEvent:Connect(function(added, total)
	points = total or (points + added)
	textLabel.Text = "Points: " .. points
	print("📲 Client received updated points:", points)
end)
