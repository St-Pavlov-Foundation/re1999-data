﻿-- chunkname: @modules/logic/survival/view/map/SurvivalHeroGroupFightView.lua

module("modules.logic.survival.view.map.SurvivalHeroGroupFightView", package.seeall)

local SurvivalHeroGroupFightView = class("SurvivalHeroGroupFightView", HeroGroupFightView)

function SurvivalHeroGroupFightView:_editableInitView()
	self:checkHeroList()
	SurvivalHeroGroupFightView.super._editableInitView(self)
end

function SurvivalHeroGroupFightView:_refreshBtns(isCostPower)
	SurvivalHeroGroupFightView.super._refreshBtns(self, isCostPower)
	gohelper.setActive(self._dropherogroup, false)
	TaskDispatcher.cancelTask(self._checkDropArrow, self)
end

function SurvivalHeroGroupFightView:checkHeroList()
	local roleNum = 5
	local groupMO = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setMaxHeroCount(roleNum, SurvivalHeroSingleGroupMO)
	HeroSingleGroupModel.instance:setSingleGroup(groupMO)
end

function SurvivalHeroGroupFightView:openHeroGroupEditView()
	ViewMgr.instance:openView(ViewName.SurvivalHeroGroupEditView, self._param)
end

function SurvivalHeroGroupFightView:_refreshReplay()
	gohelper.setActive(self._goReplayBtn, false)
	gohelper.setActive(self._gomemorytimes, false)
end

function SurvivalHeroGroupFightView:_refreshPowerShow()
	gohelper.setActive(self._gopowercontent, false)
end

function SurvivalHeroGroupFightView:_onClickStart()
	if SurvivalEquipRedDotHelper.instance.reddotType >= 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalEnterFightEquipRed, MsgBoxEnum.BoxType.Yes_No, self._realClickStart, nil, nil, self, nil, nil)
	else
		SurvivalHeroGroupFightView.super._onClickStart(self)
	end
end

function SurvivalHeroGroupFightView:_realClickStart()
	SurvivalHeroGroupFightView.super._onClickStart(self)
end

function SurvivalHeroGroupFightView:onClose()
	SurvivalHeroGroupFightView.super.onClose(self)
	HeroSingleGroupModel.instance:setMaxHeroCount()

	HeroGroupTrialModel.instance.curBattleId = nil
end

return SurvivalHeroGroupFightView
