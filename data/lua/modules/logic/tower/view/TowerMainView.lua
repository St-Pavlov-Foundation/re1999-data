module("modules.logic.tower.view.TowerMainView", package.seeall)

slot0 = class("TowerMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "centerTitle/#txt_title")
	slot0._txttitleEn = gohelper.findChildText(slot0.viewGO, "centerTitle/#txt_titleEn")
	slot0._goupdateTime = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_updateTime")
	slot0._golimitTimeUpdateTime = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_limitTimeUpdateTime")
	slot0._txtlimitTimeUpdateTime = gohelper.findChildText(slot0.viewGO, "limitTimeEpisode/#go_limitTimeUpdateTime/#txt_limitTimeUpdateTime")
	slot0._golimitTimeHasNew = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_limitTimeHasNew")
	slot0._btnlimitTime = gohelper.findChildButtonWithAudio(slot0.viewGO, "limitTimeEpisode/#btn_limitTime")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "task/#btn_task")
	slot0._gotaskReddot = gohelper.findChild(slot0.viewGO, "task/#go_taskReddot")
	slot0._gotaskNew = gohelper.findChild(slot0.viewGO, "task/#go_taskNew")
	slot0._gobossUpdateTime = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossUpdateTime")
	slot0._txtbossUpdateTime = gohelper.findChildText(slot0.viewGO, "bossEpisode/#go_bossUpdateTime/#txt_bossUpdateTime")
	slot0._gobossHasNew = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossHasNew")
	slot0._btnboss = gohelper.findChildButtonWithAudio(slot0.viewGO, "bossEpisode/#btn_boss")
	slot0._gobossContent = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossContent")
	slot0._gobossItem = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossContent/#go_bossItem")
	slot0._gobossLockTips = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_locktips")
	slot0._txtaltitudeNum = gohelper.findChildText(slot0.viewGO, "permanentEpisode/progress/#txt_altitudeNum")
	slot0._goprogressContent = gohelper.findChild(slot0.viewGO, "permanentEpisode/progress/#go_progressContent")
	slot0._goprogressItem = gohelper.findChild(slot0.viewGO, "permanentEpisode/progress/#go_progressContent/#go_progressItem")
	slot0._btnpermanent = gohelper.findChildButtonWithAudio(slot0.viewGO, "permanentEpisode/#btn_permanent")
	slot0._goticket = gohelper.findChild(slot0.viewGO, "permanentEpisode/ticket")
	slot0._imageticket = gohelper.findChildImage(slot0.viewGO, "permanentEpisode/ticket/#image_ticket")
	slot0._txtticketNum = gohelper.findChildText(slot0.viewGO, "permanentEpisode/ticket/#txt_ticketNum")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._golimitTimeLockTips = gohelper.findChild(slot0.viewGO, "limitTimeEpisode/#go_limitTimeLockTips")
	slot0._txtlimitTimeLockTips = gohelper.findChildText(slot0.viewGO, "limitTimeEpisode/#go_limitTimeLockTips/#txt_limitTimeLockTips")
	slot0._gobossLockTips = gohelper.findChild(slot0.viewGO, "bossEpisode/#go_bossLockTips")
	slot0._txtbossLockTips = gohelper.findChildText(slot0.viewGO, "bossEpisode/#go_bossLockTips/#txt_bossLockTips")
	slot0._gomopUpReddot = gohelper.findChild(slot0.viewGO, "permanentEpisode/ticket/#go_mopupReddot")
	slot0._btnmopUp = gohelper.findChildButtonWithAudio(slot0.viewGO, "permanentEpisode/ticket/#btn_mopup")
	slot0._gostore = gohelper.findChild(slot0.viewGO, "store")
	slot0._gostoreTime = gohelper.findChild(slot0.viewGO, "store/time")
	slot0._txtstoreTime = gohelper.findChildText(slot0.viewGO, "store/time/#txt_storeTime")
	slot0._txtstoreName = gohelper.findChildText(slot0.viewGO, "store/#txt_storeName")
	slot0._txtcoinNum = gohelper.findChildText(slot0.viewGO, "store/#txt_coinNum")
	slot0._imagecoin = gohelper.findChildImage(slot0.viewGO, "store/#txt_coinNum/#image_coin")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "store/#btn_store")
	slot0._goheroTrial = gohelper.findChild(slot0.viewGO, "heroTrial")
	slot0._btnheroTrial = gohelper.findChildButtonWithAudio(slot0.viewGO, "heroTrial/#btn_heroTrial")
	slot0._goheroTrialNew = gohelper.findChild(slot0.viewGO, "heroTrial/#go_heroTrialNew")
	slot0._goheroTrialNewEffect = gohelper.findChild(slot0.viewGO, "heroTrial/#saoguang")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlimitTime:AddClickListener(slot0._btnlimitTimeOnClick, slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnboss:AddClickListener(slot0._btnbossOnClick, slot0)
	slot0._btnpermanent:AddClickListener(slot0._btnpermanentOnClick, slot0)
	slot0._btnstore:AddClickListener(slot0._btnstoreOnClick, slot0)
	slot0._btnheroTrial:AddClickListener(slot0._btnheroTrialOnClick, slot0)
	slot0._btnmopUp:AddClickListener(slot0._btnmopupOnClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.onDailyReresh, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshRewardTaskInfo, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerMopUp, slot0.refreshPermanentInfo, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshStore, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0.refreshStore, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlimitTime:RemoveClickListener()
	slot0._btntask:RemoveClickListener()
	slot0._btnboss:RemoveClickListener()
	slot0._btnpermanent:RemoveClickListener()
	slot0._btnstore:RemoveClickListener()
	slot0._btnheroTrial:RemoveClickListener()
	slot0._btnmopUp:RemoveClickListener()
	slot0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.onDailyReresh, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshRewardTaskInfo, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerMopUp, slot0.refreshPermanentInfo, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshStore, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0.refreshStore, slot0)
	TaskDispatcher.cancelTask(slot0.refreshTowerState, slot0)
end

function slot0._btnlimitTimeOnClick(slot0)
	if not TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		return
	end

	if not TowerController.instance:isTimeLimitTowerOpen() then
		GameFacade.showToast(ToastEnum.TowerBossLockTips, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum))

		return
	end

	TowerController.instance:openTowerTimeLimitLevelView()
end

function slot0._btntaskOnClick(slot0)
	TowerController.instance:openTowerTaskView()
end

function slot0._btnstoreOnClick(slot0)
	TowerController.instance:openTowerStoreView()
end

function slot0._btnbossOnClick(slot0)
	if not TowerController.instance:isBossTowerOpen() then
		GameFacade.showToast(ToastEnum.TowerBossLockTips, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen))

		return
	end

	if not TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSelectView)
end

function slot0._btnpermanentOnClick(slot0)
	TowerController.instance:openTowerPermanentView()
end

function slot0._btnheroTrialOnClick(slot0)
	TowerController.instance:openTowerHeroTrialView()
	slot0:saveHeroTrialNew()
	gohelper.setActive(slot0._goheroTrialNew, false)
end

function slot0._btnmopupOnClick(slot0)
	TowerController.instance:openTowerMopUpView()
end

function slot0._editableInitView(slot0)
	slot0.bossItemTab = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goheroTrialNewEffect, false)
end

function slot0.onDailyReresh(slot0)
	slot0:refreshUI()
end

function slot0.onLocalKeyChange(slot0)
	slot0:refreshBossNewTag()
	slot0:refreshLimitedActTaskNew()
end

function slot0.onUpdateParam(slot0)
	slot0:checkJump()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_leimi_theft_open)
	TowerModel.instance:cleanTrialData()
	slot0:checkJump()
	slot0:refreshUI()
	slot0:initReddot()
	TaskDispatcher.runDelay(slot0.checkShowEffect, slot0, 0.6)
end

function slot0.checkShowEffect(slot0)
	gohelper.setActive(slot0._goheroTrialNewEffect, TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 0) == 0)
end

function slot0.initReddot(slot0)
	RedDotController.instance:addRedDot(slot0._gomopUpReddot, RedDotEnum.DotNode.TowerMopUp)
	RedDotController.instance:addRedDot(slot0._gotaskReddot, RedDotEnum.DotNode.TowerTask)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function slot0.refreshUI(slot0)
	slot0:refreshPermanentInfo()
	slot0:initTaskInfo()
	slot0:refreshRewardTaskInfo()
	slot0:refreshBossInfo()
	slot0:refreshBossNewTag()
	slot0:refreshEntranceUI()
	slot0:refreshTowerState()
	slot0:refreshStore()
	slot0:refreshHeroTrialNew()
	slot0:refreshLimitedActTaskNew()
	TaskDispatcher.cancelTask(slot0.refreshTowerState, slot0)
	TaskDispatcher.runRepeat(slot0.refreshTowerState, slot0, 1)
end

function slot0.checkJump(slot0)
	if not slot0.viewParam then
		return
	end

	slot1 = TowerModel.instance:getRecordFightParam()

	if slot0.viewParam.jumpId == TowerEnum.JumpId.TowerPermanent then
		if tabletool.len(slot1) > 0 and slot1.towerType == TowerEnum.TowerType.Normal then
			TowerPermanentModel.instance:setLastPassLayer(slot1.layerId)
			TowerController.instance:openTowerPermanentView(slot1)
		else
			slot0:_btnpermanentOnClick()
		end
	elseif slot2 == TowerEnum.JumpId.TowerBoss then
		if not slot0.viewParam.towerId then
			ViewMgr.instance:openView(ViewName.TowerBossSelectView)
		else
			TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, slot0.viewParam.towerId, {
				passLayerId = slot0.viewParam.passLayerId
			})
		end
	elseif slot2 == TowerEnum.JumpId.TowerLimited then
		slot0:_btnlimitTimeOnClick()
	elseif slot2 == TowerEnum.JumpId.TowerBossTeach then
		TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, slot0.viewParam.towerId, {
			isTeach = true,
			lastFightTeachId = TowerBossTeachModel.instance:getLastFightTeachId()
		})
		TowerBossTeachModel.instance:setLastFightTeachId(0)
	end

	if slot0.viewParam.jumpId then
		slot0.viewParam.jumpId = nil
	end
end

function slot0.refreshEntranceUI(slot0)
	slot2 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TaskRewardOpen)
	slot5 = tabletool.len(TowerTaskModel.instance.limitTimeTaskList) + tabletool.len(TowerTaskModel.instance.bossTaskList)

	gohelper.setActive(slot0._goticket, tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)) <= TowerPermanentModel.instance:getCurPermanentPassLayer())
end

function slot0.initTaskInfo(slot0)
	TowerTaskModel.instance:setTaskInfoList(TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {})
end

function slot0.refreshPermanentInfo(slot0)
	slot0._txtticketNum.text = string.format("<color=#EA9465>%s</color>/%s", TowerModel.instance:getMopUpTimes(), TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes))

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageticket, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon) .. "_1", true)

	slot0.curPassLayer = TowerPermanentModel.instance.curPassLayer
	slot4 = TowerConfig.instance:getPermanentEpisodeCo(slot0.curPassLayer)
	slot5 = TowerConfig.instance:getPermanentEpisodeCo(slot0.curPassLayer + 1)

	if TowerPermanentModel.instance:getCurPassEpisodeId() == 0 then
		slot0._txtaltitudeNum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_defaultlayer"), {
			0
		})
	else
		slot0._txtaltitudeNum.text = DungeonConfig.instance:getEpisodeCO(slot6).name
	end

	slot9 = slot5 and slot5.stageId or (slot4 and slot4.stageId or 1) + 1
	slot10 = {}

	for slot14 = 1, TowerPermanentModel.instance:getStageCount() do
		table.insert(slot10, {
			curstageId = slot8 == slot9 and slot8 or slot9
		})
	end

	gohelper.CreateObjList(slot0, slot0.progressItemShow, slot10, slot0._goprogressContent, slot0._goprogressItem)
end

function slot0.progressItemShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_normal"), slot2.curstageId <= slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_finish"), slot3 < slot6)
end

function slot0.refreshRewardTaskInfo(slot0)
end

function slot0.refreshBossInfo(slot0)
	slot2 = {}

	if #TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open) > 0 then
		table.sort(slot1, TowerAssistBossModel.sortBossList)

		for slot6 = 1, 3 do
			if slot1[slot6] then
				table.insert(slot2, slot1[slot6])
			end
		end
	end

	slot0.bossEpisodeMo = TowerModel.instance:getEpisodeMoByTowerType(TowerEnum.TowerType.Boss)

	gohelper.CreateObjList(slot0, slot0.bossItemShow, slot2, slot0._gobossContent, slot0._gobossItem)

	slot3 = TowerController.instance:isBossTowerOpen()

	gohelper.setActive(slot0._gobossContent, slot3)
	gohelper.setActive(slot0._gobossLockTips, not slot3)
end

function slot0.refreshBossNewTag(slot0)
	gohelper.setActive(slot0._gobossHasNew, TowerModel.instance:hasNewBossOpen())
end

function slot0.bossItemShow(slot0, slot1, slot2, slot3)
	if not slot0.bossItemTab[slot3] then
		slot0.bossItemTab[slot3] = {}
	end

	slot4.go = slot1
	slot4.simageEnemy = gohelper.findChildSingleImage(slot4.go, "Mask/image_bossIcon")
	slot4.goSelected = gohelper.findChild(slot4.go, "#go_Selected")

	slot4.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(TowerConfig.instance:getAssistBossConfig(TowerConfig.instance:getBossTowerConfig(slot2.id).bossId).skinId) and slot8.headIcon))
	gohelper.setActive(slot4.goSelected, not slot0.bossEpisodeMo:isPassAllUnlockLayers(slot2.id))
end

function slot0.refreshTowerState(slot0)
	slot2 = TowerController.instance:isTimeLimitTowerOpen()
	slot3 = TowerEnum.LockKey
	slot4 = 0

	if TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		slot3 = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, slot1.id, slot1, TowerEnum.LockKey)
		slot4 = slot1.nextTime / 1000 - ServerTime.now()
		slot5, slot6 = TimeUtil.secondToRoughTime2(slot4)
		slot0._txtlimitTimeUpdateTime.text = slot4 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			slot5,
			slot6
		}) or ""
	end

	slot5 = not slot3 or slot3 == TowerEnum.LockKey

	gohelper.setActive(slot0._golimitTimeHasNew, slot5 and slot2 and slot1)
	gohelper.setActive(slot0._golimitTimeUpdateTime, not slot5 and slot2 and slot1 and slot4 > 0)

	slot6 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)

	if not slot1 then
		if TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited) then
			slot9, slot10 = TimeUtil.secondToRoughTime2(slot7.nextTime / 1000 - ServerTime.now())
			slot0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				slot9,
				slot10
			})
		else
			slot0._txtlimitTimeLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not slot2 then
		slot0._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			slot6 * 10
		})
	end

	gohelper.setActive(slot0._golimitTimeLockTips, not slot1 or not slot2)

	slot7 = TowerModel.instance:hasNewBossOpen()
	slot8 = TowerController.instance:isBossTowerOpen()
	slot9 = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)
	slot11 = -1

	for slot15, slot16 in ipairs(TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)) do
		if slot11 > slot16.nextTime / 1000 - ServerTime.now() or slot11 <= 0 then
			slot11 = slot17
		end
	end

	slot12, slot13 = TimeUtil.secondToRoughTime2(slot11)
	slot0._txtbossUpdateTime.text = slot11 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
		slot12,
		slot13
	}) or ""

	gohelper.setActive(slot0._gobossHasNew, slot7 and slot8 and slot9)
	gohelper.setActive(slot0._gobossUpdateTime, not slot7 and slot8 and slot9 and slot11 > 0)
	gohelper.setActive(slot0._gobossContent, slot8)

	slot14 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

	if not slot9 then
		if TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss) then
			slot17, slot18 = TimeUtil.secondToRoughTime2(slot15.nextTime / 1000 - ServerTime.now())
			slot0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				slot17,
				slot18
			})
		else
			slot0._txtbossLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not slot8 then
		slot0._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			slot14 * 10
		})
	end

	gohelper.setActive(slot0._gobossLockTips, not slot9 or not slot8)
	slot0:refreshStoreTime()
end

function slot0.refreshStore(slot0)
	gohelper.setActive(slot0._gostore, TowerController.instance:isTowerStoreOpen())
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecoin, TowerStoreModel.instance:getCurrencyIcon())

	slot0._txtcoinNum.text = TowerStoreModel.instance:getCurrencyCount()

	slot0:refreshStoreTime()
end

function slot0.refreshStoreTime(slot0)
	slot1 = TowerStoreModel.instance:isUpdateStoreEmpty()

	gohelper.setActive(slot0._gostoreTime, not slot1)

	if slot1 then
		return
	end

	slot0._txtstoreTime.text = TowerStoreModel.instance:getUpdateStoreRemainTime()
end

function slot0.saveHeroTrialNew(slot0)
	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, TowerModel.instance:getTrialHeroSeason())
end

function slot0.refreshHeroTrialNew(slot0)
	gohelper.setActive(slot0._goheroTrial, TowerModel.instance:getTrialHeroSeason() > 0)
	gohelper.setActive(slot0._goheroTrialNew, TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, 0) ~= slot2 and slot2 > 0)
end

function slot0.refreshLimitedActTaskNew(slot0)
	slot4 = #TowerTaskModel.instance.actTaskList > 0 and slot1[1].config.activityId or 0
	slot5 = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewLimitedActTask, 0) ~= slot4 and slot4 > 0

	gohelper.setActive(slot0._gotaskNew, slot5)
	gohelper.setActive(slot0._gotaskReddot, not slot5)
end

function slot0.onClose(slot0)
	TowerTaskModel.instance:cleanData()
	TaskDispatcher.cancelTask(slot0.refreshTowerState, slot0)
	TaskDispatcher.cancelTask(slot0.checkShowEffect, slot0)
	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 1)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.bossItemTab) do
		slot5.simageEnemy:UnLoadImage()
	end
end

return slot0
