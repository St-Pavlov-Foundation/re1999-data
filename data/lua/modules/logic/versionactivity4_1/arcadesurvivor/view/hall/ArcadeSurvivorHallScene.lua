-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorHallScene.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorHallScene", package.seeall)

local ArcadeSurvivorHallScene = class("ArcadeSurvivorHallScene", BaseView)

function ArcadeSurvivorHallScene:onInitView()
	self._gotipview = gohelper.findChild(self.viewGO, "#go_tipview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHallScene:_editableInitView()
	self._levelSceneLockGODict = self:getUserDataTb_()

	self:_clearComps()
	self:_clearScene()
	self:_createScene()
end

function ArcadeSurvivorHallScene:_createScene()
	local root = CameraMgr.instance:getSceneRoot()

	self._goScene = gohelper.create3d(root, ArcadeSurvivorHallEnum.Const.GameSceneName)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._goScene.transform, 0, y, 0)
	self:_disposeSceneLoader()

	local sceneUrl = ArcadeSurvivorHallEnum.Const.SceneUrl

	if string.nilorempty(sceneUrl) then
		return
	end

	UIBlockMgr.instance:startBlock(ArcadeSurvivorEnum.BlockKey.LoadHallScene)

	self._sceneLoader = PrefabInstantiate.Create(self._goScene)

	self._sceneLoader:startLoad(sceneUrl, self._onLoadSceneFinish, self)
end

function ArcadeSurvivorHallScene:_onLoadSceneFinish()
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.LoadHallScene)

	if not self._sceneLoader then
		return
	end

	self._goSceneRes = self._sceneLoader:getInstGO()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self._goSceneRes)

	self._animPlayer:Play(UIAnimationName.Open, nil, nil)
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnLoadFinishHallScene)

	local root = gohelper.findChild(self._goSceneRes, "Obj-Plant/switch")
	local dict = ArcadeSurvivorConfig.instance:getHallUnitLockObjDict()

	for id, lockObj in pairs(dict) do
		local go = gohelper.findChild(root, lockObj)

		if not gohelper.isNil(go) then
			self._levelSceneLockGODict[id] = go
		end
	end

	self:_initScene()
	self:_refreshLevelScene()
end

function ArcadeSurvivorHallScene:_initScene()
	self:_addComp("loader", ArcadeSurvivorLoader)
	self:_addComp("interactiveUIMgr", ArcadeSurvivorHallInteractiveUIMgr, true)
	self:_addComp("entityMgr", ArcadeSurvivorHallEntityMgr, true, true)
end

function ArcadeSurvivorHallScene:_refreshLevelScene()
	for id, go in pairs(self._levelSceneLockGODict) do
		local difficulty = ArcadeSurvivorConfig.instance:getHallUnitDifficulty(id)
		local isUnlock = ArcadeSurvivorOutSideModel.instance:isUnlockDifficulty(difficulty)

		gohelper.setActive(go, not isUnlock)
	end
end

function ArcadeSurvivorHallScene:_addComp(compName, compClass, needScene, needContentGO)
	local go = self._goScene

	if needContentGO then
		go = gohelper.create3d(self._goScene, compName)
	end

	local compInst

	if needScene then
		compInst = MonoHelper.addNoUpdateLuaComOnceToGo(go, compClass, {
			scene = self,
			compName = compName
		})
	else
		compInst = MonoHelper.addNoUpdateLuaComOnceToGo(go, compClass, compName)
	end

	if not compInst then
		return
	end

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function ArcadeSurvivorHallScene:addEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeSurvivorHallScene:removeEvents()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeSurvivorHallScene:_onOpenView(viewName)
	if viewName == ViewName.EquipView then
		self:showScene(false)
	end
end

function ArcadeSurvivorHallScene:_onCloseView(viewName)
	if viewName == ViewName.EquipView then
		self:showScene(true)
	else
		local viewNameDict = ArcadeSurvivorConfig.instance:getHallUnitEnterViewNameDict()

		if viewNameDict[viewName] then
			self:showScene(true)
		end
	end
end

function ArcadeSurvivorHallScene:showScene(isShow)
	if gohelper.isNil(self._goScene) then
		return
	end

	gohelper.setActive(self._goScene, isShow)
end

function ArcadeSurvivorHallScene:onOpen()
	for _, comp in ipairs(self._compList) do
		if comp.onOpen then
			comp:onOpen()
		end
	end

	if self._goSceneRes and self._animPlayer then
		ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnLoadFinishHallScene)
		self._animPlayer:Play(UIAnimationName.Open, nil, nil)
	end
end

function ArcadeSurvivorHallScene:playerActOnDirection(direction)
	if not self.entityMgr then
		return
	end

	self.entityMgr:playerActOnDirection(direction)
end

function ArcadeSurvivorHallScene:openBuildingTipView(buildingId)
	local anchor = {
		x = 654,
		y = 263
	}
	local param = {
		buildingId = buildingId,
		root = self._gotipview,
		anchorPos = anchor,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Building, param)
end

function ArcadeSurvivorHallScene:onTransformPoint(x, y)
	local worldPos = self._goScene.transform:TransformPoint(x, y, 0)

	return worldPos
end

function ArcadeSurvivorHallScene:onInverseTransformPoint(worldPos)
	local localPos = self._goScene.transform:InverseTransformPoint(worldPos.x, worldPos.y, 0)

	return localPos
end

function ArcadeSurvivorHallScene:isCanMove()
	if not self.entityMgr then
		return
	end

	local container = ViewMgr.instance:getContainer(ViewName.ArcadeSurvivorQuitTipView)

	if container and container:isOpen() then
		return
	end

	return self.entityMgr:isCanMove()
end

function ArcadeSurvivorHallScene:getSceneGO()
	return self._goScene
end

function ArcadeSurvivorHallScene:onClose()
	for _, comp in ipairs(self._compList) do
		if comp.onClose then
			comp:onClose()
		end
	end
end

function ArcadeSurvivorHallScene:onDestroyView()
	self:onExitHall()
end

function ArcadeSurvivorHallScene:onExitHall()
	self:_disposeSceneLoader()
	self:_clearComps()
	self:_clearScene()
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.LoadHallScene)
end

function ArcadeSurvivorHallScene:_disposeSceneLoader()
	if self._sceneLoader then
		self._sceneLoader:dispose()
	end

	self._sceneLoader = nil
end

function ArcadeSurvivorHallScene:_clearComps()
	if self._compList then
		for _, comp in ipairs(self._compList) do
			comp:clear()
		end
	end

	self._compList = {}
end

function ArcadeSurvivorHallScene:_clearScene()
	if self._goSceneRes then
		gohelper.destroy(self._goSceneRes)
	end

	self._goSceneRes = nil

	if self._goScene then
		gohelper.destroy(self._goScene)
	end

	self._goScene = nil
end

return ArcadeSurvivorHallScene
