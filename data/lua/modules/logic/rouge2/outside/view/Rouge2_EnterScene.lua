﻿-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_EnterScene.lua

module("modules.logic.rouge2.outside.view.Rouge2_EnterScene", package.seeall)

local Rouge2_EnterScene = class("Rouge2_EnterScene", BaseView)

function Rouge2_EnterScene:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_EnterScene:_editableInitView()
	self._sceneGoList = {}
	self._sceneAnimatorList = {}
	self._sceneIndex = nil
	self._previousIndex = nil
	self._curveGo = nil
	self._previousDifficultyIndex = nil
	self._curDifficultyIndex = nil

	self:initRoot()
	self:initEnterScene()
	self:initCareerItem()
	self:initDifficultyItem()
end

function Rouge2_EnterScene:initRoot()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("Rouge2_EnterScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, 0, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)

	local resPath = self.viewContainer._viewSetting.otherRes[5]

	self._curveGoRoot = self:getResInst(resPath, self._sceneRoot, "curveGoRoot")
	self._curveAnimator = gohelper.findChildComponent(self._curveGoRoot, "", gohelper.Type_Animator)
	self._curveGo = gohelper.findChild(self._curveGoRoot, "curve")
	self._splineFollow = gohelper.findChildComponent(self._curveGo, "", typeof(ZProj.SplineFollow))

	for i = 1, Rouge2_OutsideEnum.SceneCount do
		self:loadScene(i)
	end
end

function Rouge2_EnterScene:initEnterScene()
	local sceneGo = self:getSceneGo(Rouge2_OutsideEnum.SceneIndex.EnterScene)
	local rightHandPath = self.viewContainer._viewSetting.otherRes[7]
	local leftHandPath = self.viewContainer._viewSetting.otherRes[12]

	self.leftHand = self:getResInst(leftHandPath, sceneGo, "leftHand")
	self.rightHand = self:getResInst(rightHandPath, sceneGo, "rightHand")

	transformhelper.setLocalPos(self.leftHand.transform, 13.5, -15.4, 12.08)
	transformhelper.setLocalPos(self.rightHand.transform, 13.5, -15.4, 12.08)
	transformhelper.setLocalScale(self.leftHand.transform, -0.6, 0.6, 0.6)
	transformhelper.setLocalScale(self.rightHand.transform, 0.6, 0.6, 0.6)

	self._spineList = self:getUserDataTb_()

	table.insert(self._spineList, self.leftHand)
	table.insert(self._spineList, self.rightHand)

	self._spineItemList = self:getUserDataTb_()

	for _, handGo in ipairs(self._spineList) do
		local item = gohelper.findChildComponent(handGo, "", typeof(Spine.Unity.SkeletonAnimation))

		table.insert(self._spineItemList, item)
	end
end

function Rouge2_EnterScene:initDifficultyItem()
	self._difficultyItemList = self:getUserDataTb_()

	local sceneGo = self:getSceneGo(Rouge2_OutsideEnum.SceneIndex.DifficultyScene)
	local itemParent = gohelper.findChild(sceneGo, "v3a2_m_s16_nandu/sence/StandStill/Obj-Plant/near").gameObject
	local constConfig = Rouge2_Config.instance:getConstCoById(Rouge2_Enum.ConstId.DifficultyIndexCount)
	local count = tonumber(constConfig.value)

	for i = 1, count do
		local itemGo = gohelper.findChild(itemParent, "nandu" .. tostring(i))

		table.insert(self._difficultyItemList, itemGo)

		local spinePath = self.viewContainer._viewSetting.otherRes[Rouge2_OutsideEnum.RoleSpineOffset + i]
		local childGo = gohelper.findChild(itemGo.gameObject, "m_s16_nandu_yuedui" .. tostring(i)).gameObject
		local spineGo = self:getResInst(spinePath, childGo, "spine" .. tostring(i))

		transformhelper.setLocalScale(spineGo.transform, 0.35, 0.35, 1)
	end

	local mainRoleParent = gohelper.findChild(itemParent, "juese")
	local mainSpinePath = self.viewContainer._viewSetting.otherRes[11]
	local mainRoleSpineGo = self:getResInst(mainSpinePath, mainRoleParent, "mainRole")

	transformhelper.setLocalScale(mainRoleSpineGo.transform, 0.12, 0.12, 1)

	local spine = gohelper.findChildComponent(mainRoleSpineGo, "", typeof(Spine.Unity.SkeletonAnimation))

	self._difficultyRoleSpine = spine
end

function Rouge2_EnterScene:initCareerItem()
	self._careerItemList = self:getUserDataTb_()

	local sceneGo = self:getSceneGo(Rouge2_OutsideEnum.SceneIndex.CareerScene)
	local itemParent = gohelper.findChild(sceneGo, "v3a2_m_s16_zhiye/sence/StandStill/Obj-Plant/near/zhiye").transform

	for i = 1, itemParent.childCount do
		local itemGo = itemParent:GetChild(i - 1)

		table.insert(self._careerItemList, itemGo)
	end
end

function Rouge2_EnterScene:addEvents()
	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
	self:addEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SceneSwitch, self.onSceneSwitch, self)
	self:addEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.BackEnterScene, self.backEnterScene, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSwitchDifficultyPage, self._onSwitchDifficultyPage, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSelectCareer, self._onSelectCareer, self)
end

function Rouge2_EnterScene:removeEvents()
	self:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
	self:removeEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SceneSwitch, self.onSceneSwitch, self)
	self:removeEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.BackEnterScene, self.backEnterScene, self)
	self:removeEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSwitchDifficultyPage, self._onSwitchDifficultyPage, self)
	self:removeEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSelectCareer, self._onSelectCareer, self)
end

function Rouge2_EnterScene:playAnim(animator, animName)
	local id = UnityEngine.Animator.StringToHash(animName)

	if animator and animator:HasState(0, id) then
		animator:Play(animName, 0, 0)
	end
end

function Rouge2_EnterScene:onOpen()
	CameraMgr.instance:switchVirtualCamera(1)

	local virtualCameraGo = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(virtualCameraGo, true)

	local cameraRoot = CameraMgr.instance:getCameraTraceGO()

	self.cameraPosition = cameraRoot.transform.localPosition

	self._splineFollow:Add(cameraRoot.transform, 0)

	local fov = self:_calcFovInternal()
	local virtualCamera = CameraMgr.instance:getVirtualCamera(1, 1)
	local old = virtualCamera.m_Lens

	virtualCamera.m_Lens = Cinemachine.LensSettings.New(fov, old.OrthographicSize, old.NearClipPlane, old.FarClipPlane, old.Dutch)
end

function Rouge2_EnterScene:onSceneSwitch(sceneIndex)
	if sceneIndex == nil then
		return
	end

	self:switchScene(sceneIndex)
end

function Rouge2_EnterScene:backEnterScene(sceneIndex)
	self._previousIndex = nil
	self._sceneIndex = sceneIndex

	self:stopMoveSceneNode(sceneIndex)

	for index, sceneGo in ipairs(self._sceneGoList) do
		local active = index == self._sceneIndex

		gohelper.setActive(sceneGo, active)
	end

	local delayTime = Rouge2_OutsideEnum.SceneOpenDelay[self._sceneIndex] or 0.01

	if sceneIndex == Rouge2_OutsideEnum.SceneIndex.EnterScene then
		self:_lockScreen(true, Rouge2_OutsideEnum.ForceCloseMaskTime)
		self:playHandSpineAnim("rouge2_hand1")
		TaskDispatcher.runDelay(self.onEnterSceneFinish, self, delayTime)
	else
		local animator = self._sceneAnimatorList[sceneIndex]
		local animName = Rouge2_EnterScene.getSwitchInName(sceneIndex)

		if animator and animator:HasState(0, UnityEngine.Animator.StringToHash(animName)) then
			animator.enabled = true

			animator:Play(animName, 0, 1)
			logNormal("rouge2 play scene in Anim" .. animName)
		end

		Rouge2_Controller.instance:openMainView()
	end
end

function Rouge2_EnterScene:switchScene(sceneIndex)
	logNormal("3.2肉鸽 开始切换场景 .. index:" .. sceneIndex)

	if not self._sceneGoList[sceneIndex] then
		self:loadScene(sceneIndex)
	end

	self._previousIndex = self._sceneIndex
	self._sceneIndex = sceneIndex

	for index, sceneGo in ipairs(self._sceneGoList) do
		local active = index == sceneIndex or index == self._previousIndex

		gohelper.setActive(sceneGo, active)
	end

	local skipScene = self:checkSkipScene()
	local delayTime = Rouge2_OutsideEnum.SceneOpenDelay[self._sceneIndex] or 0.01

	if skipScene then
		self:_lockScreen(true, Rouge2_OutsideEnum.ForceCloseMaskTime)
		ViewMgr.instance:openView(ViewName.Rouge2_SwitchView)
		TaskDispatcher.runDelay(self.onSwitchOpenFinish, self, Rouge2_OutsideEnum.SwitchViewOpenTime)
	elseif self._sceneIndex == Rouge2_OutsideEnum.SceneIndex.EnterScene then
		self:startMoveSceneNode(self._previousIndex)
		self:_lockScreen(true, Rouge2_OutsideEnum.ForceCloseMaskTime)
		TaskDispatcher.runDelay(self.onEnterSceneFinish, self, delayTime)
		self:playHandSpineAnim("rouge2_hand1")
	else
		self:switchOut()
		self:startMoveSceneNode(self._previousIndex)
		self:_lockScreen(true, Rouge2_OutsideEnum.ForceCloseMaskTime)
		TaskDispatcher.cancelTask(self.switchIn, self)
		TaskDispatcher.runDelay(self.switchIn, self, delayTime)
	end
end

function Rouge2_EnterScene:onSwitchOpenFinish()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onSwitchOpenFinish, self)

	local delayTime = Rouge2_OutsideEnum.SceneOpenDelay[self._sceneIndex] or 0.01

	self:switchOut()
	self:stopMoveSceneNode(self._sceneIndex)
	TaskDispatcher.cancelTask(self.switchIn, self)
	TaskDispatcher.runDelay(self.switchIn, self, delayTime)
end

function Rouge2_EnterScene:checkSkipScene()
	if self._previousIndex and self._sceneIndex and self._sceneIndex > self._previousIndex then
		return self._sceneIndex - self._previousIndex > 1
	end

	return false
end

function Rouge2_EnterScene:playHandSpineAnim(name)
	for _, item in ipairs(self._spineItemList) do
		item:PlayAnim(name, false, true)
	end
end

function Rouge2_EnterScene:onEnterSceneFinish()
	logNormal("3.2肉鸽 进入开始场景")
	self:_lockScreen(false)
	TaskDispatcher.cancelTask(self.onEnterSceneFinish, self)
end

Rouge2_EnterScene.UIMaskName = "Rouge2_EnterScene_Mask"

function Rouge2_EnterScene:switchIn()
	local index = self._sceneIndex

	logNormal("3.2肉鸽 切换场景完成 index:" .. index)

	local animator = self._sceneAnimatorList[index]
	local skipScene = self:checkSkipScene()

	if animator then
		local animName = Rouge2_EnterScene.getSwitchInName(index)

		if animator and animator:HasState(0, UnityEngine.Animator.StringToHash(animName)) then
			animator.enabled = true

			local time = skipScene and 0 or 0

			animator:Play(animName, 0, time)
			logNormal("rouge2 play scene in Anim" .. animName)
		end
	end

	self:_lockScreen(false)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.SceneSwitchFinish)
end

function Rouge2_EnterScene.getPathName(index)
	if index == nil then
		return "enter"
	end

	if index == Rouge2_OutsideEnum.SceneIndex.CareerScene then
		return "leave"
	end

	return string.format("path%s", index)
end

function Rouge2_EnterScene.getPathIdleName(index)
	return string.format("00%s_idle", index)
end

function Rouge2_EnterScene.getSwitchInName(index)
	return string.format("in", index)
end

function Rouge2_EnterScene.getSwitchOutName(index)
	return string.format("out", index)
end

function Rouge2_EnterScene:switchOut()
	local index = self._sceneIndex

	logNormal("3.2肉鸽 切换场景完成 index:" .. index)

	local nextAnimator = self._sceneAnimatorList[index]

	if nextAnimator and nextAnimator then
		logNormal("stop animator")

		nextAnimator.enabled = false
	end

	index = self._previousIndex

	if index then
		if index == Rouge2_OutsideEnum.SceneIndex.EnterScene then
			self:playHandSpineAnim("rouge2_hand2")
		else
			local animName = Rouge2_EnterScene.getSwitchOutName(index)
			local animator = self._sceneAnimatorList[index]
			local id = UnityEngine.Animator.StringToHash(animName)

			if animator and animator:HasState(0, id) then
				animator:Play(animName, 0, 0)
				logNormal("rouge2 play scene out Anim: " .. animName)
			end

			if index == Rouge2_OutsideEnum.SceneIndex.DifficultyScene then
				local spineName = string.format("%s_front2side", self._curDifficultyIndex)

				logNormal("rouge2 play Difficulty out Anim:  " .. spineName)
				self._difficultyRoleSpine:PlayAnim(spineName, false, true)
			end
		end
	end
end

function Rouge2_EnterScene:startMoveSceneNode(index)
	local animName = self.getPathName(index)
	local animator = self._curveAnimator
	local id = UnityEngine.Animator.StringToHash(animName)

	if animator and animator:HasState(0, id) then
		animator:Play(animName, 0, 0)
	end
end

function Rouge2_EnterScene:stopMoveSceneNode(index)
	if index then
		local animName = self.getPathIdleName(index)
		local animator = self._curveAnimator

		if animator and animator:HasState(0, UnityEngine.Animator.StringToHash(animName)) then
			animator:Play(animName, 0, 1)
		end
	end
end

function Rouge2_EnterScene:loadScene(sceneIndex)
	local resPath = self.viewContainer._viewSetting.otherRes[sceneIndex]
	local instanceGo = self:getResInst(resPath, self._curveGo, "scene_" .. sceneIndex)

	self._sceneGoList[sceneIndex] = instanceGo

	local animatorGo = instanceGo.transform:GetChild(0).gameObject
	local animator = gohelper.findChildComponent(animatorGo, "", gohelper.Type_Animator)

	self._sceneAnimatorList[sceneIndex] = animator

	return instanceGo
end

function Rouge2_EnterScene:_onSwitchDifficultyPage(difficultyIndex)
	if self._sceneIndex ~= Rouge2_OutsideEnum.SceneIndex.DifficultyScene then
		return
	end

	local showAnim = self._curDifficultyIndex ~= nil
	local bgIndex = difficultyIndex

	if self._curDifficultyIndex and self._curDifficultyIndex == bgIndex then
		return
	end

	self._previousDifficultyIndex = self._curDifficultyIndex
	self._curDifficultyIndex = bgIndex

	if self._curDifficultyIndex == nil then
		return
	end

	local animator = self._sceneAnimatorList[Rouge2_OutsideEnum.SceneIndex.DifficultyScene]

	if showAnim then
		logNormal("肉鸽2 开始切换难度")
		self:playAnim(animator, string.format("%sto%s", self._previousDifficultyIndex, bgIndex))
		TaskDispatcher.cancelTask(self.onDifficultySwitchFinish, self)
		TaskDispatcher.runDelay(self.onDifficultySwitchFinish, self, Rouge2_OutsideEnum.DifficultyChangeTime)

		local isPlayBack = self._previousDifficultyIndex > self._curDifficultyIndex
		local spineName

		if isPlayBack then
			spineName = string.format("role%sturn%s", self._curDifficultyIndex, self._previousDifficultyIndex)
		else
			spineName = string.format("role%sturn%s", self._previousDifficultyIndex, self._curDifficultyIndex)
		end

		if self._difficultyRoleSpine:HasAnimation(spineName) then
			if isPlayBack then
				self._difficultyRoleSpine.timeScale = 0.5

				self._difficultyRoleSpine:PlayAnim(string.format("%s_idle", self._curDifficultyIndex), true, true)
			else
				self._difficultyRoleSpine:PlayAnim(spineName, false, true)
			end
		else
			logError("肉鸽2 角色Spine缺少难度转换动画: " .. spineName)
		end

		TaskDispatcher.cancelTask(self.onDifficultySpineSwitchFinish, self)
		TaskDispatcher.runDelay(self.onDifficultySpineSwitchFinish, self, Rouge2_OutsideEnum.DifficultyChangeTime)
	else
		logNormal("肉鸽2 无需切换难度")
		self:playAnim(animator, string.format("%sidle", bgIndex))

		for index, itemGo in ipairs(self._difficultyItemList) do
			gohelper.setActive(itemGo, index == self._curDifficultyIndex)
		end

		self._difficultyRoleSpine:PlayAnim(string.format("%s_idle", bgIndex), true, true)
	end
end

function Rouge2_EnterScene:onDifficultySwitchFinish()
	logNormal("肉鸽2 完成切换难度")

	local animator = self._sceneAnimatorList[Rouge2_OutsideEnum.SceneIndex.DifficultyScene]

	self._difficultyRoleSpine.timeScale = 1

	self:playAnim(animator, string.format("%sidle", self._curDifficultyIndex))
	TaskDispatcher.cancelTask(self.onDifficultySwitchFinish, self)
end

function Rouge2_EnterScene:onDifficultySpineSwitchFinish()
	logNormal("肉鸽2 完成Spine切换难度")
	self._difficultyRoleSpine:PlayAnim(string.format("%s_idle", self._curDifficultyIndex), true, true)
end

function Rouge2_EnterScene:_onSelectCareer(careerId)
	if self._sceneIndex ~= Rouge2_OutsideEnum.SceneIndex.CareerScene then
		return
	end

	local showAnim = self._curCareerIndex ~= nil and self._curCareerIndex ~= careerId

	self._curCareerIndex = careerId

	local animator = self._sceneAnimatorList[Rouge2_OutsideEnum.SceneIndex.CareerScene]

	for id, item in ipairs(self._careerItemList) do
		gohelper.setActive(item, id == careerId)
	end

	if showAnim then
		logNormal("肉鸽2 开始切换职业")
		self:playAnim(animator, "switch")
		TaskDispatcher.cancelTask(self.onCareerSwitchFinish, self)
		TaskDispatcher.cancelTask(self.onCareerSwitchRefresh, self)
		TaskDispatcher.runDelay(self.onCareerSwitchFinish, self, Rouge2_OutsideEnum.CareerSwitchFinishTime)
		TaskDispatcher.runDelay(self.onCareerSwitchRefresh, self, Rouge2_OutsideEnum.CareerRefreshTime)
		self:_lockScreen(true, Rouge2_OutsideEnum.ForceCloseMaskTime)
	else
		logNormal("肉鸽2 无需切换职业")
	end
end

function Rouge2_EnterScene:onCareerSwitchRefresh()
	TaskDispatcher.cancelTask(self.onCareerSwitchRefresh, self)
	self:_lockScreen(false)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.CareerSwitchRefresh)
end

function Rouge2_EnterScene:onCareerSwitchFinish()
	local animator = self._sceneAnimatorList[Rouge2_OutsideEnum.SceneIndex.CareerScene]

	self:playAnim(animator, "idle")
	TaskDispatcher.cancelTask(self.onCareerSwitchFinish, self)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.CareerSwitchFinish)
end

function Rouge2_EnterScene:getSceneGoList()
	return self._sceneGoList
end

function Rouge2_EnterScene:getSceneGo(index)
	return self._sceneGoList[index]
end

function Rouge2_EnterScene:_lockScreen(lock, time)
	if lock then
		TaskDispatcher.runDelay(self.forceCloseLock, self, time)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(Rouge2_EnterScene.UIMaskName)
		logNormal("肉鸽开始场景 开始锁屏")
	else
		TaskDispatcher.cancelTask(self.forceCloseLock, self)
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(Rouge2_EnterScene.UIMaskName)
		logNormal("肉鸽开始场景 结束锁屏")
	end
end

function Rouge2_EnterScene:forceCloseLock()
	logError("肉鸽开始场景 事件出现表现超时 已强制关闭遮罩")
	self:_lockScreen(false)
end

function Rouge2_EnterScene:_calcFovInternal()
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local w, h = SettingsModel.instance:getCurrentScreenSize()

		fovRatio = 16 * h / 9 / w
	end

	local fov = Rouge2_OutsideEnum.TarotDefaultFOV * fovRatio
	local minFov, maxFov = self:_getMinMaxFov()

	fov = Mathf.Clamp(fov, minFov, maxFov)

	return fov
end

function Rouge2_EnterScene:_getMinMaxFov()
	return 22, 40
end

function Rouge2_EnterScene:onScreenResize()
	local fov = self:_calcFovInternal()
	local virtualCamera = CameraMgr.instance:getVirtualCamera(1, 1)
	local old = virtualCamera.m_Lens

	virtualCamera.m_Lens = Cinemachine.LensSettings.New(fov, old.OrthographicSize, old.NearClipPlane, old.FarClipPlane, old.Dutch)
end

function Rouge2_EnterScene:resetCamera()
	GameSceneMgr.instance:getCurScene().camera:resetParam()
end

function Rouge2_EnterScene:onClose()
	TaskDispatcher.cancelTask(self, self.switchIn)
	TaskDispatcher.cancelTask(self.forceCloseLock, self)
	TaskDispatcher.cancelTask(self.onEnterSceneFinish, self)
	TaskDispatcher.cancelTask(self.onDifficultySwitchFinish, self)
	TaskDispatcher.cancelTask(self.onDifficultySpineSwitchFinish, self)
	TaskDispatcher.cancelTask(self.onCareerSwitchFinish, self)
	TaskDispatcher.cancelTask(self.onCareerSwitchRefresh, self)

	local virtualCameraGo = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(virtualCameraGo, false)

	self._sceneIndex = nil
	self._previousIndex = nil

	self._splineFollow:Clear()
	MainCameraMgr.instance:_resetCamera()

	local cameraRoot = CameraMgr.instance:getCameraTraceGO()

	cameraRoot.transform.localPosition = self.cameraPosition
end

function Rouge2_EnterScene:onCloseFinish()
	local mainCamera = CameraMgr.instance:getMainCamera()

	mainCamera.fieldOfView = 35
end

function Rouge2_EnterScene:onDestroyView()
	gohelper.destroy(self._sceneRoot)
end

return Rouge2_EnterScene
