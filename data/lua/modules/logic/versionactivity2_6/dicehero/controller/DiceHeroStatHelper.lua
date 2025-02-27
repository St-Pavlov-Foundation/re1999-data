module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroStatHelper", package.seeall)

slot0 = class("DiceHeroStatHelper")

function slot0.ctor(slot0)
	slot0._useCardsRecords = {}
	slot0._gameBeginDt = 0
	slot0._talkBeginDt = 0
end

function slot0.resetGameDt(slot0)
	slot0._gameBeginDt = UnityEngine.Time.realtimeSinceStartup

	slot0:clearUseCard()
end

function slot0.resetTalkDt(slot0)
	slot0._talkBeginDt = UnityEngine.Time.realtimeSinceStartup
end

function slot0.clearUseCard(slot0)
	slot0._useCardsRecords = {}
end

function slot0.addUseCard(slot0, slot1)
	if not DiceHeroFightModel.instance:getGameData() then
		return
	end

	for slot6, slot7 in ipairs(slot0._useCardsRecords) do
		if slot7.round == slot2.round then
			table.insert(slot7.skills, slot1)

			return
		end
	end

	table.insert(slot0._useCardsRecords, {
		round = slot2.round,
		skills = {
			slot1
		}
	})
end

function slot0.sendFightEnd(slot0, slot1, slot2)
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(DiceHeroFightModel.instance:getGameData().enemyHeros) do
		table.insert(slot4, slot10.hp)
		table.insert(slot5, slot10.shield)
	end

	StatController.instance:track(StatEnum.EventName.DiceHero_FightEnd, {
		[StatEnum.EventProperties.DiceHero_ActId] = tostring(VersionActivity2_6Enum.ActivityId.DiceHero),
		[StatEnum.EventProperties.DiceHero_EpisodeId] = tostring(DiceHeroModel.instance.guideLevel),
		[StatEnum.EventProperties.DiceHero_OperTpye] = slot1 and "settle" or "giveup",
		[StatEnum.EventProperties.DiceHero_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0._gameBeginDt,
		[StatEnum.EventProperties.DiceHero_RoundNum] = slot3 and slot3.round or 0,
		[StatEnum.EventProperties.DiceHero_Result] = tostring(slot1 or DiceHeroEnum.GameStatu.None),
		[StatEnum.EventProperties.DiceHero_IsFirst] = slot2 or false,
		[StatEnum.EventProperties.DiceHero_FightObj] = {
			hero = slot3.allyHero.id,
			relics = slot0:getClone(slot3.allyHero.relicIds),
			hp_init = slot3.initHp,
			hp = slot3.allyHero.hp,
			shield = slot3.allyHero.shield,
			enemy_hp = slot4,
			ememy_shield = slot5
		},
		[StatEnum.EventProperties.DiceHero_SkillInfo] = slot0._useCardsRecords
	})
end

function slot0.sendStoryEnd(slot0, slot1, slot2)
	StatController.instance:track(StatEnum.EventName.DiceHero_StoryEnd, {
		[StatEnum.EventProperties.DiceHero_ActId] = tostring(VersionActivity2_6Enum.ActivityId.DiceHero),
		[StatEnum.EventProperties.DiceHero_EpisodeId] = tostring(DiceHeroModel.instance.guideLevel),
		[StatEnum.EventProperties.DiceHero_OperTpye] = slot1 and "settle" or "giveup",
		[StatEnum.EventProperties.DiceHero_TalkId] = DiceHeroModel.instance.talkId,
		[StatEnum.EventProperties.DiceHero_StepId] = DiceHeroModel.instance.stepId,
		[StatEnum.EventProperties.DiceHero_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0._talkBeginDt,
		[StatEnum.EventProperties.DiceHero_IsFirst] = slot2 or false
	})
end

function slot0.sendReset(slot0)
	if not DiceHeroModel.instance:getGameInfo(5) then
		return
	end

	StatController.instance:track(StatEnum.EventName.DiceHero_Reset, {
		[StatEnum.EventProperties.DiceHero_ActId] = tostring(VersionActivity2_6Enum.ActivityId.DiceHero),
		[StatEnum.EventProperties.DiceHero_EpisodeId] = tostring(slot1.currLevel),
		[StatEnum.EventProperties.DiceHero_FightObj] = {
			hero = slot1.heroBaseInfo.id,
			hp = slot1.heroBaseInfo.hp,
			shield = slot1.heroBaseInfo.shield,
			relics = slot0:getClone(slot1.heroBaseInfo.relicIds)
		}
	})
end

function slot0.getClone(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		-- Nothing
	end

	return {
		[slot6] = slot7
	}
end

slot0.instance = slot0.New()

return slot0
