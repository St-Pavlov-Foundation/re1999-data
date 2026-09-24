-- chunkname: @modules/logic/versionactivity4_0/deleike/controller/DeleikeEvent.lua

module("modules.logic.versionactivity4_0.deleike.controller.DeleikeEvent", package.seeall)

local DeleikeEvent = _M
local _get = GameUtil.getUniqueTb()

DeleikeEvent.ResetGame = _get()
DeleikeEvent.RestartGame = _get()
DeleikeEvent.Skill2DragStateChanged = _get()
DeleikeEvent.Skill2FirstDrag = _get
DeleikeEvent.SkillCntChange = _get()

return DeleikeEvent
