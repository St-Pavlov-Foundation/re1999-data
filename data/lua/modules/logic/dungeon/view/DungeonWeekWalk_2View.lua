module("modules.logic.dungeon.view.DungeonWeekWalk_2View", package.seeall)

slot0 = class("DungeonWeekWalk_2View", BaseView)

function slot0.onInitView(slot0)
	slot0._btnenterbtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/shallowbox/#btn_enterbtn")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/shallowbox/#btn_reward")
	slot0._golingqu = gohelper.findChild(slot0.viewGO, "anim/shallowbox/#btn_reward/#go_lingqu")
	slot0._gorewardredpoint = gohelper.findChild(slot0.viewGO, "anim/shallowbox/#btn_reward/#go_rewardredpoint")
	slot0._txttaskprogress = gohelper.findChildText(slot0.viewGO, "anim/shallowbox/#btn_reward/#txt_taskprogress")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/deepbox/#btn_start")
	slot0._goeasy = gohelper.findChild(slot0.viewGO, "anim/deepbox/map/scenetype/#go_easy")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "anim/deepbox/map/scenetype/#go_hard")
	slot0._txtscenetype = gohelper.findChildText(slot0.viewGO, "anim/deepbox/map/scenetype/#txt_scenetype")
	slot0._txtcurprogress = gohelper.findChildText(slot0.viewGO, "anim/deepbox/map/#txt_curprogress")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "anim/deepbox/limittime/#txt_time")
	slot0._txtmaptaskprogress = gohelper.findChildText(slot0.viewGO, "anim/deepbox/#txt_maptaskprogress")
	slot0._gomapprogressitem = gohelper.findChild(slot0.viewGO, "anim/deepbox/mapprogresslist/#go_mapprogressitem")
	slot0._btnstart2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/heartbox/#btn_start_2")
	slot0._goeasy2 = gohelper.findChild(slot0.viewGO, "anim/heartbox/map/scenetype/#go_easy2")
	slot0._gohard2 = gohelper.findChild(slot0.viewGO, "anim/heartbox/map/scenetype/#go_hard2")
	slot0._txtscenetype2 = gohelper.findChildText(slot0.viewGO, "anim/heartbox/map/scenetype/#txt_scenetype2")
	slot0._txtcurprogress2 = gohelper.findChildText(slot0.viewGO, "anim/heartbox/map/#txt_curprogress2")
	slot0._btnreward2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/heartbox/map/#btn_reward2")
	slot0._gobubble = gohelper.findChild(slot0.viewGO, "anim/heartbox/map/#btn_reward2/#go_bubble")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "anim/heartbox/map/#btn_reward2/#go_bubble/#simage_icon")
	slot0._gomapprogressitem2 = gohelper.findChild(slot0.viewGO, "anim/heartbox/mapprogresslist/#go_mapprogressitem2")
	slot0._txttime2 = gohelper.findChildText(slot0.viewGO, "anim/heartbox/limittime/#txt_time2")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "anim/heartbox/badgelist/1/badgelayout/#go_item_1")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "anim/heartbox/badgelist/2/badgelayout/#go_item_2")
	slot0._btnshop = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/#btn_shop")
	slot0._simagebgimgnext = gohelper.findChildSingleImage(slot0.viewGO, "transition/ani/#simage_bgimg_next")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnenterbtn:AddClickListener(slot0._btnenterbtnOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnstart2:AddClickListener(slot0._btnstart2OnClick, slot0)
	slot0._btnreward2:AddClickListener(slot0._btnreward2OnClick, slot0)
	slot0._btnshop:AddClickListener(slot0._btnshopOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnenterbtn:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnstart2:RemoveClickListener()
	slot0._btnreward2:RemoveClickListener()
	slot0._btnshop:RemoveClickListener()
end

function slot0._btnreward2OnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = 0
	})
end

function slot0._btnstart2OnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView()
end

function slot0._btnenterbtnOnClick(slot0)
	module_views_preloader.WeekWalkLayerViewPreload(function ()
		WeekWalkController.instance:openWeekWalkLayerView({
			layerId = 10
		})
	end)
end

function slot0._btnrewardOnClick(slot0)
	WeekWalkController.instance:openWeekWalkRewardView()
end

function slot0._btnshopOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		slot0:_openStoreView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end
end

function slot0._updateTaskStatus(slot0)
	slot1 = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week)

	gohelper.setActive(slot0._golingqu, slot1)
	gohelper.setActive(slot0._gorewardredpoint, slot1)
end

function slot0._openStoreView(slot0)
	StoreController.instance:openStoreView(StoreEnum.WeekWalkTabId)
end

function slot0._btnstartOnClick(slot0)
	slot0:openWeekWalkView()
end

function slot0._initImgs(slot0)
	slot0._simagexingdian1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#xingdian1")
	slot0._simagelefttopglow = gohelper.findChildSingleImage(slot0.viewGO, "bg/#lefttop_glow")
	slot0._simagelefttopglow2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#lefttop_glow2")
	slot0._simageleftdownglow = gohelper.findChildSingleImage(slot0.viewGO, "bg/#leftdown_glow")
	slot0._simagerihtttopglow = gohelper.findChildSingleImage(slot0.viewGO, "bg/#rihtttop_glow")
	slot0._simagerihtttopblack = gohelper.findChildSingleImage(slot0.viewGO, "bg/#rihtttop_black")
	slot0._simagecenterdown = gohelper.findChildSingleImage(slot0.viewGO, "bg/#centerdown")

	slot0._simagexingdian1:LoadImage(ResUrl.getWeekWalkBg("xingdian.png"))
	slot0._simagelefttopglow:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow.png"))
	slot0._simagelefttopglow2:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow2.png"))
	slot0._simageleftdownglow:LoadImage(ResUrl.getWeekWalkBg("leftdown_glow.png"))
	slot0._simagerihtttopglow:LoadImage(ResUrl.getWeekWalkBg("righttop_glow.png"))
	slot0._simagerihtttopblack:LoadImage(ResUrl.getWeekWalkBg("leftdown_black.png"))
	slot0._simagecenterdown:LoadImage(ResUrl.getWeekWalkBg("centerdown.png"))
end

function slot0._editableInitView(slot0)
	WeekWalkController.instance:requestTask()
	slot0:_showBonus()
	slot0:_updateTaskStatus()
	slot0:_onWeekwalk_2TaskUpdate()
	slot0:_showDeadline()
	WeekWalkController.instance:startCheckTime()
	slot0:_initImgs()

	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:_showProgress()
	slot0:_showProgress2()
	gohelper.addUIClickAudio(slot0._btnstart.gameObject, AudioEnum.WeekWalk.play_artificial_ui_entrance)
	gohelper.addUIClickAudio(slot0._btnreward.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskopen)
	gohelper.addUIClickAudio(slot0._btnshop.gameObject, AudioEnum.UI.play_ui_checkpoint_sources_open)
	slot0:_initOnOpen()
end

function slot0._updateDegrade(slot0)
	gohelper.setActive(slot0._btndegrade.gameObject, WeekWalkModel.instance:getLevel() >= 2 and WeekWalkModel.instance:getChangeLevel() <= 0)
end

function slot0._showProgress2(slot0)
	slot2, slot3 = WeekWalk_2Model.instance:getInfo():getNotFinishedMap()

	if not slot2 then
		logError("DungeonWeekWalk_2View _showProgress2 map is nil")

		return
	end

	slot4 = slot2.sceneConfig
	slot0._txtcurprogress2.text = string.format("【%s】", slot4.battleName)
	slot0._txtscenetype2.text = string.format("%s%s", slot4.typeName, slot4.name)
	slot0._mapFinishItemTab2 = slot0._mapFinishItemTab2 or slot0:getUserDataTb_()

	for slot8, slot9 in pairs(slot0._mapFinishItemTab2) do
		gohelper.setActive(slot9, false)
	end

	for slot8 = 1, WeekWalk_2Enum.MaxLayer do
		if not slot0._mapFinishItemTab2[slot8] then
			slot0._mapFinishItemTab2[slot8] = gohelper.cloneInPlace(slot0._gomapprogressitem2, "item_" .. slot8)
		end

		gohelper.setActive(slot9, true)

		slot13 = slot1:getLayerInfoByLayerIndex(slot8) and slot12.finished

		gohelper.setActive(gohelper.findChild(slot9, "finish"), slot13)
		gohelper.setActive(gohelper.findChild(slot9, "unfinish"), not slot13)
		gohelper.setActive(gohelper.findChild(slot9, "finish_light_deepdream01"), slot13)
	end

	slot0._battleStar1List = slot0._battleStar1List or slot0:getUserDataTb_()
	slot0._battleStar2List = slot0._battleStar2List or slot0:getUserDataTb_()

	slot0:_showBattleInfo(slot0._battleStar1List, slot0._goitem1, slot2:getBattleInfoByIndex(WeekWalk_2Enum.BattleIndex.First))
	slot0:_showBattleInfo(slot0._battleStar2List, slot0._goitem2, slot2:getBattleInfoByIndex(WeekWalk_2Enum.BattleIndex.Second))
end

function slot0._showBattleInfo(slot0, slot1, slot2, slot3)
	slot7 = false

	gohelper.setActive(slot2, slot7)

	for slot7 = 1, WeekWalk_2Enum.MaxStar do
		if not slot1[slot7] then
			slot9 = gohelper.cloneInPlace(slot2)
			slot10 = gohelper.findChildImage(slot9, "1")

			gohelper.setActive(slot9, true)

			slot10.enabled = false
			slot1[slot7] = slot0.viewContainer:getResInst(slot0.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot10.gameObject)
		end

		WeekWalk_2Helper.setCupEffectByResult(slot8, slot3:getCupInfo(slot7) and slot9.result or 0)
	end
end

function slot0._showProgress(slot0)
	slot2, slot3 = WeekWalkModel.instance:getInfo():getNotFinishedMap()
	slot4 = lua_weekwalk_scene.configDict[slot2.sceneId]
	slot0._txtcurprogress.text = string.format("【%s】", slot4.battleName)
	slot0._txtscenetype.text = string.format("%s%s", slot4.typeName, slot4.name)

	if slot2 then
		slot5, slot6 = slot2:getCurStarInfo()
		slot0._txtmaptaskprogress.text = string.format("%s/%s", slot5, slot6)
	else
		slot0._txtmaptaskprogress.text = "0/10"
	end

	slot5 = WeekWalkModel.isShallowMap(slot2.sceneId)

	gohelper.setActive(slot0._goeasy, slot5)
	gohelper.setActive(slot0._gohard, not slot5)

	slot0._mapFinishItemTab = slot0._mapFinishItemTab or slot0:getUserDataTb_()
	slot6 = slot1:getMapInfos()
	slot7 = 1
	slot8 = 10

	if not slot5 then
		slot8 = 11 + #WeekWalkConfig.instance:getDeepLayer(WeekWalkModel.instance:getInfo().issueId) - 1
	end

	for slot12, slot13 in pairs(slot0._mapFinishItemTab) do
		gohelper.setActive(slot13, false)
	end

	for slot12 = slot7, slot8 do
		if not slot0._mapFinishItemTab[slot12] then
			slot0._mapFinishItemTab[slot12] = gohelper.cloneInPlace(slot0._gomapprogressitem, "item_" .. slot12)
		end

		gohelper.setActive(slot13, true)
		gohelper.setActive(gohelper.findChild(slot13, "finish"), slot6[slot12] and slot15.isFinished > 0)

		slot17 = gohelper.findChildImage(slot13, "unfinish")
		slot18 = gohelper.findChildImage(slot13, "finish")

		if not UISpriteSetMgr.instance:getWeekWalkSpriteSetUnit() then
			slot0:_setImgAlpha(slot17, 0)
			slot0:_setImgAlpha(slot18, 0)
		end

		UISpriteSetMgr.instance:setWeekWalkSprite(slot17, slot5 and "btn_dian2" or "btn_dian4", true, 1)
		UISpriteSetMgr.instance:setWeekWalkSprite(slot18, slot5 and "btn_dian1" or "btn_dian3", true, 1)
		gohelper.setActive(gohelper.findChild(slot13, "finish_light_deepdream01"), not slot5 and slot16)
		gohelper.setActive(gohelper.findChild(slot13, "finish_light"), slot5 and slot16)
	end
end

function slot0._setImgAlpha(slot0, slot1, slot2)
	slot3 = slot1.color
	slot3.a = slot2
	slot1.color = slot3
end

function slot0.getWeekTaskProgress()
	slot0 = 0
	slot1 = 0
	slot2 = {}

	WeekWalkTaskListModel.instance:showTaskList(WeekWalkEnum.TaskType.Week)

	for slot7, slot8 in ipairs(WeekWalkTaskListModel.instance:getList()) do
		if WeekWalkTaskListModel.instance:getTaskMo(slot8.id) and (slot9.finishCount > 0 or slot9.hasFinished) then
			slot14 = "|"
			slot15 = "#"

			for slot14, slot15 in ipairs(GameUtil.splitString2(slot8.bonus, true, slot14, slot15)) do
				slot18 = slot15[3]

				if not slot2[string.format("%s_%s", slot15[1], slot15[2])] then
					slot2[slot19] = slot15
				else
					slot20[3] = slot20[3] + slot18
					slot2[slot19] = slot20
				end
			end
		end

		if slot9 then
			slot0 = math.max(slot9.progress or 0, slot0)
		end

		if lua_task_weekwalk.configDict[slot8.id] then
			slot1 = math.max(slot10.maxProgress or 0, slot1)
		end
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot2) do
		table.insert(slot4, slot9)
	end

	table.sort(slot4, uv0._sort)

	return slot0, slot1, slot4
end

function slot0._sort(slot0, slot1)
	if ItemModel.instance:getItemConfig(slot0[1], slot0[2]).rare ~= ItemModel.instance:getItemConfig(slot1[1], slot1[2]).rare then
		return slot3.rare < slot2.rare
	end

	return slot1[3] < slot0[3]
end

function slot0._showBonus(slot0)
	if not WeekWalkTaskListModel.instance:hasTaskList() then
		return
	end

	slot1, slot2, slot3 = uv0.getWeekTaskProgress()
	slot0._txttaskprogress.text = string.format("%s/%s", slot1, slot2)

	if slot0._gorewards then
		gohelper.destroyAllChildren(slot0._gorewards)

		for slot7, slot8 in ipairs(slot3) do
			slot9 = IconMgr.instance:getCommonItemIcon(slot0._gorewards)

			slot9:setMOValue(slot8[1], slot8[2], slot8[3])
			slot9:isShowCount(true)
			slot9:setCountFontSize(31)
		end
	end

	slot4 = #slot3 > 0

	gohelper.setActive(slot0._goempty, not slot4)
	gohelper.setActive(slot0._gohasrewards, slot4)
end

function slot0.onUpdateParam(slot0)
	slot0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
end

function slot0.onShow(slot0)
	slot0.viewContainer:setNavigateButtonViewHelpId()
	slot0:_showWeekWalkSettlementView()

	if slot0._bgmId then
		return
	end
end

function slot0._onFinishGuide(slot0, slot1)
	if slot1 == 501 then
		slot0:_showWeekWalkSettlementView()
	end
end

function slot0._showWeekWalkSettlementView(slot0)
	if GameGlobalMgr.instance:getLoadingState() and slot1:getLoadingViewName() then
		return
	end

	if WeekWalkModel.instance:getSkipShowSettlementView() then
		WeekWalkModel.instance:setSkipShowSettlementView(false)

		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	if WeekWalkModel.instance:getInfo().isPopShallowSettle then
		WeekWalkController.instance:openWeekWalkShallowSettlementView()

		return
	end

	if slot2.isPopDeepSettle then
		WeekWalkController.instance:checkOpenWeekWalkDeepLayerNoticeView()

		return
	end

	WeekWalk_2Controller.instance:checkOpenWeekWalk_2DeepLayerNoticeView()
end

function slot0.onHide(slot0)
	slot0.viewContainer:resetNavigateButtonViewHelpId()
end

function slot0.onOpen(slot0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, slot0._refreshHelpFunc, slot0._refreshTarget)
	slot0:onShow()
end

function slot0.onOpenFinish(slot0)
	slot0.viewContainer:destoryTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
end

function slot0._showDeadline(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	slot0._endTaskTime = WeekWalkController.getTaskEndTime(WeekWalkEnum.TaskType.Week)
	slot0._endTime = WeekWalkModel.instance:getInfo().endTime
	slot0._heartEndTime = WeekWalk_2Model.instance:getInfo().endTime

	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	slot0:_onRefreshDeadline()
end

function slot0._onRefreshDeadline(slot0)
	if slot0._endTaskTime and slot0._endTaskTime - ServerTime.now() <= 0 then
		slot0._endTaskTime = nil

		WeekWalkController.instance:requestTask(true)
	end

	slot1 = luaLang("p_dungeonweekwalkview_device")

	if slot0._endTime then
		if slot0._endTime - ServerTime.now() <= 0 then
			slot0._endTime = nil

			TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
		end

		slot3, slot4 = TimeUtil.secondToRoughTime2(math.floor(slot2))
		slot0._txttime.text = slot1 .. slot3 .. slot4
	end

	if slot0._heartEndTime then
		if slot0._heartEndTime - ServerTime.now() <= 0 then
			slot0._heartEndTime = nil

			TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
		end

		slot3, slot4 = TimeUtil.secondToRoughTime2(math.floor(slot2))
		slot0._txttime2.text = slot1 .. slot3 .. slot4
	end
end

function slot0._onGetInfo(slot0)
	slot0:_showDeadline()
end

function slot0._onWeekwalkTaskUpdate(slot0)
	if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
		return
	end

	slot0:_updateTaskStatus()
	slot0:_showBonus()
	slot0:_showDeadline()
end

function slot0._onWeekwalk_2TaskUpdate(slot0)
	slot2, slot3 = WeekWalk_2TaskListModel.instance:canGetRewardNum(WeekWalk_2Enum.TaskType.Once)

	gohelper.setActive(slot0._gobubble, true)

	slot0._gobubbleReddot = slot0._gobubbleReddot or gohelper.findChild(slot0.viewGO, "anim/heartbox/map/#btn_reward2/reddot")

	gohelper.setActive(slot0._gobubbleReddot, slot2 > 0)

	if slot2 == 0 and slot3 == 0 then
		gohelper.setActive(slot0._btnreward2, false)
	end
end

function slot0._initOnOpen(slot0)
	slot1 = slot0.viewContainer._navigateButtonView
	slot0._refreshHelpFunc = slot1.showHelpBtnIcon
	slot0._refreshTarget = slot1

	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, slot0._OnSelectLevel, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, slot0._onWeekwalk_2TaskUpdate, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, slot0._onGetInfo, slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, slot0._onGetInfo, slot0)
end

function slot0._OnSelectLevel(slot0)
	slot0._dropLevel.dropDown.enabled = false

	if WeekWalkModel.instance:getChangeLevel() > 0 then
		return
	end

	slot0:openWeekWalkView()
end

function slot0.openWeekWalkView(slot0)
	module_views_preloader.WeekWalkLayerViewPreload(function ()
		uv0:delayOpenWeekWalkView()
	end)
end

function slot0.delayOpenWeekWalkView(slot0)
	WeekWalkController.instance:openWeekWalkLayerView()
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.WeekWalkLayerView or slot1 == ViewName.WeekWalk_2HeartLayerView or slot1 == ViewName.StoreView then
		gohelper.setActive(gohelper.findChild(ViewMgr.instance:getContainer(ViewName.DungeonView).viewGO, "top_left"), true)
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.WeekWalkLayerView then
		-- Nothing
	end

	if slot1 == ViewName.WeekWalkLayerView or slot1 == ViewName.WeekWalk_2HeartLayerView or slot1 == ViewName.StoreView then
		if slot1 == ViewName.WeekWalk_2HeartLayerView then
			slot0._viewAnim:Play("dungeonweekwalk_out2", 0, 0)
		else
			slot0._viewAnim:Play("dungeonweekwalk_out", 0, 0)
		end

		slot2 = ViewMgr.instance:getContainer(ViewName.DungeonView)

		gohelper.setAsLastSibling(slot2.viewGO)
		gohelper.setActive(gohelper.findChild(slot2.viewGO, "top_left"), false)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.WeekWalkLayerView then
		slot0:_showProgress()
		slot0:_showWeekWalkSettlementView()
		slot0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif slot1 == ViewName.StoreView then
		slot0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif slot1 == ViewName.WeekWalkRewardView then
		slot0:_onWeekwalkTaskUpdate()
	elseif slot1 == ViewName.WeekWalk_2HeartLayerView then
		slot0:_showProgress2()
		slot0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	end
end

function slot0.onClose(slot0)
	slot0:onHide()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, slot0._refreshHelpFunc, slot0._refreshTarget)
end

function slot0._clearOnDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.delayOpenWeekWalkView, slot0)
	TaskDispatcher.cancelTask(slot0._openStoreView, slot0)
	slot0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, slot0._OnSelectLevel, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0, LuaEventSystem.Low)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0, LuaEventSystem.Low)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0, LuaEventSystem.Low)
	slot0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
	slot0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, slot0._onGetInfo, slot0)
	slot0:removeEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, slot0._onGetInfo, slot0)
	slot0:removeEventCb(GuideController.instance, GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_clearOnDestroy()
	slot0._simagexingdian1:UnLoadImage()
	slot0._simagelefttopglow:UnLoadImage()
	slot0._simagelefttopglow2:UnLoadImage()
	slot0._simageleftdownglow:UnLoadImage()
	slot0._simagerihtttopglow:UnLoadImage()
	slot0._simagerihtttopblack:UnLoadImage()
	slot0._simagecenterdown:UnLoadImage()
end

return slot0
