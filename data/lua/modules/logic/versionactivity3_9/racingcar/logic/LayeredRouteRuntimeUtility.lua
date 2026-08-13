-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/LayeredRouteRuntimeUtility.lua

module("modules.logic.versionactivity3_9.racingcar.logic.LayeredRouteRuntimeUtility", package.seeall)

local LayeredRouteRuntimeUtility = {}
local WaterfallClimb = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.WaterfallClimb")

LayeredRouteRuntimeUtility.DolphinRouteIds = {
	Main = "Main"
}
LayeredRouteRuntimeUtility.DolphinShortcutSides = {
	Left = "Left",
	Right = "Right"
}
LayeredRouteRuntimeUtility.DolphinGlideEntryModes = {
	ElementTrigger = "ElementTrigger",
	ShortcutExit = "ShortcutExit"
}
LayeredRouteRuntimeUtility.DolphinCurveModes = {
	Smooth = "Smooth",
	Linear = "Linear"
}
LayeredRouteRuntimeUtility.DolphinGlideDescentEases = {
	EaseOut = "EaseOut",
	EaseIn = "EaseIn",
	Linear = "Linear"
}

local function EqualsIgnoreCase(a, b)
	return a == b
end

function LayeredRouteRuntimeUtility.CsLaneIdToLuaIndex(laneId, laneCount)
	laneCount = math.max(1, laneCount or 1)

	return math.max(0, math.min(laneCount - 1, (laneId or 1) - 1))
end

function LayeredRouteRuntimeUtility.LuaIndexToCsLaneId(laneIndex, laneCount)
	laneCount = math.max(1, laneCount or 1)

	return math.max(1, math.min(laneCount, (laneIndex or 0) + 1))
end

local function MatchesLane(laneIds, fallbackLaneId, currentLaneId)
	local laneId = math.max(1, currentLaneId or 1)

	if laneIds and #laneIds > 0 then
		for _, id in ipairs(laneIds) do
			if math.max(1, id or 1) == laneId then
				return true
			end
		end

		return false
	end

	return laneId == math.max(1, fallbackLaneId or 1)
end

function LayeredRouteRuntimeUtility.FindRoute(config, routeId)
	if not routeId or routeId == "" then
		return nil
	end

	local routes = config and config.routeNetwork and config.routeNetwork.routes

	if not routes then
		return nil
	end

	for _, route in ipairs(routes) do
		if route and EqualsIgnoreCase(route.routeId, routeId) then
			return route
		end
	end

	return nil
end

function LayeredRouteRuntimeUtility.FindTransfer(config, fromRouteId, triggerElementId, currentDistance, currentLaneId, tolerance)
	local transfers = config and config.routeNetwork and config.routeNetwork.transfers

	if not transfers then
		return nil
	end

	for _, transfer in ipairs(transfers) do
		if transfer and transfer.enabled ~= false and EqualsIgnoreCase(transfer.fromRouteId, fromRouteId) and EqualsIgnoreCase(transfer.triggerElementId, triggerElementId) and MatchesLane(transfer.fromLaneIds, transfer.fromLaneId, currentLaneId) then
			local effectiveTolerance = transfer.triggerDistanceTolerance and transfer.triggerDistanceTolerance > 0 and transfer.triggerDistanceTolerance or tolerance

			if math.abs(transfer.fromDistance - currentDistance) <= math.max(0.01, effectiveTolerance or 0) then
				return transfer
			end
		end
	end

	return nil
end

function LayeredRouteRuntimeUtility.FindWaterDrop(config, fromRouteId, triggerElementId, currentDistance, currentLaneId, tolerance)
	local drops = config and config.routeNetwork and config.routeNetwork.waterDrops

	if not drops then
		return nil
	end

	for _, drop in ipairs(drops) do
		if drop and drop.enabled ~= false and EqualsIgnoreCase(drop.fromRouteId, fromRouteId) and EqualsIgnoreCase(drop.triggerElementId, triggerElementId) and MatchesLane(drop.fromLaneIds, drop.fromLaneId, currentLaneId) then
			local effectiveTolerance = drop.triggerDistanceTolerance and drop.triggerDistanceTolerance > 0 and drop.triggerDistanceTolerance or tolerance

			if math.abs(drop.fromDistance - currentDistance) <= math.max(0.01, effectiveTolerance or 0) then
				return drop
			end
		end
	end

	return nil
end

function LayeredRouteRuntimeUtility.FindGlide(config, fromRouteId, triggerElementId, currentDistance, currentLaneId, tolerance)
	local glides = config and config.routeNetwork and config.routeNetwork.glides

	if not glides then
		return nil
	end

	for _, glide in ipairs(glides) do
		if glide and glide.enabled ~= false and EqualsIgnoreCase(glide.entryMode, LayeredRouteRuntimeUtility.DolphinGlideEntryModes.ElementTrigger) and EqualsIgnoreCase(glide.fromRouteId, fromRouteId) and EqualsIgnoreCase(glide.triggerElementId, triggerElementId) and MatchesLane(glide.fromLaneIds, glide.fromLaneId, currentLaneId) then
			local effectiveTolerance = glide.triggerDistanceTolerance and glide.triggerDistanceTolerance > 0 and glide.triggerDistanceTolerance or tolerance

			if math.abs(glide.fromDistance - currentDistance) <= math.max(0.01, effectiveTolerance or 0) then
				return glide
			end
		end
	end

	return nil
end

function LayeredRouteRuntimeUtility.FindUnderwaterRoute(config, fromRouteId, triggerElementId, currentDistance, currentLaneId, tolerance)
	local routes = config and config.routeNetwork and config.routeNetwork.underwaterRoutes

	if not routes then
		return nil
	end

	for _, route in ipairs(routes) do
		if route and route.enabled ~= false and EqualsIgnoreCase(route.fromRouteId, fromRouteId) and EqualsIgnoreCase(route.triggerElementId, triggerElementId) and MatchesLane(route.fromLaneIds, route.fromLaneId, currentLaneId) then
			local effectiveTolerance = route.triggerDistanceTolerance and route.triggerDistanceTolerance > 0 and route.triggerDistanceTolerance or tolerance

			if math.abs(route.fromDistance - currentDistance) <= math.max(0.01, effectiveTolerance or 0) then
				return route
			end
		end
	end

	return nil
end

function LayeredRouteRuntimeUtility.FindSnowSlopeRoute(config, fromRouteId, triggerElementId, currentDistance, currentLaneId, tolerance)
	local routes = config and config.routeNetwork and config.routeNetwork.snowSlopeRoutes

	if not routes then
		return nil
	end

	for _, route in ipairs(routes) do
		if route and route.enabled ~= false and EqualsIgnoreCase(route.fromRouteId, fromRouteId) and EqualsIgnoreCase(route.triggerElementId, triggerElementId) and MatchesLane(route.fromLaneIds, route.fromLaneId, currentLaneId) then
			local effectiveTolerance = route.triggerDistanceTolerance and route.triggerDistanceTolerance > 0 and route.triggerDistanceTolerance or tolerance

			if math.abs(route.fromDistance - currentDistance) <= math.max(0.01, effectiveTolerance or 0) then
				return route
			end
		end
	end

	return nil
end

function LayeredRouteRuntimeUtility.FindWaterfallClimbRoute(config, fromRouteId, triggerElementId, currentDistance, currentLaneId, tolerance)
	local routes = config and config.routeNetwork and config.routeNetwork.waterfallClimbRoutes

	if not routes then
		return nil
	end

	for _, route in ipairs(routes) do
		if route and route.enabled ~= false and EqualsIgnoreCase(route.fromRouteId, fromRouteId) and EqualsIgnoreCase(route.triggerElementId, triggerElementId) and MatchesLane(route.fromLaneIds, route.fromLaneId, currentLaneId) then
			local effectiveTolerance = route.triggerDistanceTolerance and route.triggerDistanceTolerance > 0 and route.triggerDistanceTolerance or tolerance
			local triggerDistance = WaterfallClimb.ResolveEntryTriggerDistance(route)

			if math.abs(triggerDistance - currentDistance) <= math.max(0.01, effectiveTolerance or 0) then
				return route
			end
		end
	end

	return nil
end

function LayeredRouteRuntimeUtility.MapRouteDistance(route, routeDistance, mainBaseDistance, routeBaseDistance)
	if not route then
		return routeDistance
	end

	local localDelta = math.max(0, routeDistance - (routeBaseDistance or 0))

	return (mainBaseDistance or 0) + localDelta * math.max(0.01, route.progressScale or 1)
end

return LayeredRouteRuntimeUtility
