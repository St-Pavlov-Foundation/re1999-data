-- chunkname: @modules/logic/fight/view/FightViewHandCardSkin672804.lua

module("modules.logic.fight.view.FightViewHandCardSkin672804", package.seeall)

local FightViewHandCardSkin672804 = class("FightViewHandCardSkin672804", FightBaseClass)

function FightViewHandCardSkin672804:onConstructor()
	self.loader = self:addComponent(FightLoaderComponent)

	self:com_registMsg(FightMsgId.GetCardSkin672804Mgr, self.onGetCardSkin672804Mgr)
	self:com_registFightEvent(FightEvent.AfterEffectWorkDone, self.onAfterEffectWorkDone)
	self:com_registMsg(FightMsgId.GetCardSkin672804FloorEffect, self.onGetCardSkin672804FloorEffect)
end

function FightViewHandCardSkin672804:onGetCardSkin672804FloorEffect()
	FightMsgMgr.replyMsg(FightMsgId.GetCardSkin672804FloorEffect, self.floorEffect)
end

function FightViewHandCardSkin672804:onAfterEffectWorkDone()
	gohelper.setActive(self.floorEffect, true)
end

function FightViewHandCardSkin672804:onGetCardSkin672804Mgr()
	FightMsgMgr.replyMsg(FightMsgId.GetCardSkin672804Mgr, self)
end

function FightViewHandCardSkin672804:setFloorEffect(floorEffect)
	self.floorEffect = floorEffect
	self.floorAnimator = gohelper.onceAddComponent(floorEffect, gohelper.Type_Animator)
end

function FightViewHandCardSkin672804:onDestructor()
	return
end

return FightViewHandCardSkin672804
