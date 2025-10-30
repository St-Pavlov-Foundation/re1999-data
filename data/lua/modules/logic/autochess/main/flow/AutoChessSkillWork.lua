﻿-- chunkname: @modules/logic/autochess/main/flow/AutoChessSkillWork.lua

module("modules.logic.autochess.main.flow.AutoChessSkillWork", package.seeall)

local AutoChessSkillWork = class("AutoChessSkillWork", BaseWork)

function AutoChessSkillWork:ctor(step)
	self.step = step
end

function AutoChessSkillWork:onStart(context)
	local mgr = AutoChessEntityMgr.instance
	local skillEntity = mgr:tryGetEntity(self.step.fromId)

	if not skillEntity then
		self:finishWork()

		return
	end

	local skillCo
	local animTime = 0
	local effectTime = 0

	if skillEntity.warZone then
		skillCo = lua_auto_chess_skill.configDict[tonumber(self.step.reasonId)]
	else
		skillCo = lua_auto_chess_master_skill.configDict[tonumber(self.step.reasonId)]
	end

	if skillCo then
		if not string.nilorempty(skillCo.skillaction) then
			animTime = skillEntity:skillAnim(skillCo.skillaction)
		end

		if skillCo.useeffect ~= 0 then
			effectTime = skillEntity:playEffect(skillCo.useeffect)
		end
	end

	local delayTime = math.max(animTime, effectTime)

	if delayTime == 0 then
		self:finishWork()
	else
		TaskDispatcher.runDelay(self.finishWork, self, delayTime)
	end
end

function AutoChessSkillWork:onStop()
	TaskDispatcher.cancelTask(self.finishWork, self)
end

function AutoChessSkillWork:onResume()
	self:finishWork()
end

function AutoChessSkillWork:clearWork()
	TaskDispatcher.cancelTask(self.finishWork, self)
end

function AutoChessSkillWork:finishWork()
	self:onDone(true)
end

return AutoChessSkillWork
