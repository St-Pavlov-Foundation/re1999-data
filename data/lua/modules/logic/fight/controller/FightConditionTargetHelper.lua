﻿-- chunkname: @modules/logic/fight/controller/FightConditionTargetHelper.lua

module("modules.logic.fight.controller.FightConditionTargetHelper", package.seeall)

local FightConditionTargetHelper = _M

function FightConditionTargetHelper.initConditionTargetHandle()
	if not FightConditionTargetHelper.ConditionTargetHandle then
		FightConditionTargetHelper.ConditionTargetHandle = {
			[FightEnum.ConditionTarget.Self] = FightConditionTargetHelper.getSelfConditionTarget
		}
	end
end

function FightConditionTargetHelper.getTarget(conditionTarget, userSkillEntityId, targetEntityId)
	FightConditionTargetHelper.initConditionTargetHandle()

	local handle = FightConditionTargetHelper.ConditionTargetHandle[conditionTarget]

	if handle then
		return handle(conditionTarget, userSkillEntityId, targetEntityId)
	end

	return targetEntityId
end

function FightConditionTargetHelper.getSelfConditionTarget(conditionTarget, userSkillEntityId, targetEntityId)
	return userSkillEntityId
end

return FightConditionTargetHelper
