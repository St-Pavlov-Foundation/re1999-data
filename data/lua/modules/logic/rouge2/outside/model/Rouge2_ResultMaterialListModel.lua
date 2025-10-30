-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_ResultMaterialListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_ResultMaterialListModel", package.seeall)

local Rouge2_ResultMaterialListModel = class("Rouge2_ResultMaterialListModel", ListScrollModel)

function Rouge2_ResultMaterialListModel:initList(info)
	local tempList = {}

	if info then
		for _, itemId in ipairs(info) do
			local mo = {}

			mo.itemId = itemId
			mo.type = Rouge2_OutsideEnum.CollectionType.Material

			table.insert(tempList, mo)
		end

		table.sort(tempList, Rouge2_ResultMaterialListModel.sortMaterial)
	end

	self:setList(tempList)
end

function Rouge2_ResultMaterialListModel.sortMaterial(a, b)
	local configA = Rouge2_OutSideConfig.instance:getMaterialConfig(a.itemId)
	local configB = Rouge2_OutSideConfig.instance:getMaterialConfig(b.itemId)

	if configA.rare ~= configB.rare then
		return configA.rare < configB.rare
	end

	return configA.id < configB.id
end

Rouge2_ResultMaterialListModel.instance = Rouge2_ResultMaterialListModel.New()

return Rouge2_ResultMaterialListModel
