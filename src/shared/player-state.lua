local PlayerState = {}

local points = {}

function PlayerState.get(player)
	return points[player] or 0
end

function PlayerState.set(player, value)
	points[player] = value
end

function PlayerState.add(player, amount)
	points[player] = PlayerState.get(player) + amount
	return points[player]
end

function PlayerState.clear(player)
	points[player] = nil
end

return PlayerState
