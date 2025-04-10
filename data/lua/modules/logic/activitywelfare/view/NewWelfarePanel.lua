module("modules.logic.activitywelfare.view.NewWelfarePanel", package.seeall)

slot0 = class("NewWelfarePanel", BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Root/#txt_Descr")
	slot0._btnClose = gohelper.findChildButton(slot0.viewGO, "Root/#btn_Close")
	slot0._rewardItemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnClaimOnClick(slot0, slot1)
	Activity160Rpc.instance:sendGetAct160FinishMissionRequest(slot0.actId, slot1)
end

function slot0._jumpToTargetDungeon(slot0, slot1)
	if slot1 ~= 0 then
		slot3 = DungeonConfig.instance:getEpisodeCO(slot2)
		slot6 = slot3.chapterId

		ViewMgr.instance:closeView(ViewName.NewWelfarePanel)
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

function slot0.onOpen(slot0)
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
end

function slot0._onInfoUpdate(slot0, slot1)
	if slot1 == slot0.actId then
		slot0:refreshUI()
	end
end

function slot0._jumpFinishCallBack(slot0)
	ViewMgr.instance:closeView(ViewName.NewWelfarePanel)
end

function slot0.refreshItem(slot0)
	for slot4, slot5 in ipairs(slot0._rewardItemList) do
		gohelper.setActive(slot5.gocomplete, Activity160Model.instance:isMissionFinish(slot0.actId, slot5.id))
		gohelper.setActive(slot5.goClaim, Activity160Model.instance:isMissionCanGet(slot0.actId, slot5.id))
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._rewardItemList) do
		slot5.btnClaim:RemoveClickListener()
		slot5.btnGo:RemoveClickListener()
	end
end

return slot0
