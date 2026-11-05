-- chunkname: @modules/logic/versionactivity4_1/peishita/view/comp/PeiShiTaSchulzComp.lua

module("modules.logic.versionactivity4_1.peishita.view.comp.PeiShiTaSchulzComp", package.seeall)

local PeiShiTaSchulzComp = class("PeiShiTaSchulzComp", PeiShiTaMovableComp)

function PeiShiTaSchulzComp:init(go)
	PeiShiTaSchulzComp.super.init(self, go)

	self._goSprint = gohelper.findChild(go, "#go_sprint")
	self._goSprintAlert = gohelper.findChild(go, "icon_discovery")
	self._tranSprint = self._goSprint.transform
end

function PeiShiTaSchulzComp:addEventListeners()
	PeiShiTaSchulzComp.super.addEventListeners(self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnAlertUnit, self._onAlertUnit, self)
end

function PeiShiTaSchulzComp:_onAlertUnit(schulzId)
	if self._id ~= schulzId then
		return
	end

	gohelper.setActive(self._goSprintAlert, true)
	AudioMgr.instance:trigger(AudioEnum4_1.PeiShiTa.play_ui_atlantis_warn)
end

function PeiShiTaSchulzComp:_startPlayMove(dir)
	gohelper.setActive(self._goSprint, true)
	transformhelper.setLocalRotation(self._tranSprint, 0, 0, (dir - 1) * 90)
	AudioMgr.instance:trigger(AudioEnum4_1.PeiShiTa.play_ui_atlantis_hunter_moves)
end

function PeiShiTaSchulzComp:_onMoveDoneCallback()
	gohelper.setActive(self._goSprint, false)
	gohelper.setActive(self._goSprintAlert, false)
	PeiShiTaSchulzComp.super._onMoveDoneCallback(self)
end

function PeiShiTaSchulzComp:resetState()
	PeiShiTaSchulzComp.super.resetState(self)
	gohelper.setActive(self._goSprint, false)
	gohelper.setActive(self._goSprintAlert, false)
end

function PeiShiTaSchulzComp:onDestroy()
	PeiShiTaSchulzComp.super.onDestroy(self)
end

return PeiShiTaSchulzComp
