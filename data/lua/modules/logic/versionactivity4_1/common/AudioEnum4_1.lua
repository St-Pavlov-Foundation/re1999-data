-- chunkname: @modules/logic/versionactivity4_1/common/AudioEnum4_1.lua

module("modules.logic.versionactivity4_1.common.AudioEnum4_1", package.seeall)

local AudioEnum4_1 = _M

AudioEnum4_1.EnterView = {
	play_ui_atlantis_4_1_kv_open2 = 410061,
	stop_ui_atlantis_4_1_kv_open = 410060,
	play_ui_atlantis_4_1_kv_open = 410059
}
AudioEnum4_1.ArcadeSurvivor = {
	play_ui_atlantis_nandu_finish = 410016,
	play_ui_atlantis_product_lock = 410022,
	play_ui_atlantis_dialogue_loop = 410018,
	play_ui_atlantis_event_choose = 410020,
	play_ui_yuanzheng_item_get = 410025,
	stop_ui_atlantis_dialogue_loop = 410019,
	play_ui_yuanzheng_interface_open = 410021,
	play_ui_atlantis_text_prompt = 410017,
	play_ui_atlantis_product_buy = 410024,
	play_ui_yuanzheng_interface_open2 = 410023
}
AudioEnum4_1.ArcadeSurvivorBgm = {
	reset_voice_volume_ui_8bit_music = 410005,
	play_huoyue_bossfight_mojing_music_4_1 = 410002,
	set_voice_volume_ui_8bit_music = 410004,
	play_huoyue_bossfight_music_4_1 = 410001,
	stop_ui_8bit_music = 410003
}

local bgm = {}

AudioEnum4_1.GuessGameNew = {
	play_ui_beiai_kapai_start_game = 410045,
	play_ui_beiai_kapai_play_round = 410046,
	play_ui_beiai_kapai_card_content = 410048,
	play_ui_wenming_cards_flipping = 410057,
	play_ui_fuleyuan_yure_whoosh = 410054,
	play_ui_beiai_kapai_announce = 410050,
	play_ui_beiai_kapai_win = 410042,
	play_ui_beiai_kapai_deal = 410040,
	play_ui_beiai_kapai_turnover = 410043,
	play_ui_beiai_kapai_choose = 410047,
	play_ui_fight_card_flip = 410056,
	play_ui_beiai_kapai_settlement_bonus = 410044,
	play_ui_beiai_kapai_lose = 410041,
	play_ui_beiai_kapai_discard = 410104,
	play_ui_beiai_kapai_loseblood = 410106,
	play_ui_beiai_kapai_enter_game = 410105
}
AudioEnum4_1.Investigation_GuessView = {
	play_ui_atlantis_question_wrong = 410081,
	play_ui_atlantis_question_right = 410080
}
AudioEnum4_1.Evelyn = {
	play_ui_atlantis_yifulin_open = 410068,
	play_ui_atlantis_tool_down = 410071,
	play_ui_atlantis_connect_yes = 410073,
	play_ui_atlantis_tool_back = 410088,
	play_ui_atlantis_connect_no = 410074,
	play_ui_atlantis_pen_strat = 410069,
	play_ui_atlantis_tool_get = 410072,
	play_ui_atlantis_tool_out = 410087,
	play_ui_atlantis_pen_end = 410070,
	play_ui_atlantis_level_pass = 410075
}
AudioEnum4_1.PeiShiTa = {
	play_ui_atlantis_obtain_crossbow = 410102,
	play_ui_atlantis_hunter_moves = 410097,
	play_ui_atlantis_warn = 410096,
	play_ui_activity_2_8_fuleyuan_nuodika = 410095,
	play_ui_beiai_kapai_win = 410094,
	play_ui_atlantis_cut_trees = 410093,
	play_ui_atlantis_archery = 410103,
	play_ui_atlantis_hunter_attack = 410098,
	play_ui_atlantis_obtain_axe = 410092
}
AudioEnum4_1.Act248 = {
	play_ui_leimi_theft_open = 410110,
	play_ui_activity_subject_choose = 410114,
	play_ui_wulu_kerandian_unlock = 410113,
	play_ui_lvhu_notebook_get = 410117,
	play_ui_mail_open_1 = 410112,
	play_ui_lvhu_clue_write_1 = 410118,
	play_ui_wulu_aizila_forward_paper = 410119,
	play_ui_atlantis_jiean = 410120,
	stop_ui_atlantis_jiean = 410121,
	play_ui_task_page = 410111,
	play_ui_atlantis_reasoning_open = 410089,
	play_ui_atlantis_clue_error = 410090,
	play_ui_wulu_paiqian_open = 410116,
	play_ui_atlantis_error_fillin = 410091
}

for key, value in pairs(bgm) do
	if isDebugBuild and AudioEnum.Bgm[key] then
		logError("AudioEnum.Bgm重复定义" .. key)
	end

	AudioEnum.Bgm[key] = value
end

return AudioEnum4_1
