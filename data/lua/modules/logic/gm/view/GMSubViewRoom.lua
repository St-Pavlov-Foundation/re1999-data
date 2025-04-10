module("modules.logic.gm.view.GMSubViewRoom", package.seeall)

slot0 = class("GMSubViewRoom", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "荒原"
end

function slot0.initViewContent(slot0)
	if slot0._isInit then
		return
	end

	slot0:_initL1()
	slot0:_initL2()
	slot0:_initL3()
	slot0:_initL4()
	slot0:_initL5()
	slot0:_initL6()
	slot0:_initL7()
	slot0:_initL8()

	slot0._isInit = true
end

function slot0._initL1(slot0)
	slot1 = "L1"

	slot0:addButton(slot1, "小屋观察", slot0._onClickBtnRoomOb, slot0)
	slot0:addButton(slot1, "小屋编辑", slot0._onClickBtnRoomMap, slot0)
	slot0:addButton(slot1, "小屋Debug", slot0._onClickBtnRoomDebug, slot0)
	slot0:addButton(slot1, "小屋建筑占地", slot0._onClickRoomDebugBuildingArea, slot0)
end

function slot0._onClickBtnRoomOb(slot0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
end

function slot0._onClickBtnRoomMap(slot0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
end

function slot0._onClickBtnRoomDebug(slot0)
	ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
end

function slot0._onClickRoomDebugBuildingArea(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomDebugController.instance:openBuildingAreaView()
	else
		GameFacade.showToast(94, "GM需要进入小屋后使用。")
	end
end

function slot0._initL2(slot0)
	slot1 = "L2"
	slot2 = slot0:addSlider(slot1, "QE灵敏度", slot0._onRoomRotateSpeedChange, slot0, {
		w = 610
	})
	slot0._txtRoomRotateSpeed = slot2[3]
	slot3 = (RoomController.instance.rotateSpeed - 0.2) / 1.8

	slot2[1]:SetValue(slot3)
	slot0:_onRoomRotateSpeedChange(nil, slot3)

	slot4 = slot0:addSlider(slot1, "WASD灵敏度", slot0._onRoomMoveSpeedChange, slot0, {
		w = 685
	})
	slot0._txtRoomMoveSpeed = slot4[3]
	slot3 = (RoomController.instance.moveSpeed - 0.2) / 1.8

	slot4[1]:SetValue(slot3)
	slot0:_onRoomMoveSpeedChange(nil, slot3)
end

function slot0._initL3(slot0)
	slot1 = "L3"
	slot2 = slot0:addSlider(slot1, "RF灵敏度", slot0._onRoomScaleSpeedChange, slot0, {
		w = 610
	})
	slot0._txtRoomScaleSpeed = slot2[3]
	slot3 = (RoomController.instance.scaleSpeed - 0.2) / 1.8

	slot2[1]:SetValue(slot3)
	slot0:_onRoomScaleSpeedChange(nil, slot3)

	slot4 = slot0:addSlider(slot1, "滑屏灵敏度", slot0._onRoomTouchSpeedChange, slot0, {
		w = 685
	})
	slot0._txtRoomTouchSpeed = slot4[3]

	slot4[1]:SetValue((RoomController.instance.touchMoveSpeed - 0.2) / 1.8)
	slot0:_onRoomTouchSpeedChange(nil, (RoomController.instance.touchMoveSpeed - 0.2) / 1.8)
end

function slot0._onRoomRotateSpeedChange(slot0, slot1, slot2)
	slot3 = 0.2 + 1.8 * slot2
	RoomController.instance.rotateSpeed = slot3
	slot0._txtRoomRotateSpeed.text = string.format("%.2f", slot3)
end

function slot0._onRoomMoveSpeedChange(slot0, slot1, slot2)
	slot3 = 0.2 + 1.8 * slot2
	RoomController.instance.moveSpeed = slot3
	slot0._txtRoomMoveSpeed.text = string.format("%.2f", slot3)
end

function slot0._onRoomScaleSpeedChange(slot0, slot1, slot2)
	slot3 = 0.2 + 1.8 * slot2
	RoomController.instance.scaleSpeed = slot3
	slot0._txtRoomScaleSpeed.text = string.format("%.2f", slot3)
end

function slot0._onRoomTouchSpeedChange(slot0, slot1, slot2)
	slot3 = 0.2 + 1.8 * slot2
	RoomController.instance.touchMoveSpeed = slot3
	slot0._txtRoomTouchSpeed.text = string.format("%.2f", slot3)
end

function slot0._sortCharacterInteractionFunc(slot0, slot1)
	if slot0.behaviour ~= slot1.behaviour then
		return slot0.behaviour < slot1.behaviour
	end
end

function slot0._initL4(slot0)
	slot1 = "L4"

	if not slot0.characterInteractionList then
		slot0.characterInteractionList = {}

		for slot5, slot6 in ipairs(lua_room_character_interaction.configList) do
			if RoomCharacterModel.instance:getCharacterMOById(slot6.heroId) and slot7.characterState == RoomCharacterEnum.CharacterState.Map then
				table.insert(slot0.characterInteractionList, slot6)
			end
		end

		table.sort(slot0.characterInteractionList, uv0._sortCharacterInteractionFunc)
	end

	slot3 = {
		[RoomCharacterEnum.InteractionType.Dialog] = "对话",
		[RoomCharacterEnum.InteractionType.Building] = "建筑"
	}

	table.insert({}, "英雄-交互#id选择")

	for slot7, slot8 in ipairs(slot0.characterInteractionList) do
		if slot3[slot8.behaviour] then
			table.insert(slot2, string.format("%s-%s#%s", HeroConfig.instance:getHeroCO(slot8.heroId).name or slot8.heroId, slot3[slot8.behaviour], slot8.id))
		end
	end

	slot0:addDropDown(slot1, "小屋角色交互", slot2, slot0._onRoomInteractionSelectChanged, slot0, {
		tempH = 450,
		total_w = 650,
		drop_w = 415
	})

	slot7 = "确定"

	slot0:addButton(slot1, slot7, slot0._onClickRoomInteractionOk, slot0)

	slot2 = {
		"选择时间"
	}

	for slot7 = 1, 24 do
		table.insert(slot2, slot7 .. "时")
	end

	slot0:addDropDown(slot1, "小屋时钟触发", slot2, slot0._onRoomClockSelectChanged, slot0, {
		total_w = 600,
		tempH = 450
	})
end

function slot0._onRoomInteractionSelectChanged(slot0, slot1)
	if not slot0.characterInteractionList then
		return
	end

	if slot1 == 0 then
		slot0.selectCharacterInteractionCfg = nil

		return
	end

	slot0.selectCharacterInteractionCfg = slot0.characterInteractionList[slot1]
end

function slot0._onClickRoomInteractionOk(slot0)
	if #slot0.characterInteractionList < 1 then
		GameFacade.showToast(94, "GM需要进入小屋并放置可交互角色。")
	end

	if not slot0.selectCharacterInteractionCfg then
		return
	end

	if not RoomCharacterModel.instance:getCharacterMOById(slot0.selectCharacterInteractionCfg.heroId) or slot1.characterState ~= RoomCharacterEnum.CharacterState.Map then
		GameFacade.showToast(94, "GM 需要放置角色后可交互。")

		return
	end

	if slot0.selectCharacterInteractionCfg.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		GameFacade.showToast(94, string.format("GM %s 触发交互", slot1.heroConfig.name))
		slot1:setCurrentInteractionId(slot0.selectCharacterInteractionCfg.id)
		RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
	elseif slot0.selectCharacterInteractionCfg.behaviour == RoomCharacterEnum.InteractionType.Building then
		if not RoomMapInteractionModel.instance:getBuildingInteractionMO(slot0.selectCharacterInteractionCfg.id) then
			GameFacade.showToast(94, string.format("GM 场景无【%s】建筑，【%s】无发交互", RoomConfig.instance:getBuildingConfig(slot0.selectCharacterInteractionCfg.buildingId) and slot3.name or slot0.selectCharacterInteractionCfg.buildingId, slot1.heroConfig.name))

			return
		end

		if not RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) then
			GameFacade.showToast(94, string.format("GM 当场景状态机非[%s]", RoomEnum.FSMObState.Idle))

			return
		end

		if not RoomInteractionController.instance:showTimeByInteractionMO(slot2) then
			GameFacade.showToast(94, string.format("GM【%s】不在【%s】交互点范围内", slot1.heroConfig.name, slot4))

			return
		end

		slot0:closeThis()
		logNormal(string.format("GM【%s】【%s】触发角色建筑交互", slot1.heroConfig.name, slot4))
	end
end

function slot0._onRoomClockSelectChanged(slot0, slot1)
	if slot1 >= 1 or slot1 <= 24 then
		RoomMapController.instance:dispatchEvent(RoomEvent.OnHourReporting, slot1)
	end
end

function slot0._checkScene(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and GameSceneMgr.instance:getCurScene() ~= nil then
		return true
	end

	return false
end

function slot0._checkObMode(slot0, slot1)
	return slot0:_checkScene() and RoomController.instance:isObMode()
end

function slot0._checkEditMode(slot0, slot1)
	return slot0:_checkScene() and RoomController.instance:isEditMode()
end

function slot0._findObMOList(slot0, slot1, slot2, slot3)
	if not slot0:_checkObMode() then
		slot2 = nil
	end

	return slot0:_findMOList(slot1, slot2, slot3)
end

function slot0._findMOList(slot0, slot1, slot2, slot3)
	slot4 = {
		slot1 .. "#id-选择"
	}
	slot5 = {}

	if slot2 then
		for slot9, slot10 in ipairs(slot2) do
			if slot10 and slot10[slot3] then
				table.insert(slot4, string.format("%s#%s", slot10[slot3].name, slot10.id))
				table.insert(slot5, slot10.id)
			end
		end
	end

	return slot4, slot5
end

function slot0._initL5(slot0)
	slot1 = "L5"
	slot2, slot0._characterIdList = slot0:_findInitFollowCharacterParams()
	slot0._dropFollowCharacter = slot0:addDropDown(slot1, "角色镜头跟随", slot2, slot0._onFollowCharacterSelectChanged, slot0, {
		total_w = 650,
		drop_w = 415
	})

	slot0:addButton(slot1, "小屋交互镜头", slot0._onClickRoomBuildingCamera, slot0)
	slot0:addButton(slot1, "清空角色交互数据", slot0._onClickRoomClearInteractionData, slot0)
end

function slot0._findInitFollowCharacterParams(slot0)
	return slot0:_findObMOList("选择角色", RoomCharacterModel.instance:getList(), "skinConfig")
end

function slot0._onFollowCharacterSelectChanged(slot0, slot1)
	if not slot0._characterIdList or slot1 == 0 then
		return
	end

	if not slot0:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	if GameSceneMgr.instance:getCurScene().charactermgr:getUnit(RoomCharacterEntity:getTag(), slot0._characterIdList[slot1]) then
		slot4.cameraFollow:setFollowTarget(slot5.cameraFollowTargetComp, false)
	end
end

function slot0._onClickRoomBuildingCamera(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomDebugController.instance:openBuildingCamerView()
		slot0:closeThis()
	else
		GameFacade.showToast(94, "GM需要进入小屋后使用。")
	end
end

slot1 = 46

function slot0._onClickRoomClearInteractionData(slot0)
	if lua_gm_command.configDict[uv0] then
		slot2 = slot1.command

		GameFacade.showToast(ToastEnum.IconId, slot2)
		GMRpc.instance:sendGMRequest(slot2)
	end
end

function slot0._initL6(slot0)
	slot1 = "L6"
	slot2, slot0._vehicleIdList = slot0:_findInitFollowTargetParams()
	slot0._dropFollowTarget = slot0:addDropDown(slot1, "乘坐交通", slot2, slot0._onFollowTargetSelectChanged, slot0, {
		total_w = 650,
		drop_w = 415
	})

	slot0:addDropDown(slot1, "地块用途", {
		"地块用途选择",
		"正常",
		"货运"
	}, slot0._onBlockUseStateSelectChanged, slot0, {
		total_w = 600,
		drop_w = 415
	})
end

function slot0._findInitFollowTargetParams(slot0)
	return slot0:_findObMOList("选择交通", RoomMapVehicleModel.instance:getList(), "config")
end

function slot0._onFollowTargetSelectChanged(slot0, slot1)
	if not slot0._vehicleIdList or slot1 == 0 then
		return
	end

	if not slot0:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	GameFacade.showToast(ToastEnum.IconId, "乘坐交通工具")

	if GameSceneMgr.instance:getCurScene().vehiclemgr:getUnit(RoomMapVehicleEntity:getTag(), slot0._vehicleIdList[slot1]) then
		slot4.cameraFollow:setFollowTarget(slot5.cameraFollowTargetComp, true)
	end
end

function slot0._onBlockUseStateSelectChanged(slot0, slot1)
	if slot1 == 0 then
		return
	end

	if not slot0:_checkEditMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")

		return
	end

	slot4 = {}

	for slot9, slot10 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
		slot10:setUseState(slot1)

		if GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(slot10.id, SceneTag.RoomMapBlock) then
			table.insert(slot4, slot11)
		end
	end

	RoomBlockHelper.refreshBlockEntity(slot4, "refreshLand")
	GameFacade.showToast(ToastEnum.IconId, string.format("GM index:%s, entityCount:%s blockCount:%s", slot1, #slot4, #slot5))
end

function slot0._initL7(slot0)
	slot1 = "L7"

	slot0:addButton(slot1, "交通工具测试", slot0._onClickTestVehicle, slot0)
	slot0:addButton(slot1, "mini地图", slot0._onOpenMiniMapView, slot0)
	slot0:addButton(slot1, "货运编辑", slot0._onOpenEditPathView, slot0)

	slot0._transporQuickLinkToggle = slot0:addToggle(slot1, "调试运输路线【快速绘制】", slot0._ontransporQuickLinkChange, slot0)
	slot0._transporQuickLinkToggle.isOn = RoomTransportPathQuickLinkViewUI._IsShow_ == true
end

function slot0._onClickTestVehicle(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and RoomController.instance:isObMode() then
		slot3 = GameSceneMgr.instance:getCurScene()

		for slot7, slot8 in ipairs(RoomMapVehicleModel.instance:getList()) do
			if slot3.vehiclemgr:getUnit(RoomMapVehicleEntity:getTag(), slot8.id) then
				slot3.cameraFollow:setFollowTarget(slot9.cameraFollowTargetComp)

				return
			end
		end

		GameFacade.showToast(94, "GM交通工具数量：" .. #slot2)
	else
		GameFacade.showToast(94, "GM需要进入小屋后观察模式下使用。")
	end
end

function slot0._onOpenMiniMapView(slot0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
		itemList = {
			{
				itemId = 11921,
				itemType = MaterialEnum.MaterialType.Building
			}
		}
	})
end

function slot0._onOpenEditPathView(slot0)
	if slot0:_checkScene() then
		ViewMgr.instance:openView(ViewName.RoomTransportPathView)
		slot0:closeThis()
	else
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")
	end
end

function slot0._ontransporQuickLinkChange(slot0)
	RoomTransportPathQuickLinkViewUI._IsShow_ = RoomTransportPathQuickLinkViewUI._IsShow_ ~= true
end

function slot0._initL8(slot0)
	slot1 = "L8"
	slot0.roomWeatherIdList = {}

	for slot6, slot7 in ipairs(RoomConfig.instance:getSceneAmbientConfigList()) do
		table.insert(slot0.roomWeatherIdList, slot7.id)
	end

	slot3 = {
		"请选择天气"
	}

	tabletool.addValues(slot3, slot0.roomWeatherIdList)
	slot0:addDropDown(slot1, "小屋天气", slot3, slot0._onRoomWeatherSelectChanged, slot0, {
		total_w = 500,
		drop_w = 330
	})

	if RoomController.instance:isEditMode() and GameResMgr.IsFromEditorDir then
		RoomDebugController.instance:getDebugPackageInfo(slot0._onInitDebugMapPackageInfo, slot0, slot1)
	end
end

function slot0._onRoomWeatherSelectChanged(slot0, slot1)
	if not slot0.roomWeatherIdList then
		return
	end

	if slot1 == 0 then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		if GameSceneMgr.instance:getCurScene() and slot2.ambient then
			slot3 = slot0.roomWeatherIdList[slot1]

			slot2.ambient:tweenToAmbientId(slot3)
			GameFacade.showToast(94, string.format("GM切换小屋天气:%s", slot3))
			slot0:closeThis()
		end
	else
		GameFacade.showToast(94, "GM需要进入小屋可使用。")
	end
end

function slot0._onInitDebugMapPackageInfo(slot0, slot1, slot2)
	slot3 = {
		"选择需要复制的地图"
	}
	slot0._blockInfosList = {}
	slot4 = RoomConfig.instance

	for slot8, slot9 in ipairs(slot1) do
		slot10 = {}

		for slot14, slot15 in ipairs(slot9.infos) do
			if slot4:getBlock(slot15.blockId) and not slot4:getInitBlock(slot15.blockId) and RoomBlockHelper.isInBoundary(HexPoint(slot15.x, slot15.y)) then
				table.insert(slot10, slot15)
			end
		end

		if #slot10 > 1 then
			table.insert(slot3, slot9.packageName)
			table.insert(slot0._blockInfosList, slot10)
		end
	end

	slot0:addDropDown(slot2, "一键复制地图地块", slot3, slot0._onDropDownMapPackageChanged, slot0, {
		total_w = 750,
		drop_w = 450
	})
end

slot0.Drop_Down_Map_Package_Changed = "GMSubViewRoom.Drop_Down_Map_Package_Changed"

function slot0._onDropDownMapPackageChanged(slot0, slot1)
	if slot1 >= 1 or slot1 <= #slot0._blockInfosList then
		if RoomMapBlockModel.instance:getConfirmBlockCount() > 0 then
			GameFacade.showToast(ToastEnum.IconId, "需要先重置下荒原")

			return
		end

		slot0._waitUseBlockList = {}

		tabletool.addValues(slot0._waitUseBlockList, slot0._blockInfosList[slot1])
		TaskDispatcher.cancelTask(slot0._onWaitUseBlockList, slot0)

		if #slot0._waitUseBlockList > 0 then
			UIBlockMgr.instance:startBlock(uv0.Drop_Down_Map_Package_Changed)
			TaskDispatcher.runRepeat(slot0._onWaitUseBlockList, slot0, 0.001, #slot0._waitUseBlockList + 1)
		end
	end
end

function slot0._onWaitUseBlockList(slot0)
	if slot0._waitUseBlockList and #slot0._waitUseBlockList > 0 then
		slot1 = slot0._waitUseBlockList[#slot0._waitUseBlockList]

		table.remove(slot0._waitUseBlockList, #slot0._waitUseBlockList)
		RoomMapController.instance:useBlockRequest(slot1.blockId, slot1.rotate, slot1.x, slot1.y)
	else
		UIBlockMgr.instance:endBlock(uv0.Drop_Down_Map_Package_Changed)
		RoomController.instance:exitRoom(true)
	end
end

function slot0._findCharacterShadow(slot0)
	for slot7, slot8 in ipairs(lua_room_character.configList or {}) do
		if not string.nilorempty(slot8.shadow) and not ({
			shadow = true
		})[slot8.shadow] and SkinConfig.instance:getSkinCo(slot8.skinId) and not string.nilorempty(slot9.spine) then
			slot10 = string.split(slot9.spine, "/")
		end
	end

	logError(JsonUtil.encode({
		[string.format("%s_room", slot10[#slot10])] = slot8.shadow
	}))
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onWaitUseBlockList, slot0)
end

return slot0
