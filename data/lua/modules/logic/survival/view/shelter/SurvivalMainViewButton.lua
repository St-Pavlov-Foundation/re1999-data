module("modules.logic.survival.view.shelter.SurvivalMainViewButton", package.seeall)

local var_0_0 = class("SurvivalMainViewButton", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnExit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_lefttop/#btn_exit")
	arg_1_0.btnTarget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Left/#btn_target")
	arg_1_0.btnRoleWareHouse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Left/#btn_RoleWarehouse")
	arg_1_0.btnEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Left/#btn_equip")
	arg_1_0._goequipred = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Left/#btn_equip/go_arrow")
	arg_1_0.btnTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Left/#btn_talent")
	arg_1_0.btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/BottomRight/#btn_start")
	arg_1_0.btnDecree = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_law")
	arg_1_0.btnNpc = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/BottomRight/#btn_npc")
	arg_1_0.btnWareHouse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_Warehouse")
	arg_1_0.btnBuilding = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_build")
	arg_1_0.goNewBuilding = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_build/go_New")
	arg_1_0.goLevupBuilding = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_build/go_levelUp")
	arg_1_0.goFixBuilding = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/BottomRight/layout/#btn_build/go_Fix")
	arg_1_0.txtProgress = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_normalroot/Top/#go_progress/#txt_progress")
	arg_1_0.goMonster = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Top/#go_monster")
	arg_1_0.btnMonster = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Top/#go_monster")
	arg_1_0.sImgMonster = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_normalroot/Top/#go_monster/#go_monsterHeadIcon")
	arg_1_0.txtMonsterTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_normalroot/Top/#go_monster/#txt_LimitTime")
	arg_1_0.goMonsterTimeIcon = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Top/#go_monster/#txt_LimitTime/icon")
	arg_1_0.txtTaskDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_target")
	arg_1_0.txtSubTaskDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_normalroot/Left/#go_target/TargetView/Viewport/Content/#txt_sub")
	arg_1_0.goUI = gohelper.findChild(arg_1_0.viewGO, "go_ui")
	arg_1_0.goUI2 = gohelper.findChild(arg_1_0.viewGO, "go_ui2")
	arg_1_0.goNormalRoot = gohelper.findChild(arg_1_0.viewGO, "go_normalroot")
	arg_1_0.goLeftTop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0.igoreViewList = {
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.GMGuideStatusView
	}
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.goRaycast = gohelper.findChild(arg_1_0.viewGO, "raycast")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnExit, arg_2_0.onClickExit, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnStart, arg_2_0.onClickStart, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnEquip, arg_2_0.onClickEquip, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTalent, arg_2_0.onClickTalent, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRoleWareHouse, arg_2_0.onClickRoleWareHouse, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTarget, arg_2_0.onClickTarget, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnNpc, arg_2_0.onClickNpc, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBuilding, arg_2_0.onClickBuilding, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnDecree, arg_2_0.onClickDecree, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnWareHouse, arg_2_0.onClickWareHouse, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnMonster, arg_2_0.onClickMonster, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, arg_2_0.onTaskDataUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, arg_2_0.onWeekInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_2_0.onBuildingInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.AbandonFight, arg_2_0.refreshMonster, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, arg_2_0.updateEquipRed, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnExit)
	arg_3_0:removeClickCb(arg_3_0.btnStart)
	arg_3_0:removeClickCb(arg_3_0.btnNpc)
	arg_3_0:removeClickCb(arg_3_0.btnBuilding)
	arg_3_0:removeClickCb(arg_3_0.btnEquip)
	arg_3_0:removeClickCb(arg_3_0.btnDecree)
	arg_3_0:removeClickCb(arg_3_0.btnRoleWareHouse)
	arg_3_0:removeClickCb(arg_3_0.btnTarget)
	arg_3_0:removeClickCb(arg_3_0.btnTalent)
	arg_3_0:removeClickCb(arg_3_0.btnWareHouse)
	arg_3_0:removeClickCb(arg_3_0.btnMonster)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.onCloseViewFinish, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, arg_3_0.onTaskDataUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnWeekInfoUpdate, arg_3_0.onWeekInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_3_0.onBuildingInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.AbandonFight, arg_3_0.refreshMonster, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, arg_3_0.updateEquipRed, arg_3_0)
end

function var_0_0.initBtnUnlockComp(arg_4_0)
	if arg_4_0.hasInitBtnUnlockComp then
		return
	end

	arg_4_0.hasInitBtnUnlockComp = true

	local var_4_0 = {
		{
			SurvivalController.instance,
			SurvivalEvent.OnBuildingInfoUpdate
		},
		{
			SurvivalController.instance,
			SurvivalEvent.OnWeekInfoUpdate
		}
	}

	arg_4_0:_addUnlockComp(arg_4_0.btnDecree.gameObject, {
		{
			SurvivalEnum.ShelterBtnUnlockType.BuildingTypeLev,
			SurvivalEnum.BuildingType.Decree,
			1
		}
	}, var_4_0)
end

function var_0_0._addUnlockComp(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_1, SurvivalButtonUnlockPart, {
		unlockConditions = arg_5_2,
		eventParams = arg_5_3
	})
end

function var_0_0.onClickExit(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUpWeek, MsgBoxEnum.BoxType.Yes_No, arg_6_0._sendGiveUp, nil, nil, arg_6_0, nil, nil)
end

function var_0_0._sendGiveUp(arg_7_0)
	SurvivalWeekRpc.instance:sendSurvivalAbandonWeek()
end

function var_0_0.onClickStart(arg_8_0)
	SurvivalController.instance:enterSurvival()
end

function var_0_0.onClickMonster(arg_9_0)
	local var_9_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()

	if var_9_0 and var_9_0:canShowEntity() then
		SurvivalMapHelper.instance:gotoMonster(var_9_0.fightId)
	end
end

function var_0_0.onClickWareHouse(arg_10_0)
	ViewMgr.instance:openView(ViewName.ShelterMapBagView)
end

function var_0_0.onClickRoleWareHouse(arg_11_0)
	ViewMgr.instance:openView(ViewName.ShelterHeroWareHouseView)
end

function var_0_0.onClickTarget(arg_12_0)
	ViewMgr.instance:openView(ViewName.ShelterTaskView)
end

function var_0_0.onClickTalent(arg_13_0)
	ViewMgr.instance:openView(ViewName.SurvivalTalentOverView)
end

function var_0_0.onClickDecree(arg_14_0)
	ViewMgr.instance:openView(ViewName.SurvivalDecreeView)
end

function var_0_0.onClickNpc(arg_15_0)
	ViewMgr.instance:openView(ViewName.ShelterNpcManagerView)
end

function var_0_0.onClickBuilding(arg_16_0)
	ViewMgr.instance:openView(ViewName.ShelterBuildingManagerView)
end

function var_0_0.onClickEquip(arg_17_0)
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

function var_0_0.onOpenView(arg_18_0)
	arg_18_0:refreshViewUIVisible()
end

function var_0_0.onCloseViewFinish(arg_19_0)
	arg_19_0:refreshViewUIVisible()
end

function var_0_0.refreshViewUIVisible(arg_20_0)
	local var_20_0 = ViewHelper.instance:checkViewOnTheTop(arg_20_0.viewName, arg_20_0.igoreViewList)

	arg_20_0:setViewUIVisible(var_20_0)
end

function var_0_0.setViewUIVisible(arg_21_0, arg_21_1)
	if arg_21_0._isViewUIVisible == arg_21_1 then
		return
	end

	arg_21_0._isViewUIVisible = arg_21_1

	if arg_21_1 then
		arg_21_0.animator:Play("in", 0, 0)
	else
		arg_21_0.animator:Play("out", 0, 0)
	end

	gohelper.setActive(arg_21_0.goRaycast, not arg_21_1)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMainViewVisible, arg_21_1)
end

function var_0_0.onTaskDataUpdate(arg_22_0)
	arg_22_0:refreshTask()
end

function var_0_0.onWeekInfoUpdate(arg_23_0)
	arg_23_0:refreshView()
end

function var_0_0.onBuildingInfoUpdate(arg_24_0)
	arg_24_0:_refreshBuildingButton()
end

function var_0_0.onShelterBagUpdate(arg_25_0)
	arg_25_0:_refreshBuildingButton()
end

function var_0_0.onOpen(arg_26_0)
	arg_26_0:refreshView()
end

function var_0_0.updateEquipRed(arg_27_0)
	gohelper.setActive(arg_27_0._goequipred, SurvivalEquipRedDotHelper.instance.reddotType >= 0)
end

function var_0_0.refreshView(arg_28_0)
	arg_28_0:refreshProgress()
	arg_28_0:refreshMonster()
	arg_28_0:refreshTask()
	arg_28_0:refreshButton()
	arg_28_0:updateEquipRed()
end

function var_0_0.refreshProgress(arg_29_0)
	local var_29_0 = SurvivalShelterModel.instance:getWeekInfo()

	arg_29_0.txtProgress.text = formatLuaLang("versionactivity_1_2_114daydes", var_29_0.day)
end

function var_0_0.refreshMonster(arg_30_0)
	local var_30_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_30_1 = var_30_0:getMonsterFight()

	gohelper.setActive(arg_30_0.goMonster, var_30_1 ~= nil)

	if not var_30_1 then
		gohelper.setActive(arg_30_0.goMonster, false)

		return
	end

	local var_30_2 = var_30_0.day
	local var_30_3 = var_30_1:canShowEntity()
	local var_30_4 = var_30_1:isNotStart()
	local var_30_5 = false

	if var_30_4 then
		local var_30_6 = var_30_1.beginTime - var_30_0.day

		arg_30_0.txtMonsterTime.text = formatLuaLang("survival_mainview_monster_begin", var_30_6)
		var_30_5 = true

		gohelper.setActive(arg_30_0.goMonsterTimeIcon, true)
	elseif var_30_3 then
		local var_30_7 = var_30_1.endTime - var_30_0.day

		if var_30_7 > 0 then
			arg_30_0.txtMonsterTime.text = formatLuaLang("survival_mainview_monster_end", var_30_7)

			gohelper.setActive(arg_30_0.goMonsterTimeIcon, true)
		else
			arg_30_0.txtMonsterTime.text = luaLang("survival_mainview_monster_fight")

			gohelper.setActive(arg_30_0.goMonsterTimeIcon, false)
		end

		var_30_5 = true
	end

	if var_30_5 then
		local var_30_8 = var_30_1.fightCo.smallheadicon

		if var_30_8 then
			arg_30_0.sImgMonster:LoadImage(ResUrl.monsterHeadIcon(var_30_8))
		end
	end

	gohelper.setActive(arg_30_0.goMonster, var_30_5)
end

function var_0_0.refreshTask(arg_31_0)
	local var_31_0 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.MainTask)
	local var_31_1

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if iter_31_1:isUnFinish() then
			var_31_1 = iter_31_1

			break
		end
	end

	arg_31_0.txtTaskDesc.text = var_31_1 and var_31_1:getDesc() or ""

	local var_31_2 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.SubTask)
	local var_31_3

	for iter_31_2, iter_31_3 in ipairs(var_31_2) do
		if iter_31_3:isUnFinish() then
			var_31_3 = iter_31_3

			break
		end
	end

	arg_31_0.txtSubTaskDesc.text = var_31_3 and var_31_3:getDesc() or ""
end

function var_0_0.refreshButton(arg_32_0)
	arg_32_0:_refreshBuildingButton()
	arg_32_0:initBtnUnlockComp()
end

function var_0_0._refreshBuildingButton(arg_33_0)
	local var_33_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingBtnStatus()

	gohelper.setActive(arg_33_0.goNewBuilding, var_33_0 == SurvivalEnum.ShelterBuildingBtnStatus.New)
	gohelper.setActive(arg_33_0.goFixBuilding, var_33_0 == SurvivalEnum.ShelterBuildingBtnStatus.Destroy)
	gohelper.setActive(arg_33_0.goLevupBuilding, var_33_0 == SurvivalEnum.ShelterBuildingBtnStatus.Levelup)
end

return var_0_0
