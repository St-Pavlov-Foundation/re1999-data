module("modules.logic.ressplit.work.ResSplitSpecialWork", package.seeall)

slot0 = class("ResSplitSpecialWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = {
		"singlebg/rouge/",
		"ui/viewres/rouge/",
		"atlassrc/ui_modules/rouge/",
		"atlassrc/ui_spriteset/rouge/",
		"scenes/v1a9_m_s16_dilao",
		"scenes/v1a9_m_s16_dilao_room",
		"singlebg/toughbattle_singlebg",
		"singlebg/seasoncelebritycard/",
		"singlebg/summon/heroversion_1_9/",
		"singlebg/summon/heroversion_1_8/",
		"ui/viewres/versionactivity_1_2/",
		"ui/viewres/versionactivity_1_5/",
		"ui/viewres/versionactivity_1_8/",
		"ui/viewres/versionactivity_1_9/",
		"ui/viewres/versionactivity_2_0/",
		"singlebg/versionactivity114_1_2/",
		"singlebg/versionactivitydungeon_1_2/",
		"singlebg/versionactivitystorycollect_1_2/",
		"singlebg/versionactivitytooth_1_2/",
		"singlebg/versionactivitytrip_1_2/",
		"singlebg/versionactivitywhitehouse_1_2/",
		"singlebg_lang/txt_versionactivity114_1_2/",
		"singlebg_lang/txt_versionactivitytask_1_2/",
		"singlebg_lang/txt_versionactivitytooth_1_2/",
		"singlebg_lang/versionactivitywhitehouse_1_2/",
		"singlebg_lang/txt_versionactivitywhitehouse_1_2/",
		"singlebg/v1a5_building_singlebg/",
		"singlebg/v1a5_dungeon_singlebg/",
		"singlebg/v1a5_enterview_singlebg/",
		"singlebg/v1a5_revival_singlebg/",
		"singlebg/v1a5_storyactivityopenclose/",
		"singlebg/v1a5_taskview_singlebg/",
		"singlebg_lang/txt_v1a5_enterview_singlebg/",
		"singlebg_lang/txt_v1a5_storyactivityopenclose/",
		"singlebg_lang/txt_v1a5_taskview_singlebg/",
		"singlebg/v1a8_warmup_singlebg/",
		"singlebg/v1a9_mainactivity_singlebg/",
		"singlebg/v1a9_matildagift_singlebg/",
		"singlebg/v1a9_warmup_singlebg/",
		"singlebg/v2a0_dungeon_singlebg/",
		"singlebg/v2a0_graffiti_singlebg/",
		"singlebg/v2a0_mainactivity_singlebg/",
		"singlebg/v2a0_mercuria_singlebg/",
		"singlebg/v2a0_opening_singlebg/",
		"singlebg/v2a0_paint_singlebg/",
		"singlebg/v2a0_season_singlebg/",
		"singlebg/v2a0_sign_singlebg/",
		"singlebg/v2a0_warmup_singlebg/",
		"singlebg_lang/txt_v2a0_mainactivity_singlebg/",
		"singlebg_lang/txt_v2a0_mercuria_singlebg/",
		"singlebg_lang/txt_v2a0_opening_singlebg/",
		"singlebg_lang/txt_v2a0_sign_singlebg/",
		"singlebg_lang/txt_v2a0_warmup_singlebg/",
		"scenes/m_s14_hddt_hd02/",
		"scenes/m_s12_dfw_yaxian/",
		"scenes/v1a5_m_s14_hddt_hd/",
		"scenes/v1a5_m_s14_hddt_tz/",
		"scenes/v2a0_m_s14_hddt/",
		"scenes/v2a0_m_s15_sj/",
		"singlebg/storybg/story_atcg/2_7/",
		"singlebg/storybg/story_atcg/2_6/",
		"singlebg/dungeon/fragmenticon/"
	}
	slot3 = {
		"1_2lvhuemeng",
		"1_2lvhuemeng_1",
		"1_5_kaimu",
		"1_7_enter",
		"1_8_kaimu",
		"1_9_enter",
		"xuzhangkaichangpv_2k",
		"xuzhangkaichangpv_4k",
		"yaxianpifu",
		"getianpifu",
		"2.tsnn_v2a2",
		"quniang_v2a5",
		"quniang",
		"liangyue_v2a5",
		"luxi_v1a9",
		"37_v2a2"
	}
	slot5 = {
		FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.buff_chuchang),
		FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.buff_siwang),
		FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.buff_siwang_monster),
		FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.buff_zhunbeigongji),
		FightHelper.getEffectUrlWithLod(FightPreloadEffectWork.scene_mask_default),
		"effects/prefabs/buff/buff_shuxingzengjia.prefab"
	}
	slot6 = {
		"effects/prefabs/xingti"
	}

	for slot10, slot11 in pairs({
		"effects/prefabs/buff/shuzhen_zaowu_znegyi_1_2.prefab",
		"effects/prefabs/buff/ydzrdzwxm_zengyi.prefab",
		"effects/prefabs/buff/buff_lg_mu.prefab",
		"effects/prefabs/buff/buff_lg_xing.prefab",
		"effects/prefabs/buff/shuzhen_zaowu_znegyi_2_2.prefab",
		"effects/prefabs/buff/shuzhen_zaowu_jianyi_1_2.prefab",
		"effects/prefabs/buff/buff_lg_ling.prefab",
		"effects/prefabs/buff/buff_lg_yan.prefab",
		"effects/prefabs/buff/shuzhen_zaowu_jianyi_2_2.prefab",
		"effects/prefabs/buff/buff_lg_shou.prefab",
		"effects/prefabs/buff/buff_lg_zhi.prefab",
		"effects/prefabs/buff/ydzrdzwxm_jianyi.prefab",
		"singlebg/signature/501203.png",
		"singlebg/bgmtoggle_singlebg/bg_beijing.png",
		"singlebg/bgmtoggle_singlebg/bg_beijingwanshang.png",
		"singlebg/bgmtoggle_singlebg/bg_beijingxiyang.png",
		"singlebg/bgmtoggle_singlebg/bg_beijingyintian.png",
		"singlebg/bgmtoggle_singlebg/bgmtoggle_mechine_2.png",
		"singlebg/bgmtoggle_singlebg/v01.png",
		"singlebg/bgmtoggle_singlebg/v02.png",
		"singlebg/bgmtoggle_singlebg/v03.png",
		"singlebg/bgmtoggle_singlebg/v04.png",
		"singlebg/bgmtoggle_singlebg/v05.png",
		"singlebg/bgmtoggle_singlebg/v06.png",
		"singlebg/bgmtoggle_singlebg/v07.png",
		"singlebg/bgmtoggle_singlebg/v08.png",
		"singlebg/bgmtoggle_singlebg/v09.png",
		"singlebg/bgmtoggle_singlebg/y01.png",
		"singlebg/bgmtoggle_singlebg/y02.png",
		"singlebg/bgmtoggle_singlebg/y03.png",
		"singlebg/bgmtoggle_singlebg/y04.png",
		"singlebg/bgmtoggle_singlebg/y05.png",
		"singlebg/bgmtoggle_singlebg/y06.png",
		"singlebg/bgmtoggle_singlebg/y07.png",
		"singlebg/bgmtoggle_singlebg/y08.png",
		"singlebg/bgmtoggle_singlebg/y09.png",
		"singlebg/toughbattle_singlebg/role/rolehalfpic6.png",
		"singlebg/handbook/equip/14281.png",
		"singlebg/handbook/equip/14282.png",
		"singlebg/handbook/equip/14283.png",
		"singlebg/handbook/equip/14284.png",
		"singlebg/handbook/equip/14291.png",
		"singlebg/handbook/equip/14292.png",
		"singlebg/handbook/equip/14293.png",
		"singlebg/handbook/equip/14294.png",
		"singlebg/handbook/equip/15271.png",
		"singlebg/handbook/equip/15272.png",
		"singlebg/handbook/equip/15273.png",
		"singlebg/handbook/equip/15274.png",
		"singlebg/handbook/equip/15281.png",
		"singlebg/handbook/equip/15282.png",
		"singlebg/handbook/equip/15283.png",
		"singlebg/handbook/equip/15284.png",
		"singlebg/handbook/equip/15291.png",
		"singlebg/handbook/equip/15292.png",
		"singlebg/handbook/equip/15293.png",
		"singlebg/handbook/equip/15294.png",
		"singlebg/handbook/equip/15301.png",
		"singlebg/handbook/equip/15302.png",
		"singlebg/handbook/equip/15303.png",
		"singlebg/handbook/equip/15304.png",
		"singlebg/handbookheroicon/300402.png",
		"singlebg/handbookheroicon/302501_3.png",
		"singlebg/handbookheroicon/302504.png",
		"singlebg/handbookheroicon/302802.png",
		"singlebg/handbookheroicon/306601_2.png",
		"singlebg/headicon_small/620222.png",
		"singlebg/headicon_small/306618.png",
		"singlebg/headicon_small/307914.png",
		"singlebg/storybg/item/1_9_daboyihao.png",
		"singlebg/storybg/story_atcg/1_9/1_9_at_kaka.jpg",
		"singlebg/storybg/story_atcg/1_9/1_9_at_kakaniyagege1.jpg",
		"singlebg/storybg/smallbg/story_atcg/1_9/1_9_at_kakaniyagege1.jpg",
		"singlebg/storybg/smallbg/story_atcg/1_9/1_9_at_kakaniyagege.jpg",
		"singlebg/headskinicon_small/309102.png",
		"singlebg/room/building/11921.png",
		"singlebg/room/building/11912.png",
		"singlebg/room/building/11905.png",
		"singlebg/room/building/11908.png",
		"singlebg/room/building/11907.png",
		"singlebg/room/building/11911.png",
		"singlebg/room/building/11906.png",
		"singlebg/room/building/11901.png",
		"singlebg/room/building/11903.png",
		"singlebg/room/building/11902.png",
		"singlebg/room/building/11904.png",
		"singlebg/propitem/building/11921.png",
		"singlebg/propitem/building/11912.png",
		"singlebg/propitem/building/11905.png",
		"singlebg/propitem/building/11908.png",
		"singlebg/propitem/building/11907.png",
		"singlebg/propitem/building/11911.png",
		"singlebg/propitem/building/11906.png",
		"singlebg/propitem/building/11901.png",
		"singlebg/propitem/building/11903.png",
		"singlebg/propitem/building/11902.png",
		"singlebg/propitem/building/11904.png",
		"atlas/sp_rouge3.spriteatlas",
		"singlebg/help/v1a9_bgm_help_1.png",
		"singlebg/help/toughbattle_help_1.png",
		"singlebg/roomget/building/11907.jpg",
		"singlebg/roomget/building/11904.jpg",
		"singlebg/roomget/building/11906.jpg",
		"singlebg/roomget/building/11902.jpg",
		"singlebg/roomget/building/11921.jpg",
		"singlebg/roomget/building/11903.jpg",
		"singlebg/roomget/building/11911.jpg",
		"singlebg/roomget/building/11908.jpg",
		"singlebg/roomget/building/11905.jpg",
		"singlebg/roomget/building/11901.jpg",
		"singlebg/roomget/building/11912.jpg",
		"ui/viewres/summon/version_1_8/versionsummonxingtihalfview.prefab",
		"ui/viewres/summon/version_1_9/v1a9_versionsummongetianhalfview.prefab",
		"ui/viewres/summon/version_1_9/v1a9_versionsummonyaxianhalfview.prefab",
		"ui/viewres/summon/version_1_9/v1a9_versionsummonyuanlvhalfview.prefab",
		"ui/spriteassets/rouge3.asset",
		"scenes/m_s142_dxfktd/textures/m_s142_ground_a.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_ground_a_light.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_ground_mask_a.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_obj_a.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_obj_a_light.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_obj_a_mir.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_obj_b.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_obj_b_light.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_obj_mask01.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_obj_mask02.tga",
		"scenes/m_s142_dxfktd/textures/m_s142_zwirte.tga",
		"scenes/m_s142_dxfktd_rain/m_s142_dxfktd_rain_p.prefab",
		"scenes/v1a4_m_s181_dy_dxsd_rain/v1a4_m_s181_dy_dxsd_rain_p.prefab",
		"scenes/m_s01_zjm_a/textures/vx/leveup_glowline.png",
		"scenes/m_s01_zjm_a/textures/vx/leveup_pop.png",
		"roles/v1a9_670134_wtdjmz/670134_wtdjmz_fight.prefab",
		"roles/v1a9_670134_wtdjmz/670134_wtdjmz_ui.prefab",
		"roles/v1a9_670133_wtdjkjj/670133_wtdjkjj_fight.prefab",
		"roles/v1a9_670133_wtdjkjj/670133_wtdjkjj_material.mat",
		"roles/v1a9_670133_wtdjkjj/670133_wtdjkjj_ui.prefab",
		"singlebg_lang/txt_adventuretask/v1a9_shop_skin1.png",
		"singlebg_lang/txt_adventuretask/v1a9_shop_skin3.png",
		"singlebg_lang/txt_adventuretask/v1a9_shop_skin2.png",
		"singlebg_lang/txt_summon_version_1_9/yaxian/v1a9_roleyaxian_summon_chance.png",
		"singlebg_lang/txt_summon_version_1_9/yaxian/v1a9_yaxian_summon_img_name.png",
		"singlebg_lang/txt_summon_version_1_9/yaxian/v1a9_yaxian_summon_img_title.png",
		"singlebg_lang/txt_summon_version_1_9/getian/v1a9_getian_img_title.png",
		"singlebg_lang/txt_summon_version_1_9/getian/v1a9_getian_summon_chance.png",
		"singlebg_lang/txt_summon_version_1_9/getian/v1a9_getian_summon_name1.png",
		"singlebg_lang/txt_summon_version_1_9/yuanlv/v1a9_roleyuanlv_summon_chance.png",
		"singlebg_lang/txt_summon_version_1_9/yuanlv/v1a9_roleyuanlv_summon_img_title.png",
		"singlebg_lang/txt_summon_version_1_9/yuanlv/v1a9_roleyuanlv_summon_name.png",
		"singlebg_lang/txt_summon_version_1_10",
		"singlebg_lang/txt_summon_version_1_11",
		"singlebg_lang/txt_turnbackrecommend/v1a9_return_01.png",
		"singlebg_lang/txt_turnbackrecommend/v1a9_return_02.png",
		"singlebg_lang/txt_turnbackrecommend/v1a9_return_03.png",
		"singlebg_lang/txt_turnbackrecommend/v1a9_return_04.png",
		"singlebg_lang/txt_turnbackrecommend/v1a9_return_05.png",
		"singlebg_lang/txt_turnbackrecommend/v1a9_return_06.png",
		"singlebg_lang/txt_turnbackrecommend/v1a9_return_07.png",
		"singlebg_lang/txt_turnbackrecommend/v1a9_return_08.png",
		"singlebg_lang/txt_turnbackrecommend/v1a9_return_09.png",
		"singlebg_lang/txt_rouge/rouge_failedtitle.png",
		"singlebg_lang/txt_rouge/enter/rk_rouge.png",
		"rolesstory/rolescg/v1a9_xtxx_shichang"
	}) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Path, slot11, true)
	end

	for slot10, slot11 in pairs(slot5) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Path, slot11, false)
	end

	for slot10, slot11 in pairs(slot2) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, slot11, true)
	end

	for slot10, slot11 in pairs(slot6) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, slot11, false)
	end

	for slot10, slot11 in pairs(slot3) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Video, slot11, true)
	end

	slot0:onDone(true)
end

return slot0
