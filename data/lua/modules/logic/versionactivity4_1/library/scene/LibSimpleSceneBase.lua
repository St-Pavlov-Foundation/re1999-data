-- chunkname: @modules/logic/versionactivity4_1/library/scene/LibSimpleSceneBase.lua

module("modules.logic.versionactivity4_1.library.scene.LibSimpleSceneBase", package.seeall)

local LibSimpleSceneBase = class("LibSimpleSceneBase", BaseScene)

function LibSimpleSceneBase:ctor(rootGo, ...)
	GameUtil.setInterface(self, self._interfaceCls)
	LibSimpleSceneBase.super.ctor(self, rootGo, ...)

	self._trans = rootGo.transform
end

function LibSimpleSceneBase:isValid()
	return not self:isClosing() and not gohelper.isNil(self:containerGO())
end

function LibSimpleSceneBase:sceneObj()
	return self
end

function LibSimpleSceneBase:containerGO()
	return self._gameObj
end

function LibSimpleSceneBase:transform()
	return self._trans
end

function LibSimpleSceneBase:sceneId()
	return self._curSceneId
end

function LibSimpleSceneBase:levelId()
	return self._curLevelId
end

function LibSimpleSceneBase:setLevelId(levelId)
	self._curLevelId = levelId
end

function LibSimpleSceneBase:bNextSceneKindOfSame()
	local ne = GameSceneMgr.instance:getNextSceneType()
	local cur = GameSceneMgr.instance:getCurSceneType()

	return cur == nextSceneType
end

function LibSimpleSceneBase:create3d(optGoName, optParentGo)
	optParentGo = optParentGo or self:containerGO()

	return gohelper.create3d(optParentGo, optGoName)
end

function LibSimpleSceneBase:getOrCreateGo(nodePath, optParentGo)
	optParentGo = optParentGo or self:containerGO()

	local go = gohelper.findChild(optParentGo, nodePath)

	if gohelper.isNil(go) then
		go = self:create3d(nodePath, optParentGo)
	end

	return go
end

return LibSimpleSceneBase
