module("modules.logic.survival.view.shelter.ShelterHeroGroupFightView", package.seeall)

local var_0_0 = class("ShelterHeroGroupFightView", HeroGroupFightView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0:checkHeroList()
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._goSwitch = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/#go_switch")
	arg_1_0._goSwitchItem = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/#go_switch/#go_switchitem")

	gohelper.setActive(arg_1_0._goSwitchItem, false)
end

function var_0_0.onOpen(arg_2_0)
	var_0_0.super.onOpen(arg_2_0)

	arg_2_0.selectIndex = HeroGroupSnapshotModel.instance:getSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter)

	arg_2_0:_refreshSwitchItems()

	local var_2_0 = SurvivalShelterModel.instance:getWeekInfo().intrudeBox.fight.currRound

	arg_2_0._canClickStart = var_2_0 == arg_2_0.selectIndex

	if var_2_0 ~= arg_2_0.selectIndex then
		arg_2_0.selectIndex = var_2_0

		TaskDispatcher.runDelay(arg_2_0._autoSwitchSuccessRound, arg_2_0, 0.5)
	end
end

function var_0_0._autoSwitchSuccessRound(arg_3_0)
	if HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter, arg_3_0.selectIndex) then
		arg_3_0:_refreshSwitchItems()
		arg_3_0:checkHeroList()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(arg_3_0._goherogroupcontain, false)
		gohelper.setActive(arg_3_0._goherogroupcontain, true)

		arg_3_0._canClickStart = true
	end
end

function var_0_0._refreshBtns(arg_4_0, arg_4_1)
	var_0_0.super._refreshBtns(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._dropherogroup, false)
	TaskDispatcher.cancelTask(arg_4_0._checkDropArrow, arg_4_0)
end

function var_0_0._onClickStart(arg_5_0)
	if not arg_5_0._canClickStart then
		return
	end

	if HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter, arg_5_0.selectIndex) then
		arg_5_0:_refreshSwitchItems()
		arg_5_0:checkHeroList()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(arg_5_0._goherogroupcontain, false)
		gohelper.setActive(arg_5_0._goherogroupcontain, true)
	end

	var_0_0.super._onClickStart(arg_5_0)
end

function var_0_0.checkHeroList(arg_6_0)
	local var_6_0 = 5
	local var_6_1 = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setMaxHeroCount(var_6_0)
	HeroSingleGroupModel.instance:setSingleGroup(var_6_1)

	local var_6_2 = SurvivalShelterModel.instance:getWeekInfo()
	local var_6_3 = var_6_2.equipBox.currPlanId
	local var_6_4 = var_6_2.intrudeBox.fight

	while var_6_4.usedEquipPlan[var_6_3] do
		var_6_3 = var_6_3 + 1

		if var_6_3 > 4 then
			var_6_3 = 1
		end

		if var_6_3 == var_6_2.equipBox.currPlanId then
			logError("所有装备方案都用过了？？？？？")

			return
		end
	end

	if var_6_3 ~= var_6_2.equipBox.currPlanId then
		SurvivalWeekRpc.instance:sendSurvivalEquipSwitchPlan(var_6_3)
	end
end

function var_0_0._onClickHeroGroupItem(arg_7_0, arg_7_1)
	local var_7_0 = HeroGroupSnapshotModel.instance:getSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter)

	if SurvivalShelterModel.instance:getWeekInfo().intrudeBox.fight.currRound ~= var_7_0 then
		GameFacade.showToast(ToastEnum.SurvivalOtherRoundNoEditor)

		return
	end

	var_0_0.super._onClickHeroGroupItem(arg_7_0, arg_7_1)
end

function var_0_0.openHeroGroupEditView(arg_8_0)
	ViewMgr.instance:openView(ViewName.SurvivalHeroGroupEditView, arg_8_0._param)
end

function var_0_0._refreshReplay(arg_9_0)
	gohelper.setActive(arg_9_0._goReplayBtn, false)
	gohelper.setActive(arg_9_0._gomemorytimes, false)
end

function var_0_0._refreshPowerShow(arg_10_0)
	gohelper.setActive(arg_10_0._gopowercontent, false)
end

function var_0_0._refreshSwitchItems(arg_11_0)
	if arg_11_0._switchItems == nil then
		arg_11_0._switchItems = arg_11_0:getUserDataTb_()
	end

	for iter_11_0 = 1, 3 do
		local var_11_0 = arg_11_0._switchItems[iter_11_0]

		if var_11_0 == nil then
			local var_11_1 = gohelper.cloneInPlace(arg_11_0._goSwitchItem)

			var_11_0 = arg_11_0:getUserDataTb_()
			var_11_0.go = var_11_1
			var_11_0.goNormal = gohelper.findChild(var_11_1, "#go_Normal")
			var_11_0.goSelect = gohelper.findChild(var_11_1, "#go_Select")
			var_11_0.txtName = gohelper.findChildText(var_11_1, "#go_Normal/#txt_normal")
			var_11_0.txtName2 = gohelper.findChildText(var_11_1, "#go_Select/#txt_select")

			local var_11_2 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("shelterHeroGroupFightView_item"), iter_11_0)

			var_11_0.txtName.text = var_11_2
			var_11_0.txtName2.text = var_11_2
			var_11_0.btn = gohelper.findChildClickWithAudio(var_11_1, "#btn_click")

			var_11_0.btn:AddClickListener(function()
				if HeroGroupSnapshotModel.instance:getSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter) == iter_11_0 then
					return
				end

				if arg_11_0.selectIndex ~= iter_11_0 then
					GameFacade.showToast(ToastEnum.SurvivalOtherRoundNoEditor)

					return
				end

				if HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter, iter_11_0) then
					arg_11_0:_refreshSwitchItems()
					arg_11_0:checkHeroList()
					HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
					gohelper.setActive(arg_11_0._goherogroupcontain, false)
					gohelper.setActive(arg_11_0._goherogroupcontain, true)
				end
			end, arg_11_0, nil)

			arg_11_0._switchItems[iter_11_0] = var_11_0

			gohelper.setActive(var_11_1, true)
		end

		local var_11_3 = HeroGroupSnapshotModel.instance:getSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter)

		gohelper.setActive(var_11_0.goNormal, var_11_3 ~= iter_11_0)
		gohelper.setActive(var_11_0.goSelect, var_11_3 == iter_11_0)
	end
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0._switchItems ~= nil then
		for iter_13_0 = 1, tabletool.len(arg_13_0._switchItems) do
			local var_13_0 = arg_13_0._switchItems[iter_13_0]

			if var_13_0 ~= nil then
				var_13_0.btn:RemoveClickListener()

				var_13_0.go = nil
				var_13_0.goNormal = nil
				var_13_0.goSelect = nil
				var_13_0.btn = nil
			end
		end

		arg_13_0._switchItems = nil
	end

	var_0_0.super.onClose(arg_13_0)
	HeroSingleGroupModel.instance:setMaxHeroCount()

	HeroGroupTrialModel.instance.curBattleId = nil
end

return var_0_0
