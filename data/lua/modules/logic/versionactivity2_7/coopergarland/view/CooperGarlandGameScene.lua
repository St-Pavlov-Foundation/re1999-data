module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandGameScene", package.seeall)

slot0 = class("CooperGarlandGameScene", BaseView)
slot1 = 0.83
slot2 = 1.8

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.ChangePanelAngle, slot0._onChangePanelAngle, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, slot0._onPlayEnterNextRoundAnim, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, slot0._onRemoveModeChange, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, slot0._onResetGame, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
end

function slot0.removeEvents(slot0)
	if slot0._panelAnimEvent then
		slot0._panelAnimEvent:RemoveEventListener("panelIn")
	end

	if slot0._sceneAnimEvent then
		slot0._sceneAnimEvent:RemoveEventListener("showBall")
	end

	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.ChangePanelAngle, slot0._onChangePanelAngle, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, slot0._onPlayEnterNextRoundAnim, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, slot0._onRemoveModeChange, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, slot0._onResetGame, slot0)
	slot0:removeEventCb(GuideController.instance, GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
end

function slot0._onChangePanelAngle(slot0, slot1, slot2, slot3, slot4)
	if gohelper.isNil(slot0._transCube) then
		return
	end

	if not slot4 and (CooperGarlandGameModel.instance:getIsStopGame() or GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() or not CooperGarlandGameModel.instance:getSceneOpenAnimShowBall()) then
		return
	end

	TaskDispatcher.cancelTask(slot0._lerpRotation, slot0)

	if slot3 and slot3 > 0 then
		slot0._targetLerpAngle = {
			x = slot2 * slot0._cubeMaxAngle,
			y = -slot1 * slot0._cubeMaxAngle,
			lerpScale = slot3
		}

		TaskDispatcher.runRepeat(slot0._lerpRotation, slot0, 0.01)
	else
		transformhelper.setLocalRotation(slot0._transCube, slot10, slot11, 0)
	end
end

function slot0._lerpRotation(slot0)
	slot1, slot2 = transformhelper.getLocalRotation(slot0._transCube)
	slot3 = slot0._targetLerpAngle and slot0._targetLerpAngle.x
	slot4 = slot0._targetLerpAngle and slot0._targetLerpAngle.y

	if not slot0._targetLerpAngle or slot1 == slot3 and slot2 == slot4 then
		slot0._targetLerpAngle = nil

		TaskDispatcher.cancelTask(slot0._lerpRotation, slot0)

		return
	end

	transformhelper.setLocalRotationLerp(slot0._transCube, slot3, slot4, 0, Time.deltaTime * slot0._targetLerpAngle.lerpScale)
end

function slot0._onPlayEnterNextRoundAnim(slot0)
	slot1 = false

	if slot0._sceneAnimator then
		slot0._sceneAnimator:Play("switch", 0, 0)

		slot1 = true

		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_pkls_star_light)
	end

	if not string.nilorempty(CooperGarlandConfig.instance:getCubeSwitchAnim(CooperGarlandGameModel.instance:getGameId())) and slot0._cubeAnimator and slot0._cubeAnimatorPlayer then
		TaskDispatcher.cancelTask(slot0._playCubeSwitchAnim, slot0)
		TaskDispatcher.runDelay(slot0._playCubeSwitchAnim, slot0, uv0)

		slot1 = true
	end

	if slot1 then
		TaskDispatcher.cancelTask(CooperGarlandController.enterNextRound, CooperGarlandController.instance)
		TaskDispatcher.runDelay(CooperGarlandController.enterNextRound, CooperGarlandController.instance, uv1)
	else
		CooperGarlandController.instance:enterNextRound()
	end

	slot0:refresh()
end

function slot0._playCubeSwitchAnim(slot0)
	slot0._cubeAnimator.enabled = true

	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_cube_turn)
	slot0._cubeAnimatorPlayer:Play(CooperGarlandConfig.instance:getCubeSwitchAnim(CooperGarlandGameModel.instance:getGameId()), slot0._playCubeAnimFinished, slot0)
end

function slot0._onRemoveModeChange(slot0)
	slot0:refresh()
end

function slot0._onResetGame(slot0)
	slot0:refresh()
end

function slot0._onFinishGuide(slot0, slot1)
	if CooperGarlandConfig.instance:getStoryCompId(CooperGarlandGameModel.instance:getMapId(), slot1) then
		CooperGarlandGameEntityMgr.instance:removeComp(slot3)
		CooperGarlandController.instance:setStopGame(false)
	end
end

function slot0._editableInitView(slot0)
	slot0._targetLerpAngle = nil
	slot0._originalFOV = nil
	slot0._cubeMaxAngle = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CubeMaxAngle, true)
	slot0._originalGravity = UnityEngine.Physics.gravity
	UnityEngine.Physics.gravity = Vector3.New(0, 0, CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.Gravity, true))

	slot0:createScene()
	MainCameraMgr.instance:addView(slot0.viewName, slot0.initCamera, nil, slot0)
end

function slot0.initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot2 = CameraMgr.instance:getMainCameraTrs()

	if not slot0._originalFOV then
		slot0._originalFOV = slot1.fieldOfView
	end

	slot3 = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CameraFOV, true)
	slot1.fieldOfView = Mathf.Clamp(slot3 * 1.7777777777777777 * UnityEngine.Screen.height / UnityEngine.Screen.width, slot3, CooperGarlandEnum.Const.CameraMaxFov)

	transformhelper.setLocalPos(slot2, 0, 0, CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CameraPosZ, true))
	transformhelper.setLocalRotation(slot2, 0, 0, 0)
end

function slot0.createScene(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New(slot0.__cname)

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)

	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)

	if slot0._loader then
		slot0._loader:dispose()
	end

	slot0._loader = PrefabInstantiate.Create(slot0._sceneRoot)

	if not string.nilorempty(CooperGarlandConfig.instance:getScenePath(CooperGarlandGameModel.instance:getGameId())) then
		UIBlockMgr.instance:startBlock(CooperGarlandEnum.BlockKey.LoadGameSceneRes)
		slot0._loader:startLoad(slot7, slot0._onLoadSceneFinish, slot0)
	end
end

function slot0._onLoadSceneFinish(slot0)
	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameSceneRes)

	if not slot0._loader then
		return
	end

	slot0._sceneGo = slot0._loader:getInstGO()
	slot0._sceneAnimator = slot0._sceneGo:GetComponent(typeof(UnityEngine.Animator))
	slot0._sceneAnimEvent = slot0._sceneGo:GetComponent(gohelper.Type_AnimationEventWrap)

	slot0._sceneAnimEvent:AddEventListener("showBall", slot0._onShowBall, slot0)

	slot0._cubeGo = gohelper.findChild(slot0._sceneGo, "#go_cube")
	slot0._transCube = slot0._cubeGo.transform
	slot0._cubeAnimator = slot0._cubeGo:GetComponent(typeof(UnityEngine.Animator))
	slot0._cubeAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._cubeGo)
	slot2 = string.splitToNumber(CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CubePos), "#")

	transformhelper.setLocalPos(slot0._transCube, slot2[1], slot2[2], slot2[3])

	slot0._uiNode = gohelper.findChild(slot0._sceneGo, "#go_cube/#go_ui")

	CooperGarlandGameEntityMgr.instance:tryInitMap(slot0._uiNode, gohelper.findChild(slot0._sceneGo, "#go_cube/#go_ball"), slot0._onInitMap, slot0)

	slot4 = "open"

	if slot0._cubeAnimatorPlayer and slot0._cubeAnimator then
		if string.nilorempty(CooperGarlandConfig.instance:getCubeOpenAnim(CooperGarlandGameModel.instance:getGameId())) then
			slot0:_playCubeAnimFinished()
		else
			slot4 = "open1"

			AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_cube_turn)
			slot0._cubeAnimatorPlayer:Play(slot6, slot0._playCubeAnimFinished, slot0)
		end
	end

	if slot0._sceneAnimator then
		slot0._sceneAnimator:Play(slot4, 0, 0)
	end
end

function slot0._onInitMap(slot0)
	if gohelper.isNil(CooperGarlandGameEntityMgr.instance:getPanelGo()) then
		return
	end

	slot0._panelCanvas = slot1:GetComponent(typeof(UnityEngine.Canvas))

	if CameraMgr.instance:getMainCamera() then
		slot0._panelCanvas.worldCamera = slot2
	end

	slot0._simgPanel = gohelper.findChildSingleImage(slot1, "")

	if slot0._simgPanel then
		slot0._simgPanel:LoadImage(CooperGarlandConfig.instance:getPanelImage(CooperGarlandGameModel.instance:getGameId()))
	end

	slot0._goRemoveModeMask = gohelper.findChild(slot1, "#go_removeModeMask")
	slot0._panelAnimEvent = slot1:GetComponent(gohelper.Type_AnimationEventWrap)

	slot0._panelAnimEvent:AddEventListener("panelIn", slot0._onPanelIn, slot0)
	slot0:refresh()
end

function slot0._playCubeAnimFinished(slot0)
	if slot0._cubeAnimator then
		slot0._cubeAnimator.enabled = false
	end
end

function slot0._onPanelIn(slot0)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_next)
end

function slot0._onShowBall(slot0)
	CooperGarlandGameModel.instance:setSceneOpenAnimShowBall(true)
	CooperGarlandGameEntityMgr.instance:resetBall()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.refresh(slot0)
	slot0:refreshRemoveModeMask()
end

function slot0.refreshRemoveModeMask(slot0)
	gohelper.setActive(slot0._goRemoveModeMask, CooperGarlandGameModel.instance:getIsRemoveMode())
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._lerpRotation, slot0)
	TaskDispatcher.cancelTask(slot0._playCubeSwitchAnim, slot0)
	TaskDispatcher.cancelTask(CooperGarlandController.enterNextRound, CooperGarlandController.instance)
end

function slot0.onDestroyView(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._simgPanel then
		slot0._simgPanel:UnLoadImage()
	end

	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end

	slot0:resetCamera()

	UnityEngine.Physics.gravity = slot0._originalGravity
	slot0._originalGravity = nil

	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameSceneRes)
end

slot3 = 35

function slot0.resetCamera(slot0)
	CameraMgr.instance:getMainCamera().fieldOfView = slot0._originalFOV or uv0

	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)

	slot0._originalFOV = nil
end

return slot0
