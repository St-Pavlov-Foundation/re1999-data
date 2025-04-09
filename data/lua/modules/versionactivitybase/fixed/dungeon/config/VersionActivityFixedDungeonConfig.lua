module("modules.versionactivitybase.fixed.dungeon.config.VersionActivityFixedDungeonConfig", package.seeall)

slot0 = class("VersionActivityFixedDungeonConfig", BaseConfig)

function slot1(slot0)
	if DungeonConfig.instance:getEpisodeCO(slot0).chapterId ~= VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.ElementFight then
		if slot1.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Hard then
			slot1 = DungeonConfig.instance:getEpisodeCO(slot0 - 10000)
		else
			while slot1.chapterId ~= VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story do
				slot1 = DungeonConfig.instance:getEpisodeCO(slot1.preEpisode)
			end
		end
	end

	return slot1
end

function slot0.getEpisodeMapConfig(slot0, slot1)
	return DungeonConfig.instance:getChapterMapCfg(VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story, uv0(slot1).preEpisode)
end

function slot0.checkElementBelongMapId(slot0, slot1, slot2)
	return tabletool.indexOf({
		slot1.mapId
	}, slot2)
end

function slot0.getEpisodeIndex(slot0, slot1)
	slot2 = uv0(slot1)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot2.chapterId, slot2.id)
end

function slot0.getStoryEpisodeCo(slot0, slot1)
	return uv0(slot1)
end

function slot0.getEpisodeIdByElementId(slot0, slot1)
	return DungeonConfig.instance:getChapterMapElement(slot1).mapId
end

slot0.instance = slot0.New()

return slot0
