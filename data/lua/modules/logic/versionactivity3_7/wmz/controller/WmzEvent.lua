-- chunkname: @modules/logic/versionactivity3_7/wmz/controller/WmzEvent.lua

module("modules.logic.versionactivity3_7.wmz.controller.WmzEvent", package.seeall)

local WmzEvent = _M
local make = GameUtil.getUniqueTb()

WmzEvent.onReceiveGetAct220InfoReply = make()
WmzEvent.onReceiveAct220FinishEpisodeReply = make()
WmzEvent.onReceiveAct220EpisodePush = make()
WmzEvent.GuideStart = make()

return WmzEvent
