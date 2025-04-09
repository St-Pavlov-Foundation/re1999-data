module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementView", package.seeall)

slot0 = class("Act183SettlementView", BaseView)
slot1 = {
	"v2a5_challenge_result_roundbg4",
	"v2a5_challenge_result_roundbg3",
	"v2a5_challenge_result_roundbg2",
	"v2a5_challenge_result_roundbg1"
}

function slot0.onInitView(slot0)
	slot0._gonormalbg = gohelper.findChild(slot0.viewGO, "root/bg")
	slot0._gohardbg = gohelper.findChild(slot0.viewGO, "root/hardbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._scrollbadge = gohelper.findChildScrollRect(slot0.viewGO, "root/left/#scroll_badge")
	slot0._goepisodeitem = gohelper.findChild(slot0.viewGO, "root/left/#scroll_badge/Viewport/Content/#go_episodeitem")
	slot0._simageplayericon = gohelper.findChildSingleImage(slot0.viewGO, "root/left/player/icon/#simage_playericon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "root/left/player/#txt_name")
	slot0._txtdate = gohelper.findChildText(slot0.viewGO, "root/left/player/#txt_date")
	slot0._imageroundbg = gohelper.findChildImage(slot0.viewGO, "root/left/totalround/#image_roundbg")
	slot0._txttotalround = gohelper.findChildText(slot0.viewGO, "root/left/totalround/#txt_totalround")
	slot0._txtbossbadge = gohelper.findChildText(slot0.viewGO, "root/right/#txt_bossbadge")
	slot0._gobossheros = gohelper.findChild(slot0.viewGO, "root/right/#go_bossheros")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "root/#go_heroitem")
	slot0._gobuffs = gohelper.findChild(slot0.viewGO, "root/right/buffs/#go_buffs")
	slot0._gobuffitem = gohelper.findChild(slot0.viewGO, "root/right/buffs/#go_buffs/#go_buffitem")
	slot0._simageboss = gohelper.findChildSingleImage(slot0.viewGO, "root/right/#simage_boss")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "root/left/#scroll_badge/Viewport/Content")
	slot0._heroIconTab = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._activityId = slot0.viewParam and slot0.viewParam.activityId
	slot0._groupRecordMo = slot0.viewParam and slot0.viewParam.groupRecordMo

	slot0:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenSettlementView)
end

function slot0.refresh(slot0)
	slot0:refreshAllSubEpisodeItems()
	slot0:refreshBossEpisodeItem()
	slot0:refreshPlayerInfo()
	slot0:refreshOtherInfo()
end

function slot0.refreshAllSubEpisodeItems(slot0)
	for slot5, slot6 in ipairs(slot0._groupRecordMo:getEpusideListByTypeAndPassOrder(Act183Enum.EpisodeType.Sub)) do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goepisodeitem, "episode_" .. slot5), Act183SettlementSubEpisodeItem)

		slot8:setHeroTemplate(slot0._goheroitem)
		slot8:onUpdateMO(slot0._groupRecordMo, slot6)
	end
end

function slot0.refreshBossEpisodeItem(slot0)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, Act183SettlementBossEpisodeItem)

	slot3:setHeroTemplate(slot0._goheroitem)
	slot3:onUpdateMO(slot0._groupRecordMo, slot0._groupRecordMo:getEpisodeListByType(Act183Enum.EpisodeType.Boss) and slot1[1])
end

function slot0.refreshPlayerInfo(slot0)
	slot0._txtname.text = slot0._groupRecordMo:getUserName()
	slot0._portraitId = slot0._groupRecordMo:getPortrait()

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageplayericon)
	end

	slot0._liveHeadIcon:setLiveHead(slot0._portraitId)

	slot0._txtdate.text = TimeUtil.timestampToString(slot0._groupRecordMo:getFinishedTime() / 1000)
end

function slot0.refreshOtherInfo(slot0)
	slot1 = slot0._groupRecordMo:getAllRound()
	slot0._txttotalround.text = slot1

	if uv0[Act183Helper.getRoundStage(slot1)] then
		UISpriteSetMgr.instance:setChallengeSprite(slot0._imageroundbg, slot3)
	else
		logError(string.format("缺少回合数挡位 --> 回合数背景图配置 allRoundNum = %s, stage = %s", slot1, slot2))
	end

	gohelper.setActive(slot0._gohardbg, slot0._groupRecordMo:getGroupType() == Act183Enum.GroupType.HardMain)
	gohelper.setActive(slot0._gonormalbg, slot4 ~= Act183Enum.GroupType.HardMain)
end

function slot0.releaseAllSingleImage(slot0)
	if slot0._heroIconTab then
		for slot4, slot5 in pairs(slot0._heroIconTab) do
			slot4:UnLoadImage()
		end
	end
end

function slot0.onClose(slot0)
	slot0:releaseAllSingleImage()
	slot0._simageplayericon:UnLoadImage()
	slot0._simageboss:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
