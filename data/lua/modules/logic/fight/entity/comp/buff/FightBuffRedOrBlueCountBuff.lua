module("modules.logic.fight.entity.comp.buff.FightBuffRedOrBlueCountBuff", package.seeall)

slot0 = class("FightBuffRedOrBlueCountBuff")

function slot0.ctor(slot0)
end

function slot0.onBuffStart(slot0, slot1, slot2)
	slot0.entityMo = slot1:getMO()
	slot0.side = slot0.entityMo.side

	if slot0.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCountBuff(slot2)
	end
end

function slot0.clear(slot0)
	if slot0.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCountBuff(nil)
	end
end

function slot0.onBuffEnd(slot0)
	slot0:clear()
end

function slot0.dispose(slot0)
	slot0:clear()
end

return slot0
