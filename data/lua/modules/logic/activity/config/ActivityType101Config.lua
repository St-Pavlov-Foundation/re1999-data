﻿-- chunkname: @modules/logic/activity/config/ActivityType101Config.lua

module("modules.logic.activity.config.ActivityType101Config", package.seeall)

local ActivityType101Config = class("ActivityType101Config", BaseConfig)

function ActivityType101Config:ctor()
	return
end

function ActivityType101Config:reqConfigNames()
	return {
		"activity101_doublefestival",
		"activity101_springsign",
		"activity101_sp_bonus",
		"v2a1_activity101_moonfestivalsign",
		"linkage_activity"
	}
end

function ActivityType101Config:onConfigLoaded(configName, configTable)
	if configName == "activity101_doublefestival" then
		self.__activity101_doublefestivals = nil

		self:__initDoubleFestival()
	elseif configName == "activity101_springsign" then
		self.__activity101_springsign = nil

		self:__initSpringSign()
	elseif configName == "v2a1_activity101_moonfestivalsign" then
		self.__v2a1_activity101_moonfestivalsign = nil

		self:__initMoonFestivalSign()
	elseif configName == "linkage_activity" then
		self.__linkage_activity = nil

		self:__linkageActivity()
	end
end

function ActivityType101Config:__initDoubleFestival()
	local activity101_doublefestivals = self.__activity101_doublefestivals

	if activity101_doublefestivals then
		return activity101_doublefestivals
	end

	local res = {}

	self.__activity101_doublefestivals = res

	for _, v in ipairs(lua_activity101_doublefestival.configList) do
		local activityId = v.activityId
		local day = v.day

		res[activityId] = res[activityId] or {}
		res[activityId][day] = v
	end

	return res
end

function ActivityType101Config:getDoubleFestivalCOByDay(actId, day)
	self:__initDoubleFestival()

	local actCO = self.__activity101_doublefestivals[actId]

	if not actCO then
		return
	end

	return actCO[day]
end

function ActivityType101Config:__initSpringSign()
	local activity101_doublefestivals = self.__activity101_springsign

	if activity101_doublefestivals then
		return activity101_doublefestivals
	end

	local res = {}

	self.__activity101_springsign = res

	for _, v in ipairs(lua_activity101_springsign.configList) do
		local activityId = v.activityId
		local day = v.day

		res[activityId] = res[activityId] or {}
		res[activityId][day] = v
	end

	return res
end

function ActivityType101Config:getSpringSignByDay(actId, day)
	self:__initSpringSign()

	local actCO = self.__activity101_springsign[actId]

	if not actCO then
		return
	end

	return actCO[day]
end

function ActivityType101Config:getSpringSignMaxDay(actId)
	self:__initSpringSign()

	local actCO = self.__activity101_springsign[actId]

	if not actCO then
		return 0
	end

	return #actCO
end

function ActivityType101Config:__initMoonFestivalSign()
	local activity101_moonfestivalsign = self.__v2a1_activity101_moonfestivalsign

	if activity101_moonfestivalsign then
		return activity101_moonfestivalsign
	end

	local res = {}

	self.__v2a1_activity101_moonfestivalsign = res

	for _, v in ipairs(v2a1_activity101_moonfestivalsign.configList) do
		local activityId = v.activityId
		local day = v.day

		res[activityId] = res[activityId] or {}
		res[activityId][day] = v
	end

	return res
end

function ActivityType101Config:getMoonFestivalSignMaxDay(actId)
	self:__initSpringSign()

	local actCO = self.__v2a1_activity101_moonfestivalsign[actId]

	if not actCO then
		return 0
	end

	return #actCO
end

function ActivityType101Config:getMoonFestivalByDay(actId, day)
	self:__initMoonFestivalSign()

	local actCO = self.__v2a1_activity101_moonfestivalsign[actId]

	if not actCO then
		return
	end

	return actCO[day]
end

function ActivityType101Config:getMoonFestivalTaskCO(actId)
	local actCO = self:getSpBonusCO(actId)

	if not actCO then
		return
	end

	return actCO[1]
end

function ActivityType101Config:getSpBonusCO(actId)
	return lua_activity101_sp_bonus.configDict[actId]
end

function ActivityType101Config:__linkageActivity()
	local _linkage_activity = self.__linkage_activity

	if _linkage_activity then
		return _linkage_activity
	end

	local res = {}

	self.__linkage_activity = res

	for _, v in ipairs(lua_linkage_activity.configList) do
		local activityId = v.activityId

		res[activityId] = v
	end

	return res
end

function ActivityType101Config:getLinkageActivityCO(actId)
	self:__linkageActivity()

	return self.__linkage_activity[actId]
end

function ActivityType101Config:getRoleSignActIdList()
	return ActivityConfig.instance:getConstAsNumList(1, "#", {})
end

function ActivityType101Config:getVersionSummonActIdList()
	return ActivityConfig.instance:getConstAsNumList(6, "#", {})
end

ActivityType101Config.instance = ActivityType101Config.New()

return ActivityType101Config
