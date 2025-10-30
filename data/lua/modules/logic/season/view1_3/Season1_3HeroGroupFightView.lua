﻿-- chunkname: @modules/logic/season/view1_3/Season1_3HeroGroupFightView.lua

module("modules.logic.season.view1_3.Season1_3HeroGroupFightView", package.seeall)

local Season1_3HeroGroupFightView = class("Season1_3HeroGroupFightView", BaseView)
local MaxMultiplication = 1

function Season1_3HeroGroupFightView:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._goreplayready = gohelper.findChild(self.viewGO, "#go_container/#go_replayready")
	self._gotopbtns = gohelper.findChild(self.viewGO, "#go_container/#go_btns/#go_topbtns")
	self._btnrecommend = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_btns/#go_topbtns/btn_recommend")
	self._btnrestrain = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_btns/#go_topbtns/#btn_RestraintInfo")
	self._gobtncontain = gohelper.findChild(self.viewGO, "#go_container/btnContain")
	self._btncloth = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/btnCloth")
	self._txtclothname = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	self._txtclothnameen = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	self._btnstartseason = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_startseason")
	self._btnseasonreplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay")
	self._imagereplaybg = gohelper.findChildImage(self.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplaybg")
	self._imagereplayicon = gohelper.findChildImage(self.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplayicon")
	self._txtreplaycount = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#txt_seasonreplaycount")
	self._dropseasonherogroup = gohelper.findChildDropdown(self.viewGO, "#go_container/btnContain/horizontal/#drop_seasonherogroup")
	self._dropherogrouparrow = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#drop_seasonherogroup/arrow").transform
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self._gosupercard = gohelper.findChild(self.viewGO, "herogroupcontain/#go_supercard")
	self._simagerole = gohelper.findChildSingleImage(self._gosupercard, "#simage_role")
	self._gosupercardlight = gohelper.findChild(self.viewGO, "herogroupcontain/#go_supercard/light")
	self._gosupercardempty = gohelper.findChild(self.viewGO, "herogroupcontain/#go_supercard/#go_supercardempty")
	self._gosupercardpos = gohelper.findChild(self.viewGO, "herogroupcontain/#go_supercard/#go_supercardpos")
	self._btnsupercardclick = gohelper.findChildButtonWithAudio(self.viewGO, "herogroupcontain/#go_supercard/#btn_supercardclick")
	self._gocontainer2 = gohelper.findChild(self.viewGO, "#go_container2")
	self._gomask = gohelper.findChild(self.viewGO, "#go_container2/#go_mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_3HeroGroupFightView:addEvents()
	self._btncloth:AddClickListener(self._btnclothOnClock, self)
	self._btnrecommend:AddClickListener(self._btnrecommendOnClick, self)
	self._btnrestrain:AddClickListener(self._btnrestrainOnClick, self)
	self._btnstartseason:AddClickListener(self._btnstartseasonOnClick, self)
	self._btnseasonreplay:AddClickListener(self._btnseasonreplayOnClick, self)
	self._btnsupercardclick:AddClickListener(self._btnseasonsupercardOnClick, self)
	self._dropseasonherogroup:AddOnValueChanged(self._groupDropValueChanged, self)
end

function Season1_3HeroGroupFightView:removeEvents()
	self._btncloth:RemoveClickListener()
	self._btnrecommend:RemoveClickListener()
	self._btnrestrain:RemoveClickListener()
	self._btnstartseason:RemoveClickListener()
	self._btnseasonreplay:RemoveClickListener()
	self._btnsupercardclick:RemoveClickListener()
	self._dropseasonherogroup:RemoveOnValueChanged()
end

function Season1_3HeroGroupFightView:_btnrecommendOnClick()
	FightFailRecommendController.instance:onClickRecommend()
	self:_udpateRecommendEffect()
	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(self._episodeId, self._receiveRecommend, self)
end

function Season1_3HeroGroupFightView:_btnclothOnClock()
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local clothUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)

	if clothUnlock or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function Season1_3HeroGroupFightView:_btnrestrainOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function Season1_3HeroGroupFightView:_btnstartseasonOnClick()
	if not self._blockStart then
		self:_onClickStart()

		self._blockStart = true

		TaskDispatcher.runDelay(self._onEnableStart, self, 1)
	end
end

function Season1_3HeroGroupFightView:_onEnableStart()
	self._blockStart = false
end

function Season1_3HeroGroupFightView:_btnseasonreplayOnClick()
	self:_onClickReplay()
end

function Season1_3HeroGroupFightView:_btnseasonsupercardOnClick()
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local param = {}

	param.pos = 4
	param.actId = Activity104Model.instance:getCurSeasonId()
	param.slot = 1
	param.group = Activity104Model.instance:getSeasonCurSnapshotSubId()

	if not Activity104Model.instance:isSeasonPosUnlock(param.actId, param.group, param.slot, param.pos) then
		return
	end

	Activity104Controller.instance:openSeasonEquipHeroView(param)
end

function Season1_3HeroGroupFightView:_groupDropValueChanged(value)
	GameFacade.showToast(ToastEnum.SeasonGroupChanged)

	local actId = Activity104Model.instance:getCurSeasonId()
	local subId = value + 1

	Activity104Rpc.instance:sendChangeFightGroupRequest(actId, subId)
end

function Season1_3HeroGroupFightView:_editableInitView()
	self._simagerole:LoadImage(ResUrl.getSeasonIcon("img_vertin.png"))
	self:_initComponent()
	self:_initData()
	self:_addEvents()
end

function Season1_3HeroGroupFightView:onOpen()
	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
	self:_checkFirstPosHasEquip()
	self:_checkEquipClothSkill()
	self:_refreshUI()
	self:_checkReplay()
	self:_refreshReplay()
	self:_udpateRecommendEffect()
end

function Season1_3HeroGroupFightView:_initComponent()
	self._anim = self._gocontainer:GetComponent(typeof(UnityEngine.Animator))
	self._heroContainAnim = self._goherogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	self._btnContainAnim = self._gobtncontain:GetComponent(typeof(UnityEngine.Animator))
end

function Season1_3HeroGroupFightView:_initData()
	gohelper.addUIClickAudio(self._btnstartseason.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(self._btnseasonreplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)
	gohelper.addUIClickAudio(self._btnrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(self._dropseasonherogroup.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)
	NavigateMgr.instance:addEscape(ViewName.Season1_3HeroGroupFightView, self._onEscapeBtnClick, self)
	FightHelper.detectAttributeCounter()

	self._iconGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._btncloth.gameObject)

	recthelper.setAnchor(self._iconGO.transform, -100, 1)

	self._tweeningId = 0
	self._replayMode = false
	self._multiplication = 1

	gohelper.setActive(self._gomask, false)

	local list = {
		luaLang("season_herogroup_one"),
		luaLang("season_herogroup_two"),
		luaLang("season_herogroup_three"),
		luaLang("season_herogroup_four")
	}

	self._dropseasonherogroup:ClearOptions()
	self._dropseasonherogroup:AddOptions(list)

	local snapshotSubId = Activity104Model.instance:getSeasonCurSnapshotSubId()

	self._dropseasonherogroup:SetValue(snapshotSubId - 1)
	gohelper.setActive(self._goseasoncontain, true)
	TaskDispatcher.runRepeat(self._checkDropArrow, self, 0)
end

function Season1_3HeroGroupFightView:_addEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onModifySnapshot, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, self._onClickHeroGroupItem, self)
	self:addEventCb(FightController.instance, FightEvent.RespBeginFight, self._respBeginFight, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, self._playHeroGroupExitEffect, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, self._playCloseHeroGroupAnimation, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, self._onUseRecommendGroup, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, self._showGuideDragEffect, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, self._heroMoveForward, self)
	self:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, self._switchSnapshotSubId, self)
end

function Season1_3HeroGroupFightView:_checkReplay()
	local hasUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and userDungeonMO.hasRecord
	local isAdvance = Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId)
	local pass_model_record = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if hasUnlock and hasRecord and not string.nilorempty(pass_model_record) and not isAdvance then
		pass_model_record = cjson.decode(pass_model_record)

		if pass_model_record[tostring(self._episodeId)] and not self._replayMode then
			self._replayMode = true
			self._multiplication = PlayerPrefsHelper.getNumber(self:_getMultiplicationKey(), 1)

			self:_refreshBtns()

			self._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

			if not self._replayFightGroupMO then
				self:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
				FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
			else
				self:_switchReplayGroup()
			end
		end
	end
end

function Season1_3HeroGroupFightView:_receiveRecommend(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, msg)
end

function Season1_3HeroGroupFightView:_switchSnapshotSubId()
	self:_refreshMainCard()
end

function Season1_3HeroGroupFightView:_refreshMainCard()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local character_uid = "-100000"
	local mainRolePos = Activity104EquipItemListModel.MainCharPos
	local mainRoleSlot = 1
	local act104EquipId = 0

	if curGroupMO then
		if curGroupMO.isReplay and curGroupMO.replay_activity104Equip_data then
			local mainRoleEquipData = curGroupMO.replay_activity104Equip_data[character_uid]

			if mainRoleEquipData and mainRoleEquipData[mainRoleSlot] then
				act104EquipId = mainRoleEquipData[mainRoleSlot].equipId
			end
		end

		if not curGroupMO.isReplay and curGroupMO.activity104Equips and curGroupMO.activity104Equips[mainRolePos] then
			act104EquipId = Activity104Model.instance:getItemIdByUid(curGroupMO:getAct104PosEquips(mainRolePos):getEquipUID(mainRoleSlot))
		end
	end

	gohelper.setActive(self._gosupercardlight, false)

	if act104EquipId ~= 0 then
		if not self._superCardItem then
			self._superCardItem = Season1_3CelebrityCardItem.New()

			self._superCardItem:init(self._gosupercardpos, act104EquipId)
		else
			gohelper.setActive(self._superCardItem.go, true)
			self._superCardItem:reset(act104EquipId)
		end

		gohelper.setActive(self._gosupercardlight, true)
	elseif self._superCardItem then
		gohelper.setActive(self._superCardItem.go, false)
	end

	local layer = Activity104Model.instance:getAct104CurLayer()

	if curGroupMO.isReplay and DungeonModel.instance.curSendEpisodeId then
		local episodeType = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type

		if episodeType == DungeonEnum.EpisodeType.Season then
			layer = Activity104Model.instance:getBattleFinishLayer()
		end
	end

	local snapshotSubId = Activity104Model.instance:getSeasonCurSnapshotSubId()
	local unlock = Activity104Model.instance:isSeasonLayerPosUnlock(nil, snapshotSubId, layer, mainRoleSlot, mainRolePos)

	gohelper.setActive(self._gosupercardlock, not unlock)
	gohelper.setActive(self._gosupercardempty, unlock)
end

function Season1_3HeroGroupFightView:_checkDropArrow()
	if not self._dropherogrouparrow then
		TaskDispatcher.cancelTask(self._checkDropArrow, self)

		return
	end

	local childCount = self._dropseasonherogroup.transform.childCount

	if childCount ~= self._dropDownChildCount then
		self._dropDownChildCount = childCount

		transformhelper.setLocalScale(self._dropherogrouparrow, 1, childCount == 5 and -1 or 1, 1)
	end
end

function Season1_3HeroGroupFightView:_onClickReplay()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightReplay)

		GameFacade.showToast(desc, param)

		return
	end

	if not HeroGroupModel.instance.episodeId then
		return
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.hasRecord
	local hasFirstBattle = episodeConfig and episodeConfig.firstBattleId > 0

	if not hasRecord and hasFirstBattle then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId) and userDungeonMO.hasRecord then
		GameFacade.showToast(ToastEnum.SeasonAdvanceLevelNoReplay)

		return
	end

	if not hasRecord then
		GameFacade.showToast(ToastEnum.SeasonHeroGroupStarNoAdvanced)

		return
	end

	if self._replayMode then
		self._replayMode = false
		self._multiplication = 1

		self._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
		gohelper.setActive(self._gomultispeed, false)
	else
		self._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		self._replayMode = true
		self._multiplication = 1
	end

	PlayerPrefsHelper.setNumber(self:_getMultiplicationKey(), self._multiplication)
	self:_refreshBtns()

	if self._replayMode and not self._replayFightGroupMO then
		self:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	self:_switchReplayGroup(self._replayMode)
end

function Season1_3HeroGroupFightView:_switchReplayGroup(lastRelayMode)
	gohelper.setActive(self._goreplayready, self._replayMode)

	local haveRecord = self:_haveRecord()

	UISpriteSetMgr.instance:setHeroGroupSprite(self._imagereplayicon, not haveRecord and "btn_replay_lack" or self._replayMode and "btn_replay_pause" or "btn_replay_play")

	if lastRelayMode ~= self._replayMode then
		TaskDispatcher.cancelTask(self._switchReplayMul, self)
		TaskDispatcher.runDelay(self._switchReplayMul, self, 0.1)
	else
		self:_switchReplayMul()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, self._replayMode and "swicth" or "open")

	if self._replayMode then
		self:_updateReplayHeroGroupList()
	else
		HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)

		local heroGroupId = HeroGroupModel.instance:getCurGroupMO().id

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, heroGroupId)
		self:_refreshCloth()
		self:_refreshMainCard()
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
	end
end

function Season1_3HeroGroupFightView:_haveRecord()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		return false
	end

	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.hasRecord

	return hasRecord
end

function Season1_3HeroGroupFightView:_updateReplayHeroGroupList()
	HeroGroupModel.instance:setReplayParam(self._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, self._replayFightGroupMO.id)
	self:_refreshCloth()
	self:_refreshMainCard()
	gohelper.setActive(self._goherogroupcontain, false)
	gohelper.setActive(self._goherogroupcontain, true)
end

function Season1_3HeroGroupFightView:_switchReplayMul()
	self._txtreplaycount.text = self._replayMode and luaLang("multiple") .. self._multiplication or ""
end

function Season1_3HeroGroupFightView:_heroMoveForward(heroId)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(heroId))
end

function Season1_3HeroGroupFightView:isReplayMode()
	return self._replayMode
end

function Season1_3HeroGroupFightView:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:_refreshBtns()
end

function Season1_3HeroGroupFightView:_respBeginFight()
	gohelper.setActive(self._gomask, true)
end

function Season1_3HeroGroupFightView:_onOpenFullView(viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function Season1_3HeroGroupFightView:_onCloseView(viewName)
	if viewName == ViewName.EquipInfoTeamShowView then
		self:_checkFirstPosHasEquip()
	end
end

function Season1_3HeroGroupFightView:_getMultiplicationKey()
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), self._episodeId)
end

function Season1_3HeroGroupFightView:_udpateRecommendEffect()
	gohelper.setActive(self._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(self._episodeId))
end

function Season1_3HeroGroupFightView:_onEscapeBtnClick()
	if not self._gomask.gameObject.activeInHierarchy then
		self.viewContainer:_closeCallback()
	end
end

function Season1_3HeroGroupFightView:_refreshUI()
	local heroGroupId = HeroGroupModel.instance:getCurGroupId()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, heroGroupId)

	self._episodeId = HeroGroupModel.instance.episodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	self:_refreshBtns()
	self:_refreshCloth()
	self:_refreshMainCard()
	self.viewContainer:setNavigateOverrideClose(self.openSeason1_3MainView, self)
end

function Season1_3HeroGroupFightView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	self:_removeEvents()
	ZProj.TweenHelper.KillById(self._tweeningId)
	TaskDispatcher.cancelTask(self.openHeroGroupEditView, self)
	TaskDispatcher.cancelTask(self._closeHeroContainAnim, self)
	TaskDispatcher.cancelTask(self._onEnableStart, self)
	TaskDispatcher.cancelTask(self._checkDropArrow, self)

	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end
end

function Season1_3HeroGroupFightView:_removeEvents()
	self:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onModifySnapshot, self)
	self:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
end

function Season1_3HeroGroupFightView:_refreshReplay()
	local showReplayBtn = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	local replay_is_unlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)

	gohelper.setActive(self._btnseasonreplay.gameObject, self.episodeConfig and self.episodeConfig.canUseRecord == 1)

	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.hasRecord

	ZProj.UGUIHelper.SetColorAlpha(self._imagereplaybg, replay_is_unlock and hasRecord and 1 or 0.75)

	self._txtreplaycount.text = self._replayMode and luaLang("multiple") .. self._multiplication or ""

	local normalIcon = self._replayMode and "btn_replay_pause" or "btn_replay_play"

	UISpriteSetMgr.instance:setHeroGroupSprite(self._imagereplayicon, replay_is_unlock and hasRecord and normalIcon or "btn_replay_lack")
end

function Season1_3HeroGroupFightView:_refreshCloth()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local cloth_id = curGroupMO.clothId
	local clothMO = PlayerClothModel.instance:getById(cloth_id)

	gohelper.setActive(self._txtclothname.gameObject, clothMO)

	if clothMO then
		local clothConfig = lua_cloth.configDict[clothMO.clothId]
		local clothLv = clothMO.level or 0

		self._txtclothname.text = clothConfig.name
		self._txtclothnameen.text = clothConfig.enname
	end

	for _, clothCO in ipairs(lua_cloth.configList) do
		local icon = gohelper.findChild(self._iconGO, tostring(clothCO.id))

		if not gohelper.isNil(icon) then
			gohelper.setActive(icon, clothCO.id == cloth_id)
		end
	end

	gohelper.setActive(self._btncloth.gameObject, Season1_3HeroGroupFightView.showCloth())
end

function Season1_3HeroGroupFightView:_checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(curGroupMO.clothId) then
		return
	end

	local list = PlayerClothModel.instance:getList()

	for _, clothMO in ipairs(list) do
		if PlayerClothModel.instance:hasCloth(clothMO.id) then
			HeroGroupModel.instance:replaceCloth(clothMO.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function Season1_3HeroGroupFightView._getEpisodeConfigAndBattleConfig()
	local episodeCO = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local battleCO = episodeCO and lua_battle.configDict[episodeCO.battleId]

	return episodeCO, battleCO
end

function Season1_3HeroGroupFightView.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)

	if not clothShow then
		return false
	end

	local episodeCO, battleCO = Season1_3HeroGroupFightView._getEpisodeConfigAndBattleConfig()

	if battleCO and battleCO.noClothSkill == 1 then
		return false
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local clothMO = PlayerClothModel.instance:getById(curGroupMO.clothId)
	local list = PlayerClothModel.instance:getList()
	local hasUnlock = false

	for _, clothMO in ipairs(list) do
		hasUnlock = true

		break
	end

	return hasUnlock
end

function Season1_3HeroGroupFightView:_onModifyHeroGroup()
	self:_refreshCloth()
	self:_refreshMainCard()
end

function Season1_3HeroGroupFightView:_onModifySnapshot()
	self:_refreshCloth()
	self:_refreshMainCard()
end

function Season1_3HeroGroupFightView:_onClickHeroGroupItem(id)
	TaskDispatcher.cancelTask(self.openHeroGroupEditView, self)

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equips = heroGroupMO:getPosEquips(id - 1).equipUid

	self._param = {}
	self._param.singleGroupMOId = id
	self._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(id)
	self._param.equips = equips

	self:openHeroGroupEditView()
end

function Season1_3HeroGroupFightView:openHeroGroupEditView()
	ViewMgr.instance:openView(ViewName.HeroGroupEditView, self._param)
end

function Season1_3HeroGroupFightView:_checkFirstPosHasEquip()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		return
	end

	local equips = curGroupMO:getPosEquips(0).equipUid
	local equipId = equips and equips[1]
	local equipMO = equipId and EquipModel.instance:getEquip(equipId)

	if equipMO then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function Season1_3HeroGroupFightView:_showGuideDragEffect(param)
	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end

	local visible = tonumber(param) == 1

	if visible then
		self._dragEffectLoader = PrefabInstantiate.Create(self.viewGO)

		self._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function Season1_3HeroGroupFightView:_onClickStart()
	local costs = string.split(self.episodeConfig.cost, "|")
	local cost1 = string.split(costs[1], "#")
	local value = tonumber(cost1[3] or 0)
	local guideEpisodeId = 10104

	if HeroGroupModel.instance.episodeId == guideEpisodeId and not DungeonModel.instance:hasPassLevel(guideEpisodeId) then
		local list = HeroSingleGroupModel.instance:getList()
		local count = 0

		for i, v in ipairs(list) do
			if not v:isEmpty() then
				count = count + 1
			end
		end

		if count < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	self:_enterFight()
end

function Season1_3HeroGroupFightView:_enterFight()
	if HeroGroupModel.instance.episodeId then
		self._closeWithEnteringFight = true

		local result = FightController.instance:setFightHeroGroup()

		if result then
			local fightParam = FightModel.instance:getFightParam()

			if self._replayMode then
				fightParam.isReplay = true
				fightParam.multiplication = self._multiplication

				DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, self._multiplication, nil, true)
			else
				fightParam.isReplay = false
				fightParam.multiplication = 1

				DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function Season1_3HeroGroupFightView:_onUseRecommendGroup()
	if self._replayMode then
		self._replayMode = false
		self._multiplication = 1

		self:_refreshBtns()
		self:_switchReplayGroup()
	end
end

function Season1_3HeroGroupFightView:_refreshBtns()
	local showDrop = not self._replayMode and self:_noAidHero()

	gohelper.setActive(self._dropseasonherogroup.gameObject, showDrop)
end

function Season1_3HeroGroupFightView:_onGetFightRecordGroupReply(fightGroupMO)
	self:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)

	self._replayFightGroupMO = fightGroupMO

	if not self._replayMode then
		return
	end

	self:_switchReplayGroup()
	self:_updateReplayHeroGroup()
end

function Season1_3HeroGroupFightView:_updateReplayHeroGroup()
	HeroGroupModel.instance:setReplayParam(self._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, self._replayFightGroupMO.id)
	self:_refreshCloth()
	self:_refreshMainCard()
	gohelper.setActive(self._goherogroupcontain, false)
	gohelper.setActive(self._goherogroupcontain, true)
end

function Season1_3HeroGroupFightView:_playHeroGroupExitEffect()
	self._anim:Play("close", 0, 0)
	self._btnContainAnim:Play("close", 0, 0)
end

function Season1_3HeroGroupFightView:_playCloseHeroGroupAnimation()
	self._anim:Play("close", 0, 0)
	self._btnContainAnim:Play("close", 0, 0)

	self._heroContainAnim.enabled = true

	self._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(self._closeHeroContainAnim, self, 0.133)
end

function Season1_3HeroGroupFightView:_closeHeroContainAnim()
	if self._heroContainAnim then
		self._heroContainAnim.enabled = false
	end
end

function Season1_3HeroGroupFightView:onDestroyView()
	self._simagerole:UnLoadImage()

	if self._superCardItem then
		self._superCardItem:destroy()

		self._superCardItem = nil
	end
end

function Season1_3HeroGroupFightView:_noAidHero()
	local battleId = HeroGroupModel.instance.battleId
	local battleCo = lua_battle.configDict[battleId]

	if not battleCo then
		return
	end

	return battleCo.trialLimit <= 0 and string.nilorempty(battleCo.aid) and string.nilorempty(battleCo.trialHeros) and string.nilorempty(battleCo.trialEquips)
end

return Season1_3HeroGroupFightView
