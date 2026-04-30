-- chunkname: @modules/logic/rouge2/start/controller/Rouge2_SystemCheckHelper.lua

module("modules.logic.rouge2.start.controller.Rouge2_SystemCheckHelper", package.seeall)

local Rouge2_SystemCheckHelper = class("Rouge2_SystemCheckHelper")

function Rouge2_SystemCheckHelper.isContainBattleTag(tagList, targetTag)
	if tagList and targetTag then
		local checkFunc = Rouge2_SystemController.getCheckFuncByTagId(tonumber(targetTag))

		if checkFunc then
			return checkFunc(tagList, targetTag)
		end
	end
end

function Rouge2_SystemController.getCheckFuncByTagId(tagId)
	local checkFunc = Rouge2_SystemCheckHelper.SystemCheckFuncMap and Rouge2_SystemCheckHelper.SystemCheckFuncMap[tagId]

	return checkFunc or Rouge2_SystemController._defaultSystemTagCheckFunc
end

function Rouge2_SystemController._defaultSystemTagCheckFunc(tagList, targetTag)
	return tabletool.indexOf(tagList, targetTag) ~= nil
end

function Rouge2_SystemController._systemCheckFunc_10000(tagList, targetTag)
	if not tagList or not targetTag then
		return
	end

	for _, tag in ipairs(tagList) do
		if tag ~= "101" and tag ~= "102" then
			return true
		end
	end
end

Rouge2_SystemCheckHelper.SystemCheckFuncMap = {
	[10000] = Rouge2_SystemController._systemCheckFunc_10000
}

return Rouge2_SystemCheckHelper
