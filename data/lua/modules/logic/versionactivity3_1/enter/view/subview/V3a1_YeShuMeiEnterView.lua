﻿-- chunkname: @modules/logic/versionactivity3_1/enter/view/subview/V3a1_YeShuMeiEnterView.lua

module("modules.logic.versionactivity3_1.enter.view.subview.V3a1_YeShuMeiEnterView", package.seeall)

local V3a1_YeShuMeiEnterView = class("V3a1_YeShuMeiEnterView", VersionActivityEnterBaseSubView)

function V3a1_YeShuMeiEnterView:onInitView()
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goEnterRedDot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._goTry = gohelper.findChild(self.viewGO, "Right/#go_Try")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/#btn_Trial")
	self._goTips = gohelper.findChild(self.viewGO, "Right/#go_Try/#go_Tips")
	self._simageReward = gohelper.findChildSingleImage(self.viewGO, "Right/#go_Try/#go_Tips/#simage_Reward")
	self._txtNum = gohelper.findChildText(self.viewGO, "Right/#go_Try/#go_Tips/#txt_Num")
	self._btnitem = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/#go_Tips/#btn_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_YeShuMeiEnterView:addEvents()
	self._btnEnter:AddClickListener(self._enterGame, self)
	self._btnLocked:AddClickListener(self._clickLock, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self._btnitem:AddClickListener(self._btnitemOnClick, self)
end

function V3a1_YeShuMeiEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self._btnitem:RemoveClickListener()
end

function V3a1_YeShuMeiEnterView:_editableInitView()
	self.actId = VersionActivity3_1Enum.ActivityId.YeShuMei
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.actCo.actDesc
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function V3a1_YeShuMeiEnterView:onOpen()
	RedDotController.instance:addRedDot(self._goEnterRedDot, RedDotEnum.DotNode.V3a1YeShuMeiTask, self.actId)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneMinuteSecond)
	self._animator:Play("open", 0, 0)
end

function V3a1_YeShuMeiEnterView:_enterGame()
	local config = ActivityConfig.instance:getActivityCo(self.actId)
	local condition = config.confirmCondition

	if string.nilorempty(condition) then
		YeShuMeiController.instance:enterLevelView()
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. self.actId .. userid
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			YeShuMeiController.instance:enterLevelView()
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				YeShuMeiController.instance:enterLevelView()
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function V3a1_YeShuMeiEnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToast(toastId)
	end
end

function V3a1_YeShuMeiEnterView:_btnitemOnClick()
	return
end

function V3a1_YeShuMeiEnterView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function V3a1_YeShuMeiEnterView:everySecondCall()
	self:_refreshTime()
end

function V3a1_YeShuMeiEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			self._txtLimitTime.text = dateStr
		end

		local isLock = ActivityHelper.getActivityStatus(self.actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

function V3a1_YeShuMeiEnterView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function V3a1_YeShuMeiEnterView:onDestroyView()
	return
end

return V3a1_YeShuMeiEnterView
