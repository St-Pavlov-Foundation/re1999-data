-- chunkname: @modules/logic/versionactivity4_1/enter/view/subview/VersionActivity4_1ArcadeSurvivorEnterView.lua

module("modules.logic.versionactivity4_1.enter.view.subview.VersionActivity4_1ArcadeSurvivorEnterView", package.seeall)

local VersionActivity4_1ArcadeSurvivorEnterView = class("VersionActivity4_1ArcadeSurvivorEnterView", VersionActivityEnterBaseSubView)

function VersionActivity4_1ArcadeSurvivorEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._btnachievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_achievementpreview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity4_1ArcadeSurvivorEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnachievement:AddClickListener(self._btnachievementOnClick, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnExitHallView, self._onExitHallView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function VersionActivity4_1ArcadeSurvivorEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnachievement:RemoveClickListener()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnExitHallView, self._onExitHallView, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function VersionActivity4_1ArcadeSurvivorEnterView:_btnEnterOnClick()
	if self._animPlayer then
		self._animPlayer:Play(UIAnimationName.Close, self._enterAfterPlayAnim, self)
	else
		self:_enterAfterPlayAnim()
	end

	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnReadyEnterHallView)
end

function VersionActivity4_1ArcadeSurvivorEnterView:_enterAfterPlayAnim()
	ArcadeSurvivorGameController.instance:restartGameOrEnterHall()
end

function VersionActivity4_1ArcadeSurvivorEnterView:_btnLockedOnClick()
	GameFacade.showToast(ToastEnum.ActivityNotOpen)
end

function VersionActivity4_1ArcadeSurvivorEnterView:_btnachievementOnClick()
	local actId = ArcadeSurvivorModel.instance:getAct247Id()
	local actCfg = ActivityConfig.instance:getActivityCo(actId)

	if actCfg then
		local jumpId = actCfg.achievementJumpId

		JumpController.instance:jump(jumpId)
	end
end

function VersionActivity4_1ArcadeSurvivorEnterView:_onExitHallView()
	self._animPlayer:Play(UIAnimationName.Open, nil, nil)
end

function VersionActivity4_1ArcadeSurvivorEnterView:_onCloseViewFinish(viewName)
	local isOpenHallView = ViewMgr.instance:isOpen(ViewName.ArcadeSurvivorHallView)

	if viewName == ViewName.ArcadeSurvivorGameView and not isOpenHallView then
		self._animPlayer:Play(UIAnimationName.Open, nil, nil)
	end
end

function VersionActivity4_1ArcadeSurvivorEnterView:_editableInitView()
	local desc = ""
	local redDotId = 0
	local actId = ArcadeSurvivorModel.instance:getAct247Id()
	local actCfg = ActivityConfig.instance:getActivityCo(actId)

	if actCfg then
		desc = actCfg.actDesc
		redDotId = actCfg.redDotId
	end

	self._txtDescr.text = desc

	if redDotId ~= 0 then
		gohelper.setActive(self._goreddot, true)
		RedDotController.instance:addRedDot(self._goreddot, redDotId)
	end

	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
end

function VersionActivity4_1ArcadeSurvivorEnterView:onOpen()
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(UIAnimationName.Open, 0, 0)
	end

	self:everySecondCall()
	self:beginPerSecondRefresh()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_game_open)
end

function VersionActivity4_1ArcadeSurvivorEnterView:onEnterVideoFinished()
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(UIAnimationName.Open, 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_game_open)
end

function VersionActivity4_1ArcadeSurvivorEnterView:everySecondCall()
	self:refreshTime()
end

function VersionActivity4_1ArcadeSurvivorEnterView:refreshTime()
	local offsetSecond = 0
	local actId = ArcadeSurvivorModel.instance:getAct247Id()
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if actInfoMo then
		offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	end

	if offsetSecond > 0 then
		local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		self._txtLimitTime.text = dateStr

		gohelper.setActive(self._txtLimitTime, true)
	else
		gohelper.setActive(self._txtLimitTime, false)
	end

	local isOpen = ArcadeSurvivorModel.instance:isAct247Open()

	gohelper.setActive(self._btnEnter, isOpen)
	gohelper.setActive(self._btnLocked, not isOpen)
end

return VersionActivity4_1ArcadeSurvivorEnterView
