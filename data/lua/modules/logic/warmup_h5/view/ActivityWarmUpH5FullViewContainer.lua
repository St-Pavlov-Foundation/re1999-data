-- chunkname: @modules/logic/warmup_h5/view/ActivityWarmUpH5FullViewContainer.lua

module("modules.logic.warmup_h5.view.ActivityWarmUpH5FullViewContainer", package.seeall)

local ActivityWarmUpH5FullViewContainer = class("ActivityWarmUpH5FullViewContainer", BaseViewContainer)

function ActivityWarmUpH5FullViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityWarmUpH5FullView.New())

	return views
end

function ActivityWarmUpH5FullViewContainer:actId()
	return self.viewParam.actId
end

function ActivityWarmUpH5FullViewContainer:getBgResUrl(fallback)
	fallback = fallback or "singlebg_lang/txt_activity/activity_h5_banner.png"

	return ActivityType100Config.instance:getWarmUpH5BgResUrl(self:actId(), fallback)
end

function ActivityWarmUpH5FullViewContainer:getH5BaseUrl()
	return ActivityType100Config.instance:getWarmUpH5Link(self:actId())
end

function ActivityWarmUpH5FullViewContainer:bLoadResFromWebside()
	return ActivityType100Config.instance:bLoadResFromWebside(self:actId())
end

local kPrefix = "WarmUpH5|"

function ActivityWarmUpH5FullViewContainer:getPrefsKeyPrefix()
	return kPrefix .. tostring(self:actId())
end

function ActivityWarmUpH5FullViewContainer:saveInt(key, value)
	PlayerPrefsHelper.setNumber(key, value)
end

function ActivityWarmUpH5FullViewContainer:getInt(key, defaultValue)
	return PlayerPrefsHelper.getNumber(key, defaultValue)
end

function ActivityWarmUpH5FullViewContainer:saveStr(key, value)
	PlayerPrefsHelper.setString(key, value)
end

function ActivityWarmUpH5FullViewContainer:getStr(key, defaultValue)
	return PlayerPrefsHelper.getString(key, defaultValue)
end

local kDLed = "dled|"

function ActivityWarmUpH5FullViewContainer:_getPrefsKeyDownloadedPic()
	return self:getPrefsKeyPrefix() .. kDLed
end

function ActivityWarmUpH5FullViewContainer:saveDownloadedPicUrl(newPicUrl)
	if self:getDownloadedPicUrl() == newPicUrl then
		return
	end

	local key = self:_getPrefsKeyDownloadedPic()

	self:saveStr(key, newPicUrl or "")
end

function ActivityWarmUpH5FullViewContainer:clearDownloadedPicUrl()
	local key = self:_getPrefsKeyDownloadedPic()

	self:saveStr(key, "")
end

function ActivityWarmUpH5FullViewContainer:getDownloadedPicUrl()
	local key = self:_getPrefsKeyDownloadedPic()

	return self:getStr(key, "")
end

return ActivityWarmUpH5FullViewContainer
