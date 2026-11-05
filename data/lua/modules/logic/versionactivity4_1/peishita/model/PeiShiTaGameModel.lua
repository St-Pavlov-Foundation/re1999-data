-- chunkname: @modules/logic/versionactivity4_1/peishita/model/PeiShiTaGameModel.lua

module("modules.logic.versionactivity4_1.peishita.model.PeiShiTaGameModel", package.seeall)

local PeiShiTaGameModel = class("PeiShiTaGameModel", BaseModel)

function PeiShiTaGameModel:onInit()
	self._gameMo = nil
end

function PeiShiTaGameModel:reInit()
	self._gameMo = nil
end

function PeiShiTaGameModel:initLevel(actId, gameId)
	local gameConfig = PeiShiTaGameConfig.instance:getGame(actId, gameId)

	if not gameConfig then
		logError(string.format("PeiShiTaGameModel:initLevel 玩法关卡配置不存在, actId = %s, gameId = %s", actId, gameId))

		return
	end

	local gameMo = PeiShiTaGameMo.New()

	gameMo.actId = actId

	gameMo:updateFromGameConfig(gameConfig)

	self._gameMo = gameMo
end

function PeiShiTaGameModel:restartGame()
	if not self._gameMo then
		return
	end

	self:initLevel(self._gameMo.actId, self._gameMo.gameId)

	PeiShiTaController.instance.startTime = ServerTime.now()

	PeiShiTaGameController.instance:dispatchEvent(PeiShiTaEvent.OnLevelReset)
end

function PeiShiTaGameModel:getUnitById(id)
	if not self._gameMo then
		return nil
	end

	return self._gameMo:getUnitById(id)
end

function PeiShiTaGameModel:findSchulzUnit()
	if not self._gameMo then
		return nil
	end

	local list = self._gameMo:getUnitsByType(PeiShiTaEnum.UnitType.Schulz)

	return list and list[1] or nil
end

function PeiShiTaGameModel:setPlayerPos(x, y)
	if not self._gameMo then
		return
	end

	local player = self._gameMo:getUnitById(self._gameMo.playerId)

	if not player then
		return
	end

	self._gameMo:updateUnitPos(player, x, y)
end

function PeiShiTaGameModel:getPlayerPos()
	if not self._gameMo then
		return nil
	end

	return self._gameMo:getUnitById(self._gameMo.playerId)
end

function PeiShiTaGameModel:addTool(toolId, count)
	if not self._gameMo then
		return
	end

	count = count or 1
	self._gameMo.toolDic[toolId] = (self._gameMo.toolDic[toolId] or 0) + count

	PeiShiTaGameController.instance:dispatchEvent(PeiShiTaEvent.OnToolChanged, toolId)
end

function PeiShiTaGameModel:removeTool(toolId, count)
	if not self._gameMo then
		return
	end

	count = count or 1

	local current = self._gameMo.toolDic[toolId] or 0

	self._gameMo.toolDic[toolId] = math.max(0, current - count)

	PeiShiTaGameController.instance:dispatchEvent(PeiShiTaEvent.OnToolChanged, toolId)
end

function PeiShiTaGameModel:getToolCount(toolId)
	if not self._gameMo then
		return 0
	end

	return self._gameMo.toolDic[toolId] or 0
end

function PeiShiTaGameModel:removeUnit(x, y)
	if not self._gameMo then
		return nil
	end

	local unit = self._gameMo:getUnitByPos(x, y)

	if not unit then
		return nil
	end

	self._gameMo:removeUnit(unit)

	return unit
end

function PeiShiTaGameModel:removeUnitById(id)
	if not self._gameMo then
		return nil
	end

	local unit = self._gameMo:getUnitById(id)

	if not unit then
		return nil
	end

	self._gameMo:removeUnit(unit)

	return unit
end

function PeiShiTaGameModel:getUnitMo(x, y)
	if not self._gameMo then
		return nil
	end

	return self._gameMo:getUnitByPos(x, y)
end

function PeiShiTaGameModel:moveUnit(unit, x, y)
	if not self._gameMo or not unit then
		return
	end

	self._gameMo:updateUnitPos(unit, x, y)
end

function PeiShiTaGameModel:setFinished(isSuccess)
	if not self._gameMo then
		return
	end

	self._gameMo.isFinished = true
	self._gameMo.isSuccess = isSuccess
end

function PeiShiTaGameModel:getGameMo()
	return self._gameMo
end

function PeiShiTaGameModel:getGameId()
	return self._gameMo and self._gameMo.gameId
end

function PeiShiTaGameModel:getGameConfig()
	if not self._gameMo then
		return nil
	end

	return PeiShiTaGameConfig.instance:getGame(self._gameMo.actId, self._gameMo.gameId)
end

PeiShiTaGameModel.instance = PeiShiTaGameModel.New()

return PeiShiTaGameModel
