-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_HandBookEnemyInfoView.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_HandBookEnemyInfoView", package.seeall)

local V4a1_BossRush_HandBookEnemyInfoView = class("V4a1_BossRush_HandBookEnemyInfoView", V3a2_BossRush_HandBookEnemyInfoView)

function V4a1_BossRush_HandBookEnemyInfoView:_editableInitView()
	V4a1_BossRush_HandBookEnemyInfoView.super._editableInitView(self)

	self._goroot = gohelper.findChild(self.viewGO, "#go_right_container")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_right_container/#go_Locked")
	self._btnreview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right_container/#go_Locked/#btn_review")
	self._btnreviewgrey = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right_container/#go_Locked/#btn_reviewgrey")
	self._gotimes = gohelper.findChild(self.viewGO, "#go_right_container/#go_Locked/#go_times")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_right_container/#go_Locked/#go_times/#txt_num")
	self._gotips = gohelper.findChild(self.viewGO, "#go_right_container/#go_Locked/#go_times/#go_tips")
	self._txt = gohelper.findChildText(self.viewGO, "#go_right_container/#go_Locked/#go_times/#go_tips/#txt")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right_container/#btn_start/click")
	self._gotart = gohelper.findChild(self.viewGO, "#go_right_container/#btn_start")
	self._btnTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right_container/#go_Locked/#go_times")
	self._animator = self._goroot:GetComponent(typeof(UnityEngine.Animator))
	self._skillAnchorY = recthelper.getAnchorY(self._goskillcontainer.transform)
	self._enemyInfoHeight = recthelper.getHeight(self._scrollenemyinfo.transform)
	self._txt.text = luaLang("act128_season_unlockcount_tips")

	gohelper.setActive(self._gotips, false)
end

function V4a1_BossRush_HandBookEnemyInfoView:addEvents()
	V4a1_BossRush_HandBookEnemyInfoView.super.addEvents(self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onSelectHandBookSeason, self._onSelectHandBookSeason, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128UnlockMonsterReply, self._onReceiveAct128UnlockMonsterReply, self)
	self._btnStart:AddClickListener(self._btnstartOnClick, self)
	self._btnTip:AddClickListener(self._btntipOnClick, self)
	self._btnreview:AddClickListener(self._btnreviewOnClick, self)
	self._btnreviewgrey:AddClickListener(self._btnreviewgreyOnClick, self)
end

function V4a1_BossRush_HandBookEnemyInfoView:removeEvents()
	V4a1_BossRush_HandBookEnemyInfoView.super.removeEvents(self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.onSelectHandBookSeason, self._onSelectHandBookSeason, self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128UnlockMonsterReply, self._onReceiveAct128UnlockMonsterReply, self)
	self._btnStart:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnreview:RemoveClickListener()
	self._btnreviewgrey:RemoveClickListener()
end

function V4a1_BossRush_HandBookEnemyInfoView:_btnclaimOnClick()
	gohelper.setActive(self._goFly, false)

	local season = self._handBookMo.season
	local actId = V3a9_BossRushModel.instance:getActIdBySeason(season)

	BossRushRpc.instance:sendAct128GetExpRequest(actId, self.bossType, self._clickClaimCb, self)
end

function V4a1_BossRush_HandBookEnemyInfoView:_btnstartOnClick()
	V4a1_BossRushController.instance:openLevelReviewView(self._handBookMo)
end

function V4a1_BossRush_HandBookEnemyInfoView:_btntipOnClick()
	self._isShowTip = not self._isShowTip

	gohelper.setActive(self._gotips, self._isShowTip)
end

function V4a1_BossRush_HandBookEnemyInfoView:_btnreviewOnClick()
	GameFacade.showMessageBox(V4a1BossRushEnum.ReviewMessageBoxId, MsgBoxEnum.BoxType.Yes_No, self._yesCallback, nil, nil, self)
end

function V4a1_BossRush_HandBookEnemyInfoView:_btnreviewgreyOnClick()
	return
end

function V4a1_BossRush_HandBookEnemyInfoView:_yesCallback()
	local actId = self._handBookMo.actId
	local stage = self._handBookMo.stage
	local curActId = BossRushModel.instance:getActivityId()

	Activity128Rpc.instance:sendAct128UnlockMonsterRequest(curActId, actId, stage)
end

function V4a1_BossRush_HandBookEnemyInfoView:_onSelectHandBookSeason(season)
	return
end

function V4a1_BossRush_HandBookEnemyInfoView:_onReceiveAct128UnlockMonsterReply()
	gohelper.setActive(self._goUnlock, true)
	gohelper.setActive(self._goLocked, true)
	gohelper.setActive(self._gotart, true)
	TaskDispatcher.cancelTask(self.refreshSkill, self)
	TaskDispatcher.runDelay(self.refreshSkill, self, 0.5)
	self._animator:Play(V3a2BossRushEnum.AnimName.Unlock, 0, 0)
	AudioMgr.instance:trigger(BossRushAudioEnum.Audio.play_ui_settleaccounts_resources)
end

local btnOffst = 100

function V4a1_BossRush_HandBookEnemyInfoView:refreshSkill()
	local season = self._handBookMo.season
	local isCurSeason = V4a1_BossRushModel.instance:getCurSeason() == season
	local haveFight = self._handBookMo and self._handBookMo.haveFight
	local isShowBtn = haveFight and not isCurSeason

	gohelper.setActive(self._gotimes.gameObject, not haveFight and not isCurSeason)
	gohelper.setActive(self._gotart, isShowBtn)

	local count, total = V4a1_BossRushModel.instance:getSeasonUnlockCount()
	local lang = luaLang("act128_season_unlockcount")

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, count, total)

	gohelper.setActive(self._btnreview.gameObject, count > 0 and not haveFight and not isCurSeason)
	gohelper.setActive(self._btnreviewgrey.gameObject, count == 0 and not haveFight and not isCurSeason)
	gohelper.setActive(self._goUnlock, haveFight)
	gohelper.setActive(self._goLocked, not haveFight)

	if not haveFight then
		self._animator:Play(V3a2BossRushEnum.AnimName.Idle, 0, 0)

		return
	end

	self:refreshPassiveSkill()
	self:refreshSmallSkill()
	self:refreshSuperSkill()

	local hasSkill = not string.nilorempty(self.monsterConfig.activeSkill) or #self.monsterConfig.uniqueSkill > 0

	gohelper.setActive(self._gonoskill, not hasSkill)
	gohelper.setActive(self._goskill, hasSkill)

	local skillAnchorY = isShowBtn and self._skillAnchorY or self._skillAnchorY - btnOffst
	local enemyInfoHeight = isShowBtn and self._enemyInfoHeight or self._enemyInfoHeight + btnOffst

	recthelper.setAnchorY(self._goskillcontainer.transform, skillAnchorY)
	recthelper.setHeight(self._scrollenemyinfo.transform, enemyInfoHeight)
end

function V4a1_BossRush_HandBookEnemyInfoView:_refreshSeason()
	return
end

function V4a1_BossRush_HandBookEnemyInfoView:onClose()
	V4a1_BossRush_HandBookEnemyInfoView.super.onClose(self)
	TaskDispatcher.cancelTask(self.refreshSkill, self)
end

return V4a1_BossRush_HandBookEnemyInfoView
