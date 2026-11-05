-- chunkname: @modules/logic/versionactivity4_1/library/model/V4a1_LibrarySysModel.lua

module("modules.logic.versionactivity4_1.library.model.V4a1_LibrarySysModel", package.seeall)

local V4a1_LibrarySysModel = class("V4a1_LibrarySysModel", V4a1_LibraryBaseModel)

function V4a1_LibrarySysModel:ctor(...)
	V4a1_LibrarySysModel.super.ctor(self, ...)
end

function V4a1_LibrarySysModel:onInit()
	V4a1_LibrarySysModel.super.onInit(self)
end

function V4a1_LibrarySysModel:reInit()
	V4a1_LibrarySysModel.super.reInit(self)
	self:clear()
end

V4a1_LibrarySysModel.instance = V4a1_LibrarySysModel.New()

return V4a1_LibrarySysModel
