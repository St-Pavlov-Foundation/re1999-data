-- chunkname: @modules/logic/tips/model/MaterialHeroRecoveryTipListModel.lua

module("modules.logic.tips.model.MaterialHeroRecoveryTipListModel", package.seeall)

local MaterialHeroRecoveryTipListModel = class("MaterialHeroRecoveryTipListModel", ListScrollModel)

function MaterialHeroRecoveryTipListModel:setData(moList)
	self:setList(moList)
end

MaterialHeroRecoveryTipListModel.instance = MaterialHeroRecoveryTipListModel.New()

return MaterialHeroRecoveryTipListModel
