-- chunkname: @modules/logic/versionactivity4_1/peishita/controller/PeiShiTaGameController.lua

module("modules.logic.versionactivity4_1.peishita.controller.PeiShiTaGameController", package.seeall)

local PeiShiTaGameController = class("PeiShiTaGameController", BaseController)

function PeiShiTaGameController:onInit()
	self:reInit()
end

function PeiShiTaGameController:reInit()
	self._actId = nil
	self._gameId = nil

	self:stopFlow()
end

function PeiShiTaGameController:addConstEvents()
	return
end

function PeiShiTaGameController:startGame(actId, gameId)
	if not actId or not gameId then
		return
	end

	self._actId = actId
	self._gameId = gameId

	self:stopFlow()
	PeiShiTaGameModel.instance:initLevel(actId, gameId)
	ViewMgr.instance:openView(ViewName.PeiShiTaGameView)
end

function PeiShiTaGameController:endGame()
	self:stopFlow()

	local gameMo = PeiShiTaGameModel.instance:getGameMo()
	local isSuccess = gameMo and gameMo.isSuccess

	PeiShiTaController.instance:onGameFinish(isSuccess)
end

function PeiShiTaGameController:onMoveInput(dir)
	if self._moveLocked or GuideController.instance:isAnyGuideRunning() then
		return
	end

	local gameMo = PeiShiTaGameModel.instance:getGameMo()

	if not gameMo or gameMo.isFinished then
		return
	end

	local player = PeiShiTaGameModel.instance:getUnitById(gameMo.playerId)

	if not player then
		return
	end

	local tx, ty = PeiShiTaCellHelper.calcTargetPos(player.pos.x, player.pos.y, dir)

	if not PeiShiTaCellHelper.canEnterCell(gameMo, tx, ty) then
		return
	end

	local targetUnit = PeiShiTaCellHelper.getCellUnit(gameMo, tx, ty)

	PeiShiTaGameModel.instance:setPlayerPos(tx, ty)
	self:stopFlow()

	local flow = FlowSequence.New()

	self._flow = flow

	flow:addWork(FunctionWork.New(self.lockMoveInput, self, true))

	if not targetUnit or targetUnit.config.type ~= PeiShiTaEnum.UnitType.Obstacle then
		PeiShiTaCellHelper.commonMoveFlow(gameMo, targetUnit, flow, tx, ty, dir)
	end

	PeiShiTaCellHelper.triggerCellEffect(gameMo, targetUnit, flow, tx, ty, dir)

	if not gameMo.isFinished then
		for _, addWorks in ipairs(PeiShiTaGameController._killCheckChain) do
			if addWorks(self, gameMo, flow) then
				break
			end
		end
	end

	flow:addWork(FunctionWork.New(self.dispatchEvent, self, PeiShiTaEvent.OnBoardChanged))
	flow:addWork(FunctionWork.New(self.lockMoveInput, self, false))
	flow:addWork(FunctionWork.New(self.checkAndOpenResult, self))
	flow:start()
end

function PeiShiTaGameController:_addCrossbowKillWorks(gameMo, flow)
	local shootable = PeiShiTaGameHelper.findShootableHunter(gameMo)
	local player = PeiShiTaGameModel.instance:getUnitById(gameMo.playerId)

	if not shootable or not player then
		return false
	end

	local tx, ty = shootable.pos.x, shootable.pos.y
	local sx, sy = player.pos.x, player.pos.y

	flow:addWork(FunctionWork.New(self.dispatchEvent, self, PeiShiTaEvent.OnArcheryEffect, sx, sy, tx, ty))
	flow:addWork(WaitEventWork.New(PeiShiTaEnum.WaitArcheryAnimDoneKey))
	flow:addWork(FunctionWork.New(self.dispatchEvent, self, PeiShiTaEvent.OnUnitRemove, shootable, tx, ty))
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.removeUnit, PeiShiTaGameModel.instance, tx, ty))
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.removeTool, PeiShiTaGameModel.instance, PeiShiTaEnum.ToolId.Crossbow, 1))

	return true
end

function PeiShiTaGameController:_addSchulzKillWorks(gameMo, flow)
	local target = PeiShiTaGameHelper.findSchulzKillTarget(gameMo)

	if not target then
		return false
	end

	local schulz = PeiShiTaGameModel.instance:findSchulzUnit()

	if not schulz then
		return false
	end

	local targetX, targetY = target.pos.x, target.pos.y

	flow:addWork(FunctionWork.New(self.dispatchEvent, self, PeiShiTaEvent.OnAlertUnit, schulz.id))
	flow:addWork(WorkWaitSeconds.New(PeiShiTaEnum.ConstValue.SchulzAlertAnimTime))

	local waitEvent = PeiShiTaEnum.WaitMoveAnimDoneKey .. tostring(schulz.id)

	flow:addWork(FunctionWork.New(self.dispatchEvent, self, PeiShiTaEvent.OnUnitMove, schulz.id, targetX, targetY))
	flow:addWork(WaitEventWork.New(waitEvent))
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.removeUnitById, PeiShiTaGameModel.instance, target.id))
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.moveUnit, PeiShiTaGameModel.instance, schulz, targetX, targetY))
	flow:addWork(FunctionWork.New(self.dispatchEvent, self, PeiShiTaEvent.OnUnitRemove, target, targetX, targetY))

	return true
end

function PeiShiTaGameController:_addHunterAttackWorks(gameMo, flow)
	local hunter = PeiShiTaGameHelper.findHunterAttackTarget(gameMo)

	if not hunter then
		return false
	end

	local player = gameMo:getUnitById(gameMo.playerId)
	local playerX, playerY = player.pos.x, player.pos.y

	flow:addWork(FunctionWork.New(self.dispatchEvent, self, PeiShiTaEvent.OnAlertUnit, hunter.id))
	flow:addWork(WorkWaitSeconds.New(PeiShiTaEnum.ConstValue.HunterAlertAnimTime))

	local waitEvent = PeiShiTaEnum.WaitMoveAnimDoneKey .. tostring(hunter.id)

	flow:addWork(FunctionWork.New(self.dispatchEvent, self, PeiShiTaEvent.OnUnitMove, hunter.id, playerX, playerY))
	flow:addWork(WaitEventWork.New(waitEvent))
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.moveUnit, PeiShiTaGameModel.instance, hunter, playerX, playerY))
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.removeUnitById, PeiShiTaGameModel.instance, gameMo.playerId))
	flow:addWork(FunctionWork.New(self.dispatchEvent, self, PeiShiTaEvent.OnUnitRemove, player, playerX, playerY))

	local waitDieDone = PeiShiTaEnum.WaitDieDoneKey .. tostring(gameMo.playerId)

	flow:addWork(WaitEventWork.New(waitDieDone))
	flow:addWork(FunctionWork.New(PeiShiTaGameModel.setFinished, PeiShiTaGameModel.instance, false))

	return true
end

function PeiShiTaGameController:checkAndOpenResult()
	local gameMo = PeiShiTaGameModel.instance:getGameMo()

	if not gameMo or not gameMo.isFinished then
		return
	end

	local result = gameMo.isSuccess and StatEnum.Result.Success or StatEnum.Result.Fail

	PeiShiTaController.instance:reportGameEnd(result)
	ViewMgr.instance:openView(ViewName.PeiShiTaResultView)
end

function PeiShiTaGameController:lockMoveInput(lock)
	self._moveLocked = lock
end

function PeiShiTaGameController:isMoveLocked()
	return self._moveLocked
end

function PeiShiTaGameController:stopFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end

	self:lockMoveInput(false)
end

PeiShiTaGameController._killCheckChain = {
	PeiShiTaGameController._addCrossbowKillWorks,
	PeiShiTaGameController._addHunterAttackWorks,
	PeiShiTaGameController._addSchulzKillWorks
}
PeiShiTaGameController.instance = PeiShiTaGameController.New()

return PeiShiTaGameController
