module("modules.logic.survival.util.SurvivalMapHelper", package.seeall)

local var_0_0 = class("SurvivalMapHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0.flow = nil
	arg_1_0._allEntity = {}
	arg_1_0._steps = nil
end

function var_0_0.cacheSteps(arg_2_0, arg_2_1)
	arg_2_0._steps = arg_2_0._steps or {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = SurvivalMapStepMo.New()

		var_2_0:init(iter_2_1)

		local var_2_1 = SurvivalEnum.StepTypeToName[iter_2_1.type] or ""
		local var_2_2 = _G[string.format("Survival%sWork", var_2_1)]

		if var_2_2 then
			table.insert(arg_2_0._steps, var_2_2.New(var_2_0))
		end
	end
end

function var_0_0.addPushToFlow(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._steps = arg_3_0._steps or {}

	local var_3_0 = (_G[string.format("%sWork", arg_3_1)] or SurvivalMsgPushWork).New(arg_3_1, arg_3_2)

	table.insert(arg_3_0._steps, var_3_0)
end

function var_0_0.tryStartFlow(arg_4_0, arg_4_1)
	if not arg_4_0._steps or #arg_4_0._steps <= 0 then
		return
	end

	local var_4_0 = false

	if not arg_4_0.flow then
		arg_4_0.flow = FlowSequence.New()
		var_4_0 = true
	end

	if arg_4_1 == "EnterSurvivalReply" then
		arg_4_0.flow:addWork(SurvivalWaitSceneFinishWork.New())
	end

	local var_4_1 = FlowParallel.New()
	local var_4_2 = FlowSequence.New()

	arg_4_0.flow:addWork(var_4_1)

	local var_4_3 = {}
	local var_4_4
	local var_4_5

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._steps) do
		local var_4_6 = iter_4_1._stepMo

		if var_4_6 then
			if var_4_6.type == SurvivalEnum.StepType.UnitMove then
				if var_4_3[var_4_6.id] then
					var_4_1 = FlowParallel.New()

					arg_4_0.flow:addWork(var_4_1)

					var_4_3 = {}

					logError("一个元件在同一个tick移动了2次！！" .. var_4_6.id)
				end

				if var_4_6.id == 0 then
					var_4_5 = true
				end

				var_4_3[var_4_6.id] = true
			end

			if var_4_6.type == SurvivalEnum.StepType.ShowEventPanel or var_4_6.type == SurvivalEnum.StepType.UpdateEventPanel then
				var_4_4 = true
			end

			if var_4_6.type == SurvivalEnum.StepType.MapTickAfter or var_4_6.type == SurvivalEnum.StepType.GameTimeUpdate or var_4_6.type == SurvivalEnum.StepType.UnitMove or var_4_6.type == SurvivalEnum.StepType.UpdateUnitData or var_4_6.type == SurvivalEnum.StepType.CircleShrinkFinish or var_4_6.type == SurvivalEnum.StepType.CircleUpdate or var_4_6.type == SurvivalEnum.StepType.UpdateSafeZoneInfo or var_4_6.type == SurvivalEnum.StepType.UpdatePoints or var_4_6.type == SurvivalEnum.StepType.PlayerMoveBack then
				var_4_1:addWork(iter_4_1)
			elseif var_4_6.type == SurvivalEnum.StepType.UnitShow then
				if var_4_5 then
					var_4_1 = FlowParallel.New()

					arg_4_0.flow:addWork(var_4_1)

					var_4_3 = {}
					var_4_5 = false
				end

				var_4_1:addWork(iter_4_1)
			elseif var_4_6.type == SurvivalEnum.StepType.UnitHide then
				local var_4_7 = false

				for iter_4_2, iter_4_3 in ipairs(var_4_6.paramInt) do
					if iter_4_2 ~= 1 and var_4_3[iter_4_3] then
						var_4_7 = true

						break
					end
				end

				if var_4_7 then
					var_4_2:addWork(iter_4_1)
				else
					if var_4_5 then
						var_4_1 = FlowParallel.New()

						arg_4_0.flow:addWork(var_4_1)

						var_4_3 = {}
						var_4_5 = false
					end

					var_4_1:addWork(iter_4_1)
				end
			elseif var_4_6.type == SurvivalEnum.StepType.FastBattle then
				arg_4_0.flow:addWork(iter_4_1)

				var_4_1 = FlowParallel.New()

				arg_4_0.flow:addWork(var_4_1)

				var_4_3 = {}
				var_4_5 = false
			elseif var_4_6.type == SurvivalEnum.StepType.RemoveEventPanel then
				if var_4_4 then
					var_4_2:addWork(iter_4_1)

					var_4_4 = false
				else
					var_4_1:addWork(iter_4_1)
				end
			else
				var_4_2:addWork(iter_4_1)
			end

			if var_4_6.type == SurvivalEnum.StepType.MapTickAfter then
				arg_4_0.flow:addWork(var_4_2)

				var_4_1 = FlowParallel.New()
				var_4_2 = FlowSequence.New()

				arg_4_0.flow:addWork(var_4_1)

				var_4_3 = {}
				var_4_5 = false
			end
		else
			var_4_2:addWork(iter_4_1)
		end
	end

	arg_4_0.flow:addWork(var_4_2)

	local var_4_8 = SurvivalShelterModel.instance:getWeekInfo()

	if var_4_8 and var_4_8.inSurvival then
		arg_4_0.flow:addWork(SurvivalContinueMoveWork.New())
	end

	if var_4_0 then
		arg_4_0.flow:registerDoneListener(arg_4_0.flowDone, arg_4_0)
		arg_4_0.flow:start({})
	end

	arg_4_0._steps = nil
end

function var_0_0.flowDone(arg_5_0)
	local var_5_0 = false

	if arg_5_0.flow and arg_5_0.flow.context.fastExecute then
		SurvivalController.instance:exitMap()

		var_5_0 = true
	end

	arg_5_0.flow = nil
	arg_5_0.serverFlow = nil
	arg_5_0._steps = nil

	if not var_5_0 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.onFlowEnd)
	end
end

function var_0_0.isInFlow(arg_6_0)
	return arg_6_0.flow ~= nil or arg_6_0._steps and #arg_6_0._steps > 0
end

function var_0_0.fastDoFlow(arg_7_0)
	if not arg_7_0.flow then
		if arg_7_0._steps then
			arg_7_0._steps = nil
		end

		return
	end

	arg_7_0.flow.context.fastExecute = true
end

function var_0_0.tryShowEventView(arg_8_0, arg_8_1)
	SurvivalMapModel.instance:setMoveToTarget(nil)

	local var_8_0 = SurvivalMapModel.instance:getSceneMo()

	arg_8_1 = arg_8_1 or var_8_0.player.pos

	local var_8_1 = var_8_0:getUnitByPos(arg_8_1, true)

	if var_8_1[1] then
		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			if iter_8_1.unitType == SurvivalEnum.UnitType.Treasure then
				SurvivalStatHelper.instance:statSurvivalMapUnit("TriggerEvent", iter_8_1.id)
				SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.TriggerEvent, tostring(iter_8_1.id))

				return
			end
		end

		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapEventView
		})
		ViewMgr.instance:openView(ViewName.SurvivalMapEventView, {
			pos = arg_8_1,
			allUnitMo = var_8_1
		})
		SurvivalStatHelper.instance:statSurvivalMapUnit("TriggerEvent", var_8_1[1].id)
	end
end

function var_0_0.tryShowServerPanel(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 or arg_9_1.type == SurvivalEnum.PanelType.None then
		return
	end

	SurvivalMapModel.instance:setMoveToTarget(nil)

	local var_9_0 = arg_9_1.type

	if var_9_0 == SurvivalEnum.PanelType.Search then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapSearchView
		})
		ViewMgr.instance:openView(ViewName.SurvivalMapSearchView, {
			itemMos = arg_9_1:getSearchItems(),
			isFirst = arg_9_2
		})
	elseif var_9_0 == SurvivalEnum.PanelType.TreeEvent then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapEventView
		})
		ViewMgr.instance:openView(ViewName.SurvivalMapEventView, {
			panel = arg_9_1
		})
	elseif var_9_0 == SurvivalEnum.PanelType.DropSelect then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalDropSelectView
		})
		ViewMgr.instance:openView(ViewName.SurvivalDropSelectView, {
			panel = arg_9_1
		})
	elseif var_9_0 == SurvivalEnum.PanelType.Store then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalShopView
		})
		ViewMgr.instance:openView(ViewName.SurvivalShopView)
	end
end

function var_0_0.getBlockRes(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getScene()

	if not var_10_0 then
		return
	end

	return var_10_0.preloader:getRes(arg_10_1)
end

function var_0_0.getScene(arg_11_0)
	local var_11_0 = GameSceneMgr.instance:getCurScene()

	if not var_11_0 or var_11_0.__cname ~= "SurvivalScene" and var_11_0.__cname ~= "SurvivalShelterScene" then
		return
	end

	return var_11_0
end

function var_0_0.getSceneCameraComp(arg_12_0)
	local var_12_0 = arg_12_0:getScene()

	return var_12_0 and var_12_0.camera
end

function var_0_0.getSceneFogComp(arg_13_0)
	local var_13_0 = arg_13_0:getScene()

	return var_13_0 and var_13_0.fog
end

function var_0_0.setDistance(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getSceneCameraComp()

	if var_14_0 then
		var_14_0:setDistance(arg_14_1)
	end
end

function var_0_0.setFocusPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0:getSceneCameraComp()

	if var_15_0 then
		var_15_0:setFocus(arg_15_1, arg_15_2, arg_15_3)
	end
end

function var_0_0.setRotate(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getSceneCameraComp()

	if var_16_0 then
		var_16_0:setRotate(arg_16_1, arg_16_2)
	end
end

function var_0_0.addEntity(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._allEntity[arg_17_1] = arg_17_2
end

function var_0_0.removeEntity(arg_18_0, arg_18_1)
	arg_18_0._allEntity[arg_18_1] = nil
end

function var_0_0.getEntity(arg_19_0, arg_19_1)
	return arg_19_0._allEntity[arg_19_1]
end

function var_0_0.getShopPanel(arg_20_0)
	local var_20_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_20_0 then
		return
	end

	if var_20_0.inSurvival then
		local var_20_1 = SurvivalMapModel.instance:getSceneMo()

		if not var_20_1 then
			return
		end

		if var_20_1.panel and var_20_1.panel.type == SurvivalEnum.PanelType.Store then
			return var_20_1.panel.shop, var_20_1.panel.uid
		end
	else
		local var_20_2 = var_20_0:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Shop)

		return var_20_2 and var_20_2.shop
	end
end

function var_0_0.getBagMo(arg_21_0)
	local var_21_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_21_0 then
		return
	end

	if var_21_0.inSurvival then
		local var_21_1 = SurvivalMapModel.instance:getSceneMo()

		if not var_21_1 then
			return
		end

		return var_21_1.bag
	else
		return var_21_0.bag
	end
end

function var_0_0.clear(arg_22_0)
	if arg_22_0.flow then
		arg_22_0.flow:onDestroyInternal()

		arg_22_0.flow = nil
	end

	ViewMgr.instance:closeAllPopupViews()

	arg_22_0._steps = nil
	arg_22_0.serverFlow = nil
	arg_22_0._allEntity = {}
end

function var_0_0.gotoBuilding(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0:getScene()

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0.unit:getBuildEntity(arg_23_1)

	if not var_23_1 then
		return
	end

	local var_23_2 = var_23_1.buildingCo.pointRangeList
	local var_23_3 = var_23_0.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	var_23_3:moveToByPosList(var_23_2, arg_23_0.interactiveBuilding, arg_23_0, arg_23_1, arg_23_3)
end

function var_0_0.interactiveBuilding(arg_24_0, arg_24_1)
	local var_24_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_24_1)

	if not var_24_0 then
		logError(string.format("建筑数据不存在，buildingId:%s not found", arg_24_1))

		return
	end

	ViewMgr.instance:closeAllPopupViews()

	if not var_24_0:isBuild() then
		ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
			buildingId = arg_24_1
		})

		return
	end

	if var_24_0:isEqualType(SurvivalEnum.BuildingType.Decree) then
		ViewMgr.instance:openView(ViewName.SurvivalDecreeView)

		return
	end

	if var_24_0:isEqualType(SurvivalEnum.BuildingType.Task) then
		ViewMgr.instance:openView(ViewName.ShelterTaskView)

		return
	end

	if var_24_0:isEqualType(SurvivalEnum.BuildingType.Explore) then
		SurvivalController.instance:enterSurvival()

		return
	end

	if var_24_0:isEqualType(SurvivalEnum.BuildingType.Health) then
		ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
			buildingId = arg_24_1
		})

		return
	end

	if var_24_0:isEqualType(SurvivalEnum.BuildingType.Tent) then
		ViewMgr.instance:openView(ViewName.ShelterTentManagerView, {
			buildingId = arg_24_1
		})

		return
	end

	if var_24_0:isEqualType(SurvivalEnum.BuildingType.Equipment) then
		ViewMgr.instance:openView(ViewName.ShelterCompositeView)

		return
	end

	if var_24_0:isEqualType(SurvivalEnum.BuildingType.Npc) then
		ViewMgr.instance:openView(ViewName.ShelterRecruitView)

		return
	end

	if var_24_0:isEqualType(SurvivalEnum.BuildingType.Warehouse) then
		ViewMgr.instance:openView(ViewName.ShelterMapBagView)

		return
	end

	if var_24_0:isEqualType(SurvivalEnum.BuildingType.Shop) then
		ViewMgr.instance:openView(ViewName.SurvivalShopView)

		return
	end

	ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
		buildingId = arg_24_1
	})
end

function var_0_0.gotoUnit(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_1 == SurvivalEnum.ShelterUnitType.Npc then
		arg_25_0:gotoNpc(arg_25_2, arg_25_3)

		return
	end

	if arg_25_1 == SurvivalEnum.ShelterUnitType.Build then
		arg_25_0:gotoBuilding(arg_25_2, arg_25_3)

		return
	end

	if arg_25_1 == SurvivalEnum.ShelterUnitType.Monster then
		arg_25_0:gotoMonster(arg_25_2, arg_25_3)

		return
	end
end

function var_0_0.gotoNpc(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:getScene()

	if not var_26_0 then
		return
	end

	local var_26_1 = var_26_0.unit:getNpcEntity(arg_26_1)

	if not var_26_1 then
		return
	end

	local var_26_2 = var_26_1.pos
	local var_26_3 = var_26_0.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	var_26_3:moveToByPos(arg_26_2 or var_26_2, arg_26_0.interactiveNpc, arg_26_0, arg_26_1)
end

function var_0_0.interactiveNpc(arg_27_0, arg_27_1)
	local var_27_0 = SurvivalShelterModel.instance:getWeekInfo():getNpcInfo(arg_27_1)
	local var_27_1 = arg_27_0:getShelterNpcBehaviorList(arg_27_1)

	if var_27_1[1] then
		local var_27_2 = SurvivalBagItemMo.New()

		var_27_2:init({
			count = 1,
			id = var_27_0.id
		})
		ViewMgr.instance:closeAllPopupViews()

		local var_27_3 = {
			status = var_27_0:getShelterNpcStatus()
		}

		ViewMgr.instance:openView(ViewName.ShelterMapEventView, {
			conditionParam = var_27_3,
			title = var_27_0.co.name,
			behaviorConfig = var_27_1[1],
			unitResPath = var_27_0.co.resource,
			itemMo = var_27_2
		})
	end
end

function var_0_0.getShelterNpcBehaviorList(arg_28_0, arg_28_1)
	local var_28_0 = SurvivalShelterModel.instance:getWeekInfo():getNpcInfo(arg_28_1)
	local var_28_1 = string.splitToNumber(var_28_0.co.surBehavior, "#")
	local var_28_2 = {}
	local var_28_3 = {
		status = var_28_0:getShelterNpcStatus()
	}

	for iter_28_0, iter_28_1 in ipairs(var_28_1) do
		local var_28_4 = lua_survival_behavior.configDict[iter_28_1]

		if var_28_4 and arg_28_0:isBehaviorMeetCondition(var_28_4.condition, var_28_3) then
			table.insert(var_28_2, var_28_4)
		end
	end

	if #var_28_2 > 1 then
		table.sort(var_28_2, SortUtil.keyUpper("priority"))
	end

	return var_28_2
end

function var_0_0.gotoMonster(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0:getScene()

	if not var_29_0 then
		return
	end

	local var_29_1 = var_29_0.unit:getMonsterEntity(arg_29_1)

	if not var_29_1 then
		return
	end

	local var_29_2 = var_29_1.pos
	local var_29_3 = var_29_0.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	var_29_3:moveToByPos(arg_29_2 or var_29_2, arg_29_0.interactiveMonster, arg_29_0, arg_29_1, arg_29_3)
end

function var_0_0.interactiveMonster(arg_30_0, arg_30_1)
	local var_30_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()

	if var_30_0 and var_30_0.fightId == arg_30_1 and var_30_0:canShowEntity() then
		ViewMgr.instance:closeAllPopupViews()
		ViewMgr.instance:openView(ViewName.SurvivalMonsterEventView, {
			showType = SurvivalEnum.SurvivalMonsterEventViewShowType.Normal
		})
	end
end

function var_0_0.isBehaviorMeetCondition(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = GameUtil.splitString2(arg_31_1, false)

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if arg_31_0:checkSingleCondition(iter_31_1, arg_31_2) then
			return true
		end
	end
end

function var_0_0.checkSingleCondition(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1 then
		return true
	end

	if arg_32_1[1] == "NpcStatus" then
		return tonumber(arg_32_1[2]) == arg_32_2.status
	elseif arg_32_1[1] == "unFinishTask" then
		local var_32_0 = tonumber(arg_32_1[2])
		local var_32_1 = tonumber(arg_32_1[3])
		local var_32_2 = SurvivalShelterModel.instance:getWeekInfo().taskPanel:getTaskBoxMo(var_32_0)
		local var_32_3 = var_32_2 and var_32_2:getTaskInfo(var_32_1)

		return var_32_3 and var_32_3:isUnFinish()
	elseif arg_32_1[1] == "unAcceptTask" then
		local var_32_4 = tonumber(arg_32_1[2])
		local var_32_5 = tonumber(arg_32_1[3])
		local var_32_6 = SurvivalShelterModel.instance:getWeekInfo().taskPanel:getTaskBoxMo(var_32_4)

		return (var_32_6 and var_32_6:getTaskInfo(var_32_5)) == nil
	elseif arg_32_1[1] == "finishTask" then
		local var_32_7 = tonumber(arg_32_1[2])
		local var_32_8 = tonumber(arg_32_1[3])
		local var_32_9 = SurvivalShelterModel.instance:getWeekInfo().taskPanel:getTaskBoxMo(var_32_7)
		local var_32_10 = var_32_9 and var_32_9:getTaskInfo(var_32_8)

		return var_32_10 and not var_32_10:isUnFinish() or false
	end

	return true
end

function var_0_0.getLocalShelterEntityPosAndDir(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = SurvivalConfig.instance:getCurShelterMapId()
	local var_33_1, var_33_2 = SurvivalConfig.instance:getLocalShelterEntityPosAndDir(var_33_0, arg_33_1, arg_33_2)

	if not var_33_1 then
		var_33_1, var_33_2 = arg_33_0:getRandomWalkPosAndDir()

		SurvivalConfig.instance:saveLocalShelterEntityPosAndDir(var_33_0, arg_33_1, arg_33_2, var_33_1, var_33_2)
	end

	return var_33_1, var_33_2
end

function var_0_0.getRandomWalkPosAndDir(arg_34_0)
	if not arg_34_0:getScene() then
		return
	end

	local var_34_0 = arg_34_0:getScene()
	local var_34_1 = SurvivalConfig.instance:getShelterMapCo().walkables
	local var_34_2 = {}

	if var_34_0 then
		var_34_0.unit:addUsedPos(var_34_2)
	end

	local var_34_3 = {}

	for iter_34_0, iter_34_1 in pairs(var_34_1) do
		for iter_34_2, iter_34_3 in pairs(iter_34_1) do
			if not SurvivalHelper.instance:isHaveNode(var_34_2, iter_34_3) then
				table.insert(var_34_3, iter_34_3)
			end
		end
	end

	if #var_34_3 == 0 then
		return nil
	end

	local var_34_4 = math.random(0, 5)

	return var_34_3[math.random(1, #var_34_3)], var_34_4
end

function var_0_0.getShelterEntity(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:getScene()

	if not var_35_0 then
		return
	end

	return var_35_0.unit:getEntity(arg_35_1, arg_35_2)
end

function var_0_0.addShelterEntity(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = arg_36_0:getScene()

	if not var_36_0 then
		return
	end

	return var_36_0.unit:addEntity(arg_36_1, arg_36_2, arg_36_3)
end

function var_0_0.getAllShelterEntity(arg_37_0)
	local var_37_0 = arg_37_0:getScene()

	if not var_37_0 then
		return
	end

	return var_37_0.unit:getAllEntity()
end

var_0_0.instance = var_0_0.New()

return var_0_0
