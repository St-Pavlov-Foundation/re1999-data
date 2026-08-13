-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/specialtrack/RouteTransfer.lua

module("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.RouteTransfer", package.seeall)

local RouteTransfer = {}
local RouteTransferMinFlightDurationSec = 0.67
local RouteTransferHorizontalReferenceSpeed = 220
local RouteTransferVerticalReferenceSpeed = 120
local RouteTransferDurationStepSec = 0.05
local RouteTransferFullRollDegrees = 360
local RouteTransferAlignedCurveMinDot = math.cos(math.rad(15))
local RouteTransferAlignedRiseClearanceScale = 0.5

function RouteTransfer.ResolveFlightDuration(authoredDurationSec, horizontalDistance, verticalDistance)
	local horizontalDuration = math.max(0, horizontalDistance or 0) / RouteTransferHorizontalReferenceSpeed
	local verticalDuration = math.abs(verticalDistance or 0) / RouteTransferVerticalReferenceSpeed
	local duration = math.max(RouteTransferMinFlightDurationSec, math.max(0, authoredDurationSec or 0), horizontalDuration, verticalDuration)

	return math.ceil((duration - 1e-06) / RouteTransferDurationStepSec) * RouteTransferDurationStepSec
end

function RouteTransfer.ResolveForwardRollTotalDegrees(flightDurationSec, authoredDegreesPerSecond)
	local duration = math.max(0.01, flightDurationSec or 0)
	local rollSpeed = math.max(0, authoredDegreesPerSecond or 0)
	local authoredTurns = duration * rollSpeed / RouteTransferFullRollDegrees
	local fullTurns = math.max(1, math.floor(authoredTurns + 0.5))

	return fullTurns * RouteTransferFullRollDegrees
end

function RouteTransfer.ShouldUseAlignedHorizontalCurve(startApproachDot, landingApproachDot)
	local safeStartDot = Mathf.Clamp(startApproachDot or 1, -1, 1)
	local safeLandingDot = Mathf.Clamp(landingApproachDot or 1, -1, 1)

	return safeStartDot < RouteTransferAlignedCurveMinDot or safeLandingDot < RouteTransferAlignedCurveMinDot
end

function RouteTransfer.ResolveGenericAlignedFlightHeight(useAlignedCurve, verticalDistance, resolvedHeight)
	local height = math.max(0, resolvedHeight or 0)

	if not useAlignedCurve or (verticalDistance or 0) <= 0 then
		return height
	end

	return math.max(height, verticalDistance * RouteTransferAlignedRiseClearanceScale)
end

function RouteTransfer.Is105Air001ToAir002Transfer(transfer)
	if not transfer then
		return false
	end

	return string.lower(transfer.transferId or "") == "transfer_001" and string.lower(transfer.fromRouteId or "") == "air_001" and math.abs((transfer.fromDistance or 0) - 220) <= 0.001 and string.lower(transfer.toRouteId or "") == "air_002" and math.abs((transfer.toDistance or 0) - 24.556396484375) <= 0.001 and (transfer.toLaneId or 0) == 2
end

function RouteTransfer.ResolveAlignedFlightHeight(useAlignedCurve, resolvedHeight)
	local height = math.max(0, resolvedHeight or 0)

	return useAlignedCurve and math.max(32, height) or height
end

function RouteTransfer.EvaluateAlignedHorizontalCurve(startX, startZ, startForwardX, startForwardZ, finishX, finishZ, finishForwardX, finishForwardZ, progress)
	local t = Mathf.Clamp01(progress or 0)
	local oneMinusT = 1 - t
	local deltaX = (finishX or 0) - (startX or 0)
	local deltaZ = (finishZ or 0) - (startZ or 0)
	local flightDistance = math.sqrt(deltaX * deltaX + deltaZ * deltaZ)
	local startLength = math.sqrt((startForwardX or 0) * (startForwardX or 0) + (startForwardZ or 0) * (startForwardZ or 0))
	local finishLength = math.sqrt((finishForwardX or 0) * (finishForwardX or 0) + (finishForwardZ or 0) * (finishForwardZ or 0))
	local chordLength = math.max(0.0001, flightDistance)
	local chordX = deltaX / chordLength
	local chordZ = deltaZ / chordLength
	local safeStartX = startLength > 0.0001 and startForwardX / startLength or chordX
	local safeStartZ = startLength > 0.0001 and startForwardZ / startLength or chordZ
	local safeFinishX = finishLength > 0.0001 and finishForwardX / finishLength or chordX
	local safeFinishZ = finishLength > 0.0001 and finishForwardZ / finishLength or chordZ
	local startControlDistance = math.max(1, flightDistance * 0.33)
	local endControlDistance = math.max(1, flightDistance * 0.5)
	local p1X = startX + safeStartX * startControlDistance
	local p1Z = startZ + safeStartZ * startControlDistance
	local p2X = finishX - safeFinishX * endControlDistance
	local p2Z = finishZ - safeFinishZ * endControlDistance
	local x = startX * (oneMinusT * oneMinusT * oneMinusT) + p1X * (3 * oneMinusT * oneMinusT * t) + p2X * (3 * oneMinusT * t * t) + finishX * (t * t * t)
	local z = startZ * (oneMinusT * oneMinusT * oneMinusT) + p1Z * (3 * oneMinusT * oneMinusT * t) + p2Z * (3 * oneMinusT * t * t) + finishZ * (t * t * t)
	local tangentX = (p1X - startX) * (3 * oneMinusT * oneMinusT) + (p2X - p1X) * (6 * oneMinusT * t) + (finishX - p2X) * (3 * t * t)
	local tangentZ = (p1Z - startZ) * (3 * oneMinusT * oneMinusT) + (p2Z - p1Z) * (6 * oneMinusT * t) + (finishZ - p2Z) * (3 * t * t)
	local tangentLength = math.sqrt(tangentX * tangentX + tangentZ * tangentZ)

	if tangentLength <= 0.0001 then
		tangentX, tangentZ = chordX, chordZ
	else
		tangentX, tangentZ = tangentX / tangentLength, tangentZ / tangentLength
	end

	return x, z, tangentX, tangentZ
end

return RouteTransfer
