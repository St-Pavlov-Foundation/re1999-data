-- chunkname: @modules/logic/versionactivity4_1/peishita/helper/PeiShiTaUnitCreateHelper.lua

module("modules.logic.versionactivity4_1.peishita.helper.PeiShiTaUnitCreateHelper", package.seeall)

local PeiShiTaUnitCreateHelper = class("PeiShiTaUnitCreateHelper")

PeiShiTaUnitCreateHelper.UnitCreateStrategies = {
	[PeiShiTaEnum.UnitType.Player] = {
		prefabPath = "#go_AvatarItem",
		compClass = PeiShiTaPlayerComp
	},
	[PeiShiTaEnum.UnitType.Hunter] = {
		prefabPath = "#go_AvatarItem",
		compClass = PeiShiTaHunterComp
	},
	[PeiShiTaEnum.UnitType.Schulz] = {
		prefabPath = "#go_AvatarItem",
		compClass = PeiShiTaSchulzComp
	},
	[PeiShiTaEnum.UnitType.Obstacle] = {
		prefabPath = "#go_ObstacleItem",
		compClass = PeiShiTaObstacleComp
	},
	[PeiShiTaEnum.UnitType.Drop] = {
		prefabPath = "#go_DropItem",
		compClass = PeiShiTaDropComp
	},
	[PeiShiTaEnum.UnitType.Target] = {
		prefabPath = "#go_DropItem",
		compClass = PeiShiTaUnitComp
	}
}

function PeiShiTaUnitCreateHelper.createUnitGroups(view)
	local typeCoList = {}

	for _, typeCo in ipairs(lua_activity220_peishita_unit_type.configList) do
		table.insert(typeCoList, typeCo)
	end

	table.sort(typeCoList, function(a, b)
		if a.layer ~= b.layer then
			return a.layer < b.layer
		end

		return a.id < b.id
	end)

	for _, typeCo in ipairs(typeCoList) do
		local group = gohelper.create2d(view._goUnitInstanceRoot, "unit_group_" .. typeCo.id)

		view._unitGroupRegistry[typeCo.id] = group
	end
end

function PeiShiTaUnitCreateHelper.createUnits(view, registry, gameMo)
	local cursor = {}

	for _, unit in ipairs(gameMo.unitList or {}) do
		local unitType = unit.config.type
		local strategy = PeiShiTaUnitCreateHelper.UnitCreateStrategies[unitType]

		if strategy then
			local compList = registry[unitType]

			if not compList then
				compList = {}
				registry[unitType] = compList
			end

			local index = (cursor[unitType] or 0) + 1

			cursor[unitType] = index

			local comp = compList[index]

			if not comp then
				local templateGO = gohelper.findChild(view._goUnitTemplateList, strategy.prefabPath)

				if not templateGO then
					logError("PeiShiTaUnitCreateHelper:createUnits 单位模板节点缺失: " .. strategy.prefabPath)
				else
					local go = gohelper.clone(templateGO, view._unitGroupRegistry[unitType], "unit_" .. index)

					comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, strategy.compClass)
					compList[index] = comp
				end
			end

			if comp then
				gohelper.setActive(comp.go, true)
				comp:setUnitData(gameMo, unit)
			end
		else
			logError("PeiShiTaUnitCreateHelper:createUnits 未登记的单位类型: " .. tostring(unitType))
		end
	end

	for unitType, compList in pairs(registry) do
		for i = (cursor[unitType] or 0) + 1, #compList do
			compList[i]:_retire()
		end
	end
end

return PeiShiTaUnitCreateHelper
