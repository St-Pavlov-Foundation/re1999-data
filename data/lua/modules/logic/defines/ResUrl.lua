module("modules.logic.defines.ResUrl", package.seeall)

local var_0_0 = _M

function var_0_0.getSceneLevelUrl(arg_1_0)
	local var_1_0 = lua_scene_level.configDict[arg_1_0]

	if var_1_0 then
		return string.format("scenes/%s/%s_p.prefab", var_1_0.resName, var_1_0.resName)
	else
		logError("scene level config not exist, levelId = " .. arg_1_0)
	end
end

function var_0_0.getExploreSceneLevelUrl(arg_2_0)
	local var_2_0 = lua_scene_level.configDict[arg_2_0]

	if var_2_0 then
		return string.format("explore/scene/prefab/%s_p.prefab", var_2_0.resName)
	else
		logError("scene level config not exist, levelId = " .. arg_2_0)
	end
end

function var_0_0.getSurvivalSceneLevelUrl(arg_3_0)
	local var_3_0 = lua_scene_level.configDict[arg_3_0]

	if var_3_0 then
		return string.format("survival/common/%s.prefab", var_3_0.resName)
	else
		logError("scene level config not exist, levelId = " .. arg_3_0)
	end
end

function var_0_0.getSceneUrl(arg_4_0)
	return string.format("scenes/%s/%s_p.prefab", arg_4_0, arg_4_0)
end

function var_0_0.getSpineFightPrefab(arg_5_0)
	return var_0_0.getRolesPrefab(arg_5_0, "fight")
end

function var_0_0.getRolesPrefab(arg_6_0, arg_6_1)
	local var_6_0

	if string.find(arg_6_0, "/") then
		var_6_0 = arg_6_0
	else
		var_6_0 = string.format("%s/%s", arg_6_0, arg_6_0)
	end

	return string.format("roles/%s_%s.prefab", var_6_0, arg_6_1)
end

function var_0_0.getRolesBustPrefab(arg_7_0)
	local var_7_0

	if string.find(arg_7_0, "/") then
		var_7_0 = arg_7_0
	else
		var_7_0 = string.format("%s/%s", arg_7_0, arg_7_0)
	end

	return string.format("roles_bust/%s.prefab", var_7_0)
end

function var_0_0.getSpineFightPrefabBySkin(arg_8_0)
	if not arg_8_0 then
		return ""
	end

	local var_8_0

	if string.find(arg_8_0.spine, "/") then
		var_8_0 = arg_8_0.spine
	else
		var_8_0 = string.format("%s/%s", arg_8_0.spine, arg_8_0.spine)
	end

	if arg_8_0.fight_special == 1 then
		return string.format("roles/%s_fight_special.prefab", var_8_0)
	else
		return string.format("roles/%s_fight.prefab", var_8_0)
	end
end

function var_0_0.getRolesPrefabStory(arg_9_0)
	local var_9_0 = string.format("rolesstory/rolesprefab/%s/%s.prefab", SkinConfig.instance:getFolderName(arg_9_0), arg_9_0)

	return AvProMgr.instance:getRolesprefabUrl(var_9_0)
end

function var_0_0.getRolesCgStory(arg_10_0, arg_10_1)
	return string.format("rolesstory/rolescg/%s/%s.prefab", arg_10_1 or SkinConfig.instance:getFolderName(arg_10_0), arg_10_0)
end

function var_0_0.getLightSpine(arg_11_0)
	local var_11_0 = string.format("rolesstory/rolesprefab/%s/%s_light.prefab", SkinConfig.instance:getFolderName(arg_11_0), arg_11_0)

	return AvProMgr.instance:getRolesprefabUrl(var_11_0)
end

function var_0_0.getLightLive2d(arg_12_0)
	return string.format("live2d/roles/%s/%s.prefab", SkinConfig.instance:getFolderName(arg_12_0), arg_12_0)
end

function var_0_0.getLightLive2dFolder(arg_13_0)
	return string.format("live2d/roles/%s/", SkinConfig.instance:getFolderName(arg_13_0))
end

function var_0_0.getRolesPrefabStoryFolder(arg_14_0)
	return string.format("rolesstory/rolesprefab/%s/", SkinConfig.instance:getFolderName(arg_14_0))
end

function var_0_0.getSpineRoomPrefab(arg_15_0)
	return var_0_0.getRolesPrefab(arg_15_0, "room")
end

function var_0_0.getSpineUIPrefab(arg_16_0)
	return var_0_0.getRolesPrefab(arg_16_0, "ui")
end

function var_0_0.getSkillTimeline(arg_17_0)
	return string.format("rolestimeline/%s.playable", arg_17_0)
end

function var_0_0.getRolesTimeline()
	return "rolestimeline"
end

function var_0_0.getLoginBg(arg_19_0)
	return string.format("singlebg/loginbg/%s.png", arg_19_0)
end

function var_0_0.getLoadingBg(arg_20_0)
	return string.format("singlebg/loading/%s.png", arg_20_0)
end

function var_0_0.getMailBg(arg_21_0)
	return string.format("singlebg/mail/%s.png", arg_21_0)
end

function var_0_0.getCommonViewBg(arg_22_0)
	return string.format("singlebg/common/viewbg/%s.jpg", arg_22_0)
end

function var_0_0.getCommonIcon(arg_23_0)
	return string.format("singlebg/common/%s.png", arg_23_0)
end

function var_0_0.getDungeonIcon(arg_24_0)
	return string.format("singlebg/dungeon/%s.png", arg_24_0)
end

function var_0_0.getDungeonChapterBg(arg_25_0)
	return string.format("ui/viewres/dungeon/chapter/bg/%s.prefab", arg_25_0)
end

function var_0_0.getDungeonInteractiveItemBg(arg_26_0)
	return string.format("singlebg/dungeon/interactiveitem/%s.png", arg_26_0)
end

function var_0_0.getDungeonRuleIcon(arg_27_0)
	return string.format("singlebg/dungeon/level_rule/%s.png", arg_27_0)
end

function var_0_0.getDungeonFragmentIcon(arg_28_0)
	return string.format("singlebg/dungeon/fragmenticon/%s.png", arg_28_0)
end

function var_0_0.getFightQuitResultIcon(arg_29_0)
	return string.format("singlebg/fight/result/%s.png", arg_29_0)
end

function var_0_0.getFightGuideIcon(arg_30_0)
	return string.format("singlebg/fight/fightguide/bg_zhiying_%s.png", arg_30_0)
end

function var_0_0.getFightGuideDir()
	return "Assets/ZResourcesLib/singlebg/fight/fightguide"
end

function var_0_0.getBackpackItemIcon(arg_32_0)
	return string.format("singlebg/backpackitem/%s.png", arg_32_0)
end

function var_0_0.getSummonHeroIcon(arg_33_0)
	return string.format("singlebg/summon/hero/%s.png", arg_33_0)
end

function var_0_0.getSummonEquipIcon(arg_34_0)
	return string.format("singlebg/summon/equip/%s.png", arg_34_0)
end

function var_0_0.getSummonEquipGetIcon(arg_35_0)
	return string.format("singlebg/summon/equipget/%s.png", arg_35_0)
end

function var_0_0.getSummonBannerFullPath(arg_36_0)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_summon/banner/%s.png", arg_36_0)
end

function var_0_0.getAdventureTaskLangPath(arg_37_0)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_adventuretask/%s.png", arg_37_0)
end

function var_0_0.getSummonCoverBg(arg_38_0)
	return string.format("singlebg/summon/%s.png", arg_38_0)
end

function var_0_0.getSummonHeroMask(arg_39_0)
	return string.format("singlebg/summon/mask/%s.png", arg_39_0)
end

function var_0_0.getSummonSceneTexture(arg_40_0)
	return string.format("scenes/dynamic/m_s06_summon/%s.png", arg_40_0)
end

function var_0_0.getSignature(arg_41_0, arg_41_1)
	if arg_41_1 then
		return string.format("singlebg/signature/%s/%s.png", arg_41_1, arg_41_0)
	else
		return string.format("singlebg/signature/%s.png", arg_41_0)
	end
end

function var_0_0.getSceneUIPrefab(arg_42_0, arg_42_1)
	return string.format("ui/sceneui/%s/%s.prefab", arg_42_0, arg_42_1)
end

function var_0_0.getCharacterIcon(arg_43_0)
	return string.format("singlebg/character/%s.png", arg_43_0)
end

function var_0_0.getCharacterItemIcon(arg_44_0)
	return string.format("singlebg/characteritem/%s.png", arg_44_0)
end

function var_0_0.getCharacterDataIcon(arg_45_0)
	return string.format("singlebg/characterdata/%s", arg_45_0)
end

function var_0_0.getCharacterExskill(arg_46_0)
	return string.format("singlebg/characterexskill/%s.png", arg_46_0)
end

function var_0_0.getCharacterGetIcon(arg_47_0)
	return string.format("singlebg/characterget/%s.png", arg_47_0)
end

function var_0_0.getCharacterSkinIcon(arg_48_0)
	return string.format("singlebg/characterskin/%s.png", arg_48_0)
end

function var_0_0.getCharacterSkinLive2dBg(arg_49_0)
	return string.format("singlebg/characterskin/live2dbg/%s.png", arg_49_0)
end

function var_0_0.getCharacterSkinStoryBg(arg_50_0)
	return string.format("singlebg/skinhandbook_singlebg/skinhandbook_leftbg_%d.png", arg_50_0)
end

function var_0_0.getCharacterSkinSwitchBg(arg_51_0)
	return string.format("singlebg/characterskin/img_yulan_bg_%d.png", arg_51_0)
end

function var_0_0.getHeadSkinIconMiddle(arg_52_0)
	return string.format("singlebg/headskinicon_middle/%s.png", arg_52_0)
end

function var_0_0.getHeadSkinIconLarge(arg_53_0)
	return string.format("singlebg/headskinicon_large/%s.jpg", arg_53_0)
end

function var_0_0.getSkillEffect(arg_54_0)
	return string.format("singlebg/characteritem/skilleffect/effect_%s.png", arg_54_0)
end

function var_0_0.getCharacterRareBg(arg_55_0)
	return string.format("singlebg/characteritem/jskp_0%d.png", arg_55_0)
end

function var_0_0.getCharacterRareBgNew(arg_56_0)
	return string.format("singlebg/characteritem/jskp_0%d.png", arg_56_0)
end

function var_0_0.getTipsBg(arg_57_0)
	return string.format("singlebg/tips/%s.png", arg_57_0)
end

function var_0_0.getTipsCharacterRareBg(arg_58_0)
	return string.format("singlebg/tips/jskp_0%d.png", arg_58_0)
end

function var_0_0.getTipsCharacterColorBg(arg_59_0)
	return string.format("singlebg/tips/pfkp_00%d.png", arg_59_0)
end

function var_0_0.getPropItemIcon(arg_60_0)
	return string.format("singlebg/propitem/prop/%s.png", arg_60_0)
end

function var_0_0.getPropItemIconSmall(arg_61_0)
	return string.format("singlebg/propitem/prop_small/%s.png", arg_61_0)
end

function var_0_0.getAntiqueIcon(arg_62_0)
	return string.format("singlebg/antique_singlebg/%s.png", arg_62_0)
end

function var_0_0.getSpecialPropItemIcon(arg_63_0)
	return string.format("singlebg/propitem/special/%s.png", arg_63_0)
end

function var_0_0.getCurrencyItemIcon(arg_64_0)
	return string.format("singlebg/currencyitem/%s.png", arg_64_0)
end

function var_0_0.getCritterItemIcon(arg_65_0)
	return string.format("singlebg/propitem/critter/%s.png", arg_65_0)
end

function var_0_0.getEffect(arg_66_0)
	return string.format("effects/prefabs/%s.prefab", arg_66_0)
end

function var_0_0.getStoryPrefabRes(arg_67_0)
	return string.format("ui/viewres/story/%s.prefab", arg_67_0)
end

function var_0_0.getStoryBgEffect(arg_68_0)
	return string.format("ui/viewres/story/bg/%s.prefab", arg_68_0)
end

function var_0_0.getStoryBgMaterial(arg_69_0)
	return string.format("ui/materials/storybg/%s.mat", arg_69_0)
end

function var_0_0.getUIEffect(arg_70_0)
	return string.format("ui/viewres/effect/%s.prefab", arg_70_0)
end

function var_0_0.getSceneEffect(arg_71_0)
	return string.format("effects/prefabs/buff/%s.prefab", arg_71_0)
end

function var_0_0.getFightLoadingIcon(arg_72_0)
	return string.format("singlebg/fight/loading/%s.png", tostring(arg_72_0))
end

function var_0_0.getSkillIcon(arg_73_0)
	return string.format("singlebg/fight/skill/%s.png", tostring(arg_73_0))
end

function var_0_0.getPassiveSkillIcon(arg_74_0)
	return string.format("singlebg/fight/passive/%s.png", tostring(arg_74_0))
end

function var_0_0.getClothSkillIcon(arg_75_0)
	return string.format("singlebg/fight/cloth/%s.png", tostring(arg_75_0))
end

function var_0_0.getAttributeIcon(arg_76_0)
	return string.format("singlebg/fight/attribute/%s.png", tostring(arg_76_0))
end

function var_0_0.getFightCardDescIcon(arg_77_0)
	return string.format("singlebg/fight/carddesc/%s.png", tostring(arg_77_0))
end

function var_0_0.getFightResultcIcon(arg_78_0)
	return string.format("singlebg/fight/result/%s.png", tostring(arg_78_0))
end

function var_0_0.getFightSkillTargetcIcon(arg_79_0)
	return string.format("singlebg/fight/skilltarget/%s.png", tostring(arg_79_0))
end

function var_0_0.getStoryRes(arg_80_0)
	return string.format("singlebg/storybg/%s", tostring(arg_80_0))
end

function var_0_0.getStoryBg(arg_81_0)
	return string.format("singlebg/storybg/%s", tostring(arg_81_0))
end

function var_0_0.getStoryPrologueSkip(arg_82_0)
	return string.format("singlebg/storybg/prologueskip/%s.png", tostring(arg_82_0))
end

function var_0_0.getStorySmallBg(arg_83_0)
	return string.format("singlebg/storybg/smallbg/%s", tostring(arg_83_0))
end

function var_0_0.getStoryEpisodeIcon(arg_84_0)
	return string.format("ui/viewres/storynavigate/%s", tostring(arg_84_0))
end

function var_0_0.getStoryItem(arg_85_0)
	return string.format("singlebg/storybg/item/%s", tostring(arg_85_0))
end

function var_0_0.getStoryLangPath(arg_86_0)
	return string.format("singlebg_lang/txt_story/%s.png", tostring(arg_86_0))
end

function var_0_0.getCameraAnim(arg_87_0)
	return string.format("effects/cameraanim/%s.controller", arg_87_0)
end

function var_0_0.getCameraAnimABUrl()
	return "effects/cameraanim"
end

function var_0_0.getEntityAnim(arg_89_0)
	return string.format("effects/entityanim/%s.anim", arg_89_0)
end

function var_0_0.getEntityAnimABUrl()
	return "effects/entityanim"
end

function var_0_0.getHeadIconSmall(arg_91_0)
	return string.format("singlebg/headicon_small/%s.png", arg_91_0)
end

function var_0_0.getEquipIconSmall(arg_92_0)
	return string.format("scenes/dynamic/m_s03_xx/equipicon_small/%s.png", arg_92_0)
end

function var_0_0.getHeadIconNew(arg_93_0)
	return string.format("singlebg/propitem/hero/%s.png", arg_93_0)
end

function var_0_0.getHeroSkinPropIcon(arg_94_0)
	return string.format("singlebg/propitem/heroskin/%s.png", arg_94_0)
end

function var_0_0.getHeadIconMiddle(arg_95_0)
	return string.format("singlebg/headicon_middle/%s.png", arg_95_0)
end

function var_0_0.getHeadIconLarge(arg_96_0)
	return string.format("singlebg/headicon_large/%s.png", arg_96_0)
end

function var_0_0.getHeadIconImg(arg_97_0)
	return string.format("singlebg/headicon_img/%s.png", arg_97_0)
end

function var_0_0.getHeadSkinSmall(arg_98_0)
	return string.format("singlebg/headskinicon_small/%s.png", arg_98_0)
end

function var_0_0.getCharacterDataPic(arg_99_0)
	return string.format("singlebg/data_pic/%s.png", arg_99_0)
end

function var_0_0.getHeroGroupBg(arg_100_0)
	return string.format("singlebg/herogroup/%s.png", arg_100_0)
end

function var_0_0.getHeroDefaultEquipIcon(arg_101_0)
	return string.format("singlebg/equip_defaulticon/%s.png", arg_101_0)
end

function var_0_0.getTaskBg(arg_102_0)
	return string.format("singlebg/task/%s.png", arg_102_0)
end

function var_0_0.getEquipRareIcon(arg_103_0)
	return string.format("singlebg/equipment/rare/%s.png", arg_103_0)
end

function var_0_0.getEquipIcon(arg_104_0)
	return string.format("singlebg/equipment/icon/%s.png", arg_104_0)
end

function var_0_0.getEquipSuit(arg_105_0)
	return string.format("singlebg/equipment/suit/%s.png", arg_105_0)
end

function var_0_0.getEquipRes(arg_106_0)
	return string.format("singlebg/equipment/%s.png", arg_106_0)
end

function var_0_0.getHelpItem(arg_107_0, arg_107_1)
	if arg_107_1 then
		return string.format("singlebg_lang/txt_help/%s.png", arg_107_0)
	else
		return string.format("singlebg/help/%s.png", arg_107_0)
	end
end

function var_0_0.getVersionActivityHelpItem(arg_108_0, arg_108_1)
	if arg_108_1 then
		return string.format("singlebg_lang/txt_versionactivityhelp/%s.png", arg_108_0)
	else
		return string.format("singlebg/versionactivityhelp/%s.png", arg_108_0)
	end
end

function var_0_0.getBannerIcon(arg_109_0)
	return string.format("singlebg/banner/%s.png", arg_109_0)
end

function var_0_0.getRoleSpineMat(arg_110_0)
	return string.format("rolesbuff/%s.mat", arg_110_0)
end

function var_0_0.getRoleSpineMatTex(arg_111_0)
	return string.format("rolesbuff/%s.png", arg_111_0)
end

function var_0_0.getSettingsBg(arg_112_0)
	return string.format("singlebg/settings/%s", arg_112_0)
end

function var_0_0.getAdventureBg(arg_113_0)
	return string.format("singlebg/adventure/%s.png", arg_113_0)
end

function var_0_0.getExploreBg(arg_114_0)
	return string.format("singlebg/explore/%s.png", arg_114_0)
end

function var_0_0.getAdventureIcon(arg_115_0)
	return string.format("singlebg/adventure/iconnew/%s.png", arg_115_0)
end

function var_0_0.getAdventureEntrance(arg_116_0)
	return string.format("singlebg/adventure/entrance/%s.png", arg_116_0)
end

function var_0_0.getAdventureTarotIcon(arg_117_0)
	return string.format("singlebg/adventure/tarot/%s.png", arg_117_0)
end

function var_0_0.getAdventureTarotSmallIcon(arg_118_0)
	return string.format("singlebg/adventure/tarotsmall/%s.png", arg_118_0)
end

function var_0_0.getAdventureMagicIcon(arg_119_0, arg_119_1)
	return string.format("singlebg/adventure/magic/%s/%s.png", arg_119_0, arg_119_1)
end

function var_0_0.getAdventureTarotQuality(arg_120_0)
	return string.format("singlebg/adventure/tarot_quality/tarot_quality_%s.png", arg_120_0)
end

function var_0_0.getAdventureTask(arg_121_0)
	return string.format("singlebg/adventure/task/%s.png", arg_121_0)
end

function var_0_0.getPlayerClothIcon(arg_122_0)
	return string.format("singlebg/player/cloth/%s.png", arg_122_0)
end

function var_0_0.getPlayerBg(arg_123_0)
	return string.format("singlebg/player/%s.png", arg_123_0)
end

function var_0_0.getPlayerCardIcon(arg_124_0)
	return string.format("singlebg/playercard/%s.png", arg_124_0)
end

function var_0_0.getStoreBottomBgIcon(arg_125_0)
	return string.format("singlebg/store/%s.png", arg_125_0)
end

function var_0_0.getStoreGiftPackBg(arg_126_0)
	return string.format("singlebg/store/giftpacksview/%s.png", arg_126_0)
end

function var_0_0.getStorePackageIcon(arg_127_0)
	if string.nilorempty(arg_127_0) then
		return var_0_0.getCurrencyItemIcon(201)
	else
		return string.format("singlebg/store/package/%s.png", arg_127_0)
	end
end

function var_0_0.getStoreTagIcon(arg_128_0)
	return string.format("singlebg/store/tag_%s.png", arg_128_0)
end

function var_0_0.getStoreRecommend(arg_129_0)
	return string.format("singlebg/store/recommend/%s.png", arg_129_0)
end

function var_0_0.getStoreWildness(arg_130_0)
	return string.format("singlebg/store/wildness/%s.png", arg_130_0)
end

function var_0_0.getStoreSkin(arg_131_0)
	return string.format("singlebg/store/skin/%s.png", arg_131_0)
end

function var_0_0.getNoticeBg(arg_132_0)
	return string.format("singlebg/notice/%s.png", arg_132_0)
end

function var_0_0.getNoticeContentIcon(arg_133_0, arg_133_1)
	return string.format("singlebg/notice/hd_%d_%d.png", arg_133_0, arg_133_1)
end

function var_0_0.getSignInBg(arg_134_0)
	return string.format("singlebg/signin/%s.png", arg_134_0)
end

function var_0_0.getActivityBg(arg_135_0)
	return string.format("singlebg/activity/%s.png", arg_135_0)
end

function var_0_0.getActivityMapBg(arg_136_0)
	return string.format("singlebg/activity/%s", arg_136_0)
end

function var_0_0.getPowerBuyBg(arg_137_0)
	return string.format("singlebg/powerbuy/%s.png", arg_137_0)
end

function var_0_0.getEquipBg(arg_138_0)
	return string.format("singlebg/equip/%s", arg_138_0)
end

function var_0_0.getMessageIcon(arg_139_0)
	return string.format("singlebg/message/%s.png", arg_139_0)
end

function var_0_0.getSocialIcon(arg_140_0)
	return string.format("singlebg/social/%s", arg_140_0)
end

function var_0_0.getFightIcon(arg_141_0)
	return string.format("singlebg/fight/icon/%s", arg_141_0)
end

function var_0_0.getFightImage(arg_142_0)
	return string.format("singlebg/fight/%s", arg_142_0)
end

function var_0_0.getFightSpecialTipIcon(arg_143_0)
	return string.format("singlebg/fight/specialtip/%s", arg_143_0)
end

function var_0_0.getNickNameIcon(arg_144_0)
	return string.format("singlebg/nickname/%s.png", arg_144_0)
end

function var_0_0.getRoomRes(arg_145_0)
	return string.format("scenes/m_s07_xiaowu/prefab/%s.prefab", arg_145_0)
end

function var_0_0.getRoomResAB(arg_146_0)
	return string.format("scenes/m_s07_xiaowu/prefab/%s", arg_146_0)
end

function var_0_0.getRoomGetIcon(arg_147_0)
	return string.format("singlebg/roomget/%s.png", arg_147_0)
end

function var_0_0.getRoomBlockPackageRewardIcon(arg_148_0)
	return string.format("singlebg/roomget/blockpackage/%s.jpg", arg_148_0)
end

function var_0_0.getRoomBuildingRewardIcon(arg_149_0)
	return string.format("singlebg/roomget/building/%s.jpg", arg_149_0)
end

function var_0_0.getRoomThemeRewardIcon(arg_150_0)
	return string.format("singlebg/roomget/theme/%s.jpg", arg_150_0)
end

function var_0_0.getSpineBxhyPrefab(arg_151_0)
	return var_0_0.getRolesPrefab(arg_151_0, "room")
end

function var_0_0.getSpineUIBxhyPrefab(arg_152_0)
	return var_0_0.getRolesPrefab(arg_152_0, "ui")
end

function var_0_0.getSpineBxhyMaterial(arg_153_0)
	local var_153_0

	if string.find(arg_153_0, "/") then
		var_153_0 = arg_153_0
	else
		var_153_0 = string.format("%s/%s", arg_153_0, arg_153_0)
	end

	return string.format("roles/%s_bxhy_material.mat", var_153_0)
end

function var_0_0.getSceneRes(arg_154_0)
	return string.format("scenes/%s/%s_p.prefab", arg_154_0, arg_154_0)
end

function var_0_0.getDungeonMapRes(arg_155_0)
	return string.format("scenes/%s.prefab", arg_155_0)
end

function var_0_0.getRoomImage(arg_156_0)
	return string.format("singlebg/room/%s.png", arg_156_0)
end

function var_0_0.getMainImage(arg_157_0)
	return string.format("singlebg/main/%s.png", arg_157_0)
end

function var_0_0.getMainActivityIcon(arg_158_0)
	return string.format("singlebg_lang/txt_main/%s.png", arg_158_0)
end

function var_0_0.getHandbookBg(arg_159_0)
	return string.format("singlebg/handbook/%s.png", arg_159_0)
end

function var_0_0.getHandbookCharacterIcon(arg_160_0)
	return string.format("singlebg/handbook/character/%s.png", arg_160_0)
end

function var_0_0.getHandbookheroIcon(arg_161_0)
	return string.format("singlebg/handbookheroicon/%s.png", arg_161_0)
end

function var_0_0.getHandbookEquipImage(arg_162_0)
	return string.format("singlebg/handbook/equip/%s.png", arg_162_0)
end

function var_0_0.getCharacterTalentUpIcon(arg_163_0)
	return string.format("singlebg/charactertalentup/%s.png", arg_163_0)
end

function var_0_0.getWeekWalkBg(arg_164_0)
	return string.format("singlebg/weekwalk/%s", arg_164_0)
end

function var_0_0.getVideo(arg_165_0)
	return string.format("videos/%s.mp4", arg_165_0)
end

function var_0_0.getCharacterTalentUpTexture(arg_166_0)
	return string.format("singlebg/textures/charactertalentup/%s.png", arg_166_0)
end

function var_0_0.getWeatherEffect(arg_167_0)
	return string.format("effects/prefabs/roleeffects/%s.prefab", arg_167_0)
end

function var_0_0.getPlayerViewTexture(arg_168_0)
	return string.format("singlebg/textures/playerview/%s.png", arg_168_0)
end

function var_0_0.getCommonitemEffect(arg_169_0)
	return string.format("ui/viewres/common/effect/%s.prefab", arg_169_0)
end

function var_0_0.getDungeonPuzzleBg(arg_170_0)
	return string.format("singlebg/dungeon/puzzle/%s.png", arg_170_0)
end

function var_0_0.getUIMaskTexture(arg_171_0)
	return string.format("singlebg/textures/uimask/%s.png", arg_171_0)
end

function var_0_0.getRoomTexture(arg_172_0)
	return string.format("singlebg/textures/room/%s", arg_172_0)
end

function var_0_0.getActivityTexture(arg_173_0)
	return string.format("singlebg/textures/activity/%s", arg_173_0)
end

function var_0_0.getTeachNoteImage(arg_174_0)
	return string.format("singlebg/teachnote/%s", arg_174_0)
end

function var_0_0.getWeekWalkTarotIcon(arg_175_0)
	return string.format("singlebg/weekwalk/tarot/%s.png", arg_175_0)
end

function var_0_0.getFightTechniqueGuide(arg_176_0, arg_176_1)
	if arg_176_1 then
		return string.format("singlebg/versionactivitytechniqueguide/%s.png", arg_176_0)
	else
		return string.format("singlebg/fight/techniqueguide/%s.png", arg_176_0)
	end
end

function var_0_0.getFightEquipFloatIcon(arg_177_0)
	return string.format("singlebg/fight/equipeffect/%s.png", arg_177_0)
end

function var_0_0.getFightGuideLangIcon(arg_178_0)
	return string.format("singlebg_lang/txt_fightguide/bg_zhiying_%s.png", arg_178_0)
end

function var_0_0.getFightGuideLangDir()
	return "Assets/ZResourcesLib/singlebg_lang/txt_fightguide"
end

function var_0_0.getLoginBgLangIcon(arg_180_0)
	return string.format("singlebg_lang/txt_loginbg/%s.png", arg_180_0)
end

function var_0_0.getTechniqueLangIcon(arg_181_0, arg_181_1)
	if arg_181_1 then
		return string.format("singlebg_lang/txt_fighttechniquetips/%s.png", arg_181_0)
	else
		return string.format("singlebg/fighttechniquetips/%s.png", arg_181_0)
	end
end

function var_0_0.getTechniqueBg(arg_182_0)
	return string.format("singlebg/fight/techniquetips/%s.png", arg_182_0)
end

function var_0_0.getHandbookCharacterImage(arg_183_0)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_handbook/%s.png", arg_183_0)
end

function var_0_0.getFightBattleDialogBg(arg_184_0)
	return string.format("singlebg/fight/battledialog/%s.png", arg_184_0)
end

function var_0_0.getBpBg(arg_185_0)
	return string.format("singlebg/battlepass/%s.png", arg_185_0)
end

function var_0_0.getAct114Image(arg_186_0)
	return string.format("singlebg_lang/txt_versionactivity114_1_2/%s.png", arg_186_0)
end

function var_0_0.getDreamTailImage(arg_187_0)
	return string.format("singlebg/versionactivitydreamtail_1_2/%s.png", arg_187_0)
end

function var_0_0.getAct114MeetIcon(arg_188_0)
	return string.format("singlebg/versionactivity114_1_2/meet/%s.png", arg_188_0)
end

function var_0_0.getAct114Icon(arg_189_0)
	return string.format("singlebg/versionactivity114_1_2/%s.png", arg_189_0)
end

function var_0_0.getYaXianImage(arg_190_0)
	return string.format("singlebg/versionactivitytooth_1_2/%s.png", arg_190_0)
end

function var_0_0.getFightDiceBg(arg_191_0)
	return string.format("singlebg/fight/fightdice/%s.png", arg_191_0)
end

function var_0_0.getWeekWalkLayerIcon(arg_192_0)
	return string.format("singlebg/weekwalk/layer/%s.png", arg_192_0)
end

function var_0_0.getRoomCharacterPlaceIcon(arg_193_0)
	return string.format("singlebg/room/characterplace/%s.png", arg_193_0)
end

function var_0_0.getRoomHeadIcon(arg_194_0)
	return string.format("singlebg/room/headicon/%s.png", arg_194_0)
end

function var_0_0.getRoomBlockPackagePropIcon(arg_195_0)
	return string.format("singlebg/propitem/blockpackage/%s.png", arg_195_0)
end

function var_0_0.getRoomBlockPropIcon(arg_196_0)
	return string.format("singlebg/propitem/block/%s.png", arg_196_0)
end

function var_0_0.getRoomBuildingPropIcon(arg_197_0)
	return string.format("singlebg/propitem/building/%s.png", arg_197_0)
end

function var_0_0.getRoomThemePropIcon(arg_198_0)
	return string.format("singlebg/propitem/roomtheme/%s.png", arg_198_0)
end

function var_0_0.getRoomTaskBonusIcon(arg_199_0)
	return string.format("singlebg/room/taskbonus/%s.png", arg_199_0)
end

function var_0_0.getRoomFunctionIcon(arg_200_0)
	return string.format("singlebg/room/function/%s.png", arg_200_0)
end

function var_0_0.getRoomProductline(arg_201_0)
	return string.format("singlebg/room/productline/%s.png", arg_201_0)
end

function var_0_0.getSeasonIcon(arg_202_0)
	return string.format("singlebg/season/%s", arg_202_0)
end

function var_0_0.getV1A2SeasonIcon(arg_203_0)
	return string.format("singlebg/v1a2_season/%s", arg_203_0)
end

function var_0_0.getV1A3SeasonIcon(arg_204_0)
	return string.format("singlebg/v1a3_season/%s", arg_204_0)
end

function var_0_0.getV1A3DungeonIcon(arg_205_0)
	return string.format("singlebg/v1a3_dungeon_singlebg/%s.png", arg_205_0)
end

function var_0_0.getToastIcon(arg_206_0)
	return string.format("singlebg/toast/%s.png", arg_206_0)
end

function var_0_0.getSdkIcon(arg_207_0)
	return string.format("singlebg/sdk/%s.png", arg_207_0)
end

function var_0_0.getPlayerHeadIcon(arg_208_0)
	return string.format("singlebg/playerheadicon/%s.png", arg_208_0)
end

function var_0_0.getVersionActivityIcon(arg_209_0)
	return string.format("singlebg/versionactivity/%s.png", arg_209_0)
end

function var_0_0.getVersionActivityEnter1_2Icon(arg_210_0)
	return string.format("singlebg/versionactivityenter_1_2/%s.png", arg_210_0)
end

function var_0_0.getVersionActivityEnter1_2LangIcon(arg_211_0)
	return string.format("singlebg_lang/txt_versionactivityenter_1_2/%s.png", arg_211_0)
end

function var_0_0.getMeilanniIcon(arg_212_0)
	return string.format("singlebg/versionactivitymeilanni/%s.png", arg_212_0)
end

function var_0_0.getMeilanniLangIcon(arg_213_0)
	return string.format("singlebg_lang/txt_versionactivitymeilanni/%s.png", arg_213_0)
end

function var_0_0.getActivityWarmUpBg(arg_214_0)
	return string.format("singlebg/activitywarmup/%s.png", arg_214_0)
end

function var_0_0.getPushBoxPre(arg_215_0)
	return string.format("scenes/m_s11_txz/prefab/%s.prefab", arg_215_0)
end

function var_0_0.getPushBoxResultIcon(arg_216_0)
	return string.format("singlebg_lang/txt_versionactivitypushbox/%s.png", arg_216_0)
end

function var_0_0.getVersionactivitychessIcon(arg_217_0)
	return string.format("singlebg/versionactivitychess/%s.png", arg_217_0)
end

function var_0_0.gettxt_versionactivitychessIcon(arg_218_0)
	return string.format("singlebg_lang/txt_versionactivitychess/%s.png", arg_218_0)
end

function var_0_0.getVersionActivityExchangeIcon(arg_219_0)
	return string.format("singlebg/versionactivityexchange/%s.png", arg_219_0)
end

function var_0_0.getVersionActivityDungeonIcon(arg_220_0)
	return string.format("singlebg/versionactivitydungeon/%s.png", arg_220_0)
end

function var_0_0.getBattlePassBg(arg_221_0)
	return string.format("singlebg/battlepass/%s.png", arg_221_0)
end

function var_0_0.getVersionActivityWhiteHouse_1_2_Bg(arg_222_0)
	return string.format("singlebg/versionactivitywhitehouse_1_2/%s", arg_222_0)
end

function var_0_0.getVersionTradeBargainBg(arg_223_0)
	return string.format("singlebg/versionactivitytrade_1_2/%s.png", arg_223_0)
end

function var_0_0.getVersionActivity1_2TaskImage(arg_224_0)
	return string.format("singlebg/versionactivitytask_1_2/%s.png", arg_224_0)
end

function var_0_0.getRoomIconLangPath(arg_225_0)
	return string.format("singlebg_lang/txt_room/%s.png", arg_225_0)
end

function var_0_0.getWeekWalkIconLangPath(arg_226_0)
	return string.format("singlebg_lang/txt_weekwalk/%s.png", arg_226_0)
end

function var_0_0.getExploreEffectPath(arg_227_0)
	return string.format("effects/scenes/mishi_prefabs/%s.prefab", arg_227_0)
end

function var_0_0.getSeasonCelebrityCard(arg_228_0)
	return string.format("singlebg/seasoncelebritycard/%s.png", arg_228_0)
end

function var_0_0.getSeasonMarketIcon(arg_229_0)
	return string.format("singlebg/season/market/%s.png", arg_229_0)
end

function var_0_0.getActivityChapterLangPath(arg_230_0)
	return string.format("singlebg_lang/txt_versionactivityopen/%s.png", arg_230_0)
end

function var_0_0.getVersionActivityOpenPath(arg_231_0)
	return string.format("singlebg/versionactivityopen/%s.png", arg_231_0)
end

function var_0_0.getVersionActivityStoryCollect_1_2(arg_232_0)
	return string.format("singlebg/versionactivitystorycollect_1_2/%s.png", arg_232_0)
end

function var_0_0.getActivityWarmUpLangIcon(arg_233_0)
	return string.format("singlebg_lang/txt_activitywarmup/%s.png", arg_233_0)
end

function var_0_0.getVersionActivityDungeon_1_2(arg_234_0)
	return string.format("singlebg/versionactivitydungeon_1_2/%s.png", arg_234_0)
end

function var_0_0.getRadioIcon_1_3(arg_235_0)
	return string.format("singlebg/v1a3_radio_singlebg/%s.png", arg_235_0)
end

function var_0_0.getVersionActivityTrip_1_2(arg_236_0)
	return string.format("singlebg/versionactivitytrip_1_2/%s.png", arg_236_0)
end

function var_0_0.getActivityLangIcon(arg_237_0)
	return string.format("singlebg_lang/txt_activity/%s.png", arg_237_0)
end

function var_0_0.getActivityFullBg(arg_238_0)
	return string.format("singlebg/activity/full/%s.png", arg_238_0)
end

function var_0_0.getActivitiy119Icon(arg_239_0)
	return string.format("singlebg/v1a3_bookview_singlebg/%s.png", arg_239_0)
end

function var_0_0.getActivity1_3BuffIcon(arg_240_0)
	return string.format("singlebg/v1a3_buffview_singlebg/%s.png", arg_240_0)
end

function var_0_0.getJiaLaBoNaIcon(arg_241_0)
	return string.format("singlebg/v1a3_role1_singlebg/%s.png", arg_241_0)
end

function var_0_0.getJiaLaBoNaRoleModsIcon(arg_242_0)
	return string.format("singlebg/v1a3_role1_mods_singlebg/%s.png", arg_242_0)
end

function var_0_0.getFairyLandIcon(arg_243_0)
	return string.format("singlebg/v1a3_fairyland_singlebg/%s.png", arg_243_0)
end

function var_0_0.get1_3ChessMapIcon(arg_244_0)
	return string.format("singlebg/v1a3_role2_singlebg/%s.png", arg_244_0)
end

function var_0_0.getActivity1_3EnterIcon(arg_245_0)
	return string.format("singlebg/v1a3_enterview_singlebg/%s.png", arg_245_0)
end

function var_0_0.getV1a3TaskViewSinglebg(arg_246_0)
	return string.format("singlebg/v1a3_taskview_singlebg/%s.png", arg_246_0)
end

function var_0_0.getV1a3ArmSinglebg(arg_247_0)
	return string.format("singlebg/v1a3_arm_singlebg/%s.png", arg_247_0)
end

function var_0_0.getV1a3AstrologySinglebg(arg_248_0)
	return string.format("singlebg/v1a3_astrology_singlebg/%s.png", arg_248_0)
end

function var_0_0.getActivity133Icon(arg_249_0)
	return string.format("singlebg/v1a4_shiprepair/%s.png", arg_249_0)
end

function var_0_0.getRoleStoryIcon(arg_250_0)
	return string.format("singlebg/dungeon/rolestory_singlebg/%s.png", arg_250_0)
end

function var_0_0.getRoleStoryPhotoIcon(arg_251_0)
	return string.format("singlebg/dungeon/rolestory_photo_singlebg/%s.png", arg_251_0)
end

function var_0_0.getTurnbackIcon(arg_252_0)
	return string.format("singlebg/turnback/%s.png", arg_252_0)
end

function var_0_0.getV1a4BossRushSinglebg(arg_253_0)
	return string.format("singlebg/v1a4_bossrush_singlebg/%s.png", arg_253_0)
end

function var_0_0.getV1a4BossRushIcon(arg_254_0)
	return string.format("singlebg/v1a4_bossrush_bossicon_singlebg/%s.png", arg_254_0)
end

function var_0_0.getV1a4BossRushLangPath(arg_255_0)
	return string.format("singlebg_lang/txt_v1a4_bossrush_singlebg/%s.png", arg_255_0)
end

function var_0_0.getV1a4BossRushAssessIcon(arg_256_0)
	return string.format("singlebg/bossrush_assess_singlebg/%s.png", arg_256_0)
end

function var_0_0.getBossRushSinglebg(arg_257_0)
	return string.format("singlebg/bossrush/%s.png", arg_257_0)
end

function var_0_0.getV1a4Role37SingleBg(arg_258_0)
	return string.format("singlebg/v1a4_role37_singlebg/%s.png", arg_258_0)
end

function var_0_0.getV1a4Role6SingleBg(arg_259_0)
	return string.format("singlebg/v1a4_role37_singlebg/%s.png", arg_259_0)
end

function var_0_0.getV1a4DustRecordsIcon(arg_260_0)
	return string.format("singlebg/v1a4_dustyrecordsview/%s.png", arg_260_0)
end

function var_0_0.getV1Aa4DailyAllowanceIcon(arg_261_0)
	return string.format("singlebg/v1a4_gold_singlebg/%s.png", arg_261_0)
end

function var_0_0.getV1a5DungeonSingleBg(arg_262_0)
	return string.format("singlebg/v1a5_dungeon_singlebg/%s.png", arg_262_0)
end

function var_0_0.getV1a5EnterSingleBg(arg_263_0)
	return string.format("singlebg/v1a5_enterview_singlebg/%s.png", arg_263_0)
end

function var_0_0.getV1a5RevivalTaskSingleBg(arg_264_0)
	return string.format("singlebg/v1a5_revival_singlebg/%s.png", arg_264_0)
end

function var_0_0.getV1a5BuildSingleBg(arg_265_0)
	return string.format("singlebg/v1a5_building_singlebg/%s.png", arg_265_0)
end

function var_0_0.getDialogueSingleBg(arg_266_0)
	return string.format("singlebg/dialogue/%s.png", arg_266_0)
end

function var_0_0.getSummonFreeButton()
	return "ui/viewres/summon/summonfreebutton.prefab"
end

function var_0_0.getAchievementIcon(arg_268_0)
	return string.format("singlebg/achievement/%s.png", arg_268_0)
end

function var_0_0.getAchievementLangIcon(arg_269_0)
	return string.format("singlebg_lang/txt_achievement/%s.png", arg_269_0)
end

function var_0_0.getV1a4SignSingleBg(arg_270_0)
	return string.format("singlebg/v1a4_sign_singlebg/%s.png", arg_270_0)
end

function var_0_0.getV1a4SignSingleBgLang(arg_271_0)
	return string.format("singlebg_lang/txt_v1a4_sign_singlebg/%s.png", arg_271_0)
end

function var_0_0.getSummonBanner(arg_272_0)
	return string.format("singlebg/summon/banner/%s.png", arg_272_0)
end

function var_0_0.getSummonBannerLine(arg_273_0)
	return string.format("singlebg/summon/banner/bannerline/%s.png", arg_273_0)
end

function var_0_0.getV1a5News(arg_274_0)
	return string.format("singlebg/v1a5_news_singlebg/%s.png", arg_274_0)
end

function var_0_0.getV1a5SignSingleBg(arg_275_0)
	return string.format("singlebg/v1a5_sign_singlebg/%s.png", arg_275_0)
end

function var_0_0.getV1a5SignSingleBgLang(arg_276_0)
	return string.format("singlebg_lang/txt_v1a5_sign_singlebg/%s.png", arg_276_0)
end

function var_0_0.getV1a5AiZiLaItemIcon(arg_277_0)
	return string.format("singlebg/v1a5_aizila_icon/%s.png", arg_277_0)
end

function var_0_0.getV1a6DungeonSingleBg(arg_278_0)
	return string.format("singlebg/v1a6_dungeon_singlebg/%s.png", arg_278_0)
end

function var_0_0.getV1a6CachotIcon(arg_279_0)
	return string.format("singlebg/v1a6_cachot_singlebg/%s.png", arg_279_0)
end

function var_0_0.getV1a6SignSingleBg(arg_280_0)
	return string.format("singlebg/v1a6_sign_singlebg/%s.png", arg_280_0)
end

function var_0_0.getV1a6SignSingleBgLang(arg_281_0)
	return string.format("singlebg_lang/txt_v1a6_sign_singlebg/%s.png", arg_281_0)
end

function var_0_0.getV1a7SignSingleBg(arg_282_0)
	return string.format("singlebg/v1a7_signinview/%s.png", arg_282_0)
end

function var_0_0.getV1a7SignSingleBgLang(arg_283_0)
	return string.format("singlebg_lang/txt_v1a7_sign_singlebg/%s.png", arg_283_0)
end

function var_0_0.getSeason123Scene(arg_284_0, arg_284_1)
	return string.format("scenes/%s/scene_prefab/%s.prefab", arg_284_0, arg_284_1)
end

function var_0_0.getSeason123LayerDetailBg(arg_285_0, arg_285_1)
	return string.format("singlebg/%s/level/%s.png", arg_285_0, arg_285_1)
end

function var_0_0.getV1a8SignSingleBg(arg_286_0)
	return string.format("singlebg/v1a8_signinview/%s.png", arg_286_0)
end

function var_0_0.getV1a8DungeonSingleBg(arg_287_0)
	return string.format("singlebg/v1a8_dungeon_singlebg/%s.png", arg_287_0)
end

function var_0_0.getV1a8SignSingleBgLang(arg_288_0)
	return string.format("singlebg_lang/txt_v1a8_sign_singlebg/%s.png", arg_288_0)
end

function var_0_0.getSeason123RetailPrefab(arg_289_0, arg_289_1)
	return string.format("scenes/%s/prefab/%s.prefab", arg_289_0, arg_289_1)
end

function var_0_0.getSeason123ResetStageIcon(arg_290_0, arg_290_1)
	return string.format("singlebg/%s/reset/area/pic_%s.png", arg_290_0, arg_290_1)
end

function var_0_0.getSeason123EpisodeIcon(arg_291_0, arg_291_1)
	return string.format("singlebg/%s/loading/%s.png", arg_291_0, arg_291_1)
end

function var_0_0.getSeason123Icon(arg_292_0, arg_292_1)
	return string.format("singlebg/%s/%s.png", arg_292_0, arg_292_1)
end

function var_0_0.getTurnbackRecommendLangPath(arg_293_0)
	return string.format("Assets/ZResourcesLib/singlebg_lang/txt_turnbackrecommend/%s.png", arg_293_0)
end

function var_0_0.getV1a9SignSingleBg(arg_294_0)
	return string.format("singlebg/v1a9_sign_singlebg/%s.png", arg_294_0)
end

function var_0_0.getV1a9LogoSingleBg(arg_295_0)
	return string.format("singlebg/v1a9_logo_singlebg/%s.png", arg_295_0)
end

function var_0_0.getV1a9WarmUpSingleBg(arg_296_0)
	return string.format("singlebg/v1a9_warmup_singlebg/v1a9_warmup_day%s.png", arg_296_0)
end

function var_0_0.getPermanentSingleBg(arg_297_0)
	return string.format("singlebg/dungeon/reappear/%s.png", arg_297_0)
end

function var_0_0.getMainSceneSwitchIcon(arg_298_0)
	return string.format("singlebg/mainsceneswitch_singlebg/%s.png", arg_298_0)
end

function var_0_0.getRougeIcon(arg_299_0)
	return string.format("singlebg/rouge/%s.png", arg_299_0)
end

function var_0_0.getRougeBattleRoleIcon(arg_300_0)
	return string.format("singlebg/toughbattle_singlebg/role/%s.png", arg_300_0)
end

function var_0_0.getRougeSingleBgCollection(arg_301_0)
	return string.format("singlebg/rouge/collection/%s.png", arg_301_0)
end

function var_0_0.getRougeSingleBgDLC(arg_302_0)
	return string.format("singlebg/rouge/dlc/%s.png", arg_302_0)
end

function var_0_0.getRougeDLCLangImage(arg_303_0)
	return string.format("singlebg_lang/txt_rouge/dlc/%s.png", arg_303_0)
end

function var_0_0.getGraffitiIcon(arg_304_0)
	return string.format("singlebg/v2a0_graffiti_singlebg/%s.png", arg_304_0)
end

function var_0_0.getV2a0SignSingleBg(arg_305_0)
	return string.format("singlebg/v2a0_sign_singlebg/%s.png", arg_305_0)
end

function var_0_0.getV2a0SignSingleBgLang(arg_306_0)
	return string.format("singlebg_lang/txt_v2a0_sign_singlebg/%s.png", arg_306_0)
end

function var_0_0.getV2a0WarmUpSingleBg(arg_307_0)
	return string.format("singlebg/v2a0_warmup_singlebg/%s.png", arg_307_0)
end

function var_0_0.getV2a1SignSingleBg(arg_308_0)
	return string.format("singlebg/v2a1_sign_singlebg/%s.png", arg_308_0)
end

function var_0_0.getV2a1SignSingleBgLang(arg_309_0)
	return string.format("singlebg_lang/txt_v2a1_sign_singlebg/%s.png", arg_309_0)
end

function var_0_0.getV2a1AergusiSingleBg(arg_310_0)
	return string.format("singlebg/v2a1_aergusi_singlebg/%s.png", arg_310_0)
end

function var_0_0.getV2a1MoonFestivalSignSingleBg(arg_311_0)
	return string.format("singlebg/v2a1_moonfestival_singlebg/%s.png", arg_311_0)
end

function var_0_0.getV2a1MoonFestivalSignSingleBgLang(arg_312_0)
	return string.format("singlebg_lang/txt_v2a1_moonfestival_singlebg/%s.png", arg_312_0)
end

function var_0_0.getV2a1WarmUpSingleBg(arg_313_0)
	return string.format("singlebg/v2a1_warmup_singlebg/%s.png", arg_313_0)
end

function var_0_0.getV2a2SignSingleBg(arg_314_0)
	return string.format("singlebg/v2a2_sign_singlebg/%s.png", arg_314_0)
end

function var_0_0.getV2a2SignSingleBgLang(arg_315_0)
	return string.format("singlebg_lang/txt_v2a2_logo/%s.png", arg_315_0)
end

function var_0_0.getV2a2RedLeafFestivalSignSingleBg(arg_316_0)
	return string.format("singlebg/v2a2_redleaffestival_singlebg/%s.png", arg_316_0)
end

function var_0_0.getV2a2RedLeafFestivalSignSingleBgLang(arg_317_0)
	return string.format("singlebg_lang/txt_v2a2_redleaffestival_singlebg/%s.png", arg_317_0)
end

function var_0_0.getV2a3SignSingleBg(arg_318_0)
	return string.format("singlebg/v2a3_sign_singlebg/%s.png", arg_318_0)
end

function var_0_0.getV2a3SignSingleBgLang(arg_319_0)
	return string.format("singlebg_lang/txt_v2a3_sign_singlebg/%s.png", arg_319_0)
end

function var_0_0.getV2a3WarmUpSingleBg(arg_320_0)
	return string.format("singlebg/v2a3_warmup_singlebg/%s.png", arg_320_0)
end

function var_0_0.getV2a4SignSingleBg(arg_321_0)
	return string.format("singlebg/v2a4_sign_singlebg/%s.png", arg_321_0)
end

function var_0_0.getV2a4SignSingleBgLang(arg_322_0)
	return string.format("singlebg_lang/txt_v2a4_sign_singlebg/%s.png", arg_322_0)
end

function var_0_0.getChessDialogueSingleBg(arg_323_0)
	return string.format("singlebg/dialogue/chess/%s.png", arg_323_0)
end

function var_0_0.getV2a5SignSingleBg(arg_324_0)
	return string.format("singlebg/v2a5_sign_singlebg/%s.png", arg_324_0)
end

function var_0_0.getV2a5SignSingleBgLang(arg_325_0)
	return string.format("singlebg_lang/txt_v2a5_sign_singlebg/%s.png", arg_325_0)
end

local var_0_1 = "Assets/ZResourcesLib/"
local var_0_2 = string.len(var_0_1)

function var_0_0.getPathWithoutAssetLib(arg_326_0)
	local var_326_0 = string.find(arg_326_0, var_0_1)

	if var_326_0 then
		return string.sub(arg_326_0, var_326_0 + var_0_2)
	end

	return arg_326_0
end

function var_0_0.getV2a1Act165SingleBgLang(arg_327_0)
	return string.format("singlebg/v2a1_strangetale_singlebg/%s.png", arg_327_0)
end

function var_0_0.monsterHeadIcon(arg_328_0)
	return string.format("singlebg/headicon_monster/%s.png", tostring(arg_328_0))
end

function var_0_0.roomHeadIcon(arg_329_0)
	return string.format("singlebg/headicon_room/%s.png", tostring(arg_329_0))
end

function var_0_0.getCritterHedaIcon(arg_330_0)
	return string.format("singlebg/headicon_critter/%s.png", tostring(arg_330_0))
end

function var_0_0.getCritterLargeIcon(arg_331_0)
	return string.format("singlebg/largeicon_critter/%s.png", tostring(arg_331_0))
end

function var_0_0.getRoomCritterIcon(arg_332_0)
	return string.format("singlebg/room/critter/%s.png", tostring(arg_332_0))
end

function var_0_0.getRoomCritterEggPrefab(arg_333_0)
	return string.format("ui/viewres/room/critter/egg/%s.prefab", arg_333_0)
end

function var_0_0.getBgmEggIcon(arg_334_0)
	return string.format("singlebg/bgmtoggle_singlebg/%s.png", tostring(arg_334_0))
end

function var_0_0.getTowerIcon(arg_335_0)
	return string.format("singlebg/tower_singlebg/%s.png", tostring(arg_335_0))
end

function var_0_0.getAct174BadgeIcon(arg_336_0, arg_336_1)
	return string.format("singlebg/act174/badgeicon/%s_%s.png", arg_336_0, arg_336_1)
end

function var_0_0.getAct174BuffIcon(arg_337_0)
	return string.format("singlebg/act174/bufficon/%s.png", arg_337_0)
end

function var_0_0.getV2a4WuErLiXiIcon(arg_338_0)
	return string.format("singlebg/v2a4_wuerlixi_singlebg/%s.png", arg_338_0)
end

function var_0_0.getAutoChessIcon(arg_339_0, arg_339_1)
	if arg_339_1 then
		return string.format("singlebg/v2a5_autochess_singlebg/%s/%s.png", arg_339_1, arg_339_0)
	else
		return string.format("singlebg/v2a5_autochess_singlebg/%s.png", arg_339_0)
	end
end

function var_0_0.getChallengeIcon(arg_340_0)
	return string.format("singlebg/v2a5_challenge_singlebg/%s.png", arg_340_0)
end

function var_0_0.getAct184LanternIcon(arg_341_0)
	return string.format("singlebg/v2a5_lanternfestival_singlebg/%s.png", arg_341_0)
end

function var_0_0.getV2a5FeiLinShiDuoBg(arg_342_0)
	return string.format("singlebg/v2a5_feilinshiduo_singlebg/%s.png", arg_342_0)
end

function var_0_0.getLiveHeadIconPrefab(arg_343_0)
	return (string.format("ui/viewres/dynamichead/%s.prefab", tostring(arg_343_0)))
end

function var_0_0.getAntiqueEffect(arg_344_0)
	return (string.format("ui/viewres/antique/effect/%s.prefab", tostring(arg_344_0)))
end

function var_0_0.getDestinyIcon(arg_345_0)
	return (string.format("singlebg/characterdestiny/stone/%s.png", tostring(arg_345_0)))
end

function var_0_0.getV2a4WarmUpSingleBg(arg_346_0)
	return string.format("singlebg/v2a4_warmup_singlebg/%s.png", arg_346_0)
end

function var_0_0.getDecorateStoreImg(arg_347_0)
	return (string.format("singlebg/store/decorate/%s.png", tostring(arg_347_0)))
end

function var_0_0.getV2a5LiangYueImg(arg_348_0)
	return (string.format("singlebg_lang/txt_v2a5_liangyue_singlebg/%s.png", tostring(arg_348_0)))
end

function var_0_0.getShortenActSingleBg(arg_349_0)
	return string.format("singlebg/shortenact_singlebg/%s.png", arg_349_0)
end

function var_0_0.getAct191SingleBg(arg_350_0)
	return string.format("singlebg/act191/%s.png", arg_350_0)
end

function var_0_0.getV2a7WarmUpSingleBg(arg_351_0)
	return string.format("singlebg/v2a7_warmup_singlebg/%s.png", arg_351_0)
end

function var_0_0.getSurvivalItemIcon(arg_352_0)
	return string.format("singlebg/survival_singlebg/collection/%s.png", arg_352_0)
end

function var_0_0.getSurvivalTalentIcon(arg_353_0)
	return string.format("singlebg/survival_singlebg/talent/%s.png", arg_353_0)
end

function var_0_0.getSurvivalMapIcon(arg_354_0)
	return string.format("singlebg/survival_singlebg/map/%s.png", arg_354_0)
end

function var_0_0.getSurvivalNpcIcon(arg_355_0)
	return string.format("singlebg/survival_singlebg/npc/%s.png", arg_355_0)
end

function var_0_0.getSurvivalEquipIcon(arg_356_0)
	return string.format("singlebg/survival_singlebg/equip/icon/%s.png", arg_356_0)
end

function var_0_0.getNuoDiKaSingleBg(arg_357_0)
	return string.format("singlebg/v2a8_nuodika_singlebg/%s.png", arg_357_0)
end

function var_0_0.getNuoDiKaItemIcon(arg_358_0)
	return string.format("singlebg/v2a8_nuodika_singlebg/item/%s.png", arg_358_0)
end

function var_0_0.getNuoDiKaMonsterIcon(arg_359_0)
	return string.format("singlebg/v2a8_nuodika_singlebg/monster/%s.png", arg_359_0)
end

function var_0_0.getActivity2ndTakePhotoSingleBg(arg_360_0)
	return string.format("singlebg/v2a8_gift_singlebg/%s", arg_360_0)
end

function var_0_0.getDecorateStoreBuyBannerFullPath(arg_361_0)
	return string.format("singlebg_lang/txt_playercard_singlebg/%s.png", arg_361_0)
end

function var_0_0.getV2a8WarmUpSingleBg(arg_362_0)
	return string.format("singlebg/v2a8_warmup_singlebg/%s.png", arg_362_0)
end

function var_0_0.getCommandStationPaperIcon(arg_363_0)
	return string.format("singlebg/commandstation/paper/%s.png", arg_363_0)
end

function var_0_0.getV3a0WarmUpSingleBg(arg_364_0)
	return string.format("singlebg/v3a0_warmup_singlebg/%s.png", arg_364_0)
end

return var_0_0
