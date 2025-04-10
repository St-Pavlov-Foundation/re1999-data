module("modules.logic.fight.model.data.FightCardInfoData", package.seeall)

slot0 = FightDataClass("FightCardInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0:initClientData()

	slot0.uid = slot1.uid
	slot0.skillId = slot1.skillId
	slot0.cardEffect = slot1.cardEffect or 0
	slot0.tempCard = slot1.tempCard or false
	slot0.enchants = {}

	if slot1.enchants then
		for slot5, slot6 in ipairs(slot1.enchants) do
			slot7 = {
				enchantId = slot6.enchantId,
				duration = slot6.duration,
				exInfo = {}
			}

			for slot11, slot12 in ipairs(slot6.exInfo) do
				table.insert(slot7.exInfo, slot12)
			end

			table.insert(slot0.enchants, slot7)
		end
	end

	slot0.cardType = slot1.cardType or FightEnum.CardType.NONE
	slot0.heroId = slot1.heroId or 0
	slot0.status = slot1.status or FightEnum.CardInfoStatus.STATUS_NONE
	slot0.targetUid = slot1.targetUid or "0"
	slot0.energy = slot1.energy or 0
	slot0.areaRedOrBlue = slot1.areaRedOrBlue
	slot0.heatId = slot1.heatId or 0
end

function slot0.initClientData(slot0)
	slot1 = FightClientData.New()
	slot1.custom_lock = nil
	slot1.custom_enemyCardIndex = nil
	slot1.custom_playedCard = nil
	slot1.custom_handCardIndex = nil
	slot1.custom_color = FightEnum.CardColor.None
	slot1.custom_fromSkillId = 0
	slot0.clientData = slot1
end

function slot0.isBigSkill(slot0)
	return FightCardDataHelper.isBigSkill(slot0.skillId)
end

function slot0.clone(slot0)
	return FightDataUtil.copyData(slot0)
end

return slot0
