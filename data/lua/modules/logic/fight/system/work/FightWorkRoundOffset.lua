module("modules.logic.fight.system.work.FightWorkRoundOffset", package.seeall)

slot0 = class("FightWorkRoundOffset", FightEffectBase)

function slot0.onStart(slot0)
	FightModel.instance.maxRound = FightModel.instance.maxRound + slot0._actEffectMO.effectNum

	FightModel.instance:setRoundOffset(slot0._actEffectMO.effectNum)
	FightController.instance:dispatchEvent(FightEvent.RefreshUIRound)

	return slot0:onDone(true)
end

return slot0
