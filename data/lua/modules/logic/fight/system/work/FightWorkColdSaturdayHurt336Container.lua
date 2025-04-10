module("modules.logic.fight.system.work.FightWorkColdSaturdayHurt336Container", package.seeall)

slot0 = class("FightWorkColdSaturdayHurt336Container", FightStepEffectFlow)

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect({
		[FightEnum.EffectType.BUFFADD] = true,
		[FightEnum.EffectType.BUFFDEL] = true,
		[FightEnum.EffectType.BUFFUPDATE] = true,
		[FightEnum.EffectType.NONE] = true,
		[FightEnum.EffectType.DAMAGE] = true,
		[FightEnum.EffectType.CRIT] = true
	}, true)
end

function slot0.clearWork(slot0)
end

return slot0
