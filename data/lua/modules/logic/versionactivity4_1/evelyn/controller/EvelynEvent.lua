-- chunkname: @modules/logic/versionactivity4_1/evelyn/controller/EvelynEvent.lua

module("modules.logic.versionactivity4_1.evelyn.controller.EvelynEvent", package.seeall)

local EvelynEvent = _M
local _get = GameUtil.getUniqueTb()

EvelynEvent.GuideToolPlaced = _get()
EvelynEvent.GuideLinkSuccess = _get()
EvelynEvent.GuideFinishEpisode = _get()

return EvelynEvent
