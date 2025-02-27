module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerPageItem", package.seeall)

slot0 = class("WeekWalk_2HeartLayerPageItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_unlock")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_unlock/#btn_click")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_unlock/#btn_click/#simage_icon")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._btnlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_lock/#btn_lock")
	slot0._simagelockicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_lock/#btn_lock/#simage_lockicon")
	slot0._gochallenge = gohelper.findChild(slot0.viewGO, "#go_challenge")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "info/#txt_name")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "info/#txt_progress")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reward")
	slot0._gorewardIcon = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_rewardIcon")
	slot0._gonormalIcon = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_normalIcon")
	slot0._gorewardfinish = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_rewardfinish")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnlock:AddClickListener(slot0._btnlockOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnlock:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartView({
		mapId = slot0._layerInfo.id
	})
end

function slot0._btnlockOnClick(slot0)
	GameFacade.showToast(ToastEnum.WeekWalkLayerPage)
end

function slot0._btndetailOnClick(slot0)
end

function slot0._btnrewardOnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = slot0._layerInfo.id
	})
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gofinish, false)
	gohelper.setActive(slot0._gochallenge, false)

	slot0._animator = slot0.viewGO:GetComponent("Animator")
end

function slot0._initChildNodes(slot0, slot1)
	if slot0._starsList1 then
		return
	end

	gohelper.setActive(gohelper.findChild(slot0.viewGO, string.format("info/type%s", slot1)), true)

	slot0._txtbattlename = gohelper.findChildText(slot0.viewGO, string.format("info/type%s/txt_battlename", slot1))
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, string.format("info/type%s/txt_nameen", slot1))
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, string.format("info/type%s/txt_index", slot1))
	slot0._go1 = gohelper.findChild(slot0.viewGO, string.format("info/type%s/go_star/starlist/go_icons1/go_1", slot1))
	slot0._go2 = gohelper.findChild(slot0.viewGO, string.format("info/type%s/go_star/starlist/go_icons2/go_2", slot1))
	slot0._starsList1 = slot0:getUserDataTb_()
	slot0._starsList2 = slot0:getUserDataTb_()

	slot0:_initStarsList(slot0._starsList1, slot0._go1)
	slot0:_initStarsList(slot0._starsList2, slot0._go2)
end

function slot0._initStarsList(slot0, slot1, slot2)
	gohelper.setActive(slot2, false)

	for slot6 = 1, WeekWalk_2Enum.MaxStar do
		slot7 = gohelper.cloneInPlace(slot2)

		gohelper.setActive(slot7, true)

		slot8 = gohelper.findChildImage(slot7, "icon")
		slot8.enabled = false

		table.insert(slot1, slot0._layerView:getResInst(slot0._layerView.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot8.gameObject))
	end
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, slot0._onChangeInfo, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0:removeEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
	slot0:removeEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, slot0._onChangeInfo, slot0)
end

function slot0._onChangeInfo(slot0)
	slot0:_updateStatus()
end

function slot0._onWeekwalkTaskUpdate(slot0)
	slot0:_updateStatus()
end

function slot0.setFakeUnlock(slot0, slot1)
	slot0._fakeUnlock = slot1

	slot0:_updateStatus()
end

function slot0.playUnlockAnim(slot0)
	gohelper.setActive(slot0._gounlock, true)
	gohelper.setActive(slot0._golock, true)
	slot0._animator:Play("unlock", 0, 0)
	TaskDispatcher.runDelay(slot0._unlockAnimDone, slot0, 1.5)
	AudioMgr.instance:trigger(AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_unlock)
end

function slot0._unlockAnimDone(slot0)
	gohelper.setActive(slot0._golock, false)
end

function slot0.getIndex(slot0)
	return slot0._index
end

function slot0.getLayerId(slot0)
	return slot0._layerInfo and slot0._layerInfo.id
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._index = slot1.index
	slot0._layerView = slot1.layerView
	slot0._typeIndex = slot0._index == 4 and 1 or slot0._index
	slot0._fakeUnlock = true

	slot0:_initChildNodes(slot0._typeIndex)
	slot0:_updateStatus()
end

function slot0._updateStatus(slot0)
	slot0._layerInfo = WeekWalk_2Model.instance:getLayerInfoByLayerIndex(slot0._index)
	slot0._layerSceneConfig = slot0._layerInfo.sceneConfig
	slot0._isUnLock = slot0._layerInfo.unlock and slot0._fakeUnlock

	gohelper.setActive(slot0._golock, not slot0._isUnLock)
	gohelper.setActive(slot0._gounlock, slot0._isUnLock)

	slot0._txtbattlename.text = slot0._layerSceneConfig.battleName
	slot0._txtnameen.text = slot0._layerSceneConfig.name_en
	slot0._txtname.text = slot0._layerSceneConfig.name
	slot0._txtindex.text = tostring(slot0._index)
	slot1 = string.format("weekwalkheart_stage%s", slot0._layerInfo.config.layer)

	slot0._simageicon:LoadImage(ResUrl.getWeekWalkLayerIcon(slot1))
	slot0._simagelockicon:LoadImage(ResUrl.getWeekWalkLayerIcon(slot1))
	slot0:_updateStars()
	slot0:_updateRewardStatus()
	slot0:_updateProgress()

	slot4 = slot0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First).status == WeekWalk_2Enum.BattleStatus.Finished and slot0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second).status == WeekWalk_2Enum.BattleStatus.Finished

	gohelper.setActive(slot0._gofinish, slot4)
	gohelper.setActive(slot0._gochallenge, not slot4 and slot0._isUnLock)
end

function slot0._updateProgress(slot0)
	slot2 = 0
	slot3 = 0

	if WeekWalk_2Config.instance:getWeekWalkRewardList(slot0._layerInfo.config.layer) then
		for slot7, slot8 in pairs(slot1) do
			if lua_task_weekwalk_ver2.configDict[slot7] and WeekWalk_2TaskListModel.instance:checkPeriods(slot9) then
				slot3 = slot3 + slot8

				if WeekWalk_2TaskListModel.instance:getTaskMo(slot7) and lua_task_weekwalk_ver2.configDict[slot7].maxFinishCount <= slot10.finishCount then
					slot2 = slot2 + slot8
				end
			end
		end
	end

	slot0._txtprogress.text = string.format("%s/%s", slot2, slot3)
	slot0._txtprogress.alpha = slot3 <= slot2 and 0.45 or 1
end

function slot0._updateRewardStatus(slot0)
	gohelper.setActive(slot0._btnreward, true)

	slot3, slot4 = WeekWalk_2TaskListModel.instance:canGetRewardNum(WeekWalk_2Enum.TaskType.Season, slot0._layerInfo.id)
	slot5 = slot3 > 0

	gohelper.setActive(slot0._gorewardIcon, slot5)
	gohelper.setActive(slot0._gorewardfinish, not slot5 and slot4 <= 0)
	gohelper.setActive(slot0._gonormalIcon, not slot5 and slot4 > 0)
end

function slot0._updateStars(slot0)
	slot0:_updateStarList(slot0._starsList1, slot0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First))
	slot0:_updateStarList(slot0._starsList2, slot0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second))
end

function slot0._updateStarList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot10 = (slot2:getCupInfo(slot6) and slot8.result or 0) > 0

		gohelper.setActive(slot7, slot10)

		if slot10 then
			WeekWalk_2Helper.setCupEffect(slot7, slot8)
		end
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._unlockAnimDone, slot0)
end

return slot0
