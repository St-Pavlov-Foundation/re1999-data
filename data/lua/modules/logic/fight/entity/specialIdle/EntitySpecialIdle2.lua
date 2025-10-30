﻿-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle2.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle2", package.seeall)

local EntitySpecialIdle2 = class("EntitySpecialIdle2", UserDataDispose)

function EntitySpecialIdle2:ctor(entity)
	self:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:registerCallback(FightEvent.OnBeginWave, self._onBeginWave, self)

	self._act_count = 0
	self._entity = entity
end

function EntitySpecialIdle2:_onSkillPlayFinish(entity)
	if entity.id ~= self._entity.id then
		return
	end

	if not self._last_round_id then
		self._last_round_id = FightModel.instance:getCurRoundId()
	end

	if FightModel.instance:getCurRoundId() - self._last_round_id > 1 then
		self._act_count = 0
	else
		self._act_count = self._act_count + 1
	end

	self._last_round_id = FightModel.instance:getCurRoundId()

	if self._act_count >= 3 then
		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, entity.id)

		self._act_count = 0
	end
end

function EntitySpecialIdle2:_onBeginWave()
	self._act_count = 0
end

function EntitySpecialIdle2:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, self._onBeginWave, self)

	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle2
