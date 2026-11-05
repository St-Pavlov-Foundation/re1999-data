-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibrarySceneDirector.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibrarySceneDirector", package.seeall)

local V4a1_LibrarySceneDirector = class("V4a1_LibrarySceneDirector", V4a1_LibraryBaseSceneComp)

function V4a1_LibrarySceneDirector:ctor(...)
	V4a1_LibrarySceneDirector.super.ctor(self, ...)
end

function V4a1_LibrarySceneDirector:onSceneStart(sceneId, levelId)
	self:_destroyFlow()
	V4a1_LibrarySceneDirector.super.onSceneStart(self, sceneId, levelId)

	self._flow = V4a1_LibrarySceneDirectorFlow_onSceneStart.New()

	self._flow:start(self:sceneObj())
end

function V4a1_LibrarySceneDirector:onSceneClose(...)
	self:_destroyFlow()
	V4a1_LibrarySceneDirector.super.onSceneClose(self, ...)
end

function V4a1_LibrarySceneDirector:_destroyFlow()
	GameUtil.onDestroyViewMember(self, "_flow")
end

return V4a1_LibrarySceneDirector
