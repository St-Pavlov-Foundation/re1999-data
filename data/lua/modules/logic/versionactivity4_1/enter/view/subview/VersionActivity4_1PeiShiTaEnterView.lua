-- chunkname: @modules/logic/versionactivity4_1/enter/view/subview/VersionActivity4_1PeiShiTaEnterView.lua

module("modules.logic.versionactivity4_1.enter.view.subview.VersionActivity4_1PeiShiTaEnterView", package.seeall)

local VersionActivity4_1PeiShiTaEnterView = class("VersionActivity4_1PeiShiTaEnterView", VersionActivityEnterBaseSubView)

function VersionActivity4_1PeiShiTaEnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Left/#txt_Descr")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goEnterRedDot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtUnLocked = gohelper.findChildText(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
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

function VersionActivity4_1PeiShiTaEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self._btnitem:AddClickListener(self._btnitemOnClick, self)
end

function VersionActivity4_1PeiShiTaEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self._btnitem:RemoveClickListener()
end

function VersionActivity4_1PeiShiTaEnterView:_btnEnterOnClick()
	self:_enterGame()
end

function VersionActivity4_1PeiShiTaEnterView:_btnLockedOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status == ActivityEnum.ActivityStatus.NotUnlock and toastId then
		GameFacade.showToastWithTableParam(toastId, paramList)
	end
end

function VersionActivity4_1PeiShiTaEnterView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		if episodeCo then
			DungeonFightController.instance:enterFight(episodeCo.chapterId, episodeId)
		end
	else
		self:_clickLock()
	end
end

function VersionActivity4_1PeiShiTaEnterView:_btnitemOnClick()
	return
end

function VersionActivity4_1PeiShiTaEnterView:_editableInitView()
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function VersionActivity4_1PeiShiTaEnterView:onOpen()
	self.actId = self.viewContainer.activityId
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	RoleActivityEnum.LevelView[self.actId] = ViewName.PeiShiTaLevelView
	self._txtDescr.text = self.actCo.actDesc
	self._txtUnLocked.text = OpenHelper.getActivityUnlockTxt(self.actCo.openId)

	RedDotController.instance:addRedDot(self._goEnterRedDot, RedDotEnum.DotNode.Activity220Task, self.actId)
	VersionActivity4_1PeiShiTaEnterView.super.onOpen(self)
end

function VersionActivity4_1PeiShiTaEnterView:_enterGame()
	local condition = self.actCo.confirmCondition

	if string.nilorempty(condition) then
		PeiShiTaController.instance:enterEpisodeLevelView()
	else
		local strs = string.split(condition, "=")
		local openId = tonumber(strs[2])
		local userid = PlayerModel.instance:getPlayinfo().userId
		local key = PlayerPrefsKey.EnterRoleActivity .. self.actId .. userid
		local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

		if OpenModel.instance:isFunctionUnlock(openId) or hasTiped then
			PeiShiTaController.instance:enterEpisodeLevelView()
		else
			local openCO = OpenConfig.instance:getOpenCo(openId)
			local dungeonDisplay = DungeonConfig.instance:getEpisodeDisplay(openCO.episodeId)
			local dungeonName = DungeonConfig.instance:getEpisodeCO(openCO.episodeId).name
			local name = dungeonDisplay .. dungeonName

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(key, 1)
				PeiShiTaController.instance:enterEpisodeLevelView()
			end, nil, nil, nil, nil, nil, name)
		end
	end
end

function VersionActivity4_1PeiShiTaEnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function VersionActivity4_1PeiShiTaEnterView:everySecondCall()
	self:_refreshTime()
	self:_freshLockStatus()
end

function VersionActivity4_1PeiShiTaEnterView:_freshLockStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)

	gohelper.setActive(self._btnEnter.gameObject, status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLocked.gameObject, status == ActivityEnum.ActivityStatus.NotUnlock)
end

function VersionActivity4_1PeiShiTaEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			self._txtLimitTime.text = dateStr
		end
	end
end

return VersionActivity4_1PeiShiTaEnterView
