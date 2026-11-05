-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewMainView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewMainView", package.seeall)

local GuessGameNewMainView = class("GuessGameNewMainView", BaseView)

function GuessGameNewMainView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "timebg/#txt_time")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_start")
	self._gofirsttip = gohelper.findChild(self.viewGO, "#go_firsttip")
	self._txtfirst = gohelper.findChildText(self.viewGO, "#go_firsttip/#txt_first")
	self._goprocess = gohelper.findChild(self.viewGO, "#go_process")
	self._simagereward = gohelper.findChildSingleImage(self.viewGO, "#go_process/#simage_reward")
	self._txtprogress = gohelper.findChildText(self.viewGO, "#go_process/#txt_progress")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_process/#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/Content")
	self._imagefill = gohelper.findChildImage(self.viewGO, "#go_process/#scroll_view/Viewport/Content/progressbg/#image_fill")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/Content/#go_rewarditem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewMainView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function GuessGameNewMainView:removeEvents()
	self._btnstart:RemoveClickListener()
end

function GuessGameNewMainView:_btnstartOnClick()
	GuessGameNewController.instance:openGuessGameNewPlayView()
end

function GuessGameNewMainView:_editableInitView()
	self._rewardItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function GuessGameNewMainView:_addSelfEvents()
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self:addEventCb(GuessGameNewController.instance, GuessGameNewEvent.OnFinishGameBackToMain, self._onGameGuessFinished, self)
	self:addEventCb(GuessGameController.instance, GuessGameEvent.OnReceiveAcceptReward, self._onRewardGet, self)
end

function GuessGameNewMainView:_removeSelfEvents()
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self:removeEventCb(GuessGameNewController.instance, GuessGameNewEvent.OnFinishGameBackToMain, self._onGameGuessFinished, self)
	self:removeEventCb(GuessGameController.instance, GuessGameEvent.OnReceiveAcceptReward, self._onRewardGet, self)
end

function GuessGameNewMainView:_onCheckActState()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function GuessGameNewMainView:_onGameGuessFinished()
	self:_refresh()
end

function GuessGameNewMainView:_onRewardGet()
	self:_refreshRewards()
end

function GuessGameNewMainView:onOpen()
	self._actId = VersionActivity4_1Enum.ActivityId.GuessGameNew

	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_fuleyuan_yure_whoosh)
	self:_refresh()
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
end

function GuessGameNewMainView:_refresh()
	self:_refreshUI()
	self:_refreshRewards()
end

function GuessGameNewMainView:_refreshUI()
	local isFirstShow = GuessGameNewModel.instance:isFirstShow(self._actId)

	gohelper.setActive(self._gofirsttip, isFirstShow)

	local curScore = GuessGameNewModel.instance:getTotalScore(self._actId)

	self._txtprogress.text = curScore

	if not self._score then
		self:_focusScore(curScore)
		self:_progressUpadate(curScore)

		self._score = curScore

		return
	end

	if self._score == curScore then
		return
	end

	self:_focusScore(curScore)
	self:_playProgrogress(self._score, curScore)

	self._score = curScore
end

local maxAnchorX = -1096
local minScore = 3600

function GuessGameNewMainView:_focusScore(score)
	local rewardCos = GuessGameNewConfig.instance:getBonusCos(self._actId)
	local totalScore = rewardCos[#rewardCos].coinNum
	local focusPosX = score <= minScore and 0 or score * maxAnchorX / totalScore

	recthelper.setAnchorX(self._gocontent.transform, focusPosX)
end

function GuessGameNewMainView:_playProgrogress(fromScore, toScore)
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(fromScore, toScore, 1, self._progressUpadate, self._progressFinished, self)
end

function GuessGameNewMainView:_progressUpadate(value)
	local rewardCos = GuessGameNewConfig.instance:getBonusCos(self._actId)
	local totalScore = rewardCos[#rewardCos].coinNum

	self._imagefill.fillAmount = value / totalScore
end

function GuessGameNewMainView:_progressFinished()
	return
end

function GuessGameNewMainView:_refreshRewards()
	local rewardCos = GuessGameNewConfig.instance:getBonusCos(self._actId)

	if not rewardCos then
		return
	end

	for i = 1, #rewardCos do
		if not self._rewardItems[i] then
			self._rewardItems[i] = GuessGameNewMainRewardItem.New()

			local go = gohelper.cloneInPlace(self._gorewarditem)

			self._rewardItems[i]:init(go)
		end

		self._rewardItems[i]:refresh(rewardCos[i])
	end
end

function GuessGameNewMainView:_refreshTime()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function GuessGameNewMainView:onClose()
	return
end

function GuessGameNewMainView:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self:_removeSelfEvents()
	TaskDispatcher.cancelTask(self._refreshTime, self)

	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item:destroy()
		end

		self._rewardItems = nil
	end
end

return GuessGameNewMainView
