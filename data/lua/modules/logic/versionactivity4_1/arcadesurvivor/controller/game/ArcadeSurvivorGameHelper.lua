-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/ArcadeSurvivorGameHelper.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.ArcadeSurvivorGameHelper", package.seeall)

local ArcadeSurvivorGameHelper = _M

function ArcadeSurvivorGameHelper.getArcadeSurvivorButton(go, childPath)
	return gohelper.findChildButtonWithAudio(go, childPath, AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
end

function ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(go, childPath)
	return gohelper.findChildClickWithAudio(go, childPath, AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
end

function ArcadeSurvivorGameHelper.getResultViewInfo(isWin, isReset, serverInfo)
	local result = {
		score = 0,
		bookAddScore = 0,
		hasUnlockCharacter = false,
		isWin = isWin,
		isReset = isReset,
		resultStatisticsDict = {},
		rewardDataList = {},
		attrDict = {},
		collectionDataList = {}
	}

	if serverInfo then
		ArcadeSurvivorGameHelper._getResultViewInfoFromServer(serverInfo, result)
	else
		ArcadeSurvivorGameHelper._getResultViewInfoFromGame(result)
	end

	return result
end

function ArcadeSurvivorGameHelper._getResultViewInfoFromServer(serverInfo, refResult)
	if not serverInfo then
		return
	end

	refResult.characterId = serverInfo.player and serverInfo.player.id

	local propInfo = serverInfo.prop
	local customMap = propInfo and propInfo.customMap

	if customMap then
		for _, mapEntry in ipairs(customMap) do
			local key = mapEntry.key
			local val = mapEntry.val

			if ArcadeSurvivorGameEnum.CustomSaveResultStatisticsKeyDict[key] then
				refResult.resultStatisticsDict[key] = tonumber(val)
			elseif key == ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalScore then
				refResult.score = ArcadeSurvivorGameHelper._getAvgScoreFromSave(val)
			end
		end
	end

	local attrInfo = serverInfo.attrContainer

	if attrInfo and attrInfo.attrValues then
		for _, attrValue in ipairs(attrInfo.attrValues) do
			local base = attrValue.base
			local rate = 1 + attrValue.rate / ArcadeSurvivorEnum.Const.PermillageBase
			local increase = attrValue.increase
			local value = math.floor(base * rate + increase)

			refResult.attrDict[attrValue.id] = value
		end
	end

	local extendInfo = serverInfo.extendInfo

	if extendInfo and extendInfo.currency then
		local difficultyId = propInfo and propInfo.difficulty

		for _, currency in ipairs(extendInfo.currency) do
			local count = tonumber(currency.count) or 0
			local rewardCount = ArcadeSurvivorGameHelper._getSettleRewardCount(difficultyId, currency.id, count)

			if rewardCount > 0 then
				refResult.rewardDataList[#refResult.rewardDataList + 1] = {
					id = currency.id,
					count = rewardCount
				}
			end
		end
	end

	local collectionInfo = serverInfo.collectionContainer

	if collectionInfo and collectionInfo.collections then
		local collectionIndexDict = {}

		for _, collection in ipairs(collectionInfo.collections) do
			local id = collection.id
			local collectionCount = collection.count or 0
			local index = collectionIndexDict[id]

			if not index then
				index = #refResult.collectionDataList + 1
				collectionIndexDict[id] = index
				refResult.collectionDataList[index] = {
					id = id,
					count = collectionCount
				}
			else
				refResult.collectionDataList[index].count = refResult.collectionDataList[index].count + collectionCount
			end
		end
	end
end

function ArcadeSurvivorGameHelper._getAvgScoreFromSave(strVal)
	if string.nilorempty(strVal) then
		return 0
	end

	local scoreList

	if string.find(strVal, "#", 1, true) then
		scoreList = string.splitToNumber(strVal, "#")
	else
		scoreList = {
			tonumber(strVal) or 0
		}
	end

	local count = #scoreList

	if count <= 0 then
		return 0
	end

	local sum = 0

	for _, score in ipairs(scoreList) do
		sum = sum + score
	end

	return math.floor(sum / count)
end

function ArcadeSurvivorGameHelper._getResultViewInfoFromGame(refResult)
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	refResult.characterId = characterMO and characterMO:getId()

	for saveInfoKey in pairs(ArcadeSurvivorGameEnum.CustomSaveResultStatisticsKeyDict) do
		refResult.resultStatisticsDict[saveInfoKey] = ArcadeSurvivorGameModel.instance:getResultStatistics(saveInfoKey)
	end

	refResult.score = ArcadeSurvivorGameModel.instance:getAvgScore()

	if not characterMO then
		return
	end

	for _, attrId in pairs(ArcadeSurvivorEnum.Attribute) do
		if attrId == ArcadeSurvivorEnum.Attribute.hp then
			refResult.attrDict[attrId] = characterMO:getHp()
		else
			refResult.attrDict[attrId] = characterMO:getAttrValue(attrId)
		end
	end

	local difficultyId = ArcadeSurvivorGameModel.instance:getDifficulty()

	for _, currencyId in ipairs(ArcadeSurvivorEnum.SettleCurrency) do
		local count = ArcadeSurvivorGameModel.instance:getCurrencyCount(currencyId)
		local rewardCount = ArcadeSurvivorGameHelper._getSettleRewardCount(difficultyId, currencyId, count)

		if rewardCount > 0 then
			refResult.rewardDataList[#refResult.rewardDataList + 1] = {
				id = currencyId,
				count = rewardCount
			}
		end
	end

	for _, collectionId in ipairs(characterMO:getCollectionIdList()) do
		refResult.collectionDataList[#refResult.collectionDataList + 1] = {
			id = collectionId,
			count = characterMO:getCollectionCount(collectionId)
		}
	end
end

function ArcadeSurvivorGameHelper._getSettleRewardCount(difficultyId, currencyId, count)
	local factor = 0

	if currencyId == ArcadeSurvivorEnum.Currency.Diamond then
		factor = ArcadeSurvivorConfig.instance:getDifficultyDiamondMul(difficultyId)
	elseif currencyId == ArcadeSurvivorEnum.Currency.Cassette then
		factor = ArcadeSurvivorConfig.instance:getDifficultyCassetteMul(difficultyId)
	end

	return math.floor(count * (1 + factor / ArcadeSurvivorEnum.Const.PermillageBase))
end

function ArcadeSurvivorGameHelper.getServerInstructionData(isWin, strShopStatus, openEventSelect)
	local info = {
		prop = ArcadeSurvivorGameHelper.getServerPropInfo(strShopStatus, openEventSelect),
		extendInfo = ArcadeSurvivorGameHelper.getServerExtendInfo(isWin),
		player = ArcadeSurvivorGameHelper.getServerPlayerInfo(),
		attrContainer = ArcadeSurvivorGameHelper.getServerAttrContainer(),
		skillContainer = ArcadeSurvivorGameHelper.getServerSkillContainer(),
		collectionContainer = ArcadeSurvivorGameHelper.getServerCollectionContainer()
	}

	return info
end

function ArcadeSurvivorGameHelper.getServerPropInfo(strShopStatus, openEventSelect)
	local enableVal = ArcadeSurvivorGameEnum.Const.CustomSaveEnableVal
	local disableVal = ArcadeSurvivorGameEnum.Const.CustomSaveDisableVal
	local info = {
		difficulty = ArcadeSurvivorGameModel.instance:getDifficulty(),
		stageIndex = ArcadeSurvivorGameModel.instance:getCurStageIndex(),
		LevelIndex = ArcadeSurvivorGameModel.instance:getCurLevelIndex(),
		round = ArcadeSurvivorGameModel.instance:getCurRound(),
		customMap = {
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.ShopStatus,
				val = strShopStatus or disableVal
			},
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.OpenEventSelect,
				val = openEventSelect and enableVal or disableVal
			},
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.SelectEvent,
				val = table.concat(ArcadeSurvivorGameModel.instance:getEventIdList(), "#")
			},
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.RuleStates,
				val = ArcadeSurvivorGameModel.instance:getRuleSaveStateJson()
			},
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalScore,
				val = ArcadeSurvivorGameModel.instance:getLevelScoreStr()
			},
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.ShopRefreshCount,
				val = tostring(ArcadeSurvivorGameModel.instance:getShopRefreshBaseCount())
			},
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.LockGoodsDict,
				val = ArcadeSurvivorGameModel.instance:getLockGoodsSaveStr()
			},
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.PassLevelCount,
				val = tostring(ArcadeSurvivorGameModel.instance:getResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.PassLevelCount))
			},
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.KillMonsterNum,
				val = tostring(ArcadeSurvivorGameModel.instance:getResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.KillMonsterNum))
			},
			{
				key = ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalGainCoin,
				val = tostring(ArcadeSurvivorGameModel.instance:getResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalGainCoin))
			}
		}
	}

	return info
end

function ArcadeSurvivorGameHelper.getServerExtendInfo(isWin)
	local info = {
		addedBook = {},
		unlockRoleIds = {},
		unlockDifficultyIds = {},
		currency = {}
	}
	local books = {}
	local unlockHandBookDict = ArcadeSurvivorGameModel.instance:getUnlockHandBookDict()

	if unlockHandBookDict then
		for type, typeDict in pairs(unlockHandBookDict) do
			local eleId = {}

			for id, _ in pairs(typeDict) do
				eleId[#eleId + 1] = id
			end

			local book = {
				type = type,
				eleId = eleId
			}

			books[#books + 1] = book
		end
	end

	info.addedBook.books = books

	local unlockCharacterDict = ArcadeSurvivorGameModel.instance:getUnlockCharacterDict()

	if unlockCharacterDict then
		for characterId, _ in pairs(unlockCharacterDict) do
			info.unlockRoleIds[#info.unlockRoleIds + 1] = characterId
		end
	end

	if isWin then
		local difficulty = ArcadeSurvivorGameModel.instance:getDifficulty()
		local nextDifficulty = difficulty + 1
		local cfg = ArcadeSurvivorConfig.instance:getDifficultyCfg(nextDifficulty)

		if cfg then
			info.unlockDifficultyIds[#info.unlockDifficultyIds + 1] = nextDifficulty
		end
	end

	for _, currencyId in pairs(ArcadeSurvivorEnum.Currency) do
		local currencyCount = ArcadeSurvivorGameModel.instance:getCurrencyCount(currencyId)

		if currencyCount and currencyCount > 0 then
			local currencyInfo = {
				id = currencyId,
				count = currencyCount
			}

			info.currency[#info.currency + 1] = currencyInfo
		end
	end

	return info
end

function ArcadeSurvivorGameHelper.getServerPlayerInfo()
	local info = {}
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if characterMO then
		info.id = characterMO:getId()
	end

	return info
end

function ArcadeSurvivorGameHelper.getServerAttrContainer()
	local info = {
		attrValues = {}
	}
	local attrList
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if characterMO then
		local hpAttr = {
			rate = 0,
			increase = 0,
			id = ArcadeSurvivorEnum.Attribute.hp,
			base = characterMO:getHp()
		}

		info.attrValues[#info.attrValues + 1] = hpAttr

		local attrSet = characterMO and characterMO:getAttrSet()

		attrList = attrSet and attrSet:getAttrList()
	end

	if attrList then
		for _, attrMO in ipairs(attrList) do
			info.attrValues[#info.attrValues + 1] = {
				id = attrMO:getId(),
				base = attrMO:getBase(),
				rate = attrMO:getRate(),
				increase = attrMO:getIncrease()
			}
		end
	end

	return info
end

function ArcadeSurvivorGameHelper.getServerSkillContainer()
	local info = {
		skills = {}
	}
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local skillSet = characterMO and characterMO:getSkillSet()
	local skillSourceCountMapList = skillSet and skillSet:getSkillSourceCountMapListInSet()

	if skillSourceCountMapList then
		for _, skillSourceCount in ipairs(skillSourceCountMapList) do
			local skillInfo = {
				id = skillSourceCount.skillId,
				customMap = ArcadeSurvivorGameHelper._getSkillCustomMap(skillSourceCount.sourceCountMap)
			}

			info.skills[#info.skills + 1] = skillInfo
		end
	end

	return info
end

function ArcadeSurvivorGameHelper._getSkillCustomMap(sourceCountMap)
	local customMap = {}
	local sourceTypeList = {}

	for sourceType, _ in pairs(sourceCountMap) do
		sourceTypeList[#sourceTypeList + 1] = sourceType
	end

	table.sort(sourceTypeList)

	for _, sourceType in ipairs(sourceTypeList) do
		customMap[#customMap + 1] = {
			key = sourceType,
			val = ArcadeSurvivorGameHelper._getSkillSourceVal(sourceCountMap[sourceType])
		}
	end

	return customMap
end

function ArcadeSurvivorGameHelper._getSkillSourceVal(sourceIdDict)
	local sourceIdList = {}

	for sourceId, _ in pairs(sourceIdDict) do
		sourceIdList[#sourceIdList + 1] = sourceId
	end

	table.sort(sourceIdList)

	local pairList = {}

	for _, sourceId in ipairs(sourceIdList) do
		pairList[#pairList + 1] = string.format("%s#%s", sourceId, sourceIdDict[sourceId])
	end

	local val = table.concat(pairList, "|")

	if #val > 500 then
		logError(string.format("ArcadeSurvivorGameHelper.getServerSkillContainer error, skill customMap val too long:%s", val))
	end

	return val
end

function ArcadeSurvivorGameHelper.getServerCollectionContainer()
	local info = {
		collections = {}
	}
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local collectionIdList = characterMO and characterMO:getCollectionIdList()

	if collectionIdList then
		for _, collectionId in pairs(collectionIdList) do
			local collectionCount = characterMO:getCollectionCount(collectionId)

			info.collections[#info.collections + 1] = {
				id = collectionId,
				count = collectionCount
			}
		end
	end

	return info
end

function ArcadeSurvivorGameHelper.getGridId(x, y)
	if x and y then
		return x * ArcadeSurvivorEnum.Const.PermillageBase + y
	else
		logError(string.format("ArcadeSurvivorGameHelper.getGridId error, invalid param, x:%s, y:%s", x, y))
	end
end

function ArcadeSurvivorGameHelper.getGridXYById(gridId)
	local gridX = 0
	local gridY = 0

	gridId = tonumber(gridId)

	if gridId then
		gridX = math.floor(gridId / 1000)
		gridY = gridId - gridX * 1000
	else
		logError(string.format("ArcadeSurvivorGameHelper.getGridXYById error, invalid gridId:%s", gridId))
	end

	return gridX, gridY
end

function ArcadeSurvivorGameHelper.grid2Position(gridX, gridY, isWorld)
	local x, y = 0, 0

	if gridX and gridY then
		local baseGridSize = ArcadeSurvivorConfig.instance:getGameBaseGridSize()
		local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()
		local centerGridX = (mapSizeX + 1) * 0.5
		local centerGridY = (mapSizeY + 1) * 0.5

		x = (gridX - centerGridX) * baseGridSize
		y = (gridY - centerGridY) * baseGridSize
	end

	if isWorld then
		local scene = ArcadeSurvivorGameController.instance:getGameScene()

		if not scene then
			return x, y, 0
		end

		return scene:onTransformPoint(x, y)
	end

	return x, y
end

function ArcadeSurvivorGameHelper.getEntityNearCharacterGrid(entityMO)
	if not entityMO then
		return nil, nil
	end

	local gridX, gridY = entityMO:getGridPos()
	local sizeX, sizeY = entityMO:getSize()
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO or sizeX <= 1 and sizeY <= 1 then
		return gridX, gridY
	end

	local left = gridX
	local right = gridX + sizeX - 1
	local bottom = gridY
	local top = gridY + sizeY - 1
	local charGridX, charGridY = characterMO:getGridPos()
	local nearX = Mathf.Clamp(charGridX, left, right)
	local nearY = Mathf.Clamp(charGridY, bottom, top)

	return nearX, nearY
end

function ArcadeSurvivorGameHelper.position2Grid(x, y)
	local gridX, gridY = 0, 0

	if x and y then
		local baseGridSize = ArcadeSurvivorConfig.instance:getGameBaseGridSize()
		local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()
		local centerGridX = (mapSizeX + 1) * 0.5
		local centerGridY = (mapSizeY + 1) * 0.5

		gridX = math.floor(x / baseGridSize + centerGridX + 0.5)
		gridY = math.floor(y / baseGridSize + centerGridY + 0.5)
	end

	return gridX, gridY
end

function ArcadeSurvivorGameHelper.isOutsideMap(gridX, gridY, sizeX, sizeY)
	if not gridX or not gridY then
		logError(string.format("ArcadeSurvivorGameHelper.isOutsideMap error, invalid coordinate, gridX:%s, gridY:%s", gridX, gridY))

		return true
	end

	local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()

	if mapSizeX <= 0 or mapSizeY <= 0 then
		logError("ArcadeSurvivorGameHelper.isOutsideMap error, invalid map size")

		return true
	end

	local minimumCoordinate = ArcadeSurvivorGameEnum.Const.MinimumCoordinate

	if gridX < minimumCoordinate or mapSizeX < gridX or gridY < minimumCoordinate or mapSizeY < gridY then
		return true
	end

	if sizeX then
		local rightGridX = gridX + sizeX - 1

		if mapSizeX < rightGridX then
			return true
		end
	end

	if sizeY then
		local upGridY = gridY + sizeY - 1

		if mapSizeY < upGridY then
			return true
		end
	end

	return false
end

function ArcadeSurvivorGameHelper.iterateNearestPlacementCandidates(originX, originY, sizeX, sizeY)
	local width, height = ArcadeSurvivorGameModel.instance:getMapSize()
	local minimumCoordinate = ArcadeSurvivorGameEnum.Const.MinimumCoordinate
	local minimumX, minimumY = minimumCoordinate, minimumCoordinate
	local maximumX = width - sizeX + minimumCoordinate
	local maximumY = height - sizeY + minimumCoordinate

	if maximumX < minimumX or maximumY < minimumY then
		return
	end

	local minimumDistanceX = 0

	if originX < minimumX then
		minimumDistanceX = minimumX - originX
	elseif maximumX < originX then
		minimumDistanceX = originX - maximumX
	end

	local minimumDistanceY = 0

	if originY < minimumY then
		minimumDistanceY = minimumY - originY
	elseif maximumY < originY then
		minimumDistanceY = originY - maximumY
	end

	local maximumDistanceX = math.max(math.abs(originX - minimumX), math.abs(originX - maximumX))
	local maximumDistanceY = math.max(math.abs(originY - minimumY), math.abs(originY - maximumY))
	local minimumDx = minimumX - originX
	local maximumDx = maximumX - originX
	local distance = minimumDistanceX + minimumDistanceY
	local maximumDistance = maximumDistanceX + maximumDistanceY

	return function()
		while distance <= maximumDistance do
			local candidates = {}
			local dxStart = math.max(-distance, minimumDx)
			local dxEnd = math.min(distance, maximumDx)

			for dx = dxStart, dxEnd do
				local absoluteDx = dx < 0 and -dx or dx
				local dy = distance - absoluteDx
				local x = originX + dx

				if dy == 0 then
					local y = originY

					if y >= minimumY and y <= maximumY then
						candidates[#candidates + 1] = {
							x = x,
							y = y
						}
					end
				else
					local y1 = originY - dy
					local y2 = originY + dy

					if y1 >= minimumY and y1 <= maximumY then
						candidates[#candidates + 1] = {
							x = x,
							y = y1
						}
					end

					if y2 >= minimumY and y2 <= maximumY then
						candidates[#candidates + 1] = {
							x = x,
							y = y2
						}
					end
				end
			end

			distance = distance + 1

			if #candidates > 0 then
				return candidates
			end
		end
	end
end

function ArcadeSurvivorGameHelper.getDirectionGridFromGrid(gridX1, gridY1, gridX2, gridY2, onlyAxis)
	if not gridX1 or not gridY1 or not gridX2 or not gridY2 then
		return
	end

	local dx = gridX2 - gridX1
	local dy = gridY2 - gridY1

	if dx == 0 and dy == 0 then
		return
	end

	local direction

	if onlyAxis then
		local absDx = math.abs(dx)
		local absDy = math.abs(dy)

		if absDy < absDx then
			direction = dx > 0 and ArcadeSurvivorEnum.Direction.Right or ArcadeSurvivorEnum.Direction.Left
		elseif absDx < absDy then
			direction = dy > 0 and ArcadeSurvivorEnum.Direction.Up or ArcadeSurvivorEnum.Direction.Down
		elseif dy > 0 then
			direction = dx > 0 and ArcadeSurvivorEnum.Direction.Up or ArcadeSurvivorEnum.Direction.Left
		else
			direction = dx > 0 and ArcadeSurvivorEnum.Direction.Right or ArcadeSurvivorEnum.Direction.Down
		end
	elseif dx == 0 then
		direction = dy > 0 and ArcadeSurvivorEnum.Direction.Up or ArcadeSurvivorEnum.Direction.Down
	elseif dy == 0 then
		direction = dx > 0 and ArcadeSurvivorEnum.Direction.Right or ArcadeSurvivorEnum.Direction.Left
	elseif dy > 0 then
		direction = dx > 0 and ArcadeSurvivorEnum.Direction.RightUp or ArcadeSurvivorEnum.Direction.LeftUp
	else
		direction = dx > 0 and ArcadeSurvivorEnum.Direction.RightDown or ArcadeSurvivorEnum.Direction.LeftDown
	end

	return direction
end

function ArcadeSurvivorGameHelper.getDirectionGridFromRect(rectGridX, rectGridY, rectSizeX, rectSizeY, gridX2, gridY2)
	local left = rectGridX
	local right = rectGridX + rectSizeX - 1
	local bottom = rectGridY
	local top = rectGridY + rectSizeY - 1

	if left <= gridX2 and gridX2 <= right and bottom <= gridY2 and gridY2 <= top then
		return
	end

	local direction
	local nx = GameUtil.clamp(gridX2, left, right)
	local ny = GameUtil.clamp(gridY2, bottom, top)
	local dx = gridX2 - nx
	local dy = gridY2 - ny

	if dx == 0 then
		direction = dy > 0 and ArcadeSurvivorEnum.Direction.Up or ArcadeSurvivorEnum.Direction.Down
	elseif dy == 0 then
		direction = dx > 0 and ArcadeSurvivorEnum.Direction.Right or ArcadeSurvivorEnum.Direction.Left
	elseif dy > 0 then
		direction = dx > 0 and ArcadeSurvivorEnum.Direction.RightUp or ArcadeSurvivorEnum.Direction.LeftUp
	else
		direction = dx > 0 and ArcadeSurvivorEnum.Direction.RightDown or ArcadeSurvivorEnum.Direction.LeftDown
	end

	return direction
end

function ArcadeSurvivorGameHelper.localGrid2WorldGrid(direction, gridX, gridY, localX, localY)
	if not direction or not gridX or not gridY or not localX or not localY then
		return 0, 0
	end

	local fwdX = ArcadeSurvivorEnum.DirChangeGridX[direction] or 0
	local fwdY = ArcadeSurvivorEnum.DirChangeGridY[direction] or 0
	local leftX = -fwdY
	local leftY = fwdX

	return gridX + fwdX * localX + leftX * localY, gridY + fwdY * localX + leftY * localY
end

function ArcadeSurvivorGameHelper.getIsRectIntersect(aMinX, aMinY, aMaxX, aMaxY, bMinX, bMinY, bMaxX, bMaxY)
	if math.max(aMinX, bMinX) <= math.min(aMaxX, bMaxX) and math.max(aMinY, bMinY) <= math.min(aMaxY, bMaxY) then
		return true
	end
end

function ArcadeSurvivorGameHelper.entityIsAdjacent(mo1, mo2)
	local x1, y1 = mo1:getGridPos()
	local x2, y2 = mo2:getGridPos()
	local sizeX1, sizeY1 = mo1:getSize()
	local sizeX2, sizeY2 = mo2:getSize()
	local left1, right1 = x1, x1 + sizeX1 - 1
	local bottom1, top1 = y1, y1 + sizeY1 - 1
	local left2, right2 = x2, x2 + sizeX2 - 1
	local bottom2, top2 = y2, y2 + sizeY2 - 1

	if not (right1 < left2) and not (right2 < left1) and not (top1 < bottom2) and not (top2 < bottom1) then
		return true
	end

	local horAdj = right1 + 1 == left2 or right2 + 1 == left1
	local verAdj = top1 + 1 == bottom2 or top2 + 1 == bottom1

	if horAdj and not (top1 < bottom2) and not (top2 < bottom1) then
		return true
	end

	if verAdj and not (right1 < left2) and not (right2 < left1) then
		return true
	end

	return false
end

function ArcadeSurvivorGameHelper.getTriggerPointWithParamKeyByEffectId(effectId)
	local triggerPoint = ArcadeSurvivorConfig.instance:getSkillEffectTriggerPoint(effectId)
	local triggerPointParam = ArcadeSurvivorConfig.instance:getSkillEffectTriggerParam(effectId)

	return ArcadeSurvivorGameHelper.getTriggerPointWithParamKey(triggerPoint, triggerPointParam)
end

function ArcadeSurvivorGameHelper.getTriggerPointWithParamKey(triggerPoint, triggerPointParam)
	if string.nilorempty(triggerPoint) or string.nilorempty(triggerPointParam) then
		return triggerPoint
	else
		return string.format("%s_%s", triggerPoint, triggerPointParam)
	end
end

function ArcadeSurvivorGameHelper.getHeartIconName(hpValue, showHpCount, hpItemIndex)
	local heartIconName
	local hpSeqIndex = ArcadeGameHelper.getHPSeqIndex(hpValue, showHpCount, hpItemIndex)

	if hpSeqIndex and hpSeqIndex >= 0 then
		local imgIndex = ArcadeSurvivorConfig.instance:getHpColorImgIndex(hpSeqIndex)

		heartIconName = string.format(ArcadeSurvivorEnum.Const.HeartIcon, imgIndex)
	end

	return heartIconName
end

function ArcadeSurvivorGameHelper.getAreaShowPosition(gridIdDict)
	local minX, maxX, minY, maxY
	local count, sumX, sumY, sumXX, sumYY, sumXY = 0, 0, 0, 0, 0, 0

	for gridId in pairs(gridIdDict) do
		local x, y = ArcadeSurvivorGameHelper.getGridXYById(gridId)

		minX = minX and math.min(minX, x) or x
		maxX = maxX and math.max(maxX, x) or x
		minY = minY and math.min(minY, y) or y
		maxY = maxY and math.max(maxY, y) or y
		count = count + 1
		sumX, sumY = sumX + x, sumY + y
		sumXX, sumYY, sumXY = sumXX + x * x, sumYY + y * y, sumXY + x * y
	end

	if count == 0 then
		return
	end

	local xx = sumXX - sumX * sumX / count
	local yy = sumYY - sumY * sumY / count
	local xy = sumXY - sumX * sumY / count
	local angle = math.deg(math.atan2(2 * xy, xx - yy)) * 0.5
	local step = math.floor(angle / 45 + 0.5)
	local directions = ArcadeSurvivorEnum.Direction
	local direction = directions.Right

	if math.abs(step) == 2 then
		direction = directions.Up
	elseif step == 1 then
		direction = directions.RightUp
	elseif step == -1 then
		direction = directions.RightDown
	end

	local posX, posY = ArcadeSurvivorGameHelper.grid2Position((minX + maxX) * 0.5, (minY + maxY) * 0.5)

	return posX, posY, direction
end

function ArcadeSurvivorGameHelper.getActionShowIdList(actionShowId, showParam)
	local showIdList = ArcadeSurvivorConfig.instance:getActionShowIdList(actionShowId)

	return showIdList
end

function ArcadeSurvivorGameHelper.setShowRotationByType(showId, transform, direction)
	local rotationType = ArcadeSurvivorConfig.instance:getShowRotationType(showId)

	if rotationType ~= 1 or not transform then
		return
	end

	local rotationZ = ArcadeSurvivorEnum.Dir2RotationVal[direction] or 0

	transformhelper.setLocalRotation(transform, 0, 0, rotationZ)
end

function ArcadeSurvivorGameHelper.getGoodsCollectionPrice(collectionId)
	return ArcadeSurvivorConfig.instance:getCollectionPrice(collectionId)
end

function ArcadeSurvivorGameHelper.getGoodsPackPrice(packId)
	return ArcadeSurvivorConfig.instance:getPackPrice(packId)
end

function ArcadeSurvivorGameHelper.buyCollection(collectionId)
	ArcadeSurvivorGameController.instance:gainCollection(collectionId)
end

function ArcadeSurvivorGameHelper.buyPack(packId)
	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnOpenPack, packId)
end

ArcadeSurvivorGameHelper.UnitDataGetterDict = {
	hp = function(mo)
		return mo:getHp()
	end,
	hpPercent = function(mo)
		local hp = mo:getHp()
		local hpCap = mo:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap)

		if hpCap <= 0 then
			return 0
		end

		return hp / hpCap * ArcadeSurvivorEnum.Const.PercentBase
	end
}
ArcadeSurvivorGameHelper.GlobalDataGetterDict = {
	curRound = function()
		return ArcadeSurvivorGameModel.instance:getCurRound()
	end
}

function ArcadeSurvivorGameHelper._isBTValueTypeComparable(isOrderOp, value)
	local valueType = type(value)

	if valueType == "number" or valueType == "string" then
		return true
	end

	if not isOrderOp and valueType == "boolean" then
		return true
	end

	return false
end

function ArcadeSurvivorGameHelper.isBTCompareOperandValid(isOrderOp, left, right)
	local isValid = type(left) == type(right) and ArcadeSurvivorGameHelper._isBTValueTypeComparable(isOrderOp, left)

	if not isValid then
		logError(string.format("ArcadeSurvivorGameHelper:isBTCompareOperandValid error, types are not comparable, isOrder:%s leftType:%s rightType:%s left:%s right:%s", tostring(isOrderOp), type(left), type(right), tostring(left), tostring(right)))
	end

	return isValid
end

ArcadeSurvivorGameHelper.CompareOpDict = {
	[">"] = {
		isOrder = true,
		compFunc = function(left, right)
			return right < left
		end
	},
	[">="] = {
		isOrder = true,
		compFunc = function(left, right)
			return right <= left
		end
	},
	["<"] = {
		isOrder = true,
		compFunc = function(left, right)
			return left < right
		end
	},
	["<="] = {
		isOrder = true,
		compFunc = function(left, right)
			return left <= right
		end
	},
	["=="] = {
		isOrder = false,
		compFunc = function(left, right)
			return left == right
		end
	},
	["~="] = {
		isOrder = false,
		compFunc = function(left, right)
			return left ~= right
		end
	}
}

function ArcadeSurvivorGameHelper.getBTCompareOp(op)
	local compareOp = ArcadeSurvivorGameHelper.CompareOpDict[op]

	if not compareOp then
		logError(string.format("ArcadeSurvivorGameHelper:getBTCompareOp error, op is not supported, op:%s", tostring(op)))
	end

	return compareOp
end

function ArcadeSurvivorGameHelper.isBTCalcRightNotZero(left, right)
	local isValid = right ~= 0

	if not isValid then
		logError(string.format("ArcadeSurvivorGameHelper:isBTCalcRightNotZero error, right is 0, left:%s right:%s", tostring(left), tostring(right)))
	end

	return isValid
end

function ArcadeSurvivorGameHelper.isBTFiniteNumber(value)
	local isFinite = type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge

	if not isFinite then
		logError(string.format("ArcadeSurvivorGameHelper:isBTFiniteNumber error, value is not finite number, value:%s", tostring(value)))
	end

	return isFinite
end

ArcadeSurvivorGameHelper.CalcOpDict = {
	["+"] = {
		calcFunc = function(left, right)
			return left + right
		end
	},
	["-"] = {
		calcFunc = function(left, right)
			return left - right
		end
	},
	["%"] = {
		calcFunc = function(left, right)
			return left % right
		end,
		validateFunc = ArcadeSurvivorGameHelper.isBTCalcRightNotZero
	},
	["*"] = {
		calcFunc = function(left, right)
			return left * right
		end
	},
	["/"] = {
		calcFunc = function(left, right)
			return left / right
		end,
		validateFunc = ArcadeSurvivorGameHelper.isBTCalcRightNotZero
	}
}

function ArcadeSurvivorGameHelper.getBTCalcOp(op)
	local calcOp = ArcadeSurvivorGameHelper.CalcOpDict[op]

	if not calcOp then
		logError(string.format("ArcadeSurvivorGameHelper:getBTCalcOp error, op is not supported, op:%s", tostring(op)))
	end

	return calcOp
end

function ArcadeSurvivorGameHelper.checkHpDialogFunc(mo, groupId)
	local percent = tonumber(ArcadeSurvivorConfig.instance:getDialogParam(groupId))
	local hpCap = mo:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap)

	if not percent or hpCap <= 0 then
		return false
	end

	return mo:getHp() / hpCap <= percent / ArcadeSurvivorEnum.Const.PercentBase
end

function ArcadeSurvivorGameHelper.pickHpDialogFunc(groupIdList)
	local result, minPercent

	for _, groupId in ipairs(groupIdList) do
		local percent = tonumber(ArcadeSurvivorConfig.instance:getDialogParam(groupId))

		if percent and (not minPercent or percent < minPercent) then
			result = groupId
			minPercent = percent
		end
	end

	return result or groupIdList[1]
end

function ArcadeSurvivorGameHelper.getCanTalkDialogGroupId(mo, conditionType)
	local handlerDict = ArcadeSurvivorGameEnum.DialogTalkConditionHandler
	local handler = handlerDict and handlerDict[conditionType]

	if not handler then
		logError(string.format("ArcadeSurvivorGameHelper.getCanTalkDialogGroupId error, handler is nil, conditionType:%s", tostring(conditionType)))

		return
	end

	local candidateGroupIdList = {}

	for _, groupId in ipairs(mo:getDialogGroupIdListByCondition(conditionType)) do
		local checkFunc = handler.checkFunc

		if not mo:getDialogHavePlayed(groupId) and (not checkFunc or checkFunc(mo, groupId)) then
			candidateGroupIdList[#candidateGroupIdList + 1] = groupId
		end
	end

	if #candidateGroupIdList <= 0 then
		return
	end

	local groupId = handler.pickFunc and handler.pickFunc(candidateGroupIdList) or candidateGroupIdList[1]
	local skipGroupIdList = handler.skipUnselectedCandidates and candidateGroupIdList or {
		groupId
	}

	return groupId, skipGroupIdList
end

function ArcadeSurvivorGameHelper.getTalkCharList(strTalk)
	local result = {}

	if not string.nilorempty(strTalk) then
		local content = ""

		for _, char in ipairs(LuaUtil.getUCharArrWithLineFeed(strTalk)) do
			content = content .. char
			result[#result + 1] = content
		end
	end

	return result
end

function ArcadeSurvivorGameHelper.getChangePosPlan(source, mode, x, y, context)
	local types = ArcadeSurvivorGameEnum.ChangePosType

	if mode == types.WorldGrid then
		return {
			x = x,
			y = y
		}
	end

	if mode == types.PassPlayerAxis or mode == types.PassPlayerCorner then
		local axis = mode == types.PassPlayerAxis and ArcadeSurvivorGameEnum.DynamicAxisType.Axis or ArcadeSurvivorGameEnum.DynamicAxisType.Corner

		if context then
			return context:getPassPlayerPlan(axis)
		end

		return ArcadeSurvivorGameHelper.createPassPlayerPlan(source, axis)
	end

	if mode == types.BoardEdge then
		local fromX, fromY = source:getGridPos()
		local sizeX, sizeY = source:getSize()
		local width, height = ArcadeSurvivorGameModel.instance:getMapSize()
		local dx, dy = ArcadeSurvivorEnum.DirChangeGridX[x], ArcadeSurvivorEnum.DirChangeGridY[x]
		local minimum = ArcadeSurvivorGameEnum.Const.MinimumCoordinate
		local stepX = dx > 0 and width - sizeX + minimum - fromX or dx < 0 and fromX - minimum or math.huge
		local stepY = dy > 0 and height - sizeY + minimum - fromY or dy < 0 and fromY - minimum or math.huge
		local steps = math.min(stepX, stepY)

		return {
			x = fromX + dx * steps,
			y = fromY + dy * steps
		}
	end

	if mode == types.PlayerLocalGrid or mode == types.PlayerOffsetGrid then
		local player = ArcadeSurvivorGameModel.instance:getCharacterMO()

		if not player then
			return
		end

		local px, py = player:getGridPos()

		if mode == types.PlayerLocalGrid then
			px, py = ArcadeSurvivorGameHelper.localGrid2WorldGrid(player:getDirection(), px, py, x, y)
		else
			px, py = px + x, py + y
		end

		return {
			x = px,
			y = py
		}
	end
end

function ArcadeSurvivorGameHelper.moveToWorldGrid(targetList, x, y, moveEffectShowId)
	for _, targetMO in ipairs(targetList) do
		local entityType = targetMO:getEntityType()
		local uid = targetMO:getUid()

		ArcadeSurvivorGameController.instance:forceMoveEntity(entityType, uid, x, y, true, moveEffectShowId)
	end
end

function ArcadeSurvivorGameHelper.moveToPlayLocalGrid(targetList, localX, localY, moveEffectShowId)
	local plan = ArcadeSurvivorGameHelper.getChangePosPlan(nil, ArcadeSurvivorGameEnum.ChangePosType.PlayerLocalGrid, localX, localY)

	if plan then
		ArcadeSurvivorGameHelper.moveToWorldGrid(targetList, plan.x, plan.y, moveEffectShowId)
	end
end

local function movePassPlayer(targetList, axisType, moveEffectShowId)
	for _, targetMO in ipairs(targetList) do
		local plan = ArcadeSurvivorGameHelper.createPassPlayerPlan(targetMO, axisType)

		if plan then
			ArcadeSurvivorGameHelper.moveToWorldGrid({
				targetMO
			}, plan.x, plan.y, moveEffectShowId)
		end
	end
end

function ArcadeSurvivorGameHelper.movePassPlayerAxis(targetList, moveEffectShowId)
	movePassPlayer(targetList, ArcadeSurvivorGameEnum.DynamicAxisType.Axis, moveEffectShowId)
end

function ArcadeSurvivorGameHelper.movePassPlayerCorner(targetList, moveEffectShowId)
	movePassPlayer(targetList, ArcadeSurvivorGameEnum.DynamicAxisType.Corner, moveEffectShowId)
end

function ArcadeSurvivorGameHelper.moveToPlayerOffsetGrid(targetList, offsetX, offsetY, moveEffectShowId)
	local plan = ArcadeSurvivorGameHelper.getChangePosPlan(nil, ArcadeSurvivorGameEnum.ChangePosType.PlayerOffsetGrid, offsetX, offsetY)

	if plan then
		ArcadeSurvivorGameHelper.moveToWorldGrid(targetList, plan.x, plan.y, moveEffectShowId)
	end
end

function ArcadeSurvivorGameHelper.createPassPlayerPlan(sourceMO, axisType)
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local playerGridX, playerGridY = characterMO:getGridPos()
	local fromX, fromY = sourceMO:getGridPos()
	local sizeX, sizeY = sourceMO:getSize()
	local dx = playerGridX < fromX and -1 or playerGridX >= fromX + sizeX and 1 or 0
	local dy = playerGridY < fromY and -1 or playerGridY >= fromY + sizeY and 1 or 0

	if axisType == ArcadeSurvivorGameEnum.DynamicAxisType.Axis then
		if dx == 0 == (dy == 0) then
			return
		end
	elseif axisType == ArcadeSurvivorGameEnum.DynamicAxisType.Corner then
		if dx == 0 or dy == 0 then
			return
		end
	else
		return
	end

	local enterX = dx > 0 and playerGridX - (fromX + sizeX - 1) or fromX - playerGridX
	local enterY = dy > 0 and playerGridY - (fromY + sizeY - 1) or fromY - playerGridY
	local steps

	if dx == 0 then
		steps = enterY + sizeY
	elseif dy == 0 then
		steps = enterX + sizeX
	else
		steps = math.min(enterX + sizeX, enterY + sizeY)

		if steps <= math.max(enterX, enterY) then
			return
		end
	end

	local targetX, targetY = fromX + dx * steps, fromY + dy * steps

	if ArcadeSurvivorGameHelper.isOutsideMap(targetX, targetY, sizeX, sizeY) then
		return
	end

	local grids = {}

	for step = 1, steps do
		local x, y = fromX + dx * step, fromY + dy * step

		for gridX = x, x + sizeX - 1 do
			for gridY = y, y + sizeY - 1 do
				if gridX < fromX or gridX >= fromX + sizeX or gridY < fromY or gridY >= fromY + sizeY then
					grids[ArcadeSurvivorGameHelper.getGridId(gridX, gridY)] = true
				end
			end
		end
	end

	return {
		x = targetX,
		y = targetY,
		gridIdDict = grids
	}
end

function ArcadeSurvivorGameHelper.getWeightedId(idList, weightList, totalWeight)
	if not totalWeight or totalWeight <= 0 then
		return
	end

	local randomVal = math.random(totalWeight)

	for index, weight in ipairs(weightList) do
		randomVal = randomVal - weight

		if randomVal <= 0 then
			return idList[index]
		end
	end
end

function ArcadeSurvivorGameHelper.parseColonNumberList(param)
	local result = {}

	if string.nilorempty(param) then
		return result
	end

	local dataList = GameUtil.splitString2(param, true, "#", ":")

	if not dataList then
		return result
	end

	for _, data in ipairs(dataList) do
		local id = tonumber(data[1])
		local val = tonumber(data[2])

		if id and val then
			result[#result + 1] = {
				id = id,
				val = val
			}
		end
	end

	return result
end

function ArcadeSurvivorGameHelper.parseWeightedDataList(dataList)
	local idList = {}
	local weightList = {}
	local totalWeight = 0

	if dataList then
		for _, data in ipairs(dataList) do
			local id = tonumber(data[1])
			local weight = tonumber(data[2]) or 0

			if id and weight > 0 then
				idList[#idList + 1] = id
				weightList[#weightList + 1] = weight
				totalWeight = totalWeight + weight
			end
		end
	end

	return idList, weightList, totalWeight
end

function ArcadeSurvivorGameHelper.parseWeightedIdList(param)
	local dataList = GameUtil.splitString2(param, true, "#", ":")

	return ArcadeSurvivorGameHelper.parseWeightedDataList(dataList)
end

return ArcadeSurvivorGameHelper
