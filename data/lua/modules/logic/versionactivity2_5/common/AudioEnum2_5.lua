module("modules.logic.versionactivity2_5.common.AudioEnum2_5", package.seeall)

slot0 = AudioEnum
slot0.VersionActivity2_5Enter = {
	play_ui_tangren_open1 = 20250002
}
slot0.AutoChess = {
	play_ui_tangren_qishou_confirm = 20250405,
	play_ui_tangren_battle_enter = 20250408,
	play_ui_tangren_toycar_standby_loop = 20250404,
	play_ui_tangren_chess_purchase = 20250407,
	play_ui_tangren_shopping_enter = 20250406,
	play_ui_tangren_toycar_appear = 20250403,
	play_ui_tangren_store_upgrade = 20250409,
	play_ui_tangren_copy_enter = 20250410
}
slot0.GoldenMillet = {
	play_ui_tangren_songpifu_loop = 25251201,
	stop_ui_tangren_songpifu_loop = 25251202
}
slot0.FeiLinShiDuo = {
	play_ui_tangren_bounced = 20250809,
	play_ui_tangren_scene_switch = 20250812,
	play_ui_tangren_spikes_death = 20250810,
	play_ui_tangren_landing = 20250808,
	play_ui_tangren_door_close = 20250814,
	play_ui_formationsave = 20250819,
	play_ui_tangren_revival = 20250811,
	play_ui_tangren_box_push_loop = 20250804,
	play_ui_tangren_ladder_crawl_loop = 20250806,
	play_ui_tangren_door_open = 20250813,
	stop_ui_tangren_ladder_crawl_loop = 20250807,
	play_ui_pkls_endpoint_arrival = 20250815,
	play_ui_pkls_challenge_fail = 20250816,
	play_ui_activity_organ_open = 20250820,
	play_ui_leimi_level_difficulty = 20250817,
	play_ui_tangren_move_loop = 20250802,
	stop_ui_tangren_box_push_loop = 20250805,
	stop_ui_tangren_move_loop = 20250803,
	play_ui_jinye_story_star = 20250818
}
slot2 = {
	Act183_GroupFinished = 20251007,
	Act183_OpenSettlementView = 20251005,
	Act183_EpisodeFinished = 20251001,
	play_ui_rewards_rare_2000081 = 2000081,
	Act183_OpenTaskView = 20211509,
	play_ui_tangren_qiandao_open_25251110 = 25251110,
	Act183_OpenRepressView = 20001907,
	Act183_EscapeRuleLineEffect = 20251002,
	Act183_ClickEpisode = 20251003,
	Act183_HardMainUnlock = 25001040,
	Act183_RefreshEscapeRule = 20211503,
	Act183_SwitchGroup = 20251006,
	Act183_OpenFinishView = 20251004,
	play_ui_shuori_qiyuan_unlock_1 = 25251108,
	Act183_OpenBadgeView = 20001907,
	play_ui_tangren_qiandao_leiji_25251111 = 25251111,
	play_ui_shuori_qiyuan_unlock_2 = 25251109
}
slot0.LiangYueAudio = {
	play_ui_tangren_anzhu = 20250703,
	play_ui_wulu_aizila_forward_paper = 20151006,
	play_ui_tangren_pen2 = 20250707,
	play_ui_wulu_lucky_bag_prize = 25050241,
	play_ui_tangren_delete = 20250705,
	play_ui_tangren_fangru = 20250704,
	play_ui_feichi_stanzas = 20250702,
	play_ui_tangren_pen1 = 20250706,
	play_ui_wangshi_argus_level_open = 20211503
}
slot0.Act186 = {
	play_ui_leimi_theft_open = 25251403,
	play_ui_tangren_cookies_open = 25251414,
	play_ui_mln_day_night = 25251406,
	play_ui_help_switch = 25251413,
	play_ui_tangren_qiuqian = 25251405,
	play_ui_tangren_mysticism = 25251409,
	play_ui_tangren_banger = 25251410,
	play_ui_mln_unlock = 25251411,
	play_ui_common_click = 25251402,
	play_ui_mln_details_open = 25251412,
	stop_ui_bus = 25251401,
	play_ui_tangren_cloud = 25251407,
	play_ui_tangren_firework = 25251408,
	play_ui_mln_page_turn = 25251404
}

for slot6, slot7 in pairs({
	play_autochess = 3251821
}) do
	if isDebugBuild and slot0.Bgm[slot6] then
		logError("AudioEnum.Bgm重复定义" .. slot6)
	end

	slot0.Bgm[slot6] = slot7
end

for slot6, slot7 in pairs(slot2) do
	if isDebugBuild and slot0.UI[slot6] then
		logError("AudioEnum.UI重复定义" .. slot6)
	end

	slot0.UI[slot6] = slot7
end

function slot0.activate()
end

return slot0
