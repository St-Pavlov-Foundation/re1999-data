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
	if arg_29_0._enterConfig then
		DungeonModel.instance:setLastSelectMode(arg_29_0._chapterType, arg_29_0._enterConfig.id)
	end

	local var_29_0 = DungeonConfig.instance:getEpisodeCO(arg_29_0._episodeId)

	DungeonFightController.instance:enterFight(var_29_0.chapterId, arg_29_0._episodeId, arg_29_0._curSpeed)
end

function var_0_0._editableInitView(arg_30_0)
	local var_30_0 = gohelper.findChild(arg_30_0.viewGO, "anim")

	arg_30_0._animator = var_30_0 and var_30_0:GetComponent(typeof(UnityEngine.Animator))
	arg_30_0._simageList = arg_30_0:getUserDataTb_()

	arg_30_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_30_0._onCurrencyChange, arg_30_0)
	arg_30_0._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	arg_30_0._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	arg_30_0._rulesimageList = arg_30_0:getUserDataTb_()
	arg_30_0._rulesimagelineList = arg_30_0:getUserDataTb_()
	arg_30_0._rewarditems = arg_30_0:getUserDataTb_()
	arg_30_0._enemyitems = arg_30_0:getUserDataTb_()
	arg_30_0._episodeItemParam = arg_30_0:getUserDataTb_()

	gohelper.removeUIClickAudio(arg_30_0._btncloseview.gameObject)
	gohelper.removeUIClickAudio(arg_30_0._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(arg_30_0._btnhardmode.gameObject)
	gohelper.addUIClickAudio(arg_30_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
end

function var_0_0._initStar(arg_31_0)
	gohelper.setActive(arg_31_0._gostar, true)

	arg_31_0._starImgList = arg_31_0:getUserDataTb_()

	local var_31_0 = arg_31_0._gostar.transform
	local var_31_1 = var_31_0.childCount

	for iter_31_0 = 1, var_31_1 do
		local var_31_2 = var_31_0:GetChild(iter_31_0 - 1):GetComponent(gohelper.Type_Image)

		table.insert(arg_31_0._starImgList, var_31_2)
	end
end

function var_0_0.showStatus(arg_32_0)
	local var_32_0 = arg_32_0._config.id
	local var_32_1 = DungeonModel.instance:isOpenHardDungeon(arg_32_0._config.chapterId)
	local var_32_2 = var_32_0 and DungeonModel.instance:hasPassLevelAndStory(var_32_0)
	local var_32_3 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_32_0)
	local var_32_4 = arg_32_0._episodeInfo
	local var_32_5 = DungeonConfig.instance:getHardEpisode(arg_32_0._config.id)
	local var_32_6 = var_32_5 and DungeonModel.instance:getEpisodeInfo(var_32_5.id)
	local var_32_7 = arg_32_0._starImgList[4]
	local var_32_8 = arg_32_0._starImgList[3]
	local var_32_9 = arg_32_0._starImgList[2]

	arg_32_0:_setStar(arg_32_0._starImgList[1], var_32_4.star >= DungeonEnum.StarType.Normal and var_32_2, 1)

	if not string.nilorempty(var_32_3) then
		arg_32_0:_setStar(var_32_9, var_32_4.star >= DungeonEnum.StarType.Advanced and var_32_2, 2)

		if var_32_5 then
			local var_32_10 = DungeonModel.instance:episodeIsInLockTime(var_32_5.id)

			gohelper.setActive(var_32_8, not var_32_10)
			gohelper.setActive(var_32_7, not var_32_10)
		end

		if var_32_6 and var_32_4.star >= DungeonEnum.StarType.Advanced and var_32_1 and var_32_2 then
			arg_32_0:_setStar(var_32_8, var_32_6.star >= DungeonEnum.StarType.Normal, 3)
			arg_32_0:_setStar(var_32_7, var_32_6.star >= DungeonEnum.StarType.Advanced, 4)
		end
	end

	if arg_32_0._simpleConfig then
		local var_32_11 = var_32_4.star >= DungeonEnum.StarType.Normal and var_32_2

		arg_32_0._setStarN(arg_32_0._imgnormalstar1s, var_32_11, 2)
		arg_32_0._setStarN(arg_32_0._imgnormalstar1ru, var_32_11, 2)
		arg_32_0._setStarN(arg_32_0._imgnormalstar1lu, var_32_11, 2)

		local var_32_12 = var_32_4.star >= DungeonEnum.StarType.Advanced and var_32_2

		arg_32_0._setStarN(arg_32_0._imgnormalstar2s, var_32_12, 2)
		arg_32_0._setStarN(arg_32_0._imgnormalstar2ru, var_32_12, 2)
		arg_32_0._setStarN(arg_32_0._imgnormalstar2lu, var_32_12, 2)

		local var_32_13 = DungeonModel.instance:hasPassLevelAndStory(arg_32_0._simpleConfig.id)

		arg_32_0._setStarN(arg_32_0._imgstorystar1s, var_32_13, 1)
		arg_32_0._setStarN(arg_32_0._imgstorystar1u, var_32_13, 1)

		if var_32_5 then
			local var_32_14 = DungeonModel.instance:episodeIsInLockTime(var_32_5.id)

			gohelper.setActive(arg_32_0._imghardstar1s, not var_32_14)
			gohelper.setActive(arg_32_0._imghardstar1u, not var_32_14)
			gohelper.setActive(arg_32_0._imghardstar2s, not var_32_14)
			gohelper.setActive(arg_32_0._imghardstar2u, not var_32_14)

			local var_32_15 = DungeonModel.instance:getEpisodeInfo(var_32_5.id)

			if var_32_15 and var_32_4.star >= DungeonEnum.StarType.Advanced and var_32_1 and var_32_2 then
				local var_32_16 = var_32_15.star >= DungeonEnum.StarType.Normal
				local var_32_17 = var_32_15.star >= DungeonEnum.StarType.Advanced

				arg_32_0._setStarN(arg_32_0._imghardstar1s, var_32_16, 3)
				arg_32_0._setStarN(arg_32_0._imghardstar1u, var_32_16, 3)
				arg_32_0._setStarN(arg_32_0._imghardstar2s, var_32_17, 3)
				arg_32_0._setStarN(arg_32_0._imghardstar2u, var_32_17, 3)
			else
				arg_32_0._setStarN(arg_32_0._imghardstar1s, false, 3)
				arg_32_0._setStarN(arg_32_0._imghardstar1u, false, 3)
				arg_32_0._setStarN(arg_32_0._imghardstar2s, false, 3)
				arg_32_0._setStarN(arg_32_0._imghardstar2u, false, 3)
			end
		end
	end
end

function var_0_0._setStar(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = "#9B9B9B"

	if arg_33_2 then
		var_33_0 = arg_33_3 > 2 and "#FF4343" or "#F97142"
		arg_33_1.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_33_1, var_33_0)
end

function var_0_0._onCurrencyChange(arg_34_0, arg_34_1)
	if not arg_34_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_34_0:refreshCostPower()
end

function var_0_0.onUpdateParam(arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0.closeThis, arg_35_0)
	arg_35_0:_initInfo()
	arg_35_0.viewContainer:refreshHelp()
	arg_35_0:showStatus()
	arg_35_0:_doUpdate()
	arg_35_0:checkSendGuideEvent()
end

function var_0_0._addRuleItem(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = gohelper.clone(arg_36_0._goruletemp, arg_36_0._gorulelist, arg_36_1.id)

	gohelper.setActive(var_36_0, true)

	local var_36_1 = gohelper.findChildImage(var_36_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_36_1, "wz_" .. arg_36_2)

	local var_36_2 = gohelper.findChildImage(var_36_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_36_2, arg_36_1.icon)
end

function var_0_0._setRuleDescItem(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_37_1 = gohelper.clone(arg_37_0._goruleitem, arg_37_0._goruleDescList, arg_37_1.id)

	gohelper.setActive(var_37_1, true)

	local var_37_2 = gohelper.findChildImage(var_37_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_37_2, arg_37_1.icon)

	local var_37_3 = gohelper.findChild(var_37_1, "line")

	table.insert(arg_37_0._rulesimagelineList, var_37_3)

	local var_37_4 = gohelper.findChildImage(var_37_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_37_4, "wz_" .. arg_37_2)

	gohelper.findChildText(var_37_1, "desc").text = string.format("<color=%s>[%s]</color>%s", var_37_0[arg_37_2], luaLang("dungeon_add_rule_target_" .. arg_37_2), arg_37_1.desc)
end

function var_0_0.onOpen(arg_38_0)
	arg_38_0:_initInfo()
	arg_38_0:showStatus()
	arg_38_0:_doUpdate()
	arg_38_0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, arg_38_0._OnUnlockNewChapter, arg_38_0)
	arg_38_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_38_0.viewContainer.refreshHelp, arg_38_0.viewContainer)
	arg_38_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_38_0._onUpdateDungeonInfo, arg_38_0)
	arg_38_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_38_0.showDoubleDrop, arg_38_0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, arg_38_0._btncloseOnClick, arg_38_0)

	if not arg_38_0.viewParam[var_0_1.isJumpOpen] then
		arg_38_0:checkSendGuideEvent()
	end
end

function var_0_0._onUpdateDungeonInfo(arg_39_0)
	local var_39_0 = DungeonConfig.instance:getChapterCO(arg_39_0._config.chapterId)

	arg_39_0:showFree(var_39_0)
end

function var_0_0._OnUnlockNewChapter(arg_40_0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function var_0_0._doUpdate(arg_41_0)
	local var_41_0 = arg_41_0.viewParam[5]
	local var_41_1, var_41_2 = DungeonModel.instance:getLastSelectMode()

	if var_41_0 or var_41_1 == DungeonEnum.ChapterType.Hard then
		if arg_41_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
			arg_41_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_41_0._enterConfig.id)

			if arg_41_0._hardEpisode then
				arg_41_0._config = arg_41_0._hardEpisode

				arg_41_0:_showEpisodeMode(true, false)
				arg_41_0._animator:Play("dungeonlevel_in_hard", 0, 0)

				return
			end
		end
	elseif var_41_1 == DungeonEnum.ChapterType.Simple and arg_41_0._simpleConfig then
		arg_41_0._config = arg_41_0._simpleConfig

		arg_41_0:_showEpisodeMode(false, false)
		arg_41_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	if arg_41_0._simpleConfig and arg_41_0:checkFirstDisplay() and DungeonModel.instance:getLastFightEpisodePassMode(arg_41_0._enterConfig) == DungeonEnum.ChapterType.Simple then
		arg_41_0._config = arg_41_0._simpleConfig

		arg_41_0:_showEpisodeMode(false, false)
		arg_41_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	arg_41_0:onUpdate()
	arg_41_0._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function var_0_0._initInfo(arg_42_0)
	arg_42_0._enterConfig = arg_42_0.viewParam[1]
	arg_42_0._simpleConfig = DungeonConfig.instance:getSimpleEpisode(arg_42_0._enterConfig)
	arg_42_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_42_0._enterConfig.id)
	arg_42_0._config = arg_42_0._enterConfig
	arg_42_0._chapterIndex = arg_42_0.viewParam[3]
	arg_42_0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_42_0._config.chapterId, arg_42_0._config.id)

	arg_42_0:_updateEpisodeInfo()

	if arg_42_0.viewParam[var_0_1.isJumpOpen] then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, arg_42_0._config.id)
	end

	arg_42_0:refreshTitleField()
end

var_0_0.BtnOutScreenTime = 0.3

function var_0_0.onUpdate(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = DungeonConfig.instance:getChapterCO(arg_43_0._config.chapterId)
	local var_43_1 = var_43_0.type
	local var_43_2 = var_43_1 == DungeonEnum.ChapterType.Hard

	if arg_43_0._chapterType ~= var_43_1 and arg_43_0._animator then
		local var_43_3 = var_43_2 and "hard" or "normal"

		arg_43_0._animator:Play(var_43_3, 0, 0)
		arg_43_0._animator:Update(0)
	end

	arg_43_0._chapterType = var_43_1

	arg_43_0._gonormal2:SetActive(false)

	if arg_43_2 then
		TaskDispatcher.cancelTask(arg_43_0._delayToSwitchStartBtn, arg_43_0)
		TaskDispatcher.runDelay(arg_43_0._delayToSwitchStartBtn, arg_43_0, var_0_0.BtnOutScreenTime)
	else
		arg_43_0:_delayToSwitchStartBtn()
	end

	gohelper.setActive(arg_43_0._goselectstorybg, var_43_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_43_0._gounselectstorybg, var_43_1 ~= DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_43_0._goselectnormalbgN, var_43_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_43_0._gounselectnormalbgr, var_43_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_43_0._gounselectnormalbgl, var_43_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_43_0._goselecthardbgN, var_43_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_43_0._gounselecthardbgN, var_43_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_43_0._simagenormalbg, var_43_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_43_0._simagehardbg, var_43_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_43_0._gohardmodedecorate, var_43_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_43_0._goselecthardbg, var_43_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_43_0._gounselecthardbg, var_43_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_43_0._goselectnormalbg, var_43_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_43_0._gounselectnormalbg, var_43_1 == DungeonEnum.ChapterType.Hard)

	arg_43_0._episodeId = arg_43_0._config.id

	local var_43_4 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_43_5 = ResUrl.getCurrencyItemIcon(var_43_4.icon .. "_btn")

	arg_43_0._simagepower2:LoadImage(var_43_5)
	arg_43_0._simagepower3:LoadImage(var_43_5)
	gohelper.setActive(arg_43_0._goboss, arg_43_0:_isBossTypeEpisode(var_43_2))
	gohelper.setActive(arg_43_0._gonormaleye, not var_43_2)
	gohelper.setActive(arg_43_0._gohardeye, var_43_2)

	if arg_43_0._config.battleId ~= 0 then
		gohelper.setActive(arg_43_0._gorecommond, true)

		local var_43_6 = var_43_1 == DungeonEnum.ChapterType.Simple
		local var_43_7 = DungeonHelper.getEpisodeRecommendLevel(arg_43_0._episodeId, var_43_6)

		if var_43_7 ~= 0 then
			gohelper.setActive(arg_43_0._gorecommond, true)

			arg_43_0._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(var_43_7)
		else
			gohelper.setActive(arg_43_0._gorecommond, false)
		end
	else
		gohelper.setActive(arg_43_0._gorecommond, false)
	end

	arg_43_0:setTitleDesc()
	arg_43_0:showFree(var_43_0)
	arg_43_0:showDoubleDrop()

	arg_43_0._txttitle3.text = string.format("%02d", arg_43_0._levelIndex)
	arg_43_0._txtchapterindex.text = var_43_0.chapterIndex

	if arg_43_2 then
		TaskDispatcher.cancelTask(arg_43_0.refreshCostPower, arg_43_0)
		TaskDispatcher.runDelay(arg_43_0.refreshCostPower, arg_43_0, var_0_0.BtnOutScreenTime)
	else
		arg_43_0:refreshCostPower()
	end

	arg_43_0:refreshChallengeLimit()
	arg_43_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_43_0.refreshChallengeLimit, arg_43_0)
	arg_43_0:onStoryStatus()
end

function var_0_0._isBossTypeEpisode(arg_44_0, arg_44_1)
	if arg_44_1 then
		if arg_44_0._config.preEpisode then
			local var_44_0 = arg_44_0._config.preEpisode

			return DungeonConfig.instance:getEpisodeCO(var_44_0).displayMark == 1
		end

		return arg_44_0._config.displayMark == 1
	else
		return arg_44_0._config.displayMark == 1
	end
end

function var_0_0._delayToSwitchStartBtn(arg_45_0)
	local var_45_0 = arg_45_0._chapterType == DungeonEnum.ChapterType.Hard

	gohelper.setActive(arg_45_0._gostartnormal, not var_45_0)
	gohelper.setActive(arg_45_0._gostarthard, var_45_0)
end

function var_0_0.showDoubleDrop(arg_46_0)
	if not arg_46_0._config then
		return
	end

	local var_46_0 = DungeonConfig.instance:getChapterCO(arg_46_0._config.chapterId)
	local var_46_1, var_46_2, var_46_3 = DoubleDropModel.instance:isShowDoubleByEpisode(arg_46_0._config.id, true)

	gohelper.setActive(arg_46_0._godoubletimes, var_46_1)

	if var_46_1 then
		local var_46_4 = {
			var_46_2,
			var_46_3
		}

		arg_46_0._txtdoubletimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), var_46_4)

		recthelper.setAnchorY(arg_46_0._gooperation.transform, -20)
		recthelper.setAnchorY(arg_46_0._btnequip.transform, -410)
	else
		recthelper.setAnchorY(arg_46_0._gooperation.transform, 0)
		recthelper.setAnchorY(arg_46_0._btnequip.transform, -390)
	end
end

function var_0_0.showFree(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_1.enterAfterFreeLimit > 0

	gohelper.setActive(arg_47_0._gorighttop, not var_47_0)

	arg_47_0._enterAfterFreeLimit = var_47_0

	if not var_47_0 then
		return
	end

	local var_47_1 = DungeonModel.instance:getChapterRemainingNum(arg_47_1.type)

	if var_47_1 <= 0 then
		var_47_0 = false
	end

	gohelper.setActive(arg_47_0._goequipmap, var_47_0)
	gohelper.setActive(arg_47_0._gooperation, not var_47_0)
	gohelper.setActive(arg_47_0._gorighttop, not var_47_0)

	arg_47_0._enterAfterFreeLimit = var_47_0

	if not var_47_0 then
		return
	end

	arg_47_0._txtfightcount.text = var_47_1 == 0 and string.format("<color=#b3afac>%s</color>", var_47_1) or var_47_1

	gohelper.setActive(arg_47_0._gofightcountbg, var_47_1 ~= 0)
	arg_47_0:_refreshFreeCost()
end

function var_0_0._refreshFreeCost(arg_48_0)
	arg_48_0._txtcostcount.text = -1 * arg_48_0._curSpeed
end

function var_0_0.showViewStory(arg_49_0)
	local var_49_0 = StoryConfig.instance:getEpisodeStoryIds(arg_49_0._config)
	local var_49_1 = false

	for iter_49_0, iter_49_1 in ipairs(var_49_0) do
		if StoryModel.instance:isStoryFinished(iter_49_1) then
			var_49_1 = true

			break
		end
	end

	if not var_49_1 then
		return
	end
end

function var_0_0.refreshChallengeLimit(arg_50_0)
	local var_50_0, var_50_1, var_50_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_50_0._episodeId)

	if var_50_0 > 0 and var_50_1 > 0 then
		local var_50_3 = ""

		if var_50_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_50_3 = luaLang("daily")
		elseif var_50_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_50_3 = luaLang("weekly")
		else
			var_50_3 = luaLang("monthly")
		end

		arg_50_0._txtchallengecountlimit.text = string.format("%s%s (%d/%d)", var_50_3, luaLang("times"), math.max(0, var_50_1 - arg_50_0._episodeInfo.challengeCount), var_50_1)
	else
		arg_50_0._txtchallengecountlimit.text = ""
	end

	arg_50_0._isCanChallenge, arg_50_0._challengeLockCode = DungeonModel.instance:isCanChallenge(arg_50_0._config)

	gohelper.setActive(arg_50_0._gostart, arg_50_0._isCanChallenge)
	gohelper.setActive(arg_50_0._golock, not arg_50_0._isCanChallenge)
end

function var_0_0.onStoryStatus(arg_51_0)
	local var_51_0 = false
	local var_51_1 = DungeonConfig.instance:getChapterCO(arg_51_0._config.chapterId)

	if arg_51_0._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_51_0._config.afterStory) and arg_51_0._episodeInfo.star > DungeonEnum.StarType.None then
		var_51_0 = true
	end

	gohelper.setActive(arg_51_0._gooperation, not var_51_0 and not arg_51_0._enterAfterFreeLimit)
	gohelper.setActive(arg_51_0._btnstory, var_51_0)

	local var_51_2 = arg_51_0._chapterType == DungeonEnum.ChapterType.Hard

	if var_51_0 then
		arg_51_0:refreshHardMode()
		arg_51_0._btnhardmode.gameObject:SetActive(false)
	elseif not var_51_2 then
		arg_51_0:refreshHardMode()
	else
		arg_51_0._btnHardModeActive = false

		TaskDispatcher.cancelTask(arg_51_0._delaySetActive, arg_51_0)
		TaskDispatcher.runDelay(arg_51_0._delaySetActive, arg_51_0, 0.2)
	end

	arg_51_0:showViewStory()

	local var_51_3, var_51_4, var_51_5 = DungeonModel.instance:getChapterListTypes()
	local var_51_6 = DungeonModel.instance:chapterListIsRoleStory()
	local var_51_7 = (not var_51_3 or arg_51_0._config.type ~= DungeonEnum.EpisodeType.Story) and not var_51_4 and not var_51_5 and not var_51_6

	gohelper.setActive(arg_51_0._goswitch, arg_51_0._simpleConfig and var_51_7)
	gohelper.setActive(arg_51_0._gonormal, not arg_51_0._simpleConfig and var_51_7)
	gohelper.setActive(arg_51_0._gohard, not arg_51_0._simpleConfig and var_51_7)
	gohelper.setActive(arg_51_0._gostar, not arg_51_0._simpleConfig and var_51_7)
	recthelper.setAnchorY(arg_51_0._txtdesc.transform, var_51_7 and 56.6 or 129.1)
	recthelper.setAnchorY(arg_51_0._gorecommond.transform, var_51_7 and 87.3 or 168.4)
	TaskDispatcher.cancelTask(arg_51_0._checkLockTime, arg_51_0)
	TaskDispatcher.runRepeat(arg_51_0._checkLockTime, arg_51_0, 1)
end

function var_0_0._checkLockTime(arg_52_0)
	local var_52_0 = DungeonConfig.instance:getHardEpisode(arg_52_0._enterConfig.id)
	local var_52_1 = arg_52_0.isInLockTime and true or false

	if var_52_0 and DungeonModel.instance:episodeIsInLockTime(var_52_0.id) then
		arg_52_0.isInLockTime = true
	else
		arg_52_0.isInLockTime = false
	end

	if var_52_1 ~= arg_52_0.isInLockTime then
		arg_52_0:showStatus()
		arg_52_0:onStoryStatus()
	elseif arg_52_0.isInLockTime then
		local var_52_2 = ServerTime.now()
		local var_52_3 = string.splitToNumber(var_52_0.lockTime, "#")

		arg_52_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_52_3[2] / 1000 - ServerTime.now())))
	end
end

function var_0_0.refreshHardMode(arg_53_0)
	arg_53_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_53_0._enterConfig.id)

	local var_53_0 = false

	if arg_53_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
		local var_53_1 = DungeonModel.instance:isOpenHardDungeon(arg_53_0._config.chapterId)

		var_53_0 = arg_53_0._hardEpisode ~= nil and var_53_1
	end

	if arg_53_0._hardEpisode and DungeonModel.instance:episodeIsInLockTime(arg_53_0._hardEpisode.id) then
		var_53_0 = false

		gohelper.setActive(arg_53_0._txtLockTime, true)

		local var_53_2 = ServerTime.now()
		local var_53_3 = string.splitToNumber(arg_53_0._hardEpisode.lockTime, "#")

		arg_53_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_53_3[2] / 1000 - ServerTime.now())))
		arg_53_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	else
		gohelper.setActive(arg_53_0._txtLockTime, false)

		arg_53_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0.1
	end

	arg_53_0._btnhardmode.gameObject:SetActive(var_53_0)
	gohelper.setActive(arg_53_0._golockbg, not var_53_0)

	arg_53_0._gohard:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_53_0 and 1 or 0.3
	arg_53_0._btnHardModeActive = var_53_0
end

function var_0_0._delaySetActive(arg_54_0)
	arg_54_0._btnhardmode.gameObject:SetActive(arg_54_0._btnHardModeActive)
end

function var_0_0.refreshCostPower(arg_55_0)
	local var_55_0 = string.split(arg_55_0._config.cost, "|")
	local var_55_1 = string.split(var_55_0[1], "#")
	local var_55_2 = tonumber(var_55_1[3] or 0) * arg_55_0._curSpeed

	arg_55_0._txtusepower.text = "-" .. var_55_2
	arg_55_0._txtusepowerhard.text = "-" .. var_55_2

	if var_55_2 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._txtusepower, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._txtusepowerhard, "#FFEAEA")
		gohelper.setActive(arg_55_0._gonormallackpower, false)
		gohelper.setActive(arg_55_0._gohardlackpower, false)
	else
		local var_55_3 = arg_55_0._chapterType == DungeonEnum.ChapterType.Hard

		SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._txtusepowerhard, "#C44945")
		gohelper.setActive(arg_55_0._gonormallackpower, not var_55_3)
		gohelper.setActive(arg_55_0._gohardlackpower, var_55_3)
	end
end

function var_0_0.onClose(arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0.closeThis, arg_56_0)
	AudioMgr.instance:trigger(arg_56_0:getCurrentChapterListTypeAudio().onClose)

	arg_56_0._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_56_0._episodeItemParam)

	if arg_56_0._rewarditems then
		for iter_56_0, iter_56_1 in ipairs(arg_56_0._rewarditems) do
			TaskDispatcher.cancelTask(iter_56_1.refreshLimitTime, iter_56_1)
		end
	end

	arg_56_0._chapterType = nil
end

function var_0_0.onCloseFinish(arg_57_0)
	return
end

function var_0_0.clearRuleList(arg_58_0)
	arg_58_0._simageList = arg_58_0:getUserDataTb_()

	for iter_58_0, iter_58_1 in pairs(arg_58_0._rulesimageList) do
		iter_58_1:UnLoadImage()
	end

	arg_58_0._rulesimageList = arg_58_0:getUserDataTb_()
	arg_58_0._rulesimagelineList = arg_58_0:getUserDataTb_()

	gohelper.destroyAllChildren(arg_58_0._gorulelist)
	gohelper.destroyAllChildren(arg_58_0._goruleDescList)
end

function var_0_0.onDestroyView(arg_59_0)
	arg_59_0._simagepower2:UnLoadImage()
	arg_59_0._simagepower3:UnLoadImage()
	arg_59_0._simagenormalbg:UnLoadImage()
	arg_59_0._simagehardbg:UnLoadImage()

	for iter_59_0, iter_59_1 in pairs(arg_59_0._rulesimageList) do
		iter_59_1:UnLoadImage()
	end

	for iter_59_2 = 1, #arg_59_0._enemyitems do
		arg_59_0._enemyitems[iter_59_2].simagemonsterhead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_59_0._delaySetActive, arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0._delayToSwitchStartBtn, arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0.refreshCostPower, arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0._checkLockTime, arg_59_0)
end

function var_0_0.refreshTitleField(arg_60_0)
	local var_60_0 = GameUtil.utf8len(arg_60_0._config.name) > 7 and arg_60_0.titleList[2] or arg_60_0.titleList[1]

	if var_60_0 == arg_60_0.curTitleItem then
		return
	end

	for iter_60_0, iter_60_1 in ipairs(arg_60_0.titleList) do
		gohelper.setActive(iter_60_1._go, iter_60_1 == var_60_0)
	end

	arg_60_0.curTitleItem = var_60_0
	arg_60_0._txttitle1 = var_60_0._txttitle1
	arg_60_0._txttitle3 = var_60_0._txttitle3
	arg_60_0._txtchapterindex = var_60_0._txtchapterindex
	arg_60_0._txttitle4 = var_60_0._txttitle4
	arg_60_0._gostar = var_60_0._gostar

	arg_60_0:_initStar()
end

function var_0_0.setTitleDesc(arg_61_0)
	arg_61_0:refreshTitleField()

	local var_61_0
	local var_61_1 = DungeonConfig.instance:getChapterTypeByEpisodeId(arg_61_0._config.id)

	if var_61_1 == DungeonEnum.ChapterType.Hard then
		var_61_0 = DungeonConfig.instance:getEpisodeCO(arg_61_0._config.preEpisode)
	elseif var_61_1 == DungeonEnum.ChapterType.Simple then
		var_61_0 = DungeonConfig.instance:getEpisodeCO(arg_61_0._config.normalEpisodeId)
	else
		var_61_0 = arg_61_0._config
	end

	arg_61_0._txtdesc.text = var_61_0.desc
	arg_61_0._txttitle4.text = var_61_0.name_En

	local var_61_2 = GameUtil.utf8sub(var_61_0.name, 1, 1)
	local var_61_3 = ""
	local var_61_4

	if GameUtil.utf8len(var_61_0.name) >= 2 then
		var_61_3 = string.format("<size=80>%s</size>", GameUtil.utf8sub(var_61_0.name, 2, GameUtil.utf8len(var_61_0.name) - 1))
	end

	arg_61_0._txttitle1.text = var_61_2 .. var_61_3

	ZProj.UGUIHelper.RebuildLayout(arg_61_0._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_61_0._txttitle4.transform)

	if GameUtil.utf8len(arg_61_0._config.name) > 2 then
		var_61_4 = recthelper.getAnchorX(arg_61_0._txttitle1.transform) + recthelper.getWidth(arg_61_0._txttitle1.transform)
	else
		var_61_4 = recthelper.getAnchorX(arg_61_0._txttitle1.transform) + recthelper.getWidth(arg_61_0._txttitle1.transform) + recthelper.getAnchorX(arg_61_0._txttitle4.transform)
	end

	recthelper.setAnchorX(arg_61_0._txttitle3.transform, var_61_4)
end

function var_0_0.getCurrentChapterListTypeAudio(arg_62_0)
	local var_62_0, var_62_1, var_62_2 = DungeonModel.instance:getChapterListTypes()
	local var_62_3

	if var_62_0 then
		var_62_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	elseif var_62_1 then
		var_62_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Resource]
	elseif var_62_2 then
		var_62_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Insight]
	else
		var_62_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	end

	return var_62_3
end

function var_0_0._setStarN(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = "#9B9B9B"

	if arg_63_1 then
		var_63_0 = arg_63_2 == 1 and "#efb974" or arg_63_2 == 2 and "#F97142" or "#FF4343"
		arg_63_0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_63_0, var_63_0)
end

function var_0_0._btnHardOnClick(arg_64_0)
	if arg_64_0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		arg_64_0:_showHardDungeonOpenTip()

		return
	end

	local var_64_0 = DungeonConfig.instance:getHardEpisode(arg_64_0._enterConfig.id)

	if var_64_0 and DungeonModel.instance:episodeIsInLockTime(var_64_0.id) then
		GameFacade.showToastString(arg_64_0._txtLockTime.text)

		return
	end

	local var_64_1 = DungeonModel.instance:getEpisodeInfo(arg_64_0._enterConfig.id)

	if not DungeonModel.instance:hasPassLevelAndStory(arg_64_0._enterConfig.id) or var_64_1.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	arg_64_0._config = arg_64_0._hardEpisode

	arg_64_0:_showEpisodeMode(true, true)
end

function var_0_0._btnNormalOnClick(arg_65_0)
	if arg_65_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_65_0._config = arg_65_0._enterConfig

	arg_65_0:_showEpisodeMode(false, true)
end

function var_0_0._btnSimpleOnClick(arg_66_0)
	if arg_66_0._chapterType == DungeonEnum.ChapterType.Simple then
		return
	end

	arg_66_0._config = arg_66_0._simpleConfig

	arg_66_0:_showEpisodeMode(false, true)
end

function var_0_0.checkSendGuideEvent(arg_67_0)
	if not arg_67_0._config then
		return
	end

	local var_67_0 = DungeonModel.instance:hasPassLevelAndStory(arg_67_0._config.id)
	local var_67_1 = DungeonConfig.instance:getEpisodeBattleId(arg_67_0._config.id)
	local var_67_2 = arg_67_0._config.chapterId

	if DungeonConfig.instance:getChapterCO(var_67_2).type == DungeonEnum.ChapterType.Normal and not var_67_0 and var_67_1 and var_67_1 ~= 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnOpenUnPassLevelGuide)
	end
end

function var_0_0.checkFirstDisplay(arg_68_0)
	local var_68_0 = PlayerModel.instance:getMyUserId()
	local var_68_1 = PlayerPrefsKey.DungeonMapLevelFirstShow .. arg_68_0._simpleConfig.id .. var_68_0

	if PlayerPrefsHelper.getNumber(var_68_1, 0) == 0 then
		PlayerPrefsHelper.setNumber(var_68_1, 1)

		return true
	end

	return false
end

return var_0_0
