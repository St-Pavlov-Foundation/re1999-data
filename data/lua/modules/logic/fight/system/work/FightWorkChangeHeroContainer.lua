module("modules.logic.fight.system.work.FightWorkChangeHeroContainer", package.seeall)

slot0 = class("FightWorkChangeHeroContainer", FightStepEffectFlow)

function slot0.onStart(slot0)
	for slot8, slot9 in ipairs(slot0:getAdjacentSameEffectList({
		[FightEnum.EffectType.CALLMONSTERTOSUB] = true
	}, true)) do
		slot0:com_registWorkDoneFlowSequence():registWork(FightWorkFlowParallel):registWork(FightStepBuilder.ActEffectWorkCls[slot9.actEffectData.effectType], slot9.fightStepData, slot9.actEffectData)
	end

	slot3:registWork(FightWorkFocusMonsterAfterChangeHero)
	slot3:start()
end

function slot0._showSubEntity(slot0)
	GameSceneMgr.instance:getCurScene().entityMgr:showSubEntity()
end

function slot0.clearWork(slot0)
end

return slot0
