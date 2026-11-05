-- chunkname: @modules/logic/versionactivity4_1/library/controller/V4a1_LibraryEvent.lua

module("modules.logic.versionactivity4_1.library.controller.V4a1_LibraryEvent", package.seeall)

local V4a1_LibraryEvent = _M
local make = GameUtil.getUniqueTb()

V4a1_LibraryEvent.OnPreloadFinish = make()
V4a1_LibraryEvent.OnShowCharsChanged = make()

return V4a1_LibraryEvent
