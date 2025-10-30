﻿-- chunkname: @modules/logic/commonprop/helper/CommonPropUseTipsHelper.lua

module("modules.logic.commonprop.helper.CommonPropUseTipsHelper", package.seeall)

local CommonPropUseTipsHelper = class("CommonPropUseTipsHelper")

function CommonPropUseTipsHelper.getUseTipDesc(itemId, materialType)
	local useTipsConfig = ItemConfig.instance:getItemUseTipConfigById(itemId)

	if useTipsConfig == nil then
		logError("通用立刻使用道具弹窗, 不存在的道具 id:" .. tostring(itemId))

		return nil
	end

	local paramList = {}
	local paramData = string.splitToNumber(useTipsConfig.descParam, "#")

	for _, paramType in ipairs(paramData) do
		local paramStr = CommonPropUseTipsHelper.tryGetDescStr(paramType, itemId, materialType)

		table.insert(paramList, paramStr)
	end

	local desc = GameUtil.getSubPlaceholderLuaLang(useTipsConfig.desc, paramList)

	return desc
end

function CommonPropUseTipsHelper.tryGetDescStr(paramType, itemId, materialType)
	local func = CommonPropUseTipsHelper["tipParamHandler_" .. paramType]

	if not func then
		logError("未处理当前描述触发类型, 触发类型 = " .. tostring(paramType))

		return ""
	end

	return func(itemId, materialType)
end

function CommonPropUseTipsHelper.sortList(a, b)
	if a.priority == b.priority then
		return a.id > b.id
	end

	return a.priority > b.priority
end

function CommonPropUseTipsHelper.tipParamHandler_1(itemId, materialType)
	local config = ItemConfig.instance:getItemConfig(materialType, itemId)

	if not config or config.name == nil then
		logError("通用立刻使用道具弹窗, 不存在的道具 id:" .. tostring(itemId))
	end

	return config.name
end

function CommonPropUseTipsHelper.checkShow(itemId)
	local useTipsConfig = ItemConfig.instance:getItemUseTipConfigById(itemId)

	if useTipsConfig == nil then
		logError("通用立刻使用道具弹窗, 不存在的道具 id:" .. tostring(itemId))

		return false
	end

	if string.nilorempty(useTipsConfig.checkParam) then
		return true
	end

	local paramData = string.split(useTipsConfig.checkParam, "|")

	for _, singleParam in ipairs(paramData) do
		local singlePramList = string.split(singleParam, "#")
		local type = tonumber(singlePramList[1])
		local result = CommonPropUseTipsHelper.tryGetCheckHandler(type, singlePramList)

		if result == false then
			return false
		end
	end

	return true
end

function CommonPropUseTipsHelper.tryGetCheckHandler(paramType, itemId, param)
	local func = CommonPropUseTipsHelper["checkParamHandler_" .. paramType]

	if not func then
		logError("未处理当前检测触发类型, 触发类型 = " .. tostring(paramType))

		return false
	end

	return func(itemId, param)
end

function CommonPropUseTipsHelper.checkParamHandler_1(itemId, param)
	return SignInModel.instance:getCanSupplementMonthCardDays() > 0
end

return CommonPropUseTipsHelper
