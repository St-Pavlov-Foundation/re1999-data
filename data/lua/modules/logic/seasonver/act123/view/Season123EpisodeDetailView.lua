﻿-- chunkname: @modules/logic/seasonver/act123/view/Season123EpisodeDetailView.lua

module("modules.logic.seasonver.act123.view.Season123EpisodeDetailView", package.seeall)

local Season123EpisodeDetailView = class("Season123EpisodeDetailView", BaseView)

function Season123EpisodeDetailView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._simagestageicon = gohelper.findChildSingleImage(self.viewGO, "#go_info/left/#simage_stageicon")
	self._animatorRight = gohelper.findChildComponent(self.viewGO, "#go_info/right", typeof(UnityEngine.Animator))
	self._txtlevelnamecn = gohelper.findChildText(self.viewGO, "#go_info/left/#txt_levelnamecn")
	self._descScroll = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View")
	self._animScroll = self._descScroll:GetComponent(typeof(UnityEngine.Animator))
	self._descContent = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/Viewport/Content")
	self._goDescItem = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem")
	self._txtcurindex = gohelper.findChildText(self.viewGO, "#go_info/right/position/center/#txt_curindex")
	self._txtmaxindex = gohelper.findChildText(self.viewGO, "#go_info/right/position/center/#txt_maxindex")
	self._btnlast = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/position/#btn_last")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/position/#btn_next")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_info/right/#txt_desc")
	self._txtenemylv = gohelper.findChildText(self.viewGO, "#go_info/right/enemylv/enemylv/#txt_enemylv")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/btns/#btn_start")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/btns/#btn_reset")
	self._btnReplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/btns/#btn_storyreplay")
	self._gopart = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_part")
	self._gostage = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_part/#go_stage")
	self._gostagelvlitem = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_part/#go_stage/list/#go_stagelvlitem")
	self._gounlocktype1 = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype1")
	self._gounlocktype2 = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype2")
	self._gounlocktype3 = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype3")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._godecorate = gohelper.findChild(self.viewGO, "#go_info/right/decorate")
	self._gocenter = gohelper.findChild(self.viewGO, "#go_info/right/position/center")
	self._gopartempty = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_partempty")
	self._simageempty = gohelper.findChildSingleImage(self.viewGO, "#go_info/right/layout/#go_partempty/#simage_empty")
	self._goleftscrolltopmask = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/mask2")
	self._goreset = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_reset")
	self._txtresettime = gohelper.findChildText(self.viewGO, "#go_info/right/layout/#go_reset/#txt_title/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123EpisodeDetailView:addEvents()
	self._btnlast:AddClickListener(self._btnlastOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function Season123EpisodeDetailView:removeEvents()
	self._btnlast:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

function Season123EpisodeDetailView:_editableInitView()
	gohelper.setActive(self._gostagelvlitem, false)

	self._txtseasondesc = gohelper.findChildText(self.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem/txt_desc")
end

function Season123EpisodeDetailView:onDestroyView()
	Season123EpisodeDetailController.instance:onCloseView()
	self._simagestageicon:UnLoadImage()

	if self._showLvItems then
		for _, v in pairs(self._showLvItems) do
			v:destroy()
		end

		self._showLvItems = nil
	end
end

function Season123EpisodeDetailView:onOpen()
	self:addEventCb(Season123Controller.instance, Season123Event.DetailSwitchLayer, self.handleDetailSwitchLayer, self)
	self:addEventCb(Season123Controller.instance, Season123Event.RefreshDetailView, self.refreshShowInfo, self)
	self:addEventCb(Season123Controller.instance, Season123Event.ResetStageFinished, self.closeThis, self)
	Season123EpisodeDetailController.instance:onOpenView(self.viewParam.actId, self.viewParam.stage, self.viewParam.layer)

	local actMO = ActivityModel.instance:getActMO(self.viewParam.actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	local layer = Season123EpisodeDetailModel.instance.layer

	self:resetData()
	self:noAudioShowInfoByOpen()
	self._simageempty:LoadImage(Season123Controller.getSeasonIcon("kongzhuangtai.png", self.viewParam.actId))
end

function Season123EpisodeDetailView:onOpenFinish()
	local loadingViewName = Season123Controller.instance:getEpisodeLoadingViewName()

	ViewMgr.instance:closeView(loadingViewName, true)
end

function Season123EpisodeDetailView:onClose()
	TaskDispatcher.cancelTask(self._delayShowInfo, self)
end

function Season123EpisodeDetailView:handleDetailSwitchLayer(param)
	local isNext = param.isNext

	self._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	self._animScroll:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.cancelTask(self._delayShowInfo, self)
	TaskDispatcher.runDelay(self._delayShowInfo, self, 0.2)
end

function Season123EpisodeDetailView:_delayShowInfo()
	self:_showInfo()
end

function Season123EpisodeDetailView:refreshShowInfo()
	self:_showInfo()
end

function Season123EpisodeDetailView:_btnstartOnClick()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local episodeId = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer).episodeId

	Season123EpisodeDetailController.instance:checkEnterFightScene()
end

function Season123EpisodeDetailView:resetData()
	self._showLvItems = {}
	self._showStageItems = {}
	self._infoStageItems = {}
	self._equipReward = {}
	self._rewardItems = {}
	self._partStageItems = {}
end

function Season123EpisodeDetailView:noAudioShowInfoByOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(self._goinfo, true)
	self:_showInfo()
end

function Season123EpisodeDetailView:_showInfo()
	self:_setInfo()
	self:_setParts()
	self:_setButton()
	self:_setResetInfo()
end

function Season123EpisodeDetailView:_setButton()
	local needShowReset = Season123EpisodeDetailController.instance:isStageNeedClean() or Season123EpisodeDetailController.instance:isNextLayersNeedClean()

	gohelper.setActive(self._btnreset, needShowReset)
	gohelper.setActive(self._btnstart, not needShowReset)
end

function Season123EpisodeDetailView:_setResetInfo()
	local needShowReset = Season123EpisodeDetailController.instance:isStageNeedClean() or Season123EpisodeDetailController.instance:isNextLayersNeedClean()

	gohelper.setActive(self._goreset, needShowReset)
	gohelper.setActive(self._txtresettime, needShowReset)

	if needShowReset then
		local round = Season123EpisodeDetailModel.instance:getCurFinishRound()

		if round and round > 0 then
			self._txtresettime.text = tostring(round)
		else
			self._txtresettime.text = "--"
		end
	end
end

Season123EpisodeDetailView.NomalStageTagPos = Vector2(46.3, 2.7)
Season123EpisodeDetailView.NewStageTagPos = Vector2(4.37, 2.7)

function Season123EpisodeDetailView:_setInfo()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local episodeCo = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)

	if not episodeCo then
		return
	end

	local afterStory = Season123Model.instance:isEpisodeAfterStory(actId, stage, layer)

	gohelper.setActive(self._btnReplay, afterStory and episodeCo.afterStoryId and episodeCo.afterStoryId ~= 0 or false)

	self._txtlevelnamecn.text = episodeCo.layerName
	self._txtseasondesc.text = episodeCo.desc
	self._txtdesc.text = DungeonConfig.instance:getEpisodeCO(episodeCo.episodeId).desc
	self._txtcurindex.text = string.format("%02d", layer)

	local maxLayer = Season123ProgressUtils.getMaxLayer(actId, stage)

	self._txtmaxindex.text = string.format("%02d", maxLayer)

	local isNewStage = Season123EpisodeDetailModel.instance:isNextLayerNewStarGroup(layer)

	gohelper.setActive(self._godecorate, isNewStage)

	local targetStageTagPos = isNewStage and Season123EpisodeDetailView.NewStageTagPos or Season123EpisodeDetailView.NomalStageTagPos

	recthelper.setAnchor(self._gocenter.transform, targetStageTagPos.x, targetStageTagPos.y)

	local folder = Season123Model.instance:getSingleBgFolder()
	local urlStr = ResUrl.getSeason123LayerDetailBg(folder, episodeCo.layerPicture)

	if not string.nilorempty(urlStr) then
		self._simagestageicon:LoadImage(urlStr)
	end

	gohelper.setActive(self._gorewarditem, false)

	local rewards = DungeonModel.instance:getEpisodeFirstBonus(episodeCo.episodeId)

	for i = 2, math.max(#self._rewardItems - 1, #rewards) + 1 do
		local item = self._rewardItems[i] or self:createRewardItem(i)

		self:refreshRewardItem(item, rewards[i - 1])
	end

	self:refreshEquipCardItem()

	self._btnlast.button.interactable = layer > 1
	self._btnnext.button.interactable = layer < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer()
end

function Season123EpisodeDetailView:refreshEquipCardItem()
	if not self._rewardItems[1] then
		self._rewardItems[1] = self:createRewardItem(1)
	end

	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local episodeCo = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)

	gohelper.setActive(self._rewardItems[1].go, episodeCo.firstPassEquipId and episodeCo.firstPassEquipId > 0)

	if episodeCo.firstPassEquipId and episodeCo.firstPassEquipId > 0 then
		local hasGetReward = layer < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer() or Season123EpisodeDetailModel.instance:alreadyPassEpisode(layer)

		if not self._rewardItems[1].itemIcon then
			self._rewardItems[1].itemIcon = Season123CelebrityCardItem.New()

			self._rewardItems[1].itemIcon:setColorDark(hasGetReward)
			self._rewardItems[1].itemIcon:init(self._rewardItems[1].cardParent, episodeCo.firstPassEquipId)
		else
			self._rewardItems[1].itemIcon:setColorDark(hasGetReward)
			self._rewardItems[1].itemIcon:reset(episodeCo.firstPassEquipId)
		end

		gohelper.setActive(self._rewardItems[1].cardParent, true)
		gohelper.setActive(self._rewardItems[1].itemParent, false)
		gohelper.setActive(self._rewardItems[1].receive, hasGetReward)
	end
end

function Season123EpisodeDetailView:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.cloneInPlace(self._gorewarditem, "reward_" .. tostring(index))

	item.go = itemGo
	item.itemParent = gohelper.findChild(itemGo, "go_prop")
	item.cardParent = gohelper.findChild(itemGo, "go_card")
	item.receive = gohelper.findChild(itemGo, "go_receive")
	self._rewardItems[index] = item

	return item
end

function Season123EpisodeDetailView:refreshRewardItem(item, itemInfo)
	if not itemInfo or not next(itemInfo) then
		gohelper.setActive(item.go, false)

		return
	end

	if not item.itemIcon then
		item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.itemParent)
	end

	gohelper.setActive(item.cardParent, false)
	gohelper.setActive(item.itemParent, true)
	item.itemIcon:setMOValue(tonumber(itemInfo[1]), tonumber(itemInfo[2]), tonumber(itemInfo[3]), nil, true)
	item.itemIcon:isShowCount(tonumber(itemInfo[1]) ~= MaterialEnum.MaterialType.Hero)
	item.itemIcon:setCountFontSize(40)
	item.itemIcon:showStackableNum2()
	item.itemIcon:setHideLvAndBreakFlag(true)
	item.itemIcon:hideEquipLvAndBreak(true)
	gohelper.setActive(item.go, true)

	local layer = Season123EpisodeDetailModel.instance.layer
	local hasGetReward = layer < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer() or Season123EpisodeDetailModel.instance:alreadyPassEpisode(layer)

	gohelper.setActive(item.receive, hasGetReward)

	local color = hasGetReward and "#7b7b7b" or "#ffffff"

	item.itemIcon:setItemColor(color)
end

function Season123EpisodeDetailView:_setParts()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local episodeCo = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)

	self._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(episodeCo.level)

	if layer < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer() or layer > Season123ProgressUtils.getMaxLayer(actId, stage) then
		gohelper.setActive(self._gopart, false)
		gohelper.setActive(self._gopartempty, true)
		gohelper.setActive(self._gounlocktype1, false)
		gohelper.setActive(self._gounlocktype2, false)
		gohelper.setActive(self._gounlocktype3, false)
	else
		local isNewStage = Season123EpisodeDetailModel.instance:isNextLayerNewStarGroup(layer)

		gohelper.setActive(self._gostage, isNewStage)

		if isNewStage then
			local starGrop = Season123EpisodeDetailModel.instance:getCurStarGroup(actId, layer)

			self:_showPartStarGroupItem(starGrop + 1)
		end

		local newUnlocks = string.splitToNumber(episodeCo.unlockEquipIndex, "#")

		if #newUnlocks > 0 then
			local newUnlockIndex = newUnlocks[1]

			gohelper.setActive(self._gounlocktype1, Season123HeroGroupUtils.getUnlockIndexSlot(newUnlockIndex) == 1)
			gohelper.setActive(self._gounlocktype2, Season123HeroGroupUtils.getUnlockIndexSlot(newUnlockIndex) == 2)
			gohelper.setActive(self._gounlocktype3, Season123HeroGroupUtils.getUnlockIndexSlot(newUnlockIndex) == 3)
		else
			gohelper.setActive(self._gounlocktype1, false)
			gohelper.setActive(self._gounlocktype2, false)
			gohelper.setActive(self._gounlocktype3, false)
		end

		gohelper.setActive(self._gopart, isNewStage or #newUnlocks > 0)
		gohelper.setActive(self._gopartempty, not isNewStage and not (#newUnlocks > 0))
	end
end

Season123EpisodeDetailView.UnLockStageItemAlpha = 1
Season123EpisodeDetailView.LockStageItemAlpha = 0.3

function Season123EpisodeDetailView:_showPartStarGroupItem(starGroup)
	if starGroup < 7 then
		if self._partStageItems[7] then
			gohelper.setActive(self._partStageItems[7].go, false)
		end

		for i = 1, 6 do
			if not self._partStageItems[i] then
				local item = self:getUserDataTb_()
				local itemGo = gohelper.cloneInPlace(self._gostagelvlitem, "partstageitem_" .. tostring(i))

				item.go = itemGo
				item.current = gohelper.findChild(itemGo, "current")
				item.next = gohelper.findChild(itemGo, "next")
				item.canvasgroup = gohelper.onceAddComponent(itemGo, typeof(UnityEngine.CanvasGroup))
				self._partStageItems[i] = item
			end

			gohelper.setActive(self._partStageItems[i].go, true)
			gohelper.setActive(self._partStageItems[i].next, i == starGroup)
			gohelper.setActive(self._partStageItems[i].current, i ~= starGroup)

			self._partStageItems[i].canvasgroup.alpha = i <= starGroup and Season123EpisodeDetailView.UnLockStageItemAlpha or Season123EpisodeDetailView.LockStageItemAlpha
		end
	else
		for i = 1, 7 do
			if not self._partStageItems[i] then
				local item = self:getUserDataTb_()
				local itemGo = gohelper.cloneInPlace(self._gostagelvlitem, "partstageitem_" .. tostring(i))

				item.go = itemGo
				item.current = gohelper.findChild(itemGo, "current")
				item.next = gohelper.findChild(itemGo, "next")
				item.canvasgroup = gohelper.onceAddComponent(itemGo, typeof(UnityEngine.CanvasGroup))
				self._partStageItems[i] = item
			end

			gohelper.setActive(self._partStageItems[i].go, true)
			gohelper.setActive(self._partStageItems[i].next, i == starGroup)
			gohelper.setActive(self._partStageItems[i].current, i ~= starGroup)

			self._partStageItems[i].canvasgroup.alpha = i <= starGroup and Season123EpisodeDetailView.UnLockStageItemAlpha or Season123EpisodeDetailView.LockStageItemAlpha
		end
	end
end

function Season123EpisodeDetailView:_btnlastOnClick()
	if Season123EpisodeDetailController.instance:canSwitchLayer(false) then
		Season123EpisodeDetailController.instance:switchLayer(false)
	end
end

function Season123EpisodeDetailView:_btnnextOnClick()
	if Season123EpisodeDetailController.instance:canSwitchLayer(true) then
		Season123EpisodeDetailController.instance:switchLayer(true)
	end
end

function Season123EpisodeDetailView:_btnresetOnClick()
	Season123Controller.instance:openResetView({
		actId = Season123EpisodeDetailModel.instance.activityId,
		stage = Season123EpisodeDetailModel.instance.stage,
		layer = Season123EpisodeDetailModel.instance.layer
	})
end

return Season123EpisodeDetailView
