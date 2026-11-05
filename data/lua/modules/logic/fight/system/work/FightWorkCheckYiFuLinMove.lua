-- chunkname: @modules/logic/fight/system/work/FightWorkCheckYiFuLinMove.lua

module("modules.logic.fight.system.work.FightWorkCheckYiFuLinMove", package.seeall)

local FightWorkCheckYiFuLinMove = class("FightWorkCheckYiFuLinMove", FightWorkItem)

function FightWorkCheckYiFuLinMove:onStart()
	local entityList = FightDataHelper.entityMgr:getSideList(FightEnum.EntitySide.MySide)

	if not entityList or #entityList < 1 then
		return self:onDone(true)
	end

	local targetEntityList = {}

	for _, entityMO in ipairs(entityList) do
		if entityMO:hasBuffFeature(FightEnum.BuffFeature.PositionSortSelect) then
			table.insert(targetEntityList, entityMO.uid)

			break
		end
	end

	if #targetEntityList < 1 then
		return self:onDone(true)
	end

	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
	self:cancelFightWorkSafeTimer()
	ViewMgr.instance:openView(ViewName.FightYiFuLinMoveView, {
		entityId = targetEntityList[1]
	})
end

function FightWorkCheckYiFuLinMove:_onRespUseClothSkillFail()
	logError("伊芙琳 位置交换失败")
	ViewMgr.instance:closeView(ViewName.FightYiFuLinMoveView)
	self:onDone(true)
end

function FightWorkCheckYiFuLinMove:clearWork()
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
end

return FightWorkCheckYiFuLinMove
