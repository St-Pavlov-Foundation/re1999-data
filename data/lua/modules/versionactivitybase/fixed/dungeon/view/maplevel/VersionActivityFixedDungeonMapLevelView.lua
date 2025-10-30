﻿-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/maplevel/VersionActivityFixedDungeonMapLevelView.lua

module("modules.versionactivitybase.fixed.dungeon.view.maplevel.VersionActivityFixedDungeonMapLevelView", package.seeall)

local VersionActivityFixedDungeonMapLevelView = class("VersionActivityFixedDungeonMapLevelView", BaseView)
local OPEN_ANIM_TIME = 0.4
local UNLOCK_ANIM_TIME = 2.7

function VersionActivityFixedDungeonMapLevelView:onInitView()
	self.goVersionActivity = gohelper.findChild(self.viewGO, "anim/versionactivity")
	self.animator = self.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	self.animatorPlayer = SLFramework.AnimatorPlayer.Get(self.goVersionActivity)
	self.animationEventWrap = self.goVersionActivity:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._simageactivitynormalbg = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	self._simageactivityhardbg = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	self._txtmapName = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	self._txtmapNameEn = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	self._txtmapNum = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	self._txtmapChapterIndex = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_mapChapterIndex")
	self._gonormaleye = gohelper.findChild(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_normal")
	self._gohardeye = gohelper.findChild(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_hard")
	self._imagestar1 = gohelper.findChildImage(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star1")
	self._imagestar2 = gohelper.findChildImage(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star2")
	self._goswitch = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch")
	self._gotype1 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	self._gotype2 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	self._gotype3 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	self._gotype4 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	self._gotype0 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	self._gorecommend = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_recommend")
	self._txtrecommendlv = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/content/#go_recommend/txt/#txt_recommendlv")
	self._txtactivitydesc = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	self._gorewards = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_rewards")
	self._goactivityrewarditem = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_rewards/rewardList/#go_activityrewarditem")
	self._btnactivityreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/#go_rewards/#btn_activityreward")
	self._gonorewards = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_norewards")

	local goStartBtnRoot = gohelper.findChild(self.viewGO, "anim/versionactivity/right/startBtn")

	self.startBtnAnimator = goStartBtnRoot:GetComponent(typeof(UnityEngine.Animator))
	self._btnnormalStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	self._txtusepowernormal = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_usepowernormal")
	self._txtnorstarttext = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	self._txtnorstarttexten = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttexten")
	self._btnhardStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	self._txtusepowerhard = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	self._btnlockStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_lock")
	self._simagepower = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/right/startBtn/#simage_power")
	self._btnreplayStory = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory")
	self._gorighttop = gohelper.findChild(self.viewGO, "anim/#go_righttop")
	self._golefttop = gohelper.findChild(self.viewGO, "anim/#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedDungeonMapLevelView:addEvents()
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self._btnleftarrow:AddClickListener(self._btnleftarrowOnClick, self)
	self._btnrightarrow:AddClickListener(self._btnrightarrowOnClick, self)
	self._btnactivityreward:AddClickListener(self._btnactivityrewardOnClick, self)
	self._btnnormalStart:AddClickListener(self._btnnormalStartOnClick, self)
	self._btnhardStart:AddClickListener(self._btnhardStartOnClick, self)
	self._btnlockStart:AddClickListener(self._btnlockStartOnClick, self)
	self._btnreplayStory:AddClickListener(self._btnreplayStoryOnClick, self)
	self.animationEventWrap:AddEventListener("refresh", self.refreshUI, self)
end

function VersionActivityFixedDungeonMapLevelView:removeEvents()
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self._btnleftarrow:RemoveClickListener()
	self._btnrightarrow:RemoveClickListener()
	self._btnactivityreward:RemoveClickListener()
	self._btnnormalStart:RemoveClickListener()
	self._btnhardStart:RemoveClickListener()
	self._btnlockStart:RemoveClickListener()
	self._btnreplayStory:RemoveClickListener()
	self.animationEventWrap:RemoveAllEventListener()
end

function VersionActivityFixedDungeonMapLevelView:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:refreshCostPower()
end

function VersionActivityFixedDungeonMapLevelView:_btnleftarrowOnClick()
	local isHardMode = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	if isHardMode or #self.mode2EpisodeDict == 1 or self.modeIndex <= 1 then
		return
	end

	self.modeIndex = self.modeIndex - 1

	self:refreshUIByMode(self.modeList[self.modeIndex])
end

function VersionActivityFixedDungeonMapLevelView:_btnrightarrowOnClick()
	local isHardMode = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	if isHardMode or #self.mode2EpisodeDict == 1 or self.modeIndex >= #self.modeList then
		return
	end

	self.modeIndex = self.modeIndex + 1

	self:refreshUIByMode(self.modeList[self.modeIndex])
end

function VersionActivityFixedDungeonMapLevelView:refreshUIByMode(mode)
	if self.mode == mode then
		return
	end

	self.animator:Play(UIAnimationName.Switch, 0, 0)

	self.mode = mode
	self.showEpisodeCo = self.mode2EpisodeDict[self.mode]
	self.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(self.showEpisodeCo.id)

	if not self.showEpisodeMo then
		self.showEpisodeMo = UserDungeonMO.New()

		self.showEpisodeMo:initFromManual(self.showEpisodeCo.chapterId, self.showEpisodeCo.id, 0, 0)
	end
end

function VersionActivityFixedDungeonMapLevelView:_btnactivityrewardOnClick()
	DungeonController.instance:openDungeonRewardView(self.showEpisodeCo)
end

function VersionActivityFixedDungeonMapLevelView:_btnnormalStartOnClick()
	if self.modeCanFight then
		self:startBattle()
	else
		self:_btnlockStartOnClick()
	end
end

function VersionActivityFixedDungeonMapLevelView:_btnhardStartOnClick()
	self:startBattle()
end

function VersionActivityFixedDungeonMapLevelView:startBattle()
	if self.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		local skipStory = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SkipStroy) or self.showEpisodeCo.beforeStory == 0

		if skipStory then
			self:_playSkipMainStory()
		else
			self:_playMainStory()
		end

		return
	end

	if self.isSpecialEpisode then
		self.lastEpisodeSelectModeDict[tostring(self.specialEpisodeId)] = self.mode

		local prefsKey = VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
		local strLastSelectMode = cjson.encode(self.lastEpisodeSelectModeDict)

		VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance:savePlayerPrefs(prefsKey, strLastSelectMode)
	end

	if DungeonModel.instance:hasPassLevelAndStory(self.showEpisodeCo.id) then
		self:_enterFight()

		return
	end

	if self.showEpisodeCo.beforeStory > 0 then
		if not StoryModel.instance:isStoryFinished(self.showEpisodeCo.beforeStory) then
			self:_playStoryAndEnterFight(self.showEpisodeCo.beforeStory)

			return
		end

		if self.showEpisodeMo.star <= DungeonEnum.StarType.None then
			self:_enterFight()

			return
		end

		if self.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(self.showEpisodeCo.afterStory) then
			self:playAfterStory(self.showEpisodeCo.afterStory)

			return
		end
	end

	self:_enterFight()
end

function VersionActivityFixedDungeonMapLevelView:_playSkipMainStory()
	DungeonRpc.instance:sendStartDungeonRequest(self.showEpisodeCo.chapterId, self.showEpisodeCo.id)
	self:onStoryFinished()
end

function VersionActivityFixedDungeonMapLevelView:_playMainStory()
	DungeonRpc.instance:sendStartDungeonRequest(self.showEpisodeCo.chapterId, self.showEpisodeCo.id)

	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStory(self.showEpisodeCo.beforeStory, param, self.onStoryFinished, self)
end

function VersionActivityFixedDungeonMapLevelView:onStoryFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	self:closeThis()
end

function VersionActivityFixedDungeonMapLevelView:_playStoryAndEnterFight(storyId)
	if StoryModel.instance:isStoryFinished(storyId) then
		self:_enterFight()

		return
	end

	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStory(storyId, param, self._enterFight, self)
end

function VersionActivityFixedDungeonMapLevelView:_enterFight()
	DungeonFightController.instance:enterFight(self.showEpisodeCo.chapterId, self.showEpisodeCo.id, 1)
end

function VersionActivityFixedDungeonMapLevelView:playAfterStory(storyId)
	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStory(storyId, param, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		self:closeThis()
	end, self)
end

function VersionActivityFixedDungeonMapLevelView:_btnlockStartOnClick()
	local preModeName = self:getPreModeName()

	GameFacade.showToast(ToastEnum.VersionActivityCanFight, preModeName)
end

function VersionActivityFixedDungeonMapLevelView:getPreModeName()
	local modeIndex = self.modeIndex - 1
	local mode = self.modeList[modeIndex]

	if not mode then
		logWarn("not modeIndex mode : " .. modeIndex)

		return ""
	end

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[mode])
end

function VersionActivityFixedDungeonMapLevelView:_btnreplayStoryOnClick()
	if not self.storyIdList or #self.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(self.storyIdList)

	local param = {}

	param.isLeiMiTeActivityStory = true

	StoryController.instance:resetStoryParam(param)
end

function VersionActivityFixedDungeonMapLevelView:_editableInitView()
	self.rewardItems = {}
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	gohelper.setActive(self._goactivityrewarditem, false)
	gohelper.setActive(self._gonormaleye, false)
	gohelper.setActive(self._gohardeye, false)

	self.lockTypeAnimator = self._gotype0:GetComponent(typeof(UnityEngine.Animator))
	self.txtLockType = gohelper.findChildText(self._gotype0, "txt")
	self.lockTypeIconGo = gohelper.findChild(self._gotype0, "txt/icon")
	self.leftArrowLight = gohelper.findChild(self._btnleftarrow.gameObject, "left_arrow")
	self.leftArrowDisable = gohelper.findChild(self._btnleftarrow.gameObject, "left_arrow_disable")
	self.rightArrowLight = gohelper.findChild(self._btnrightarrow.gameObject, "right_arrow")
	self.rightArrowDisable = gohelper.findChild(self._btnrightarrow.gameObject, "right_arrow_disable")

	self:initLocalEpisodeMode()
end

function VersionActivityFixedDungeonMapLevelView:initLocalEpisodeMode()
	local unlockModePrefsKey = VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion)
	local strLastUnlockModeValue = dungeonController.instance:getPlayerPrefs(unlockModePrefsKey, "")

	self.unlockedEpisodeModeDict = dungeonController.instance:loadDictFromStr(strLastUnlockModeValue)

	local lastSelectModePrefsKey = VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
	local strLastSelectModeValue = dungeonController.instance:getPlayerPrefs(lastSelectModePrefsKey, "")

	self.lastEpisodeSelectModeDict = dungeonController.instance:loadDictFromStr(strLastSelectModeValue)
end

function VersionActivityFixedDungeonMapLevelView:onUpdateParam()
	self:onOpen()
	self.animator:Play(UIAnimationName.Open, 0, 0)
end

function VersionActivityFixedDungeonMapLevelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	self:initViewParam()
	self:initMode()
	self:markSelectEpisode()
	self:refreshStoryIdList()
	self:refreshBg()
	self:refreshUI()
	self.animator:Play(UIAnimationName.Open, 0, 0)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, self.viewGO)
end

function VersionActivityFixedDungeonMapLevelView:initViewParam()
	self.originEpisodeId = self.viewParam.episodeId
	self.originEpisodeConfig = DungeonConfig.instance:getEpisodeCO(self.originEpisodeId)
	self.isFromJump = self.viewParam.isJump
	self.index = VersionActivityFixedDungeonConfig.instance:getEpisodeIndex(self.originEpisodeId)

	self.viewContainer:setOpenedEpisodeId(self.originEpisodeId)

	self.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.originEpisodeId)
	self.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(self.originEpisodeId)
end

function VersionActivityFixedDungeonMapLevelView:initMode()
	self.mode = ActivityConfig.instance:getChapterIdMode(self.originEpisodeConfig.chapterId)
	self.modeIndex = 1

	if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	self.modeList = {
		VersionActivityDungeonBaseEnum.DungeonMode.Story,
		VersionActivityDungeonBaseEnum.DungeonMode.Story2,
		VersionActivityDungeonBaseEnum.DungeonMode.Story3
	}

	local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self.originEpisodeConfig)

	self.mode2EpisodeDict = {}

	for _, episodeCo in ipairs(episodeList) do
		local chapterMode = ActivityConfig.instance:getChapterIdMode(episodeCo.chapterId)

		self.mode2EpisodeDict[chapterMode] = episodeCo
	end

	self.isSpecialEpisode = #episodeList > 1
	self.specialEpisodeId = episodeList[1].id

	if not self.isSpecialEpisode then
		return
	end

	if self.isFromJump then
		self:checkNeedPlayModeUnLockAnimation()
	else
		local episodeCo

		for i = #episodeList, 1, -1 do
			episodeCo = episodeList[i]

			if DungeonModel.instance:hasPassLevelAndStory(episodeCo.preEpisode) then
				self.mode = self.modeList[i]

				break
			end
		end

		self:checkNeedPlayModeUnLockAnimation()

		if not self.needPlayUnlockModeAnimation then
			self.mode = self.lastEpisodeSelectModeDict[tostring(self.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story
		end
	end

	for index, mode in ipairs(self.modeList) do
		if mode == self.mode then
			self.modeIndex = index

			break
		end
	end

	self.showEpisodeCo = self.mode2EpisodeDict[self.mode]
	self.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(self.showEpisodeCo.id)

	if not self.showEpisodeMo then
		self.showEpisodeMo = UserDungeonMO.New()

		self.showEpisodeMo:initFromManual(self.showEpisodeCo.chapterId, self.showEpisodeCo.id, 0, 0)
	end
end

function VersionActivityFixedDungeonMapLevelView:checkNeedPlayModeUnLockAnimation()
	local isStoryMode = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story
	local isHardMode = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	if isHardMode or self.mode == isStoryMode then
		self.needPlayUnlockModeAnimation = false
	else
		local unLockedMode = self.unlockedEpisodeModeDict[tostring(self.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story

		self.needPlayUnlockModeAnimation = unLockedMode < self.mode
	end
end

function VersionActivityFixedDungeonMapLevelView:markSelectEpisode()
	if self.originEpisodeConfig.type == DungeonEnum.EpisodeType.Normal then
		VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(self.originEpisodeConfig.chapterId, self.originEpisodeId)
	end
end

function VersionActivityFixedDungeonMapLevelView:refreshStoryIdList()
	local isStoryEpisode = self.originEpisodeConfig.type == DungeonEnum.EpisodeType.Story
	local isHardMode = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	if isStoryEpisode or isHardMode then
		self.storyIdList = nil

		return
	end

	local checkStoryEpisodeCfg = self.originEpisodeConfig
	local storyMode = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local storyModeEpisodeCfg = self.mode2EpisodeDict and self.mode2EpisodeDict[storyMode]

	if storyModeEpisodeCfg then
		checkStoryEpisodeCfg = storyModeEpisodeCfg
	end

	self.storyIdList = {}

	local beforeStory = checkStoryEpisodeCfg.beforeStory

	if beforeStory > 0 and StoryModel.instance:isStoryHasPlayed(beforeStory) then
		table.insert(self.storyIdList, beforeStory)
	end

	local afterStory = checkStoryEpisodeCfg.afterStory

	if afterStory > 0 and StoryModel.instance:isStoryHasPlayed(afterStory) then
		table.insert(self.storyIdList, afterStory)
	end
end

function VersionActivityFixedDungeonMapLevelView:refreshBg()
	gohelper.setActive(self._simageactivitynormalbg.gameObject, self.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(self._simageactivityhardbg.gameObject, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function VersionActivityFixedDungeonMapLevelView:refreshUI()
	self:refreshModeCanFight()
	self:refreshEpisodeTextInfo()
	self:refreshStar()
	self:refreshMode()
	self:refreshArrow()
	self:refreshReward()
	self:refreshStartBtn()
	self:refreshEye()

	if self.needPlayUnlockModeAnimation then
		TaskDispatcher.runDelay(self.playModeUnlockAnimation, self, OPEN_ANIM_TIME)
	end
end

function VersionActivityFixedDungeonMapLevelView:refreshModeCanFight()
	if self.showEpisodeCo.preEpisode == 0 then
		self.modeCanFight = true

		return
	end

	self.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(self.showEpisodeCo.preEpisode)
end

function VersionActivityFixedDungeonMapLevelView:refreshEpisodeTextInfo()
	local chapterCo = DungeonConfig.instance:getChapterCO(self.showEpisodeCo.chapterId)
	local targetConfig

	if chapterCo.id == VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).DungeonChapterId.Story then
		targetConfig = self.showEpisodeCo
	else
		targetConfig = VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(self.showEpisodeCo.id)
	end

	self._txtmapName.text = self:buildEpisodeName(targetConfig)

	local txtColor = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	self._txtmapNameEn.text = self:buildColorText(targetConfig.name_En, txtColor)
	self._txtmapNum.text = self:buildColorText(string.format("%02d", self.index), txtColor)
	self._txtmapChapterIndex.text = self:buildColorText(chapterCo.chapterIndex .. " .", txtColor)
	self._txtactivitydesc.text = targetConfig.desc

	local recommendLevel = DungeonHelper.getEpisodeRecommendLevel(self.showEpisodeCo.id)
	local battleCo = lua_battle.configDict[self.showEpisodeCo.battleId]
	local firstCattleCo = lua_battle.configDict[self.showEpisodeCo.firstBattleId]
	local isFirstBalance = firstCattleCo and not string.nilorempty(firstCattleCo.balance)
	local isBalance = battleCo and not string.nilorempty(battleCo.balance)
	local isPass = DungeonModel.instance:hasPassLevel(self.showEpisodeCo.id)

	gohelper.setActive(self._gorecommend, recommendLevel > 0)

	if (isFirstBalance or isBalance) and not isPass then
		self._txtrecommendlv.text = "---"
	elseif recommendLevel > 0 then
		self._txtrecommendlv.text = HeroConfig.instance:getCommonLevelDisplay(recommendLevel)
	end
end

function VersionActivityFixedDungeonMapLevelView:buildEpisodeName(episodeCo)
	local name = episodeCo.name
	local firstName = GameUtil.utf8sub(name, 1, 1)
	local remainName = ""
	local nameLen = GameUtil.utf8len(name)

	if nameLen > 1 then
		remainName = GameUtil.utf8sub(name, 2, nameLen - 1)
	end

	local txtColor = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	return self:buildColorText(string.format("<size=112>%s</size>%s", firstName, remainName), txtColor)
end

function VersionActivityFixedDungeonMapLevelView:buildColorText(text, color)
	return string.format("<color=%s>%s</color>", color, text)
end

function VersionActivityFixedDungeonMapLevelView:refreshStar()
	local normalEpisodeId = self.showEpisodeCo.id
	local passStory = normalEpisodeId and DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)
	local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)

	self:setStarImage(self._imagestar1, passStory, normalEpisodeId)

	if string.nilorempty(advancedConditionText) then
		gohelper.setActive(self._imagestar2.gameObject, false)
	else
		gohelper.setActive(self._imagestar2.gameObject, true)
		self:setStarImage(self._imagestar2, passStory and self.showEpisodeMo.star >= DungeonEnum.StarType.Advanced, normalEpisodeId)
	end
end

function VersionActivityFixedDungeonMapLevelView:setStarImage(image, light, episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local starTypeData = VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).EpisodeStarType[episodeConfig.chapterId]

	if light then
		local starType = starTypeData.light

		VersionActivityFixedHelper.setDungeonSprite(image, starType, true, self._bigVersion, self._smallVersion)
	else
		local starType = starTypeData.empty

		VersionActivityFixedHelper.setDungeonSprite(image, starType, true, self._bigVersion, self._smallVersion)
	end
end

function VersionActivityFixedDungeonMapLevelView:refreshMode()
	gohelper.setActive(self._gotype1, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(self._gotype2, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(self._gotype3, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(self._gotype4, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	local needShowLockNode = not self.modeCanFight or self.needPlayUnlockModeAnimation

	gohelper.setActive(self._gotype0, needShowLockNode)

	if needShowLockNode then
		self.lockTypeAnimator.enabled = true
		self.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[self.mode])

		if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2 then
			SLFramework.UGUI.GuiHelper.SetColor(self.txtLockType, "#757563")
		elseif self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3 then
			SLFramework.UGUI.GuiHelper.SetColor(self.txtLockType, "#757563")
		end
	end

	gohelper.setActive(self.lockTypeIconGo, needShowLockNode)
end

function VersionActivityFixedDungeonMapLevelView:refreshArrow()
	local showArrow = self.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and self.isSpecialEpisode

	gohelper.setActive(self._btnleftarrow.gameObject, showArrow)
	gohelper.setActive(self._btnrightarrow.gameObject, showArrow)

	if showArrow then
		gohelper.setActive(self.leftArrowLight, self.modeIndex ~= 1)
		gohelper.setActive(self.leftArrowDisable, self.modeIndex == 1)

		local isLast = #self.modeList == self.modeIndex

		gohelper.setActive(self.rightArrowLight, not isLast)
		gohelper.setActive(self.rightArrowDisable, isLast)
	end
end

function VersionActivityFixedDungeonMapLevelView:refreshReward()
	local rewardList = {}
	local firstRewardIndex = 0
	local advancedRewardIndex = 0

	if self.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeAdvancedBonus(self.showEpisodeCo.id))

		advancedRewardIndex = #rewardList
	end

	if self.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeFirstBonus(self.showEpisodeCo.id))

		firstRewardIndex = #rewardList
	end

	tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeReward(self.showEpisodeCo.id))
	tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeRewardDisplayList(self.showEpisodeCo.id))

	local rewardCount = #rewardList

	gohelper.setActive(self._gorewards, rewardCount > 0)
	gohelper.setActive(self._gonorewards, rewardCount == 0)

	if rewardCount == 0 then
		return
	end

	local count = math.min(#rewardList, 3)
	local reward, rewardItem

	for i = 1, count do
		rewardItem = self.rewardItems[i]

		if not rewardItem then
			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.cloneInPlace(self._goactivityrewarditem, "item" .. i)
			rewardItem.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(rewardItem.go, "itemicon"))
			rewardItem.gonormal = gohelper.findChild(rewardItem.go, "rare/#go_rare1")
			rewardItem.gofirst = gohelper.findChild(rewardItem.go, "rare/#go_rare2")
			rewardItem.goadvance = gohelper.findChild(rewardItem.go, "rare/#go_rare3")
			rewardItem.gofirsthard = gohelper.findChild(rewardItem.go, "rare/#go_rare4")
			rewardItem.txtnormal = gohelper.findChildText(rewardItem.go, "rare/#go_rare1/txt")

			table.insert(self.rewardItems, rewardItem)
		end

		reward = rewardList[i]

		gohelper.setActive(rewardItem.gonormal, false)
		gohelper.setActive(rewardItem.gofirst, false)
		gohelper.setActive(rewardItem.goadvance, false)
		gohelper.setActive(rewardItem.gofirsthard, false)

		local goFirstRare, goAdvanceRare
		local quantity = reward[3]
		local isShowCount = true

		if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
			goFirstRare = rewardItem.gofirsthard
			goAdvanceRare = rewardItem.goadvance
		else
			goFirstRare = rewardItem.gofirst
			goAdvanceRare = rewardItem.goadvance
		end

		if i <= advancedRewardIndex then
			gohelper.setActive(goAdvanceRare, true)
		elseif i <= firstRewardIndex then
			gohelper.setActive(goFirstRare, true)
		else
			gohelper.setActive(rewardItem.gonormal, true)

			local tagType = reward[3]

			isShowCount = true

			if reward.tagType then
				tagType = reward.tagType
				isShowCount = quantity ~= 0
			elseif #reward >= 4 then
				quantity = reward[4]
			else
				isShowCount = false
			end

			rewardItem.txtnormal.text = luaLang("dungeon_prob_flag" .. tagType)
		end

		rewardItem.iconItem:setMOValue(reward[1], reward[2], quantity, nil, true)
		rewardItem.iconItem:setCountFontSize(40)
		rewardItem.iconItem:setHideLvAndBreakFlag(true)
		rewardItem.iconItem:hideEquipLvAndBreak(true)
		rewardItem.iconItem:isShowCount(isShowCount)
		gohelper.setActive(rewardItem.go, true)
	end

	for i = count + 1, #self.rewardItems do
		gohelper.setActive(self.rewardItems[i].go, false)
	end
end

function VersionActivityFixedDungeonMapLevelView:refreshStartBtn()
	self:refreshCostPower()

	local currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local powerIcon = ResUrl.getCurrencyItemIcon(currencyCo.icon .. "_btn")

	self._simagepower:LoadImage(powerIcon)

	local isHardMode = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard
	local notHardMode = not isHardMode

	gohelper.setActive(self._btnnormalStart.gameObject, self.modeCanFight and notHardMode)
	gohelper.setActive(self._btnhardStart.gameObject, isHardMode)
	gohelper.setActive(self._btnlockStart.gameObject, not self.modeCanFight or self.needPlayUnlockModeAnimation)

	local hasStory = self.storyIdList and #self.storyIdList > 0
	local storyMode = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local storyModeEpisodeCfg = self.mode2EpisodeDict and self.mode2EpisodeDict[storyMode]
	local checkPassEpisodeId = storyModeEpisodeCfg and storyModeEpisodeCfg.id or self.originEpisodeConfig.id
	local hasPassLevelAndStory = DungeonModel.instance:hasPassLevelAndStory(checkPassEpisodeId)

	gohelper.setActive(self._btnreplayStory.gameObject, hasPassLevelAndStory and hasStory)

	if isHardMode then
		return
	end

	if self.modeCanFight then
		local hasPassLevel = DungeonModel.instance:hasPassLevel(self.showEpisodeCo.id)
		local isStoryFinished = StoryModel.instance:isStoryFinished(self.showEpisodeCo.afterStory)

		if hasPassLevel and self.showEpisodeCo.afterStory > 0 and not isStoryFinished then
			self._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")

			recthelper.setAnchorX(self._txtnorstarttext.gameObject.transform, 0)
			recthelper.setAnchorX(self._txtnorstarttexten.gameObject.transform, 0)
			gohelper.setActive(self._txtusepowernormal.gameObject, false)
			gohelper.setActive(self._simagepower.gameObject, false)
		else
			self._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")

			recthelper.setAnchorX(self._txtnorstarttext.gameObject.transform, 121)
			recthelper.setAnchorX(self._txtnorstarttexten.gameObject.transform, 121)
			gohelper.setActive(self._txtusepowernormal.gameObject, true)
			gohelper.setActive(self._simagepower.gameObject, true)
		end
	else
		gohelper.setActive(self._simagepower.gameObject, false)
		gohelper.setActive(self._txtusepowernormal.gameObject, false)
	end
end

function VersionActivityFixedDungeonMapLevelView:refreshCostPower()
	local cost = 0

	if not string.nilorempty(self.showEpisodeCo.cost) then
		cost = string.splitToNumber(self.showEpisodeCo.cost, "#")[3]
	end

	self._txtusepowernormal.text = "-" .. cost
	self._txtusepowerhard.text = "-" .. cost

	if cost <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#FFEAEA")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#C44945")
	end
end

function VersionActivityFixedDungeonMapLevelView:refreshEye()
	local showEye = self.originEpisodeConfig.displayMark == 1

	if not showEye then
		gohelper.setActive(self._gonormaleye, false)
		gohelper.setActive(self._gohardeye, false)

		return
	end

	local isHard = self.originEpisodeConfig.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).DungeonChapterId.Hard

	gohelper.setActive(self._gonormaleye, not isHard)
	gohelper.setActive(self._gohardeye, isHard)
end

function VersionActivityFixedDungeonMapLevelView:playModeUnlockAnimation()
	if not self.needPlayUnlockModeAnimation then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	self:_playModeUnLockAnimation(UIAnimationName.Unlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapLevelViewPlayUnlockAnim)
	TaskDispatcher.runDelay(self.onModeUnlockAnimationPlayDone, self, UNLOCK_ANIM_TIME)
end

function VersionActivityFixedDungeonMapLevelView:_playModeUnLockAnimation(animationName)
	self.lockTypeAnimator.enabled = true

	self.lockTypeAnimator:Play(animationName)
	self.startBtnAnimator:Play(animationName)
end

function VersionActivityFixedDungeonMapLevelView:onModeUnlockAnimationPlayDone()
	self:_playModeUnLockAnimation(UIAnimationName.Idle)

	self.unlockedEpisodeModeDict[tostring(self.specialEpisodeId)] = self.mode

	local prefsKey = VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local strLastUnlockMode = cjson.encode(self.unlockedEpisodeModeDict)

	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:savePlayerPrefs(prefsKey, strLastUnlockMode)

	self.needPlayUnlockModeAnimation = false

	self:refreshMode()
	self:refreshStartBtn()
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapLevelViewPlayUnlockAnim)
end

function VersionActivityFixedDungeonMapLevelView:onClose()
	TaskDispatcher.cancelTask(self.playModeUnlockAnimation, self)
	TaskDispatcher.cancelTask(self.onModeUnlockAnimationPlayDone, self)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapLevelViewPlayUnlockAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivityFixedDungeonMapLevelView:onDestroyView()
	self.rewardItems = nil

	self._simagepower:UnLoadImage()
end

return VersionActivityFixedDungeonMapLevelView
