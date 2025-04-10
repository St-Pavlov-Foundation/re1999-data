module("modules.logic.fight.system.work.FightWorkEffectMiss", package.seeall)

slot0 = class("FightWorkEffectMiss", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0.actEffectData.targetId) then
		FightFloatMgr.instance:float(slot0.actEffectData.targetId, FightEnum.FloatType.buff, luaLang("fight_float_miss"), FightEnum.BuffFloatEffectType.Good)
	end

	slot0:onDone(true)
end

return slot0
