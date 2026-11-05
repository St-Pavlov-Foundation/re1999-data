-- chunkname: @modules/logic/versionactivity4_1/peishita/view/comp/PeiShiTaDropComp.lua

module("modules.logic.versionactivity4_1.peishita.view.comp.PeiShiTaDropComp", package.seeall)

local PeiShiTaDropComp = class("PeiShiTaDropComp", PeiShiTaUnitComp)

function PeiShiTaDropComp:addEventListeners()
	PeiShiTaDropComp.super.addEventListeners(self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitRemove, self._onDropDie, self)
end

function PeiShiTaDropComp:playOpenAnim()
	self._animator:Stop()
	self._animComp:Play("open", 0, 1)

	self._animComp.enabled = true
end

function PeiShiTaDropComp:_onDropDie(unit, x, y)
	if not self._inUse then
		return
	end

	if self._unitX ~= x or self._unitY ~= y then
		return
	end

	self._animator:Play("close", self._reallyRetire, self)

	if self._unitId == PeiShiTaEnum.ToolId.Crossbow then
		AudioMgr.instance:trigger(AudioEnum4_1.PeiShiTa.play_ui_atlantis_obtain_crossbow)
	elseif self._unitId == PeiShiTaEnum.ToolId.Axe then
		AudioMgr.instance:trigger(AudioEnum4_1.PeiShiTa.play_ui_atlantis_obtain_axe)
	end
end

return PeiShiTaDropComp
