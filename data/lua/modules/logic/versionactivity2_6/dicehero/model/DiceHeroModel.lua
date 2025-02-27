module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroModel", package.seeall)

slot0 = class("DiceHeroModel", BaseModel)

function slot0.onInit(slot0)
	slot0.unlockChapterIds = {}
	slot0.gameInfos = {}
	slot0.guideChapter = 0
	slot0.guideLevel = 0
	slot0.isUnlockNewChapter = false
	slot0.talkId = 0
	slot0.stepId = 0
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initInfo(slot0, slot1)
	slot0.gameInfos = {}
	slot2 = slot0.unlockChapterIds
	slot0.unlockChapterIds = {
		[1.0] = true
	}

	for slot6, slot7 in ipairs(slot1.gameInfo) do
		slot0.gameInfos[slot7.chapter] = DiceHeroGameInfoMo.New()

		slot0.gameInfos[slot7.chapter]:init(slot7)

		if slot0.gameInfos[slot7.chapter].allPass then
			slot0.unlockChapterIds[slot7.chapter + 1] = true
		end
	end

	slot0.isUnlockNewChapter = #slot2 ~= #slot0.unlockChapterIds

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.InfoUpdate)
end

function slot0.getGameInfo(slot0, slot1)
	return slot0.gameInfos[slot1 or 1]
end

function slot0.hasReward(slot0, slot1)
	if not slot0.gameInfos[slot1 or 1] then
		return false
	end

	return slot0.gameInfos[slot1]:hasReward()
end

slot0.instance = slot0.New()

return slot0
