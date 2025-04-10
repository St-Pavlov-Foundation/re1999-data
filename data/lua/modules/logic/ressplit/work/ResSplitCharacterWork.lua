module("modules.logic.ressplit.work.ResSplitCharacterWork", package.seeall)

slot0 = class("ResSplitCharacterWork", BaseWork)

function slot0.onStart(slot0, slot1)
	for slot6, slot7 in pairs(SkinConfig.instance:getAllSkinCoList()) do
		if ResSplitModel.instance:isExcludeCharacter(slot7.characterId) and ResSplitModel.instance:isExcludeSkin(slot7.id) then
			slot0:_addSkinRes(slot7, true)
		else
			slot0:_addSkinRes(slot7, false)
		end
	end

	for slot7, slot8 in pairs(HeroConfig.instance.heroConfig.configDict) do
		slot9 = ResSplitModel.instance:isExcludeCharacter(slot7)

		if ResSplitModel.instance:isExcludeCharacter(slot7) then
			if CharacterDataConfig.instance:getCharacterVoicesCo(slot7) then
				for slot14, slot15 in pairs(slot10) do
					if ResSplitModel.instance.audioDic[slot14] then
						ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, slot16.bankName, true)
					end
				end
			end
		else
			for slot14, slot15 in ipairs(FightHelper.buildSkills(slot7)) do
				ResSplitModel.instance:addIncludeSkill(slot15)
			end
		end

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getSignature(slot8.signature), slot9)
	end

	slot0:onDone(true)
end

function slot0._addSkinRes(slot0, slot1, slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadSkinSmall(slot1.id), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHandbookheroIcon(slot1.id), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconImg(slot1.drawing), slot2)
	ResSplitHelper.checkConfigEmpty(string.format("skin:%d", slot1.id), "headIcon", slot1.headIcon)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconSmall(slot1.headIcon), false)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconMiddle(slot1.retangleIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconSmall(slot1.retangleIcon), false)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconLarge(slot1.retangleIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconLarge(slot1.largeIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadSkinIconMiddle(slot1.skinGetIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadSkinIconLarge(slot1.skinGetBackIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, ResUrl.getLightLive2dFolder(slot1.live2d), slot2)

	slot6 = ResUrl.getRolesPrefabStoryFolder(slot1.verticalDrawing)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, string.sub(slot6, 1, string.len(slot6) - 1), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, string.format("roles/%s/", string.split(slot1.spine, "/")[1]), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, string.format("roles/%s/", string.split(slot1.alternateSpine, "/")[1]), slot2)

	if lua_character_limited.configDict[slot1.id] and not string.nilorempty(slot8.entranceMv) then
		ResSplitModel.instance:setExclude(ResSplitEnum.Path, langVideoUrl(slot8.entranceMv), slot2)
	end

	if slot2 == false then
		FightConfig.instance:_checkskinSkill()

		if FightConfig.instance._skinSkillTLDict[slot1.id] then
			for slot13, slot14 in pairs(slot9) do
				ResSplitModel.instance:addIncludeTimeline(slot14)
			end
		end
	end
end

return slot0
