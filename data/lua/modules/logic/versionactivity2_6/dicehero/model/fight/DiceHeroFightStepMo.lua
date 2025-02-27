module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightStepMo", package.seeall)

slot0 = pureTable("DiceHeroFightStepMo")

function slot0.init(slot0, slot1)
	slot0.actionType = slot1.actionType
	slot0.reasonId = slot1.reasonId
	slot0.fromId = slot1.fromId
	slot0.toId = slot1.toId
	slot0.effect = {}

	for slot5, slot6 in ipairs(slot1.effect) do
		slot0.effect[slot5] = DiceHeroFightEffectMo.New()

		slot0.effect[slot5]:init(slot6, slot0)
	end

	slot0.isByCard = false
	slot0.isByHero = false

	if slot0.actionType == 1 then
		slot0.isByCard = DiceHeroFightModel.instance:getGameData().skillCardsBySkillId[tonumber(slot0.reasonId)] and slot3.co.type ~= DiceHeroEnum.CardType.Hero
		slot0.isByHero = slot2.allyHero.uid == slot0.fromId
	end
end

return slot0
