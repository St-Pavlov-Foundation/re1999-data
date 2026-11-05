-- chunkname: @modules/logic/versionactivity4_1/library/controller/V4a1_LibraryController.lua

module("modules.logic.versionactivity4_1.library.controller.V4a1_LibraryController", package.seeall)

local V4a1_LibraryController = class("V4a1_LibraryController", BaseController)

function V4a1_LibraryController:ctor(...)
	V4a1_LibraryController.super.ctor(self, ...)
end

function V4a1_LibraryController:onInit()
	self._sys = V4a1_LibrarySysModel.instance
	self._scene = V4a1_LibrarySceneModel.instance

	assert(self._sys and self._scene)
	self:reInit()
end

function V4a1_LibraryController:reInit()
	return
end

function V4a1_LibraryController:actId()
	return self._sys:actId()
end

function V4a1_LibraryController:configInst()
	return self._sys:configInst()
end

function V4a1_LibraryController:enterScene()
	self._scene:enterScene()
end

function V4a1_LibraryController:exitScene()
	self:_exitScene()
end

function V4a1_LibraryController:_exitScene()
	MainController.instance:enterMainScene()
	self._scene:clear()
end

function V4a1_LibraryController:getSceneObj()
	return self._scene:getSceneObj()
end

V4a1_LibraryController.instance = V4a1_LibraryController.New()

return V4a1_LibraryController
