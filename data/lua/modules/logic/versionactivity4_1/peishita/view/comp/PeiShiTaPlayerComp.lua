-- chunkname: @modules/logic/versionactivity4_1/peishita/view/comp/PeiShiTaPlayerComp.lua

module("modules.logic.versionactivity4_1.peishita.view.comp.PeiShiTaPlayerComp", package.seeall)

local PeiShiTaPlayerComp = class("PeiShiTaPlayerComp", PeiShiTaMovableComp)

function PeiShiTaPlayerComp:init(go)
	PeiShiTaPlayerComp.super.init(self, go)

	self._goBladeEffect = gohelper.findChild(go, "#go_blade_glint")
	self._tranBladeEffect = self._goBladeEffect.transform
	self._goDizziness = gohelper.findChild(go, "#go_dizziness")
end

function PeiShiTaPlayerComp:addEventListeners()
	PeiShiTaPlayerComp.super.addEventListeners(self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnPlayerMove, self._onPlayerMove, self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnToolChanged, self._onToolChanged, self)
end

function PeiShiTaPlayerComp:resetState()
	PeiShiTaPlayerComp.super.resetState(self)
	gohelper.setActive(self._goBladeEffect, false)
	gohelper.setActive(self._goDizziness, false)
end

function PeiShiTaPlayerComp:_onPlayerMove(x, y, dir)
	if not self._inUse then
		return
	end

	self:_setGridPos(x, y, false)
end

function PeiShiTaPlayerComp:_onToolChanged(toolId)
	if not self._inUse then
		return
	end

	if toolId == PeiShiTaEnum.ToolId.Crossbow then
		self:refreshCrossbowEffect()
	end
end

function PeiShiTaPlayerComp:refreshCrossbowEffect()
	local toolCount = PeiShiTaGameModel.instance:getToolCount(PeiShiTaEnum.ToolId.Crossbow)

	gohelper.setActive(self._goDizziness, toolCount > 0)

	if toolCount > 0 then
		TaskDispatcher.cancelTask(self._hideDizzinessEffect, self)
		TaskDispatcher.runDelay(self._hideDizzinessEffect, self, 1.2)
	end
end

function PeiShiTaPlayerComp:_hideDizzinessEffect()
	gohelper.setActive(self._goDizziness, false)
end

function PeiShiTaPlayerComp:_onUnitRemove(unit)
	PeiShiTaPlayerComp.super._onUnitRemove(self, unit)

	if not self._inUse then
		return
	end

	if unit.config.type == PeiShiTaEnum.UnitType.Obstacle then
		self:_playRemoveObstacleEffect()
	end
end

function PeiShiTaPlayerComp:_playRemoveObstacleEffect()
	gohelper.setActive(self._goBladeEffect, true)
	transformhelper.setLocalRotation(self._tranBladeEffect, 0, 0, self._faceRight and 0 or 180)
	TaskDispatcher.cancelTask(self._hideBladeEffect, self)
	TaskDispatcher.runDelay(self._hideBladeEffect, self, PeiShiTaEnum.ConstValue.RemoveTreeAnimTime)
end

function PeiShiTaPlayerComp:_onMoveDoneCallback()
	PeiShiTaPlayerComp.super._onMoveDoneCallback(self)

	if self._gameMo.isSuccess then
		self._animator:Play("leave", self._onLeaveAnimDone, self)
	end
end

function PeiShiTaPlayerComp:_onLeaveAnimDone()
	PeiShiTaGameController.instance:dispatchEvent(PeiShiTaEvent.OnLeaveAnimDone)
end

function PeiShiTaPlayerComp:_hideBladeEffect()
	gohelper.setActive(self._goBladeEffect, false)
end

function PeiShiTaPlayerComp:onDestroy()
	TaskDispatcher.cancelTask(self._hideBladeEffect, self)
	TaskDispatcher.cancelTask(self._hideDizzinessEffect, self)
	PeiShiTaPlayerComp.super.onDestroy(self)
end

return PeiShiTaPlayerComp
