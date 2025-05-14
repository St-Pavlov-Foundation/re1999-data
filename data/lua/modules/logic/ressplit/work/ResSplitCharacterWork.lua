module("modules.logic.ressplit.work.ResSplitCharacterWork", package.seeall)

local var_0_0 = class("ResSplitCharacterWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SkinConfig.instance:getAllSkinCoList()

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if ResSplitModel.instance:isExcludeCharacter(iter_1_1.characterId) and ResSplitModel.instance:isExcludeSkin(iter_1_1.id) then
			arg_1_0:_addSkinRes(iter_1_1, true)
		else
			arg_1_0:_addSkinRes(iter_1_1, false)
		end
	end

	local var_1_1 = HeroConfig.instance.heroConfig.configDict

	for iter_1_2, iter_1_3 in pairs(var_1_1) do
		local var_1_2 = ResSplitModel.instance:isExcludeCharacter(iter_1_2)

		if ResSplitModel.instance:isExcludeCharacter(iter_1_2) then
			local var_1_3 = CharacterDataConfig.instance:getCharacterVoicesCo(iter_1_2)

			if var_1_3 then
				for iter_1_4, iter_1_5 in pairs(var_1_3) do
					local var_1_4 = ResSplitModel.instance.audioDic[iter_1_4]

					if var_1_4 then
						ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, var_1_4.bankName, true)
					end
				end
			end
		else
			local var_1_5 = FightHelper.buildSkills(iter_1_2)

			for iter_1_6, iter_1_7 in ipairs(var_1_5) do
				ResSplitModel.instance:addIncludeSkill(iter_1_7)
			end
		end

		local var_1_6 = ResUrl.getSignature(iter_1_3.signature)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_1_6, var_1_2)
	end

	arg_1_0:onDone(true)
end

function var_0_0._addSkinRes(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = string.format("skin:%d", arg_2_1.id)
	local var_2_1 = ResUrl.getHeadSkinSmall(arg_2_1.id)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_1, arg_2_2)

	local var_2_2 = ResUrl.getHandbookheroIcon(arg_2_1.id)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_2, arg_2_2)

	local var_2_3 = ResUrl.getHeadIconImg(arg_2_1.drawing)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_3, arg_2_2)
	ResSplitHelper.checkConfigEmpty(var_2_0, "headIcon", arg_2_1.headIcon)

	local var_2_4 = ResUrl.getHeadIconSmall(arg_2_1.headIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_4, false)

	local var_2_5 = ResUrl.getHeadIconMiddle(arg_2_1.retangleIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_5, arg_2_2)

	local var_2_6 = ResUrl.getHeadIconSmall(arg_2_1.retangleIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_6, false)

	local var_2_7 = ResUrl.getHeadIconLarge(arg_2_1.retangleIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_7, arg_2_2)

	local var_2_8 = ResUrl.getHeadIconLarge(arg_2_1.largeIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_8, arg_2_2)

	local var_2_9 = ResUrl.getHeadSkinIconMiddle(arg_2_1.skinGetIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_9, arg_2_2)

	local var_2_10 = ResUrl.getHeadSkinIconLarge(arg_2_1.skinGetBackIcon)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_10, arg_2_2)

	local var_2_11 = ResUrl.getLightLive2dFolder(arg_2_1.live2d)

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, var_2_11, arg_2_2)

	local var_2_12 = ResUrl.getRolesPrefabStoryFolder(arg_2_1.verticalDrawing)
	local var_2_13 = string.sub(var_2_12, 1, string.len(var_2_12) - 1)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_13, arg_2_2)

	local var_2_14 = string.split(arg_2_1.spine, "/")
	local var_2_15 = string.format("roles/%s/", var_2_14[1])

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, var_2_15, arg_2_2)

	local var_2_16 = string.split(arg_2_1.alternateSpine, "/")
	local var_2_17 = string.format("roles/%s/", var_2_16[1])

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, var_2_17, arg_2_2)

	local var_2_18 = lua_character_limited.configDict[arg_2_1.id]

	if var_2_18 and not string.nilorempty(var_2_18.entranceMv) then
		local var_2_19 = langVideoUrl(var_2_18.entranceMv)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, var_2_19, arg_2_2)
	end

	if arg_2_2 == false then
		FightConfig.instance:_checkskinSkill()

		local var_2_20 = FightConfig.instance._skinSkillTLDict[arg_2_1.id]

		if var_2_20 then
			for iter_2_0, iter_2_1 in pairs(var_2_20) do
				ResSplitModel.instance:addIncludeTimeline(iter_2_1)
			end
		end
	end
end

return var_0_0
