-- chunkname: @modules/logic/fight/system/work/FightWorkSkinDownEffectExit672804.lua

module("modules.logic.fight.system.work.FightWorkSkinDownEffectExit672804", package.seeall)

local FightWorkSkinDownEffectExit672804 = class("FightWorkSkinDownEffectExit672804", FightWorkItem)

function FightWorkSkinDownEffectExit672804:onConstructor()
	return
end

function FightWorkSkinDownEffectExit672804:onStart()
	local flow = self:com_registFlowSequence()
	local floorEffect = FightMsgMgr.sendMsg(FightMsgId.GetCardSkin672804FloorEffect)

	if floorEffect then
		local animator = gohelper.onceAddComponent(floorEffect, gohelper.Type_Animator)
		local speed = FightModel.instance:getUISpeed()

		animator.speed = speed

		animator:Play("out", 0, 0)
		flow:registWork(FightWorkDelayTimer, 0.5 / speed)
		flow:registWork(FightWorkFunction, gohelper.setActive, floorEffect, false)
	end

	self:playWorkAndDone(flow)
end

return FightWorkSkinDownEffectExit672804
