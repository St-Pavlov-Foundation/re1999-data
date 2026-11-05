-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibrarySceneCompInterface.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibrarySceneCompInterface", package.seeall)

local V4a1_LibrarySceneCompInterface = class("V4a1_LibrarySceneCompInterface")

function V4a1_LibrarySceneCompInterface:sceneId()
	return self:sceneObj()._curSceneId
end

function V4a1_LibrarySceneCompInterface:levelId()
	return self:sceneObj():getCurLevelId()
end

function V4a1_LibrarySceneCompInterface:sceneCameraComp()
	return self:sceneObj().camera
end

function V4a1_LibrarySceneCompInterface:sceneGoComp()
	return self:sceneObj().go
end

function V4a1_LibrarySceneCompInterface:sceneLevelComp()
	return self:sceneObj().level
end

function V4a1_LibrarySceneCompInterface:scenePreloaderComp()
	return self:sceneObj().preloader
end

function V4a1_LibrarySceneCompInterface:sceneLoaderComp()
	return self:sceneObj().loader
end

function V4a1_LibrarySceneCompInterface:sceneDirectorComp()
	return self:sceneObj().director
end

function V4a1_LibrarySceneCompInterface:sceneEntityMgrComp()
	return self:sceneObj().entitymgr
end

function V4a1_LibrarySceneCompInterface:sceneViewComp()
	return self:sceneObj().view
end

function V4a1_LibrarySceneCompInterface:levelGo()
	return self:sceneLevelComp():getSceneGo()
end

function V4a1_LibrarySceneCompInterface:sceneObj()
	return V4a1_LibraryController.instance:getSceneObj()
end

function V4a1_LibrarySceneCompInterface:actId()
	return V4a1_LibraryController.instance:actId()
end

return V4a1_LibrarySceneCompInterface
