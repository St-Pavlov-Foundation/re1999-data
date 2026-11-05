-- chunkname: @modules/logic/versionactivity4_1/peishita/define/PeiShiTaEvent.lua

module("modules.logic.versionactivity4_1.peishita.define.PeiShiTaEvent", package.seeall)

local PeiShiTaEvent = class("PeiShiTaEvent")

PeiShiTaEvent.OnPlayerMove = GameUtil.getEventId()
PeiShiTaEvent.OnBoardChanged = GameUtil.getEventId()
PeiShiTaEvent.OnToolChanged = GameUtil.getEventId()
PeiShiTaEvent.OnLevelReset = GameUtil.getEventId()
PeiShiTaEvent.OnMoveAnimDone = GameUtil.getEventId()
PeiShiTaEvent.OnArcheryEffect = GameUtil.getEventId()
PeiShiTaEvent.OnArcheryAnimDone = GameUtil.getEventId()
PeiShiTaEvent.OnUnitRemove = GameUtil.getEventId()
PeiShiTaEvent.OnUnitMove = GameUtil.getEventId()
PeiShiTaEvent.OnUnitDieDone = GameUtil.getEventId()
PeiShiTaEvent.OnLeaveAnimDone = GameUtil.getEventId()
PeiShiTaEvent.OnAlertUnit = GameUtil.getEventId()
PeiShiTaEvent.ResetGame = GameUtil.getEventId()
PeiShiTaEvent.ZTriggerStartGame = GameUtil.getEventId()
PeiShiTaEvent.ZTriggerFinishGame = GameUtil.getEventId()
PeiShiTaEvent.ClaimAll = GameUtil.getEventId()
PeiShiTaEvent.OnEnterGame = GameUtil.getEventId()

return PeiShiTaEvent
