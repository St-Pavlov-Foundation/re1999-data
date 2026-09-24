-- chunkname: @modules/logic/versionactivity4_0/deleike/model/DeleikeSkillMgr.lua

module("modules.logic.versionactivity4_0.deleike.model.DeleikeSkillMgr", package.seeall)

local DeleikeSkillMgr = class("DeleikeSkillMgr")
local Input = UnityEngine.Input
local Time = UnityEngine.Time
local SKILL2_THICK = 10
local SIDE_EXTENT = DeleikeEnum.SkillWidth

function DeleikeSkillMgr:init(goLine1, goLine2)
	self.skill1 = MonoHelper.addNoUpdateLuaComOnceToGo(goLine1, DeleikeSkill1Comp)
	self.skill2 = MonoHelper.addNoUpdateLuaComOnceToGo(goLine2, DeleikeSkill2Comp)

	self.skill2:resetForReuse()

	self.curSkill = nil
	self._isVisible = false
	self._sideLeft = nil
	self._sideRight = nil

	gohelper.setActive(self.skill1.go, false)
	gohelper.setActive(self.skill2.go, false)

	self.isCharging = false
	self.activeSkillId = 1
	self._chargeCenterX, self._chargeCenterY = 0, 0
	self._chargeDirX, self._chargeDirY = 1, 0
	self._chargeLength = 0
	self._chargeWidth = 0
	self._chargeStartTime = 0
	self._dragPressed = false

	UpdateBeat:Add(self.onUpdate, self)
end

function DeleikeSkillMgr:dispose()
	UpdateBeat:Remove(self.onUpdate, self)
	self:_hideSkillLine()

	if self.player then
		self.player:setCharging(false)
	end
end

function DeleikeSkillMgr:onUpdate()
	if self.isCharging then
		self:_refreshChargeCenter()
		self:updateCharge()
	end

	self:updateChargeVisual()
	self:_updateDragAutoCancel()
	self:_updateScreenDrag()
end

function DeleikeSkillMgr:_updateScreenDrag()
	local skill2 = self.skill2

	if not skill2 or not skill2.dragActive then
		return
	end

	local mgr = DeleikeGameMgr.instance

	if not mgr.sceneRootRt then
		return
	end

	if Input.GetMouseButton(0) then
		local pos = recthelper.screenPosToAnchorPos(Input.mousePosition, mgr.sceneRootRt)

		skill2:processDrag(pos.x, pos.y, true)

		self._dragPressed = true
	elseif self._dragPressed then
		skill2:processDrag(0, 0, false)

		self._dragPressed = false
	end
end

function DeleikeSkillMgr:_updateDragAutoCancel()
	if not self.skill2 or not self.skill2.dragActive or not self.player then
		return
	end

	local px, py = self.player:getLogicPos()

	if self.skill2:isPlayerInDragZone(px, py) then
		self.skill2:cancelDrag()

		self._dragPressed = false
	end
end

function DeleikeSkillMgr:_isSkillBlocked()
	return self.skill2 ~= nil and self.skill2.dragActive
end

function DeleikeSkillMgr:onSkillBtnDragBegin(skillId)
	if self:_isSkillBlocked() then
		return
	end

	self.activeSkillId = skillId

	if self:_canCharge() then
		self:startCharge()
	end
end

function DeleikeSkillMgr:onSkillBtnDragMove(dx, dy)
	if self:_isSkillBlocked() then
		return
	end

	if not self.isCharging then
		return
	end

	local lenSq = dx * dx + dy * dy

	if lenSq < 0.0001 then
		return
	end

	local len = math.sqrt(lenSq)

	self:_refreshChargeDir(dx / len, dy / len)
end

function DeleikeSkillMgr:onSkillBtnDragEnd(cancelled)
	if self:_isSkillBlocked() then
		return
	end

	if not self.isCharging then
		return
	end

	if cancelled then
		self:cancelCharge()
	else
		self:releaseSkill()
	end
end

function DeleikeSkillMgr:cancelCharge()
	if not self.isCharging then
		return
	end

	self.isCharging = false

	self.player:setCharging(false)
	self:_hideSkillLine()
end

function DeleikeSkillMgr:cancelDrag()
	self._dragPressed = false

	if self.skill2 and self.skill2.dragActive then
		self.skill2:cancelDrag()
	end
end

function DeleikeSkillMgr:resetState()
	self:cancelDrag()

	if self.isCharging then
		self:cancelCharge()
	end
end

function DeleikeSkillMgr:_canCharge()
	if not self.player then
		return false
	end

	local skillCount = self.player:getSkillCount(self.activeSkillId)

	return skillCount ~= nil and skillCount > 0
end

function DeleikeSkillMgr:_refreshChargeCenter()
	if not self.player then
		return
	end

	local px, py = self.player:getLogicPos()

	self._chargeCenterX = px + self._chargeDirX * DeleikeEnum.PlayerRadius
	self._chargeCenterY = py + self._chargeDirY * DeleikeEnum.PlayerRadius
end

function DeleikeSkillMgr:_refreshChargeDir(dirX, dirY)
	self._chargeDirX, self._chargeDirY = dirX, dirY

	self:_refreshChargeCenter()
end

function DeleikeSkillMgr:startCharge()
	self.isCharging = true
	self._chargeStartTime = Time.time
	self._chargeLength = 0
	self._chargeWidth = 0

	self:_switchSkill(self.activeSkillId)
	self:_refreshChargeDir(1, 0)
	self.player:setCharging(true)
end

function DeleikeSkillMgr:_buildBlockQuad()
	local centerX, centerY = self._chargeCenterX, self._chargeCenterY
	local dirX, dirY = self._chargeDirX, self._chargeDirY
	local perpX, perpY = -dirY, dirX
	local hw, len

	if self.activeSkillId == 1 then
		hw = DeleikeEnum.SkillWidth * 0.5
		len = self._chargeLength
	else
		hw = self._chargeWidth * 0.5
		len = SKILL2_THICK
	end

	local endX = centerX + dirX * len
	local endY = centerY + dirY * len

	return {
		{
			x = centerX - perpX * hw,
			y = centerY - perpY * hw
		},
		{
			x = endX - perpX * hw,
			y = endY - perpY * hw
		},
		{
			x = endX + perpX * hw,
			y = endY + perpY * hw
		},
		{
			x = centerX + perpX * hw,
			y = centerY + perpY * hw
		}
	}
end

function DeleikeSkillMgr:refreshUncutMarks()
	local blockQuad = self:_buildBlockQuad()
	local blocked = false
	local unitCoord = DeleikeGameMgr.instance.unitCoord
	local unitList = unitCoord and unitCoord.unitList or {}

	for i = 1, #unitList do
		local comp = unitList[i]
		local mo = comp.mo

		if mo and mo.tileType == DeleikeEnum.TileType.Anchor and not gohelper.isNil(comp.go) then
			local hit = DeleikeCollision.convexPolysOverlap(blockQuad, comp:getWorldPolygon())

			if hit then
				blocked = true
			end

			gohelper.setActive(comp.goUncut, hit)
		end
	end

	local half = DeleikeEnum.GridUnit * 0.5
	local triggers = unitCoord and unitCoord.triggerList or {}

	for i = 1, #triggers do
		local comp = triggers[i]

		if comp.isDoor and not comp.isCollected and not gohelper.isNil(comp.go) then
			local wx, wy = comp.worldPos.x, comp.worldPos.y
			local doorQuad = {
				{
					x = wx - half,
					y = wy - half
				},
				{
					x = wx - half,
					y = wy + half
				},
				{
					x = wx + half,
					y = wy + half
				},
				{
					x = wx + half,
					y = wy - half
				}
			}
			local hit = DeleikeCollision.convexPolysOverlap(blockQuad, doorQuad)

			if hit then
				blocked = true
			end

			if comp.goUncut then
				gohelper.setActive(comp.goUncut, hit)
			end
		end
	end

	return blocked
end

function DeleikeSkillMgr:clearUncutMarks()
	local unitCoord = DeleikeGameMgr.instance.unitCoord
	local unitList = unitCoord and unitCoord.unitList or {}

	for i = 1, #unitList do
		local comp = unitList[i]
		local mo = comp.mo

		if mo and mo.tileType == DeleikeEnum.TileType.Anchor and comp.goUncut then
			gohelper.setActive(comp.goUncut, false)
		end
	end

	local triggers = unitCoord and unitCoord.triggerList or {}

	for i = 1, #triggers do
		local comp = triggers[i]

		if comp.isDoor and comp.goUncut then
			gohelper.setActive(comp.goUncut, false)
		end
	end
end

function DeleikeSkillMgr:getLineStatus()
	if self:refreshUncutMarks() then
		return DeleikeEnum.LineStatus.UnCut
	else
		return DeleikeEnum.LineStatus.CanCut
	end
end

function DeleikeSkillMgr:updateCharge()
	local elapsed = Time.time - self._chargeStartTime

	if self.activeSkillId == 1 then
		self._chargeLength = math.min(elapsed * DeleikeEnum.Skill1ChargeRate, DeleikeEnum.Skill1MaxLength)
	else
		local w

		if elapsed <= DeleikeEnum.Skill2ChargePhase1Time then
			w = DeleikeEnum.Skill2ChargePhase1Max * (elapsed / DeleikeEnum.Skill2ChargePhase1Time)
		else
			w = DeleikeEnum.Skill2ChargePhase1Max + (DeleikeEnum.Skill2WidthMax - DeleikeEnum.Skill2ChargePhase1Max) * ((elapsed - DeleikeEnum.Skill2ChargePhase1Time) / (DeleikeEnum.Skill2ChargePhase2Time - DeleikeEnum.Skill2ChargePhase1Time))
		end

		self._chargeWidth = math.min(w, DeleikeEnum.Skill2WidthMax)
		self._chargeLength = 1
	end
end

function DeleikeSkillMgr:updateChargeVisual()
	if not self.isCharging then
		return
	end

	local status = self:getLineStatus()

	if self.activeSkillId == 1 then
		self.skill1:setLineStatus(status)
	else
		self.skill2:setLineStatus(status)
	end

	if self.activeSkillId == 2 then
		self:_updateVisual(self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeLength, self._chargeWidth * 0.5)
	else
		self:_updateVisual(self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeLength)
	end
end

function DeleikeSkillMgr:releaseSkill()
	if not self.isCharging then
		return
	end

	self.isCharging = false

	self.player:setCharging(false)

	local blocked = self:getLineStatus() == DeleikeEnum.LineStatus.UnCut
	local skillCount = self.player:getSkillCount(self.activeSkillId)

	if self.activeSkillId == 1 then
		if self._chargeLength < DeleikeEnum.Skill1MaxLength or blocked or skillCount <= 0 then
			self:_hideSkillLine()

			return
		end

		self.player:setSkillCount(self.activeSkillId, skillCount - 1)
		self:_updateVisual(self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeLength)
		self.skill1:onTrigger(self._sideLeft, self._sideRight, self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeLength)
		self:_hideSkillLine()
	else
		if self._chargeWidth < DeleikeEnum.Skill2WidthMax or blocked or skillCount <= 0 then
			self:_hideSkillLine()

			return
		end

		self.player:setSkillCount(self.activeSkillId, skillCount - 1)
		self:_updateVisual(self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeLength, self._chargeWidth * 0.5)
		self.skill2:onTrigger(self._sideLeft, self._sideRight, self._chargeCenterX, self._chargeCenterY, self._chargeDirX, self._chargeDirY, self._chargeLength)
		self:_hideSkillLine()
	end
end

function DeleikeSkillMgr:_switchSkill(skillId)
	local target = skillId == 1 and self.skill1 or self.skill2

	if self.curSkill == target then
		return
	end

	if self.curSkill then
		gohelper.setActive(self.curSkill.go, false)
	end

	self.curSkill = target

	if self._isVisible then
		gohelper.setActive(self.curSkill.go, true)
	end
end

function DeleikeSkillMgr:_updateVisual(centerX, centerY, dirX, dirY, length, halfWidth)
	halfWidth = halfWidth or DeleikeEnum.SkillWidth * 0.5

	if dirX == 0 and dirY == 0 or length < 1 then
		return
	end

	local perpX, perpY = -dirY, dirX
	local hw = halfWidth
	local endX = centerX + dirX * length
	local endY = centerY + dirY * length
	local ext = SIDE_EXTENT

	self._sideLeft = {
		{
			x = centerX - perpX * hw - dirX * ext,
			y = centerY - perpY * hw - dirY * ext
		},
		{
			x = centerX + perpX * hw - dirX * ext,
			y = centerY + perpY * hw - dirY * ext
		},
		{
			x = centerX + perpX * hw,
			y = centerY + perpY * hw
		},
		{
			x = centerX - perpX * hw,
			y = centerY - perpY * hw
		}
	}
	self._sideRight = {
		{
			x = endX - perpX * hw,
			y = endY - perpY * hw
		},
		{
			x = endX + perpX * hw,
			y = endY + perpY * hw
		},
		{
			x = endX + perpX * hw + dirX * ext,
			y = endY + perpY * hw + dirY * ext
		},
		{
			x = endX - perpX * hw + dirX * ext,
			y = endY - perpY * hw + dirY * ext
		}
	}

	if self.activeSkillId == 1 then
		local midX = centerX + dirX * length * 0.5
		local midY = centerY + dirY * length * 0.5

		self:_updateLine(self.skill1.transform, midX, midY, perpX, perpY, DeleikeEnum.SkillWidth, length)
	else
		local midX = centerX + dirX * SKILL2_THICK * 0.5
		local midY = centerY + dirY * SKILL2_THICK * 0.5

		self:_updateLine(self.skill2.transform, midX, midY, perpX, perpY, hw * 2, SKILL2_THICK)
	end

	self:_showSkillLine()
end

function DeleikeSkillMgr:_updateLine(transform, px, py, perpX, perpY, width, height)
	recthelper.setAnchor(transform, px, py)

	local angle = math.deg(math.atan2(perpY, perpX))

	transformhelper.setLocalRotation(transform, 0, 0, angle)
	recthelper.setSize(transform, width, height)
end

function DeleikeSkillMgr:_showSkillLine()
	if self._isVisible then
		return
	end

	self._isVisible = true

	if self.curSkill then
		self.curSkill:fadeIn()
	end
end

function DeleikeSkillMgr:_hideSkillLine()
	if not self._isVisible then
		return
	end

	self._isVisible = false

	if self.curSkill then
		self.curSkill:fadeOut()
	end

	self:clearUncutMarks()

	self._sideLeft = nil
	self._sideRight = nil
end

return DeleikeSkillMgr
