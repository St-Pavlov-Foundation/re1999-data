-- chunkname: @modules/logic/autochess/main/flow/AutoChessEffectWork.lua

module("modules.logic.autochess.main.flow.AutoChessEffectWork", package.seeall)

local AutoChessEffectWork = class("AutoChessEffectWork", BaseWork)

function AutoChessEffectWork:ctor(effect)
	self.effect = effect
	self.mgr = AutoChessEntityMgr.instance
	self.chessMo = AutoChessModel.instance:getChessMo()

	if self.effect.effectType == AutoChessEnum.EffectType.NextFightStep then
		logError("异常:NextFightStep类型的数据不该出现在这里")
	end
end

function AutoChessEffectWork:markSkillEffect(fromUid, effectId)
	self.skillFromUid = fromUid
	self.skillEffectId = effectId
end

function AutoChessEffectWork:onStart(context)
	local handleFunc = AutoChessEffectHandleFunc.instance:getHandleFunc(self.effect.effectType)

	if handleFunc then
		handleFunc(self)
	else
		logError(string.format("警告:跳过EffectType : %s", self.effect.effectType))
		self:finishWork()
	end
end

function AutoChessEffectWork:onStop()
	if self.damageWork then
		self.damageWork:onStopInternal()
	else
		TaskDispatcher.cancelTask(self.delayAttack, self)
		TaskDispatcher.cancelTask(self.delayFloatLeader, self)
		TaskDispatcher.cancelTask(self.finishWork, self)
	end
end

function AutoChessEffectWork:onResume()
	if self.damageWork then
		self.damageWork:onResumeInternal()
	else
		self:finishWork()
	end
end

function AutoChessEffectWork:clearWork()
	if self.damageWork then
		self.damageWork:unregisterDoneListener(self.finishWork, self)

		self.damageWork = nil
	end

	TaskDispatcher.cancelTask(self.delayAttack, self)
	TaskDispatcher.cancelTask(self.delayFloatLeader, self)
	TaskDispatcher.cancelTask(self.chessCombine1, self)
	TaskDispatcher.cancelTask(self.chessCombine2, self)
	TaskDispatcher.cancelTask(self.chessDisband1, self)
	TaskDispatcher.cancelTask(self.finishWork, self)

	self.effect = nil
	self.mgr = nil
	self.chessMo = nil
	self.skillEffectId = nil
end

function AutoChessEffectWork:finishWork()
	if self.effect.effectType == AutoChessEnum.EffectType.ChessDie then
		AutoChessEntityMgr.instance:removeEntity(self.effect.targetId)
	end

	self:onDone(true)
end

function AutoChessEffectWork:delayAttack()
	local delayTime = 0
	local attackLeader = self.mgr:getLeaderEntity(self.effect.fromId)
	local hurtLeader = self.mgr:getLeaderEntity(self.effect.targetId)

	if attackLeader and hurtLeader then
		delayTime = attackLeader:ranged(hurtLeader.transform.position, 20002)
	end

	TaskDispatcher.runDelay(self.delayFloatLeader, self, delayTime)
end

function AutoChessEffectWork:delayFloatLeader()
	local hurtLeader = self.mgr:getLeaderEntity(self.effect.targetId)

	if hurtLeader then
		hurtLeader:floatHp(self.effect.effectNum)
		TaskDispatcher.runDelay(self.finishWork, self, 1)
	else
		self:finishWork()
	end
end

function AutoChessEffectWork:chessCombine1()
	local uidList = string.split(self.effect.effectString, "#")

	for _, uid in ipairs(uidList) do
		local entity = self.mgr:getEntity(uid)

		if entity then
			entity:die()
		end

		local chessPos = self.chessMo:getChessPosition1(uid, self.chessMo.lastSvrFight)

		chessPos.chess = AutoChessHelper.buildEmptyChess()
	end

	TaskDispatcher.runDelay(self.chessCombine2, self, AutoChessEnum.ChessAniTime.die)
end

function AutoChessEffectWork:chessCombine2()
	local uidList = string.split(self.effect.effectString, "#")

	for _, uid in ipairs(uidList) do
		self.mgr:removeEntity(uid)
	end

	local chess = self.effect.chessList[1]

	self.mgr:addEntity(self.bornWarzone, chess, self.bornIndex)

	local chessPos = self.chessMo:getChessPosition(self.bornWarzone, self.bornIndex + 1, self.chessMo.lastSvrFight)

	chessPos.chess = chess

	TaskDispatcher.runDelay(self.finishWork, self, AutoChessEnum.ChessAniTime.born)
end

function AutoChessEffectWork:chessDisband1()
	local indexList = string.splitToNumber(self.effect.effectString, "#")

	for k, chess in ipairs(self.effect.chessList) do
		local index = indexList[k]
		local entity = self.mgr:getEntity(chess.uid)

		if entity then
			entity:move(index)
		end

		local chessPos = self.chessMo:getChessPosition(self.bornWarzone, index + 1, self.chessMo.lastSvrFight)

		chessPos.chess = chess
	end

	TaskDispatcher.runDelay(self.finishWork, self, AutoChessEnum.ChessAniTime.jump)
end

return AutoChessEffectWork
