module("modules.logic.tower.view.TowerTaskView", package.seeall)

slot0 = class("TowerTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._goFullBg2 = gohelper.findChild(slot0.viewGO, "#simage_FullBG2")
	slot0._goLeft = gohelper.findChild(slot0.viewGO, "Left")
	slot0._scrolltower = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_tower")
	slot0._gotowerContent = gohelper.findChild(slot0.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent")
	slot0._gotowerItem = gohelper.findChild(slot0.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent/#go_towerItem")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent/#go_timeTowerItem/normal/time/#txt_time")
	slot0._goRight = gohelper.findChild(slot0.viewGO, "Right")
	slot0._scrolltaskList = gohelper.findChildScrollRect(slot0.viewGO, "Right/#scroll_taskList")
	slot0._gotaskContent = gohelper.findChild(slot0.viewGO, "Right/#scroll_taskList/Viewport/#go_taskContent")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "Right/#go_tips")
	slot0._gotimeTowerScore = gohelper.findChild(slot0.viewGO, "Right/#go_tips/#go_timeTowerScore")
	slot0._txttimeTowerScore = gohelper.findChildText(slot0.viewGO, "Right/#go_tips/#go_timeTowerScore/#txt_timeTowerScore")
	slot0._txttimeTowerTime = gohelper.findChildText(slot0.viewGO, "Right/#go_tips/#go_timeTowerScore/layout/#txt_timeTowerTime")
	slot0._gobossTowerTips = gohelper.findChild(slot0.viewGO, "Right/#go_tips/#go_bossTowerTips")
	slot0._txtbossTowerTip = gohelper.findChildText(slot0.viewGO, "Right/#go_tips/#go_bossTowerTips/#txt_bossTowerTip")
	slot0._txtbossTowerTime = gohelper.findChildText(slot0.viewGO, "Right/#go_tips/#go_bossTowerTips/layout/#txt_bossTowerTime")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._goactReward = gohelper.findChild(slot0.viewGO, "Right/#go_actReward")
	slot0._simageRewardIcon = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_actReward/#simage_rewardicon")
	slot0._btnShowRewardInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_actReward/#btn_showRewardInfo")
	slot0._txtRewardCount = gohelper.findChildText(slot0.viewGO, "Right/#go_actReward/#txt_rewardCount")
	slot0._txtactReward = gohelper.findChildText(slot0.viewGO, "Right/#go_actReward/#txt_actReward")
	slot0._goactPointContent = gohelper.findChild(slot0.viewGO, "Right/#go_actReward/#go_actPointContent")
	slot0._goactPointItem = gohelper.findChild(slot0.viewGO, "Right/#go_actReward/#go_actPointContent/#go_actPointItem")
	slot0._btnactNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_actReward/#btn_actNormal")
	slot0._btnCanget = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_actReward/#btn_actCanget")
	slot0._goactHasget = gohelper.findChild(slot0.viewGO, "Right/#go_actReward/#go_actHasget")
	slot0._animActReward = slot0._goactReward:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshTaskPos, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.InitTowerItemData, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshLeftUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshActReward, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, slot0.refreshActReward, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshUI, slot0)
	slot0._btnCanget:AddClickListener(slot0._btnActCangetOnClick, slot0)
	slot0._btnactNormal:AddClickListener(slot0._btnActNormalOnClick, slot0)
	slot0._btnShowRewardInfo:AddClickListener(slot0._btnShowRewardInfoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshTaskPos, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.InitTowerItemData, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshLeftUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshActReward, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.OnTaskRewardGetFinish, slot0.refreshActReward, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshUI, slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	slot0._btnCanget:RemoveClickListener()
	slot0._btnactNormal:RemoveClickListener()
	slot0._btnShowRewardInfo:RemoveClickListener()
end

slot0.TaskMaskTime = 0.65
slot0.TaskGetAnimTime = 0.567
slot0.EnterViewAnimBlock = "playEnterTowerTaskViewAnim"
slot0.MoreTaskPosY = 14
slot0.NormalTaskPosY = -75
slot0.NormalTaskCount = 4
slot0.NormalTaskScrollHeight = 1044
slot0.ActTaskScrollHeight = 860

function slot0.onTowerItemClick(slot0, slot1)
	if slot1.select then
		return
	end

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(slot1.data.type, slot1.data.towerId)
	slot0:refreshSelectState()
	slot0:refreshRemainTime()
	slot0:refreshTaskPos()
	slot0:refreshReddot()
	slot0:refreshActReward()
end

function slot0._btnActCangetOnClick(slot0)
	TaskRpc.instance:sendFinishTaskRequest(slot0.actRewardTaskMO.config.id)
	slot0._animActReward:Play(UIAnimationName.Finish, 0, 0)
end

function slot0._btnActNormalOnClick(slot0)
	if not slot0.actRewardTaskMO then
		return
	end

	GameFacade.showToast(ToastEnum.TowerTaskActRewardNormalClick, slot0.actRewardTaskMO.config.desc)
end

function slot0._btnShowRewardInfoOnClick(slot0)
	slot1 = string.split(slot0.actRewardTaskMO.config.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(slot1[1], slot1[2])
end

function slot0._editableInitView(slot0)
	slot0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0.viewContainer.scrollView)

	slot0._taskAnimRemoveItem:setMoveInterval(0)
	slot0._taskAnimRemoveItem:setMoveAnimationTime(uv0.TaskMaskTime - uv0.TaskGetAnimTime)

	slot0.towerItemTab = slot0:getUserDataTb_()
	slot0.removeIndexTab = {}

	gohelper.setActive(slot0._gotowerItem, false)

	slot0.showActRewardEnter = true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_task_entry)
	TaskDispatcher.runDelay(slot0.endEnterAnimBlock, slot0, 0.8)
	UIBlockMgr.instance:startBlock(uv0.EnterViewAnimBlock)
	slot0:selectDefaultTaskCategory()
	slot0:refreshUI()
	slot0:saveLimitedActTaskNew()

	slot0.showActRewardEnter = false
end

function slot0.selectDefaultTaskCategory(slot0)
	if not slot0.viewParam.towerType or not slot0.viewParam.towerId then
		if #TowerTaskModel.instance.actTaskList > 0 then
			if ActivityModel.instance:getActivityInfo()[TowerTaskModel.instance.actTaskList[1].config.activityId]:isOpen() and not slot5:isExpired() then
				slot1 = TowerEnum.ActTaskType
				slot2 = slot4
			end
		else
			slot1 = TowerEnum.TowerType.Limited
			slot2 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() and slot3.towerId or 1
		end
	end

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(slot1, slot2)

	slot0.viewParam.towerType = nil
	slot0.viewParam.towerId = nil
end

function slot0.refreshUI(slot0)
	slot0:InitTowerItemData()
	slot0:refreshSelectState()
	slot0:refreshRemainTime()
	slot0:refreshTaskPos()
	slot0:refreshLeftUI()
	slot0:refreshReddot()
	slot0:refreshActReward()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
end

function slot0.saveLimitedActTaskNew(slot0)
	if #TowerTaskModel.instance.actTaskList > 0 then
		TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewLimitedActTask, slot1[1].config.activityId)
	end
end

function slot0.InitTowerItemData(slot0)
	slot1 = {}
	slot2 = TowerTaskModel.instance.limitTimeTaskList
	slot3 = TowerTaskModel.instance.actTaskList
	slot4 = {}
	slot5 = {}

	for slot9 in pairs(TowerTaskModel.instance.bossTaskList) do
		table.insert(slot5, slot9)
	end

	table.sort(slot5)

	for slot9, slot10 in ipairs(slot5) do
		table.insert(slot4, TowerTaskModel.instance.bossTaskList[slot10])
	end

	if slot0:buildTowerItemData(slot2, TowerEnum.TowerType.Limited) then
		table.insert(slot1, slot6)
	end

	for slot10, slot11 in ipairs(slot4) do
		if slot0:buildTowerItemData(slot11, TowerEnum.TowerType.Boss) then
			table.insert(slot1, slot12)
		end
	end

	if slot0:buildTowerItemData(slot3, TowerEnum.ActTaskType) then
		table.insert(slot1, slot7)
	end

	slot0:createOrRefreshTowerItem(slot1)
end

function slot0.buildTowerItemData(slot0, slot1, slot2)
	slot3 = {}

	if not slot1 or tabletool.len(slot1) == 0 then
		return nil
	end

	slot3.taskList = slot1
	slot3.taskCount = #slot1
	slot3.finishCount = TowerTaskModel.instance:getTaskItemRewardCount(slot1)
	slot3.type = slot2

	if slot2 == TowerEnum.TowerType.Limited then
		slot3.timeConfig = TowerConfig.instance:getTowerLimitedCoByTaskGroupId(slot1[1].config.taskGroupId)
		slot3.towerId = slot3.timeConfig.season
	elseif slot2 == TowerEnum.TowerType.Boss then
		slot3.timeConfig = TowerConfig.instance:getTowerBossTimeCoByTaskGroupId(slot1[1].config.taskGroupId)
		slot3.towerId = slot3.timeConfig.towerId
	elseif slot2 == TowerEnum.ActTaskType then
		slot3.towerId = slot1[1].config.activityId
		slot3.timeConfig = slot1[1].config
	end

	slot3.towerOpenMo = TowerModel.instance:getTowerOpenInfo(slot2, slot3.towerId, TowerEnum.TowerStatus.Open)

	return slot3
end

function slot0.createOrRefreshTowerItem(slot0, slot1)
	slot0.towerItemList = slot0:getUserDataTb_()
	slot2 = false

	for slot6, slot7 in ipairs(slot1) do
		if not slot0.towerItemTab[slot7.type] then
			slot0.towerItemTab[slot7.type] = {}
		end

		if tabletool.len(slot0.towerItemTab[slot7.type]) > 0 then
			for slot11, slot12 in pairs(slot0.towerItemTab[slot7.type]) do
				slot13 = slot12.data
				slot14 = false

				for slot18, slot19 in pairs(slot1) do
					if slot19.towerId == slot13.towerId and slot19.type == slot13.type then
						slot14 = true
					end
				end

				if not slot14 then
					slot12.btnClick:RemoveClickListener()
					gohelper.destroy(slot12.go)

					slot0.towerItemTab[slot7.type][slot13.towerId] = nil
					slot2 = true
				end
			end

			if slot2 then
				slot0:selectDefaultTaskCategory()
			end
		end

		if not slot0.towerItemTab[slot7.type][slot7.towerId] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.clone(slot0._gotowerItem, slot0._gotowerContent, string.format("tower%s_%s", slot7.type, slot7.towerId))
			slot8.goTimeTower = gohelper.findChild(slot8.go, "go_timeTowerItem")
			slot8.goBossTower = gohelper.findChild(slot8.go, "go_bossTowerItem")
			slot8.goActTower = gohelper.findChild(slot8.go, "go_actTowerItem")
			slot8.btnClick = gohelper.findChildButtonWithAudio(slot8.go, "btn_click")

			slot8.btnClick:AddClickListener(slot0.onTowerItemClick, slot0, slot8)

			slot8.timeTowerUI = slot0:findTowerItemUI(slot8.goTimeTower)
			slot8.bossTowerUI = slot0:findTowerItemUI(slot8.goBossTower)
			slot8.actTowerUI = slot0:findTowerItemUI(slot8.goActTower)
			slot8.select = false
			slot8.data = slot7
			slot0.towerItemTab[slot7.type][slot7.towerId] = slot8

			gohelper.setAsLastSibling(slot8.go)
		end

		if slot7.type == TowerEnum.TowerType.Boss then
			slot8.towerItemUI = slot8.bossTowerUI
		elseif slot7.type == TowerEnum.ActTaskType then
			slot8.towerItemUI = slot8.actTowerUI
		else
			slot8.towerItemUI = slot8.timeTowerUI
		end

		slot0:refreshTowerItem(slot8)
		table.insert(slot0.towerItemList, slot8)
	end

	for slot6, slot7 in pairs(slot0.towerItemList) do
		if slot7.data.type == TowerEnum.TowerType.Limited then
			gohelper.setAsFirstSibling(slot7.go)

			break
		end
	end

	for slot6, slot7 in pairs(slot0.towerItemList) do
		if slot7.data.type == TowerEnum.ActTaskType then
			gohelper.setAsFirstSibling(slot7.go)

			break
		end
	end

	for slot6 = #slot1 + 1, #slot0.towerItemList do
		gohelper.setActive(slot0.towerItemList[slot6].go, false)
	end
end

function slot0.refreshTowerItem(slot0, slot1)
	slot1.select = TowerTaskModel.instance.curSelectTowerType == slot1.data.type and TowerTaskModel.instance.curSelectToweId == slot1.data.towerId
	slot4 = slot1.data.type == TowerEnum.TowerType.Boss
	slot5 = slot1.data.type == TowerEnum.ActTaskType

	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.goTimeTower, not slot4 and not slot5)
	gohelper.setActive(slot1.goBossTower, slot4)
	gohelper.setActive(slot1.goActTower, slot5)
	gohelper.setActive(slot1.towerItemUI.normalGO, not slot1.select)
	gohelper.setActive(slot1.towerItemUI.selectGO, slot1.select)
	gohelper.setActive(slot1.towerItemUI.goNormalIconMask, slot4)
	gohelper.setActive(slot1.towerItemUI.goSelectIconMask, slot4)
	gohelper.setActive(slot1.towerItemUI.imageNormalIcon, not slot4)
	gohelper.setActive(slot1.towerItemUI.imageSelectIcon, not slot4)

	if slot4 then
		slot1.towerItemUI.simageNormalIcon:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(TowerConfig.instance:getAssistBossConfig(TowerConfig.instance:getBossTowerConfig(slot1.data.towerId).bossId).skinId) and slot8.headIcon))
		slot1.towerItemUI.simageSelectIcon:LoadImage(ResUrl.monsterHeadIcon(slot8 and slot8.headIcon))
	else
		UISpriteSetMgr.instance:setTowerSprite(slot1.towerItemUI.imageNormalIcon, slot5 and "tower_tasktimeicon_2" or "tower_tasktimeicon_1")
		UISpriteSetMgr.instance:setTowerSprite(slot1.towerItemUI.imageSelectIcon, slot5 and "tower_tasktimeicon_2" or "tower_tasktimeicon_1")
	end

	slot6 = TowerConfig.instance:getBossTowerConfig(slot1.data.towerId)
	slot1.towerItemUI.txtNormalName.text = slot4 and slot6.name or slot5 and luaLang("towertask_act_name") or luaLang("towertask_timelimited_name")
	slot1.towerItemUI.txtSelectName.text = slot4 and slot6.name or slot5 and luaLang("towertask_act_name") or luaLang("towertask_timelimited_name")
	slot1.towerItemUI.txtNameEn.text = slot4 and slot6.nameEn or slot5 and luaLang("towertask_act_nameEn") or luaLang("towertask_timelimited_nameEn")
	slot1.towerItemUI.txtNormalTaskNum.text = string.format("%s/%s", slot1.data.finishCount, #slot1.data.taskList)
	slot1.towerItemUI.txtSelectTaskNum.text = string.format("%s/%s", slot1.data.finishCount, #slot1.data.taskList)
end

function slot0.findTowerItemUI(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.normalGO = gohelper.findChild(slot1, "normal")
	slot2.selectGO = gohelper.findChild(slot1, "select")
	slot2.imageNormalIcon = gohelper.findChildImage(slot2.normalGO, "image_icon")
	slot2.imageSelectIcon = gohelper.findChildImage(slot2.selectGO, "image_icon")
	slot2.goNormalIconMask = gohelper.findChild(slot2.normalGO, "Mask")
	slot2.goSelectIconMask = gohelper.findChild(slot2.selectGO, "Mask")
	slot2.simageNormalIcon = gohelper.findChildSingleImage(slot2.normalGO, "Mask/image_bossIcon")
	slot2.simageSelectIcon = gohelper.findChildSingleImage(slot2.selectGO, "Mask/image_bossIcon")
	slot2.txtNormalName = gohelper.findChildText(slot2.normalGO, "txt_name")
	slot2.txtSelectName = gohelper.findChildText(slot2.selectGO, "txt_name")
	slot2.txtNormalTaskNum = gohelper.findChildText(slot2.normalGO, "txt_taskNum")
	slot2.txtSelectTaskNum = gohelper.findChildText(slot2.selectGO, "txt_taskNum")
	slot2.goNormalReddot = gohelper.findChild(slot2.normalGO, "go_reddot")
	slot2.goSelectReddot = gohelper.findChild(slot2.selectGO, "go_reddot")
	slot2.txtTime = gohelper.findChildText(slot2.normalGO, "time/txt_time")
	slot2.goSelectTime = gohelper.findChild(slot2.selectGO, "time")
	slot2.txtSelectTime = gohelper.findChildText(slot2.selectGO, "time/txt_time")
	slot2.txtNameEn = gohelper.findChildText(slot2.selectGO, "txt_en")

	return slot2
end

function slot0.taskProgressShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_light"), slot3 <= slot2.finishCount)
end

function slot0.refreshSelectState(slot0)
	slot2 = TowerTaskModel.instance.curSelectToweId

	TowerTaskModel.instance:refreshList(TowerTaskModel.instance.curSelectTowerType)

	for slot6, slot7 in ipairs(slot0.towerItemList) do
		slot7.select = slot1 == slot7.data.type and slot2 == slot7.data.towerId

		gohelper.setActive(slot7.towerItemUI.normalGO, not slot7.select)
		gohelper.setActive(slot7.towerItemUI.selectGO, slot7.select)
	end

	gohelper.setActive(slot0._gobossTowerTips, slot1 == TowerEnum.TowerType.Boss)
	gohelper.setActive(slot0._gotimeTowerScore, slot1 == TowerEnum.TowerType.Limited)

	slot3 = TowerModel.instance:getTowerInfoById(slot1, slot2)

	if slot1 == TowerEnum.TowerType.Boss then
		slot0._txtbossTowerTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerbossepisodepasscount"), TowerAssistBossModel.instance:getById(TowerConfig.instance:getBossTowerConfig(slot2).bossId) and slot5.level or 0, TowerConfig.instance:getAssistBossMaxLev(slot4.bossId))
	elseif slot1 == TowerEnum.TowerType.Limited then
		slot0._txttimeTowerScore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertask_currenthighscore_level"), {
			TowerConfig.instance:getScoreToStarConfig(TowerTimeLimitLevelModel.instance:getHistoryHighScore())
		})
	end
end

function slot0.refreshRemainTime(slot0)
	for slot4, slot5 in ipairs(slot0.towerItemList) do
		slot8, slot9 = TimeUtil.secondToRoughTime2(slot5.data.towerOpenMo and slot6.taskEndTime / 1000 - ServerTime.now() or 0, true)

		gohelper.setActive(slot5.towerItemUI.goSelectTime, slot5.data.type == TowerEnum.ActTaskType)

		if slot5.data.type == TowerEnum.ActTaskType then
			if ActivityModel.instance:getActivityInfo()[slot5.data.timeConfig.activityId] and slot11:isOpen() and not slot11:isExpired() then
				slot12 = slot11:getRealEndTimeStamp() - ServerTime.now()
				slot13 = TimeUtil.SecondToActivityTimeFormat(slot12, true)
				slot5.towerItemUI.txtTime.text = slot12 > 0 and slot13 or ""
				slot5.towerItemUI.txtSelectTime.text = slot12 > 0 and slot13 or ""

				gohelper.setActive(slot5.towerItemUI.txtTime.gameObject, slot12 > 0)
			else
				slot5.towerItemUI.txtTime.text = ""
				slot5.towerItemUI.txtSelectTime.text = ""

				gohelper.setActive(slot5.towerItemUI.txtTime.gameObject, false)
			end
		else
			slot5.towerItemUI.txtTime.text = slot7 > 0 and string.format("%s%s", slot8, slot9) or ""
			slot5.towerItemUI.txtSelectTime.text = slot7 > 0 and string.format("%s%s", slot8, slot9) or ""

			gohelper.setActive(slot5.towerItemUI.txtTime.gameObject, slot7 > 0)
		end
	end

	slot5, slot6 = TimeUtil.secondToRoughTime2(TowerModel.instance:getTowerOpenInfo(TowerTaskModel.instance.curSelectTowerType, TowerTaskModel.instance.curSelectToweId, TowerEnum.TowerStatus.Open) and slot3.taskEndTime / 1000 - ServerTime.now() or 0, true)

	if slot1 == TowerEnum.TowerType.Boss then
		slot0._txtbossTowerTime.text = slot4 > 0 and string.format("%s%s", slot5, slot6) or ""

		gohelper.setActive(slot0._txtbossTowerTime.gameObject, slot4 > 0)
	elseif slot1 == TowerEnum.TowerType.Limited then
		slot0._txttimeTowerTime.text = slot4 > 0 and string.format("%s%s", slot5, slot6) or ""

		gohelper.setActive(slot0._txttimeTowerTime.gameObject, slot4 > 0)
	end
end

function slot0.refreshTaskPos(slot0)
	slot0._scrolltaskList.verticalNormalizedPosition = 1

	recthelper.setAnchorY(slot0._goRight.transform, uv0.NormalTaskCount < TowerTaskModel.instance:getCount() and uv0.MoreTaskPosY or uv0.NormalTaskPosY)
	recthelper.setHeight(slot0._scrolltaskList.gameObject.transform, TowerTaskModel.instance.curSelectTowerType == TowerEnum.ActTaskType and uv0.ActTaskScrollHeight or uv0.NormalTaskScrollHeight)
end

function slot0.refreshLeftUI(slot0)
	slot1 = TowerTaskModel.instance:checkHasBossTask()

	gohelper.setActive(slot0._simageFullBG.gameObject, slot1)
	gohelper.setActive(slot0._goLeft, slot1)
	gohelper.setActive(slot0._goFullBg2, not slot1)
end

function slot0.refreshReddot(slot0)
	for slot4, slot5 in pairs(slot0.towerItemTab) do
		for slot9, slot10 in pairs(slot5) do
			gohelper.setActive(slot10.timeTowerUI.goNormalReddot, TowerTaskModel.instance:canShowReddot(slot4, slot9) and slot4 == TowerEnum.TowerType.Limited)
			gohelper.setActive(slot10.timeTowerUI.goSelectReddot, slot11 and slot4 == TowerEnum.TowerType.Limited)
			gohelper.setActive(slot10.bossTowerUI.goNormalReddot, slot11 and slot4 == TowerEnum.TowerType.Boss)
			gohelper.setActive(slot10.bossTowerUI.goSelectReddot, slot11 and slot4 == TowerEnum.TowerType.Boss)
			gohelper.setActive(slot10.actTowerUI.goNormalReddot, slot11 and slot4 == TowerEnum.ActTaskType)
			gohelper.setActive(slot10.actTowerUI.goSelectReddot, slot11 and slot4 == TowerEnum.ActTaskType)
		end
	end
end

function slot0.refreshActReward(slot0)
	slot2 = TowerTaskModel.instance.curSelectTowerType == TowerEnum.ActTaskType
	slot0.actRewardTaskMO = TowerTaskModel.instance:getActRewardTask()

	gohelper.setActive(slot0._goactReward, slot2 and slot0.actRewardTaskMO)

	if not slot2 or not slot0.actRewardTaskMO then
		return
	end

	if slot0.showActRewardEnter then
		slot0._animActReward:Play(UIAnimationName.Open, 0, 0)
	else
		slot0._animActReward:Play(UIAnimationName.Idle, 0, 0)
	end

	slot0._txtactReward.text = slot0.actRewardTaskMO.config.desc
	slot3 = string.split(slot0.actRewardTaskMO.config.bonus, "#")
	slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot3[1], slot3[2])

	slot0._simageRewardIcon:LoadImage(slot5)

	slot0._txtRewardCount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), slot3[3])
	slot6 = {}

	for slot10 = 1, slot0.actRewardTaskMO.config.maxProgress do
		table.insert(slot6, slot10 <= slot0.actRewardTaskMO.progress and 1 or 0)
	end

	gohelper.setActive(slot0._btnactNormal.gameObject, not TowerTaskModel.instance:isTaskFinished(slot0.actRewardTaskMO) and not slot0.actRewardTaskMO.hasFinished)
	gohelper.setActive(slot0._btnCanget.gameObject, slot0.actRewardTaskMO.hasFinished)
	gohelper.setActive(slot0._goactHasget, TowerTaskModel.instance:isTaskFinished(slot0.actRewardTaskMO) and not slot0.actRewardTaskMO.hasFinished)
	gohelper.CreateObjList(slot0, slot0.taskRewardProgressShow, slot6, slot0._goactPointContent, slot0._goactPointItem)
end

function slot0.taskRewardProgressShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_light"), slot2 == 1)
end

function slot0._playGetRewardFinishAnim(slot0, slot1)
	if slot1 then
		slot0.removeIndexTab = {
			slot1
		}
	end

	TaskDispatcher.runDelay(slot0.delayPlayFinishAnim, slot0, uv0.TaskGetAnimTime)
end

function slot0.delayPlayFinishAnim(slot0)
	slot0._taskAnimRemoveItem:removeByIndexs(slot0.removeIndexTab)
end

function slot0.endEnterAnimBlock(slot0)
	UIBlockMgr.instance:endBlock(uv0.EnterViewAnimBlock)
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0.towerItemList) do
		slot5.btnClick:RemoveClickListener()
		slot5.bossTowerUI.simageNormalIcon:UnLoadImage()
		slot5.bossTowerUI.simageSelectIcon:UnLoadImage()
	end

	UIBlockMgr.instance:endBlock(uv0.EnterViewAnimBlock)
	TaskDispatcher.cancelTask(slot0.endEnterAnimBlock, slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayFinishAnim, slot0)
	slot0._simageRewardIcon:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
