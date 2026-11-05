-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/LibSimpleSceneCompBase.lua

module("modules.logic.versionactivity4_1.library.scene.comp.LibSimpleSceneCompBase", package.seeall)

local LibSimpleSceneCompBase = class("LibSimpleSceneCompBase", LibSimpleLuaCompBase)

function LibSimpleSceneCompBase:ctor(sceneObj, ...)
	GameUtil.setInterface(self, self._interfaceCls)
	self:__onInit()

	if isDebugBuild then
		assert(isTypeOf(sceneObj, LibSimpleSceneBase))
	end

	self._sceneObj = sceneObj

	LuaEventSystem.addEventMechanism(self)
end

function LibSimpleSceneCompBase:init()
	return
end

function LibSimpleSceneCompBase:parent()
	return self._sceneObj
end

function LibSimpleSceneCompBase:sceneObj()
	return self._sceneObj
end

function LibSimpleSceneCompBase:getOrCreateGo(memberName, ...)
	if isDebugBuild then
		assert(type(memberName) == "string", debug.traceback())
	end

	local go = self[memberName]

	if gohelper.isNil(go) then
		self[memberName] = self:sceneObj():getOrCreateGo(...)
	end

	return self[memberName]
end

function LibSimpleSceneCompBase:onInit()
	return
end

function LibSimpleSceneCompBase:onSceneStart(sceneId, levelId)
	self:addEventListeners()
end

function LibSimpleSceneCompBase:onScenePrepared(sceneId, levelId)
	return
end

function LibSimpleSceneCompBase:onSceneClose()
	self:removeEventListeners()
	self:unregisterAllCallback()
	self:__onDispose()
end

return LibSimpleSceneCompBase
