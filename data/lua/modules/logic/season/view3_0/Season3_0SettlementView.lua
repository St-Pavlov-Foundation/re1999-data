﻿module("modules.logic.season.view3_0.Season3_0SettlementView", package.seeall)

local var_0_0 = class("Season3_0SettlementView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosettlement = gohelper.findChild(arg_1_0.viewGO, "#go_settlement")
	arg_1_0._gospecialmarket = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_specialmarket")
	arg_1_0._simagespecialbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_settlement/#go_specialmarket/#simage_specialbg")
	arg_1_0._animationEvent = arg_1_0._gosettlement:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_settlement/#btn_close")
	arg_1_0._simagedecorate6 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_settlement/decorate/mask/#simage_decorate6")
	arg_1_0._simagedecorate10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_settlement/decorate/mask/#simage_decorate10")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/left/#simage_circlebg/#txt_index")
	arg_1_0._txtlevelnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/left/#txt_levelnamecn")
	arg_1_0._gostageitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem1")
	arg_1_0._gostageitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem2")
	arg_1_0._gostageitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem3")
	arg_1_0._gostageitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem4")
	arg_1_0._gostageitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem5")
	arg_1_0._gostageitem6 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem6")
	arg_1_0._gostageitem7 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem7")
	arg_1_0._simageherodecorate = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_settlement/right/herocard/#simage_herodecorate")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_progress")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_progress/#txt_progress")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._gohero1 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero1")
	arg_1_0._gohero2 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero2")
	arg_1_0._gohero3 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero3")
	arg_1_0._gohero4 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero4")
	arg_1_0._gosupercard = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/herocard/#go_supercard")
	arg_1_0._gofightsucc = gohelper.findChild(arg_1_0.viewGO, "#go_fightsucc")
	arg_1_0._simagefightsuccbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_fightsucc/#simage_fightsuccbg")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightsucc/#btn_closetip")
	arg_1_0._gocoverrecordpart = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part")
	arg_1_0._btncoverrecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/#btn_cover_record")
	arg_1_0._txtcurroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	arg_1_0._txtmaxroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	arg_1_0._goCoverLessThan = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	arg_1_0._goCoverMuchThan = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	arg_1_0._goCoverEqual = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_equal")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom")
	arg_1_0._gospace = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_space")
	arg_1_0._btnstat = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_settlement/right/layout/middle/#btn_stat")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._btncloseaward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tips/#btn_closeaward")
	arg_1_0._gorewardtip = gohelper.findChild(arg_1_0.viewGO, "#go_tips/layout/vertical/#go_rewardtip")
	arg_1_0._awardcontent = gohelper.findChild(arg_1_0.viewGO, "#go_tips/layout/vertical/#go_rewardtip/#scroll_rewardtip/Viewport/Content")
	arg_1_0._gorewardtipitem = gohelper.findChild(arg_1_0.viewGO, "#go_tips/layout/vertical/#go_rewardtip/#scroll_rewardtip/Viewport/Content/#go_rewardtipitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnstat:AddClickListener(arg_2_0._btnstatOnClick, arg_2_0)
	arg_2_0._btncloseaward:AddClickListener(arg_2_0._btncloseawardOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btncoverrecord, arg_2_0._onBtnCoverRecordClick, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, arg_2_0._onCoverDungeonRecordReply, arg_2_0)
	FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, arg_2_0._onGetFightRecordGroupReply, arg_2_0)
	arg_2_0._animationEvent:AddEventListener("reward", arg_2_0._onRewardShow, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnstat:RemoveClickListener()
	arg_3_0._btncloseaward:RemoveClickListener()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_3_0._onGetFightRecordGroupReply, arg_3_0)
	arg_3_0._animationEvent:RemoveEventListener("reward")
end

function var_0_0._btnclosetipOnClick(arg_4_0)
	arg_4_0:_showAwardTip()
	gohelper.setActive(arg_4_0._gofightsucc, false)
end

function var_0_0._btncloseawardOnClick(arg_5_0)
	if Time.realtimeSinceStartup - arg_5_0._startTime < 2 then
		return
	end

	arg_5_0:_showSettlement()
end

function var_0_0._btnstatOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._showAwardTip(arg_7_0)
	FightHelper.hideAllEntity()

	if arg_7_0._episode_config.type == DungeonEnum.EpisodeType.Season and FightResultModel.instance.firstPass then
		gohelper.setActive(arg_7_0._gotips, true)
		arg_7_0:_showAwardTipsData()
	else
		arg_7_0:_showSettlement()
	end
end

function var_0_0._showSettlement(arg_8_0)
	gohelper.setActive(arg_8_0._gotips, false)

	arg_8_0._startTime = Time.realtimeSinceStartup

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_clearing)
	gohelper.setActive(arg_8_0._gosettlement, true)
	gohelper.setActive(arg_8_0._gospecialmarket, arg_8_0._episode_config.type == DungeonEnum.EpisodeType.SeasonSpecial)
	arg_8_0:_checkNewRecord()
	arg_8_0:_detectCoverRecord()
	TaskDispatcher.runDelay(arg_8_0._dailyShowHero, arg_8_0, 0.6)
end

function var_0_0._onRewardShow(arg_9_0)
	arg_9_0:_showSettlementReward()
end

function var_0_0._dailyShowHero(arg_10_0)
	arg_10_0._heroIndex = 0

	TaskDispatcher.runRepeat(arg_10_0._showHeroItem, arg_10_0, 0.03, #arg_10_0._heroList)
	TaskDispatcher.runDelay(arg_10_0._showGetCardView, arg_10_0, 1.5)
end

function var_0_0._showHeroItem(arg_11_0)
	arg_11_0._heroIndex = arg_11_0._heroIndex + 1

	gohelper.setActive(arg_11_0._heroList[arg_11_0._heroIndex].viewGO, true)
end

function var_0_0._showGetCardView(arg_12_0)
	if arg_12_0.equip_cards then
		arg_12_0._showTipsFlow = FlowSequence.New()

		arg_12_0._showTipsFlow:addWork(Season3_0SettlementTipsWork.New())
		arg_12_0._showTipsFlow:registerDoneListener(arg_12_0._onShowTipsFlowDone, arg_12_0)

		local var_12_0 = {}

		var_12_0.delayTime = 0

		arg_12_0._showTipsFlow:start(var_12_0)
	end
end

function var_0_0._onShowTipsFlowDone(arg_13_0)
	arg_13_0.equip_cards = nil
end

function var_0_0._checkNewRecord(arg_14_0)
	if FightResultModel.instance.updateDungeonRecord then
		GameFacade.showToast(ToastEnum.FightNewRecord)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	end
end

function var_0_0._onCoverDungeonRecordReply(arg_15_0, arg_15_1)
	arg_15_0._hasSendCoverRecord = true

	gohelper.setActive(arg_15_0._gocoverrecordpart, false)

	if arg_15_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
	end
end

function var_0_0._detectCoverRecord(arg_16_0)
	gohelper.setActive(arg_16_0._gocoverrecordpart, FightResultModel.instance.canUpdateDungeonRecord or false)

	if FightResultModel.instance.canUpdateDungeonRecord then
		arg_16_0._txtcurroundcount.text = FightResultModel.instance.newRecordRound or ""
		arg_16_0._txtmaxroundcount.text = FightResultModel.instance.oldRecordRound or ""

		gohelper.setActive(arg_16_0._goCoverLessThan, FightResultModel.instance.newRecordRound < FightResultModel.instance.oldRecordRound)
		gohelper.setActive(arg_16_0._goCoverMuchThan, FightResultModel.instance.newRecordRound > FightResultModel.instance.oldRecordRound)
		gohelper.setActive(arg_16_0._goCoverEqual, FightResultModel.instance.newRecordRound == FightResultModel.instance.oldRecordRound)

		if FightResultModel.instance.newRecordRound >= FightResultModel.instance.oldRecordRound then
			arg_16_0._txtcurroundcount.color = GameUtil.parseColor("#272525")
		else
			arg_16_0._txtcurroundcount.color = GameUtil.parseColor("#AC5320")
		end
	end
end

function var_0_0._onBtnCoverRecordClick(arg_17_0)
	DungeonRpc.instance:sendCoverDungeonRecordRequest(true)
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._simagedecorate10:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
	arg_18_0._simagefightsuccbg:LoadImage(ResUrl.getSeasonIcon("full/diejia_bj.png"))
	arg_18_0._simageherodecorate:LoadImage(ResUrl.getSeasonIcon("jiesuan_zhujue.png"))
	arg_18_0._simagespecialbg:LoadImage(ResUrl.getSeasonIcon("full/img_bg3.png"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_succeed)
	gohelper.setActive(arg_18_0._gofightsucc, true)
	gohelper.setActive(arg_18_0._gosettlement, false)
	gohelper.setActive(arg_18_0._gotips, false)

	arg_18_0._fightsucc_click = gohelper.getClick(arg_18_0._gofightsucc)
end

function var_0_0._btncloseOnClick(arg_19_0)
	if Time.realtimeSinceStartup - arg_19_0._startTime < 2.5 then
		return
	end

	if arg_19_0.equip_cards then
		return
	end

	arg_19_0:closeThis()

	local var_19_0 = FightModel.instance:getAfterStory()

	if var_19_0 > 0 and not StoryModel.instance:isStoryFinished(var_19_0) then
		local var_19_1 = {}

		var_19_1.mark = true
		var_19_1.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(var_19_0, var_19_1, function()
			FightSuccView.onStoryEnd()
		end)

		return
	end

	FightSuccView.onStoryEnd()
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0._startTime = Time.realtimeSinceStartup
	arg_21_0._episode_config = lua_episode.configDict[FightResultModel.instance:getEpisodeId()]

	local var_21_0 = Activity104Model.instance:getBattleFinishLayer() or 1

	arg_21_0._config = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), var_21_0)

	if arg_21_0._config then
		arg_21_0._simagedecorate6:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/ty_chatu_%s.png", arg_21_0._config.stagePicture)))
	end

	arg_21_0._txtindex.text = string.format("%02d", var_21_0)
	arg_21_0._txtlevelnamecn.text = arg_21_0._episode_config.name

	local var_21_1 = {}

	tabletool.addValues(var_21_1, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(var_21_1, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(var_21_1, FightResultModel.instance:getMaterialDataList())

	local var_21_2 = {}

	for iter_21_0 = #var_21_1, 1, -1 do
		local var_21_3 = var_21_1[iter_21_0]

		if var_21_3.materilType == MaterialEnum.MaterialType.EquipCard then
			table.insert(var_21_2, var_21_3.materilId)
		end
	end

	arg_21_0:_onHeroItemLoaded()

	if #var_21_2 > 0 then
		arg_21_0.equip_cards = var_21_2
	end

	arg_21_0.reward_list = var_21_1

	local var_21_4 = FightResultModel.instance.firstPass and arg_21_0._episode_config.type == DungeonEnum.EpisodeType.Season

	gohelper.setActive(arg_21_0._goprogress, var_21_4)

	if #var_21_1 == 0 then
		if FightResultModel.instance.firstPass then
			logError("服务器没有下发奖励")
		end

		gohelper.setActive(arg_21_0._gorewards, false)
	end

	gohelper.setActive(arg_21_0._gobottom, FightResultModel.instance.firstPass or #var_21_1 > 0)
	gohelper.setActive(arg_21_0._gospace, not FightResultModel.instance.firstPass and not (#var_21_1 > 0))
	arg_21_0:_setStages()

	arg_21_0._reward_list = var_21_1

	TaskDispatcher.runDelay(arg_21_0._btnclosetipOnClick, arg_21_0, 1.5)

	CameraMgr.instance:getCameraRootAnimator().enabled = false
end

function var_0_0._showSettlementReward(arg_22_0)
	local var_22_0 = gohelper.findChild(arg_22_0._scrollrewards.gameObject, "Viewport/Content")

	gohelper.addChild(arg_22_0.viewGO, arg_22_0._gorewarditem)
	arg_22_0:com_createObjList(arg_22_0._onRewardItemShow, arg_22_0.reward_list, var_22_0, arg_22_0._gorewarditem, nil, 0.1)
end

function var_0_0._setStages(arg_23_0)
	local var_23_0 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), Activity104Model.instance:getBattleFinishLayer()).stage
	local var_23_1 = Activity104Model.instance:getMaxStage()

	if arg_23_0._episode_config.type == DungeonEnum.EpisodeType.SeasonSpecial then
		var_23_0 = var_23_1 - 1
	end

	for iter_23_0 = 1, 7 do
		arg_23_0:refreshStageGO(arg_23_0["_gostageitem" .. iter_23_0], iter_23_0, var_23_0, var_23_1)
	end
end

function var_0_0.refreshStageGO(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if not arg_24_1 then
		return
	end

	local var_24_0 = arg_24_2 == arg_24_4

	if arg_24_4 < arg_24_2 or var_24_0 and arg_24_3 < arg_24_2 then
		gohelper.setActive(arg_24_1, false)

		return
	end

	gohelper.setActive(arg_24_1, true)

	local var_24_1 = arg_24_2 <= arg_24_3
	local var_24_2 = gohelper.findChild(arg_24_1, "light")
	local var_24_3 = gohelper.findChild(arg_24_1, "dark")

	gohelper.setActive(var_24_2, var_24_1)
	gohelper.setActive(var_24_3, not var_24_1)

	if var_24_1 then
		local var_24_4 = var_24_0 and "#B83838" or "#FFFFFF"
		local var_24_5 = gohelper.findChildImage(arg_24_1, "light")

		SLFramework.UGUI.GuiHelper.SetColor(var_24_5, var_24_4)
	end
end

function var_0_0._onRewardItemShow(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = gohelper.findChild(arg_25_1, "go_prop")

	if arg_25_2.materilType == MaterialEnum.MaterialType.EquipCard then
		local var_25_1 = Season3_0CelebrityCardItem.New()

		var_25_1:init(gohelper.findChild(var_25_0, "cardicon"), arg_25_2.materilId)

		arg_25_0._equipAwardCards = arg_25_0._equipAwardCards or {}

		table.insert(arg_25_0._equipAwardCards, var_25_1)
	else
		local var_25_2 = IconMgr.instance:getCommonPropListItemIcon(var_25_0)

		var_25_2._index = arg_25_3

		function var_25_2.callback(arg_26_0)
			arg_26_0:setCountFontSize(40)
			arg_26_0:hideName()
		end

		var_25_2:onUpdateMO(arg_25_2)
	end
end

local var_0_1 = {
	{
		Vector2.New(136.2, 196)
	},
	{
		Vector2.New(-92.3, 114),
		Vector2.New(149.7, 195.9)
	},
	{
		Vector2.New(-219.9, 195.9),
		Vector2.New(22.2, 116.1),
		Vector2.New(264.8, 195.9)
	},
	{
		Vector2.New(-340.6, 267.6),
		Vector2.New(-112.2, 195.9),
		Vector2.New(115, 115),
		Vector2.New(345.2, 195.9)
	}
}

function var_0_0._onHeroItemLoaded(arg_27_0)
	arg_27_0._heroList = {}
	arg_27_0._hero_obj_list = arg_27_0:getUserDataTb_()

	local var_27_0 = arg_27_0.viewContainer:getSetting().otherRes.itemRes

	for iter_27_0 = 1, 4 do
		local var_27_1 = arg_27_0.viewContainer:getResInst(var_27_0, arg_27_0["_gohero" .. iter_27_0])

		gohelper.setActive(var_27_1, false)
		table.insert(arg_27_0._hero_obj_list, var_27_1)
	end

	gohelper.setActive(arg_27_0._gosupercard, false)

	local var_27_2 = FightModel.instance:getFightParam()
	local var_27_3 = FightModel.instance:getBattleId()
	local var_27_4 = var_27_3 and lua_battle.configDict[var_27_3]
	local var_27_5 = var_27_4 and var_27_4.playerMax or ModuleEnum.HeroCountInGroup
	local var_27_6 = FightModel.instance.curFightModel

	if not var_27_6 then
		local var_27_7 = {}
		local var_27_8 = {}

		for iter_27_1, iter_27_2 in ipairs(var_27_2.mySideUids) do
			table.insert(var_27_8, iter_27_2)
		end

		for iter_27_3, iter_27_4 in ipairs(var_27_2.mySideSubUids) do
			table.insert(var_27_8, iter_27_4)
		end

		local var_27_9 = {}

		for iter_27_5, iter_27_6 in ipairs(var_27_2.equips) do
			var_27_9[iter_27_6.heroUid] = iter_27_6
		end

		local var_27_10 = {}

		for iter_27_7, iter_27_8 in ipairs(var_27_2.activity104Equips) do
			var_27_10[iter_27_8.heroUid] = iter_27_8
		end

		if var_27_2.trialHeroList then
			for iter_27_9, iter_27_10 in ipairs(var_27_2.trialHeroList) do
				local var_27_11 = iter_27_10.pos

				if var_27_11 < 0 then
					var_27_11 = var_27_5 - var_27_11
				end

				var_27_7[var_27_11] = iter_27_10

				table.insert(var_27_8, var_27_11, 0)
			end
		end

		for iter_27_11 = 1, 4 do
			if var_27_7[iter_27_11] then
				if lua_hero_trial.configDict[var_27_7[iter_27_11].trialId][0] then
					local var_27_12 = var_27_7[iter_27_11].equipUid
					local var_27_13 = arg_27_0:openSubView(Season3_0SettlementHeroItem, arg_27_0._hero_obj_list[iter_27_11], nil, var_27_6, nil, var_27_12, nil, nil, var_27_7[iter_27_11])

					table.insert(arg_27_0._heroList, var_27_13)
				end
			else
				local var_27_14 = var_27_8[iter_27_11]
				local var_27_15 = var_27_14 ~= "0" and var_27_9[var_27_14] and var_27_9[var_27_14].equipUid
				local var_27_16 = var_27_14 ~= "0" and var_27_10[var_27_14] and var_27_10[var_27_14].equipUid
				local var_27_17 = arg_27_0:openSubView(Season3_0SettlementHeroItem, arg_27_0._hero_obj_list[iter_27_11], nil, var_27_6, var_27_14, var_27_15, var_27_16)

				if var_27_14 ~= "0" then
					table.insert(arg_27_0._heroList, var_27_17)
				end
			end
		end

		arg_27_0:_refreshHeroItemPos()

		local var_27_18 = "-100000"

		if var_27_10[var_27_18] then
			local var_27_19 = var_27_10[var_27_18].equipUid and var_27_10[var_27_18].equipUid[1]

			if var_27_19 and var_27_19 ~= "0" then
				gohelper.setActive(arg_27_0._gosupercard, true)
				arg_27_0:openSubView(Season3_0CelebrityCardGetItem, Season3_0CelebrityCardItem.AssetPath, arg_27_0._gosupercard, var_27_19, true)
			end
		end
	else
		FightRpc.instance:sendGetFightRecordGroupRequest(var_27_2.episodeId)
	end
end

function var_0_0._refreshHeroItemPos(arg_28_0)
	local var_28_0 = arg_28_0._heroList and #arg_28_0._heroList or 0

	if var_28_0 <= 0 then
		return
	end

	local var_28_1 = var_0_1[var_28_0]

	for iter_28_0 = 1, var_28_0 do
		recthelper.setAnchor(arg_28_0._heroList[iter_28_0].viewGO.transform.parent, var_28_1[iter_28_0].x, var_28_1[iter_28_0].y)
	end
end

function var_0_0._onGetFightRecordGroupReply(arg_29_0, arg_29_1)
	for iter_29_0 = 1, 4 do
		local var_29_0 = arg_29_0._hero_obj_list[iter_29_0]
		local var_29_1 = arg_29_1:getHeroByIndex(iter_29_0)
		local var_29_2 = arg_29_1.replay_equip_data[var_29_1]
		local var_29_3 = arg_29_1.replay_activity104Equip_data[var_29_1]
		local var_29_4 = arg_29_1.replay_hero_data[var_29_1]

		if not var_29_4 then
			for iter_29_1, iter_29_2 in pairs(arg_29_1.replay_hero_data) do
				if iter_29_2.heroId == var_29_1 then
					var_29_4 = iter_29_2

					break
				end
			end
		end

		local var_29_5 = arg_29_0:openSubView(Season3_0SettlementHeroItem, var_29_0, nil, true, var_29_1, var_29_2, var_29_3, var_29_4)

		if var_29_1 ~= "0" then
			table.insert(arg_29_0._heroList, var_29_5)
		end
	end

	local var_29_6 = "-100000"

	if arg_29_1.replay_activity104Equip_data[var_29_6] then
		local var_29_7 = arg_29_1.replay_activity104Equip_data[var_29_6][1].equipId

		gohelper.setActive(arg_29_0._gosupercard, var_29_7 ~= 0)
		arg_29_0:openSubView(Season3_0CelebrityCardGetItem, Season3_0CelebrityCardItem.AssetPath, arg_29_0._gosupercard, nil, nil, var_29_7)
	end
end

function var_0_0._showAwardTipsData(arg_30_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_clearing_unfold)

	arg_30_0._startTime = Time.realtimeSinceStartup

	gohelper.setActive(arg_30_0._gorewardtip, #arg_30_0._reward_list > 0)
	arg_30_0:_releaseAwardImage()
	arg_30_0:com_createObjList(arg_30_0._onAwardItemShow, arg_30_0._reward_list, arg_30_0._awardcontent, arg_30_0._gorewardtipitem)
	arg_30_0:_showPassData()
end

function var_0_0._showPassData(arg_31_0)
	local var_31_0 = Activity104Model.instance:getBattleFinishLayer()
	local var_31_1 = gohelper.findChild(arg_31_0.viewGO, "#go_tips/layout/vertical/mask/#go_scrolllv/Viewport/Content")
	local var_31_2 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), var_31_0 - 1)
	local var_31_3 = string.format("%02d", var_31_0 - 1)

	if not var_31_2 then
		var_31_3 = ""

		gohelper.setActive(gohelper.findChild(var_31_1, "#text1/pass"), false)
	end

	gohelper.findChildText(var_31_1, "#text1/#txt_passindex1").text = var_31_3

	local var_31_4 = string.format("%02d", var_31_0)

	gohelper.findChildText(var_31_1, "#text2/#txt_selectindex1").text = var_31_4

	local var_31_5 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), var_31_0 + 1)

	gohelper.setActive(gohelper.findChild(var_31_1, "#text3"), var_31_5)

	local var_31_6 = string.format("%02d", var_31_0 + 1)

	gohelper.findChildText(var_31_1, "#text3/#txt_passindex1").text = var_31_6

	local var_31_7 = gohelper.findChild(var_31_1, "maxlayer")

	gohelper.setActive(var_31_7, not var_31_5)
	gohelper.setActive(gohelper.findChild(var_31_1, "seleted"), var_31_5)
end

function var_0_0._releaseAwardImage(arg_32_0)
	if arg_32_0._awardImage then
		for iter_32_0, iter_32_1 in ipairs(arg_32_0._awardImage) do
			iter_32_1:UnLoadImage()
		end
	end

	if arg_32_0._awardClick then
		for iter_32_2, iter_32_3 in ipairs(arg_32_0._awardClick) do
			iter_32_3:RemoveClickListener()
		end
	end

	arg_32_0._awardImage = arg_32_0:getUserDataTb_()
	arg_32_0._awardClick = arg_32_0:getUserDataTb_()
end

function var_0_0._onAwardItemShow(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = gohelper.findChildSingleImage(arg_33_1, "simage_reward")
	local var_33_1 = gohelper.findChild(arg_33_1, "#go_headiconpos")
	local var_33_2 = gohelper.findChildSingleImage(var_33_1, "#simage_headicon")
	local var_33_3, var_33_4 = ItemModel.instance:getItemConfigAndIcon(arg_33_2.materilType, arg_33_2.materilId, true)

	if var_33_3.subType == ItemEnum.SubType.Portrait then
		gohelper.setActive(var_33_1, true)
		gohelper.setActive(var_33_0.gameObject, false)
		var_33_2:LoadImage(var_33_4)
	else
		gohelper.setActive(var_33_1, false)
		gohelper.setActive(var_33_0.gameObject, true)
		var_33_0:LoadImage(var_33_4)
	end

	table.insert(arg_33_0._awardImage, var_33_2)
	table.insert(arg_33_0._awardImage, var_33_0)

	gohelper.findChildText(arg_33_1, "txt_rewardcount").text = luaLang("multiple") .. arg_33_2.quantity

	local var_33_5 = gohelper.findChildImage(arg_33_1, "image_bg")
	local var_33_6 = var_33_3.rare or 5

	UISpriteSetMgr.instance:setSeasonSprite(var_33_5, "img_pz_" .. var_33_6, true)

	local var_33_7 = gohelper.findChildImage(arg_33_1, "image_circle")

	UISpriteSetMgr.instance:setSeasonSprite(var_33_7, "bg_pinjidi_lanse_" .. var_33_6)

	local var_33_8 = gohelper.findChildClick(arg_33_1, "btnClick")

	var_33_8:AddClickListener(arg_33_0._onAwardItemClick, arg_33_0, arg_33_2)
	table.insert(arg_33_0._awardClick, var_33_8)

	if arg_33_2.materilType == MaterialEnum.MaterialType.EquipCard then
		local var_33_9 = Season3_0CelebrityCardItem.New()

		var_33_9:init(gohelper.findChild(arg_33_1, "cardicon"), arg_33_2.materilId)

		arg_33_0._equipAwardCards = arg_33_0._equipAwardCards or {}

		table.insert(arg_33_0._equipAwardCards, var_33_9)
		gohelper.setActive(gohelper.findChild(arg_33_1, "image_circle"), false)
		gohelper.setActive(gohelper.findChild(arg_33_1, "simage_reward"), false)
		gohelper.setActive(gohelper.findChild(arg_33_1, "image_bg"), false)
	end
end

function var_0_0._onAwardItemClick(arg_34_0, arg_34_1)
	MaterialTipController.instance:showMaterialInfo(arg_34_1.materilType, arg_34_1.materilId)
end

function var_0_0.onClose(arg_35_0)
	if arg_35_0._equipAwardCards then
		for iter_35_0, iter_35_1 in ipairs(arg_35_0._equipAwardCards) do
			iter_35_1:destroy()
		end

		arg_35_0._equipAwardCards = nil
	end

	if arg_35_0._showTipsFlow then
		arg_35_0._showTipsFlow:stop()

		arg_35_0._showTipsFlow = nil
	end

	TaskDispatcher.cancelTask(arg_35_0._showHeroItem, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._dailyShowHero, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._showGetCardView, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._btnclosetipOnClick, arg_35_0)
	arg_35_0._simagedecorate6:UnLoadImage()
	arg_35_0._simagedecorate10:UnLoadImage()
	arg_35_0._simagefightsuccbg:UnLoadImage()
	arg_35_0._simageherodecorate:UnLoadImage()
	arg_35_0._simagespecialbg:UnLoadImage()

	if FightResultModel.instance.canUpdateDungeonRecord and not arg_35_0._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end

	arg_35_0:_releaseAwardImage()
end

return var_0_0
