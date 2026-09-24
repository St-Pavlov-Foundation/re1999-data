-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikeTriggerDoor.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikeTriggerDoor", package.seeall)

local DeleikeTriggerDoor = class("DeleikeTriggerDoor", DeleikeTriggerBase)

function DeleikeTriggerDoor:init(go)
	DeleikeTriggerDoor.super.init(self, go)

	self.isDoor = true
	self.goUncut = gohelper.findChild(go, "uncut")
end

function DeleikeTriggerDoor:onDestroy()
	TaskDispatcher.cancelTask(self.delayFinish, self)
	GameUtil.setActiveUIBlock("DeleikeTriggerDoorLock", false, true)
end

function DeleikeTriggerDoor:onPicked()
	GameUtil.setActiveUIBlock("DeleikeTriggerDoorLock", true, false)
end

function DeleikeTriggerDoor:onAnimFinish()
	DeleikeTriggerDoor.super.onAnimFinish(self)
	ViewMgr.instance:openView(ViewName.DeleikeGameResultView)
	GameUtil.setActiveUIBlock("DeleikeTriggerDoorLock", false, true)
end

return DeleikeTriggerDoor
