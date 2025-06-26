module("modules.logic.dungeon.view.DungeonMapLevelView", package.seeall)

local var_0_0 = class("DungeonMapLevelView", BaseView)
local var_0_1 = {
	isJumpOpen = 6
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_normal")
	arg_1_0._btnhardmode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_hard/go/#btn_hardmode")
	arg_1_0._btnhardmodetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_hard/go/#btn_hardmodetip")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_hard")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bgmask/#simage_normalbg")
	arg_1_0._simagehardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bgmask/#simage_hardbg")
	arg_1_0._imagehardstatus = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_hard/#image_hardstatus")
	arg_1_0._btnnormalmode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_normal/#btn_normalmode")
	arg_1_0._txtpower = gohelper.findChildText(arg_1_0.viewGO, "anim/right/power/#txt_power")
	arg_1_0._simagepower1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/right/power/#simage_power1")
	arg_1_0._txtrule = gohelper.findChildText(arg_1_0.viewGO, "anim/right/condition/#go_additionRule/#txt_rule")
	arg_1_0._goruletemp = gohelper.findChild(arg_1_0.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp")
	arg_1_0._imagetagicon = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp/#image_tagicon")
	arg_1_0._gorulelist = gohelper.findChild(arg_1_0.viewGO, "anim/right/condition/#go_additionRule/#go_rulelist")
	arg_1_0._godefault = gohelper.findChild(arg_1_0.viewGO, "anim/right/condition/#go_default")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "anim/right/reward/#scroll_reward")
	arg_1_0._gooperation = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#btn_start")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_equipmap/#btn_equip")
	arg_1_0._txtchallengecountlimit = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#txt_challengecountlimit")
	arg_1_0._gonormal2 = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2")
	arg_1_0._goticket = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket")
	arg_1_0._btnshowtickets = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#btn_showtickets")
	arg_1_0._goticketlist = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketlist")
	arg_1_0._goticketItem = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem")
	arg_1_0._goticketinfo = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo")
	arg_1_0._simageticket = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#simage_ticket")
	arg_1_0._txtticket = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#txt_ticket")
	arg_1_0._gonoticket = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket")
	arg_1_0._txtnoticket1 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket1")
	arg_1_0._txtnoticket2 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket2")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_lock")
	arg_1_0._goequipmap = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_equipmap")
	arg_1_0._txtcostcount = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_equipmap/#btn_equip/#txt_num")
	arg_1_0._gofightcountbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_equipmap/fightcount/#go_fightcountbg")
	arg_1_0._txtfightcount = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_equipmap/fightcount/#txt_fightcount")
	arg_1_0._btnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_operation/#go_lock/#btn_lock")
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#btn_story")
	arg_1_0._btnviewstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#btn_viewstory")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_righttop")
	arg_1_0.titleList = {}

	local var_1_0 = arg_1_0:getUserDataTb_()

	var_1_0._go = gohelper.findChild(arg_1_0.viewGO, "anim/right/title")
	var_1_0._txttitle1 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title/#txt_title1")
	var_1_0._txttitle3 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title/#txt_title3")
	var_1_0._txtchapterindex = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title/#txt_title3/#txt_chapterindex")
	var_1_0._txttitle4 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title/#txt_title1/#txt_title4")
	var_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "anim/right/title/#go_star")
	arg_1_0.titleList[1] = var_1_0

	local var_1_1 = arg_1_0:getUserDataTb_()

	var_1_1._go = gohelper.findChild(arg_1_0.viewGO, "anim/right/title2")
	var_1_1._txttitle1 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title2/#txt_title1")
	var_1_1._txttitle3 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title2/#txt_title3")
	var_1_1._txtchapterindex = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title2/#txt_title3/#txt_chapterindex")
	var_1_1._txttitle4 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title2/#txt_title1/#txt_title4")
	var_1_1._gostar = gohelper.findChild(arg_1_0.viewGO, "anim/right/title2/#go_star")
	arg_1_0.titleList[2] = var_1_1
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#txt_desc")
	arg_1_0._gorecommond = gohelper.findChild(arg_1_0.viewGO, "anim/right/recommend")
	arg_1_0._txtrecommondlv = gohelper.findChildText(arg_1_0.viewGO, "anim/right/recommend/#txt_recommendlv")
	arg_1_0._simagepower2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#simage_power2")
	arg_1_0._txtusepower = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#txt_usepower")
	arg_1_0._simagepower3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#simage_power3")
	arg_1_0._txtusepowerhard = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#txt_usepowerhard")
	arg_1_0._gostartnormal = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal")
	arg_1_0._gostarthard = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard")
	arg_1_0._gohardmodedecorate = gohelper.findChild(arg_1_0.viewGO, "anim/right/title/#txt_title1/#go_hardmodedecorate")
	arg_1_0._gostoryline = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_storyline")
	arg_1_0._goselecthardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_hard/go/#go_selecthardbg")
	arg_1_0._gounselecthardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_hard/go/#go_unselecthardbg")
	arg_1_0._goselectnormalbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_normal/#go_selectnormalbg")
	arg_1_0._gounselectnormalbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_normal/#go_unselectnormalbg")
	arg_1_0._golockbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_hard/go/#go_lockbg")
	arg_1_0._txtLockTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "anim/right/#go_hard/go/#go_lockbg/#txt_locktime")
	arg_1_0._gonormallackpower = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#go_normallackpower")
	arg_1_0._gohardlackpower = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#go_hardlackpower")
	arg_1_0._goboss = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_boss")
	arg_1_0._gonormaleye = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_boss/#go_normaleye")
	arg_1_0._gohardeye = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_boss/#go_hardeye")
	arg_1_0._godoubletimes = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_doubletimes")
	arg_1_0._txtdoubletimes = gohelper.findChildTextMesh(arg_1_0.viewGO, "anim/right/#go_doubletimes/#txt_doubletimes")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch")
	arg_1_0._gostory = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_story")
	arg_1_0._btnSimpleClick = gohelper.findChildButton(arg_1_0.viewGO, "anim/right/#go_switch/#go_story/clickarea")
	arg_1_0._goselectstorybg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_story/#go_selectstorybg")
	arg_1_0._gounselectstorybg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_story/#go_unselectstorybg")
	arg_1_0._gonormalN = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal")
	arg_1_0._btnNormalClick = gohelper.findChildButton(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/clickarea")
	arg_1_0._goselectnormalbgN = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg")
	arg_1_0._gounselectnormalbgr = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right")
	arg_1_0._gounselectnormalbgl = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left")
	arg_1_0._gohardN = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard")
	arg_1_0._btnHardClick = gohelper.findChildButton(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard/clickarea")
	arg_1_0._goselecthardbgN = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg")
	arg_1_0._gounselecthardbgN = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg")
	arg_1_0._golockbgN = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard/#go_lockbg")
	arg_1_0._txtLockTimeN = gohelper.findChildTextMesh(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard/#go_lockbg/#txt_locktime")
	arg_1_0._imgstorystar1s = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_story/#go_selectstorybg/star1")
	arg_1_0._imgstorystar1u = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_story/#go_unselectstorybg/star1")
	arg_1_0._imgnormalstar1s = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg/star1")
	arg_1_0._imgnormalstar2s = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg/star2")
	arg_1_0._imgnormalstar1ru = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right/star1")
	arg_1_0._imgnormalstar2ru = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right/star2")
	arg_1_0._imgnormalstar1lu = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left/star1")
	arg_1_0._imgnormalstar2lu = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left/star2")
	arg_1_0._imghardstar1s = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg/star1")
	arg_1_0._imghardstar2s = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg/star2")
	arg_1_0._imghardstar1u = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg/star1")
	arg_1_0._imghardstar2u = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg/star2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnhardmode:AddClickListener(arg_2_0._btnhardmodeOnClick, arg_2_0)
	arg_2_0._btnhardmodetip:AddClickListener(arg_2_0._btnhardmodetipOnClick, arg_2_0)
	arg_2_0._btnnormalmode:AddClickListener(arg_2_0._btnnormalmodeOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnshowtickets:AddClickListener(arg_2_0._btnshowticketsOnClick, arg_2_0)
	arg_2_0._btnlock:AddClickListener(arg_2_0._btnlockOnClick, arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnstoryOnClick, arg_2_0)
	arg_2_0._btnSimpleClick:AddClickListener(arg_2_0._btnSimpleOnClick, arg_2_0)
	arg_2_0._btnNormalClick:AddClickListener(arg_2_0._btnNormalOnClick, arg_2_0)
	arg_2_0._btnHardClick:AddClickListener(arg_2_0._btnHardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnhardmode:RemoveClickListener()
	arg_3_0._btnhardmodetip:RemoveClickListener()
	arg_3_0._btnnormalmode:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnshowtickets:RemoveClickListener()
	arg_3_0._btnlock:RemoveClickListener()
	arg_3_0._btnstory:RemoveClickListener()
	arg_3_0._btnSimpleClick:RemoveClickListener()
	arg_3_0._btnNormalClick:RemoveClickListener()
	arg_3_0._btnHardClick:RemoveClickListener()
end

var_0_0.AudioConfig = {
	[DungeonEnum.ChapterListType.Story] = {
		onOpen = AudioEnum.UI.play_ui_checkpoint_pagesopen,
		onClose = AudioEnum.UI.UI_role_introduce_close
	},
	[DungeonEnum.ChapterListType.Resource] = {
		onOpen = AudioEnum.UI.play_ui_checkpoint_sources_open,
		onClose = AudioEnum.UI.UI_role_introduce_close
	},
	[DungeonEnum.ChapterListType.Insight] = {
		onOpen = AudioEnum.UI.UI_checkpoint_Insight_open,
		onClose = AudioEnum.UI.UI_role_introduce_close
	}
}

function var_0_0._btncloseviewOnClick(arg_4_0)
	TaskDispatcher.runDelay(arg_4_0.closeThis, arg_4_0, 0)
end

function var_0_0._btnshowrewardOnClick(arg_5_0)
	DungeonController.instance:openDungeonRewardView(arg_5_0._config)
end

function var_0_0._btnhardmodeOnClick(arg_6_0)
	if arg_6_0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		arg_6_0:_showHardDungeonOpenTip()

		return
	end

	local var_6_0 = DungeonConfig.instance:getHardEpisode(arg_6_0._enterConfig.id)

	if var_6_0 and DungeonModel.instance:episodeIsInLockTime(var_6_0.id) then
		GameFacade.showToastString(arg_6_0._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(arg_6_0._enterConfig.id) or arg_6_0._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	arg_6_0._config = arg_6_0._hardEpisode

	arg_6_0:_showEpisodeMode(true, true)
end

function var_0_0._showHardDungeonOpenTip(arg_7_0)
	local var_7_0 = lua_open.configDict[OpenEnum.UnlockFunc.HardDungeon].episodeId
	local var_7_1 = DungeonConfig.instance:getEpisodeDisplay(var_7_0)

	GameFacade.showToast(ToastEnum.DungeonMapLevel, var_7_1)
end

function var_0_0._btnhardmodetipOnClick(arg_8_0)
	if arg_8_0._config == arg_8_0._hardEpisode then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		arg_8_0:_showHardDungeonOpenTip()

		return
	end

	local var_8_0 = DungeonConfig.instance:getHardEpisode(arg_8_0._enterConfig.id)

	if var_8_0 and DungeonModel.instance:episodeIsInLockTime(var_8_0.id) then
		GameFacade.showToastString(arg_8_0._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(arg_8_0._config.id) or arg_8_0._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end
end

function var_0_0._btnnormalmodeOnClick(arg_9_0)
	if arg_9_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_9_0._config = arg_9_0._enterConfig

	arg_9_0:_showEpisodeMode(false, true)
end

function var_0_0._showEpisodeMode(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._episodeItemParam.index = arg_10_0._levelIndex
	arg_10_0._episodeItemParam.isHardMode = arg_10_1
	arg_10_0._episodeItemParam.episodeConfig = arg_10_0._config
	arg_10_0._episodeItemParam.immediately = not arg_10_2

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_10_0._episodeItemParam)
	arg_10_0:_updateEpisodeInfo()
	arg_10_0:onUpdate(arg_10_1, arg_10_2)

	if arg_10_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_switch)
	end
end

function var_0_0._updateEpisodeInfo(arg_11_0)
	arg_11_0._episodeInfo = DungeonModel.instance:getEpisodeInfo(arg_11_0._config.id)
	arg_11_0._curSpeed = 1
end

function var_0_0._btnlockOnClick(arg_12_0)
	local var_12_0 = DungeonModel.instance:getCantChallengeToast(arg_12_0._config)

	if var_12_0 then
		GameFacade.showToast(ToastEnum.CantChallengeToast, var_12_0)
	end
end

function var_0_0._btnstoryOnClick(arg_13_0)
	local var_13_0 = DungeonModel.instance:hasPassLevelAndStory(arg_13_0._config.id)
	local var_13_1 = {}

	var_13_1.mark = true
	var_13_1.episodeId = arg_13_0._config.id

	StoryController.instance:playStory(arg_13_0._config.afterStory, var_13_1, function()
		arg_13_0:onStoryStatus()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		local var_14_0 = DungeonModel.instance:hasPassLevelAndStory(arg_13_0._config.id)

		if var_14_0 and var_14_0 ~= var_13_0 then
			DungeonController.instance:showUnlockContentToast(arg_13_0._config.id)
		end

		ViewMgr.instance:closeView(arg_13_0.viewName)
	end, arg_13_0)
end

function var_0_0._showStoryPlayBackBtn(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_1 > 0 and StoryModel.instance:isStoryFinished(arg_15_1)

	gohelper.setActive(arg_15_2, var_15_0)

	if var_15_0 then
		DungeonLevelItem.showEpisodeName(arg_15_0._config, arg_15_0._chapterIndex, arg_15_0._levelIndex, arg_15_3)
	end
end

function var_0_0._showMiddleStoryPlayBackBtn(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = StoryConfig.instance:getEpisodeFightStory(arg_16_0._config)
	local var_16_1 = #var_16_0 > 0

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if not StoryModel.instance:isStoryFinished(iter_16_1) then
			var_16_1 = false

			break
		end
	end

	gohelper.setActive(arg_16_1, var_16_1)

	if var_16_1 then
		DungeonLevelItem.showEpisodeName(arg_16_0._config, arg_16_0._chapterIndex, arg_16_0._levelIndex, arg_16_2)
	end
end

function var_0_0._btnshowticketsOnClick(arg_17_0)
	return
end

function var_0_0._playMainStory(arg_18_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_18_0._config.chapterId, arg_18_0._config.id)

	local var_18_0 = {}

	var_18_0.mark = true
	var_18_0.episodeId = arg_18_0._config.id

	local var_18_1 = DungeonConfig.instance:getExtendStory(arg_18_0._config.id)

	if var_18_1 then
		local var_18_2 = {
			arg_18_0._config.beforeStory,
			var_18_1
		}

		StoryController.instance:playStories(var_18_2, var_18_0, arg_18_0.onStoryFinished, arg_18_0)
	else
		StoryController.instance:playStory(arg_18_0._config.beforeStory, var_18_0, arg_18_0.onStoryFinished, arg_18_0)
	end
end

function var_0_0.onStoryFinished(arg_19_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_19_0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(arg_19_0.viewName)
end

function var_0_0._btnequipOnClick(arg_20_0)
	if arg_20_0:_checkEquipOverflow() then
		return
	end

	arg_20_0:_enterFight()
end

function var_0_0._checkEquipOverflow(arg_21_0)
	if arg_21_0._chapterType == DungeonEnum.ChapterType.Equip then
		local var_21_0 = EquipModel.instance:getEquips()

		if tabletool.len(var_21_0) >= EquipConfig.instance:getEquipBackpackMaxCount() then
			MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.EquipOverflow, MsgBoxEnum.BoxType.Yes_No, luaLang("p_equipdecompose_decompose"), "DISSOCIATION", nil, nil, arg_21_0._onChooseDecompose, arg_21_0._onCancelDecompose, nil, arg_21_0, arg_21_0, nil)

			return true
		end
	end
end

function var_0_0._onChooseDecompose(arg_22_0)
	EquipController.instance:openEquipDecomposeView()
end

function var_0_0._onCancelDecompose(arg_23_0)
	arg_23_0:_enterFight()
end

function var_0_0._btnstartOnClick(arg_24_0)
	if DungeonEnum.MazeGamePlayEpisode[arg_24_0._config.id] then
		arg_24_0:_playStoryAndOpenMazePlayView()

		return
	end

	if arg_24_0._config.type == DungeonEnum.EpisodeType.Story then
		arg_24_0:_playMainStory()

		return
	end

	local var_24_0, var_24_1, var_24_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_24_0._episodeId)

	if var_24_0 > 0 and var_24_1 > 0 and var_24_1 <= var_24_2 then
		local var_24_3 = ""

		if var_24_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_24_3 = luaLang("time_day2")
		elseif var_24_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_24_3 = luaLang("time_week")
		else
			var_24_3 = luaLang("time_month")
		end

		GameFacade.showToast(ToastEnum.DungeonMapLevel3, var_24_3)

		return
	end

	if arg_24_0._chapterType == DungeonEnum.ChapterType.Normal and var_24_0 > 0 and var_24_1 > 0 and var_24_1 < var_24_2 then
		GameFacade.showToast(ToastEnum.DungeonMapLevel4)

		return
	end

	if DungeonConfig.instance:getChapterCO(arg_24_0._config.chapterId).type == DungeonEnum.ChapterType.RoleStory then
		arg_24_0:_startRoleStory()

		return
	end

	if arg_24_0._config.beforeStory > 0 then
		if arg_24_0._config.afterStory > 0 then
			if not StoryModel.instance:isStoryFinished(arg_24_0._config.afterStory) then
				arg_24_0:_playStoryAndEnterFight(arg_24_0._config.beforeStory)

				return
			end
		elseif arg_24_0._episodeInfo.star <= DungeonEnum.StarType.None then
			arg_24_0:_playStoryAndEnterFight(arg_24_0._config.beforeStory)

			return
		end
	end

	if arg_24_0:_checkEquipOverflow() then
		return
	end

	arg_24_0:_enterFight()
end

function var_0_0._playStoryAndOpenMazePlayView(arg_25_0)
	local var_25_0 = arg_25_0._config.beforeStory

	DungeonRpc.instance:sendStartDungeonRequest(arg_25_0._config.chapterId, arg_25_0._config.id)

	if DungeonMazeModel.instance:HasLocalProgress() then
		arg_25_0:_openMazePlayView(true)

		return
	end

	local var_25_1 = {}

	var_25_1.mark = true
	var_25_1.episodeId = arg_25_0._config.id

	StoryController.instance:playStory(var_25_0, var_25_1, arg_25_0._openMazePlayView, arg_25_0)
end

function var_0_0._openMazePlayView(arg_26_0, arg_26_1)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_26_0._config.id)

	local var_26_0 = {
		episodeCfg = arg_26_0._config,
		existProgress = arg_26_1
	}

	DungeonMazeController.instance:openMazeGameView(var_26_0)
end

function var_0_0._startRoleStory(arg_27_0)
	if arg_27_0._config.beforeStory > 0 then
		arg_27_0:_playStoryAndEnterFight(arg_27_0._config.beforeStory, true)

		return
	end

	arg_27_0:_enterFight()
end

function var_0_0._playStoryAndEnterFight(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_2 and StoryModel.instance:isStoryFinished(arg_28_1) then
		arg_28_0:_enterFight()

		return
	end

	local var_28_0 = {}

	var_28_0.mark = true
	var_28_0.episodeId = arg_28_0._config.id

	StoryController.instance:playStory(arg_28_1, var_28_0, arg_28_0._enterFight, arg_28_0)
end

function var_0_0._enterFight(arg_29_0)
	if CommandStationController.instance:chapterInCommandStation(arg_29_0._enterChapterId) then
		CommandStationController.instance:setRecordEpisodeId(arg_29_0._enterConfig.id)
	end

	if DungeonController.checkEpisodeFiveHero(arg_29_0._episodeId) then
		local var_29_0 = ModuleEnum.HeroGroupSnapshotType.FiveHero

		HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(var_29_0, arg_29_0._onRecvMsg, arg_29_0)
	else
		arg_29_0:_reallyEnterFight()
	end
end

function var_0_0._onRecvMsg(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_2 == 0 then
		arg_30_0:_reallyEnterFight()
	end
end

function var_0_0._reallyEnterFight(arg_31_0)
	if arg_31_0._enterConfig then
		DungeonModel.instance:setLastSelectMode(arg_31_0._chapterType, arg_31_0._enterConfig.id)
	end

	local var_31_0 = DungeonConfig.instance:getEpisodeCO(arg_31_0._episodeId)

	DungeonFightController.instance:enterFight(var_31_0.chapterId, arg_31_0._episodeId, arg_31_0._curSpeed)
end

function var_0_0._editableInitView(arg_32_0)
	local var_32_0 = gohelper.findChild(arg_32_0.viewGO, "anim")

	arg_32_0._animator = var_32_0 and var_32_0:GetComponent(typeof(UnityEngine.Animator))
	arg_32_0._simageList = arg_32_0:getUserDataTb_()

	arg_32_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_32_0._onCurrencyChange, arg_32_0)
	arg_32_0._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	arg_32_0._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	arg_32_0._rulesimageList = arg_32_0:getUserDataTb_()
	arg_32_0._rulesimagelineList = arg_32_0:getUserDataTb_()
	arg_32_0._rewarditems = arg_32_0:getUserDataTb_()
	arg_32_0._enemyitems = arg_32_0:getUserDataTb_()
	arg_32_0._episodeItemParam = arg_32_0:getUserDataTb_()

	gohelper.removeUIClickAudio(arg_32_0._btncloseview.gameObject)
	gohelper.removeUIClickAudio(arg_32_0._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(arg_32_0._btnhardmode.gameObject)
	gohelper.addUIClickAudio(arg_32_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
end

function var_0_0._initStar(arg_33_0)
	gohelper.setActive(arg_33_0._gostar, true)

	arg_33_0._starImgList = arg_33_0:getUserDataTb_()

	local var_33_0 = arg_33_0._gostar.transform
	local var_33_1 = var_33_0.childCount

	for iter_33_0 = 1, var_33_1 do
		local var_33_2 = var_33_0:GetChild(iter_33_0 - 1):GetComponent(gohelper.Type_Image)

		table.insert(arg_33_0._starImgList, var_33_2)
	end
end

function var_0_0.showStatus(arg_34_0)
	local var_34_0 = arg_34_0._config.id
	local var_34_1 = DungeonModel.instance:isOpenHardDungeon(arg_34_0._config.chapterId)
	local var_34_2 = var_34_0 and DungeonModel.instance:hasPassLevelAndStory(var_34_0)
	local var_34_3 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_34_0)
	local var_34_4 = arg_34_0._episodeInfo
	local var_34_5 = DungeonConfig.instance:getHardEpisode(arg_34_0._config.id)
	local var_34_6 = var_34_5 and DungeonModel.instance:getEpisodeInfo(var_34_5.id)
	local var_34_7 = arg_34_0._starImgList[4]
	local var_34_8 = arg_34_0._starImgList[3]
	local var_34_9 = arg_34_0._starImgList[2]

	arg_34_0:_setStar(arg_34_0._starImgList[1], var_34_4.star >= DungeonEnum.StarType.Normal and var_34_2, 1)

	if not string.nilorempty(var_34_3) then
		arg_34_0:_setStar(var_34_9, var_34_4.star >= DungeonEnum.StarType.Advanced and var_34_2, 2)

		if var_34_5 then
			local var_34_10 = DungeonModel.instance:episodeIsInLockTime(var_34_5.id)

			gohelper.setActive(var_34_8, not var_34_10)
			gohelper.setActive(var_34_7, not var_34_10)
		end

		if var_34_6 and var_34_4.star >= DungeonEnum.StarType.Advanced and var_34_1 and var_34_2 then
			arg_34_0:_setStar(var_34_8, var_34_6.star >= DungeonEnum.StarType.Normal, 3)
			arg_34_0:_setStar(var_34_7, var_34_6.star >= DungeonEnum.StarType.Advanced, 4)
		end
	end

	if arg_34_0._simpleConfig then
		local var_34_11 = var_34_4.star >= DungeonEnum.StarType.Normal and var_34_2

		arg_34_0._setStarN(arg_34_0._imgnormalstar1s, var_34_11, 2)
		arg_34_0._setStarN(arg_34_0._imgnormalstar1ru, var_34_11, 2)
		arg_34_0._setStarN(arg_34_0._imgnormalstar1lu, var_34_11, 2)

		local var_34_12 = var_34_4.star >= DungeonEnum.StarType.Advanced and var_34_2

		arg_34_0._setStarN(arg_34_0._imgnormalstar2s, var_34_12, 2)
		arg_34_0._setStarN(arg_34_0._imgnormalstar2ru, var_34_12, 2)
		arg_34_0._setStarN(arg_34_0._imgnormalstar2lu, var_34_12, 2)

		local var_34_13 = DungeonModel.instance:hasPassLevelAndStory(arg_34_0._simpleConfig.id)

		arg_34_0._setStarN(arg_34_0._imgstorystar1s, var_34_13, 1)
		arg_34_0._setStarN(arg_34_0._imgstorystar1u, var_34_13, 1)

		if var_34_5 then
			local var_34_14 = DungeonModel.instance:episodeIsInLockTime(var_34_5.id)

			gohelper.setActive(arg_34_0._imghardstar1s, not var_34_14)
			gohelper.setActive(arg_34_0._imghardstar1u, not var_34_14)
			gohelper.setActive(arg_34_0._imghardstar2s, not var_34_14)
			gohelper.setActive(arg_34_0._imghardstar2u, not var_34_14)

			local var_34_15 = DungeonModel.instance:getEpisodeInfo(var_34_5.id)

			if var_34_15 and var_34_4.star >= DungeonEnum.StarType.Advanced and var_34_1 and var_34_2 then
				local var_34_16 = var_34_15.star >= DungeonEnum.StarType.Normal
				local var_34_17 = var_34_15.star >= DungeonEnum.StarType.Advanced

				arg_34_0._setStarN(arg_34_0._imghardstar1s, var_34_16, 3)
				arg_34_0._setStarN(arg_34_0._imghardstar1u, var_34_16, 3)
				arg_34_0._setStarN(arg_34_0._imghardstar2s, var_34_17, 3)
				arg_34_0._setStarN(arg_34_0._imghardstar2u, var_34_17, 3)
			else
				arg_34_0._setStarN(arg_34_0._imghardstar1s, false, 3)
				arg_34_0._setStarN(arg_34_0._imghardstar1u, false, 3)
				arg_34_0._setStarN(arg_34_0._imghardstar2s, false, 3)
				arg_34_0._setStarN(arg_34_0._imghardstar2u, false, 3)
			end
		end
	end
end

function var_0_0._setStar(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = "#9B9B9B"

	if arg_35_2 then
		var_35_0 = arg_35_3 > 2 and "#FF4343" or "#F97142"
		arg_35_1.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_35_1, var_35_0)
end

function var_0_0._onCurrencyChange(arg_36_0, arg_36_1)
	if not arg_36_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_36_0:refreshCostPower()
end

function var_0_0.onUpdateParam(arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0.closeThis, arg_37_0)
	arg_37_0:_initInfo()
	arg_37_0.viewContainer:refreshHelp()
	arg_37_0:showStatus()
	arg_37_0:_doUpdate()
	arg_37_0:checkSendGuideEvent()
end

function var_0_0._addRuleItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = gohelper.clone(arg_38_0._goruletemp, arg_38_0._gorulelist, arg_38_1.id)

	gohelper.setActive(var_38_0, true)

	local var_38_1 = gohelper.findChildImage(var_38_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_38_1, "wz_" .. arg_38_2)

	local var_38_2 = gohelper.findChildImage(var_38_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_38_2, arg_38_1.icon)
end

function var_0_0._setRuleDescItem(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_39_1 = gohelper.clone(arg_39_0._goruleitem, arg_39_0._goruleDescList, arg_39_1.id)

	gohelper.setActive(var_39_1, true)

	local var_39_2 = gohelper.findChildImage(var_39_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_39_2, arg_39_1.icon)

	local var_39_3 = gohelper.findChild(var_39_1, "line")

	table.insert(arg_39_0._rulesimagelineList, var_39_3)

	local var_39_4 = gohelper.findChildImage(var_39_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_39_4, "wz_" .. arg_39_2)

	gohelper.findChildText(var_39_1, "desc").text = string.format("<color=%s>[%s]</color>%s", var_39_0[arg_39_2], luaLang("dungeon_add_rule_target_" .. arg_39_2), arg_39_1.desc)
end

function var_0_0.onOpen(arg_40_0)
	arg_40_0:_initInfo()
	arg_40_0:showStatus()
	arg_40_0:_doUpdate()
	arg_40_0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, arg_40_0._OnUnlockNewChapter, arg_40_0)
	arg_40_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_40_0.viewContainer.refreshHelp, arg_40_0.viewContainer)
	arg_40_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_40_0._onUpdateDungeonInfo, arg_40_0)
	arg_40_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_40_0.showDoubleDrop, arg_40_0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, arg_40_0._btncloseOnClick, arg_40_0)

	if not arg_40_0.viewParam[var_0_1.isJumpOpen] then
		arg_40_0:checkSendGuideEvent()
	end
end

function var_0_0._onUpdateDungeonInfo(arg_41_0)
	local var_41_0 = DungeonConfig.instance:getChapterCO(arg_41_0._config.chapterId)

	arg_41_0:showFree(var_41_0)
end

function var_0_0._OnUnlockNewChapter(arg_42_0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function var_0_0._doUpdate(arg_43_0)
	local var_43_0 = arg_43_0.viewParam[5]
	local var_43_1, var_43_2 = DungeonModel.instance:getLastSelectMode()

	if var_43_0 or var_43_1 == DungeonEnum.ChapterType.Hard then
		if arg_43_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
			arg_43_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_43_0._enterConfig.id)

			if arg_43_0._hardEpisode then
				arg_43_0._config = arg_43_0._hardEpisode

				arg_43_0:_showEpisodeMode(true, false)
				arg_43_0._animator:Play("dungeonlevel_in_hard", 0, 0)

				return
			end
		end
	elseif var_43_1 == DungeonEnum.ChapterType.Simple and arg_43_0._simpleConfig then
		arg_43_0._config = arg_43_0._simpleConfig

		arg_43_0:_showEpisodeMode(false, false)
		arg_43_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	if arg_43_0._simpleConfig and arg_43_0:checkFirstDisplay() and DungeonModel.instance:getLastFightEpisodePassMode(arg_43_0._enterConfig) == DungeonEnum.ChapterType.Simple then
		arg_43_0._config = arg_43_0._simpleConfig

		arg_43_0:_showEpisodeMode(false, false)
		arg_43_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	arg_43_0:onUpdate()
	arg_43_0._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function var_0_0._initInfo(arg_44_0)
	arg_44_0._enterConfig = arg_44_0.viewParam[1]
	arg_44_0._enterChapterId = arg_44_0._enterConfig.chapterId
	arg_44_0._simpleConfig = DungeonConfig.instance:getSimpleEpisode(arg_44_0._enterConfig)
	arg_44_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_44_0._enterConfig.id)
	arg_44_0._config = arg_44_0._enterConfig
	arg_44_0._chapterIndex = arg_44_0.viewParam[3]
	arg_44_0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_44_0._config.chapterId, arg_44_0._config.id)

	arg_44_0:_updateEpisodeInfo()

	if arg_44_0.viewParam[var_0_1.isJumpOpen] then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, arg_44_0._config.id)
	end

	arg_44_0:refreshTitleField()
end

var_0_0.BtnOutScreenTime = 0.3

function var_0_0.onUpdate(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = DungeonConfig.instance:getChapterCO(arg_45_0._config.chapterId)
	local var_45_1 = var_45_0.type
	local var_45_2 = var_45_1 == DungeonEnum.ChapterType.Hard

	if arg_45_0._chapterType ~= var_45_1 and arg_45_0._animator then
		local var_45_3 = var_45_2 and "hard" or "normal"

		arg_45_0._animator:Play(var_45_3, 0, 0)
		arg_45_0._animator:Update(0)
	end

	arg_45_0._chapterType = var_45_1

	arg_45_0._gonormal2:SetActive(false)

	if arg_45_2 then
		TaskDispatcher.cancelTask(arg_45_0._delayToSwitchStartBtn, arg_45_0)
		TaskDispatcher.runDelay(arg_45_0._delayToSwitchStartBtn, arg_45_0, var_0_0.BtnOutScreenTime)
	else
		arg_45_0:_delayToSwitchStartBtn()
	end

	gohelper.setActive(arg_45_0._goselectstorybg, var_45_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_45_0._gounselectstorybg, var_45_1 ~= DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_45_0._goselectnormalbgN, var_45_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_45_0._gounselectnormalbgr, var_45_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_45_0._gounselectnormalbgl, var_45_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_45_0._goselecthardbgN, var_45_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_45_0._gounselecthardbgN, var_45_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_45_0._simagenormalbg, var_45_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_45_0._simagehardbg, var_45_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_45_0._gohardmodedecorate, var_45_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_45_0._goselecthardbg, var_45_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_45_0._gounselecthardbg, var_45_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_45_0._goselectnormalbg, var_45_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_45_0._gounselectnormalbg, var_45_1 == DungeonEnum.ChapterType.Hard)

	arg_45_0._episodeId = arg_45_0._config.id

	local var_45_4 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_45_5 = ResUrl.getCurrencyItemIcon(var_45_4.icon .. "_btn")

	arg_45_0._simagepower2:LoadImage(var_45_5)
	arg_45_0._simagepower3:LoadImage(var_45_5)
	gohelper.setActive(arg_45_0._goboss, arg_45_0:_isBossTypeEpisode(var_45_2))
	gohelper.setActive(arg_45_0._gonormaleye, not var_45_2)
	gohelper.setActive(arg_45_0._gohardeye, var_45_2)

	if arg_45_0._config.battleId ~= 0 then
		gohelper.setActive(arg_45_0._gorecommond, true)

		local var_45_6 = var_45_1 == DungeonEnum.ChapterType.Simple
		local var_45_7 = DungeonHelper.getEpisodeRecommendLevel(arg_45_0._episodeId, var_45_6)

		if var_45_7 ~= 0 then
			gohelper.setActive(arg_45_0._gorecommond, true)

			arg_45_0._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(var_45_7)
		else
			gohelper.setActive(arg_45_0._gorecommond, false)
		end
	else
		gohelper.setActive(arg_45_0._gorecommond, false)
	end

	arg_45_0:setTitleDesc()
	arg_45_0:showFree(var_45_0)
	arg_45_0:showDoubleDrop()

	arg_45_0._txttitle3.text = string.format("%02d", arg_45_0._levelIndex)
	arg_45_0._txtchapterindex.text = var_45_0.chapterIndex

	if arg_45_2 then
		TaskDispatcher.cancelTask(arg_45_0.refreshCostPower, arg_45_0)
		TaskDispatcher.runDelay(arg_45_0.refreshCostPower, arg_45_0, var_0_0.BtnOutScreenTime)
	else
		arg_45_0:refreshCostPower()
	end

	arg_45_0:refreshChallengeLimit()
	arg_45_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_45_0.refreshChallengeLimit, arg_45_0)
	arg_45_0:onStoryStatus()
end

function var_0_0._isBossTypeEpisode(arg_46_0, arg_46_1)
	if arg_46_1 then
		if arg_46_0._config.preEpisode then
			local var_46_0 = arg_46_0._config.preEpisode

			return DungeonConfig.instance:getEpisodeCO(var_46_0).displayMark == 1
		end

		return arg_46_0._config.displayMark == 1
	else
		return arg_46_0._config.displayMark == 1
	end
end

function var_0_0._delayToSwitchStartBtn(arg_47_0)
	local var_47_0 = arg_47_0._chapterType == DungeonEnum.ChapterType.Hard

	gohelper.setActive(arg_47_0._gostartnormal, not var_47_0)
	gohelper.setActive(arg_47_0._gostarthard, var_47_0)
end

function var_0_0.showDoubleDrop(arg_48_0)
	if not arg_48_0._config then
		return
	end

	local var_48_0 = DungeonConfig.instance:getChapterCO(arg_48_0._config.chapterId)
	local var_48_1, var_48_2, var_48_3 = DoubleDropModel.instance:isShowDoubleByEpisode(arg_48_0._config.id, true)

	gohelper.setActive(arg_48_0._godoubletimes, var_48_1)

	if var_48_1 then
		local var_48_4 = {
			var_48_2,
			var_48_3
		}

		arg_48_0._txtdoubletimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), var_48_4)

		recthelper.setAnchorY(arg_48_0._gooperation.transform, -20)
		recthelper.setAnchorY(arg_48_0._btnequip.transform, -410)
	else
		recthelper.setAnchorY(arg_48_0._gooperation.transform, 0)
		recthelper.setAnchorY(arg_48_0._btnequip.transform, -390)
	end
end

function var_0_0.showFree(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_1.enterAfterFreeLimit > 0

	gohelper.setActive(arg_49_0._gorighttop, not var_49_0)

	arg_49_0._enterAfterFreeLimit = var_49_0

	if not var_49_0 then
		return
	end

	local var_49_1 = DungeonModel.instance:getChapterRemainingNum(arg_49_1.type)

	if var_49_1 <= 0 then
		var_49_0 = false
	end

	gohelper.setActive(arg_49_0._goequipmap, var_49_0)
	gohelper.setActive(arg_49_0._gooperation, not var_49_0)
	gohelper.setActive(arg_49_0._gorighttop, not var_49_0)

	arg_49_0._enterAfterFreeLimit = var_49_0

	if not var_49_0 then
		return
	end

	arg_49_0._txtfightcount.text = var_49_1 == 0 and string.format("<color=#b3afac>%s</color>", var_49_1) or var_49_1

	gohelper.setActive(arg_49_0._gofightcountbg, var_49_1 ~= 0)
	arg_49_0:_refreshFreeCost()
end

function var_0_0._refreshFreeCost(arg_50_0)
	arg_50_0._txtcostcount.text = -1 * arg_50_0._curSpeed
end

function var_0_0.showViewStory(arg_51_0)
	local var_51_0 = StoryConfig.instance:getEpisodeStoryIds(arg_51_0._config)
	local var_51_1 = false

	for iter_51_0, iter_51_1 in ipairs(var_51_0) do
		if StoryModel.instance:isStoryFinished(iter_51_1) then
			var_51_1 = true

			break
		end
	end

	if not var_51_1 then
		return
	end
end

function var_0_0.refreshChallengeLimit(arg_52_0)
	local var_52_0, var_52_1, var_52_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_52_0._episodeId)

	if var_52_0 > 0 and var_52_1 > 0 then
		local var_52_3 = ""

		if var_52_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_52_3 = luaLang("daily")
		elseif var_52_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_52_3 = luaLang("weekly")
		else
			var_52_3 = luaLang("monthly")
		end

		arg_52_0._txtchallengecountlimit.text = string.format("%s%s (%d/%d)", var_52_3, luaLang("times"), math.max(0, var_52_1 - arg_52_0._episodeInfo.challengeCount), var_52_1)
	else
		arg_52_0._txtchallengecountlimit.text = ""
	end

	arg_52_0._isCanChallenge, arg_52_0._challengeLockCode = DungeonModel.instance:isCanChallenge(arg_52_0._config)

	gohelper.setActive(arg_52_0._gostart, arg_52_0._isCanChallenge)
	gohelper.setActive(arg_52_0._golock, not arg_52_0._isCanChallenge)
end

function var_0_0.onStoryStatus(arg_53_0)
	local var_53_0 = false
	local var_53_1 = DungeonConfig.instance:getChapterCO(arg_53_0._config.chapterId)

	if arg_53_0._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_53_0._config.afterStory) and arg_53_0._episodeInfo.star > DungeonEnum.StarType.None then
		var_53_0 = true
	end

	gohelper.setActive(arg_53_0._gooperation, not var_53_0 and not arg_53_0._enterAfterFreeLimit)
	gohelper.setActive(arg_53_0._btnstory, var_53_0)

	local var_53_2 = arg_53_0._chapterType == DungeonEnum.ChapterType.Hard

	if var_53_0 then
		arg_53_0:refreshHardMode()
		arg_53_0._btnhardmode.gameObject:SetActive(false)
	elseif not var_53_2 then
		arg_53_0:refreshHardMode()
	else
		arg_53_0._btnHardModeActive = false

		TaskDispatcher.cancelTask(arg_53_0._delaySetActive, arg_53_0)
		TaskDispatcher.runDelay(arg_53_0._delaySetActive, arg_53_0, 0.2)
	end

	arg_53_0:showViewStory()

	local var_53_3, var_53_4, var_53_5 = DungeonModel.instance:getChapterListTypes()
	local var_53_6 = DungeonModel.instance:chapterListIsRoleStory()
	local var_53_7 = (not var_53_3 or arg_53_0._config.type ~= DungeonEnum.EpisodeType.Story) and not var_53_4 and not var_53_5 and not var_53_6

	gohelper.setActive(arg_53_0._goswitch, arg_53_0._simpleConfig and var_53_7)
	gohelper.setActive(arg_53_0._gonormal, not arg_53_0._simpleConfig and var_53_7)
	gohelper.setActive(arg_53_0._gohard, not arg_53_0._simpleConfig and var_53_7)
	gohelper.setActive(arg_53_0._gostar, not arg_53_0._simpleConfig and var_53_7)
	recthelper.setAnchorY(arg_53_0._txtdesc.transform, var_53_7 and 56.6 or 129.1)
	recthelper.setAnchorY(arg_53_0._gorecommond.transform, var_53_7 and 87.3 or 168.4)
	TaskDispatcher.cancelTask(arg_53_0._checkLockTime, arg_53_0)
	TaskDispatcher.runRepeat(arg_53_0._checkLockTime, arg_53_0, 1)
end

function var_0_0._checkLockTime(arg_54_0)
	local var_54_0 = DungeonConfig.instance:getHardEpisode(arg_54_0._enterConfig.id)
	local var_54_1 = arg_54_0.isInLockTime and true or false

	if var_54_0 and DungeonModel.instance:episodeIsInLockTime(var_54_0.id) then
		arg_54_0.isInLockTime = true
	else
		arg_54_0.isInLockTime = false
	end

	if var_54_1 ~= arg_54_0.isInLockTime then
		arg_54_0:showStatus()
		arg_54_0:onStoryStatus()
	elseif arg_54_0.isInLockTime then
		local var_54_2 = ServerTime.now()
		local var_54_3 = string.splitToNumber(var_54_0.lockTime, "#")

		arg_54_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_54_3[2] / 1000 - ServerTime.now())))
	end
end

function var_0_0.refreshHardMode(arg_55_0)
	arg_55_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_55_0._enterConfig.id)

	local var_55_0 = false

	if arg_55_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
		local var_55_1 = DungeonModel.instance:isOpenHardDungeon(arg_55_0._config.chapterId)

		var_55_0 = arg_55_0._hardEpisode ~= nil and var_55_1
	end

	if arg_55_0._hardEpisode and DungeonModel.instance:episodeIsInLockTime(arg_55_0._hardEpisode.id) then
		var_55_0 = false

		gohelper.setActive(arg_55_0._txtLockTime, true)

		local var_55_2 = ServerTime.now()
		local var_55_3 = string.splitToNumber(arg_55_0._hardEpisode.lockTime, "#")

		arg_55_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_55_3[2] / 1000 - ServerTime.now())))
		arg_55_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	else
		gohelper.setActive(arg_55_0._txtLockTime, false)

		arg_55_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0.1
	end

	arg_55_0._btnhardmode.gameObject:SetActive(var_55_0)
	gohelper.setActive(arg_55_0._golockbg, not var_55_0)

	arg_55_0._gohard:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_55_0 and 1 or 0.3
	arg_55_0._btnHardModeActive = var_55_0
end

function var_0_0._delaySetActive(arg_56_0)
	arg_56_0._btnhardmode.gameObject:SetActive(arg_56_0._btnHardModeActive)
end

function var_0_0.refreshCostPower(arg_57_0)
	local var_57_0 = string.split(arg_57_0._config.cost, "|")
	local var_57_1 = string.split(var_57_0[1], "#")
	local var_57_2 = tonumber(var_57_1[3] or 0) * arg_57_0._curSpeed

	arg_57_0._txtusepower.text = "-" .. var_57_2
	arg_57_0._txtusepowerhard.text = "-" .. var_57_2

	if var_57_2 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_57_0._txtusepower, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_57_0._txtusepowerhard, "#FFEAEA")
		gohelper.setActive(arg_57_0._gonormallackpower, false)
		gohelper.setActive(arg_57_0._gohardlackpower, false)
	else
		local var_57_3 = arg_57_0._chapterType == DungeonEnum.ChapterType.Hard

		SLFramework.UGUI.GuiHelper.SetColor(arg_57_0._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_57_0._txtusepowerhard, "#C44945")
		gohelper.setActive(arg_57_0._gonormallackpower, not var_57_3)
		gohelper.setActive(arg_57_0._gohardlackpower, var_57_3)
	end
end

function var_0_0.onClose(arg_58_0)
	TaskDispatcher.cancelTask(arg_58_0.closeThis, arg_58_0)
	AudioMgr.instance:trigger(arg_58_0:getCurrentChapterListTypeAudio().onClose)

	arg_58_0._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_58_0._episodeItemParam)

	if arg_58_0._rewarditems then
		for iter_58_0, iter_58_1 in ipairs(arg_58_0._rewarditems) do
			TaskDispatcher.cancelTask(iter_58_1.refreshLimitTime, iter_58_1)
		end
	end

	arg_58_0._chapterType = nil
end

function var_0_0.onCloseFinish(arg_59_0)
	return
end

function var_0_0.clearRuleList(arg_60_0)
	arg_60_0._simageList = arg_60_0:getUserDataTb_()

	for iter_60_0, iter_60_1 in pairs(arg_60_0._rulesimageList) do
		iter_60_1:UnLoadImage()
	end

	arg_60_0._rulesimageList = arg_60_0:getUserDataTb_()
	arg_60_0._rulesimagelineList = arg_60_0:getUserDataTb_()

	gohelper.destroyAllChildren(arg_60_0._gorulelist)
	gohelper.destroyAllChildren(arg_60_0._goruleDescList)
end

function var_0_0.onDestroyView(arg_61_0)
	arg_61_0._simagepower2:UnLoadImage()
	arg_61_0._simagepower3:UnLoadImage()
	arg_61_0._simagenormalbg:UnLoadImage()
	arg_61_0._simagehardbg:UnLoadImage()

	for iter_61_0, iter_61_1 in pairs(arg_61_0._rulesimageList) do
		iter_61_1:UnLoadImage()
	end

	for iter_61_2 = 1, #arg_61_0._enemyitems do
		arg_61_0._enemyitems[iter_61_2].simagemonsterhead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_61_0._delaySetActive, arg_61_0)
	TaskDispatcher.cancelTask(arg_61_0._delayToSwitchStartBtn, arg_61_0)
	TaskDispatcher.cancelTask(arg_61_0.refreshCostPower, arg_61_0)
	TaskDispatcher.cancelTask(arg_61_0._checkLockTime, arg_61_0)
end

function var_0_0.refreshTitleField(arg_62_0)
	local var_62_0 = GameUtil.utf8len(arg_62_0._config.name) > 7 and arg_62_0.titleList[2] or arg_62_0.titleList[1]

	if var_62_0 == arg_62_0.curTitleItem then
		return
	end

	for iter_62_0, iter_62_1 in ipairs(arg_62_0.titleList) do
		gohelper.setActive(iter_62_1._go, iter_62_1 == var_62_0)
	end

	arg_62_0.curTitleItem = var_62_0
	arg_62_0._txttitle1 = var_62_0._txttitle1
	arg_62_0._txttitle3 = var_62_0._txttitle3
	arg_62_0._txtchapterindex = var_62_0._txtchapterindex
	arg_62_0._txttitle4 = var_62_0._txttitle4
	arg_62_0._gostar = var_62_0._gostar

	arg_62_0:_initStar()
end

function var_0_0.setTitleDesc(arg_63_0)
	arg_63_0:refreshTitleField()

	local var_63_0
	local var_63_1 = DungeonConfig.instance:getChapterTypeByEpisodeId(arg_63_0._config.id)

	if var_63_1 == DungeonEnum.ChapterType.Hard then
		var_63_0 = DungeonConfig.instance:getEpisodeCO(arg_63_0._config.preEpisode)
	elseif var_63_1 == DungeonEnum.ChapterType.Simple then
		var_63_0 = DungeonConfig.instance:getEpisodeCO(arg_63_0._config.normalEpisodeId)
	else
		var_63_0 = arg_63_0._config
	end

	arg_63_0._txtdesc.text = var_63_0.desc
	arg_63_0._txttitle4.text = var_63_0.name_En

	local var_63_2 = GameUtil.utf8sub(var_63_0.name, 1, 1)
	local var_63_3 = ""
	local var_63_4

	if GameUtil.utf8len(var_63_0.name) >= 2 then
		var_63_3 = string.format("<size=80>%s</size>", GameUtil.utf8sub(var_63_0.name, 2, GameUtil.utf8len(var_63_0.name) - 1))
	end

	arg_63_0._txttitle1.text = var_63_2 .. var_63_3

	ZProj.UGUIHelper.RebuildLayout(arg_63_0._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_63_0._txttitle4.transform)

	if GameUtil.utf8len(arg_63_0._config.name) > 2 then
		var_63_4 = recthelper.getAnchorX(arg_63_0._txttitle1.transform) + recthelper.getWidth(arg_63_0._txttitle1.transform)
	else
		var_63_4 = recthelper.getAnchorX(arg_63_0._txttitle1.transform) + recthelper.getWidth(arg_63_0._txttitle1.transform) + recthelper.getAnchorX(arg_63_0._txttitle4.transform)
	end

	recthelper.setAnchorX(arg_63_0._txttitle3.transform, var_63_4)
end

function var_0_0.getCurrentChapterListTypeAudio(arg_64_0)
	local var_64_0, var_64_1, var_64_2 = DungeonModel.instance:getChapterListTypes()
	local var_64_3

	if var_64_0 then
		var_64_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	elseif var_64_1 then
		var_64_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Resource]
	elseif var_64_2 then
		var_64_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Insight]
	else
		var_64_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	end

	return var_64_3
end

function var_0_0._setStarN(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = "#9B9B9B"

	if arg_65_1 then
		var_65_0 = arg_65_2 == 1 and "#efb974" or arg_65_2 == 2 and "#F97142" or "#FF4343"
		arg_65_0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_65_0, var_65_0)
end

function var_0_0._btnHardOnClick(arg_66_0)
	if arg_66_0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		arg_66_0:_showHardDungeonOpenTip()

		return
	end

	local var_66_0 = DungeonConfig.instance:getHardEpisode(arg_66_0._enterConfig.id)

	if var_66_0 and DungeonModel.instance:episodeIsInLockTime(var_66_0.id) then
		GameFacade.showToastString(arg_66_0._txtLockTime.text)

		return
	end

	local var_66_1 = DungeonModel.instance:getEpisodeInfo(arg_66_0._enterConfig.id)

	if not DungeonModel.instance:hasPassLevelAndStory(arg_66_0._enterConfig.id) or var_66_1.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	arg_66_0._config = arg_66_0._hardEpisode

	arg_66_0:_showEpisodeMode(true, true)
end

function var_0_0._btnNormalOnClick(arg_67_0)
	if arg_67_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_67_0._config = arg_67_0._enterConfig

	arg_67_0:_showEpisodeMode(false, true)
end

function var_0_0._btnSimpleOnClick(arg_68_0)
	if arg_68_0._chapterType == DungeonEnum.ChapterType.Simple then
		return
	end

	arg_68_0._config = arg_68_0._simpleConfig

	arg_68_0:_showEpisodeMode(false, true)
end

function var_0_0.checkSendGuideEvent(arg_69_0)
	if not arg_69_0._config then
		return
	end

	local var_69_0 = DungeonModel.instance:hasPassLevelAndStory(arg_69_0._config.id)
	local var_69_1 = DungeonConfig.instance:getEpisodeBattleId(arg_69_0._config.id)
	local var_69_2 = arg_69_0._config.chapterId

	if DungeonConfig.instance:getChapterCO(var_69_2).type == DungeonEnum.ChapterType.Normal and not var_69_0 and var_69_1 and var_69_1 ~= 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnOpenUnPassLevelGuide)
	end
end

function var_0_0.checkFirstDisplay(arg_70_0)
	local var_70_0 = PlayerModel.instance:getMyUserId()
	local var_70_1 = PlayerPrefsKey.DungeonMapLevelFirstShow .. arg_70_0._simpleConfig.id .. var_70_0

	if PlayerPrefsHelper.getNumber(var_70_1, 0) == 0 then
		PlayerPrefsHelper.setNumber(var_70_1, 1)

		return true
	end

	return false
end

return var_0_0
