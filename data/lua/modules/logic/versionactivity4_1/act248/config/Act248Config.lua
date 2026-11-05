-- chunkname: @modules/logic/versionactivity4_1/act248/config/Act248Config.lua

module("modules.logic.versionactivity4_1.act248.config.Act248Config", package.seeall)

local Act248Config = class("Act248Config", BaseConfig)

function Act248Config:reqConfigNames()
	return {
		"activity248_clue_category",
		"activity248_clue",
		"activity248_file",
		"activity248_option",
		"activity248_report",
		"activity248_slot",
		"activity248_const"
	}
end

function Act248Config:onInit()
	return
end

function Act248Config:onConfigLoaded(configName, configTable)
	return
end

function Act248Config:getSlotGroupCos(pileId)
	if not self._slotGroupCoDict then
		self._slotGroupCoDict = {}

		for _, co in pairs(lua_activity248_slot.configDict) do
			if not self._slotGroupCoDict[co.pileId] then
				self._slotGroupCoDict[co.pileId] = {}
			end

			table.insert(self._slotGroupCoDict[co.pileId], co)
		end
	end

	return self._slotGroupCoDict[pileId]
end

function Act248Config:getCategoryCo(category)
	return lua_activity248_clue_category.configDict[category]
end

function Act248Config:getReportCo(fileId)
	return lua_activity248_report.configDict[fileId]
end

function Act248Config:getReportOptionCo(id)
	return lua_activity248_option.configDict[id]
end

function Act248Config:getConstValue(id, isNumber)
	local co = lua_activity248_const.configDict[id]
	local value = co and co.value

	if value and isNumber then
		return tonumber(value)
	end

	return value
end

Act248Config.instance = Act248Config.New()

return Act248Config
