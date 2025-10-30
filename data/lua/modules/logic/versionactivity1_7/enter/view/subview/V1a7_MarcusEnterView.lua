﻿-- chunkname: @modules/logic/versionactivity1_7/enter/view/subview/V1a7_MarcusEnterView.lua

module("modules.logic.versionactivity1_7.enter.view.subview.V1a7_MarcusEnterView", package.seeall)

local V1a7_MarcusEnterView = class("V1a7_MarcusEnterView", BaseView)

function V1a7_MarcusEnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtLocked = gohelper.findChildText(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a7_MarcusEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
end

function V1a7_MarcusEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function V1a7_MarcusEnterView:_btnEnterOnClick()
	local userid = PlayerModel.instance:getPlayinfo().userId
	local key = PlayerPrefsKey.EnterRoleActivity .. "#" .. tostring(VersionActivity1_7Enum.ActivityId.Marcus) .. "#" .. tostring(userid)
	local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_70104) or hasTiped then
		ActMarcusController.instance:enterActivity()

		return
	end

	local openCO = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act_70104)
	local dungeonName = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function()
		PlayerPrefsHelper.setNumber(key, 1)
		ActMarcusController.instance:enterActivity()
	end, nil, nil, nil, nil, nil, dungeonName)
end

function V1a7_MarcusEnterView:_btnLockedOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status == ActivityEnum.ActivityStatus.NotUnlock and toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end
end

function V1a7_MarcusEnterView:_editableInitView()
	self.actId = VersionActivity1_7Enum.ActivityId.Marcus
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.config.actDesc

	local unlockTxt = OpenHelper.getActivityUnlockTxt(self.config.openId)

	self._txtLocked.text = unlockTxt

	self:initRewards()

	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
end

function V1a7_MarcusEnterView:onOpen()
	V1a7_MarcusEnterView.super.onOpen(self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._onActStatusChange, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.UpdateActivity, self._showLeftTime, self)

	local goreddot = gohelper.findChild(self._btnEnter.gameObject, "#go_reddot")
	local redDotIcon = RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.PermanentRoleActivityTask, self.actId)

	redDotIcon:setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	self:_freshLockStatus()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	self.animComp:playOpenAnim()
end

function V1a7_MarcusEnterView:onClose()
	V1a7_MarcusEnterView.super.onClose(self)
end

function V1a7_MarcusEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	self.animComp:destroy()
end

function V1a7_MarcusEnterView:initRewards()
	local rewards = string.split(self.config.activityBonus, "|")

	for _, reward in ipairs(rewards) do
		local itemCo = string.splitToNumber(reward, "#")
		local item = IconMgr.instance:getCommonItemIcon(self._gorewards)

		item:setMOValue(itemCo[1], itemCo[2], 1)
		item:isShowCount(false)
	end
end

function V1a7_MarcusEnterView:_freshLockStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self._btnEnter, status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLocked, status == ActivityEnum.ActivityStatus.NotUnlock)
end

function V1a7_MarcusEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function V1a7_MarcusEnterView:_onActStatusChange()
	self:_freshLockStatus()
end

return V1a7_MarcusEnterView
