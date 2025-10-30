﻿-- chunkname: @modules/logic/gm/view/GMSubViewRoom.lua

module("modules.logic.gm.view.GMSubViewRoom", package.seeall)

local GMSubViewRoom = class("GMSubViewRoom", GMSubViewBase)

function GMSubViewRoom:ctor()
	self.tabName = "荒原"
end

function GMSubViewRoom:initViewContent()
	if self._isInit then
		return
	end

	self:_initL1()
	self:_initL2()
	self:_initL3()
	self:_initL4()
	self:_initL5()
	self:_initL6()
	self:_initL7()
	self:_initL8()
	self:_initL9()

	self._isInit = true
end

function GMSubViewRoom:_initL1()
	local LStr = "L1"

	self:addButton(LStr, "小屋观察", self._onClickBtnRoomOb, self)
	self:addButton(LStr, "小屋编辑", self._onClickBtnRoomMap, self)
	self:addButton(LStr, "小屋Debug", self._onClickBtnRoomDebug, self)
	self:addButton(LStr, "小屋建筑占地", self._onClickRoomDebugBuildingArea, self)
	self:addButton(LStr, "小屋一键GM", self._onClickBtnOneKey, self)
end

function GMSubViewRoom:_onClickBtnRoomOb()
	RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
end

function GMSubViewRoom:_onClickBtnRoomMap()
	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
end

function GMSubViewRoom:_onClickBtnRoomDebug()
	ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
end

function GMSubViewRoom:_onClickRoomDebugBuildingArea()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomDebugController.instance:openBuildingAreaView()
	else
		GameFacade.showToast(94, "GM需要进入小屋后使用。")
	end
end

function GMSubViewRoom:_onClickBtnOneKey()
	local gmList = {
		"set roomLevel 6",
		"set tradeLevel   15",
		"add allBlockPackage",
		"add allBuilding",
		"add allSpecialBlock"
	}
	local delay = 0

	for _, gm in ipairs(gmList) do
		if delay == 0 then
			GMRpc.instance:sendGMRequest(gm)
		else
			TaskDispatcher.runDelay(function()
				GMRpc.instance:sendGMRequest(gm)
			end, nil, delay)
		end

		delay = delay + 0.1
	end
end

function GMSubViewRoom:_initL2()
	local LStr = "L2"
	local comp1 = self:addSlider(LStr, "QE灵敏度", self._onRoomRotateSpeedChange, self, {
		w = 610
	})

	self._txtRoomRotateSpeed = comp1[3]

	local curValue = (RoomController.instance.rotateSpeed - 0.2) / 1.8

	comp1[1]:SetValue(curValue)
	self:_onRoomRotateSpeedChange(nil, curValue)

	local comp2 = self:addSlider(LStr, "WASD灵敏度", self._onRoomMoveSpeedChange, self, {
		w = 685
	})

	self._txtRoomMoveSpeed = comp2[3]
	curValue = (RoomController.instance.moveSpeed - 0.2) / 1.8

	comp2[1]:SetValue(curValue)
	self:_onRoomMoveSpeedChange(nil, curValue)
end

function GMSubViewRoom:_initL3()
	local LStr = "L3"
	local comp3 = self:addSlider(LStr, "RF灵敏度", self._onRoomScaleSpeedChange, self, {
		w = 610
	})

	self._txtRoomScaleSpeed = comp3[3]

	local curValue = (RoomController.instance.scaleSpeed - 0.2) / 1.8

	comp3[1]:SetValue(curValue)
	self:_onRoomScaleSpeedChange(nil, curValue)

	local comp4 = self:addSlider(LStr, "滑屏灵敏度", self._onRoomTouchSpeedChange, self, {
		w = 685
	})

	self._txtRoomTouchSpeed = comp4[3]
	curValue = (RoomController.instance.touchMoveSpeed - 0.2) / 1.8

	comp4[1]:SetValue((RoomController.instance.touchMoveSpeed - 0.2) / 1.8)
	self:_onRoomTouchSpeedChange(nil, curValue)
end

function GMSubViewRoom:_onRoomRotateSpeedChange(param, value)
	local speed = 0.2 + 1.8 * value

	RoomController.instance.rotateSpeed = speed
	self._txtRoomRotateSpeed.text = string.format("%.2f", speed)
end

function GMSubViewRoom:_onRoomMoveSpeedChange(param, value)
	local speed = 0.2 + 1.8 * value

	RoomController.instance.moveSpeed = speed
	self._txtRoomMoveSpeed.text = string.format("%.2f", speed)
end

function GMSubViewRoom:_onRoomScaleSpeedChange(param, value)
	local speed = 0.2 + 1.8 * value

	RoomController.instance.scaleSpeed = speed
	self._txtRoomScaleSpeed.text = string.format("%.2f", speed)
end

function GMSubViewRoom:_onRoomTouchSpeedChange(param, value)
	local speed = 0.2 + 1.8 * value

	RoomController.instance.touchMoveSpeed = speed
	self._txtRoomTouchSpeed.text = string.format("%.2f", speed)
end

function GMSubViewRoom._sortCharacterInteractionFunc(a, b)
	if a.behaviour ~= b.behaviour then
		return a.behaviour < b.behaviour
	end
end

function GMSubViewRoom:_initL4()
	local LStr = "L4"

	if not self.characterInteractionList then
		self.characterInteractionList = {}

		for _, cfg in ipairs(lua_room_character_interaction.configList) do
			local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(cfg.heroId)

			if roomCharacterMO and roomCharacterMO.characterState == RoomCharacterEnum.CharacterState.Map then
				table.insert(self.characterInteractionList, cfg)
			end
		end

		table.sort(self.characterInteractionList, GMSubViewRoom._sortCharacterInteractionFunc)
	end

	local interStr = {}
	local typeName = {
		[RoomCharacterEnum.InteractionType.Dialog] = "对话",
		[RoomCharacterEnum.InteractionType.Building] = "建筑"
	}

	table.insert(interStr, "英雄-交互#id选择")

	for _, cfg in ipairs(self.characterInteractionList) do
		if typeName[cfg.behaviour] then
			local heroCo = HeroConfig.instance:getHeroCO(cfg.heroId)
			local str = string.format("%s-%s#%s", heroCo.name or cfg.heroId, typeName[cfg.behaviour], cfg.id)

			table.insert(interStr, str)
		end
	end

	self:addDropDown(LStr, "小屋角色交互", interStr, self._onRoomInteractionSelectChanged, self, {
		tempH = 450,
		total_w = 650,
		drop_w = 415
	})
	self:addButton(LStr, "确定", self._onClickRoomInteractionOk, self)

	interStr = {
		"选择时间"
	}

	for i = 1, 24 do
		table.insert(interStr, i .. "时")
	end

	self:addDropDown(LStr, "小屋时钟触发", interStr, self._onRoomClockSelectChanged, self, {
		total_w = 600,
		tempH = 450
	})
end

function GMSubViewRoom:_onRoomInteractionSelectChanged(index)
	if not self.characterInteractionList then
		return
	end

	if index == 0 then
		self.selectCharacterInteractionCfg = nil

		return
	end

	self.selectCharacterInteractionCfg = self.characterInteractionList[index]
end

function GMSubViewRoom:_onClickRoomInteractionOk()
	if #self.characterInteractionList < 1 then
		GameFacade.showToast(94, "GM需要进入小屋并放置可交互角色。")
	end

	if not self.selectCharacterInteractionCfg then
		return
	end

	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self.selectCharacterInteractionCfg.heroId)

	if not roomCharacterMO or roomCharacterMO.characterState ~= RoomCharacterEnum.CharacterState.Map then
		GameFacade.showToast(94, "GM 需要放置角色后可交互。")

		return
	end

	if self.selectCharacterInteractionCfg.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		GameFacade.showToast(94, string.format("GM %s 触发交互", roomCharacterMO.heroConfig.name))
		roomCharacterMO:setCurrentInteractionId(self.selectCharacterInteractionCfg.id)
		RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
	elseif self.selectCharacterInteractionCfg.behaviour == RoomCharacterEnum.InteractionType.Building then
		local interctionMO = RoomMapInteractionModel.instance:getBuildingInteractionMO(self.selectCharacterInteractionCfg.id)
		local buildingCfg = RoomConfig.instance:getBuildingConfig(self.selectCharacterInteractionCfg.buildingId)
		local builingName = buildingCfg and buildingCfg.name or self.selectCharacterInteractionCfg.buildingId

		if not interctionMO then
			GameFacade.showToast(94, string.format("GM 场景无【%s】建筑，【%s】无发交互", builingName, roomCharacterMO.heroConfig.name))

			return
		end

		if not RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) then
			GameFacade.showToast(94, string.format("GM 当场景状态机非[%s]", RoomEnum.FSMObState.Idle))

			return
		end

		local isSuccess = RoomInteractionController.instance:showTimeByInteractionMO(interctionMO)

		if not isSuccess then
			GameFacade.showToast(94, string.format("GM【%s】不在【%s】交互点范围内", roomCharacterMO.heroConfig.name, builingName))

			return
		end

		self:closeThis()
		logNormal(string.format("GM【%s】【%s】触发角色建筑交互", roomCharacterMO.heroConfig.name, builingName))
	end
end

function GMSubViewRoom:_onRoomClockSelectChanged(index)
	if index >= 1 or index <= 24 then
		RoomMapController.instance:dispatchEvent(RoomEvent.OnHourReporting, index)
	end
end

function GMSubViewRoom:_checkScene()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and GameSceneMgr.instance:getCurScene() ~= nil then
		return true
	end

	return false
end

function GMSubViewRoom:_checkObMode(isTips)
	return self:_checkScene() and RoomController.instance:isObMode()
end

function GMSubViewRoom:_checkEditMode(isTips)
	return self:_checkScene() and RoomController.instance:isEditMode()
end

function GMSubViewRoom:_findObMOList(tipStr, moList, cfgKey)
	if not self:_checkObMode() then
		moList = nil
	end

	return self:_findMOList(tipStr, moList, cfgKey)
end

function GMSubViewRoom:_findMOList(tipStr, moList, cfgKey)
	local strList = {
		tipStr .. "#id-选择"
	}
	local idList = {}

	if moList then
		for _, xxMO in ipairs(moList) do
			if xxMO and xxMO[cfgKey] then
				table.insert(strList, string.format("%s#%s", xxMO[cfgKey].name, xxMO.id))
				table.insert(idList, xxMO.id)
			end
		end
	end

	return strList, idList
end

function GMSubViewRoom:_initL5()
	local LStr = "L5"
	local strNameList, idList = self:_findInitFollowCharacterParams()

	self._dropFollowCharacter = self:addDropDown(LStr, "角色镜头跟随", strNameList, self._onFollowCharacterSelectChanged, self, {
		total_w = 650,
		drop_w = 415
	})
	self._characterIdList = idList

	self:addButton(LStr, "小屋交互镜头", self._onClickRoomBuildingCamera, self)
	self:addButton(LStr, "清空角色交互数据", self._onClickRoomClearInteractionData, self)
end

function GMSubViewRoom:_findInitFollowCharacterParams()
	return self:_findObMOList("选择角色", RoomCharacterModel.instance:getList(), "skinConfig")
end

function GMSubViewRoom:_onFollowCharacterSelectChanged(index)
	if not self._characterIdList or index == 0 then
		return
	end

	if not self:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	local vehicleTag = RoomCharacterEntity:getTag()
	local vehicleId = self._characterIdList[index]
	local scene = GameSceneMgr.instance:getCurScene()
	local characterEntity = scene.charactermgr:getUnit(vehicleTag, vehicleId)

	if characterEntity then
		scene.cameraFollow:setFollowTarget(characterEntity.cameraFollowTargetComp, false)
	end
end

function GMSubViewRoom:_onClickRoomBuildingCamera()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomDebugController.instance:openBuildingCamerView()
		self:closeThis()
	else
		GameFacade.showToast(94, "GM需要进入小屋后使用。")
	end
end

local ClearInteractionDataGMId = 46

function GMSubViewRoom:_onClickRoomClearInteractionData()
	local cfg = lua_gm_command.configDict[ClearInteractionDataGMId]

	if cfg then
		local cmd = cfg.command

		GameFacade.showToast(ToastEnum.IconId, cmd)
		GMRpc.instance:sendGMRequest(cmd)
	end
end

function GMSubViewRoom:_initL6()
	local LStr = "L6"
	local strNameList, idList = self:_findInitFollowTargetParams()

	self._dropFollowTarget = self:addDropDown(LStr, "乘坐交通", strNameList, self._onFollowTargetSelectChanged, self, {
		total_w = 650,
		drop_w = 415
	})
	self._vehicleIdList = idList

	self:addDropDown(LStr, "地块用途", {
		"地块用途选择",
		"正常",
		"货运"
	}, self._onBlockUseStateSelectChanged, self, {
		total_w = 600,
		drop_w = 415
	})
end

function GMSubViewRoom:_findInitFollowTargetParams()
	return self:_findObMOList("选择交通", RoomMapVehicleModel.instance:getList(), "config")
end

function GMSubViewRoom:_onFollowTargetSelectChanged(index)
	if not self._vehicleIdList or index == 0 then
		return
	end

	if not self:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	GameFacade.showToast(ToastEnum.IconId, "乘坐交通工具")

	local vehicleId = self._vehicleIdList[index]
	local vehicleTag = RoomMapVehicleEntity:getTag()
	local scene = GameSceneMgr.instance:getCurScene()
	local vehicleEntity = scene.vehiclemgr:getUnit(vehicleTag, vehicleId)

	if vehicleEntity then
		scene.cameraFollow:setFollowTarget(vehicleEntity.cameraFollowTargetComp, true)
	end
end

function GMSubViewRoom:_onBlockUseStateSelectChanged(index)
	if index == 0 then
		return
	end

	if not self:_checkEditMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")

		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local mapmgr = scene.mapmgr
	local blockEntityList = {}
	local blockMOList = RoomMapBlockModel.instance:getFullBlockMOList()

	for _, blockMO in ipairs(blockMOList) do
		blockMO:setUseState(index)

		local entity = mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

		if entity then
			table.insert(blockEntityList, entity)
		end
	end

	RoomBlockHelper.refreshBlockEntity(blockEntityList, "refreshLand")
	GameFacade.showToast(ToastEnum.IconId, string.format("GM index:%s, entityCount:%s blockCount:%s", index, #blockEntityList, #blockMOList))
end

function GMSubViewRoom:_initL7()
	local LStr = "L7"

	self:addButton(LStr, "交通工具测试", self._onClickTestVehicle, self)
	self:addButton(LStr, "mini地图", self._onOpenMiniMapView, self)
	self:addButton(LStr, "货运编辑", self._onOpenEditPathView, self)

	self._transporQuickLinkToggle = self:addToggle(LStr, "调试运输路线【快速绘制】", self._ontransporQuickLinkChange, self)
	self._transporQuickLinkToggle.isOn = RoomTransportPathQuickLinkViewUI._IsShow_ == true
end

function GMSubViewRoom:_onClickTestVehicle()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and RoomController.instance:isObMode() then
		local vehicleTag = RoomMapVehicleEntity:getTag()
		local mapVehicleMOList = RoomMapVehicleModel.instance:getList()
		local scene = GameSceneMgr.instance:getCurScene()

		for _, vehicleMO in ipairs(mapVehicleMOList) do
			local vehicleEntity = scene.vehiclemgr:getUnit(vehicleTag, vehicleMO.id)

			if vehicleEntity then
				scene.cameraFollow:setFollowTarget(vehicleEntity.cameraFollowTargetComp)

				return
			end
		end

		GameFacade.showToast(94, "GM交通工具数量：" .. #mapVehicleMOList)
	else
		GameFacade.showToast(94, "GM需要进入小屋后观察模式下使用。")
	end
end

function GMSubViewRoom:_onOpenMiniMapView()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
		itemList = {
			{
				itemId = 11921,
				itemType = MaterialEnum.MaterialType.Building
			}
		}
	})
end

function GMSubViewRoom:_onOpenEditPathView()
	if self:_checkScene() then
		ViewMgr.instance:openView(ViewName.RoomTransportPathView)
		self:closeThis()
	else
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")
	end
end

function GMSubViewRoom:_ontransporQuickLinkChange()
	RoomTransportPathQuickLinkViewUI._IsShow_ = RoomTransportPathQuickLinkViewUI._IsShow_ ~= true
end

function GMSubViewRoom:_initL8()
	local LStr = "L8"

	self.roomWeatherIdList = {}

	local ambientCfgList = RoomConfig.instance:getSceneAmbientConfigList()

	for _, cfg in ipairs(ambientCfgList) do
		table.insert(self.roomWeatherIdList, cfg.id)
	end

	local interStr = {
		"请选择天气"
	}

	tabletool.addValues(interStr, self.roomWeatherIdList)
	self:addDropDown(LStr, "小屋天气", interStr, self._onRoomWeatherSelectChanged, self, {
		total_w = 500,
		drop_w = 330
	})

	if RoomController.instance:isEditMode() and GameResMgr.IsFromEditorDir then
		RoomDebugController.instance:getDebugPackageInfo(self._onInitDebugMapPackageInfo, self, LStr)
	end
end

function GMSubViewRoom:_onRoomWeatherSelectChanged(index)
	if not self.roomWeatherIdList then
		return
	end

	if index == 0 then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		local scene = GameSceneMgr.instance:getCurScene()

		if scene and scene.ambient then
			local wId = self.roomWeatherIdList[index]

			scene.ambient:tweenToAmbientId(wId)
			GameFacade.showToast(94, string.format("GM切换小屋天气:%s", wId))
			self:closeThis()
		end
	else
		GameFacade.showToast(94, "GM需要进入小屋可使用。")
	end
end

function GMSubViewRoom:_onInitDebugMapPackageInfo(package, groupId)
	local mapNameList = {
		"选择需要复制的地图"
	}

	self._blockInfosList = {}

	local tRoomConfig = RoomConfig.instance

	for i, packageMap in ipairs(package) do
		local blockInfos = {}

		for _, info in ipairs(packageMap.infos) do
			local hexPoint = HexPoint(info.x, info.y)
			local isInBound = RoomBlockHelper.isInBoundary(hexPoint)

			if tRoomConfig:getBlock(info.blockId) and not tRoomConfig:getInitBlock(info.blockId) and isInBound then
				table.insert(blockInfos, info)
			end
		end

		if #blockInfos > 1 then
			table.insert(mapNameList, packageMap.packageName)
			table.insert(self._blockInfosList, blockInfos)
		end
	end

	self:addDropDown(groupId, "一键复制地图地块", mapNameList, self._onDropDownMapPackageChanged, self, {
		total_w = 750,
		drop_w = 450
	})
end

GMSubViewRoom.Drop_Down_Map_Package_Changed = "GMSubViewRoom.Drop_Down_Map_Package_Changed"

function GMSubViewRoom:_onDropDownMapPackageChanged(index)
	if index >= 1 or index <= #self._blockInfosList then
		if RoomMapBlockModel.instance:getConfirmBlockCount() > 0 then
			GameFacade.showToast(ToastEnum.IconId, "需要先重置下荒原")

			return
		end

		self._waitUseBlockList = {}

		tabletool.addValues(self._waitUseBlockList, self._blockInfosList[index])
		TaskDispatcher.cancelTask(self._onWaitUseBlockList, self)

		if #self._waitUseBlockList > 0 then
			UIBlockMgr.instance:startBlock(GMSubViewRoom.Drop_Down_Map_Package_Changed)
			TaskDispatcher.runRepeat(self._onWaitUseBlockList, self, 0.001, #self._waitUseBlockList + 1)
		end
	end
end

function GMSubViewRoom:_onWaitUseBlockList()
	if self._waitUseBlockList and #self._waitUseBlockList > 0 then
		local info = self._waitUseBlockList[#self._waitUseBlockList]

		table.remove(self._waitUseBlockList, #self._waitUseBlockList)
		RoomMapController.instance:useBlockRequest(info.blockId, info.rotate, info.x, info.y)
	else
		UIBlockMgr.instance:endBlock(GMSubViewRoom.Drop_Down_Map_Package_Changed)
		RoomController.instance:exitRoom(true)
	end
end

function GMSubViewRoom:_findCharacterShadow()
	local roomCharacterList = lua_room_character.configList or {}
	local resDict = {}
	local excludeDic = {
		shadow = true
	}

	for _, characterCfg in ipairs(roomCharacterList) do
		if not string.nilorempty(characterCfg.shadow) and not excludeDic[characterCfg.shadow] then
			local skinConfig = SkinConfig.instance:getSkinCo(characterCfg.skinId)

			if skinConfig and not string.nilorempty(skinConfig.spine) then
				local arr = string.split(skinConfig.spine, "/")

				resDict[string.format("%s_room", arr[#arr])] = characterCfg.shadow
			end
		end
	end

	logError(JsonUtil.encode(resDict))
end

function GMSubViewRoom:_initL9()
	local LStr = "L9"
	local interStr = {
		"换色选择",
		"地块换色",
		"建筑换色"
	}

	self:addDropDown(LStr, "小屋换色", interStr, self._onRoomChangeMeshReaderColorChanged, self, {
		total_w = 500,
		drop_w = 330
	})
end

function GMSubViewRoom:_onRoomChangeMeshReaderColorChanged(index)
	if not self:_checkScene() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋下使用。")

		return
	end

	local blockKeys = {
		RoomEnum.EffectKey.BlockLandKey,
		RoomEnum.EffectKey.BlockRiverFloorKey,
		RoomEnum.EffectKey.BlockRiverKey
	}

	tabletool.addValues(blockKeys, RoomEnum.EffectKey.BlockFloorBKeys)
	tabletool.addValues(blockKeys, RoomEnum.EffectKey.BlockFloorBKeys)

	local buildingKeys = {
		RoomEnum.EffectKey.BuildingGOKey
	}
	local blockEntityList = {}
	local buildingEntityList = {}
	local scene = GameSceneMgr.instance:getCurScene()

	LuaUtil.insertDict(blockEntityList, scene.mapmgr:getTagUnitDict(SceneTag.RoomMapBlock))
	LuaUtil.insertDict(buildingEntityList, scene.buildingmgr:getTagUnitDict(SceneTag.RoomBuilding))
	self:_setEntityListByEffectKeyList(blockEntityList, blockKeys, index == 1)
	self:_setEntityListByEffectKeyList(buildingEntityList, buildingKeys, index == 2)
end

local Shader = UnityEngine.Shader
local _ENABLE_CHANGE_COLOR = "_ENABLE_CHANGE_COLOR"
local ShaderIDMap = {
	enableChangeColor = Shader.PropertyToID("_EnableChangeColor"),
	hue = Shader.PropertyToID("_Hue"),
	saturation = Shader.PropertyToID("_Saturation"),
	brightness = Shader.PropertyToID("_Brightness")
}

function GMSubViewRoom:_setEntityListByEffectKeyList(entityList, keyList, isOpen)
	local scene = GameSceneMgr.instance:getCurScene()
	local mpb = scene.mapmgr:getPropertyBlock()

	mpb:Clear()

	local cfgList = lua_room_block_color_param.configList
	local num = #cfgList
	local idx = 0

	for i, entity in ipairs(entityList) do
		if isOpen then
			idx = idx + 1

			if idx > #cfgList then
				idx = 1
			end

			local cfg = cfgList[idx]
			local value = math.floor(i % 200) * 0.01 - 1

			mpb:SetFloat(ShaderIDMap.enableChangeColor, 1)
			mpb:SetFloat(ShaderIDMap.hue, cfg.hue)
			mpb:SetFloat(ShaderIDMap.saturation, cfg.saturation)
			mpb:SetFloat(ShaderIDMap.brightness, cfg.brightness)
		end

		for _, key in ipairs(keyList) do
			self:_setMeshReaderColor(entity.effect:getComponentsByPath(key, RoomEnum.ComponentName.MeshRenderer, "mesh"), mpb, open)
		end
	end
end

function GMSubViewRoom:_setMeshReaderColor(meshRendererList, mpb, open)
	if meshRendererList then
		for i, meshRenderer in ipairs(meshRendererList) do
			meshRenderer:SetPropertyBlock(mpb)
		end
	end
end

function GMSubViewRoom:onDestroyView()
	TaskDispatcher.cancelTask(self._onWaitUseBlockList, self)
end

return GMSubViewRoom
