module("modules.logic.fight.system.work.FightWorkZXQRemoveCard", package.seeall)

slot0 = class("FightWorkZXQRemoveCard", FightEffectBase)

function slot0.onStart(slot0)
	if slot0.actEffectData.teamType ~= FightEnum.TeamType.MySide then
		slot0:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
