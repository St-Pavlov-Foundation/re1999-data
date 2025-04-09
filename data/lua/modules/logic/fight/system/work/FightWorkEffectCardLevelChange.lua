module("modules.logic.fight.system.work.FightWorkEffectCardLevelChange", package.seeall)

slot0 = class("FightWorkEffectCardLevelChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.cardIndex = tonumber(slot0.actEffectData.targetId)
	slot0.oldSkillId = FightDataHelper.handCardMgr.handCard[slot0.cardIndex] and slot2.skillId
end

function slot0.onStart(slot0)
	slot0:_startChangeCardEffect()
end

function slot0._startChangeCardEffect(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0.actEffectData) then
		slot0:onDone(true)

		return
	end

	if FightModel.instance:getVersion() < 1 then
		if not FightHelper.getEntity(slot0.actEffectData.entity.id) then
			slot0:onDone(true)

			return
		end

		if not slot3:isMySide() then
			slot0:onDone(true)

			return
		end
	end

	if not slot0.oldSkillId then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	if FightModel.instance:getVersion() >= 4 then
		FightController.instance:dispatchEvent(FightEvent.CardLevelChange, slot0.cardIndex, slot0.oldSkillId)
		slot0:com_registTimer(slot0._delayDone, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
