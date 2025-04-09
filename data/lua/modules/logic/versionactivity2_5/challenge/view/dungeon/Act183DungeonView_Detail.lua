module("modules.logic.versionactivity2_5.challenge.view.dungeon.Act183DungeonView_Detail", package.seeall)

slot0 = class("Act183DungeonView_Detail", BaseView)
slot1 = 0.1

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._gonormaltype = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_normaltype")
	slot0._goselectnormal = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_normaltype/#go_selectnormal")
	slot0._gounselectnormal = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_normaltype/#go_unselectnormal")
	slot0._gohardtype = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_hardtype")
	slot0._goselecthard = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_hardtype/#go_selecthard")
	slot0._gounselecthard = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_hardtype/#go_unselecthard")
	slot0._btnclicknormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/mode/#go_normaltype/#btn_clicknormal")
	slot0._btnclickhard = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/mode/#go_hardtype/#btn_clickhard")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/#btn_task")
	slot0._goepisodecontainer = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer")
	slot0._gonormalepisode = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer/#go_normalepisode")
	slot0._gobossepisode = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer/#go_bossepisode")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/top/bar/#btn_reset")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "root/right/#go_detail")
	slot0._btnclosedetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_closedetail")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_normal")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_hard")
	slot0._scrolldetail = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#go_detail/#scroll_detail")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/title/#txt_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/top/#txt_desc")
	slot0._godone = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/title/#go_done")
	slot0._goconditions = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions")
	slot0._imageconditionstar = gohelper.findChildImage(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/top/title/#image_conditionstar")
	slot0._goconditiondescs = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/#go_conditiondescs")
	slot0._txtconditionitem = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/#go_conditiondescs/#txt_conditionitem")
	slot0._gobaserulecontainer = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer")
	slot0._gobadgerules = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_badgerules")
	slot0._gobadgeruleitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_badgerules/#go_badgeruleitem")
	slot0._gobaserules = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_baserules")
	slot0._gobaseruleitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_baserules/#go_baseruleitem")
	slot0._goescaperulecontainer = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer")
	slot0._goescaperules = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer/#go_escaperules")
	slot0._goescaperuleitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer/#go_escaperules/#go_escaperuleitem")
	slot0._gorewardcontainer = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer/#go_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer/#go_rewards/#go_rewarditem")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_start")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_restart")
	slot0._btnbadge = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_badge")
	slot0._golock = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_lock")
	slot0._txtusebadgenum = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/#btn_badge/#txt_usebadgenum")
	slot0._gobadgedetail = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_badgedetail")
	slot0._btnclosebadge = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#go_badgedetail/#btn_closebadge")
	slot0._btnresetbadge = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#go_badgedetail/#go_badges/#btn_resetbadge")
	slot0._gobadgeitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_badgedetail/#go_badges/#go_badgeitem")
	slot0._btnrepress = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_repress")
	slot0._gosetrepresshero = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero")
	slot0._simagerepressheroicon = gohelper.findChildSingleImage(slot0.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero/#simage_repressheroicon")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero/#image_Career")
	slot0._gorepressresult = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult")
	slot0._gohasrepress = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_hasrepress")
	slot0._gounrepress = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_unrepress")
	slot0._gorepressrules = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_repressrules")
	slot0._gorepressruleitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_repressrules/#go_repressruleitem")
	slot0._gorepressheropos = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_hasrepress/#go_repressheropos")
	slot0._btnresetepisode = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_resetepisode")
	slot0._btninfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/title/#btn_Info")
	slot0._goleadertips = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_LeaderTips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosedetail:AddClickListener(slot0._btnclosedetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosedetail:RemoveClickListener()
end

function slot0._btnclosedetailOnClick(slot0)
	slot0:setDetailVisible(false)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, slot0._onClickEpisode, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, slot0._onUpdateRepressInfo, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateGroupInfo, slot0._onUpdateGroupInfo, slot0)

	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
	slot0._compMgr = MonoHelper.addLuaComOnceToGo(slot0._godetail, Act183DungeonCompMgr)

	slot0._compMgr:addComp(slot0._godetail, Act183DungeonDescComp, true)
	slot0._compMgr:addComp(slot0._goconditions, Act183DungeonConditionComp, true)
	slot0._compMgr:addComp(slot0._gobaserulecontainer, Act183DungeonBaseAndBadgeRuleComp, true)
	slot0._compMgr:addComp(slot0._gorewardcontainer, Act183DungeonRewardRuleComp, true)
	slot0._compMgr:addComp(slot0._goescaperulecontainer, Act183DungeonEscapeRuleComp, true)
	slot0._compMgr:addComp(slot0._gorepressresult, Act183DungeonRepressResultComp, true)
	slot0._compMgr:addComp(slot0._btnstart.gameObject, Act183DungeonStartBtnComp, true)
	slot0._compMgr:addComp(slot0._gobadgedetail, Act183DungeonSelectBadgeComp, true)
	slot0._compMgr:addComp(slot0._btnrepress.gameObject, Act183DungeonRepressBtnComp, false)
	slot0._compMgr:addComp(slot0._btnrestart.gameObject, Act183DungeonRestartBtnComp, false)
	slot0._compMgr:addComp(slot0._btnresetepisode.gameObject, Act183DungeonResetBtnComp, false)
	slot0._compMgr:addComp(slot0._golock, Act183DungeonLockBtnComp, false)
	slot0._compMgr:addComp(slot0._btnbadge.gameObject, Act183DungeonBadgeBtnComp, false)
	slot0._compMgr:addComp(slot0._goleadertips, Act183DungeonTeamLeaderTipsComp, false)
	slot0:setDetailVisible(false)
end

function slot0._onClickEpisode(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0._expand and slot0._episodeId ~= slot1 then
		slot0._animator:Play("rightswitch", 0, 0)
	end

	slot0._nextEpisodeMo = Act183Model.instance:getEpisodeMoById(slot1)

	if not slot0._nextEpisodeMo then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(slot0.switchEpisodeDetail, slot0)
	TaskDispatcher.runDelay(slot0.switchEpisodeDetail, slot0, uv0)
end

function slot0.switchEpisodeDetail(slot0)
	slot0:refreshEpisodeDetail(slot0._nextEpisodeMo)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
end

function slot0._onUpdateRepressInfo(slot0, slot1, slot2)
	if not slot0._expand or slot0._episodeId ~= slot1 then
		return
	end

	slot0:refreshEpisodeDetail(slot2)
end

function slot0._onUpdateGroupInfo(slot0)
	if not slot0._expand or not slot0._episodeId then
		return
	end

	slot0:refreshEpisodeDetail(Act183Model.instance:getEpisodeMoById(slot0._episodeId))
end

function slot0.refreshEpisodeDetail(slot0, slot1)
	slot2 = slot1 ~= nil

	slot0:setDetailVisible(slot2)

	if not slot2 then
		return
	end

	slot0._episodeId = slot1:getEpisodeId()

	slot0._compMgr:onUpdateMO(slot1)
end

function slot0.setDetailVisible(slot0, slot1)
	if slot0._expand and not slot1 then
		slot0._animator:Play("rightclose", 0, 0)
	elseif not slot0._expand and slot1 then
		slot0._animator:Play("rightopen", 0, 0)
	end

	slot0._expand = slot1

	gohelper.setActive(slot0._godetail, slot0._expand)
	gohelper.setActive(slot0._btnclosedetail.gameObject, slot0._expand)

	if not slot1 then
		slot0._episodeId = nil
	end
end

function slot0.onClose(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(slot0.switchEpisodeDetail, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
