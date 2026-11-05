-- chunkname: @modules/logic/versionactivity4_1/peishita/view/comp/PeiShiTaMovableComp.lua

module("modules.logic.versionactivity4_1.peishita.view.comp.PeiShiTaMovableComp", package.seeall)

local PeiShiTaMovableComp = class("PeiShiTaMovableComp", PeiShiTaUnitComp)

function PeiShiTaMovableComp:init(go)
	PeiShiTaMovableComp.super.init(self, go)

	self._faceRight = true
	self._goHitEffect = gohelper.findChild(go, "#go_hit")
end

function PeiShiTaMovableComp:addEventListeners()
	PeiShiTaMovableComp.super.addEventListeners(self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitRemove, self._onUnitRemove, self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitMove, self._onUnitMove, self)
end

function PeiShiTaMovableComp:_refreshPos()
	local x, y = self:_getGridPos()

	self:_setGridPos(x, y, true)
end

function PeiShiTaMovableComp:_setGridPos(x, y, isInstant)
	GameUtil.onDestroyViewMember_TweenId(self, "_moveTweenId")

	local localX, localY = PeiShiTaGameHelper.gridToLocalPos(x, y)

	self._posTargetX, self._posTargetY = x, y

	local moveDir = PeiShiTaGameHelper.calcMoveDir(self._unitX, self._unitY, x, y)
	local distance = math.max(math.abs(x - self._unitX), math.abs(y - self._unitY))

	self._moveDir = moveDir

	self:_setFaceDir(moveDir)

	self._unitX = x
	self._unitY = y

	if isInstant then
		recthelper.setAnchor(self.transform, localX, localY)

		return
	end

	self:_startPlayMove(moveDir)

	local moveTime = PeiShiTaGameConfig.instance:getUnitMoveTime(self._unitType) * distance

	self._moveTweenId = ZProj.TweenHelper.DOAnchorPos(self.transform, localX, localY, moveTime, self._onMoveDoneCallback, self)
end

function PeiShiTaMovableComp:_setFaceDir(dir)
	if dir == PeiShiTaEnum.Direction.Left then
		self._faceRight = false
	elseif dir == PeiShiTaEnum.Direction.Right then
		self._faceRight = true
	else
		return
	end

	self:_applyFaceScale()
end

function PeiShiTaMovableComp:_applyFaceScale()
	local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(self._tranIcon)
	local absScaleX = math.abs(scaleX)

	transformhelper.setLocalScale(self._tranIcon, self._faceRight and absScaleX or -absScaleX, scaleY, scaleZ)
end

function PeiShiTaMovableComp:_startPlayMove()
	return
end

function PeiShiTaMovableComp:_onMoveDoneCallback()
	PeiShiTaGameController.instance:dispatchEvent(PeiShiTaEvent.OnMoveAnimDone, self._id)
end

function PeiShiTaMovableComp:_onUnitRemove(unit)
	if not self._inUse or not unit or self._id ~= unit.id then
		return
	end

	self._animator:Play("die", self._reallyRetire, self)
end

function PeiShiTaMovableComp:_onUnitMove(id, x, y)
	if not self._inUse or self._id ~= id then
		return
	end

	self:_setGridPos(x, y, false)
end

function PeiShiTaMovableComp:onDestroy()
	GameUtil.onDestroyViewMember_TweenId(self, "_moveTweenId")
	PeiShiTaMovableComp.super.onDestroy(self)
end

return PeiShiTaMovableComp
