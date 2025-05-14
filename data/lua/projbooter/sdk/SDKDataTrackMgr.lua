module("projbooter.sdk.SDKDataTrackMgr", package.seeall)

local var_0_0 = class("SDKDataTrackMgr")

var_0_0.EventName = {
	unzip_finish_fail = "unzip_finish_fail",
	hotupdate_81_100 = "hotupdate_81_100",
	unzip_finish = "unzip_finish",
	hotupdate_download = "hotupdate_download",
	voice_pack_UI_manager = "voice_pack_UI_manager",
	hotupdate_0_20 = "hotupdate_0_20",
	hotupdate_files_check_fail = "hotupdate_files_check_fail",
	socket_connect = "socket_connect",
	ChooseRole = "choose_role",
	hotupdate_request = "hotupdate_request",
	hotupdate_request_resource = "hotupdate_request_resource",
	hotupdate_61_80 = "hotupdate_61_80",
	hotupdate_41_60 = "hotupdate_41_60",
	hotupdate_files_check = "hotupdate_files_check",
	hotupdate_21_40 = "hotupdate_21_40",
	confirm_download_resources = "confirm_download_resources",
	first_socket_connect = "first_socket_connect",
	hotupdate_check = "hotupdate_check",
	resource_load = "resource_load",
	voice_pack_downloading = "voice_pack_downloading",
	ChooseServer = "choose_server",
	voice_pack_switch = "voice_pack_switch",
	resource_load_fail = "resource_load_fail",
	voice_pack_delete = "voice_pack_delete",
	unzip_start = "unzip_start",
	resources_downloading = "resources_downloading",
	main_hero_interaction = "main_hero_interaction",
	resource_load_finish = "resource_load_finish",
	event_hostswitch = "event_hostswitch",
	voice_pack_download_confirm = "voice_pack_download_confirm",
	start_game = "start_game",
	HotUpdate = "hot_update"
}
var_0_0.EventProperties = {
	data_length = "data_length",
	result_code = "result_code",
	UpdateAmount = "update_amount",
	current_language = "current_language",
	main_hero_interaction_voice_id = "voiceid",
	update_amount = "update_amount",
	voice_pack_before = "voice_pack_before",
	spend_time = "spend_time",
	voice_pack_delete = "voice_pack_delete",
	start_timestamp = "start_timestamp",
	result_message = "result_message",
	result = "result",
	download_voice_pack_list = "download_voice_pack_list",
	host_ip = "host_ip",
	main_hero_interaction_area_id = "area_id",
	currenthost = "currenthost",
	main_hero_interaction_skin_id = "skinid",
	UpdatePercentage = "update_percentage",
	request_result = "request_result",
	resource_type = "resource_type",
	gamescene = "gamescene",
	current_voice_pack_used = "current_voice_pack_used",
	result_msg = "result_msg",
	entrance = "entrance",
	switchcount = "switchcount",
	current_voice_pack_list = "current_voice_pack_list",
	request_url = "request_url",
	step = "step"
}
var_0_0.RequestResult = {
	success = "success",
	fail = "fail"
}
var_0_0.Result = {
	success = "success",
	fail = "fail"
}
var_0_0.UserProperties = {
	FirstStartTime = "frist_star_time",
	DownloadChannel = "DownloadChannel",
	AppChannelId = "app_channelid",
	AppSubChannelId = "app_subchannelid"
}
var_0_0.PropertyTypes = {
	[var_0_0.EventProperties.UpdateAmount] = "number",
	[var_0_0.EventProperties.UpdatePercentage] = "string",
	[var_0_0.UserProperties.DownloadChannel] = "string",
	[var_0_0.UserProperties.AppChannelId] = "string",
	[var_0_0.UserProperties.AppSubChannelId] = "string",
	[var_0_0.UserProperties.AppSubChannelId] = "string",
	[var_0_0.EventProperties.request_result] = "string",
	[var_0_0.EventProperties.request_url] = "string",
	[var_0_0.EventProperties.result_code] = "string",
	[var_0_0.EventProperties.result_message] = "string",
	[var_0_0.EventProperties.start_timestamp] = "datetime",
	[var_0_0.EventProperties.spend_time] = "number",
	[var_0_0.EventProperties.data_length] = "number",
	[var_0_0.EventProperties.host_ip] = "string",
	[var_0_0.EventProperties.result] = "string",
	[var_0_0.EventProperties.result_msg] = "string",
	[var_0_0.EventProperties.current_language] = "string",
	[var_0_0.EventProperties.entrance] = "string",
	[var_0_0.EventProperties.current_voice_pack_list] = "list",
	[var_0_0.EventProperties.current_voice_pack_used] = "string",
	[var_0_0.EventProperties.download_voice_pack_list] = "list",
	[var_0_0.EventProperties.update_amount] = "number",
	[var_0_0.EventProperties.step] = "string",
	[var_0_0.EventProperties.voice_pack_before] = "string",
	[var_0_0.EventProperties.voice_pack_delete] = "string",
	[var_0_0.EventProperties.gamescene] = "string",
	[var_0_0.EventProperties.currenthost] = "string",
	[var_0_0.EventProperties.switchcount] = "number",
	[var_0_0.EventProperties.resource_type] = "list",
	[var_0_0.EventProperties.main_hero_interaction_skin_id] = "number",
	[var_0_0.EventProperties.main_hero_interaction_area_id] = "number",
	[var_0_0.EventProperties.main_hero_interaction_voice_id] = "string"
}
var_0_0.DefinedTypeToLuaType = {
	string = "string",
	array = "table",
	datetime = "number",
	boolean = "boolean",
	list = "table",
	number = "number"
}
var_0_0.FirstStartTimePrefsKey = "DataTrackFirstStartTime"

function var_0_0.ctor(arg_1_0)
	arg_1_0.csharpInst = ZProj.SDKDataTrackManager.Instance
end

function var_0_0.initSDKDataTrack(arg_2_0)
	arg_2_0.csharpInst:InitSDKDataTrack()
	arg_2_0:_setFirstStartTimeProperty()
end

function var_0_0.getDataTrackProperties(arg_3_0)
	if not arg_3_0:isEnableDataTrack() then
		return ""
	end

	return arg_3_0.csharpInst:CallGetStrFunc("getDataTrackProperties")
end

function var_0_0.roleLogin(arg_4_0, arg_4_1)
	if not arg_4_0:isEnableDataTrack() then
		return
	end

	arg_4_0.csharpInst:CallVoidFuncWithParams("roleLogin", tostring(arg_4_1))

	local var_4_0 = tostring(SDKMgr.instance:getChannelId())
	local var_4_1 = tostring(SDKMgr.instance:getSubChannelId())

	arg_4_0:profileSet({
		[var_0_0.UserProperties.AppChannelId] = var_4_0,
		[var_0_0.UserProperties.AppSubChannelId] = var_4_1
	})
end

function var_0_0.track(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}

	arg_5_2 = arg_5_2 or {}

	for iter_5_0, iter_5_1 in pairs(arg_5_2) do
		local var_5_1 = var_0_0.PropertyTypes[iter_5_0]

		if not string.nilorempty(var_5_1) and type(iter_5_1) ~= var_0_0.DefinedTypeToLuaType[var_5_1] then
			logError(string.format("埋点 属性类型不一致, propertyName: %s, param: %s, currentType: %s, definedType: %s", tostring(iter_5_0), tostring(iter_5_1), type(iter_5_1), var_0_0.DefinedTypeToLuaType[var_5_1]))
		end

		if var_5_1 == "array" or var_5_1 == "list" and JsonUtil then
			JsonUtil.markAsArray(iter_5_1)
		end

		if var_5_1 == "array" and #iter_5_1 <= 0 then
			table.insert(var_5_0, iter_5_0)
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		arg_5_2[iter_5_3] = nil
	end

	if isDebugBuild then
		logNormal("track event : eventName : " .. arg_5_1 .. ", properties : " .. cjson.encode(arg_5_2))
	end

	if not arg_5_0:isEnableDataTrack() then
		return
	end

	return arg_5_0.csharpInst:CallVoidFuncWithParams("track", arg_5_1, arg_5_0:_tableToDictionary(arg_5_2))
end

function var_0_0.profileSet(arg_6_0, arg_6_1)
	if not arg_6_0:isEnableDataTrack() then
		return
	end

	return arg_6_0.csharpInst:CallVoidFuncWithParams("profileSet", arg_6_0:_tableToDictionary(arg_6_1))
end

function var_0_0.isEnableDataTrack(arg_7_0)
	return not SLFramework.FrameworkSettings.IsEditor and not GameChannelConfig.isSlsdk()
end

function var_0_0._setFirstStartTimeProperty(arg_8_0)
	local var_8_0 = UnityEngine.PlayerPrefs.GetInt(var_0_0.FirstStartTimePrefsKey, 0)
	local var_8_1 = tostring(SDKMgr.instance:getSubChannelId())

	if var_8_0 == 0 then
		local var_8_2 = os.time()

		UnityEngine.PlayerPrefs.SetInt(var_0_0.FirstStartTimePrefsKey, var_8_2)

		local var_8_3 = os.date("%Y-%m-%d %H:%M:%S", var_8_2)

		arg_8_0:profileSet({
			[var_0_0.UserProperties.DownloadChannel] = var_8_1
		})
	end
end

function var_0_0.trackChooseServerEvent(arg_9_0)
	var_0_0.instance:track(var_0_0.EventName.ChooseServer, {})
end

function var_0_0.trackHotupdateFilesCheckEvent(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == var_0_0.Result.fail then
		var_0_0.instance:track(var_0_0.EventName.hotupdate_files_check_fail, {
			[var_0_0.EventProperties.result_msg] = arg_10_2 or ""
		})
	else
		var_0_0.instance:track(var_0_0.EventName.hotupdate_files_check, {})
	end
end

function var_0_0.trackUnzipFinishEvent(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == var_0_0.Result.fail then
		var_0_0.instance:track(var_0_0.EventName.unzip_finish_fail, {
			[var_0_0.EventProperties.result_msg] = arg_11_2 or ""
		})
	else
		var_0_0.instance:track(var_0_0.EventName.unzip_finish, {})
	end
end

function var_0_0.trackResourceLoadFinishEvent(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == var_0_0.Result.fail then
		var_0_0.instance:track(var_0_0.EventName.resource_load_fail, {
			[var_0_0.EventProperties.result_msg] = arg_12_2 or ""
		})
	else
		var_0_0.instance:track(var_0_0.EventName.resource_load_finish, {})
	end
end

function var_0_0.trackGetRemoteVersionEvent(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_3 = arg_13_3 and tostring(arg_13_3)

	var_0_0.instance:track(var_0_0.EventName.hotupdate_request, {
		[var_0_0.EventProperties.request_result] = arg_13_1,
		[var_0_0.EventProperties.request_url] = arg_13_2,
		[var_0_0.EventProperties.result_code] = arg_13_3 or "",
		[var_0_0.EventProperties.result_message] = arg_13_4 or ""
	})
end

function var_0_0.trackHotUpdateResourceEvent(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_3 = arg_14_3 and tostring(arg_14_3)

	var_0_0.instance:track(var_0_0.EventName.hotupdate_request_resource, {
		[var_0_0.EventProperties.request_result] = arg_14_1,
		[var_0_0.EventProperties.request_url] = arg_14_2,
		[var_0_0.EventProperties.result_code] = arg_14_3 or "",
		[var_0_0.EventProperties.result_message] = arg_14_4 or ""
	})
end

function var_0_0.trackSocketConnectEvent(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if arg_15_1 == var_0_0.RequestResult.success then
		var_0_0.instance:track(var_0_0.EventName.first_socket_connect)
	end

	var_0_0.instance:track(var_0_0.EventName.socket_connect, {
		[var_0_0.EventProperties.request_result] = arg_15_1,
		[var_0_0.EventProperties.start_timestamp] = arg_15_2,
		[var_0_0.EventProperties.spend_time] = arg_15_3,
		[var_0_0.EventProperties.data_length] = arg_15_4,
		[var_0_0.EventProperties.host_ip] = arg_15_5
	})
end

function var_0_0.trackVoicePackDownloadConfirm(arg_16_0, arg_16_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_download_confirm, {
		[var_0_0.EventProperties.current_language] = GameConfig:GetCurLangShortcut(),
		[var_0_0.EventProperties.current_voice_pack_used] = GameConfig:GetCurVoiceShortcut(),
		[var_0_0.EventProperties.current_voice_pack_list] = arg_16_1.current_voice_pack_list or {},
		[var_0_0.EventProperties.download_voice_pack_list] = arg_16_1.download_voice_pack_list or {},
		[var_0_0.EventProperties.entrance] = arg_16_1.entrance,
		[var_0_0.EventProperties.update_amount] = arg_16_1.update_amount or 0
	})
end

function var_0_0.trackVoicePackDownloading(arg_17_0, arg_17_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_downloading, {
		[var_0_0.EventProperties.step] = arg_17_1.step,
		[var_0_0.EventProperties.download_voice_pack_list] = arg_17_1.download_voice_pack_list or {},
		[var_0_0.EventProperties.update_amount] = arg_17_1.update_amount or 0,
		[var_0_0.EventProperties.spend_time] = arg_17_1.spend_time or 0,
		[var_0_0.EventProperties.result_msg] = arg_17_1.result_msg or ""
	})
end

function var_0_0.trackOptionPackDownloading(arg_18_0, arg_18_1)
	var_0_0.instance:track(var_0_0.EventName.resources_downloading, {
		[var_0_0.EventProperties.step] = arg_18_1.step,
		[var_0_0.EventProperties.resource_type] = arg_18_1.resource_type or "",
		[var_0_0.EventProperties.update_amount] = arg_18_1.update_amount or 0,
		[var_0_0.EventProperties.spend_time] = arg_18_1.spend_time or 0,
		[var_0_0.EventProperties.result_msg] = arg_18_1.result_msg or ""
	})
end

function var_0_0.trackOptionPackConfirmDownload(arg_19_0, arg_19_1)
	var_0_0.instance:track(var_0_0.EventName.confirm_download_resources, {
		[var_0_0.EventProperties.resource_type] = arg_19_1.resource_type or {}
	})
end

function var_0_0.trackVoicePackSwitch(arg_20_0, arg_20_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_switch, {
		[var_0_0.EventProperties.current_language] = arg_20_1.current_language,
		[var_0_0.EventProperties.entrance] = arg_20_1.entrance or "",
		[var_0_0.EventProperties.current_voice_pack_list] = arg_20_1.current_voice_pack_list or {},
		[var_0_0.EventProperties.current_voice_pack_used] = arg_20_1.current_voice_pack_used or "",
		[var_0_0.EventProperties.voice_pack_before] = arg_20_1.voice_pack_before or ""
	})
end

function var_0_0.trackVoicePackDelete(arg_21_0, arg_21_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_delete, {
		[var_0_0.EventProperties.current_language] = arg_21_1.current_language,
		[var_0_0.EventProperties.current_voice_pack_list] = arg_21_1.current_voice_pack_list or {},
		[var_0_0.EventProperties.current_voice_pack_used] = arg_21_1.current_voice_pack_used or "",
		[var_0_0.EventProperties.voice_pack_delete] = arg_21_1.voice_pack_delete or ""
	})
end

function var_0_0.trackDomainFailCount(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3 > 0 then
		var_0_0.instance:track(var_0_0.EventName.event_hostswitch, {
			[var_0_0.EventProperties.gamescene] = arg_22_1,
			[var_0_0.EventProperties.currenthost] = arg_22_2,
			[var_0_0.EventProperties.switchcount] = arg_22_3
		})
	end
end

function var_0_0.trackMainHeroInteraction(arg_23_0, arg_23_1)
	var_0_0.instance:track(var_0_0.EventName.main_hero_interaction, {
		[var_0_0.EventProperties.main_hero_interaction_skin_id] = arg_23_1.main_hero_interaction_skin_id or -1,
		[var_0_0.EventProperties.main_hero_interaction_area_id] = arg_23_1.main_hero_interaction_area_id or -1,
		[var_0_0.EventProperties.main_hero_interaction_voice_id] = arg_23_1.main_hero_interaction_voice_id or ""
	})
end

function var_0_0._tableToDictionary(arg_24_0, arg_24_1)
	local var_24_0

	if JsonUtil then
		var_24_0 = JsonUtil.encode(arg_24_1)
	else
		var_24_0 = cjson.encode(arg_24_1)
	end

	return arg_24_0.csharpInst:ConvertDictionary(var_24_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
