module("modules.logic.room.view.RoomViewConfirm", package.seeall)

local var_0_0 = class("RoomViewConfirm", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goconfirm = gohelper.findChild(arg_4_0.viewGO, "go_confirm")
	arg_4_0._gocontainer = gohelper.findChild(arg_4_0.viewGO, "go_confirm/go_container")
	arg_4_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_confirm/go_container/btn_confirm")
	arg_4_0._btncancel = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_confirm/go_container/btn_cancel")

	arg_4_0._btnconfirm:AddClickListener(arg_4_0._btnconfirmOnClick, arg_4_0)
	arg_4_0._btncancel:AddClickListener(arg_4_0._btncancelOnClick, arg_4_0)

	arg_4_0._btncancelcharacter = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_confirm/go_container/btn_cancelcharacter")

	arg_4_0._btncancelcharacter:AddClickListener(arg_4_0._btncancelOnClick, arg_4_0)

	arg_4_0._gocancelpos = gohelper.findChild(arg_4_0.viewGO, "go_confirm/go_container/go_cancelpos")
	arg_4_0._goconfirmpos = gohelper.findChild(arg_4_0.viewGO, "go_confirm/go_container/go_confirmpos")
	arg_4_0._gocancelposcharacter = gohelper.findChild(arg_4_0.viewGO, "go_confirm/go_container/go_cancelposcharacter")
	arg_4_0._goconfirmposcharacter = gohelper.findChild(arg_4_0.viewGO, "go_confirm/go_container/go_confirmposcharacter")

	local var_4_0 = {}

	for iter_4_0 = 1, 100 do
		table.insert(var_4_0, 0.5)
	end

	arg_4_0._gorotate = gohelper.findChild(arg_4_0.viewGO, "go_confirm/go_container/go_rotate")
	arg_4_0._rotateClick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._gorotate)

	arg_4_0._rotateClick:AddClickListener(arg_4_0._btnrotateOnClick, arg_4_0)

	arg_4_0._rotatePress = SLFramework.UGUI.UILongPressListener.Get(arg_4_0._gorotate)

	arg_4_0._rotatePress:SetLongPressTime(var_4_0)

	arg_4_0._confirmCanvasGroup = arg_4_0._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
	arg_4_0._isCharacter = false
	arg_4_0._allFocusItem = arg_4_0:getUserDataTb_()
	arg_4_0._allFocusItem[1] = arg_4_0._btncancel.transform
	arg_4_0._allFocusItem[2] = arg_4_0._gorotate.transform
	arg_4_0._allFocusItem[3] = arg_4_0._btnconfirm.transform
	arg_4_0._inputhandle = TaskDispatcher.runRepeat(arg_4_0._handleMouseInput, arg_4_0, 0.01)
end

function var_0_0._handleMouseInput(arg_5_0)
	if not PCInputController.instance:getIsUse() then
		return
	end

	local var_5_0 = UnityEngine.Input.mouseScrollDelta

	if var_5_0 and var_5_0.y ~= 0 then
		arg_5_0:_btnrotateOnClick()
	end

	if UnityEngine.Input.GetMouseButtonDown(1) then
		arg_5_0:_btncancelOnClick()
	end

	if UnityEngine.Input.GetKey("space") then
		arg_5_0:_btnconfirmOnClick()
	end
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			arg_6_0:_confirmBuilding()
		else
			arg_6_0:_confirmBlock()
		end
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			arg_6_0:_confirmBuilding()
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			arg_6_0:_confirmCharacter()
		end
	end
end

function var_0_0._confirmBuilding(arg_7_0)
	local var_7_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0.id
	local var_7_2 = var_7_0.buildingId
	local var_7_3 = var_7_0.rotate
	local var_7_4 = var_7_0.hexPoint
	local var_7_5, var_7_6 = RoomBuildingHelper.canConfirmPlace(var_7_2, var_7_4, var_7_3, nil, nil, false, var_7_0.levels, true)

	if var_7_5 then
		if tonumber(var_7_1) < 1 then
			local var_7_7 = ManufactureConfig.instance:getManufactureBuildingCfg(var_7_2)

			if var_7_7 and var_7_7.placeNoCost == 1 then
				RoomBuildingController.instance:sendBuyManufactureBuildingRpc(var_7_2)

				return
			end

			ViewMgr.instance:openView(ViewName.RoomManufacturePlaceCostView)

			return
		end

		local var_7_8 = RoomBuildingAreaHelper.findTempOutBuildingMOList()

		if var_7_8 and #var_7_8 then
			local var_7_9 = RoomBuildingAreaHelper.formatBuildingMOListNameStr(var_7_8)

			GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeMainBuilding, MsgBoxEnum.BoxType.Yes_No, arg_7_0._requestUseBuilding, nil, nil, arg_7_0, nil, nil, var_7_9)

			return
		end

		local var_7_10 = RoomBuildingAreaHelper.findTempOutTransportMOList()

		if var_7_10 and #var_7_10 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeMainBuildingTransportPath, MsgBoxEnum.BoxType.Yes_No, arg_7_0._requestUseBuilding, nil, nil, arg_7_0, nil, nil)

			return
		end

		RoomMapController.instance:useBuildingRequest(var_7_1, var_7_3, var_7_4.x, var_7_4.y)
	elseif var_7_6 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.Foundation then
		GameFacade.showToast(ToastEnum.RoomErrorFoundation)
	elseif var_7_6 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceId then
		GameFacade.showToast(ToastEnum.RoomErrorResourceId)
	elseif var_7_6 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceArea then
		GameFacade.showToast(ToastEnum.RoomErrorResourceArea)
	elseif var_7_6 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.NoAreaMainBuilding then
		GameFacade.showToast(ToastEnum.NoAreaMainBuilding)
	elseif var_7_6 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.OutSizeAreaBuilding then
		GameFacade.showToast(ToastEnum.OutSizeAreaBuilding)
	elseif var_7_6 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.InTransportPath then
		GameFacade.showToast(ToastEnum.RoomBuildingInTranspath)
	end
end

function var_0_0._requestUnUseBuilding(arg_8_0)
	local var_8_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if var_8_0 then
		RoomMapController.instance:unUseBuildingRequest(var_8_0.id)
	end
end

function var_0_0._requestUseBuilding(arg_9_0)
	local var_9_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if var_9_0 then
		local var_9_1 = var_9_0.hexPoint

		RoomMapController.instance:useBuildingRequest(var_9_0.id, var_9_0.rotate, var_9_1.x, var_9_1.y)
	end
end

function var_0_0._removeOutBuildingMOList(arg_10_0, arg_10_1)
	local var_10_0 = RoomBuildingAreaHelper.findTempOutBuildingMOList(arg_10_1)

	if var_10_0 and #var_10_0 > 0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			RoomMapController.instance:unUseBuildingRequest(iter_10_1.id)
		end
	end
end

function var_0_0._confirmBlock(arg_11_0)
	local var_11_0 = RoomMapBlockModel.instance:getTempBlockMO()
	local var_11_1 = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()

	if not var_11_0 or not var_11_1 then
		return
	end

	if RoomInventoryBlockModel.instance:isMaxNum() then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMax)

		return
	end

	local var_11_2 = var_11_1.id
	local var_11_3 = var_11_1.rotate
	local var_11_4 = var_11_0.hexPoint

	RoomMapController.instance:useBlockRequest(var_11_2, var_11_3, var_11_4.x, var_11_4.y)
end

function var_0_0._confirmCharacter(arg_12_0)
	local var_12_0 = RoomCharacterModel.instance:getTempCharacterMO()

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0.currentPosition

	if RoomCharacterHelper.canConfirmPlace(var_12_0.heroId, var_12_1, var_12_0.skinId, true) then
		RoomMapController.instance:useCharacterRequest(var_12_0.id)
	end
end

function var_0_0._btnrotateOnClick(arg_13_0)
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			arg_13_0:_rotateBuilding()
		else
			arg_13_0:_rotateBlock()
		end
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			arg_13_0:_rotateBuilding()
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			arg_13_0:_rotateCharacter()
		end
	end
end

function var_0_0._rotateBuilding(arg_14_0)
	local var_14_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not var_14_0 then
		return
	end

	for iter_14_0 = 1, 5 do
		local var_14_1 = RoomRotateHelper.rotateRotate(var_14_0.rotate, iter_14_0)

		if RoomBuildingHelper.canTryPlace(var_14_0.buildingId, var_14_0.hexPoint, var_14_1) then
			local var_14_2 = {
				rotate = var_14_1
			}

			arg_14_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, var_14_2)

			return
		end
	end

	GameFacade.showToast(ToastEnum.RoomRotateBuilding)
end

function var_0_0._rotateBlock(arg_15_0)
	local var_15_0 = RoomMapBlockModel.instance:getTempBlockMO()

	if not var_15_0 then
		return
	end

	local var_15_1 = {
		rotate = RoomRotateHelper.rotateRotate(var_15_0.rotate, 1)
	}

	arg_15_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBlock, var_15_1)
end

function var_0_0._rotateCharacter(arg_16_0)
	return
end

function var_0_0._btncancelOnClick(arg_17_0)
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			arg_17_0:_cancelBuilding()
		else
			arg_17_0:_cancelBlock()
		end
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			arg_17_0:_cancelBuilding()
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			arg_17_0:_cancelCharacter()
		end
	end
end

function var_0_0._cancelBuilding(arg_18_0)
	local var_18_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not var_18_0 then
		return
	end

	if var_18_0.buildingState == RoomBuildingEnum.BuildingState.Temp then
		arg_18_0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
	elseif var_18_0.buildingState == RoomBuildingEnum.BuildingState.Revert then
		if var_18_0:isBuildingArea() then
			local var_18_1 = RoomBuildingAreaHelper.findTempOutBuildingMOList()

			if var_18_1 and #var_18_1 then
				local var_18_2 = RoomBuildingAreaHelper.formatBuildingMOListNameStr(var_18_1)

				GameFacade.showMessageBox(MessageBoxIdDefine.RoomUnUseMainBuilding, MsgBoxEnum.BoxType.Yes_No, arg_18_0._requestUnUseBuilding, nil, nil, arg_18_0, nil, nil, var_18_2)

				return
			end
		end

		if arg_18_0:_checkBuildingHasCriter(var_18_0) then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomUnUseManufactureBuilding, MsgBoxEnum.BoxType.Yes_No, arg_18_0._requestUnUseBuilding, nil, nil, arg_18_0, nil, nil)

			return
		end

		local var_18_3 = RoomBuildingAreaHelper.findTempOutTransportMOList()

		if var_18_3 and #var_18_3 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomUnUseMainBuildingTransportPath, MsgBoxEnum.BoxType.Yes_No, arg_18_0._requestUnUseBuilding, nil, nil, arg_18_0, nil, nil)

			return
		end

		local var_18_4 = var_18_0.id

		RoomMapController.instance:unUseBuildingRequest(var_18_4)
	end
end

function var_0_0._checkBuildingHasCriter(arg_19_0, arg_19_1)
	if arg_19_1 then
		local var_19_0 = arg_19_1.config and arg_19_1.config.buildingType

		if RoomBuildingEnum.BuildingArea[var_19_0] then
			return true
		end
	end

	return false
end

function var_0_0._cancelBlock(arg_20_0)
	arg_20_0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
end

function var_0_0._cancelCharacter(arg_21_0)
	local var_21_0 = RoomCharacterModel.instance:getTempCharacterMO()

	if not var_21_0 then
		return
	end

	if var_21_0.characterState == RoomCharacterEnum.CharacterState.Temp then
		arg_21_0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceCharacter)
	elseif var_21_0.characterState == RoomCharacterEnum.CharacterState.Revert then
		RoomMapController.instance:unUseCharacterRequest(var_21_0.id, nil, nil, true)
	end
end

function var_0_0._refreshUI(arg_22_0)
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			arg_22_0:_refreshBuildingUI()
		else
			arg_22_0:_refreshBlockUI()
		end

		arg_22_0._isCharacter = false
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			arg_22_0:_refreshBuildingUI()

			arg_22_0._isCharacter = false
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			arg_22_0:_refreshCharacterUI()

			arg_22_0._isCharacter = true
		else
			gohelper.setActive(arg_22_0._gocontainer, false)
		end
	else
		gohelper.setActive(arg_22_0._gocontainer, false)
	end
end

function var_0_0._refreshBuildingUI(arg_23_0)
	gohelper.setActive(arg_23_0._btncancel.gameObject, true)
	gohelper.setActive(arg_23_0._btncancelcharacter.gameObject, false)

	local var_23_0 = RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm)

	var_23_0 = var_23_0 and arg_23_0._dropOP ~= true

	gohelper.setActive(arg_23_0._gocontainer, var_23_0)
	gohelper.setActive(arg_23_0._gorotate, true)

	if var_23_0 then
		local var_23_1 = RoomMapBuildingModel.instance:getTempBuildingMO()
		local var_23_2 = var_23_1 and arg_23_0._scene.buildingmgr:getBuildingEntity(var_23_1.id, SceneTag.RoomBuilding)

		if var_23_2 then
			local var_23_3 = var_23_2:getBodyGO() or var_23_2.go
			local var_23_4 = Vector3(transformhelper.getPos(var_23_3.transform))
			local var_23_5 = var_23_1.config and var_23_1.config.uiScale

			arg_23_0:_setUIPos(var_23_4, 0, var_23_5 and var_23_5 * 0.001)
		end

		arg_23_0:_setRotateAudio(AudioEnum.Room.play_ui_home_board_switch)
		arg_23_0:_setCancelAudio(AudioEnum.Room.play_ui_home_board_recovery)
		arg_23_0:_setConfirmAudio(0)
	end

	recthelper.setAnchor(arg_23_0._btncancel.gameObject.transform, recthelper.getAnchor(arg_23_0._gocancelpos.transform))
	recthelper.setAnchor(arg_23_0._btnconfirm.gameObject.transform, recthelper.getAnchor(arg_23_0._goconfirmpos.transform))
end

function var_0_0._refreshBlockUI(arg_24_0)
	gohelper.setActive(arg_24_0._btncancel.gameObject, true)
	gohelper.setActive(arg_24_0._btncancelcharacter.gameObject, false)

	local var_24_0 = RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) or RoomFSMHelper.isCanJompTo(RoomEnum.FSMEditState.PlaceConfirm)

	gohelper.setActive(arg_24_0._gocontainer, var_24_0)
	gohelper.setActive(arg_24_0._gorotate, true)

	if var_24_0 then
		local var_24_1 = RoomMapBlockModel.instance:getTempBlockMO()
		local var_24_2 = var_24_1 and arg_24_0._scene.mapmgr:getBlockEntity(var_24_1.id, SceneTag.RoomMapBlock)

		if var_24_2 then
			local var_24_3 = Vector3(transformhelper.getPos(var_24_2.go.transform))

			arg_24_0:_setUIPos(var_24_3, 0.12)
		end

		arg_24_0:_setRotateAudio(AudioEnum.Room.play_ui_home_board_switch)
		arg_24_0:_setCancelAudio(AudioEnum.Room.play_ui_home_board_remove)
		arg_24_0:_setConfirmAudio(0)
	end

	recthelper.setAnchor(arg_24_0._btncancel.gameObject.transform, recthelper.getAnchor(arg_24_0._gocancelpos.transform))
	recthelper.setAnchor(arg_24_0._btnconfirm.gameObject.transform, recthelper.getAnchor(arg_24_0._goconfirmpos.transform))
end

function var_0_0._refreshCharacterUI(arg_25_0)
	gohelper.setActive(arg_25_0._gorotate, true)
	gohelper.setActive(arg_25_0._gocontainer, arg_25_0._dropOP ~= true)
	gohelper.setActive(arg_25_0._gorotate, false)

	local var_25_0 = RoomCharacterModel.instance:getTempCharacterMO()
	local var_25_1 = var_25_0 and arg_25_0._scene.charactermgr:getCharacterEntity(var_25_0.id, SceneTag.RoomCharacter)

	gohelper.setActive(arg_25_0._btncancel.gameObject, not var_25_0 or var_25_0.characterState ~= RoomCharacterEnum.CharacterState.Revert)
	gohelper.setActive(arg_25_0._btncancelcharacter.gameObject, var_25_0 and var_25_0.characterState == RoomCharacterEnum.CharacterState.Revert)

	if var_25_1 then
		local var_25_2 = var_25_0.currentPosition
		local var_25_3 = 0.6 * RoomBlockEnum.BlockSize
		local var_25_4 = arg_25_0._scene.camera:getCameraRotate()
		local var_25_5 = var_25_2.x + var_25_3 * math.sin(var_25_4)
		local var_25_6 = var_25_2.z + var_25_3 * math.cos(var_25_4)
		local var_25_7 = Vector3(var_25_5, 0, var_25_6)

		arg_25_0:_setUIPos(var_25_7, 0.05, 0.5)
		arg_25_0:_setRotateAudio(AudioEnum.Room.play_ui_home_role_switch)
		arg_25_0:_setCancelAudio(AudioEnum.Room.play_ui_home_role_remove)
		arg_25_0:_setConfirmAudio(AudioEnum.Room.play_ui_home_role_fix)
	end

	recthelper.setAnchor(arg_25_0._btncancel.gameObject.transform, recthelper.getAnchor(arg_25_0._gocancelposcharacter.transform))
	recthelper.setAnchor(arg_25_0._btnconfirm.gameObject.transform, recthelper.getAnchor(arg_25_0._goconfirmposcharacter.transform))
end

function var_0_0._setRotateAudio(arg_26_0, arg_26_1)
	if arg_26_1 == 0 then
		gohelper.removeUIClickAudio(arg_26_0._gorotate)
	else
		gohelper.addUIClickAudio(arg_26_0._gorotate, arg_26_1 or AudioEnum.UI.Play_UI_Universal_Click)
	end
end

function var_0_0._setCancelAudio(arg_27_0, arg_27_1)
	if arg_27_1 == 0 then
		gohelper.removeUIClickAudio(arg_27_0._btncancel.gameObject)
		gohelper.removeUIClickAudio(arg_27_0._btncancelcharacter.gameObject)
	else
		gohelper.addUIClickAudio(arg_27_0._btncancel.gameObject, arg_27_1 or AudioEnum.UI.Play_UI_Universal_Click)
		gohelper.addUIClickAudio(arg_27_0._btncancelcharacter.gameObject, arg_27_1 or AudioEnum.UI.Play_UI_Universal_Click)
	end
end

function var_0_0._setConfirmAudio(arg_28_0, arg_28_1)
	if arg_28_1 == 0 then
		gohelper.removeUIClickAudio(arg_28_0._btnconfirm.gameObject)
	else
		gohelper.addUIClickAudio(arg_28_0._btnconfirm.gameObject, arg_28_1 or AudioEnum.UI.Play_UI_Universal_Click)
	end
end

function var_0_0._setUIPos(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = RoomBendingHelper.worldToBendingSimple(arg_29_1)
	local var_29_1 = arg_29_0._scene.camera:getCameraPosition()
	local var_29_2 = arg_29_0._scene.camera:getCameraFocus()
	local var_29_3 = Vector3.Distance(var_29_1, var_29_0)
	local var_29_4 = Mathf.Clamp(2.912 / var_29_3, 0.4, 1)
	local var_29_5 = arg_29_0._scene.camera:getCameraRotate()
	local var_29_6 = var_29_0.x - (0.9 - var_29_4 * 0.5) * Mathf.Sin(var_29_5)
	local var_29_7 = var_29_0.z - (0.9 - var_29_4 * 0.5) * Mathf.Cos(var_29_5)

	arg_29_2 = arg_29_2 or 0

	local var_29_8 = Vector3(var_29_6, var_29_0.y + arg_29_2, var_29_7)
	local var_29_9 = recthelper.worldPosToAnchorPos(var_29_8, arg_29_0._goconfirm.transform)

	recthelper.setAnchor(arg_29_0._gocontainer.transform, var_29_9.x, arg_29_0._isCharacter and var_29_9.y or var_29_9.y - 20)
end

function var_0_0._onFSMEnterState(arg_30_0, arg_30_1)
	arg_30_0:_refreshUI()
end

function var_0_0._onFSMLeaveState(arg_31_0, arg_31_1)
	arg_31_0:_refreshUI()
end

function var_0_0._onConfirmRefreshUI(arg_32_0)
	arg_32_0:_refreshUI()
end

function var_0_0._pressBuildingUp(arg_33_0)
	arg_33_0._dropOP = true

	arg_33_0:_refreshUI()
end

function var_0_0._dropBuildingDown(arg_34_0)
	arg_34_0._dropOP = false

	arg_34_0:_refreshUI()
end

function var_0_0._pressCharacterUp(arg_35_0)
	arg_35_0._dropOP = true

	arg_35_0:_refreshUI()
end

function var_0_0._dropCharacterDown(arg_36_0)
	arg_36_0._dropOP = false

	arg_36_0:_refreshUI()
end

function var_0_0._isDropOP(arg_37_0)
	if arg_37_0._dropOP then
		return true
	end
end

function var_0_0._cameraTransformUpdate(arg_38_0)
	arg_38_0:_refreshUI()
end

function var_0_0._addBtnAudio(arg_39_0)
	gohelper.addUIClickAudio(arg_39_0._btnconfirm.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0._onGamepadKeyUp(arg_40_0, arg_40_1)
	if (arg_40_1 == GamepadEnum.KeyCode.LB or arg_40_1 == GamepadEnum.KeyCode.RB) and arg_40_0._gocontainer.activeInHierarchy then
		arg_40_0._focusIndex = arg_40_0._focusIndex or 2

		local var_40_0 = arg_40_1 == GamepadEnum.KeyCode.LB and -1 or 1
		local var_40_1 = arg_40_0._focusIndex + var_40_0

		if var_40_1 == 2 and arg_40_0._gorotate.activeInHierarchy == false then
			var_40_1 = var_40_1 + var_40_0
		end

		local var_40_2 = math.max(1, var_40_1)
		local var_40_3 = math.min(3, var_40_2)

		arg_40_0._focusIndex = var_40_3

		local var_40_4 = arg_40_0._allFocusItem[var_40_3]
		local var_40_5 = recthelper.rectToRelativeAnchorPos(var_40_4.position, ViewMgr.instance:getUIRoot().transform)

		GamepadController.instance:setPointerAnchor(var_40_5.x, var_40_5.y)
	end
end

function var_0_0.onOpen(arg_41_0)
	arg_41_0:_refreshUI()
	arg_41_0:_addBtnAudio()
	arg_41_0:addEventCb(RoomMapController.instance, RoomEvent.FSMEnterState, arg_41_0._onFSMEnterState, arg_41_0)
	arg_41_0:addEventCb(RoomMapController.instance, RoomEvent.FSMLeaveState, arg_41_0._onFSMLeaveState, arg_41_0)
	arg_41_0:addEventCb(RoomBuildingController.instance, RoomEvent.PressBuildingUp, arg_41_0._pressBuildingUp, arg_41_0)
	arg_41_0:addEventCb(RoomBuildingController.instance, RoomEvent.DropBuildingDown, arg_41_0._dropBuildingDown, arg_41_0)
	arg_41_0:addEventCb(RoomCharacterController.instance, RoomEvent.PressCharacterUp, arg_41_0._pressCharacterUp, arg_41_0)
	arg_41_0:addEventCb(RoomCharacterController.instance, RoomEvent.DropCharacterDown, arg_41_0._dropCharacterDown, arg_41_0)
	arg_41_0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_41_0._cameraTransformUpdate, arg_41_0)
	arg_41_0:addEventCb(RoomMapController.instance, RoomEvent.RoomVieiwConfirmRefreshUI, arg_41_0._onConfirmRefreshUI, arg_41_0)

	if GamepadController.instance:isOpen() then
		arg_41_0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, arg_41_0._onGamepadKeyUp, arg_41_0)
	end
end

function var_0_0.onClose(arg_42_0)
	return
end

function var_0_0.onDestroyView(arg_43_0)
	arg_43_0._btnconfirm:RemoveClickListener()
	arg_43_0._btncancel:RemoveClickListener()
	arg_43_0._btncancelcharacter:RemoveClickListener()
	arg_43_0._rotateClick:RemoveClickListener()
	arg_43_0._rotatePress:RemoveLongPressListener()
	TaskDispatcher.cancelTask(arg_43_0._handleMouseInput, arg_43_0)
end

var_0_0.prefabPath = "ui/viewres/room/roomviewconfirm.prefab"

return var_0_0
