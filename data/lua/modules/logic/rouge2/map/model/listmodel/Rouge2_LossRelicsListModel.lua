-- chunkname: @modules/logic/rouge2/map/model/listmodel/Rouge2_LossRelicsListModel.lua

module("modules.logic.rouge2.map.model.listmodel.Rouge2_LossRelicsListModel", package.seeall)

local Rouge2_LossRelicsListModel = class("Rouge2_LossRelicsListModel", Rouge2_LossItemListModelBase)

function Rouge2_LossRelicsListModel:initSort()
	Rouge2_ItemListModelBase.super.initSort(self)
	self:addSortType(1, Rouge2_LossRelicsListModel._sortBySelectStatus)
end

function Rouge2_LossRelicsListModel._sortBySelectStatus(aItem, bItem)
	local aSelect = Rouge2_LossRelicsListModel.instance:isSelect(aItem)
	local bSelect = Rouge2_LossRelicsListModel.instance:isSelect(bItem)

	if aSelect ~= bSelect then
		return aSelect
	end
end

Rouge2_LossRelicsListModel.instance = Rouge2_LossRelicsListModel.New()

return Rouge2_LossRelicsListModel
