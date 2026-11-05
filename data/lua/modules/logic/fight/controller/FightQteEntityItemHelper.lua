-- chunkname: @modules/logic/fight/controller/FightQteEntityItemHelper.lua

module("modules.logic.fight.controller.FightQteEntityItemHelper", package.seeall)

local FightQteEntityItemHelper = _M
local DefaultPath = "ui/viewres/fight/fightbreakthroughheroitem_base.prefab"
local EntityItemPrefab = {
	[3159] = "ui/viewres/fight/fightbreakthroughheroitem_3.prefab",
	[3066] = "ui/viewres/fight/fightbreakthroughheroitem_1.prefab",
	[3155] = "ui/viewres/fight/fightbreakthroughheroitem_2.prefab"
}
local EntityItemCls = {
	[3155] = FightQteEntityItemHNJ,
	[3066] = FightQteEntityItem37,
	[3159] = FightQteEntityItemPST
}

function FightQteEntityItemHelper.createEntityItem(entityMo, useType)
	if not entityMo then
		return
	end

	local heroId = entityMo.modelId
	local entityItemCls = EntityItemCls[heroId]

	entityItemCls = entityItemCls or FightQteEntityItemBase

	local entityItem = entityItemCls.New()

	entityItem:init(entityMo, useType)

	local prefabPath = EntityItemPrefab[heroId]

	if string.nilorempty(prefabPath) then
		entityItem:setPrefabPath(DefaultPath)
	else
		entityItem:setPrefabPath(prefabPath)
	end

	return entityItem
end

local CostType2Image = {
	[CharacterEnum.CareerType.Yan] = "fight_breakthrough_point_1_1",
	[CharacterEnum.CareerType.Xing] = "fight_breakthrough_point_2_1"
}

function FightQteEntityItemHelper.getCostTypeImage(costType)
	return CostType2Image[costType]
end

local SmallCostType2Image = {
	[CharacterEnum.CareerType.Yan] = "fight_breakthrough_point_1",
	[CharacterEnum.CareerType.Xing] = "fight_breakthrough_point_2"
}

function FightQteEntityItemHelper.getSmallCostTypeImage(costType)
	return SmallCostType2Image[costType]
end

function FightQteEntityItemHelper.getBuffActIdLayer(buffActId, entityMo)
	if not buffActId then
		return -1
	end

	if not entityMo then
		return -1
	end

	local buffDict = entityMo:getBuffDic()

	for _, buffMO in pairs(buffDict) do
		local buffId = buffMO.buffId
		local featuresSplit = entityMo:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				if oneFeature[1] == buffActId then
					return buffMO.layer, oneFeature
				end
			end
		end
	end

	return -1
end

return FightQteEntityItemHelper
