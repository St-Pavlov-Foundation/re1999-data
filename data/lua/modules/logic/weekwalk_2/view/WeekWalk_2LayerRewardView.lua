module("modules.logic.weekwalk_2.view.WeekWalk_2LayerRewardView", package.seeall)

slot0 = class("WeekWalk_2LayerRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goicons1 = gohelper.findChild(slot0.viewGO, "go_star/starlist/#go_icons1")
	slot0._txtchapternum1 = gohelper.findChildText(slot0.viewGO, "go_star/starlist/#go_icons1/#txt_chapternum1")
	slot0._goicons2 = gohelper.findChild(slot0.viewGO, "go_star/starlist/#go_icons2")
	slot0._txtchapternum2 = gohelper.findChildText(slot0.viewGO, "go_star/starlist/#go_icons2/#txt_chapternum2")
	slot0._txttitlecn = gohelper.findChildText(slot0.viewGO, "#txt_titlecn")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_titlecn/#txt_name")
	slot0._txtmaintitle = gohelper.findChildText(slot0.viewGO, "#txt_maintitle")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "right/#scroll_reward")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "right/#scroll_reward/fade/viewport/#go_rewardcontent")

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
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetTaskReward, slot0._getTaskBouns, slot0)
	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("img_bg_black.png"))
end

function slot0._updateTask(slot0)
	WeekWalk_2TaskListModel.instance:showLayerTaskList(slot0._mapId == 0 and WeekWalk_2Enum.TaskType.Once or WeekWalk_2Enum.TaskType.Season, slot0._mapId)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._mapId = slot0.viewParam.mapId

	slot0:_updateTask()
	slot0:_updateInfo()
	slot0:_showBattleInfo()
end

function slot0._showBattleInfo(slot0)
	slot0._mapInfo = WeekWalk_2Model.instance:getLayerInfo(slot0._mapId)

	gohelper.setActive(slot0._txtmaintitle, slot0._mapId == 0)
	gohelper.setActive(slot0._txttitlecn, slot0._mapId ~= 0)

	if not slot0._mapInfo then
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "go_star"), false)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "txt_deeptip"), false)

		return
	end

	slot0:_showBattle(slot0._goicons1, slot0._mapInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First))
	slot0:_showBattle(slot0._goicons2, slot0._mapInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second))
end

function slot0._showBattle(slot0, slot1, slot2)
	gohelper.setActive(gohelper.findChild(slot1, "icon"), false)

	for slot7 = 1, WeekWalk_2Enum.MaxStar do
		slot8 = gohelper.cloneInPlace(slot3)

		gohelper.setActive(slot8, true)

		slot9 = gohelper.findChildImage(slot8, "icon")
		slot9.enabled = false
		slot10 = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot9.gameObject)

		if (slot2:getCupInfo(slot7) and slot11.result or WeekWalk_2Enum.CupType.None) == WeekWalk_2Enum.CupType.None then
			slot12 = WeekWalk_2Enum.CupType.None2
		end

		WeekWalk_2Helper.setCupEffectByResult(slot10, slot12)
	end

	slot6 = slot2.status == WeekWalk_2Enum.BattleStatus.Finished

	gohelper.setActive(gohelper.findChild(slot1, "go_finished"), slot6)
	gohelper.setActive(gohelper.findChild(slot1, "go_unfinish"), not slot6)
end

function slot0._onWeekwalkTaskUpdate(slot0)
	if not slot0._getTaskBonusItem then
		return
	end

	slot0._getTaskBonusItem:playOutAnim()

	slot0._getTaskBonusItem = nil

	UIBlockMgr.instance:startBlock("WeekWalk_2LayerRewardView bonus")
	TaskDispatcher.runDelay(slot0._showRewards, slot0, 0.3)
end

function slot0._getTaskBouns(slot0, slot1)
	slot0._getTaskBonusItem = slot1
end

function slot0._showRewards(slot0)
	slot0:_updateTask()
	slot0:_updateInfo()
	UIBlockMgr.instance:endBlock("WeekWalk_2LayerRewardView bonus")
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, WeekWalk_2TaskListModel.instance:getTaskRewardList())
end

function slot0._updateInfo(slot0)
	slot2 = 0

	for slot7, slot8 in ipairs(WeekWalk_2TaskListModel.instance:getList()) do
		if slot8.maxProgress then
			slot3 = math.max(0, slot8.maxProgress)
		end
	end

	slot0._mapInfo = WeekWalk_2Model.instance:getLayerInfo(slot0._mapId)

	if slot0._mapInfo then
		slot0._txttitlecn.text = slot0._mapInfo.sceneConfig.battleName
		slot0._txtname.text = slot0._mapInfo.sceneConfig.name
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showRewards, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
