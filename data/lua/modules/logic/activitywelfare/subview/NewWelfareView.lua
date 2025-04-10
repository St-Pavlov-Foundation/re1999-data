module("modules.logic.activitywelfare.subview.NewWelfareView", package.seeall)

slot0 = class("NewWelfareView", BaseView)
slot0.FirstProgress = 0.18
slot0.SecondProgress = 0.58

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Root/#txt_Descr")
	slot0._imgfill = gohelper.findChildImage(slot0.viewGO, "Root/Progress/go_fillbg/go_fill")
	slot0._rewardItemList = {}
	slot0._progressItemList = {}
	slot0._isfirstopen = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnClaimOnClick(slot0, slot1)
	Activity160Rpc.instance:sendGetAct160FinishMissionRequest(slot0.actId, slot1)
end

function slot0._jumpToTargetDungeon(slot0, slot1)
	if slot1 ~= 0 then
		slot3 = DungeonConfig.instance:getEpisodeCO(slot2)
		slot6 = slot3.chapterId

		ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
		DungeonController.instance:jumpDungeon({
			chapterType = lua_chapter.configDict[slot6].type,
			chapterId = slot6,
			episodeId = slot3.id
		})
	end
end

function slot0._editableInitView(slot0)
	slot0.actId = ActivityEnum.Activity.NewWelfare
	slot0.missionCO = Activity160Config.instance:getActivityMissions(slot0.actId)

	slot0:_initRewardItem()
	slot0:_initProgress()
end

function slot0._initRewardItem(slot0)
	if not slot0.missionCO then
		return
	end

	for slot4, slot5 in ipairs(slot0.missionCO) do
		slot6 = slot0:getUserDataTb_()
		slot7 = gohelper.findChild(slot0.viewGO, "Root/Card" .. slot4)
		slot6.go = slot7
		slot6.co = slot5
		slot6.id = slot5.id
		slot6.gocomplete = gohelper.findChild(slot7, "#go_Complete")
		slot6.gonormal = gohelper.findChild(slot7, "#go_Normal")
		slot6.txttitle = gohelper.findChildText(slot7, "#txt_Title")
		slot6.txtnum = gohelper.findChildText(slot7, "#txt_Num")
		slot6.goClaim = gohelper.findChild(slot6.gonormal, "#btn_Claim")
		slot6.btnClaim = gohelper.findChildButton(slot6.gonormal, "#btn_Claim")

		slot6.btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0, slot5.id)

		slot6.gogo = gohelper.findChild(slot6.gonormal, "#btn_Go")
		slot6.btnGo = gohelper.findChildButton(slot6.gonormal, "#btn_Go")

		slot6.btnGo:AddClickListener(slot0._jumpToTargetDungeon, slot0, slot5.episodeId)
		table.insert(slot0._rewardItemList, slot6)
	end
end

function slot0._initProgress(slot0)
	if not slot0.missionCO then
		return
	end

	for slot5 = 1, #slot0.missionCO do
		slot6 = slot0:getUserDataTb_()
		slot7 = gohelper.findChild(slot0.viewGO, "Root/Progress/go_point" .. slot5)
		slot6.id = slot0.missionCO[slot5].id
		slot6.go = slot7
		slot6.godark = gohelper.findChild(slot7, "dark")
		slot6.golight = gohelper.findChild(slot7, "light")

		table.insert(slot0._progressItemList, slot6)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:addEventCb(Activity160Controller.instance, Activity160Event.InfoUpdate, slot0._onInfoUpdate, slot0)
	slot0:refreshView()
end

function slot0.refreshView(slot0)
	slot0._txtDescr.text = ActivityConfig.instance:getActivityCo(slot0.actId).actDesc
	slot0._txtLimitTime.text = luaLang("activityshow_unlimittime")

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshItem()
	slot0:refreshProgress()
end

function slot0._onInfoUpdate(slot0, slot1)
	if slot1 == slot0.actId then
		slot0:refreshUI()
	end
end

function slot0._jumpFinishCallBack(slot0)
	ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
end

function slot0.refreshItem(slot0)
	for slot4, slot5 in ipairs(slot0._rewardItemList) do
		slot6 = Activity160Model.instance:isMissionFinish(slot0.actId, slot5.id)
		slot7 = Activity160Model.instance:isMissionCanGet(slot0.actId, slot5.id)

		gohelper.setActive(slot5.gocomplete, slot6)
		gohelper.setActive(slot5.gonormal, not slot6)
		gohelper.setActive(slot5.goClaim, slot7)
		gohelper.setActive(slot5.gogo, not slot7)
	end
end

function slot0.refreshProgress(slot0)
	slot0._progress = 0

	for slot5, slot6 in ipairs(slot0._progressItemList) do
		if Activity160Model.instance:isMissionFinish(slot0.actId, slot6.id) or Activity160Model.instance:isMissionCanGet(slot0.actId, slot6.id) then
			slot1 = 0 + 1
		end

		gohelper.setActive(slot6.godark, not slot9)
		gohelper.setActive(slot6.golight, slot9)
	end

	if slot1 == 1 then
		slot0._progress = uv0.FirstProgress
	elseif slot1 == 2 then
		slot0._progress = uv0.SecondProgress
	elseif slot1 == 3 then
		slot0._progress = 1
	end

	if not slot0._isfirstopen then
		slot0._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, slot0._progress, 0.5, slot0._setFaithPercent, slot0._setFaithValue, slot0, nil, EaseType.Linear)
		slot0._isfirstopen = true
	end
end

function slot0._setFaithPercent(slot0, slot1)
	slot0._imgfill.fillAmount = slot1
end

function slot0._setFaithValue(slot0)
	slot0:_setFaithPercent(slot0._progress)

	if slot0._faithTweenId then
		ZProj.TweenHelper.KillById(slot0._faithTweenId)

		slot0._faithTweenId = nil
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._rewardItemList) do
		slot5.btnClaim:RemoveClickListener()
		slot5.btnGo:RemoveClickListener()
	end
end

return slot0
