module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6StatHelper", package.seeall)

slot0 = class("LengZhou6StatHelper")

function slot0.ctor(slot0)
	slot0._episodeId = nil
	slot0._endless_library_round = 0
	slot0._result = nil
	slot0._beginTime = 0
	slot0._useRound = 0
	slot0._playerHp = 0
	slot0._enemyHp = 0
	slot0._skill_ids = {}
	slot0._skill_usages = {}
	slot0._isEndless = false
end

function slot0.enterGame(slot0)
	slot0._episodeId = LengZhou6Model.instance:getCurEpisodeId()

	if LengZhou6Model.instance:getEpisodeInfoMo(slot0._episodeId) then
		slot0._isEndless = slot1:isEndlessEpisode()
	end

	slot0._beginTime = os.time()
	slot0._useRound = 0

	tabletool.clear(slot0._skill_ids)
	tabletool.clear(slot0._skill_usages)
end

function slot0.setGameResult(slot0, slot1)
	slot0._result = slot1
end

function slot0.updateRound(slot0)
	slot0._useRound = slot0._useRound + 1
end

function slot0.addUseSkillId(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot2 = true

	for slot6, slot7 in ipairs(slot0._skill_ids) do
		if slot7 == slot1 then
			slot2 = false

			break
		end
	end

	if slot2 then
		table.insert(slot0._skill_ids, slot1)
	end
end

function slot0.addUseSkillInfo(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot2 = true

	for slot6 = 1, #slot0._skill_usages do
		if slot0._skill_usages[slot6].skill_id == slot1 then
			slot7.skill_num = slot7.skill_num + 1
			slot2 = false

			break
		end
	end

	if slot2 then
		table.insert(slot0._skill_usages, {
			skill_num = 1,
			skill_id = slot1
		})
	end
end

function slot0.setPlayerAndEnemyHp(slot0, slot1, slot2)
	slot0._playerHp = slot1
	slot0._enemyHp = slot2
end

function slot0.sendGameExit(slot0)
	slot2 = LengZhou6GameModel.instance:getEnemy()

	if LengZhou6GameModel.instance:getPlayer() and slot2 then
		slot0:setPlayerAndEnemyHp(slot1:getHp(), slot2:getHp())
	end

	slot3 = ""

	if slot0._isEndless then
		slot3 = tostring(LengZhou6GameModel.instance:getEndLessModelLayer())
	end

	StatController.instance:track(StatEnum.EventName.ExitHissabethActivity, {
		[StatEnum.EventProperties.LengZhou6_EpisodeId] = tostring(slot0._episodeId),
		[StatEnum.EventProperties.LengZhou6_EndlessLibraryRound] = slot3,
		[StatEnum.EventProperties.LengZhou6_Result] = tostring(slot0._result),
		[StatEnum.EventProperties.LengZhou6_UseTime] = os.time() - slot0._beginTime,
		[StatEnum.EventProperties.LengZhou6_TotalRound] = slot0._useRound,
		[StatEnum.EventProperties.LengZhou6_OurRemainingHP] = slot0._playerHp,
		[StatEnum.EventProperties.LengZhou6_EnemyRemainingHP] = slot0._enemyHp,
		[StatEnum.EventProperties.LengZhou6_SkillId] = slot0._skill_ids,
		[StatEnum.EventProperties.LengZhou6_SkillUsage] = slot0._skill_usages
	})
end

slot0.instance = slot0.New()

return slot0
