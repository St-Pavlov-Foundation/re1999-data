module("modules.logic.versionactivity1_5.common.AudioEnum1_5", package.seeall)

slot0 = AudioEnum
slot0.ui_v1a5_news = {
	play_ui_wulu_complete_burn = 25005503
}
slot0.ui_activity_1_5_wulu = {
	play_ui_wulu_arena_open = 25050216,
	play_ui_wulu_seal_cutting_eft = 25005511,
	play_ui_wulu_caiquan_decide = 25050220,
	play_ui_wulu_caiquan_open = 25050219
}
slot0.ui_mail = {
	play_ui_mail_open_1 = 25005513
}
slot0.ui_activity142 = {
	UnlockChapter = 25050203,
	CloseMapView = 25050229,
	UnlockItem = 25050202,
	OpenMapView = 25050201
}
slot0.chess_activity142 = {
	CloseEye = 25050207,
	FireBall = 25050208,
	MonsterBeHit = 25050210,
	ArrowHitPlayer = 25050215,
	EnterGameView = 25050230,
	Arrow = 25050214,
	Die = 25050211,
	SwitchTrackEnemy = 25050212,
	TileBroken = 25050213,
	SwitchPlayer = 25050206,
	LightBrazier = 25050205
}
slot2 = {
	play_ui_wulu_second_open = 20150003,
	play_ui_wulu_atticletter_opening = 25005505,
	play_ui_wulu_atticletter_write_loop = 25005507,
	play_ui_wulu_quest_unlock = 20150009,
	play_ui_wulu_build = 20150008,
	play_ui_wulu_atticletter_write_stop = 25005508,
	play_ui_wulu_atticletter_cleaning = 25005509,
	play_ui_wulu_atticletter_day_tap = 25005510,
	play_ui_wulu_flame = 20150010,
	play_ui_checkpoint_noise_campfire = 20152001,
	play_ui_wulu_first_open = 20150001,
	play_ui_wulu_switch = 20150005,
	play_ui_wulu_paiqian_open = 20150006,
	play_ui_wulu_atticletter_read_over = 25005506
}

for slot6, slot7 in pairs({
	play_activitymusic_seasonmain_1_5 = 3200085,
	Activity142Bgm = 3200087,
	ActivityMainBgm1_5_1 = 20150002,
	V1a5AiZiLaBgm = 3200088,
	ActivityMainBgm1_5_2 = 20150004,
	ActivityMainBgm1_5 = 3200084
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
