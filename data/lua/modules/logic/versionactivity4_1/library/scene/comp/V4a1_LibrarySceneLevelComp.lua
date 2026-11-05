-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibrarySceneLevelComp.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibrarySceneLevelComp", package.seeall)

local V4a1_LibrarySceneLevelComp = class("V4a1_LibrarySceneLevelComp", CommonSceneLevelComp)

function V4a1_LibrarySceneLevelComp:ctor(...)
	V4a1_LibrarySceneLevelComp.super.ctor(self, ...)
end

function V4a1_LibrarySceneLevelComp:onSceneStart(sceneId, levelId)
	self._sceneId = sceneId
	self._levelId = levelId
end

function V4a1_LibrarySceneLevelComp:onSceneClose()
	V4a1_LibrarySceneLevelComp.super.onSceneClose(self)
end

function V4a1_LibrarySceneLevelComp:onExec_LibAsyncTaskWork()
	self:loadLevel()
end

function V4a1_LibrarySceneLevelComp:getLevelId(levelId)
	return V4a1_LibraryConfig.instance:getSceneLevelId()
end

return V4a1_LibrarySceneLevelComp
