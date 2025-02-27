module("modules.logic.tower.model.TowerSubEpisodeMo", package.seeall)

slot0 = pureTable("TowerSubEpisodeMo")

function slot0.updateInfo(slot0, slot1)
	slot0.episodeId = slot1.episodeId
	slot0.status = slot1.status
	slot0.heros = slot1.heros
	slot0.assistBossId = slot1.assistBossId
	slot0.heroIds = {}
	slot0.equipUids = {}

	if slot0.heros then
		for slot5 = 1, #slot0.heros do
			slot0.heroIds[slot5] = slot0.heros[slot5] and slot6.heroId or 0

			if slot6 and slot6.equipUid and #slot6.equipUid > 0 then
				slot0.equipUids[slot5] = {}

				for slot10 = 1, #slot6.equipUid do
					table.insert(slot0.equipUids[slot5], slot6.equipUid[slot10])
				end
			end
		end
	end
end

function slot0.getHeros(slot0, slot1)
	if slot0.status == 1 and slot0.heroIds then
		for slot5 = 1, #slot0.heroIds do
			slot1[slot0.heroIds[slot5]] = 1
		end
	end
end

function slot0.getAssistBossId(slot0, slot1)
	if slot0.status == 1 and slot0.assistBossId then
		slot1[slot0.assistBossId] = 1
	end
end

return slot0
