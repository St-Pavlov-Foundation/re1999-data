module("modules.logic.commandstation.view.CommandStationMapSceneView", package.seeall)

local var_0_0 = class("CommandStationMapSceneView", BaseView)

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
	arg_4_0._gofullscreen = gohelper.findChild(arg_4_0.viewGO, "#go_bg")
	arg_4_0._tempVector = Vector3()
	arg_4_0._dragDeltaPos = Vector3()

	arg_4_0:_initMap()
	arg_4_0:_initDrag()
end

function var_0_0._initMap(arg_5_0)
	local var_5_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_5_1 = CameraMgr.instance:getSceneRoot()

	arg_5_0._sceneRoot = UnityEngine.GameObject.New("CommandStationMapScene")

	local var_5_2, var_5_3, var_5_4 = transformhelper.getLocalPos(var_5_0)

	transformhelper.setLocalPos(arg_5_0._sceneRoot.transform, 0, var_5_3, 0)
	gohelper.addChild(var_5_1, arg_5_0._sceneRoot)
end

function var_0_0._initDrag(arg_6_0)
	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._gofullscreen)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBegin, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEnd, arg_6_0)
	arg_6_0._drag:AddDragListener(arg_6_0._onDrag, arg_6_0)
end

function var_0_0.getDragWorldPos(arg_7_0, arg_7_1)
	local var_7_0 = CameraMgr.instance:getMainCamera()
	local var_7_1 = arg_7_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_7_1.position, var_7_0, var_7_1))
end

function var_0_0._onDragBegin(arg_8_0, arg_8_1, arg_8_2)
	if ViewMgr.instance:isOpen(ViewName.CommandStationCharacterEventView) then
		return
	end

	arg_8_0._dragBeginPos = arg_8_0:getDragWorldPos(arg_8_2)

	if arg_8_0._sceneTrans then
		arg_8_0._beginDragPos = arg_8_0._sceneTrans.localPosition
	end
end

function var_0_0._onDragEnd(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._dragBeginPos = nil
	arg_9_0._beginDragPos = nil
end

function var_0_0._onDrag(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._dragBeginPos then
		return
	end

	local var_10_0 = arg_10_0:getDragWorldPos(arg_10_2) - arg_10_0._dragBeginPos

	arg_10_0:drag(var_10_0)
end

function var_0_0.drag(arg_11_0, arg_11_1)
	if not arg_11_0._sceneTrans or not arg_11_0._beginDragPos then
		return
	end

	arg_11_0._dragDeltaPos.x = arg_11_1.x
	arg_11_0._dragDeltaPos.y = arg_11_1.y

	local var_11_0 = arg_11_0:vectorAdd(arg_11_0._beginDragPos, arg_11_0._dragDeltaPos)

	arg_11_0:setScenePosSafety(var_11_0)
end

function var_0_0.vectorAdd(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._tempVector

	var_12_0.x = arg_12_1.x + arg_12_2.x
	var_12_0.y = arg_12_1.y + arg_12_2.y

	return var_12_0
end

function var_0_0._changeMap(arg_13_0, arg_13_1)
	if arg_13_0._sceneUrl == arg_13_1 then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.MapLoadFinish, arg_13_0._sceneGo)
		CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene)

		return
	end

	if not arg_13_0._oldMapLoader and arg_13_0._sceneGo then
		arg_13_0._oldMapLoader = arg_13_0._mapLoader
		arg_13_0._oldSceneGo = arg_13_0._sceneGo
		arg_13_0._mapLoader = nil
	end

	if arg_13_0._mapLoader then
		arg_13_0._mapLoader:dispose()

		arg_13_0._mapLoader = nil
	end

	arg_13_0._mapLoader = MultiAbLoader.New()
	arg_13_0._sceneUrl = arg_13_1

	arg_13_0._mapLoader:addPath(arg_13_0._sceneUrl)
	arg_13_0._mapLoader:startLoad(arg_13_0._loadSceneFinish, arg_13_0)
end

function var_0_0._loadSceneFinish(arg_14_0)
	arg_14_0:_disposeOldMap()

	local var_14_0 = arg_14_0._sceneUrl
	local var_14_1 = arg_14_0._mapLoader:getAssetItem(var_14_0):GetResource(var_14_0)

	arg_14_0._sceneGo = gohelper.clone(var_14_1, arg_14_0._sceneRoot)
	arg_14_0._sceneTrans = arg_14_0._sceneGo.transform

	CommandStationMapModel.instance:setSceneGo(arg_14_0._sceneGo)
	MainCameraMgr.instance:addView(arg_14_0.viewName, arg_14_0._initCamera, arg_14_0._resetCamera, arg_14_0)
	MainCameraMgr.instance:setCloseViewFinishReset(arg_14_0.viewName, true)
	arg_14_0:_initScene()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MapLoadFinish, arg_14_0._sceneGo)
end

function var_0_0.getSceneGo(arg_15_0)
	return arg_15_0._sceneGo
end

function var_0_0._setBlur(arg_16_0, arg_16_1)
	arg_16_0._blurOriginalParam = arg_16_0._blurOriginalParam or {
		dofFactor = PostProcessingMgr.instance:getUnitPPValue("dofFactor"),
		dofDistance = PostProcessingMgr.instance:getUnitPPValue("dofDistance"),
		dofSampleScale = PostProcessingMgr.instance:getUnitPPValue("dofSampleScale"),
		dofRT1Scale = PostProcessingMgr.instance:getUnitPPValue("dofRT1Scale"),
		dofRT2Scale = PostProcessingMgr.instance:getUnitPPValue("dofRT2Scale"),
		dofRT3Scale = PostProcessingMgr.instance:getUnitPPValue("dofRT3Scale"),
		dofTotalScale = PostProcessingMgr.instance:getUnitPPValue("dofTotalScale"),
		rolesStoryMaskActive = PostProcessingMgr.instance:getUnitPPValue("rolesStoryMaskActive"),
		bloomActive = PostProcessingMgr.instance:getUnitPPValue("bloomActive")
	}

	if arg_16_1 then
		if arg_16_0._tweenFactorFinish then
			PostProcessingMgr.instance:setUnitPPValue("dofFactor", 1)
		end

		PostProcessingMgr.instance:setUnitPPValue("dofDistance", 0)
		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4(0.1, 0.1, 2, 0))
		PostProcessingMgr.instance:setUnitPPValue("dofRT1Scale", 1)
		PostProcessingMgr.instance:setUnitPPValue("dofRT2Scale", 1)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
		PostProcessingMgr.instance:setUnitPPValue("dofTotalScale", 1)
		PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", false)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	else
		if not arg_16_0._blurOriginalParam then
			return
		end

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_16_0._blurOriginalParam.dofFactor)
		PostProcessingMgr.instance:setUnitPPValue("dofDistance", arg_16_0._blurOriginalParam.dofDistance)
		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", arg_16_0._blurOriginalParam.dofSampleScale)
		PostProcessingMgr.instance:setUnitPPValue("dofRT1Scale", arg_16_0._blurOriginalParam.dofRT1Scale)
		PostProcessingMgr.instance:setUnitPPValue("dofRT2Scale", arg_16_0._blurOriginalParam.dofRT2Scale)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", arg_16_0._blurOriginalParam.dofRT3Scale)
		PostProcessingMgr.instance:setUnitPPValue("dofTotalScale", arg_16_0._blurOriginalParam.dofTotalScale)
		PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", arg_16_0._blurOriginalParam.rolesStoryMaskActive)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", arg_16_0._blurOriginalParam.bloomActive)

		arg_16_0._blurOriginalParam = nil
	end
end

function var_0_0._initCamera(arg_17_0)
	if arg_17_0._sceneVisible == false then
		return
	end

	arg_17_0._targetOrghographic = false
	arg_17_0._targetFov = var_0_0.getFov(CommandStationEnum.CameraFov)
	arg_17_0._targetPosZ = -7.5
	arg_17_0._targetRotation = CommandStationEnum.CameraRotation + 360

	local var_17_0 = CameraMgr.instance:getMainCamera()

	var_17_0.orthographic = arg_17_0._targetOrghographic
	var_17_0.fieldOfView = arg_17_0._targetFov

	local var_17_1 = CameraMgr.instance:getCameraTraceGO()

	transformhelper.setLocalPos(var_17_1.transform, 0, 0, arg_17_0._targetPosZ)
	transformhelper.setLocalRotation(var_17_1.transform, arg_17_0._targetRotation, 0, 0)
	arg_17_0:_setBlur(true)
end

function var_0_0.getFov(arg_18_0)
	local var_18_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local var_18_1, var_18_2 = SettingsModel.instance:getCurrentScreenSize()

		var_18_0 = 16 * var_18_2 / 9 / var_18_1
	end

	return arg_18_0 * var_18_0
end

function var_0_0._resetCamera(arg_19_0)
	arg_19_0:_doScreenResize()
	arg_19_0:_setBlur(false)
end

function var_0_0._doScreenResize(arg_20_0)
	local var_20_0, var_20_1 = GameGlobalMgr.instance:getScreenState():getScreenSize()

	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, var_20_0, var_20_1)
end

function var_0_0._initScene(arg_21_0)
	if arg_21_0._sceneVisible == false then
		return
	end

	local var_21_0 = gohelper.findChild(arg_21_0._sceneGo, "root/size")
	local var_21_1 = var_21_0 and var_21_0:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	if var_21_1 then
		arg_21_0._mapSize = var_21_1.size
	else
		logError(string.format("CommandStationMapSceneView _initScene scene:%s 的root/size 缺少 BoxCollider,请联系地编处理", arg_21_0._sceneUrl))

		arg_21_0._mapSize = Vector2()
	end

	local var_21_2 = arg_21_0._mapSize.x
	local var_21_3 = arg_21_0._mapSize.y
	local var_21_4 = CameraMgr.instance:getMainCamera()
	local var_21_5 = UnityEngine.Screen.width
	local var_21_6 = UnityEngine.Screen.height
	local var_21_7 = Vector3(0, var_21_6, 0)
	local var_21_8 = Vector3(var_21_5, 0, 0)
	local var_21_9 = Vector3.forward
	local var_21_10 = Vector3.zero
	local var_21_11 = arg_21_0:_getRayPlaneIntersection(var_21_4:ScreenPointToRay(var_21_7), var_21_9, var_21_10)
	local var_21_12 = arg_21_0:_getRayPlaneIntersection(var_21_4:ScreenPointToRay(var_21_8), var_21_9, var_21_10)

	arg_21_0._viewWidth = math.abs(var_21_12.x - var_21_11.x)
	arg_21_0._viewHeight = math.abs(var_21_12.y - var_21_11.y)
	arg_21_0._halfViewWidth = arg_21_0._viewWidth / 2
	arg_21_0._halfViewHeight = arg_21_0._viewHeight / 2

	local var_21_13 = arg_21_0._sceneRoot.transform.position
	local var_21_14 = 1
	local var_21_15 = -1
	local var_21_16 = 1
	local var_21_17 = -1

	arg_21_0._mapMinX = var_21_11.x - (var_21_2 - arg_21_0._viewWidth) - var_21_13.x + var_21_14
	arg_21_0._mapMaxX = var_21_11.x - var_21_13.x + var_21_15
	arg_21_0._mapMinY = var_21_11.y - var_21_13.y + var_21_16
	arg_21_0._mapMaxY = var_21_11.y + (var_21_3 - arg_21_0._viewHeight) - var_21_13.y + var_21_17

	local var_21_18 = arg_21_0._sceneConfig.leftUpRange
	local var_21_19 = arg_21_0._sceneConfig.rightDownRange
	local var_21_20 = -var_21_19[1] + arg_21_0._halfViewWidth
	local var_21_21 = -var_21_18[1] - arg_21_0._halfViewWidth
	local var_21_22 = -var_21_18[2] + arg_21_0._halfViewHeight
	local var_21_23 = -var_21_19[2] - arg_21_0._halfViewHeight

	arg_21_0._dragMapMinX = math.min(var_21_20, var_21_21)
	arg_21_0._dragMapMaxX = math.max(var_21_20, var_21_21)
	arg_21_0._dragMapMinY = math.min(var_21_22, var_21_23)
	arg_21_0._dragMapMaxY = math.max(var_21_22, var_21_23)

	arg_21_0:_setInitPos()
end

function var_0_0._getRayPlaneIntersection(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_1.origin
	local var_22_1 = arg_22_1.direction
	local var_22_2 = Vector3.Dot(var_22_1, arg_22_2)

	return var_22_0 + var_22_1 * (Vector3.Dot(arg_22_3 - var_22_0, arg_22_2) / var_22_2)
end

function var_0_0._getInitPos(arg_23_0)
	return "-8#4"
end

function var_0_0._setInitPos(arg_24_0, arg_24_1)
	if not arg_24_0._sceneTrans then
		return
	end

	if arg_24_0._targetPos then
		arg_24_0:setScenePosSafety(arg_24_0._targetPos, arg_24_1, arg_24_0._skipInBoundary)

		return
	end

	local var_24_0 = arg_24_0:_getInitPos()
	local var_24_1 = string.splitToNumber(var_24_0, "#")

	arg_24_0:setScenePosSafety(Vector3(var_24_1[1], var_24_1[2], 0), arg_24_1)
end

function var_0_0._getMapInfo(arg_25_0, arg_25_1)
	if arg_25_1 then
		return arg_25_0._mapMinX, arg_25_0._mapMinY, arg_25_0._mapMaxX, arg_25_0._mapMaxY
	else
		return arg_25_0._dragMapMinX, arg_25_0._dragMapMinY, arg_25_0._dragMapMaxX, arg_25_0._dragMapMaxY
	end
end

function var_0_0.setScenePosSafety(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if not arg_26_0._sceneTrans then
		return
	end

	arg_26_0._skipInBoundary = arg_26_3

	local var_26_0, var_26_1, var_26_2, var_26_3 = arg_26_0:_getMapInfo(arg_26_3)

	arg_26_1.x = Mathf.Clamp(arg_26_1.x, var_26_0, var_26_2)
	arg_26_1.y = Mathf.Clamp(arg_26_1.y, var_26_1, var_26_3)
	arg_26_0._targetPos = arg_26_1

	if arg_26_0._tweenId then
		ZProj.TweenHelper.KillById(arg_26_0._tweenId)

		arg_26_0._tweenId = nil
	end

	if arg_26_2 then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene, true)

		local var_26_4 = arg_26_0._tweenTime or 0.6

		arg_26_0._tweenTime = nil

		UIBlockHelper.instance:startBlock("CommandStationMapSceneView", var_26_4, arg_26_0.viewName)

		arg_26_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_26_0._sceneTrans, arg_26_1.x, arg_26_1.y, 0, var_26_4, arg_26_0._localMoveDone, arg_26_0, nil, EaseType.InOutCubic)
	else
		arg_26_0._sceneTrans.localPosition = arg_26_1

		CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene)
	end
end

function var_0_0._localMoveDone(arg_27_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene)
end

function var_0_0.setSceneVisible(arg_28_0, arg_28_1)
	arg_28_0._sceneVisible = arg_28_1

	gohelper.setActive(arg_28_0._sceneRoot, arg_28_1 and true or false)
	arg_28_0:_setBlur(arg_28_1)
	arg_28_0:_doScreenResize()
end

function var_0_0.onOpen(arg_29_0)
	arg_29_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_29_0._onScreenResize, arg_29_0, LuaEventSystem.Low)
	arg_29_0:addEventCb(CommandStationController.instance, CommandStationEvent.SelectTimePoint, arg_29_0._onSelectTimePoint, arg_29_0)
	arg_29_0:addEventCb(CommandStationController.instance, CommandStationEvent.SceneFocusPos, arg_29_0._onSceneFocusPos, arg_29_0)
	arg_29_0:addEventCb(CommandStationController.instance, CommandStationEvent.RTGoHide, arg_29_0._onRTGoHide, arg_29_0)
	arg_29_0:addEventCb(PostProcessingMgr.instance, PostProcessingEvent.onUnitCameraVisibleChange, arg_29_0._onUnitCameraVisibleChange, arg_29_0, LuaEventSystem.Low)
	arg_29_0:addEventCb(ViewMgr.instance, ViewEvent.BeforeOpenView, arg_29_0._onBeforeOpenView, arg_29_0)
	arg_29_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_29_0._onReOpenWhileOpen, arg_29_0)
	arg_29_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_29_0._OnCloseView, arg_29_0)
	arg_29_0:_showTimeId(CommandStationMapModel.instance:getTimeId())
	TaskDispatcher.runRepeat(arg_29_0._protectedCamera, arg_29_0, 0)
end

function var_0_0._protectedCamera(arg_30_0)
	if arg_30_0._sceneVisible == false or not arg_30_0._sceneGo then
		return
	end

	local var_30_0 = CameraMgr.instance:getMainCamera()
	local var_30_1 = CameraMgr.instance:getCameraTraceGO()
	local var_30_2 = transformhelper.getLocalRotation(var_30_1.transform)
	local var_30_3, var_30_4, var_30_5 = transformhelper.getLocalPos(var_30_1.transform)

	if var_30_0.orthographic ~= arg_30_0._targetOrghographic or var_30_5 ~= arg_30_0._targetPosZ or var_30_2 ~= arg_30_0._targetRotation then
		arg_30_0:_initCamera()
		logError(string.format("CommandStationMapSceneView camera is not right:%s, %s, %s", var_30_0.orthographic, var_30_5, var_30_2))
	end
end

function var_0_0._onRTGoHide(arg_31_0)
	arg_31_0._tweenFactor = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_31_0._tweenUpdate, arg_31_0._tweenFinish, arg_31_0)
end

function var_0_0._tweenUpdate(arg_32_0, arg_32_1)
	if not arg_32_0._blurOriginalParam then
		return
	end

	PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_32_1)
end

function var_0_0._tweenFinish(arg_33_0)
	arg_33_0._tweenFactorFinish = true
end

function var_0_0.onOpenFinish(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._protectedCamera, arg_34_0)
end

function var_0_0._onUnitCameraVisibleChange(arg_35_0, arg_35_1)
	if not arg_35_1 and arg_35_0._blurOriginalParam and arg_35_0._sceneVisible ~= false then
		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	end
end

function var_0_0._OnCloseView(arg_36_0, arg_36_1)
	if ViewMgr.instance:isFull(arg_36_1) and ViewHelper.instance:checkViewOnTheTop(arg_36_0.viewName) then
		arg_36_0._sceneVisible = true

		arg_36_0:_doScreenResize()
	end
end

function var_0_0._onBeforeOpenView(arg_37_0, arg_37_1)
	if arg_37_1 == ViewName.StoreView then
		return
	end

	if ViewMgr.instance:isFull(arg_37_1) and arg_37_1 ~= arg_37_0.viewName then
		arg_37_0.viewContainer:setVisibleInternal(false)
	end
end

function var_0_0._onReOpenWhileOpen(arg_38_0, arg_38_1)
	if arg_38_0.viewName == arg_38_1 then
		ViewMgr.instance:closeView(ViewName.CommandStationDispatchEventMainView)

		return
	end

	if ViewMgr.instance:isFull(arg_38_1) and arg_38_1 ~= arg_38_0.viewName then
		arg_38_0.viewContainer:setVisibleInternal(false)
	end
end

function var_0_0._onSceneFocusPos(arg_39_0, arg_39_1, arg_39_2)
	arg_39_1.x = -arg_39_1.x
	arg_39_1.y = -arg_39_1.y - 0.5
	arg_39_1.z = 0

	arg_39_0:setScenePosSafety(arg_39_1, true, not arg_39_2)
end

function var_0_0._onSelectTimePoint(arg_40_0, arg_40_1)
	arg_40_0:_showTimeId(arg_40_1)
end

function var_0_0._showTimeId(arg_41_0, arg_41_1)
	if not arg_41_1 then
		return
	end

	if arg_41_0._timeId == arg_41_1 then
		return
	end

	arg_41_0._timeId = arg_41_1

	CommandStationMapModel.instance:setTimeId(arg_41_1)

	local var_41_0 = CommandStationMapModel.instance:getCurTimeIdScene()

	if not var_41_0 then
		return
	end

	arg_41_0._sceneConfig = var_41_0

	local var_41_1 = var_41_0.scene

	arg_41_0:_changeMap(var_41_1)
end

function var_0_0._onScreenResize(arg_42_0)
	if arg_42_0._sceneGo then
		arg_42_0:_initScene()
	end
end

function var_0_0._disposeOldMap(arg_43_0)
	if arg_43_0._oldSceneGo then
		gohelper.destroy(arg_43_0._oldSceneGo)

		arg_43_0._oldSceneGo = nil
	end

	if arg_43_0._oldMapLoader then
		arg_43_0._oldMapLoader:dispose()

		arg_43_0._oldMapLoader = nil
	end
end

function var_0_0.onClose(arg_44_0)
	arg_44_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_44_0._onScreenResize, arg_44_0)
	arg_44_0._drag:RemoveDragBeginListener()
	arg_44_0._drag:RemoveDragListener()
	arg_44_0._drag:RemoveDragEndListener()
	CommandStationMapModel.instance:clearSceneInfo()
	TaskDispatcher.cancelTask(arg_44_0._protectedCamera, arg_44_0)

	if arg_44_0._tweenFactor then
		ZProj.TweenHelper.KillById(arg_44_0._tweenFactor)

		arg_44_0._tweenFactor = nil
	end

	if arg_44_0._tweenId then
		ZProj.TweenHelper.KillById(arg_44_0._tweenId)

		arg_44_0._tweenId = nil
	end
end

function var_0_0.onCloseFinish(arg_45_0)
	return
end

function var_0_0.onDestroyView(arg_46_0)
	gohelper.destroy(arg_46_0._sceneRoot)

	if arg_46_0._mapLoader then
		arg_46_0._mapLoader:dispose()
	end

	arg_46_0:_disposeOldMap()
end

return var_0_0
