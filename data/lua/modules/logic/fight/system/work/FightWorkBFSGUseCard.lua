module("modules.logic.fight.system.work.FightWorkBFSGUseCard", package.seeall)

slot0 = class("FightWorkBFSGUseCard", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getVersion() >= 1 and slot0.actEffectData.teamType ~= FightEnum.TeamType.MySide then
		slot0:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
