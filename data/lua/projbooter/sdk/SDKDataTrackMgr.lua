﻿-- chunkname: @projbooter/sdk/SDKDataTrackMgr.lua

module("projbooter.sdk.SDKDataTrackMgr", package.seeall)

local SDKDataTrackMgr = class("SDKDataTrackMgr")

SDKDataTrackMgr.EventName = {
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
SDKDataTrackMgr.EventProperties = {
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
SDKDataTrackMgr.RequestResult = {
	success = "success",
	fail = "fail"
}
SDKDataTrackMgr.Result = {
	success = "success",
	fail = "fail"
}
SDKDataTrackMgr.UserProperties = {
	FirstStartTime = "frist_star_time",
	DownloadChannel = "DownloadChannel",
	AppChannelId = "app_channelid",
	AppSubChannelId = "app_subchannelid"
}
SDKDataTrackMgr.PropertyTypes = {
	[SDKDataTrackMgr.EventProperties.UpdateAmount] = "number",
	[SDKDataTrackMgr.EventProperties.UpdatePercentage] = "string",
	[SDKDataTrackMgr.UserProperties.DownloadChannel] = "string",
	[SDKDataTrackMgr.UserProperties.AppChannelId] = "string",
	[SDKDataTrackMgr.UserProperties.AppSubChannelId] = "string",
	[SDKDataTrackMgr.UserProperties.AppSubChannelId] = "string",
	[SDKDataTrackMgr.EventProperties.request_result] = "string",
	[SDKDataTrackMgr.EventProperties.request_url] = "string",
	[SDKDataTrackMgr.EventProperties.result_code] = "string",
	[SDKDataTrackMgr.EventProperties.result_message] = "string",
	[SDKDataTrackMgr.EventProperties.start_timestamp] = "datetime",
	[SDKDataTrackMgr.EventProperties.spend_time] = "number",
	[SDKDataTrackMgr.EventProperties.data_length] = "number",
	[SDKDataTrackMgr.EventProperties.host_ip] = "string",
	[SDKDataTrackMgr.EventProperties.result] = "string",
	[SDKDataTrackMgr.EventProperties.result_msg] = "string",
	[SDKDataTrackMgr.EventProperties.current_language] = "string",
	[SDKDataTrackMgr.EventProperties.entrance] = "string",
	[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = "list",
	[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = "string",
	[SDKDataTrackMgr.EventProperties.download_voice_pack_list] = "list",
	[SDKDataTrackMgr.EventProperties.update_amount] = "number",
	[SDKDataTrackMgr.EventProperties.step] = "string",
	[SDKDataTrackMgr.EventProperties.voice_pack_before] = "string",
	[SDKDataTrackMgr.EventProperties.voice_pack_delete] = "string",
	[SDKDataTrackMgr.EventProperties.gamescene] = "string",
	[SDKDataTrackMgr.EventProperties.currenthost] = "string",
	[SDKDataTrackMgr.EventProperties.switchcount] = "number",
	[SDKDataTrackMgr.EventProperties.resource_type] = "list",
	[SDKDataTrackMgr.EventProperties.main_hero_interaction_skin_id] = "number",
	[SDKDataTrackMgr.EventProperties.main_hero_interaction_area_id] = "number",
	[SDKDataTrackMgr.EventProperties.main_hero_interaction_voice_id] = "string"
}
SDKDataTrackMgr.DefinedTypeToLuaType = {
	string = "string",
	array = "table",
	datetime = "number",
	object = "table",
	boolean = "boolean",
	list = "table",
	number = "number"
}
SDKDataTrackMgr.FirstStartTimePrefsKey = "DataTrackFirstStartTime"

function SDKDataTrackMgr:ctor()
	self.csharpInst = ZProj.SDKDataTrackManager.Instance
end

function SDKDataTrackMgr:initSDKDataTrack()
	self.csharpInst:InitSDKDataTrack()
	self:_setFirstStartTimeProperty()
end

function SDKDataTrackMgr:getDataTrackProperties()
	if not self:isEnableDataTrack() then
		return ""
	end

	return self.csharpInst:CallGetStrFunc("getDataTrackProperties")
end

function SDKDataTrackMgr:roleLogin(roleId)
	if not self:isEnableDataTrack() then
		return
	end

	self.csharpInst:CallVoidFuncWithParams("roleLogin", tostring(roleId))

	local channelId = tostring(SDKMgr.instance:getChannelId())
	local subChannelId = tostring(SDKMgr.instance:getSubChannelId())

	self:profileSet({
		[SDKDataTrackMgr.UserProperties.AppChannelId] = channelId,
		[SDKDataTrackMgr.UserProperties.AppSubChannelId] = subChannelId
	})
end

function SDKDataTrackMgr:track(eventName, luaProperties)
	local emptyPropertyNames = {}

	luaProperties = luaProperties or {}

	for propertyName, param in pairs(luaProperties) do
		local definedType = SDKDataTrackMgr.PropertyTypes[propertyName]

		if not string.nilorempty(definedType) and type(param) ~= SDKDataTrackMgr.DefinedTypeToLuaType[definedType] then
			logError(string.format("埋点 属性类型不一致, propertyName: %s, param: %s, currentType: %s, definedType: %s", tostring(propertyName), tostring(param), type(param), SDKDataTrackMgr.DefinedTypeToLuaType[definedType]))
		end

		if definedType == "array" or definedType == "list" and JsonUtil then
			JsonUtil.markAsArray(param)
		end

		if definedType == "array" and #param <= 0 then
			table.insert(emptyPropertyNames, propertyName)
		end
	end

	for i, emptyPropertyName in ipairs(emptyPropertyNames) do
		luaProperties[emptyPropertyName] = nil
	end

	if isDebugBuild then
		logNormal("track event : eventName : " .. eventName .. ", properties : " .. cjson.encode(luaProperties))
	end

	if not self:isEnableDataTrack() then
		return
	end

	return self.csharpInst:CallVoidFuncWithParams("track", eventName, self:_tableToDictionary(luaProperties))
end

function SDKDataTrackMgr:profileSet(luaProperties)
	if not self:isEnableDataTrack() then
		return
	end

	return self.csharpInst:CallVoidFuncWithParams("profileSet", self:_tableToDictionary(luaProperties))
end

function SDKDataTrackMgr:isEnableDataTrack()
	return not SLFramework.FrameworkSettings.IsEditor and not GameChannelConfig.isSlsdk()
end

function SDKDataTrackMgr:_setFirstStartTimeProperty()
	local firstStartTime = UnityEngine.PlayerPrefs.GetInt(SDKDataTrackMgr.FirstStartTimePrefsKey, 0)
	local subChannelId = tostring(SDKMgr.instance:getSubChannelId())

	if firstStartTime == 0 then
		firstStartTime = os.time()

		UnityEngine.PlayerPrefs.SetInt(SDKDataTrackMgr.FirstStartTimePrefsKey, firstStartTime)

		local timeProperty = os.date("%Y-%m-%d %H:%M:%S", firstStartTime)

		self:profileSet({
			[SDKDataTrackMgr.UserProperties.DownloadChannel] = subChannelId
		})
	end
end

function SDKDataTrackMgr:trackChooseServerEvent()
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.ChooseServer, {})
end

function SDKDataTrackMgr:trackHotupdateFilesCheckEvent(result, msg)
	if result == SDKDataTrackMgr.Result.fail then
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_files_check_fail, {
			[SDKDataTrackMgr.EventProperties.result_msg] = msg or ""
		})
	else
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_files_check, {})
	end
end

function SDKDataTrackMgr:trackUnzipFinishEvent(result, msg)
	if result == SDKDataTrackMgr.Result.fail then
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.unzip_finish_fail, {
			[SDKDataTrackMgr.EventProperties.result_msg] = msg or ""
		})
	else
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.unzip_finish, {})
	end
end

function SDKDataTrackMgr:trackResourceLoadFinishEvent(result, msg)
	if result == SDKDataTrackMgr.Result.fail then
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resource_load_fail, {
			[SDKDataTrackMgr.EventProperties.result_msg] = msg or ""
		})
	else
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resource_load_finish, {})
	end
end

function SDKDataTrackMgr:trackGetRemoteVersionEvent(result, url, code, message)
	code = code and tostring(code)

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_request, {
		[SDKDataTrackMgr.EventProperties.request_result] = result,
		[SDKDataTrackMgr.EventProperties.request_url] = url,
		[SDKDataTrackMgr.EventProperties.result_code] = code or "",
		[SDKDataTrackMgr.EventProperties.result_message] = message or ""
	})
end

function SDKDataTrackMgr:trackHotUpdateResourceEvent(result, url, code, message)
	code = code and tostring(code)

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_request_resource, {
		[SDKDataTrackMgr.EventProperties.request_result] = result,
		[SDKDataTrackMgr.EventProperties.request_url] = url,
		[SDKDataTrackMgr.EventProperties.result_code] = code or "",
		[SDKDataTrackMgr.EventProperties.result_message] = message or ""
	})
end

function SDKDataTrackMgr:trackSocketConnectEvent(result, startTimestamp, spendTime, dataLength, hostIp)
	if result == SDKDataTrackMgr.RequestResult.success then
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.first_socket_connect)
	end

	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.socket_connect, {
		[SDKDataTrackMgr.EventProperties.request_result] = result,
		[SDKDataTrackMgr.EventProperties.start_timestamp] = startTimestamp,
		[SDKDataTrackMgr.EventProperties.spend_time] = spendTime,
		[SDKDataTrackMgr.EventProperties.data_length] = dataLength,
		[SDKDataTrackMgr.EventProperties.host_ip] = hostIp
	})
end

function SDKDataTrackMgr:trackVoicePackDownloadConfirm(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, {
		[SDKDataTrackMgr.EventProperties.current_language] = GameConfig:GetCurLangShortcut(),
		[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = GameConfig:GetCurVoiceShortcut(),
		[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = data.current_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.download_voice_pack_list] = data.download_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.entrance] = data.entrance,
		[SDKDataTrackMgr.EventProperties.update_amount] = data.update_amount or 0
	})
end

function SDKDataTrackMgr:trackVoicePackDownloading(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, {
		[SDKDataTrackMgr.EventProperties.step] = data.step,
		[SDKDataTrackMgr.EventProperties.download_voice_pack_list] = data.download_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.update_amount] = data.update_amount or 0,
		[SDKDataTrackMgr.EventProperties.spend_time] = data.spend_time or 0,
		[SDKDataTrackMgr.EventProperties.result_msg] = data.result_msg or ""
	})
end

function SDKDataTrackMgr:trackOptionPackDownloading(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resources_downloading, {
		[SDKDataTrackMgr.EventProperties.step] = data.step,
		[SDKDataTrackMgr.EventProperties.resource_type] = data.resource_type or "",
		[SDKDataTrackMgr.EventProperties.update_amount] = data.update_amount or 0,
		[SDKDataTrackMgr.EventProperties.spend_time] = data.spend_time or 0,
		[SDKDataTrackMgr.EventProperties.result_msg] = data.result_msg or ""
	})
end

function SDKDataTrackMgr:trackOptionPackConfirmDownload(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.confirm_download_resources, {
		[SDKDataTrackMgr.EventProperties.resource_type] = data.resource_type or {}
	})
end

function SDKDataTrackMgr:trackVoicePackSwitch(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_switch, {
		[SDKDataTrackMgr.EventProperties.current_language] = data.current_language,
		[SDKDataTrackMgr.EventProperties.entrance] = data.entrance or "",
		[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = data.current_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = data.current_voice_pack_used or "",
		[SDKDataTrackMgr.EventProperties.voice_pack_before] = data.voice_pack_before or ""
	})
end

function SDKDataTrackMgr:trackVoicePackDelete(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_delete, {
		[SDKDataTrackMgr.EventProperties.current_language] = data.current_language,
		[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = data.current_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = data.current_voice_pack_used or "",
		[SDKDataTrackMgr.EventProperties.voice_pack_delete] = data.voice_pack_delete or ""
	})
end

function SDKDataTrackMgr:trackDomainFailCount(scene, domain, failCount)
	if failCount > 0 then
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.event_hostswitch, {
			[SDKDataTrackMgr.EventProperties.gamescene] = scene,
			[SDKDataTrackMgr.EventProperties.currenthost] = domain,
			[SDKDataTrackMgr.EventProperties.switchcount] = failCount
		})
	end
end

function SDKDataTrackMgr:trackMainHeroInteraction(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.main_hero_interaction, {
		[SDKDataTrackMgr.EventProperties.main_hero_interaction_skin_id] = data.main_hero_interaction_skin_id or -1,
		[SDKDataTrackMgr.EventProperties.main_hero_interaction_area_id] = data.main_hero_interaction_area_id or -1,
		[SDKDataTrackMgr.EventProperties.main_hero_interaction_voice_id] = data.main_hero_interaction_voice_id or ""
	})
end

function SDKDataTrackMgr:_tableToDictionary(luaTable)
	local jsonStr

	if JsonUtil then
		jsonStr = JsonUtil.encode(luaTable)
	else
		jsonStr = cjson.encode(luaTable)
	end

	return self.csharpInst:ConvertDictionary(jsonStr)
end

SDKDataTrackMgr.instance = SDKDataTrackMgr.New()

return SDKDataTrackMgr
