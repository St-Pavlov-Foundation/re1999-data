-- chunkname: @modules/logic/decorate/model/DecorateModel.lua

module("modules.logic.decorate.model.DecorateModel", package.seeall)

local DecorateModel = class("DecorateModel", BaseModel)

function DecorateModel:getItemIcon(itemConfig, goodsId)
	if not itemConfig then
		return
	end

	if itemConfig.subType == ItemEnum.SubType.PlayerBg then
		return ResUrl.getDecorateStoreBuyBannerFullPath(itemConfig.id)
	end

	local itemDecorateCo, classify = self:getItemDecorateCo(itemConfig)

	if itemDecorateCo then
		if itemConfig.subType == ItemEnum.SubType.MainSceneSkin then
			return ResUrl.getMainSceneSwitchIcon(itemDecorateCo.previewIcon)
		end

		if itemConfig.subType == ItemEnum.SubType.MainUISkin then
			if classify == MainSwitchClassifyEnum.Classify.UI then
				return ResUrl.getMainSceneSwitchLangIcon(itemDecorateCo.previewIcon)
			end

			return ResUrl.getMainSceneSwitchIcon(itemDecorateCo.previewIcon)
		end

		if itemConfig.subType == ItemEnum.SubType.FightCard or itemConfig.subType == ItemEnum.SubType.FightFloatType then
			return ResUrl.getMainSceneSwitchIcon(itemDecorateCo.previewImage)
		end
	end

	itemDecorateCo = DecorateStoreConfig.instance:getDecorateConfig(goodsId)

	if itemDecorateCo then
		return ResUrl.getDecorateStoreImg(itemDecorateCo.biglmg)
	end
end

function DecorateModel:getItemDecorateCo(itemConfig)
	if not itemConfig then
		return
	end

	if itemConfig.subType == ItemEnum.SubType.MainSceneSkin then
		return MainSceneSwitchConfig.instance:getConfigByItemId(itemConfig.id)
	end

	if itemConfig.subType == ItemEnum.SubType.MainUISkin then
		local classify = MainSwitchClassifyEnum.Classify.UI
		local uiCo = MainUISwitchConfig.instance:getUISwitchCoByItemId(itemConfig.id)

		if not uiCo then
			uiCo = ClickUISwitchConfig.instance:getClickUICoByItemId(itemConfig.id)
			classify = MainSwitchClassifyEnum.Classify.Click
		end

		return uiCo, classify
	end

	if itemConfig.subType == ItemEnum.SubType.FightCard or itemConfig.subType == ItemEnum.SubType.FightFloatType then
		return FightUISwitchConfig.instance:getStyleCoByItemId(itemConfig.id)
	end
end

function DecorateModel:getItemSource(itemConfig)
	if not itemConfig then
		return
	end

	if itemConfig.subType == ItemEnum.SubType.MainSceneSkin then
		return MainSceneSwitchConfig.instance:getItemSource(itemConfig.id)
	end

	if itemConfig.subType == ItemEnum.SubType.MainUISkin then
		local uiCo = MainUISwitchConfig.instance:getUISwitchCoByItemId(itemConfig.id)

		if uiCo then
			return MainUISwitchConfig.instance:getItemSource(itemConfig.id)
		else
			return ClickUISwitchConfig.instance:getItemSource(itemConfig.id)
		end
	end

	if itemConfig.subType == ItemEnum.SubType.FightCard or itemConfig.subType == ItemEnum.SubType.FightFloatType then
		return FightUISwitchConfig.instance:getItemSource(itemConfig.id)
	end
end

function DecorateModel:isCurMaterial(itemConfig)
	if not itemConfig then
		return
	end

	if itemConfig.subType == ItemEnum.SubType.PlayerBg then
		return StoreModel.instance:isStoreDecorateGoodsValid(itemConfig.id)
	end

	local status = self:getItemStatus(itemConfig)

	if status == DecorateEnum.SceneStutas.Lock then
		return false
	end

	return true
end

function DecorateModel:getItemStatus(itemConfig)
	local config = self:getItemDecorateCo(itemConfig)

	if not config then
		return DecorateEnum.SceneStutas.Lock
	end

	if config.defaultUnlock == 1 then
		return DecorateEnum.SceneStutas.Unlock
	end

	local num = ItemModel.instance:getItemCount(itemConfig.id)

	if num > 0 then
		return DecorateEnum.SceneStutas.Unlock
	end

	if self:canJump(itemConfig) then
		return DecorateEnum.SceneStutas.LockCanGet
	end

	return DecorateEnum.SceneStutas.Lock
end

function DecorateModel:canJump(itemConfig)
	if not itemConfig then
		return
	end

	local sourceTables = self:getItemSource(itemConfig)

	if not sourceTables then
		return
	end

	for i, sourceTable in ipairs(sourceTables) do
		local cantJumpTips, toastParamList = self:getCantJump(sourceTable)

		if not cantJumpTips then
			return true
		end
	end

	return false
end

function DecorateModel:getCantJump(sourceTable)
	if not sourceTable then
		return
	end

	local open = JumpController.instance:isJumpOpen(sourceTable.sourceId)
	local jumpConfig = JumpConfig.instance:getJumpConfig(sourceTable.sourceId)

	if open then
		return JumpController.instance:cantJump(jumpConfig.param)
	end

	return OpenHelper.getToastIdAndParam(jumpConfig.openId)
end

function DecorateModel:collectSource(itemId)
	local itemConfig = lua_item.configDict[itemId]

	if not itemConfig then
		return
	end

	local sourcesStr = itemConfig.sources
	local sourceTables = {}

	if not string.nilorempty(sourcesStr) then
		local sources = string.split(sourcesStr, "|")

		for i, source in ipairs(sources) do
			local sourceParam = string.splitToNumber(source, "#")
			local sourceTable = {}

			sourceTable.sourceId = sourceParam[1]
			sourceTable.probability = sourceParam[2]
			sourceTable.episodeId = JumpConfig.instance:getJumpEpisodeId(sourceTable.sourceId)

			if sourceTable.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(sourceTable.episodeId) then
				table.insert(sourceTables, sourceTable)
			end
		end
	end

	return sourceTables
end

function DecorateModel:getGoodsItemType(storeId)
	if storeId == StoreEnum.StoreId.RoomStore or storeId == StoreEnum.StoreId.NewRoomStore or storeId == StoreEnum.StoreId.OldRoomStore then
		return
	end
end

DecorateModel.instance = DecorateModel.New()

return DecorateModel
