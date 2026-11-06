-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/rpc/ArcadeSurvivorRpc.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.rpc.ArcadeSurvivorRpc", package.seeall)

local ArcadeSurvivorRpc = class("ArcadeSurvivorRpc", BaseRpc)

function ArcadeSurvivorRpc:sendArcadeSurvivorGetOutsideInfoRequest(callback, callbackObj)
	local req = ArcadeSurvivorModule_pb.ArcadeSurvivorGetOutsideInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorGetOutsideInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	ArcadeSurvivorOutSideModel.instance:refreshInfo(info)
end

function ArcadeSurvivorRpc:sendArcadeSurvivorRoleMoveRequest(x, y, callback, callbackObj)
	if self._saveHeroGridX == x and self._saveHeroGridY == y then
		return
	end

	self._saveHeroGridX = x
	self._saveHeroGridY = y

	local req = ArcadeSurvivorModule_pb.ArcadeSurvivorRoleMoveRequest()

	req.x = x
	req.y = y

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorRoleMoveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ArcadeSurvivorRpc:sendArcadeSurvivorSwitchCharacterRequest(characterId, callback, callbackObj)
	local req = ArcadeSurvivorModule_pb.ArcadeSurvivorSwitchCharacterRequest()

	req.characterId = characterId

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorSwitchCharacterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local characterId = msg.characterId

	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnEquipHero, characterId)
end

function ArcadeSurvivorRpc:sendArcadeSurvivorTalentUpgradeRequest(talentId, level, callback, callbackObj)
	local req = ArcadeSurvivorModule_pb.ArcadeSurvivorTalentUpgradeRequest()

	req.talentId = talentId
	req.level = level

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorTalentUpgradeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local talentId = msg.talentId
	local level = msg.level

	ArcadeSurvivorStatHelper.instance:sendTalentUpgrade(talentId, level)
	ArcadeSurvivorHeroModel.instance:setTalentLevel(talentId, level)
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.UpLevelTalent, talentId, level)
end

function ArcadeSurvivorRpc:sendArcadeSurvivorGainRewardRequest(rewardId, callback, callbackObj)
	local req = ArcadeSurvivorModule_pb.ArcadeSurvivorGainRewardRequest()

	req.rewardId = rewardId or 0

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorGainRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ArcadeSurvivorOutSideModel.instance:onFinishReward()
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnGainReward)
end

function ArcadeSurvivorRpc:sendArcadeSurvivorClearNewBookRequest(type, ids, callback, callbackObj)
	local req = ArcadeSurvivorModule_pb.ArcadeSurvivorClearNewBookRequest()

	req.type = type

	for _, id in ipairs(ids) do
		req.ids:append(id)
	end

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorClearNewBookReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local type = msg.type
	local ids = msg.ids
	local idDict = {}

	for _, id in ipairs(ids) do
		idDict[id] = true
	end

	local moList = ArcadeSurvivorHandBookModel.instance:getMOListByType(type)

	if moList then
		for _, mo in ipairs(moList) do
			local id = mo:getId()

			if idDict[id] then
				mo:setNew()
			end
		end
	end
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorCurrencyChangePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ArcadeSurvivorOutSideModel.instance:updateCurrencyCount(msg.currency)
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnOutsideCurrencyChangePush)
end

function ArcadeSurvivorRpc:_fillPropData(prop, data)
	if not data then
		return
	end

	prop.difficulty = data.difficulty
	prop.stageIndex = data.stageIndex
	prop.LevelIndex = data.LevelIndex
	prop.round = data.round

	for _, customData in ipairs(data.customMap) do
		local mapEntry = prop.customMap:add()

		mapEntry.key = customData.key
		mapEntry.val = customData.val
	end
end

function ArcadeSurvivorRpc:_fillExtendData(extendInfo, data)
	if not data then
		return
	end

	local booksData = data.addedBook and data.addedBook.books

	if booksData then
		for _, bookData in ipairs(booksData) do
			local book = extendInfo.addedBook.books:add()

			book.type = bookData.type

			for _, eleId in ipairs(bookData.eleId) do
				book.eleId:append(eleId)
			end
		end
	end

	local unlockRolesData = data.unlockRoleIds

	if unlockRolesData then
		for _, roleId in ipairs(unlockRolesData) do
			extendInfo.unlockRoleIds:append(roleId)
		end
	end

	local unlockDifficultyData = data.unlockDifficultyIds

	if unlockDifficultyData then
		for _, difficultyId in ipairs(unlockDifficultyData) do
			extendInfo.unlockDifficultyIds:append(difficultyId)
		end
	end

	local currencyData = data.currency

	if currencyData then
		for _, currencyInfo in ipairs(currencyData) do
			local currency = extendInfo.currency:add()

			currency.id = currencyInfo.id
			currency.count = currencyInfo.count
		end
	end
end

function ArcadeSurvivorRpc:_fillPlayerData(player, data)
	if not data then
		return
	end

	player.id = data.id
end

function ArcadeSurvivorRpc:_fillAttrData(attrContainer, data)
	if data and data.attrValues then
		for _, attrData in ipairs(data.attrValues) do
			local attr = attrContainer.attrValues:add()

			attr.id = attrData.id
			attr.base = attrData.base
			attr.rate = attrData.rate
			attr.increase = attrData.increase
		end
	end
end

function ArcadeSurvivorRpc:_fillSkillData(skillContainer, data)
	if data and data.skills then
		for _, skillData in ipairs(data.skills) do
			local skill = skillContainer.skills:add()

			skill.id = skillData.id

			if skillData.customMap then
				for _, mapData in ipairs(skillData.customMap) do
					local mapEntry = skill.customMap:add()

					mapEntry.key = mapData.key
					mapEntry.val = mapData.val
				end
			end
		end
	end
end

function ArcadeSurvivorRpc:_fillCollectionData(collectionContainer, data)
	if data and data.collections then
		for _, collectionData in ipairs(data.collections) do
			local collection = collectionContainer.collections:add()

			collection.id = collectionData.id
			collection.count = collectionData.count
		end
	end
end

function ArcadeSurvivorRpc:sendArcadeSurvivorGetInsideInfoRequest(callback, callbackObj)
	local req = ArcadeSurvivorModule_pb.ArcadeSurvivorGetInsideInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorGetInsideInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ArcadeSurvivorRpc:sendArcadeSurvivorSaveGameRequest(data, callback, callbackObj)
	local req = ArcadeSurvivorModule_pb.ArcadeSurvivorSaveGameRequest()

	self:_fillPropData(req.info.prop, data.prop)
	self:_fillExtendData(req.info.extendInfo, data.extendInfo)
	self:_fillPlayerData(req.info.player, data.player)
	self:_fillAttrData(req.info.attrContainer, data.attrContainer)
	self:_fillSkillData(req.info.skillContainer, data.skillContainer)
	self:_fillCollectionData(req.info.collectionContainer, data.collectionContainer)
	self:sendMsg(req, callback, callbackObj)
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorSaveGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ArcadeSurvivorRpc:sendArcadeSurvivorSettleGameRequest(type, data, callback, callbackObj)
	local req = ArcadeSurvivorModule_pb.ArcadeSurvivorSettleGameRequest()

	req.type = type

	self:_fillPropData(req.info.prop, data.prop)
	self:_fillExtendData(req.info.extendInfo, data.extendInfo)
	self:_fillPlayerData(req.info.player, data.player)
	self:_fillAttrData(req.info.attrContainer, data.attrContainer)
	self:_fillSkillData(req.info.skillContainer, data.skillContainer)
	self:_fillCollectionData(req.info.collectionContainer, data.collectionContainer)
	self:sendMsg(req, callback, callbackObj)
end

function ArcadeSurvivorRpc:onReceiveArcadeSurvivorSettleGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

ArcadeSurvivorRpc.instance = ArcadeSurvivorRpc.New()

return ArcadeSurvivorRpc
