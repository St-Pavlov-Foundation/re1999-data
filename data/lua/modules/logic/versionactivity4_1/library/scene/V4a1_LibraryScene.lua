-- chunkname: @modules/logic/versionactivity4_1/library/scene/V4a1_LibraryScene.lua

module("modules.logic.versionactivity4_1.library.scene.V4a1_LibraryScene", package.seeall)

local V4a1_LibraryScene = class("V4a1_LibraryScene", LibSimpleSceneBase)

function V4a1_LibraryScene:ctor(...)
	V4a1_LibraryScene.super.ctor(self, ...)
end

function V4a1_LibraryScene:_createAllComps()
	self:_addComp("go", V4a1_LibrarySceneGoComp)
	self:_addComp("camera", V4a1_LibrarySceneCameraComp)
	self:_addComp("level", V4a1_LibrarySceneLevelComp)
	self:_addComp("preloader", V4a1_LibraryScenePreloaderComp)
	self:_addComp("loader", V4a1_LibrarySceneLoaderComp)
	self:_addComp("director", V4a1_LibrarySceneDirector)
	self:_addComp("entitymgr", V4a1_LibrarySceneEntityMgr)
	self:_addComp("view", V4a1_LibrarySceneViewComp)
end

function V4a1_LibraryScene:onClose()
	if not self:bNextSceneKindOfSame() then
		self:_onCloseImpl()
	end

	V4a1_LibraryScene.super.onClose(self)
end

function V4a1_LibraryScene:_onCloseImpl()
	return
end

function V4a1_LibraryScene:registerCallback_OnShowCharsChanged(cb, cbObj)
	self.entitymgr:registerCallback(V4a1_LibraryEvent.OnShowCharsChanged, cb, cbObj)
end

return V4a1_LibraryScene
