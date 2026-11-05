-- chunkname: @modules/logic/versionactivity4_1/peishita/view/comp/PeiShiTaHunterComp.lua

module("modules.logic.versionactivity4_1.peishita.view.comp.PeiShiTaHunterComp", package.seeall)

local PeiShiTaHunterComp = class("PeiShiTaHunterComp", PeiShiTaMovableComp)

function PeiShiTaHunterComp:init(go)
	PeiShiTaHunterComp.super.init(self, go)

	self._goHunterAlert = gohelper.findChild(go, "icon_alert")
	self._goDizziness = gohelper.findChild(go, "icon_dizziness")
end

function PeiShiTaHunterComp:addEventListeners()
	PeiShiTaHunterComp.super.addEventListeners(self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnToolChanged, self._onToolChanged, self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnAlertUnit, self._onAlertUnit, self)
end

function PeiShiTaHunterComp:refreshUI()
	PeiShiTaHunterComp.super.refreshUI(self)
	self:refreshDizziness()
end

function PeiShiTaHunterComp:_onToolChanged()
	if not self._inUse then
		return
	end

	self:refreshDizziness()
end

function PeiShiTaHunterComp:refreshDizziness()
	local toolCount = PeiShiTaGameModel.instance:getToolCount(PeiShiTaEnum.ToolId.Crossbow)

	gohelper.setActive(self._goDizziness, toolCount > 0)
end

function PeiShiTaHunterComp:_applyFaceScale()
	local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(self._tranIcon)
	local absScaleX = math.abs(scaleX)

	transformhelper.setLocalScale(self._tranIcon, self._faceRight and -absScaleX or absScaleX, scaleY, scaleZ)
end

function PeiShiTaHunterComp:resetState()
	PeiShiTaHunterComp.super.resetState(self)
	gohelper.setActive(self._goHunterAlert, false)
end

function PeiShiTaHunterComp:_onAlertUnit(unitId)
	if self._id ~= unitId then
		return
	end

	gohelper.setActive(self._goHunterAlert, true)
	AudioMgr.instance:trigger(AudioEnum4_1.PeiShiTa.play_ui_atlantis_warn)
end

function PeiShiTaHunterComp:_startPlayMove()
	AudioMgr.instance:trigger(AudioEnum4_1.PeiShiTa.play_ui_atlantis_hunter_moves)
end

function PeiShiTaHunterComp:_onMoveDoneCallback()
	gohelper.setActive(self._goHunterAlert, false)
	PeiShiTaHunterComp.super._onMoveDoneCallback(self)
end

return PeiShiTaHunterComp
