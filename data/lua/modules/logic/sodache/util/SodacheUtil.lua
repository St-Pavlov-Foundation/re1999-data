-- chunkname: @modules/logic/sodache/util/SodacheUtil.lua

module("modules.logic.sodache.util.SodacheUtil", package.seeall)

local SodacheUtil = class("SodacheUtil")

function SodacheUtil.isInside()
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return false
	end

	return outSideMo.inside
end

function SodacheUtil.getAttr(attrId)
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return 0
	end

	return outSideMo.attrContainer:getAttr(attrId)
end

function SodacheUtil.getCurrencyName()
	local co = lua_sodache_item.configDict[SodacheEnum.CurrencyId.Coin]

	if not co then
		return ""
	end

	return co.name
end

function SodacheUtil.getCurrencyIcon()
	local co = lua_sodache_item.configDict[SodacheEnum.CurrencyId.Coin]

	if not co then
		return ""
	end

	return co.icon
end

function SodacheUtil.getItemCount(itemId, bagType)
	bagType = bagType or SodacheEnum.BagType.Outside

	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return 0
	end

	local bag = outSideMo:getBag(bagType)

	if not bag then
		return 0
	end

	return bag:getItemQuantity(itemId)
end

function SodacheUtil.getItemsByCardType(cardType, bagType)
	bagType = bagType or SodacheEnum.BagType.Outside

	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return {}
	end

	local bag = outSideMo:getBag(bagType)

	if not bag then
		return {}
	end

	return bag:getItemsByCardType(cardType)
end

function SodacheUtil.isOpen(openId)
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return false
	end

	return tabletool.indexOf(outSideMo.functionBox.functionIds, openId)
end

function SodacheUtil.setInside(isInside)
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if outSideMo then
		if outSideMo.inside == isInside then
			return
		end

		outSideMo.inside = isInside
	else
		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.InsideStatusChange, isInside)

	if isInside then
		SodacheController.instance:realEnterInsideScene()
	else
		SodacheController.instance:enterScene()
	end

	SodacheUtil.closeViews(not isInside)
end

local outsideViews = {
	ViewName.SodacheMainView,
	ViewName.SodacheMapSelectView,
	ViewName.SodacheMapDetailView,
	ViewName.SodacheCardSelectView
}
local insideViews = {
	ViewName.SodacheMapView
}

function SodacheUtil.closeViews(isInside)
	local views = isInside and insideViews or outsideViews

	for k, v in pairs(views) do
		ViewMgr.instance:closeView(v)
	end
end

function SodacheUtil.checkUnlockCondition(condition)
	local params = string.split(condition, "#")

	if params[1] == "haveItem" then
		local costs = string.splitToNumber(params[2], ":")
		local itemCnt = SodacheUtil.getItemCount(costs[1])

		return itemCnt, costs[2], costs[1]
	elseif params[1] == "level" then
		local needLvl = tonumber(params[2])
		local outsideMo = SodacheModel.instance:getOutsideMo()
		local curLvl = outsideMo.prop.level

		return curLvl, needLvl
	elseif params[1] == "buildingLevel" then
		local needLvl = tonumber(params[3])
		local outsideMo = SodacheModel.instance:getOutsideMo()
		local buildingMo = outsideMo.buildingBox:getBuildingMo(tonumber(params[2]))
		local curLvl = buildingMo.level

		return curLvl, needLvl
	end
end

function SodacheUtil.compareNum(num, mode, val)
	if mode == 1 then
		return val <= num
	elseif mode == 2 then
		return num <= val
	elseif mode == 3 then
		return num == val
	end
end

function SodacheUtil.getRelicAttrs(relicId, level)
	local strs = {}
	local configs = lua_sodache_upgrade.configDict[relicId]

	for _, config in ipairs(configs) do
		if level >= config.level then
			strs[#strs + 1] = config.globalAttri
		end
	end

	return strs
end

function SodacheUtil.getGlobalAttrMap(globalAttr, attrMap)
	attrMap = attrMap or {}

	local params = GameUtil.splitString2(globalAttr, true)

	if params then
		for _, param in ipairs(params) do
			local id = param[1]
			local value = param[2]

			if attrMap[id] then
				attrMap[id] = attrMap[id] + value
			else
				attrMap[id] = value
			end
		end
	end

	return attrMap
end

function SodacheUtil.getBuildingResUrl(name)
	return string.format("modules/sodache/scene/prefab/%s.prefab", name)
end

function SodacheUtil.showToast(msg)
	if not ViewMgr.instance:isOpen(ViewName.SodacheToastView) then
		table.insert(SodacheModel.instance.toastList, msg)
		ViewMgr.instance:openView(ViewName.SodacheToastView)
	elseif ViewMgr.instance:isOpening(ViewName.SodacheToastView) then
		table.insert(SodacheModel.instance.toastList, msg)
	else
		SodacheController.instance:dispatchEvent(SodacheEvent.ShowToast, msg)
	end
end

function SodacheUtil.showCardToast(data)
	if not ViewMgr.instance:isOpen(ViewName.SodacheCardToastView) then
		table.insert(SodacheModel.instance.cardToastList, data)
		ViewMgr.instance:openView(ViewName.SodacheCardToastView)
	elseif ViewMgr.instance:isOpening(ViewName.SodacheCardToastView) then
		table.insert(SodacheModel.instance.cardToastList, data)
	else
		SodacheController.instance:dispatchEvent(SodacheEvent.ShowCardToast, data)
	end
end

function SodacheUtil.checkOneKeyUpRelic()
	local canUp = false
	local outsideMo = SodacheModel.instance:getOutsideMo()
	local relics = outsideMo.relicBox.relics

	for i = #relics, 1, -1 do
		local mo = relics[i]

		if mo.level ~= mo.maxLevel then
			local nextCfg = lua_sodache_upgrade.configDict[mo.id][mo.level + 1]

			if nextCfg then
				local params = GameUtil.splitString2(nextCfg.cost, true, "&", ":")
				local needCnt = params[1][2]
				local relicCnt = SodacheUtil.getItemCount(mo.id)

				if needCnt <= relicCnt then
					if params[2] then
						local coinCnt = SodacheUtil.getItemCount(SodacheEnum.CurrencyId.Coin)

						if coinCnt >= params[2][2] then
							canUp = true

							break
						end
					else
						canUp = true

						break
					end
				end
			end
		end
	end

	return canUp
end

return SodacheUtil
