-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikeSkill1Comp.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikeSkill1Comp", package.seeall)

local DeleikeSkill1Comp = class("DeleikeSkill1Comp", LuaCompBase)

function DeleikeSkill1Comp:init(go)
	self.skillId = 1
	self.go = go
	self.transform = go.transform
	self.childItems = {}

	for _, v in pairs(DeleikeEnum.LineStatus) do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(go, tostring(v))
		item.anim = gohelper.findComponentAnim(item.go)
		self.childItems[v] = item
	end

	self:setLineStatus(DeleikeEnum.LineStatus.CanCut)
end

function DeleikeSkill1Comp:onDestroy()
	TaskDispatcher.cancelTask(self.delayHide, self)
end

function DeleikeSkill1Comp:setLineStatus(status)
	if self.status == status then
		return
	end

	self.status = status

	for k, item in pairs(self.childItems) do
		gohelper.setActive(item.go, k == status)

		if k == status then
			item.anim:Play("switch_in", 0, 0)
		end
	end
end

function DeleikeSkill1Comp:onTrigger(leftQuad, rightQuad, centerX, centerY, dirX, dirY, length)
	if not leftQuad or not rightQuad then
		return
	end

	local toProcess = DeleikeHelper.getSharedTiles()

	for i = 1, #toProcess do
		local comp = toProcess[i]

		if not gohelper.isNil(comp.go) then
			DeleikeClipHelper.ClipTile(comp, leftQuad, rightQuad, true)
		end
	end

	DeleikeGameMgr.instance:addLineTile(centerX, centerY, dirX, dirY)

	local bx = centerX + dirX * length
	local by = centerY + dirY * length

	self:_applyMove(bx, by, dirX, dirY, length)
	self:_eatTriggersInSkillBox(centerX, centerY, dirX, dirY, length)
end

function DeleikeSkill1Comp:_applyMove(bx, by, dirX, dirY, length)
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if not unitCoord then
		return
	end

	local behindUnits = unitCoord:getUnitsBehindB(bx, by, dirX, dirY)

	unitCoord:moveUnitsAnimated(behindUnits, -dirX * length, -dirY * length)
end

function DeleikeSkill1Comp:_eatTriggersInSkillBox(centerX, centerY, dirX, dirY, length)
	local perpX, perpY = -dirY, dirX
	local hw = DeleikeEnum.SkillWidth * 0.5
	local endX = centerX + dirX * length
	local endY = centerY + dirY * length
	local quad = {
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
	local unitCoord = DeleikeGameMgr.instance.unitCoord
	local triggers = unitCoord and unitCoord.triggerList or {}

	for i = 1, #triggers do
		local comp = triggers[i]

		if comp.tryEat and not gohelper.isNil(comp.go) and not comp.isCollected and DeleikeCollision.pointInConvexPoly(comp.worldPos.x, comp.worldPos.y, quad) then
			comp:tryEat()
		end
	end
end

function DeleikeSkill1Comp:fadeIn()
	TaskDispatcher.cancelTask(self.delayHide, self)
	gohelper.setActive(self.go, true)

	local item = self.childItems[self.status]

	item.anim:Play("open", 0, 0)
end

function DeleikeSkill1Comp:fadeOut()
	local item = self.childItems[self.status]

	item.anim:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayHide, self, 0.16)
end

function DeleikeSkill1Comp:delayHide()
	gohelper.setActive(self.go, false)
end

return DeleikeSkill1Comp
