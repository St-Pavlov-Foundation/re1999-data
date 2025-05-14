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
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HardDungeon))

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

function var_0_0._btnhardmodetipOnClick(arg_7_0)
	if arg_7_0._config == arg_7_0._hardEpisode then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		local var_7_0 = lua_open.configDict[OpenEnum.UnlockFunc.HardDungeon].episodeId
		local var_7_1 = DungeonConfig.instance:getEpisodeDisplay(var_7_0)

		GameFacade.showToast(ToastEnum.DungeonMapLevel, var_7_1)

		return
	end

	local var_7_2 = DungeonConfig.instance:getHardEpisode(arg_7_0._enterConfig.id)

	if var_7_2 and DungeonModel.instance:episodeIsInLockTime(var_7_2.id) then
		GameFacade.showToastString(arg_7_0._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(arg_7_0._config.id) or arg_7_0._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end
end

function var_0_0._btnnormalmodeOnClick(arg_8_0)
	if arg_8_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_8_0._config = arg_8_0._enterConfig

	arg_8_0:_showEpisodeMode(false, true)
end

function var_0_0._showEpisodeMode(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._episodeItemParam.index = arg_9_0._levelIndex
	arg_9_0._episodeItemParam.isHardMode = arg_9_1
	arg_9_0._episodeItemParam.episodeConfig = arg_9_0._config
	arg_9_0._episodeItemParam.immediately = not arg_9_2

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_9_0._episodeItemParam)
	arg_9_0:_updateEpisodeInfo()
	arg_9_0:onUpdate(arg_9_1, arg_9_2)

	if arg_9_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_switch)
	end
end

function var_0_0._updateEpisodeInfo(arg_10_0)
	arg_10_0._episodeInfo = DungeonModel.instance:getEpisodeInfo(arg_10_0._config.id)
	arg_10_0._curSpeed = 1
end

function var_0_0._btnlockOnClick(arg_11_0)
	local var_11_0 = DungeonModel.instance:getCantChallengeToast(arg_11_0._config)

	if var_11_0 then
		GameFacade.showToast(ToastEnum.CantChallengeToast, var_11_0)
	end
end

function var_0_0._btnstoryOnClick(arg_12_0)
	local var_12_0 = DungeonModel.instance:hasPassLevelAndStory(arg_12_0._config.id)
	local var_12_1 = {}

	var_12_1.mark = true
	var_12_1.episodeId = arg_12_0._config.id

	StoryController.instance:playStory(arg_12_0._config.afterStory, var_12_1, function()
		arg_12_0:onStoryStatus()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		local var_13_0 = DungeonModel.instance:hasPassLevelAndStory(arg_12_0._config.id)

		if var_13_0 and var_13_0 ~= var_12_0 then
			DungeonController.instance:showUnlockContentToast(arg_12_0._config.id)
		end

		ViewMgr.instance:closeView(arg_12_0.viewName)
	end, arg_12_0)
end

function var_0_0._showStoryPlayBackBtn(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_1 > 0 and StoryModel.instance:isStoryFinished(arg_14_1)

	gohelper.setActive(arg_14_2, var_14_0)

	if var_14_0 then
		DungeonLevelItem.showEpisodeName(arg_14_0._config, arg_14_0._chapterIndex, arg_14_0._levelIndex, arg_14_3)
	end
end

function var_0_0._showMiddleStoryPlayBackBtn(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = StoryConfig.instance:getEpisodeFightStory(arg_15_0._config)
	local var_15_1 = #var_15_0 > 0

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if not StoryModel.instance:isStoryFinished(iter_15_1) then
			var_15_1 = false

			break
		end
	end

	gohelper.setActive(arg_15_1, var_15_1)

	if var_15_1 then
		DungeonLevelItem.showEpisodeName(arg_15_0._config, arg_15_0._chapterIndex, arg_15_0._levelIndex, arg_15_2)
	end
end

function var_0_0._btnshowticketsOnClick(arg_16_0)
	return
end

function var_0_0._playMainStory(arg_17_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_17_0._config.chapterId, arg_17_0._config.id)

	local var_17_0 = {}

	var_17_0.mark = true
	var_17_0.episodeId = arg_17_0._config.id

	local var_17_1 = DungeonConfig.instance:getExtendStory(arg_17_0._config.id)

	if var_17_1 then
		local var_17_2 = {
			arg_17_0._config.beforeStory,
			var_17_1
		}

		StoryController.instance:playStories(var_17_2, var_17_0, arg_17_0.onStoryFinished, arg_17_0)
	else
		StoryController.instance:playStory(arg_17_0._config.beforeStory, var_17_0, arg_17_0.onStoryFinished, arg_17_0)
	end
end

function var_0_0.onStoryFinished(arg_18_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_18_0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(arg_18_0.viewName)
end

function var_0_0._btnequipOnClick(arg_19_0)
	if arg_19_0:_checkEquipOverflow() then
		return
	end

	arg_19_0:_enterFight()
end

function var_0_0._checkEquipOverflow(arg_20_0)
	if arg_20_0._chapterType == DungeonEnum.ChapterType.Equip then
		local var_20_0 = EquipModel.instance:getEquips()

		if tabletool.len(var_20_0) >= EquipConfig.instance:getEquipBackpackMaxCount() then
			MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.EquipOverflow, MsgBoxEnum.BoxType.Yes_No, luaLang("p_equipdecompose_decompose"), "DISSOCIATION", nil, nil, arg_20_0._onChooseDecompose, arg_20_0._onCancelDecompose, nil, arg_20_0, arg_20_0, nil)

			return true
		end
	end
end

function var_0_0._onChooseDecompose(arg_21_0)
	EquipController.instance:openEquipDecomposeView()
end

function var_0_0._onCancelDecompose(arg_22_0)
	arg_22_0:_enterFight()
end

function var_0_0._btnstartOnClick(arg_23_0)
	if arg_23_0._config.type == DungeonEnum.EpisodeType.Story then
		arg_23_0:_playMainStory()

		return
	end

	local var_23_0, var_23_1, var_23_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_23_0._episodeId)

	if var_23_0 > 0 and var_23_1 > 0 and var_23_1 <= var_23_2 then
		local var_23_3 = ""

		if var_23_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_23_3 = luaLang("time_day2")
		elseif var_23_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_23_3 = luaLang("time_week")
		else
			var_23_3 = luaLang("time_month")
		end

		GameFacade.showToast(ToastEnum.DungeonMapLevel3, var_23_3)

		return
	end

	if arg_23_0._chapterType == DungeonEnum.ChapterType.Normal and var_23_0 > 0 and var_23_1 > 0 and var_23_1 < var_23_2 then
		GameFacade.showToast(ToastEnum.DungeonMapLevel4)

		return
	end

	if DungeonConfig.instance:getChapterCO(arg_23_0._config.chapterId).type == DungeonEnum.ChapterType.RoleStory then
		arg_23_0:_startRoleStory()

		return
	end

	if arg_23_0._config.beforeStory > 0 then
		if arg_23_0._config.afterStory > 0 then
			if not StoryModel.instance:isStoryFinished(arg_23_0._config.afterStory) then
				arg_23_0:_playStoryAndEnterFight(arg_23_0._config.beforeStory)

				return
			end
		elseif arg_23_0._episodeInfo.star <= DungeonEnum.StarType.None then
			arg_23_0:_playStoryAndEnterFight(arg_23_0._config.beforeStory)

			return
		end
	end

	if arg_23_0:_checkEquipOverflow() then
		return
	end

	arg_23_0:_enterFight()
end

function var_0_0._startRoleStory(arg_24_0)
	if arg_24_0._config.beforeStory > 0 then
		arg_24_0:_playStoryAndEnterFight(arg_24_0._config.beforeStory, true)

		return
	end

	arg_24_0:_enterFight()
end

function var_0_0._playStoryAndEnterFight(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_2 and StoryModel.instance:isStoryFinished(arg_25_1) then
		arg_25_0:_enterFight()

		return
	end

	local var_25_0 = {}

	var_25_0.mark = true
	var_25_0.episodeId = arg_25_0._config.id

	StoryController.instance:playStory(arg_25_1, var_25_0, arg_25_0._enterFight, arg_25_0)
end

function var_0_0._enterFight(arg_26_0)
	if arg_26_0._enterConfig then
		DungeonModel.instance:setLastSelectMode(arg_26_0._chapterType, arg_26_0._enterConfig.id)
	end

	local var_26_0 = DungeonConfig.instance:getEpisodeCO(arg_26_0._episodeId)

	DungeonFightController.instance:enterFight(var_26_0.chapterId, arg_26_0._episodeId, arg_26_0._curSpeed)
end

function var_0_0._editableInitView(arg_27_0)
	local var_27_0 = gohelper.findChild(arg_27_0.viewGO, "anim")

	arg_27_0._animator = var_27_0 and var_27_0:GetComponent(typeof(UnityEngine.Animator))
	arg_27_0._simageList = arg_27_0:getUserDataTb_()

	arg_27_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_27_0._onCurrencyChange, arg_27_0)
	arg_27_0._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	arg_27_0._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	arg_27_0._rulesimageList = arg_27_0:getUserDataTb_()
	arg_27_0._rulesimagelineList = arg_27_0:getUserDataTb_()
	arg_27_0._rewarditems = arg_27_0:getUserDataTb_()
	arg_27_0._enemyitems = arg_27_0:getUserDataTb_()
	arg_27_0._episodeItemParam = arg_27_0:getUserDataTb_()

	gohelper.removeUIClickAudio(arg_27_0._btncloseview.gameObject)
	gohelper.removeUIClickAudio(arg_27_0._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(arg_27_0._btnhardmode.gameObject)
	gohelper.addUIClickAudio(arg_27_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
end

function var_0_0._initStar(arg_28_0)
	gohelper.setActive(arg_28_0._gostar, true)

	arg_28_0._starImgList = arg_28_0:getUserDataTb_()

	local var_28_0 = arg_28_0._gostar.transform
	local var_28_1 = var_28_0.childCount

	for iter_28_0 = 1, var_28_1 do
		local var_28_2 = var_28_0:GetChild(iter_28_0 - 1):GetComponent(gohelper.Type_Image)

		table.insert(arg_28_0._starImgList, var_28_2)
	end
end

function var_0_0.showStatus(arg_29_0)
	local var_29_0 = arg_29_0._config.id
	local var_29_1 = DungeonModel.instance:isOpenHardDungeon(arg_29_0._config.chapterId)
	local var_29_2 = var_29_0 and DungeonModel.instance:hasPassLevelAndStory(var_29_0)
	local var_29_3 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_29_0)
	local var_29_4 = arg_29_0._episodeInfo
	local var_29_5 = DungeonConfig.instance:getHardEpisode(arg_29_0._config.id)
	local var_29_6 = var_29_5 and DungeonModel.instance:getEpisodeInfo(var_29_5.id)
	local var_29_7 = arg_29_0._starImgList[4]
	local var_29_8 = arg_29_0._starImgList[3]
	local var_29_9 = arg_29_0._starImgList[2]

	arg_29_0:_setStar(arg_29_0._starImgList[1], var_29_4.star >= DungeonEnum.StarType.Normal and var_29_2, 1)

	if not string.nilorempty(var_29_3) then
		arg_29_0:_setStar(var_29_9, var_29_4.star >= DungeonEnum.StarType.Advanced and var_29_2, 2)

		if var_29_5 then
			local var_29_10 = DungeonModel.instance:episodeIsInLockTime(var_29_5.id)

			gohelper.setActive(var_29_8, not var_29_10)
			gohelper.setActive(var_29_7, not var_29_10)
		end

		if var_29_6 and var_29_4.star >= DungeonEnum.StarType.Advanced and var_29_1 and var_29_2 then
			arg_29_0:_setStar(var_29_8, var_29_6.star >= DungeonEnum.StarType.Normal, 3)
			arg_29_0:_setStar(var_29_7, var_29_6.star >= DungeonEnum.StarType.Advanced, 4)
		end
	end

	if arg_29_0._simpleConfig then
		local var_29_11 = var_29_4.star >= DungeonEnum.StarType.Normal and var_29_2

		arg_29_0._setStarN(arg_29_0._imgnormalstar1s, var_29_11, 2)
		arg_29_0._setStarN(arg_29_0._imgnormalstar1ru, var_29_11, 2)
		arg_29_0._setStarN(arg_29_0._imgnormalstar1lu, var_29_11, 2)

		local var_29_12 = var_29_4.star >= DungeonEnum.StarType.Advanced and var_29_2

		arg_29_0._setStarN(arg_29_0._imgnormalstar2s, var_29_12, 2)
		arg_29_0._setStarN(arg_29_0._imgnormalstar2ru, var_29_12, 2)
		arg_29_0._setStarN(arg_29_0._imgnormalstar2lu, var_29_12, 2)

		local var_29_13 = DungeonModel.instance:hasPassLevelAndStory(arg_29_0._simpleConfig.id)

		arg_29_0._setStarN(arg_29_0._imgstorystar1s, var_29_13, 1)
		arg_29_0._setStarN(arg_29_0._imgstorystar1u, var_29_13, 1)

		if var_29_5 then
			local var_29_14 = DungeonModel.instance:episodeIsInLockTime(var_29_5.id)

			gohelper.setActive(arg_29_0._imghardstar1s, not var_29_14)
			gohelper.setActive(arg_29_0._imghardstar1u, not var_29_14)
			gohelper.setActive(arg_29_0._imghardstar2s, not var_29_14)
			gohelper.setActive(arg_29_0._imghardstar2u, not var_29_14)

			local var_29_15 = DungeonModel.instance:getEpisodeInfo(var_29_5.id)

			if var_29_15 and var_29_4.star >= DungeonEnum.StarType.Advanced and var_29_1 and var_29_2 then
				local var_29_16 = var_29_15.star >= DungeonEnum.StarType.Normal
				local var_29_17 = var_29_15.star >= DungeonEnum.StarType.Advanced

				arg_29_0._setStarN(arg_29_0._imghardstar1s, var_29_16, 3)
				arg_29_0._setStarN(arg_29_0._imghardstar1u, var_29_16, 3)
				arg_29_0._setStarN(arg_29_0._imghardstar2s, var_29_17, 3)
				arg_29_0._setStarN(arg_29_0._imghardstar2u, var_29_17, 3)
			else
				arg_29_0._setStarN(arg_29_0._imghardstar1s, false, 3)
				arg_29_0._setStarN(arg_29_0._imghardstar1u, false, 3)
				arg_29_0._setStarN(arg_29_0._imghardstar2s, false, 3)
				arg_29_0._setStarN(arg_29_0._imghardstar2u, false, 3)
			end
		end
	end
end

function var_0_0._setStar(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = "#9B9B9B"

	if arg_30_2 then
		var_30_0 = arg_30_3 > 2 and "#FF4343" or "#F97142"
		arg_30_1.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_30_1, var_30_0)
end

function var_0_0._onCurrencyChange(arg_31_0, arg_31_1)
	if not arg_31_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_31_0:refreshCostPower()
end

function var_0_0.onUpdateParam(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0.closeThis, arg_32_0)
	arg_32_0:_initInfo()
	arg_32_0.viewContainer:refreshHelp()
	arg_32_0:showStatus()
	arg_32_0:_doUpdate()
	arg_32_0:checkSendGuideEvent()
end

function var_0_0._addRuleItem(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = gohelper.clone(arg_33_0._goruletemp, arg_33_0._gorulelist, arg_33_1.id)

	gohelper.setActive(var_33_0, true)

	local var_33_1 = gohelper.findChildImage(var_33_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_33_1, "wz_" .. arg_33_2)

	local var_33_2 = gohelper.findChildImage(var_33_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_33_2, arg_33_1.icon)
end

function var_0_0._setRuleDescItem(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_34_1 = gohelper.clone(arg_34_0._goruleitem, arg_34_0._goruleDescList, arg_34_1.id)

	gohelper.setActive(var_34_1, true)

	local var_34_2 = gohelper.findChildImage(var_34_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_34_2, arg_34_1.icon)

	local var_34_3 = gohelper.findChild(var_34_1, "line")

	table.insert(arg_34_0._rulesimagelineList, var_34_3)

	local var_34_4 = gohelper.findChildImage(var_34_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_34_4, "wz_" .. arg_34_2)

	gohelper.findChildText(var_34_1, "desc").text = string.format("<color=%s>[%s]</color>%s", var_34_0[arg_34_2], luaLang("dungeon_add_rule_target_" .. arg_34_2), arg_34_1.desc)
end

function var_0_0.onOpen(arg_35_0)
	arg_35_0:_initInfo()
	arg_35_0:showStatus()
	arg_35_0:_doUpdate()
	arg_35_0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, arg_35_0._OnUnlockNewChapter, arg_35_0)
	arg_35_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_35_0.viewContainer.refreshHelp, arg_35_0.viewContainer)
	arg_35_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_35_0._onUpdateDungeonInfo, arg_35_0)
	arg_35_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_35_0.showDoubleDrop, arg_35_0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, arg_35_0._btncloseOnClick, arg_35_0)

	if not arg_35_0.viewParam[var_0_1.isJumpOpen] then
		arg_35_0:checkSendGuideEvent()
	end
end

function var_0_0._onUpdateDungeonInfo(arg_36_0)
	local var_36_0 = DungeonConfig.instance:getChapterCO(arg_36_0._config.chapterId)

	arg_36_0:showFree(var_36_0)
end

function var_0_0._OnUnlockNewChapter(arg_37_0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function var_0_0._doUpdate(arg_38_0)
	local var_38_0 = arg_38_0.viewParam[5]
	local var_38_1, var_38_2 = DungeonModel.instance:getLastSelectMode()

	if var_38_0 or var_38_1 == DungeonEnum.ChapterType.Hard then
		if arg_38_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
			arg_38_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_38_0._enterConfig.id)

			if arg_38_0._hardEpisode then
				arg_38_0._config = arg_38_0._hardEpisode

				arg_38_0:_showEpisodeMode(true, false)
				arg_38_0._animator:Play("dungeonlevel_in_hard", 0, 0)

				return
			end
		end
	elseif var_38_1 == DungeonEnum.ChapterType.Simple and arg_38_0._simpleConfig then
		arg_38_0._config = arg_38_0._simpleConfig

		arg_38_0:_showEpisodeMode(false, false)
		arg_38_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	if arg_38_0._simpleConfig and arg_38_0:checkFirstDisplay() and DungeonModel.instance:getLastFightEpisodePassMode(arg_38_0._enterConfig) == DungeonEnum.ChapterType.Simple then
		arg_38_0._config = arg_38_0._simpleConfig

		arg_38_0:_showEpisodeMode(false, false)
		arg_38_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	arg_38_0:onUpdate()
	arg_38_0._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function var_0_0._initInfo(arg_39_0)
	arg_39_0._enterConfig = arg_39_0.viewParam[1]
	arg_39_0._simpleConfig = DungeonConfig.instance:getSimpleEpisode(arg_39_0._enterConfig)
	arg_39_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_39_0._enterConfig.id)
	arg_39_0._config = arg_39_0._enterConfig
	arg_39_0._chapterIndex = arg_39_0.viewParam[3]
	arg_39_0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_39_0._config.chapterId, arg_39_0._config.id)

	arg_39_0:_updateEpisodeInfo()

	if arg_39_0.viewParam[var_0_1.isJumpOpen] then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, arg_39_0._config.id)
	end

	arg_39_0:refreshTitleField()
end

var_0_0.BtnOutScreenTime = 0.3

function var_0_0.onUpdate(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = DungeonConfig.instance:getChapterCO(arg_40_0._config.chapterId)
	local var_40_1 = var_40_0.type
	local var_40_2 = var_40_1 == DungeonEnum.ChapterType.Hard

	if arg_40_0._chapterType ~= var_40_1 and arg_40_0._animator then
		local var_40_3 = var_40_2 and "hard" or "normal"

		arg_40_0._animator:Play(var_40_3, 0, 0)
		arg_40_0._animator:Update(0)
	end

	arg_40_0._chapterType = var_40_1

	arg_40_0._gonormal2:SetActive(false)

	if arg_40_2 then
		TaskDispatcher.cancelTask(arg_40_0._delayToSwitchStartBtn, arg_40_0)
		TaskDispatcher.runDelay(arg_40_0._delayToSwitchStartBtn, arg_40_0, var_0_0.BtnOutScreenTime)
	else
		arg_40_0:_delayToSwitchStartBtn()
	end

	gohelper.setActive(arg_40_0._goselectstorybg, var_40_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_40_0._gounselectstorybg, var_40_1 ~= DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_40_0._goselectnormalbgN, var_40_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_40_0._gounselectnormalbgr, var_40_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_40_0._gounselectnormalbgl, var_40_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_40_0._goselecthardbgN, var_40_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_40_0._gounselecthardbgN, var_40_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_40_0._simagenormalbg, var_40_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_40_0._simagehardbg, var_40_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_40_0._gohardmodedecorate, var_40_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_40_0._goselecthardbg, var_40_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_40_0._gounselecthardbg, var_40_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_40_0._goselectnormalbg, var_40_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_40_0._gounselectnormalbg, var_40_1 == DungeonEnum.ChapterType.Hard)

	arg_40_0._episodeId = arg_40_0._config.id

	local var_40_4 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_40_5 = ResUrl.getCurrencyItemIcon(var_40_4.icon .. "_btn")

	arg_40_0._simagepower2:LoadImage(var_40_5)
	arg_40_0._simagepower3:LoadImage(var_40_5)
	gohelper.setActive(arg_40_0._goboss, arg_40_0:_isBossTypeEpisode(var_40_2))
	gohelper.setActive(arg_40_0._gonormaleye, not var_40_2)
	gohelper.setActive(arg_40_0._gohardeye, var_40_2)

	if arg_40_0._config.battleId ~= 0 then
		gohelper.setActive(arg_40_0._gorecommond, true)

		local var_40_6 = var_40_1 == DungeonEnum.ChapterType.Simple
		local var_40_7 = DungeonHelper.getEpisodeRecommendLevel(arg_40_0._episodeId, var_40_6)

		if var_40_7 ~= 0 then
			gohelper.setActive(arg_40_0._gorecommond, true)

			arg_40_0._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(var_40_7)
		else
			gohelper.setActive(arg_40_0._gorecommond, false)
		end
	else
		gohelper.setActive(arg_40_0._gorecommond, false)
	end

	arg_40_0:setTitleDesc()
	arg_40_0:showFree(var_40_0)
	arg_40_0:showDoubleDrop()

	arg_40_0._txttitle3.text = string.format("%02d", arg_40_0._levelIndex)
	arg_40_0._txtchapterindex.text = var_40_0.chapterIndex

	if arg_40_2 then
		TaskDispatcher.cancelTask(arg_40_0.refreshCostPower, arg_40_0)
		TaskDispatcher.runDelay(arg_40_0.refreshCostPower, arg_40_0, var_0_0.BtnOutScreenTime)
	else
		arg_40_0:refreshCostPower()
	end

	arg_40_0:refreshChallengeLimit()
	arg_40_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_40_0.refreshChallengeLimit, arg_40_0)
	arg_40_0:onStoryStatus()
end

function var_0_0._isBossTypeEpisode(arg_41_0, arg_41_1)
	if arg_41_1 then
		if arg_41_0._config.preEpisode then
			local var_41_0 = arg_41_0._config.preEpisode

			return DungeonConfig.instance:getEpisodeCO(var_41_0).displayMark == 1
		end

		return arg_41_0._config.displayMark == 1
	else
		return arg_41_0._config.displayMark == 1
	end
end

function var_0_0._delayToSwitchStartBtn(arg_42_0)
	local var_42_0 = arg_42_0._chapterType == DungeonEnum.ChapterType.Hard

	gohelper.setActive(arg_42_0._gostartnormal, not var_42_0)
	gohelper.setActive(arg_42_0._gostarthard, var_42_0)
end

function var_0_0.showDoubleDrop(arg_43_0)
	if not arg_43_0._config then
		return
	end

	local var_43_0 = DungeonConfig.instance:getChapterCO(arg_43_0._config.chapterId)
	local var_43_1, var_43_2, var_43_3 = DoubleDropModel.instance:isShowDoubleByEpisode(arg_43_0._config.id, true)

	gohelper.setActive(arg_43_0._godoubletimes, var_43_1)

	if var_43_1 then
		local var_43_4 = {
			var_43_2,
			var_43_3
		}

		arg_43_0._txtdoubletimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), var_43_4)

		recthelper.setAnchorY(arg_43_0._gooperation.transform, -20)
		recthelper.setAnchorY(arg_43_0._btnequip.transform, -410)
	else
		recthelper.setAnchorY(arg_43_0._gooperation.transform, 0)
		recthelper.setAnchorY(arg_43_0._btnequip.transform, -390)
	end
end

function var_0_0.showFree(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1.enterAfterFreeLimit > 0

	gohelper.setActive(arg_44_0._gorighttop, not var_44_0)

	arg_44_0._enterAfterFreeLimit = var_44_0

	if not var_44_0 then
		return
	end

	local var_44_1 = DungeonModel.instance:getChapterRemainingNum(arg_44_1.type)

	if var_44_1 <= 0 then
		var_44_0 = false
	end

	gohelper.setActive(arg_44_0._goequipmap, var_44_0)
	gohelper.setActive(arg_44_0._gooperation, not var_44_0)
	gohelper.setActive(arg_44_0._gorighttop, not var_44_0)

	arg_44_0._enterAfterFreeLimit = var_44_0

	if not var_44_0 then
		return
	end

	arg_44_0._txtfightcount.text = var_44_1 == 0 and string.format("<color=#b3afac>%s</color>", var_44_1) or var_44_1

	gohelper.setActive(arg_44_0._gofightcountbg, var_44_1 ~= 0)
	arg_44_0:_refreshFreeCost()
end

function var_0_0._refreshFreeCost(arg_45_0)
	arg_45_0._txtcostcount.text = -1 * arg_45_0._curSpeed
end

function var_0_0.showViewStory(arg_46_0)
	local var_46_0 = StoryConfig.instance:getEpisodeStoryIds(arg_46_0._config)
	local var_46_1 = false

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		if StoryModel.instance:isStoryFinished(iter_46_1) then
			var_46_1 = true

			break
		end
	end

	if not var_46_1 then
		return
	end
end

function var_0_0.refreshChallengeLimit(arg_47_0)
	local var_47_0, var_47_1, var_47_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_47_0._episodeId)

	if var_47_0 > 0 and var_47_1 > 0 then
		local var_47_3 = ""

		if var_47_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_47_3 = luaLang("daily")
		elseif var_47_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_47_3 = luaLang("weekly")
		else
			var_47_3 = luaLang("monthly")
		end

		arg_47_0._txtchallengecountlimit.text = string.format("%s%s (%d/%d)", var_47_3, luaLang("times"), math.max(0, var_47_1 - arg_47_0._episodeInfo.challengeCount), var_47_1)
	else
		arg_47_0._txtchallengecountlimit.text = ""
	end

	arg_47_0._isCanChallenge, arg_47_0._challengeLockCode = DungeonModel.instance:isCanChallenge(arg_47_0._config)

	gohelper.setActive(arg_47_0._gostart, arg_47_0._isCanChallenge)
	gohelper.setActive(arg_47_0._golock, not arg_47_0._isCanChallenge)
end

function var_0_0.onStoryStatus(arg_48_0)
	local var_48_0 = false
	local var_48_1 = DungeonConfig.instance:getChapterCO(arg_48_0._config.chapterId)

	if arg_48_0._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_48_0._config.afterStory) and arg_48_0._episodeInfo.star > DungeonEnum.StarType.None then
		var_48_0 = true
	end

	gohelper.setActive(arg_48_0._gooperation, not var_48_0 and not arg_48_0._enterAfterFreeLimit)
	gohelper.setActive(arg_48_0._btnstory, var_48_0)

	local var_48_2 = arg_48_0._chapterType == DungeonEnum.ChapterType.Hard

	if var_48_0 then
		arg_48_0:refreshHardMode()
		arg_48_0._btnhardmode.gameObject:SetActive(false)
	elseif not var_48_2 then
		arg_48_0:refreshHardMode()
	else
		arg_48_0._btnHardModeActive = false

		TaskDispatcher.cancelTask(arg_48_0._delaySetActive, arg_48_0)
		TaskDispatcher.runDelay(arg_48_0._delaySetActive, arg_48_0, 0.2)
	end

	arg_48_0:showViewStory()

	local var_48_3, var_48_4, var_48_5 = DungeonModel.instance:getChapterListTypes()
	local var_48_6 = DungeonModel.instance:chapterListIsRoleStory()
	local var_48_7 = (not var_48_3 or arg_48_0._config.type ~= DungeonEnum.EpisodeType.Story) and not var_48_4 and not var_48_5 and not var_48_6

	gohelper.setActive(arg_48_0._goswitch, arg_48_0._simpleConfig and var_48_7)
	gohelper.setActive(arg_48_0._gonormal, not arg_48_0._simpleConfig and var_48_7)
	gohelper.setActive(arg_48_0._gohard, not arg_48_0._simpleConfig and var_48_7)
	gohelper.setActive(arg_48_0._gostar, not arg_48_0._simpleConfig and var_48_7)
	recthelper.setAnchorY(arg_48_0._txtdesc.transform, var_48_7 and 56.6 or 129.1)
	recthelper.setAnchorY(arg_48_0._gorecommond.transform, var_48_7 and 87.3 or 168.4)
	TaskDispatcher.cancelTask(arg_48_0._checkLockTime, arg_48_0)
	TaskDispatcher.runRepeat(arg_48_0._checkLockTime, arg_48_0, 1)
end

function var_0_0._checkLockTime(arg_49_0)
	local var_49_0 = DungeonConfig.instance:getHardEpisode(arg_49_0._enterConfig.id)
	local var_49_1 = arg_49_0.isInLockTime and true or false

	if var_49_0 and DungeonModel.instance:episodeIsInLockTime(var_49_0.id) then
		arg_49_0.isInLockTime = true
	else
		arg_49_0.isInLockTime = false
	end

	if var_49_1 ~= arg_49_0.isInLockTime then
		arg_49_0:showStatus()
		arg_49_0:onStoryStatus()
	elseif arg_49_0.isInLockTime then
		local var_49_2 = ServerTime.now()
		local var_49_3 = string.splitToNumber(var_49_0.lockTime, "#")

		arg_49_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_49_3[2] / 1000 - ServerTime.now())))
	end
end

function var_0_0.refreshHardMode(arg_50_0)
	arg_50_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_50_0._enterConfig.id)

	local var_50_0 = false

	if arg_50_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
		local var_50_1 = DungeonModel.instance:isOpenHardDungeon(arg_50_0._config.chapterId)

		var_50_0 = arg_50_0._hardEpisode ~= nil and var_50_1
	end

	if arg_50_0._hardEpisode and DungeonModel.instance:episodeIsInLockTime(arg_50_0._hardEpisode.id) then
		var_50_0 = false

		gohelper.setActive(arg_50_0._txtLockTime, true)

		local var_50_2 = ServerTime.now()
		local var_50_3 = string.splitToNumber(arg_50_0._hardEpisode.lockTime, "#")

		arg_50_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_50_3[2] / 1000 - ServerTime.now())))
		arg_50_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	else
		gohelper.setActive(arg_50_0._txtLockTime, false)

		arg_50_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0.1
	end

	arg_50_0._btnhardmode.gameObject:SetActive(var_50_0)
	gohelper.setActive(arg_50_0._golockbg, not var_50_0)

	arg_50_0._gohard:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_50_0 and 1 or 0.3
	arg_50_0._btnHardModeActive = var_50_0
end

function var_0_0._delaySetActive(arg_51_0)
	arg_51_0._btnhardmode.gameObject:SetActive(arg_51_0._btnHardModeActive)
end

function var_0_0.refreshCostPower(arg_52_0)
	local var_52_0 = string.split(arg_52_0._config.cost, "|")
	local var_52_1 = string.split(var_52_0[1], "#")
	local var_52_2 = tonumber(var_52_1[3] or 0) * arg_52_0._curSpeed

	arg_52_0._txtusepower.text = "-" .. var_52_2
	arg_52_0._txtusepowerhard.text = "-" .. var_52_2

	if var_52_2 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_52_0._txtusepower, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_52_0._txtusepowerhard, "#FFEAEA")
		gohelper.setActive(arg_52_0._gonormallackpower, false)
		gohelper.setActive(arg_52_0._gohardlackpower, false)
	else
		local var_52_3 = arg_52_0._chapterType == DungeonEnum.ChapterType.Hard

		SLFramework.UGUI.GuiHelper.SetColor(arg_52_0._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_52_0._txtusepowerhard, "#C44945")
		gohelper.setActive(arg_52_0._gonormallackpower, not var_52_3)
		gohelper.setActive(arg_52_0._gohardlackpower, var_52_3)
	end
end

function var_0_0.onClose(arg_53_0)
	TaskDispatcher.cancelTask(arg_53_0.closeThis, arg_53_0)
	AudioMgr.instance:trigger(arg_53_0:getCurrentChapterListTypeAudio().onClose)

	arg_53_0._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_53_0._episodeItemParam)

	if arg_53_0._rewarditems then
		for iter_53_0, iter_53_1 in ipairs(arg_53_0._rewarditems) do
			TaskDispatcher.cancelTask(iter_53_1.refreshLimitTime, iter_53_1)
		end
	end

	arg_53_0._chapterType = nil
end

function var_0_0.onCloseFinish(arg_54_0)
	return
end

function var_0_0.clearRuleList(arg_55_0)
	arg_55_0._simageList = arg_55_0:getUserDataTb_()

	for iter_55_0, iter_55_1 in pairs(arg_55_0._rulesimageList) do
		iter_55_1:UnLoadImage()
	end

	arg_55_0._rulesimageList = arg_55_0:getUserDataTb_()
	arg_55_0._rulesimagelineList = arg_55_0:getUserDataTb_()

	gohelper.destroyAllChildren(arg_55_0._gorulelist)
	gohelper.destroyAllChildren(arg_55_0._goruleDescList)
end

function var_0_0.onDestroyView(arg_56_0)
	arg_56_0._simagepower2:UnLoadImage()
	arg_56_0._simagepower3:UnLoadImage()
	arg_56_0._simagenormalbg:UnLoadImage()
	arg_56_0._simagehardbg:UnLoadImage()

	for iter_56_0, iter_56_1 in pairs(arg_56_0._rulesimageList) do
		iter_56_1:UnLoadImage()
	end

	for iter_56_2 = 1, #arg_56_0._enemyitems do
		arg_56_0._enemyitems[iter_56_2].simagemonsterhead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_56_0._delaySetActive, arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0._delayToSwitchStartBtn, arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0.refreshCostPower, arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0._checkLockTime, arg_56_0)
end

function var_0_0.refreshTitleField(arg_57_0)
	local var_57_0 = GameUtil.utf8len(arg_57_0._config.name) > 7 and arg_57_0.titleList[2] or arg_57_0.titleList[1]

	if var_57_0 == arg_57_0.curTitleItem then
		return
	end

	for iter_57_0, iter_57_1 in ipairs(arg_57_0.titleList) do
		gohelper.setActive(iter_57_1._go, iter_57_1 == var_57_0)
	end

	arg_57_0.curTitleItem = var_57_0
	arg_57_0._txttitle1 = var_57_0._txttitle1
	arg_57_0._txttitle3 = var_57_0._txttitle3
	arg_57_0._txtchapterindex = var_57_0._txtchapterindex
	arg_57_0._txttitle4 = var_57_0._txttitle4
	arg_57_0._gostar = var_57_0._gostar

	arg_57_0:_initStar()
end

function var_0_0.setTitleDesc(arg_58_0)
	arg_58_0:refreshTitleField()

	local var_58_0
	local var_58_1 = DungeonConfig.instance:getChapterTypeByEpisodeId(arg_58_0._config.id)

	if var_58_1 == DungeonEnum.ChapterType.Hard then
		var_58_0 = DungeonConfig.instance:getEpisodeCO(arg_58_0._config.preEpisode)
	elseif var_58_1 == DungeonEnum.ChapterType.Simple then
		var_58_0 = DungeonConfig.instance:getEpisodeCO(arg_58_0._config.normalEpisodeId)
	else
		var_58_0 = arg_58_0._config
	end

	arg_58_0._txtdesc.text = var_58_0.desc
	arg_58_0._txttitle4.text = var_58_0.name_En

	local var_58_2 = GameUtil.utf8sub(var_58_0.name, 1, 1)
	local var_58_3 = ""
	local var_58_4

	if GameUtil.utf8len(var_58_0.name) >= 2 then
		var_58_3 = string.format("<size=80>%s</size>", GameUtil.utf8sub(var_58_0.name, 2, GameUtil.utf8len(var_58_0.name) - 1))
	end

	arg_58_0._txttitle1.text = var_58_2 .. var_58_3

	ZProj.UGUIHelper.RebuildLayout(arg_58_0._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_58_0._txttitle4.transform)

	if GameUtil.utf8len(arg_58_0._config.name) > 2 then
		var_58_4 = recthelper.getAnchorX(arg_58_0._txttitle1.transform) + recthelper.getWidth(arg_58_0._txttitle1.transform)
	else
		var_58_4 = recthelper.getAnchorX(arg_58_0._txttitle1.transform) + recthelper.getWidth(arg_58_0._txttitle1.transform) + recthelper.getAnchorX(arg_58_0._txttitle4.transform)
	end

	recthelper.setAnchorX(arg_58_0._txttitle3.transform, var_58_4)
end

function var_0_0.getCurrentChapterListTypeAudio(arg_59_0)
	local var_59_0, var_59_1, var_59_2 = DungeonModel.instance:getChapterListTypes()
	local var_59_3

	if var_59_0 then
		var_59_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	elseif var_59_1 then
		var_59_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Resource]
	elseif var_59_2 then
		var_59_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Insight]
	else
		var_59_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	end

	return var_59_3
end

function var_0_0._setStarN(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = "#9B9B9B"

	if arg_60_1 then
		var_60_0 = arg_60_2 == 1 and "#efb974" or arg_60_2 == 2 and "#F97142" or "#FF4343"
		arg_60_0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_60_0, var_60_0)
end

function var_0_0._btnHardOnClick(arg_61_0)
	if arg_61_0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HardDungeon))

		return
	end

	local var_61_0 = DungeonConfig.instance:getHardEpisode(arg_61_0._enterConfig.id)

	if var_61_0 and DungeonModel.instance:episodeIsInLockTime(var_61_0.id) then
		GameFacade.showToastString(arg_61_0._txtLockTime.text)

		return
	end

	local var_61_1 = DungeonModel.instance:getEpisodeInfo(arg_61_0._enterConfig.id)

	if not DungeonModel.instance:hasPassLevelAndStory(arg_61_0._enterConfig.id) or var_61_1.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	arg_61_0._config = arg_61_0._hardEpisode

	arg_61_0:_showEpisodeMode(true, true)
end

function var_0_0._btnNormalOnClick(arg_62_0)
	if arg_62_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_62_0._config = arg_62_0._enterConfig

	arg_62_0:_showEpisodeMode(false, true)
end

function var_0_0._btnSimpleOnClick(arg_63_0)
	if arg_63_0._chapterType == DungeonEnum.ChapterType.Simple then
		return
	end

	arg_63_0._config = arg_63_0._simpleConfig

	arg_63_0:_showEpisodeMode(false, true)
end

function var_0_0.checkSendGuideEvent(arg_64_0)
	if not arg_64_0._config then
		return
	end

	local var_64_0 = DungeonModel.instance:hasPassLevelAndStory(arg_64_0._config.id)
	local var_64_1 = DungeonConfig.instance:getEpisodeBattleId(arg_64_0._config.id)
	local var_64_2 = arg_64_0._config.chapterId

	if DungeonConfig.instance:getChapterCO(var_64_2).type == DungeonEnum.ChapterType.Normal and not var_64_0 and var_64_1 and var_64_1 ~= 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnOpenUnPassLevelGuide)
	end
end

function var_0_0.checkFirstDisplay(arg_65_0)
	local var_65_0 = PlayerModel.instance:getMyUserId()
	local var_65_1 = PlayerPrefsKey.DungeonMapLevelFirstShow .. arg_65_0._simpleConfig.id .. var_65_0

	if PlayerPrefsHelper.getNumber(var_65_1, 0) == 0 then
		PlayerPrefsHelper.setNumber(var_65_1, 1)

		return true
	end

	return false
end

return var_0_0
