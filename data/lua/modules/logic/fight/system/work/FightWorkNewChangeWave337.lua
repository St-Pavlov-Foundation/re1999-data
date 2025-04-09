module("modules.logic.fight.system.work.FightWorkNewChangeWave337", package.seeall)

slot0 = class("FightWorkNewChangeWave337", FightEffectBase)

function slot0.onStart(slot0)
	slot1 = slot0:com_registWorkDoneFlowSequence()

	slot1:registWork(Work2FightWork, FightWorkStepChangeWave, slot0.actEffectData.fight)
	slot1:registWork(Work2FightWork, FightWorkAppearTimeline)
	slot1:registWork(Work2FightWork, FightWorkStartBornEnemy)
	slot1:registWork(Work2FightWork, FightWorkFocusMonster)
	slot1:registWork(FightWorkFunction, slot0.sendChangeWaveEvent, slot0)
	slot1:start({})
end

function slot0.sendChangeWaveEvent(slot0)
	FightController.instance:beginWave()
end

return slot0
