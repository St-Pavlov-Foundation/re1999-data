-- chunkname: @modules/logic/character/utils/HeroRecoveryHelper.lua

module("modules.logic.character.utils.HeroRecoveryHelper", package.seeall)

local HeroRecoveryHelper = {}

function HeroRecoveryHelper.giveback‌ItemListByHeroId(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return
	end

	local consumeStrList = {}

	HeroRecoveryHelper._giveback‌UpLv(heroMo, consumeStrList)
	HeroRecoveryHelper._givebackTalent(heroMo, consumeStrList)
	HeroRecoveryHelper._givebackDestinyFacets(heroMo, consumeStrList)

	return HeroRecoveryHelper._consumeStrList2ItemDataList(consumeStrList, true)
end

function HeroRecoveryHelper.recoverItemListByHeroId(heroId, duplicateCount)
	local cfg = HeroConfig.instance:getHeroCO(heroId)

	if not cfg then
		return
	end

	if not duplicateCount then
		local heroMo = HeroModel.instance:getByHeroId(heroId)

		if not heroMo then
			return
		end

		duplicateCount = heroMo.duplicateCount
	end

	if not duplicateCount then
		return
	end

	local costStr
	local countVal = CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount)

	if duplicateCount >= countVal - 1 then
		costStr = cfg.duplicateItem2
	elseif duplicateCount >= 1 then
		costStr = cfg.duplicateItemSpecial
	end

	if string.nilorempty(costStr) then
		return
	end

	return HeroRecoveryHelper._consumeStrList2ItemDataList({
		costStr
	})
end

local function _replace_hero_newindex(t, key, value)
	local target = rawget(t, 1)

	if target then
		target[key] = value
	end
end

function HeroRecoveryHelper.mergeHeroMO(heroMO, mergeInfo)
	local mergHeroMO = RoomHelper.mergeCfg(heroMO, mergeInfo)
	local metatable = getmetatable(mergHeroMO)

	metatable.__newindex = _replace_hero_newindex

	return mergHeroMO, mergeInfo
end

function HeroRecoveryHelper.sortItemDataFunc(a, b)
	local tItemModel = ItemModel.instance
	local aCfg = tItemModel:getItemConfig(a.materilType, a.materilId)
	local bCfg = tItemModel:getItemConfig(b.materilType, b.materilId)
	local aRare = aCfg and aCfg.rare or 0
	local bRare = bCfg and bCfg.rare or 0

	if aRare ~= bRare then
		return bRare < aRare
	end

	local aQuatity = a.quatity or 0
	local bQuatity = b.quatity or 0

	if aQuatity ~= bQuatity then
		return bQuatity < aQuatity
	end

	local aId = a.materilId or 0
	local bId = b.materilId or 0

	if aId ~= bId then
		return bId < aId
	end
end

function HeroRecoveryHelper._consumeStrList2ItemDataList(consumeStrList, isConversion)
	local itemList = {}
	local itemDict = {}
	local itemType, itemId, quatity
	local tempIsConversion = isConversion == true
	local tHeroConfig = HeroConfig.instance

	for _, consumeStr in ipairs(consumeStrList) do
		local costArrList = GameUtil.splitString2(consumeStr, true)

		if costArrList then
			for i, costArr in ipairs(costArrList) do
				if costArr and #costArr >= 3 then
					itemType, itemId, quatity = costArr[1], costArr[2], costArr[3]

					if tempIsConversion then
						local converCfg = tHeroConfig:getRecyleConversionCo(itemId, itemType)

						if converCfg then
							itemId = converCfg.conversionId
							itemType = converCfg.conversionType
						end
					end

					if not itemDict[itemType] then
						itemDict[itemType] = {}
					end

					local item = itemDict[itemType][itemId]

					if not item then
						item = HeroRecoveryHelper.creteItemData(itemType, itemId, quatity)

						table.insert(itemList, item)

						itemDict[itemType][itemId] = item
					else
						item.quantity = item.quantity + quatity
					end
				end
			end
		end
	end

	return itemList
end

function HeroRecoveryHelper.creteItemData(itemType, itemId, quatity)
	return {
		materilType = itemType,
		materilId = itemId,
		quantity = quatity,
		itemId = itemId,
		itemType = itemType
	}
end

local NO_COST_UPLEVE_DIC = {
	true,
	[121] = true,
	[31] = true,
	[71] = true
}

function HeroRecoveryHelper._giveback‌UpLv(heroMo, consumeStrList)
	if heroMo.level > 1 then
		local rare = heroMo.config.rare
		local tSkillConfig = SkillConfig.instance

		for lv = 2, heroMo.level do
			local cfg = tSkillConfig:getcosumeCO(lv, rare)

			if cfg and NO_COST_UPLEVE_DIC[cfg.level] ~= true then
				table.insert(consumeStrList, cfg.cosume)
			end
		end
	end

	if heroMo.rank and heroMo.rank > 0 then
		for rank = 1, heroMo.rank do
			local cfg = SkillConfig.instance:getherorankCO(heroMo.heroId, rank)

			if cfg then
				table.insert(consumeStrList, cfg.consume)
			end
		end
	end
end

function HeroRecoveryHelper._givebackTalent(heroMo, consumeStrList)
	local talent = heroMo.talent
	local heroId = heroMo.heroId

	if talent and talent > 1 then
		local tSkillConfig = SkillConfig.instance

		for taLv = 2, talent do
			local cfg = tSkillConfig:gettalentCO(heroId, taLv)

			if cfg then
				table.insert(consumeStrList, cfg.consume)
			end
		end
	end

	local styleMoList = TalentStyleModel.instance:getStyleMoList(heroId)

	if styleMoList then
		TalentStyleModel.instance:refreshUnlockInfo(heroId)

		for _, styleMo in ipairs(styleMoList) do
			if styleMo._isUnlock then
				local consume = HeroResonanceConfig.instance:getTalentStyleUnlockConsume(heroId, styleMo._styleId)

				table.insert(consumeStrList, consume)
			end
		end
	end
end

function HeroRecoveryHelper._givebackDestinyFacets(heroMo, consumeStrList)
	local destinyStoneMo = heroMo.destinyStoneMo

	if not destinyStoneMo or not destinyStoneMo.unlockStoneIds then
		return
	end

	local unlockStoneIds = destinyStoneMo.unlockStoneIds

	for _, stoneId in ipairs(unlockStoneIds) do
		local stoneMo = destinyStoneMo:getStoneMo(stoneId)

		if stoneMo then
			local conusmeCfg = stoneMo.conusmeCo

			if conusmeCfg then
				table.insert(consumeStrList, conusmeCfg.consume)
			end
		end
	end

	local rank = destinyStoneMo.rank or 0
	local level = destinyStoneMo.level or 0
	local cosDic = CharacterDestinyConfig.instance:getDestinySlotCosByHeroId(heroMo.heroId)

	if cosDic then
		for _rank, cos1 in ipairs(cosDic) do
			if _rank < rank then
				for _, slotsCfg in ipairs(cos1) do
					table.insert(consumeStrList, slotsCfg.consume)
				end
			elseif _rank == rank and level > 0 then
				for i = 1, level do
					local slotsCfg = cos1[i]

					if slotsCfg then
						table.insert(consumeStrList, slotsCfg.consume)
					end
				end
			end
		end
	end
end

return HeroRecoveryHelper
