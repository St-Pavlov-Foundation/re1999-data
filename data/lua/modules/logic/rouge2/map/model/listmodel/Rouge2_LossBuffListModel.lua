-- chunkname: @modules/logic/rouge2/map/model/listmodel/Rouge2_LossBuffListModel.lua

module("modules.logic.rouge2.map.model.listmodel.Rouge2_LossBuffListModel", package.seeall)

local Rouge2_LossBuffListModel = class("Rouge2_LossBuffListModel", Rouge2_LossItemListModelBase)

function Rouge2_LossBuffListModel:initSort()
	Rouge2_ItemListModelBase.super.initSort(self)
	self:addSortType(1, Rouge2_LossBuffListModel._sortBySelectStatus)
end

function Rouge2_LossBuffListModel._sortBySelectStatus(aItem, bItem)
	local aSelect = Rouge2_LossBuffListModel.instance:isSelect(aItem)
	local bSelect = Rouge2_LossBuffListModel.instance:isSelect(bItem)

	if aSelect ~= bSelect then
		return aSelect
	end
end

Rouge2_LossBuffListModel.instance = Rouge2_LossBuffListModel.New()

return Rouge2_LossBuffListModel
