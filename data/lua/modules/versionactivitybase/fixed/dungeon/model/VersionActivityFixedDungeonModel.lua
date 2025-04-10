module("modules.versionactivitybase.fixed.dungeon.model.VersionActivityFixedDungeonModel", package.seeall)

slot0 = class("VersionActivityFixedDungeonModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:init()
end

function slot0.init(slot0)
	slot0:setLastEpisodeId()
	slot0:setShowInteractView()
end

function slot0.setLastEpisodeId(slot0, slot1)
	slot0.lastEpisodeId = slot1
end

function slot0.getLastEpisodeId(slot0)
	return slot0.lastEpisodeId
end

function slot0.setShowInteractView(slot0, slot1)
	slot0.isShowInteractView = slot1
end

function slot0.checkIsShowInteractView(slot0)
	return slot0.isShowInteractView
end

function slot0.setIsNotShowNewElement(slot0, slot1)
	slot0.notShowNewElement = slot1
end

function slot0.isNotShowNewElement(slot0)
	return slot0.notShowNewElement
end

function slot0.setMapNeedTweenState(slot0, slot1)
	slot0.isMapNeedTween = slot1
end

function slot0.getMapNeedTweenState(slot0)
	return slot0.isMapNeedTween
end

function slot0.getElementCoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(DungeonMapModel.instance:getAllElements()) do
		if DungeonConfig.instance:getChapterMapElement(slot8) and lua_chapter_map.configDict[slot9.mapId] and slot10.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story and slot1 == slot9.mapId then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.getElementCoListWithFinish(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(slot0:getAllNormalElementCoList(slot1)) do
		slot9 = slot8.id

		if lua_chapter_map.configDict[slot8.mapId] and slot10.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story then
			if slot1 == slot8.mapId and DungeonMapModel.instance:elementIsFinished(slot9) and not DungeonMapModel.instance:getElementById(slot9) then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2, slot3
end

function slot0.getAllNormalElementCoList(slot0, slot1)
	slot2 = {}

	if DungeonConfig.instance:getMapElements(slot1) then
		for slot7, slot8 in pairs(slot3) do
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

function slot0.setDungeonBaseMo(slot0, slot1)
	slot0.actDungeonBaseMo = slot1
end

function slot0.getDungeonBaseMo(slot0)
	return slot0.actDungeonBaseMo
end

function slot0.getInitEpisodeId(slot0)
	slot3 = 0
	slot4 = 0

	for slot8, slot9 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story)) do
		slot10 = DungeonModel.instance:isUnlock(slot9)

		if DungeonModel.instance.isBattleEpisode(slot9) then
			slot4 = slot9.id < slot4 and slot4 or slot9.id
		end

		if slot10 and slot3 < slot9.id then
			slot3 = slot9.id
		end
	end

	if DungeonModel.instance:chapterIsPass(slot1.DungeonChapterId.Story) then
		slot3 = slot4
	end

	return slot3
end

slot1 = 1
slot2 = 0

function slot0.isNeedPlayHardModeUnlockAnimation(slot0, slot1)
	if VersionActivityFixedHelper.getVersionActivityDungeonController().instance:getPlayerPrefs(VersionActivityFixedHelper.getVersionActivityDungeonEnum().PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim, uv0) ~= uv1 then
		return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(slot1 or VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon)
	end
end

function slot0.savePlayerPrefsPlayHardModeUnlockAnimation(slot0)
	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:savePlayerPrefs(VersionActivityFixedHelper.getVersionActivityDungeonEnum().PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim, uv0)
end

function slot0.isTipHardModeUnlockOpen(slot0, slot1)
	if slot1 ~= VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon then
		return
	end

	if VersionActivityFixedHelper.getVersionActivityDungeonController().instance:getPlayerPrefs(VersionActivityFixedHelper.getVersionActivityDungeonEnum().PlayerPrefsKey.OpenHardModeUnlockTip, uv0) ~= uv1 then
		return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(slot1)
	end
end

function slot0.setTipHardModeUnlockOpen(slot0)
	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:savePlayerPrefs(VersionActivityFixedHelper.getVersionActivityDungeonEnum().PlayerPrefsKey.OpenHardModeUnlockTip, uv0)
	slot0:refreshVersionActivityEnterRedDot()
end

function slot0.refreshVersionActivityEnterRedDot(slot0)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[RedDotEnum.DotNode.VersionActivityEnterRedDot] = true
	})
end

function slot0.getHardModeCurrenyNum(slot0, slot1)
	slot3 = 0
	slot4 = 0

	for slot8, slot9 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot1)) do
		slot10 = DungeonModel.instance:getEpisodeInfo(slot9.id)

		if DungeonModel.instance:getEpisodeFirstBonus(slot9.id) then
			for slot15, slot16 in ipairs(slot11) do
				if tonumber(slot16[1]) == MaterialEnum.MaterialType.Currency and tonumber(slot16[2]) == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
					if slot10 and slot10.star ~= DungeonEnum.StarType.None then
						slot3 = slot3 + tonumber(slot16[3])
					end

					slot4 = slot4 + tonumber(slot16[3])
				end
			end
		end
	end

	return slot3, slot4
end

slot0.instance = slot0.New()

return slot0
