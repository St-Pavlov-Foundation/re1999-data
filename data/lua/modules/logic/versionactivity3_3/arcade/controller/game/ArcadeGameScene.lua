-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameScene.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameScene", package.seeall)

local ArcadeGameScene = class("ArcadeGameScene")

function ArcadeGameScene:onEnterArcadeGame(isRestartGame)
	self:_clearComps()
	self:_clearScene()

	self._isRestartGame = isRestartGame

	local root = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = gohelper.create3d(root, ArcadeGameEnum.Const.GameSceneName)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	self._sceneOffsetY = y

	self:_disposeSceneLoader()

	local sceneUrl = ResUrl.getArcadeSceneRes(ArcadeGameEnum.Const.GameSceneResName)

	if not string.nilorempty(sceneUrl) then
		UIBlockMgr.instance:startBlock(ArcadeEnum.BlockKey.LoadGameScene)

		self._sceneLoader = PrefabInstantiate.Create(self._sceneRoot)

		self._sceneLoader:startLoad(sceneUrl, self._onLoadSceneFinish, self)
	end
end

function ArcadeGameScene:_onLoadSceneFinish()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.LoadGameScene)

	if not self._sceneLoader then
		return
	end

	self._goScene = self._sceneLoader:getInstGO()

	self:_initScene()
end

function ArcadeGameScene:_initScene()
	self:_addComp("loader", ArcadeLoader)
	self:_addComp("roomMgr", ArcadeRoomMgr)
	self:_addComp("entityMgr", ArcadeEntityMgr, true)
	self:_addComp("effectMgr", ArcadeEffectMgr, true)
	self:_addComp("flyingEffectMgr", ArcadeFlyingEffectMgr, true)
	self:_disposePreGameStartFlow()

	self._preGameStartFlow = FlowSequence.New()

	self._preGameStartFlow:addWork(ArcadePreGameStartWork.New(self.entityMgr, ArcadeGameController.instance, ArcadeEvent.OnLoadFinishGameCharacter))
	self._preGameStartFlow:registerDoneListener(self._initSceneFinish, self)
	self._preGameStartFlow:start()
end

function ArcadeGameScene:_addComp(compName, compClass, useNewGO)
	local go = self._sceneRoot

	if useNewGO then
		go = gohelper.create3d(self._sceneRoot, compName)
	end

	local compInst = MonoHelper.addNoUpdateLuaComOnceToGo(go, compClass, {
		scene = self,
		compName = compName
	})

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function ArcadeGameScene:_initSceneFinish()
	self:_disposePreGameStartFlow()
	ArcadeGameController.instance:startGame(self._isRestartGame)

	self._isRestartGame = nil
end

function ArcadeGameScene:onExitArcadeGame()
	self:_disposeSceneLoader()
	self:_disposePreGameStartFlow()
	self:_clearComps()
	self:_clearScene()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.LoadGameScene)
end

function ArcadeGameScene:_clearComps()
	if self._compList then
		for _, comp in ipairs(self._compList) do
			local compName = comp:getCompName()

			self[compName] = nil

			comp:clear()
		end
	end

	self._compList = {}
end

function ArcadeGameScene:_clearScene()
	if self._goScene then
		gohelper.destroy(self._goScene)
	end

	self._goScene = nil

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)
	end

	self._sceneRoot = nil
end

function ArcadeGameScene:_disposeSceneLoader()
	if self._sceneLoader then
		self._sceneLoader:dispose()
	end

	self._sceneLoader = nil
end

function ArcadeGameScene:_disposePreGameStartFlow()
	if not self._preGameStartFlow then
		return
	end

	self._preGameStartFlow:unregisterDoneListener(self._initSceneFinish, self)
	self._preGameStartFlow:destroy()

	self._preGameStartFlow = nil
end

function ArcadeGameScene:getSceneRoot()
	return self._sceneRoot
end

function ArcadeGameScene:getSceneGO()
	return self._goScene
end

function ArcadeGameScene:getSceneOffsetY()
	return self._sceneOffsetY
end

return ArcadeGameScene
