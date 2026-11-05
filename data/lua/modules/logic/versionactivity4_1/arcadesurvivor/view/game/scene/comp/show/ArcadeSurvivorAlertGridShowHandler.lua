-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/comp/show/ArcadeSurvivorAlertGridShowHandler.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.comp.show.ArcadeSurvivorAlertGridShowHandler", package.seeall)

local ArcadeSurvivorAlertGridShowHandler = class("ArcadeSurvivorAlertGridShowHandler")

function ArcadeSurvivorAlertGridShowHandler:ctor()
	self._gridId2AlertItemDict = {}
	self._gridId2BreakEndTimeDict = {}
	self._effectGO2AlertItemDict = {}
	self._alertItemPool = {}
end

function ArcadeSurvivorAlertGridShowHandler:onGetGO(gridId, go, remainTurn)
	self:_initNodes(gridId, go)
	self:_switchNum(gridId, remainTurn)
end

function ArcadeSurvivorAlertGridShowHandler:_initNodes(gridId, go)
	self._grayscaleExcludeTrans = nil

	local alertItem = self._effectGO2AlertItemDict[go]

	if alertItem then
		self._alertItemPool[go] = nil

		local oldGridId = alertItem.gridId

		if oldGridId then
			self._gridId2AlertItemDict[oldGridId] = nil
			self._gridId2BreakEndTimeDict[oldGridId] = nil
		end

		self._grayscaleExcludeTrans = alertItem.numTrans
	else
		local bgGO = gohelper.findChild(go, "root/bg")
		local breakGO = gohelper.findChild(go, "root/break")
		local numParent = gohelper.findChild(go, "root/num")

		gohelper.setActive(bgGO, true)
		gohelper.setActive(numParent, true)
		gohelper.setActive(breakGO, false)

		local numTrans = numParent.transform
		local nodeDict = {}

		for i = 0, numTrans.childCount - 1 do
			local child = numTrans:GetChild(i)
			local num = tonumber(child.name)

			if num then
				nodeDict[num] = child.gameObject

				gohelper.setActive(child.gameObject, false)
			end
		end

		alertItem = {
			effectGO = go,
			bgGO = bgGO,
			numGO = numParent,
			breakGO = breakGO,
			numNodeDict = nodeDict,
			numTrans = numTrans
		}
		self._effectGO2AlertItemDict[go] = alertItem
	end

	gohelper.setActive(alertItem.bgGO, true)
	gohelper.setActive(alertItem.numGO, true)
	gohelper.setActive(alertItem.breakGO, false)

	self._gridId2BreakEndTimeDict[gridId] = nil
	alertItem.gridId = gridId
	self._gridId2AlertItemDict[gridId] = alertItem
end

function ArcadeSurvivorAlertGridShowHandler:onRefresh(gridId, remainTurn)
	self:_switchNum(gridId, remainTurn)
end

function ArcadeSurvivorAlertGridShowHandler:_switchNum(gridId, remainTurn)
	local alertItem = self._gridId2AlertItemDict[gridId]

	if not alertItem then
		return
	end

	local nodeDict = alertItem.numNodeDict

	if not nodeDict then
		return
	end

	local haveNode = false

	for num, nodeGO in pairs(nodeDict) do
		local isActive = num == remainTurn

		gohelper.setActive(nodeGO, isActive)

		if isActive then
			haveNode = true
		end
	end

	if not haveNode then
		logError(string.format("ArcadeSurvivorAlertGridShowHandler:switchNum error, no num:%s node", remainTurn))
	end
end

function ArcadeSurvivorAlertGridShowHandler:onRemoved(gridId)
	local alertItem = self._gridId2AlertItemDict[gridId]

	if not alertItem then
		return false
	end

	gohelper.setActive(alertItem.bgGO, false)
	gohelper.setActive(alertItem.numGO, false)
	gohelper.setActive(alertItem.breakGO, true)

	self._gridId2BreakEndTimeDict[gridId] = Time.time + ArcadeSurvivorGameEnum.Const.AlertBreakHideTime

	return true
end

function ArcadeSurvivorAlertGridShowHandler:onUpdate()
	local gridId2BreakEndTimeDict = self._gridId2BreakEndTimeDict

	if not gridId2BreakEndTimeDict then
		return
	end

	local now = Time.time
	local gridId2AlertItemDict = self._gridId2AlertItemDict

	for gridId, endTime in pairs(gridId2BreakEndTimeDict) do
		if endTime <= now then
			local alertItem = gridId2AlertItemDict[gridId]

			if alertItem then
				gohelper.setActive(alertItem.breakGO, false)

				local effectGO = alertItem.effectGO

				gohelper.setActive(effectGO, false)

				local oldGridId = alertItem.gridId or gridId

				gridId2AlertItemDict[oldGridId] = nil
				alertItem.gridId = nil
				self._alertItemPool[effectGO] = alertItem
			end

			gridId2BreakEndTimeDict[gridId] = nil
		end
	end
end

function ArcadeSurvivorAlertGridShowHandler:getReusableEffectGO(gridId)
	local alertItem = self._gridId2AlertItemDict[gridId]

	if alertItem then
		self._gridId2BreakEndTimeDict[gridId] = nil

		return alertItem.effectGO
	end

	local effectGO, pooledAlertItem = next(self._alertItemPool)

	if not effectGO then
		return nil
	end

	self._alertItemPool[effectGO] = nil
	pooledAlertItem.gridId = gridId
	self._gridId2AlertItemDict[gridId] = pooledAlertItem
	self._gridId2BreakEndTimeDict[gridId] = nil

	return effectGO
end

function ArcadeSurvivorAlertGridShowHandler:getRetainedEffectGODict()
	local retainedEffectGODict = {}
	local alertItemPool = self._alertItemPool

	for effectGO in pairs(alertItemPool) do
		retainedEffectGODict[effectGO] = true
	end

	local gridId2BreakEndTimeDict = self._gridId2BreakEndTimeDict

	for gridId in pairs(gridId2BreakEndTimeDict) do
		local alertItem = self._gridId2AlertItemDict[gridId]

		if alertItem then
			retainedEffectGODict[alertItem.effectGO] = true
		end
	end

	return retainedEffectGODict
end

function ArcadeSurvivorAlertGridShowHandler:getGrayscaleExcludeTrans()
	return self._grayscaleExcludeTrans
end

function ArcadeSurvivorAlertGridShowHandler:onClear()
	self._gridId2AlertItemDict = {}
	self._gridId2BreakEndTimeDict = {}
	self._effectGO2AlertItemDict = {}
	self._alertItemPool = {}
	self._grayscaleExcludeTrans = nil
end

return ArcadeSurvivorAlertGridShowHandler
