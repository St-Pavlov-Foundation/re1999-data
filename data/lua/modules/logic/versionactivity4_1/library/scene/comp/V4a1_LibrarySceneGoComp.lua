-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibrarySceneGoComp.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibrarySceneGoComp", package.seeall)

local V4a1_LibrarySceneGoComp = class("V4a1_LibrarySceneGoComp", V4a1_LibraryBaseSceneComp)

function V4a1_LibrarySceneGoComp:ctor(...)
	V4a1_LibrarySceneGoComp.super.ctor(self, ...)
end

function V4a1_LibrarySceneGoComp:onSceneStart(sceneId, levelId)
	self:_clear()
	GameSceneMgr.instance:registerCallback(SceneEventName.SceneGoChangeVisible, self._onSceneGoChangeVisible, self)
end

function V4a1_LibrarySceneGoComp:onScenePrepared(sceneId, levelId)
	self._animator = self:levelGo():GetComponent(gohelper.Type_Animator)
end

function V4a1_LibrarySceneGoComp:onSceneClose(...)
	self:_clear()
	V4a1_LibrarySceneGoComp.super.onSceneClose(self, ...)
end

function V4a1_LibrarySceneGoComp:_clear()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.SceneGoChangeVisible, self._onSceneGoChangeVisible, self)

	for _, memberName in pairs(V4a1_LibraryEnum.SceneGoName) do
		self[memberName] = nil
	end

	self._animator = nil
end

function V4a1_LibrarySceneGoComp:_getGoImpl(eSceneGoNameName, optParentGo, optNodePath)
	optNodePath = optNodePath or eSceneGoNameName

	return self:getOrCreateGo(eSceneGoNameName, optNodePath, optParentGo)
end

function V4a1_LibrarySceneGoComp:getCharsRootGo()
	return self:_getGoImpl(V4a1_LibraryEnum.SceneGoName.CharsRoot)
end

function V4a1_LibrarySceneGoComp:onPlayOpenAnim()
	if self._animator then
		self._animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function V4a1_LibrarySceneGoComp:onPlayIdleAnim()
	if self._animator then
		self._animator:Play(UIAnimationName.Idle, 0, 1)
	end
end

function V4a1_LibrarySceneGoComp:_onSceneGoChangeVisible(bActive)
	if bActive then
		self:onPlayIdleAnim()
	end
end

return V4a1_LibrarySceneGoComp
