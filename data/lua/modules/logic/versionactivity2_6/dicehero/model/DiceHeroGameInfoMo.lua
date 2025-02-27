module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroGameInfoMo", package.seeall)

slot0 = pureTable("DiceHeroGameInfoMo")

function slot0.init(slot0, slot1)
	slot0.chapter = slot1.chapter
	slot0.heroBaseInfo = DiceHeroHeroBaseInfoMo.New()

	slot0.heroBaseInfo:init(slot1.heroBaseInfo)

	slot0.rewardItems = {}

	for slot5, slot6 in pairs(slot1.panel.rewardItems) do
		slot0.rewardItems[slot5] = DiceHeroRewardMo.New()

		slot0.rewardItems[slot5]:init(slot6)
	end

	slot0.allLevelCos = DiceHeroConfig.instance:getLevelCos(slot0.chapter)
	slot0.co = slot0.allLevelCos[#slot1.passLevelIds + 1] or slot0.allLevelCos[slot2] or slot0.allLevelCos[1]
	slot0.currLevel = slot0.co and slot0.co.id or 0
	slot0.allPass = slot2 == #slot0.allLevelCos
end

function slot0.hasReward(slot0)
	return #slot0.rewardItems > 0
end

return slot0
