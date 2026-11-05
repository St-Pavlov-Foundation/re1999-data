-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/config/ArcadeSurvivorConfig.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.config.ArcadeSurvivorConfig", package.seeall)

local ArcadeSurvivorConfig = class("ArcadeSurvivorConfig", BaseConfig)

function ArcadeSurvivorConfig:reqConfigNames()
	return {
		"arcade_survivor_const",
		"arcade_survivor_currency",
		"arcade_survivor_reward",
		"arcade_survivor_grade",
		"arcade_survivor_character",
		"arcade_survivor_monster",
		"arcade_survivor_ally",
		"arcade_survivor_grid_cell",
		"arcade_survivor_hall_unit",
		"arcade_survivor_attribute",
		"arcade_survivor_chartag",
		"arcade_survivor_skill",
		"arcade_survivor_skill_effect",
		"arcade_survivor_buff",
		"arcade_survivor_collection",
		"arcade_survivor_collection_rule",
		"arcade_survivor_tag",
		"arcade_survivor_pack",
		"arcade_survivor_shop",
		"arcade_survivor_difficulty",
		"arcade_survivor_stage",
		"arcade_survivor_level",
		"arcade_survivor_level_rule",
		"arcade_survivor_event",
		"arcade_survivor_monster_group",
		"arcade_survivor_talent",
		"arcade_survivor_talent_icon",
		"arcade_survivor_handbook_category",
		"arcade_survivor_handbook",
		"arcade_survivor_show",
		"arcade_survivor_action_show",
		"arcade_survivor_state_show",
		"arcade_survivor_talk",
		"arcade_survivor_talk_step",
		"arcade_survivor_dialog_group",
		"arcade_survivor_dialog_step",
		"arcade_survivor_behavior"
	}
end

function ArcadeSurvivorConfig:onInit()
	self._difficulty2StagesDict = {}
	self._stage2LevelsDict = {}
	self._ruleId2NormalWeight = {}
	self._ruleId2EliteWeight = {}
	self._skillEffectIdListCache = nil
	self._skillEffectParamCache = nil
	self._skillEffectTargetCache = nil
	self._behaviorChildIdListCache = nil
	self._showOffsetCache = nil
end

function ArcadeSurvivorConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function ArcadeSurvivorConfig:arcade_survivor_skillConfigLoaded(configTable)
	self._skillEffectIdListCache = nil
end

function ArcadeSurvivorConfig:arcade_survivor_skill_effectConfigLoaded(configTable)
	self._skillEffectParamCache = nil
	self._skillEffectTargetCache = nil
end

function ArcadeSurvivorConfig:arcade_survivor_behaviorConfigLoaded(configTable)
	self._behaviorChildIdListCache = nil
end

function ArcadeSurvivorConfig:arcade_survivor_showConfigLoaded(configTable)
	self._showOffsetCache = nil
end

function ArcadeSurvivorConfig:_getConstCfg(constId, nilError)
	local cfg = lua_arcade_survivor_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getConst(constId, isToNumber, isMLValue)
	local cfg = self:_getConstCfg(constId, true)

	if not cfg then
		return
	end

	if isMLValue then
		return cfg.mlvalue
	else
		local value = cfg.value

		if isToNumber then
			return tonumber(value) or 0
		else
			return value
		end
	end
end

function ArcadeSurvivorConfig:getConstArray(constId, isTonumber, delimiter1, delimiter2)
	local cfg = self:_getConstCfg(constId, true)

	if not cfg or string.nilorempty(delimiter1) then
		return
	end

	local result
	local value = cfg.value

	if value then
		if string.nilorempty(delimiter2) then
			if isTonumber then
				result = string.splitToNumber(value, delimiter1)
			else
				result = string.split(value, delimiter1)
			end
		else
			result = GameUtil.splitString2(value, isTonumber, delimiter1, delimiter2)
		end
	end

	return result
end

function ArcadeSurvivorConfig:getHpColorImgIndex(index)
	if not self._hpColorList then
		self._hpColorList = self:getConstArray(ArcadeSurvivorEnum.ConstId.HpColorList, false, "#") or {}
	end

	index = index % #self._hpColorList + 1

	return self._hpColorList[index]
end

function ArcadeSurvivorConfig:getGameBaseViewSize()
	if not self._gameBaseViewSizeX or not self._gameBaseVIewSizeY then
		local arr = self:getConstArray(ArcadeSurvivorEnum.ConstId.GameBaseViewSize, true, "#")

		self._gameBaseViewSizeX = arr[1]
		self._gameBaseVIewSizeY = arr[2]
	end

	return self._gameBaseViewSizeX, self._gameBaseVIewSizeY
end

function ArcadeSurvivorConfig:getGameBaseGridSize()
	if not self._gameBaseGridSize then
		self._gameBaseGridSize = self:getConst(ArcadeSurvivorEnum.ConstId.GameBaseGridSize, true)
	end

	return self._gameBaseGridSize
end

function ArcadeSurvivorConfig:getGameBaseUIGridSize()
	if not self._gameBaseUIGridSize then
		self._gameBaseUIGridSize = self:getConst(ArcadeSurvivorEnum.ConstId.GameBaseUIGridSize, true)
	end

	return self._gameBaseUIGridSize
end

function ArcadeSurvivorConfig:getCurrencyCfg(currencyId, nilError)
	local cfg = lua_arcade_survivor_currency.configDict[currencyId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getCurrencyCfg error, cfg is nil, currencyId:%s", currencyId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getCurrencyMin(currencyId)
	local cfg = self:getCurrencyCfg(currencyId, true)

	return cfg and cfg.min or 0
end

function ArcadeSurvivorConfig:getCurrencyMax(currencyId)
	local cfg = self:getCurrencyCfg(currencyId, true)

	return cfg and cfg.max or 0
end

function ArcadeSurvivorConfig:getCurrencyName(currencyId)
	local cfg = self:getCurrencyCfg(currencyId, true)

	return cfg and cfg.name or ""
end

function ArcadeSurvivorConfig:getCurrencyDesc(currencyId)
	local cfg = self:getCurrencyCfg(currencyId, true)

	return cfg and cfg.desc or ""
end

function ArcadeSurvivorConfig:getCurrencyIcon(currencyId)
	local cfg = self:getCurrencyCfg(currencyId, true)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getCurrencySmallIcon(currencyId)
	local cfg = self:getCurrencyCfg(currencyId, true)

	return cfg and cfg.smallIcon
end

function ArcadeSurvivorConfig:getGradeCfg(score, nilError)
	local result

	if score then
		for _, cfg in ipairs(lua_arcade_survivor_grade.configList) do
			local needScore = cfg.needScore
			local findScore = result and result.needScore

			if needScore <= score and (not findScore or findScore < needScore) then
				result = cfg
			end
		end
	end

	if not result and nilError then
		logError(string.format("ArcadeSurvivorConfig:getGradeCfg error, cfg is nil, score:%s", score))
	end

	return result
end

function ArcadeSurvivorConfig:getGradeLevel(score)
	local cfg = self:getGradeCfg(score)

	return cfg and cfg.needScore
end

function ArcadeSurvivorConfig:getCurGradeNeedScore(score)
	local cfg = self:getGradeCfg(score)

	return cfg and cfg.needScore
end

function ArcadeSurvivorConfig:getNextGradeNeedScore(score)
	local findScore

	if score then
		for _, cfg in ipairs(lua_arcade_survivor_grade.configList) do
			local needScore = cfg.needScore

			if score < needScore and (not findScore or needScore < findScore) then
				findScore = needScore
			end
		end
	end

	return findScore
end

function ArcadeSurvivorConfig:getGradeIcon(score)
	local cfg = self:getGradeCfg(score)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getGradeAddCoinRate(score)
	local cfg = self:getGradeCfg(score)

	return cfg and cfg.gainRateAdd or 0
end

function ArcadeSurvivorConfig:getCharacterCfg(characterId, nilError)
	local cfg = lua_arcade_survivor_character.configDict[characterId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getCharacterCfg error, cfg is nil, characterId:%s", characterId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getCharacterIdByWeaponCollectionId(weaponCollectionId)
	if not self._weaponCollectionId2CharacterIdDict then
		self._weaponCollectionId2CharacterIdDict = {}

		for _, cfg in ipairs(lua_arcade_survivor_character.configList) do
			if cfg.weaponCollectionId and cfg.weaponCollectionId > 0 then
				self._weaponCollectionId2CharacterIdDict[cfg.weaponCollectionId] = cfg.id
			end
		end
	end

	return self._weaponCollectionId2CharacterIdDict[weaponCollectionId]
end

function ArcadeSurvivorConfig:getCharacterWeaponCollectionId(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.weaponCollectionId
end

function ArcadeSurvivorConfig:getCharacterCollectionId(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.collectionId
end

function ArcadeSurvivorConfig:getCharacterSize(characterId)
	local sizeX, sizeY = 0, 0
	local cfg = self:getCharacterCfg(characterId, true)

	if cfg and not string.nilorempty(cfg.shape) then
		local arr = string.splitToNumber(cfg.shape, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeSurvivorConfig:getCharacterHpCap(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.hpCap or 0
end

function ArcadeSurvivorConfig:getCharacterRespawnNeedHpCap(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.respawnNeedHpCap or 0
end

function ArcadeSurvivorConfig:getCharacterAtk(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.atk or 0
end

function ArcadeSurvivorConfig:getCharacterAtkLength(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.atkLength or 0
end

function ArcadeSurvivorConfig:getCharacterAtkWidth(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.atkWidth or 0
end

function ArcadeSurvivorConfig:getCharacterAtkInterval(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.atkInterval or 0
end

function ArcadeSurvivorConfig:getCharacterCriRate(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.criRate or 0
end

function ArcadeSurvivorConfig:getCharacterUnlockCondition(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.unlockCondition
end

function ArcadeSurvivorConfig:getCharTagCfg(tagId)
	local cfg = lua_arcade_survivor_chartag.configDict[tagId]

	if not cfg then
		logError(string.format("ArcadeSurvivorConfig:getCharTagCfg error, cfg is nil, tagId:%s", tagId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getCharTagName(tagId)
	local cfg = self:getCharTagCfg(tagId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getCharacterRes(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.resName
end

function ArcadeSurvivorConfig:getCharacterIcon(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getCharacterPortrait(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.portrait
end

function ArcadeSurvivorConfig:getCharacterPortraitScale(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.portraitScale
end

function ArcadeSurvivorConfig:getCharacterPortraitOffset(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.portraitOffset
end

function ArcadeSurvivorConfig:getCharacterLockTip(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.lockTip
end

function ArcadeSurvivorConfig:getMonsterCfg(monsterId, nilError)
	local cfg = lua_arcade_survivor_monster.configDict[monsterId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getMonsterCfg error, cfg is nil, monsterId:%s", monsterId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getMonsterName(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.name or ""
end

function ArcadeSurvivorConfig:getMonsterDesc(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.desc
end

function ArcadeSurvivorConfig:getMonsterRes(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.resName
end

function ArcadeSurvivorConfig:getMonsterIcon(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getMonsterDialogGroupIdList(monsterId)
	local result = {}
	local cfg = self:getMonsterCfg(monsterId, true)

	if cfg and not string.nilorempty(cfg.dialogGroupIds) then
		result = string.splitToNumber(cfg.dialogGroupIds, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getMonsterSize(monsterId)
	local sizeX, sizeY = 0, 0
	local cfg = self:getMonsterCfg(monsterId, true)

	if cfg and not string.nilorempty(cfg.shape) then
		local arr = string.splitToNumber(cfg.shape, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeSurvivorConfig:getMonsterType(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.type
end

function ArcadeSurvivorConfig:getMonsterHpCap(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.hpCap or 0
end

function ArcadeSurvivorConfig:getMonsterAtk(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.atk or 0
end

function ArcadeSurvivorConfig:getMonsterDropCoin(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.dropCoin or 0
end

function ArcadeSurvivorConfig:getMonsterTreeId(monsterId, difficulty)
	local cfg = self:getMonsterCfg(monsterId, true)

	if not cfg or string.nilorempty(cfg.treeIds) then
		return
	end

	local treeIndex = difficulty

	if not treeIndex or treeIndex <= 0 then
		treeIndex = 1
	end

	local treeIdList = string.splitToNumber(cfg.treeIds, "#")
	local treeId = treeIdList[treeIndex]

	if not treeId or treeId <= 0 then
		treeId = treeIdList[1]

		logError(string.format("ArcadeSurvivorConfig:getMonsterTreeId error, treeId is nil, monsterId:%s, difficulty:%s", monsterId, difficulty))
	end

	return treeId
end

function ArcadeSurvivorConfig:getMonsterSkillIdList(monsterId)
	local result = {}
	local cfg = self:getMonsterCfg(monsterId, true)

	if cfg and not string.nilorempty(cfg.skillIds) then
		result = string.splitToNumber(cfg.skillIds, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getMonsterIconOffset(characterId)
	local cfg = self:getMonsterCfg(characterId, true)

	return cfg and cfg.iconOffset
end

function ArcadeSurvivorConfig:getMonsterIconScale(characterId)
	local cfg = self:getMonsterCfg(characterId, true)

	return cfg and cfg.iconScale
end

function ArcadeSurvivorConfig:getMonsterIconOffset2(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.iconOffset2
end

function ArcadeSurvivorConfig:getMonsterIconScale2(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.iconScale2
end

function ArcadeSurvivorConfig:getMonsterBgmId(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.bgmId
end

function ArcadeSurvivorConfig:getAllyCfg(allyId, nilError)
	local cfg = lua_arcade_survivor_ally.configDict[allyId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getAllyCfg error, cfg is nil, allyId:%s", allyId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getAllyName(allyId)
	local cfg = self:getAllyCfg(allyId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getAllyRes(allyId)
	local cfg = self:getAllyCfg(allyId, true)

	return cfg and cfg.resName
end

function ArcadeSurvivorConfig:getAllyIcon(allyId)
	local cfg = self:getAllyCfg(allyId, true)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getAllySize(allyId)
	local sizeX, sizeY = 0, 0
	local cfg = self:getAllyCfg(allyId, true)

	if cfg and not string.nilorempty(cfg.shape) then
		local arr = string.splitToNumber(cfg.shape, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeSurvivorConfig:getAllyDuration(allyId)
	local cfg = self:getAllyCfg(allyId, true)

	return cfg and cfg.durationTicks or 0
end

function ArcadeSurvivorConfig:getAllySkillIdList(allyId)
	local result = {}
	local cfg = self:getAllyCfg(allyId, true)

	if cfg and not string.nilorempty(cfg.skillIds) then
		result = string.splitToNumber(cfg.skillIds, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getFloorCfg(floorId, nilError)
	local cfg = lua_arcade_survivor_grid_cell.configDict[floorId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getFloorCfg error, cfg is nil, floorId:%s", floorId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getFloorName(floorId)
	local cfg = self:getFloorCfg(floorId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getFloorType(floorId)
	local cfg = self:getFloorCfg(floorId, true)

	return cfg and cfg.type
end

function ArcadeSurvivorConfig:getFloorSize(floorId)
	local sizeX, sizeY = 0, 0
	local cfg = self:getFloorCfg(floorId, true)

	if cfg and not string.nilorempty(cfg.shape) then
		local arr = string.splitToNumber(cfg.shape, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeSurvivorConfig:getFloorRes(floorId)
	local cfg = self:getFloorCfg(floorId, true)

	return cfg and cfg.resName
end

function ArcadeSurvivorConfig:getFloorIcon(floorId)
	local cfg = self:getFloorCfg(floorId, true)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getFloorDurationTicks(floorId)
	local cfg = self:getFloorCfg(floorId, true)

	return cfg and cfg.durationTicks or 0
end

function ArcadeSurvivorConfig:getFloorSkillIdList(floorId)
	local result = {}
	local cfg = self:getFloorCfg(floorId, true)

	if cfg and not string.nilorempty(cfg.skillIds) then
		result = string.splitToNumber(cfg.skillIds, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getFloorShowId(floorId)
	local cfg = self:getFloorCfg(floorId, true)

	return cfg and cfg.showId
end

function ArcadeSurvivorConfig:getHallUnitCfg(unitId, nilError)
	local cfg = lua_arcade_survivor_hall_unit.configDict[unitId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getHallUnitCfg error, cfg is nil, unitId:%s", unitId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getHallUnitIdList()
	if not self._hallUnitIdList then
		self._hallUnitIdList = {}

		for id, _ in pairs(lua_arcade_survivor_hall_unit.configDict) do
			self._hallUnitIdList[#self._hallUnitIdList + 1] = id
		end
	end

	return self._hallUnitIdList
end

function ArcadeSurvivorConfig:getHallUnitEnterViewNameDict()
	if not self._hallUnitEnterViewNameDict then
		self._hallUnitEnterViewNameDict = {}

		for _, cfg in pairs(lua_arcade_survivor_hall_unit.configDict) do
			local viewName = cfg.enterViewName

			if not string.nilorempty(viewName) then
				self._hallUnitEnterViewNameDict[viewName] = true
			end
		end
	end

	return self._hallUnitEnterViewNameDict
end

function ArcadeSurvivorConfig:getHallUnitName(unitId)
	local cfg = self:getHallUnitCfg(unitId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getHallUnitDesc(unitId)
	local cfg = self:getHallUnitCfg(unitId, true)

	return cfg and cfg.desc
end

function ArcadeSurvivorConfig:getHallUnitGrid(unitId)
	local gridX, gridY = 0, 0
	local cfg = self:getHallUnitCfg(unitId, true)

	if cfg and not string.nilorempty(cfg.grid) then
		local arr = string.splitToNumber(cfg.grid, "#")

		gridX = arr[1] or 0
		gridY = arr[2] or 0
	end

	return gridX, gridY
end

function ArcadeSurvivorConfig:getHallUnitPos(unitId)
	local posX, posY = 0, 0
	local cfg = self:getHallUnitCfg(unitId, true)

	if cfg and not string.nilorempty(cfg.pos) then
		local arr = string.splitToNumber(cfg.pos, "#")

		posX = arr[1] or 0
		posY = arr[2] or 0
	end

	return posX, posY
end

function ArcadeSurvivorConfig:getHallUnitRes(unitId)
	local cfg = self:getHallUnitCfg(unitId, true)

	return cfg and cfg.resName
end

function ArcadeSurvivorConfig:getHallUnitScale(unitId)
	local scaleX, scaleY = 1, 1
	local cfg = self:getHallUnitCfg(unitId, true)

	if cfg and not string.nilorempty(cfg.scale) then
		local arr = string.splitToNumber(cfg.scale, "#")

		scaleX = arr[1] or 1
		scaleY = arr[2] or scaleX
	end

	return scaleX, scaleY
end

function ArcadeSurvivorConfig:getHallUnitPosOffset(unitId)
	local offsetX, offsetY = 0, 0
	local cfg = self:getHallUnitCfg(unitId, true)

	if cfg and not string.nilorempty(cfg.posOffset) then
		local arr = string.splitToNumber(cfg.posOffset, "#")

		offsetX = arr[1] or 0
		offsetY = arr[2] or 0
	end

	return offsetX, offsetY
end

function ArcadeSurvivorConfig:getHallUnitNameOffset(unitId)
	local offsetX, offsetY = 0, 0
	local cfg = self:getHallUnitCfg(unitId, true)

	if cfg and not string.nilorempty(cfg.nameOffset) then
		local arr = string.splitToNumber(cfg.nameOffset, "#")

		offsetX = arr[1] or 0
		offsetY = arr[2] or 0
	end

	return offsetX, offsetY
end

function ArcadeSurvivorConfig:getHallUnitReddot(unitId)
	local cfg = self:getHallUnitCfg(unitId, true)

	return cfg and cfg.reddot
end

function ArcadeSurvivorConfig:getHallUnitTalkGroupIdList(unitId)
	local result = {}
	local cfg = self:getHallUnitCfg(unitId, true)

	if cfg and not string.nilorempty(cfg.talkGroupIds) then
		result = string.splitToNumber(cfg.talkGroupIds, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getHallUnitIsOpenTip(unitId)
	local cfg = self:getHallUnitCfg(unitId, true)

	return cfg and cfg.isOpenTip
end

function ArcadeSurvivorConfig:getHallUnitEnterViewName(unitId)
	local cfg = self:getHallUnitCfg(unitId, true)

	return cfg and cfg.enterViewName
end

function ArcadeSurvivorConfig:getHallUnitDifficulty(unitId)
	local cfg = self:getHallUnitCfg(unitId, true)

	return cfg and cfg.difficulty
end

function ArcadeSurvivorConfig:getHallUnitLockObj(unitId)
	local cfg = self:getHallUnitCfg(unitId, true)

	return cfg and cfg.lockObj
end

function ArcadeSurvivorConfig:getHallUnitLockObjDict()
	if not self._hallUnitLockObjDict then
		self._hallUnitLockObjDict = {}

		for id, cfg in pairs(lua_arcade_survivor_hall_unit.configDict) do
			self._hallUnitLockObjDict[id] = cfg.lockObj
		end
	end

	return self._hallUnitLockObjDict
end

function ArcadeSurvivorConfig:getHallUnitLockToast(unitId)
	local cfg = self:getHallUnitCfg(unitId, true)

	return cfg and cfg.lockToast
end

function ArcadeSurvivorConfig:getAttributeCfg(attrId, nilError)
	local cfg = lua_arcade_survivor_attribute.configDict[attrId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getAttributeCfg error, cfg is nil, attrId:%s", attrId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getAttributeName(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getAttributeMin(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.min or 0
end

function ArcadeSurvivorConfig:getAttributeMax(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.max or 0
end

function ArcadeSurvivorConfig:getAttributeIcon(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getAttributeSort(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.sort
end

function ArcadeSurvivorConfig:getSkillCfg(skillId, nilError)
	local cfg = lua_arcade_survivor_skill.configDict[skillId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getSkillCfg error, cfg is nil, skillId:%s", skillId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getSkillName(skillId)
	local cfg = self:getSkillCfg(skillId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getSkillDesc(skillId)
	local cfg = self:getSkillCfg(skillId, true)

	return cfg and cfg.desc
end

function ArcadeSurvivorConfig:getSkillType(skillId)
	local cfg = self:getSkillCfg(skillId, true)

	return cfg and cfg.type
end

function ArcadeSurvivorConfig:getSkillEffectIdList(skillId)
	local cache = self._skillEffectIdListCache

	if not cache then
		cache = {}
		self._skillEffectIdListCache = cache
	end

	local cached = cache[skillId]

	if cached then
		return cached
	end

	local result = {}
	local cfg = self:getSkillCfg(skillId, true)

	if cfg and not string.nilorempty(cfg.effectIds) then
		result = string.splitToNumber(cfg.effectIds, "#")
	end

	if skillId then
		cache[skillId] = result
	end

	return result
end

function ArcadeSurvivorConfig:getSkillEffectCfg(effectId, nilError)
	local cfg = lua_arcade_survivor_skill_effect.configDict[effectId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getSkillEffectCfg error, cfg is nil, effectId:%s", effectId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getSkillEffectSubEffect(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.subEffect
end

function ArcadeSurvivorConfig:getSkillEffectTriggerPoint(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.triggerPoint
end

function ArcadeSurvivorConfig:getSkillEffectTriggerParam(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.triggerParam
end

function ArcadeSurvivorConfig:getSkillEffectCondition(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.condition
end

function ArcadeSurvivorConfig:getSkillEffectConditionParam(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.conditionParam
end

function ArcadeSurvivorConfig:getSkillEffectTriggerRate(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.triggerRate or 0
end

function ArcadeSurvivorConfig:getSkillEffectLevelMaxTriggerCount(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.levelMaxTriggerCount or 0
end

function ArcadeSurvivorConfig:getSkillEffectType(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.type
end

function ArcadeSurvivorConfig:getSkillEffectParam(effectId)
	local cache = self._skillEffectParamCache

	if not cache then
		cache = {}
		self._skillEffectParamCache = cache
	end

	local cached = cache[effectId]

	if cached then
		return cached
	end

	local result = {}
	local cfg = self:getSkillEffectCfg(effectId, true)

	if cfg and not string.nilorempty(cfg.param) then
		result = string.split(cfg.param, "#")
	end

	if effectId then
		cache[effectId] = result
	end

	return result
end

function ArcadeSurvivorConfig:getSkillEffectTarget(effectId)
	local cache = self._skillEffectTargetCache

	if not cache then
		cache = {}
		self._skillEffectTargetCache = cache
	end

	local cached = cache[effectId]

	if cached then
		return cached
	end

	local result = {}
	local cfg = self:getSkillEffectCfg(effectId, true)

	if cfg and not string.nilorempty(cfg.target) then
		result = string.split(cfg.target, "#")
	end

	if effectId then
		cache[effectId] = result
	end

	return result
end

function ArcadeSurvivorConfig:getSkillEffectTriggerShowId(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.triggerShowId
end

function ArcadeSurvivorConfig:getSkillEffectCasterShowId(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.casterShowId
end

function ArcadeSurvivorConfig:getSkillEffectTargetShowId(effectId)
	local cfg = self:getSkillEffectCfg(effectId, true)

	return cfg and cfg.targetShowId
end

function ArcadeSurvivorConfig:getBuffCfg(buffId, nilError)
	local cfg = lua_arcade_survivor_buff.configDict[buffId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getBuffCfg error, cfg is nil, buffId:%s", buffId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getBuffName(buffId)
	local cfg = self:getBuffCfg(buffId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getBuffDesc(buffId)
	local cfg = self:getBuffCfg(buffId, true)

	return cfg and cfg.desc
end

function ArcadeSurvivorConfig:getBuffType(buffId)
	local cfg = self:getBuffCfg(buffId, true)

	return cfg and cfg.type
end

function ArcadeSurvivorConfig:getBuffParam(buffId)
	local cfg = self:getBuffCfg(buffId, true)

	return cfg and cfg.param
end

function ArcadeSurvivorConfig:getBuffMaxStack(buffId)
	local cfg = self:getBuffCfg(buffId, true)

	return cfg and cfg.maxStack
end

function ArcadeSurvivorConfig:getBuffIsSubStack(buffId)
	local cfg = self:getBuffCfg(buffId, true)

	return cfg and cfg.isSubStack
end

function ArcadeSurvivorConfig:getBuffDuration(buffId)
	local cfg = self:getBuffCfg(buffId, true)

	return cfg and cfg.duration or 0
end

function ArcadeSurvivorConfig:getBuffGainShow(buffId)
	local cfg = self:getBuffCfg(buffId, true)

	return cfg and cfg.gainShow
end

function ArcadeSurvivorConfig:getBuffLoopShow(buffId)
	local cfg = self:getBuffCfg(buffId, true)

	return cfg and cfg.loopShow
end

function ArcadeSurvivorConfig:getBuffLevelKeep(buffId)
	local cfg = self:getBuffCfg(buffId)

	return cfg and cfg.levelKeep
end

function ArcadeSurvivorConfig:getCollectionCfg(collectionId, nilError)
	local cfg = lua_arcade_survivor_collection.configDict[collectionId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getCollectionCfg error, cfg is nil, collectionId:%s", collectionId))
	end

	return cfg
end

function ArcadeSurvivorConfig:arcade_survivor_collectionConfigLoaded(configTable)
	local rare2IdListDict = {}
	local tag2Rare2IdListDict = {}
	local collectionId2TagListDict = {}
	local collectionId2TagDictDict = {}
	local configList = configTable and configTable.configList or {}

	for _, cfg in ipairs(configList) do
		local rarity = cfg.rarity or 0
		local rareIdList = rare2IdListDict[rarity]

		if not rareIdList then
			rareIdList = {}
			rare2IdListDict[rarity] = rareIdList
		end

		rareIdList[#rareIdList + 1] = cfg.id

		local tagList = {}
		local tagDict = {}

		if not string.nilorempty(cfg.tagId) then
			for _, tag in ipairs(string.split(cfg.tagId, "#")) do
				if not tagDict[tag] then
					tagDict[tag] = true
					tagList[#tagList + 1] = tag

					local tagRare2IdListDict = tag2Rare2IdListDict[tag]

					if not tagRare2IdListDict then
						tagRare2IdListDict = {}
						tag2Rare2IdListDict[tag] = tagRare2IdListDict
					end

					local tagRareIdList = tagRare2IdListDict[rarity]

					if not tagRareIdList then
						tagRareIdList = {}
						tagRare2IdListDict[rarity] = tagRareIdList
					end

					tagRareIdList[#tagRareIdList + 1] = cfg.id
				end
			end
		end

		collectionId2TagListDict[cfg.id] = tagList
		collectionId2TagDictDict[cfg.id] = tagDict
	end

	self._rare2CollectionIdListDict = rare2IdListDict
	self._tag2Rare2IdListDict = tag2Rare2IdListDict
	self._collectionId2TagListDict = collectionId2TagListDict
	self._collectionId2TagDictDict = collectionId2TagDictDict
end

function ArcadeSurvivorConfig:_ensureCollectionIndex()
	if self._rare2CollectionIdListDict then
		return
	end

	self:arcade_survivor_collectionConfigLoaded(lua_arcade_survivor_collection)
end

function ArcadeSurvivorConfig:_appendCollectionIdList(result, idList, excludeDict)
	for _, collectionId in ipairs(idList) do
		if not excludeDict or not excludeDict[collectionId] then
			result[#result + 1] = collectionId
		end
	end
end

function ArcadeSurvivorConfig:getCollectionIdListInCfg(rare, specTag, excludeDict)
	self:_ensureCollectionIndex()

	local result = {}

	if specTag then
		local tagRare2IdListDict = self._tag2Rare2IdListDict[specTag]

		if not tagRare2IdListDict then
			return result
		end

		if rare then
			local idList = tagRare2IdListDict[rare]

			if idList then
				self:_appendCollectionIdList(result, idList, excludeDict)
			end
		else
			for _, idList in pairs(tagRare2IdListDict) do
				self:_appendCollectionIdList(result, idList, excludeDict)
			end
		end

		return result
	end

	if rare then
		local idList = self._rare2CollectionIdListDict[rare]

		if idList then
			self:_appendCollectionIdList(result, idList, excludeDict)
		end
	else
		for _, idList in pairs(self._rare2CollectionIdListDict) do
			self:_appendCollectionIdList(result, idList, excludeDict)
		end
	end

	return result
end

function ArcadeSurvivorConfig:getCollectionName(collectionId)
	local cfg = self:getCollectionCfg(collectionId, true)

	return cfg and cfg.name or ""
end

function ArcadeSurvivorConfig:getCollectionDesc(collectionId)
	local cfg = self:getCollectionCfg(collectionId, true)

	return cfg and cfg.desc or ""
end

function ArcadeSurvivorConfig:getCollectionIcon(collectionId)
	local cfg = self:getCollectionCfg(collectionId, true)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getCollectionTagIds(collectionId, getDict)
	self:_ensureCollectionIndex()

	local tagList = self._collectionId2TagListDict[collectionId]

	if not tagList then
		self:getCollectionCfg(collectionId, true)

		return nil
	end

	if getDict then
		return self._collectionId2TagDictDict[collectionId]
	end

	return tagList
end

function ArcadeSurvivorConfig:getCollectionRarity(collectionId)
	local cfg = self:getCollectionCfg(collectionId, true)

	return cfg and cfg.rarity
end

function ArcadeSurvivorConfig:getCollectionMaxStacks(collectionId)
	local cfg = self:getCollectionCfg(collectionId, true)

	return cfg and cfg.maxStacks or 0
end

function ArcadeSurvivorConfig:getCollectionAddSkillIdList(collectionId)
	local result = {}
	local cfg = self:getCollectionCfg(collectionId, true)

	if cfg and not string.nilorempty(cfg.addSkills) then
		result = string.splitToNumber(cfg.addSkills, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getCollectionMonsterAddSkillIdList(collectionId)
	local result = {}
	local cfg = self:getCollectionCfg(collectionId, true)

	if cfg and not string.nilorempty(cfg.monsterAddSkills) then
		result = string.splitToNumber(cfg.monsterAddSkills, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getCollectionRuleIdList(collectionId)
	local result = {}
	local cfg = self:getCollectionCfg(collectionId, true)

	if cfg and not string.nilorempty(cfg.ruleIds) then
		result = string.splitToNumber(cfg.ruleIds, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getCollectionPrice(collectionId)
	local cfg = self:getCollectionCfg(collectionId, true)

	return cfg and cfg.prices or 0
end

function ArcadeSurvivorConfig:getCollectionRuleCfg(ruleId, nilError)
	local cfg = lua_arcade_survivor_collection_rule.configDict[ruleId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getCollectionRuleCfg error, cfg is nil, ruleId:%s", ruleId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getCollectionRuleType(ruleId)
	local cfg = self:getCollectionRuleCfg(ruleId, true)

	return cfg and cfg.type
end

function ArcadeSurvivorConfig:getCollectionRuleTypeParam(ruleId)
	local cfg = self:getCollectionRuleCfg(ruleId, true)

	return cfg and cfg.typeParam
end

function ArcadeSurvivorConfig:getTagCfg(tagId, nilError)
	local cfg = lua_arcade_survivor_tag.configDict[tagId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getTagCfg error, cfg is nil, tagId:%s", tagId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getTagName(tagId)
	local cfg = self:getTagCfg(tagId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getPackCfg(packId, nilError)
	local cfg = lua_arcade_survivor_pack.configDict[packId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getPackCfg error, cfg is nil, packId:%s", packId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getPackName(packId)
	local cfg = self:getPackCfg(packId, true)

	return cfg and cfg.name or ""
end

function ArcadeSurvivorConfig:getPackIcon(packId)
	local cfg = self:getPackCfg(packId, true)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getPackDesc(packId)
	local cfg = self:getPackCfg(packId, true)

	return cfg and cfg.desc or ""
end

function ArcadeSurvivorConfig:getPackRarity(packId)
	local cfg = self:getPackCfg(packId, true)

	return cfg and cfg.rarity
end

function ArcadeSurvivorConfig:getPackPrice(packId)
	local cfg = self:getPackCfg(packId, true)

	return cfg and cfg.prices or 0
end

function ArcadeSurvivorConfig:getPackOptionCount(packId)
	local cfg = self:getPackCfg(packId, true)

	return cfg and cfg.optionCount or 0
end

function ArcadeSurvivorConfig:getPackRerollCount(packId)
	local cfg = self:getPackCfg(packId, true)

	return cfg and cfg.rerollCount or 0
end

function ArcadeSurvivorConfig:getPackRarityWeightList(packId)
	local result = {}
	local cfg = self:getPackCfg(packId, true)

	if cfg and not string.nilorempty(cfg.rarityWeights) then
		result = string.splitToNumber(cfg.rarityWeights, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getShopCfg(shopId, nilError)
	local cfg = lua_arcade_survivor_shop.configDict[shopId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getShopCfg error, cfg is nil, shopId:%s", shopId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getShopGoodsType(shopId)
	local cfg = self:getShopCfg(shopId, true)

	return cfg and cfg.goodsType
end

function ArcadeSurvivorConfig:getShopSlot(shopId)
	local cfg = self:getShopCfg(shopId, true)

	return cfg and cfg.slot or 0
end

function ArcadeSurvivorConfig:getShopSlotParamList(shopId)
	local result = {}
	local cfg = self:getShopCfg(shopId, true)

	if cfg and not string.nilorempty(cfg.slotParams) then
		result = string.split(cfg.slotParams, "|")
	end

	return result
end

function ArcadeSurvivorConfig:getShopWeightList(shopId)
	local result = {}
	local cfg = self:getShopCfg(shopId, true)

	if cfg and not string.nilorempty(cfg.weight) then
		result = string.splitToNumber(cfg.weight, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getShopTagWeightList(shopId)
	local result = {}
	local cfg = self:getShopCfg(shopId, true)

	if cfg and not string.nilorempty(cfg.tagWeight) then
		result = string.splitToNumber(cfg.tagWeight, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getDifficultyCfg(difficultyId, nilError)
	local cfg = lua_arcade_survivor_difficulty.configDict[difficultyId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getDifficultyCfg error, cfg is nil, difficultyId:%s", difficultyId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getDifficultyIdList()
	if not self._difficultyIdList then
		self._difficultyIdList = {}

		for _, cfg in ipairs(lua_arcade_survivor_difficulty.configList) do
			self._difficultyIdList[#self._difficultyIdList + 1] = cfg.id
		end
	end

	return self._difficultyIdList
end

function ArcadeSurvivorConfig:_getDifficultyStageIdList(difficultyId)
	if self._difficulty2StagesDict[difficultyId] then
		return self._difficulty2StagesDict[difficultyId]
	else
		local cfg = self:getDifficultyCfg(difficultyId, true)

		if cfg and not string.nilorempty(cfg.stageIds) then
			local stageIdList = string.splitToNumber(cfg.stageIds, "#")

			self._difficulty2StagesDict[difficultyId] = stageIdList

			return stageIdList
		end
	end
end

function ArcadeSurvivorConfig:getDifficultyStageId(difficulty, stageIndex)
	local stageList = self:_getDifficultyStageIdList(difficulty)

	return stageList and stageList[stageIndex]
end

function ArcadeSurvivorConfig:getDifficultyStageCount(difficultyId)
	local stageList = self:_getDifficultyStageIdList(difficultyId)

	return stageList and #stageList or 0
end

function ArcadeSurvivorConfig:getDifficultyDesc(difficultyId)
	local cfg = self:getDifficultyCfg(difficultyId)

	return cfg and cfg.desc or ""
end

function ArcadeSurvivorConfig:getDifficultyAddSkill(difficultyId)
	local result = {}
	local cfg = self:getDifficultyCfg(difficultyId, true)

	if cfg and not string.nilorempty(cfg.addSkills) then
		result = string.splitToNumber(cfg.addSkills, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getDifficultyMonsterAddSkillIdList(difficultyId)
	local result = {}
	local cfg = self:getDifficultyCfg(difficultyId, true)

	if cfg and not string.nilorempty(cfg.monsterAddSkills) then
		result = string.splitToNumber(cfg.monsterAddSkills, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getDifficultyDiamondMul(difficultyId)
	local cfg = self:getDifficultyCfg(difficultyId, true)

	return cfg and cfg.diamondMul or 0
end

function ArcadeSurvivorConfig:getDifficultyCassetteMul(difficultyId)
	local cfg = self:getDifficultyCfg(difficultyId, true)

	return cfg and cfg.cassetteMul or 0
end

function ArcadeSurvivorConfig:getDifficultyHpMul(difficultyId)
	local cfg = self:getDifficultyCfg(difficultyId, true)

	return cfg and cfg.hpMul or 0
end

function ArcadeSurvivorConfig:getDifficultyAtkMul(difficultyId)
	local cfg = self:getDifficultyCfg(difficultyId, true)

	return cfg and cfg.atkMul or 0
end

function ArcadeSurvivorConfig:getDifficultyPlayerTurnTime(difficultyId)
	local cfg = self:getDifficultyCfg(difficultyId, true)

	return cfg and cfg.playerTurnTime
end

function ArcadeSurvivorConfig:getDifficultyStartShopRefresh(difficultyId)
	local cfg = self:getDifficultyCfg(difficultyId, true)

	return cfg and cfg.startShopRefresh or 0
end

function ArcadeSurvivorConfig:getDifficultyStartCoin(difficultyId)
	local cfg = self:getDifficultyCfg(difficultyId, true)

	return cfg and cfg.startCoin or 0
end

function ArcadeSurvivorConfig:getStageCfg(stageId, nilError)
	local cfg = lua_arcade_survivor_stage.configDict[stageId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getStageCfg error, cfg is nil, stageId:%s", stageId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getStageName(stageId)
	local cfg = self:getStageCfg(stageId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getStageSceneRes(stageId)
	local cfg = self:getStageCfg(stageId, true)

	return cfg and cfg.sceneRes
end

function ArcadeSurvivorConfig:getStageEventPool(stageId)
	local result = {}
	local cfg = self:getStageCfg(stageId, true)

	if cfg and not string.nilorempty(cfg.eventPool) then
		result = string.splitToNumber(cfg.eventPool, "#")
	end

	return result
end

function ArcadeSurvivorConfig:_getStageLevelIdList(stageId)
	if self._stage2LevelsDict[stageId] then
		return self._stage2LevelsDict[stageId]
	else
		local cfg = self:getStageCfg(stageId, true)

		if cfg and not string.nilorempty(cfg.levelIds) then
			local levelIdList = string.splitToNumber(cfg.levelIds, "#")

			self._stage2LevelsDict[stageId] = levelIdList

			return levelIdList
		end
	end
end

function ArcadeSurvivorConfig:getStageLevelId(stageId, levelIndex)
	local stageList = self:_getStageLevelIdList(stageId)

	return stageList and stageList[levelIndex]
end

function ArcadeSurvivorConfig:getStageLevelCount(stageId)
	local stageList = self:_getStageLevelIdList(stageId)

	return stageList and #stageList or 0
end

function ArcadeSurvivorConfig:getLevelCfg(levelId, nilError)
	local cfg = lua_arcade_survivor_level.configDict[levelId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getLevelCfg error, cfg is nil, levelId:%s", levelId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getLevelName(levelId)
	local cfg = self:getLevelCfg(levelId, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getLevelTitle(levelId)
	local cfg = self:getLevelCfg(levelId, true)

	return cfg and cfg.title
end

function ArcadeSurvivorConfig:getLevelRuleId(levelId)
	local cfg = self:getLevelCfg(levelId, true)

	return cfg and cfg.ruleId
end

function ArcadeSurvivorConfig:getLevelShopId(levelId)
	local cfg = self:getLevelCfg(levelId, true)

	return cfg and cfg.shopId
end

function ArcadeSurvivorConfig:getLevelPriceMul(levelId)
	local cfg = self:getLevelCfg(levelId, true)

	return cfg and cfg.priceMul or 0
end

function ArcadeSurvivorConfig:getLevelHpMul(levelId)
	local cfg = self:getLevelCfg(levelId, true)

	return cfg and cfg.hpMul or 0
end

function ArcadeSurvivorConfig:getLevelAtkMul(levelId)
	local cfg = self:getLevelCfg(levelId, true)

	return cfg and cfg.atkMul or 0
end

function ArcadeSurvivorConfig:getLevelMonsterGroupPool(levelId)
	local result = {}
	local cfg = self:getLevelCfg(levelId, true)

	if cfg and not string.nilorempty(cfg.monsterGroupPool) then
		result = string.splitToNumber(cfg.monsterGroupPool, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getLevelAddDiamond(levelId)
	local cfg = self:getLevelCfg(levelId, true)

	return cfg and cfg.addDiamond or 0
end

function ArcadeSurvivorConfig:getLevelAddCassette(levelId)
	local cfg = self:getLevelCfg(levelId, true)

	return cfg and cfg.addCassette or 0
end

function ArcadeSurvivorConfig:getLevelIsBossLevel(levelId)
	local ruleId = self:getLevelRuleId(levelId)
	local strBossIds = self:getLevelRuleBossId(ruleId)

	if not string.nilorempty(strBossIds) then
		return true
	end
end

function ArcadeSurvivorConfig:getLevelRuleCfg(ruleId, nilError)
	local cfg = lua_arcade_survivor_level_rule.configDict[ruleId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getLevelRuleCfg error, cfg is nil, ruleId:%s", ruleId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getLevelRuleBoardSize(ruleId)
	local sizeX, sizeY = 0, 0
	local cfg = self:getLevelRuleCfg(ruleId, true)

	if cfg and not string.nilorempty(cfg.boardSize) then
		local arr = string.splitToNumber(cfg.boardSize, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeSurvivorConfig:getLevelRuleViewSize(ruleId)
	local sizeX, sizeY = 0, 0
	local cfg = self:getLevelRuleCfg(ruleId, true)

	if cfg and not string.nilorempty(cfg.viewSize) then
		local arr = string.splitToNumber(cfg.viewSize, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeSurvivorConfig:getLevelRuleTileRes(ruleId)
	local cfg = self:getLevelRuleCfg(ruleId, true)

	return cfg.tileRes
end

function ArcadeSurvivorConfig:getLevelRuleTileSize(ruleId)
	local cfg = self:getLevelRuleCfg(ruleId, true)

	return cfg.tileSize
end

function ArcadeSurvivorConfig:getLevelRuleStartPos(ruleId)
	local posX, posY = 0, 0
	local cfg = self:getLevelRuleCfg(ruleId, true)

	if cfg and not string.nilorempty(cfg.startPos) then
		local arr = string.splitToNumber(cfg.startPos, "#")

		posX = arr[1] or 0
		posY = arr[2] or 0
	end

	return posX, posY
end

function ArcadeSurvivorConfig:getLevelRuleInitMonsterCount(ruleId)
	local cfg = self:getLevelRuleCfg(ruleId, true)

	return cfg and cfg.initMonsterCount or 0
end

function ArcadeSurvivorConfig:getLevelRuleNormalWeight(ruleId, curRound)
	local weightArr = self._ruleId2NormalWeight[ruleId]

	if not weightArr then
		local cfg = self:getLevelRuleCfg(ruleId, true)

		if cfg and not string.nilorempty(cfg.normalWeight) then
			weightArr = GameUtil.splitString2(cfg.normalWeight, true, "|", "#")
			self._ruleId2NormalWeight[ruleId] = weightArr
		end
	end

	local result = 0

	if weightArr then
		curRound = curRound or 0

		for i = 1, #weightArr do
			local data = weightArr[i]

			if curRound >= data[1] then
				result = data[2]
			else
				break
			end
		end
	end

	return result
end

function ArcadeSurvivorConfig:getLevelRuleEliteWeight(ruleId, curRound)
	local weightArr = self._ruleId2EliteWeight[ruleId]

	if not weightArr then
		local cfg = self:getLevelRuleCfg(ruleId, true)

		if cfg and not string.nilorempty(cfg.eliteWeight) then
			weightArr = GameUtil.splitString2(cfg.eliteWeight, true, "|", "#")
			self._ruleId2EliteWeight[ruleId] = weightArr
		end
	end

	local result = 0

	if weightArr then
		curRound = curRound or 0

		for i = 1, #weightArr do
			local data = weightArr[i]

			if curRound >= data[1] then
				result = data[2]
			else
				break
			end
		end
	end

	return result
end

function ArcadeSurvivorConfig:getLevelRuleBossId(ruleId)
	local cfg = self:getLevelRuleCfg(ruleId, true)

	return cfg and cfg.bossIds
end

function ArcadeSurvivorConfig:getLevelRuleBossIdList(ruleId)
	local bossIdGroups
	local cfg = self:getLevelRuleCfg(ruleId, true)
	local bossIds = cfg and cfg.bossIds

	if not string.nilorempty(bossIds) then
		bossIdGroups = GameUtil.splitString2(bossIds, true, "|", "#")
	end

	local bossIdList = {}
	local bossPosList = {}

	if bossIdGroups then
		local groupCount = #bossIdGroups

		if groupCount > 0 then
			local randomIndex = math.random(groupCount)
			local groupIdList = bossIdGroups[randomIndex]

			for _, bossId in ipairs(groupIdList) do
				if bossId and bossId > 0 then
					bossIdList[#bossIdList + 1] = bossId
				end
			end

			bossPosList = self:getLevelRuleBossPos(ruleId, randomIndex)

			local bossCount = #bossIdList
			local bossPosCount = #bossPosList

			for bossIndex = 1, bossCount do
				local bossPos = bossPosList[bossIndex]

				if not bossPos or not bossPos.x or not bossPos.y then
					logError(string.format("ArcadeSurvivorConfig:getLevelRuleBossIdList error, boss pos missing, levelRuleId:%s bossId:%s bossIndex:%s bossCount:%s bossPosCount:%s", ruleId, bossIdList[bossIndex], bossIndex, bossCount, bossPosCount))
				end
			end
		end
	end

	return bossIdList, bossPosList
end

function ArcadeSurvivorConfig:getLevelRuleBossPos(ruleId, index)
	local result = {}
	local cfg = self:getLevelRuleCfg(ruleId, true)
	local bossPos = cfg and cfg.bossPos

	if not string.nilorempty(bossPos) then
		local posGroupList = string.split(bossPos, "|")
		local posGroup = index and posGroupList[index]

		if posGroup then
			local posArr = GameUtil.splitString2(posGroup, true, "#", ",")

			for _, posData in ipairs(posArr) do
				result[#result + 1] = {
					x = posData[1],
					y = posData[2]
				}
			end
		end
	end

	return result
end

function ArcadeSurvivorConfig:getLevelRuleMaxAddCount(ruleId)
	local cfg = self:getLevelRuleCfg(ruleId, true)

	return cfg and cfg.maxAddCount or 0
end

function ArcadeSurvivorConfig:getLevelRuleMaxAddEliteCount(ruleId)
	local cfg = self:getLevelRuleCfg(ruleId, true)

	return cfg and cfg.maxAddEliteCount or 0
end

function ArcadeSurvivorConfig:getLevelRuleWaveCount(ruleId)
	local cfg = self:getLevelRuleCfg(ruleId, true)

	return cfg and cfg.waveCount or 0
end

function ArcadeSurvivorConfig:getLevelRuleWaveInterval(ruleId)
	local cfg = self:getLevelRuleCfg(ruleId, true)

	return cfg and cfg.waveInterval or 0
end

function ArcadeSurvivorConfig:getLevelRuleWaveAdd(ruleId)
	local cfg = self:getLevelRuleCfg(ruleId, true)

	return cfg and cfg.waveAdd or 0
end

function ArcadeSurvivorConfig:getLevelRuleWaveExtraAddDict(ruleId)
	local result = {}
	local cfg = self:getLevelRuleCfg(ruleId, true)
	local waveExtraAdd = cfg and cfg.waveExtraAdd
	local hasWaveExtraAdd = not string.nilorempty(waveExtraAdd)

	if hasWaveExtraAdd then
		local extraAddArr = GameUtil.splitString2(waveExtraAdd, true, "|", "#")

		for i = 1, #extraAddArr do
			local data = extraAddArr[i]
			local waveIndex = data[1]
			local extraAdd = data[2]

			if waveIndex and extraAdd then
				result[waveIndex] = extraAdd
			end
		end
	end

	return result
end

function ArcadeSurvivorConfig:getEventCfg(eventId, nilError)
	local cfg = lua_arcade_survivor_event.configDict[eventId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getEventCfg error, cfg is nil, eventId:%s", eventId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getEventTitle(eventId)
	local cfg = self:getEventCfg(eventId, true)

	return cfg and cfg.title
end

function ArcadeSurvivorConfig:getEventDesc(eventId)
	local cfg = self:getEventCfg(eventId, true)

	return cfg and cfg.desc
end

function ArcadeSurvivorConfig:getEventPopupImage(eventId)
	local cfg = self:getEventCfg(eventId, true)

	return cfg and cfg.popupImage
end

function ArcadeSurvivorConfig:getEventImgOffset(eventId)
	local cfg = self:getEventCfg(eventId, true)

	return cfg and cfg.imgOffset
end

function ArcadeSurvivorConfig:getEventNeedSkillId(eventId)
	local cfg = self:getEventCfg(eventId, true)

	return cfg and cfg.needSkillId
end

function ArcadeSurvivorConfig:getEventRuleIdList(eventId)
	local result = {}
	local cfg = self:getEventCfg(eventId, true)

	if cfg and not string.nilorempty(cfg.ruleIds) then
		result = string.splitToNumber(cfg.ruleIds, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getEventSkillIdList(eventId)
	local result = {}
	local cfg = self:getEventCfg(eventId, true)

	if cfg and not string.nilorempty(cfg.skillIds) then
		result = string.splitToNumber(cfg.skillIds, "#")
	end

	return result
end

function ArcadeSurvivorConfig:getMonsterGroupCfg(groupId, nilError)
	local cfg = lua_arcade_survivor_monster_group.configDict[groupId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getMonsterGroupCfg error, cfg is nil, groupId:%s", groupId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getMonsterGroupNormalMonsterWeightList(groupId)
	local monsterIdList, weightList
	local cfg = self:getMonsterGroupCfg(groupId, true)

	if cfg then
		if not string.nilorempty(cfg.normalMonsters) then
			monsterIdList = string.splitToNumber(cfg.normalMonsters, "#")
		end

		if not string.nilorempty(cfg.normalWeight) then
			weightList = string.splitToNumber(cfg.normalWeight, "#")
		end
	end

	if monsterIdList and weightList then
		local result = {}

		for i = 1, #monsterIdList do
			result[i] = {
				monsterId = monsterIdList[i],
				weight = weightList[i] or 0
			}
		end

		return result
	end
end

function ArcadeSurvivorConfig:getMonsterGroupEliteMonsterWeightList(groupId)
	local eliteMonsterIdList, eliteWeightList
	local cfg = self:getMonsterGroupCfg(groupId, true)

	if cfg then
		if not string.nilorempty(cfg.eliteMonsters) then
			eliteMonsterIdList = string.splitToNumber(cfg.eliteMonsters, "#")
		end

		if not string.nilorempty(cfg.eliteWeight) then
			eliteWeightList = string.splitToNumber(cfg.eliteWeight, "#")
		end
	end

	if eliteMonsterIdList and eliteWeightList then
		local result = {}

		for i = 1, #eliteMonsterIdList do
			result[i] = {
				monsterId = eliteMonsterIdList[i],
				weight = eliteWeightList[i] or 0
			}
		end

		return result
	end
end

function ArcadeSurvivorConfig:getTalentLevelDict(talentId, nilError)
	local levelDict = lua_arcade_survivor_talent.configDict[talentId]

	if not levelDict and nilError then
		logError(string.format("ArcadeSurvivorConfig:getTalentLevelDict error, levelDict is nil, talentId:%s", talentId))
	end

	return levelDict
end

function ArcadeSurvivorConfig:getTalentCfg(talentId, level, nilError)
	local levelDict = self:getTalentLevelDict(talentId, nilError)
	local cfg = levelDict and levelDict[level]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getTalentCfg error, cfg is nil, talentId:%s, level:%s", talentId, level))
	end

	return cfg
end

function ArcadeSurvivorConfig:getTalentCost(talentId, level)
	local cfg = self:getTalentCfg(talentId, level, true)

	return cfg and cfg.cost or 0
end

function ArcadeSurvivorConfig:getTalentName(talentId, level)
	local cfg = self:getTalentCfg(talentId, level, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getTalentDisplayType(talentId, level)
	local cfg = self:getTalentCfg(talentId, level, true)

	return cfg and cfg.displayType
end

function ArcadeSurvivorConfig:getTalentSkill(talentId, level)
	local cfg = self:getTalentCfg(talentId, level, true)

	return cfg and cfg.skill
end

function ArcadeSurvivorConfig:getTalentFixedDesc(talentId, level)
	local cfg = self:getTalentCfg(talentId, level)

	return cfg and cfg.fixedDesc
end

function ArcadeSurvivorConfig:getTalentAddCoin(talentId, level)
	local cfg = self:getTalentCfg(talentId, level, true)

	return cfg and cfg.addCoin or 0
end

function ArcadeSurvivorConfig:getTalentAddShopRefresh(talentId, level)
	local cfg = self:getTalentCfg(talentId, level, true)

	return cfg and cfg.addShopRefresh or 0
end

function ArcadeSurvivorConfig:getTalentMaxLevel(talentId)
	local maxLevel = 0
	local levelDict = self:getTalentLevelDict(talentId, true)

	if levelDict then
		for level in pairs(levelDict) do
			if maxLevel < level then
				maxLevel = level
			end
		end
	end

	return maxLevel
end

function ArcadeSurvivorConfig:getTalentIconCfg(iconId, nilError)
	local cfg = lua_arcade_survivor_talent_icon.configDict[iconId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getTalentIconCfg error, cfg is nil, iconId:%s", iconId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getTalentIcon(iconId)
	local cfg = self:getTalentIconCfg(iconId, true)

	return cfg and cfg.icon
end

function ArcadeSurvivorConfig:getHandbookCategoryCfg(typeId, nilError)
	local cfg = lua_arcade_survivor_handbook_category.configDict[typeId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getHandbookCategoryCfg error, cfg is nil, typeId:%s", typeId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getHandbookCategoryList()
	local result = {}

	for _, cfg in ipairs(lua_arcade_survivor_handbook_category.configList) do
		result[#result + 1] = cfg.id
	end

	return result
end

function ArcadeSurvivorConfig:getHandbookCategoryTitle(typeId)
	local cfg = self:getHandbookCategoryCfg(typeId, true)

	return cfg and cfg.title or ""
end

function ArcadeSurvivorConfig:getHandbookCfg(eleId, nilError)
	local cfg = lua_arcade_survivor_handbook.configDict[eleId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getHandbookCfg error, cfg is nil, eleId:%s", eleId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getHandbookOrder(eleId)
	local cfg = self:getHandbookCfg(eleId, true)

	return cfg and cfg.order or 0
end

function ArcadeSurvivorConfig:getActionShowCfg(actionShowId, nilError)
	local cfg = lua_arcade_survivor_action_show.configDict[actionShowId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getActionShowCfg error, cfg is nil, actionShowId:%s", actionShowId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getActionShowIdList(actionShowId)
	local cfg = self:getActionShowCfg(actionShowId, true)

	return cfg and cfg.showIds
end

function ArcadeSurvivorConfig:getStateShowCfg(stateShowId, nilError)
	local cfg = lua_arcade_survivor_state_show.configDict[stateShowId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getStateShowCfg error, cfg is nil, stateShowId:%s", stateShowId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getStateShowShowId(stateShowId)
	local cfg = self:getStateShowCfg(stateShowId, true)

	return cfg and cfg.showId
end

function ArcadeSurvivorConfig:getShowCfg(showId, nilError)
	local cfg = lua_arcade_survivor_show.configDict[showId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getShowCfg error, cfg is nil, showId:%s", showId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getShowAnim(showId, direction)
	local cfg = self:getShowCfg(showId, true)
	local animName = cfg and cfg.triggerAnimation
	local directionMarker = "▩1%%s"

	if not string.nilorempty(animName) and string.find(animName, directionMarker) then
		animName = string.gsub(animName, directionMarker, direction or ArcadeSurvivorEnum.Direction.Up)
	end

	return animName
end

function ArcadeSurvivorConfig:getShowAudio(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.triggerAudio
end

function ArcadeSurvivorConfig:getShowResName(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.triggerEffects
end

function ArcadeSurvivorConfig:getShowIsPlayOnGrid(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.isPlayOnGrid
end

function ArcadeSurvivorConfig:getShowTriggerShowMode(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.triggerShowMode or 0
end

function ArcadeSurvivorConfig:getShowTriggerShowModeParam(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.triggershowModeParam
end

function ArcadeSurvivorConfig:getShowIsNearestGrid(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.isNearestGrid
end

function ArcadeSurvivorConfig:getShowSpeed(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.speed
end

function ArcadeSurvivorConfig:getShowDirection(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.direction
end

function ArcadeSurvivorConfig:getShowIsFromBorder(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.isFromBorder
end

function ArcadeSurvivorConfig:getShowRotationType(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.effectsRotationType
end

function ArcadeSurvivorConfig:getShowOffset(showId)
	local cache = self._showOffsetCache

	if not cache then
		cache = {}
		self._showOffsetCache = cache
	end

	local cached = cache[showId]

	if cached then
		return cached[1], cached[2]
	end

	local offsetX, offsetY = 0, 0
	local cfg = self:getShowCfg(showId, true)

	if cfg and not string.nilorempty(cfg.effectsOffset) then
		local arr = string.splitToNumber(cfg.effectsOffset, "#")

		offsetX = arr[1] or 0
		offsetY = arr[2] or 0
	end

	if showId then
		cache[showId] = {
			offsetX,
			offsetY
		}
	end

	return offsetX, offsetY
end

function ArcadeSurvivorConfig:getShowScale(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.effectsScale
end

function ArcadeSurvivorConfig:getShowNeedShake(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.needShake
end

function ArcadeSurvivorConfig:getShowUIEffect(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.uiEffect
end

function ArcadeSurvivorConfig:getShowDuration(showId)
	local cfg = self:getShowCfg(showId, true)

	return cfg and cfg.duration
end

function ArcadeSurvivorConfig:getTalkCfg(groupId, nilError)
	local cfg = lua_arcade_survivor_talk.configDict[groupId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getTalkCfg error, cfg is nil, groupId:%s", groupId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getTalkCondition(groupId)
	local cfg = self:getTalkCfg(groupId, true)

	return cfg and cfg.condition
end

function ArcadeSurvivorConfig:getTalkWeight(groupId)
	local cfg = self:getTalkCfg(groupId, true)

	return cfg and cfg.weight or 0
end

function ArcadeSurvivorConfig:getTalkStepDict(groupId, nilError)
	local stepDict = lua_arcade_survivor_talk_step.configDict[groupId]

	if not stepDict and nilError then
		logError(string.format("ArcadeSurvivorConfig:getTalkStepDict error, stepDict is nil, groupId:%s", groupId))
	end

	return stepDict
end

function ArcadeSurvivorConfig:getTalkStepCfg(groupId, step, nilError)
	local stepDict = self:getTalkStepDict(groupId, nilError)
	local cfg = stepDict and stepDict[step]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getTalkStepCfg error, cfg is nil, groupId:%s, step:%s", groupId, step))
	end

	return cfg
end

function ArcadeSurvivorConfig:getDialogGroupCfg(groupId, nilError)
	local cfg = lua_arcade_survivor_dialog_group.configDict[groupId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getDialogGroupCfg error, cfg is nil, groupId:%s", groupId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getDialogCondition(groupId)
	local cfg = self:getDialogGroupCfg(groupId, true)

	return cfg and cfg.condition
end

function ArcadeSurvivorConfig:getDialogParam(groupId)
	local cfg = self:getDialogGroupCfg(groupId, true)

	return cfg and cfg.param
end

function ArcadeSurvivorConfig:getDialogStepDict(groupId, nilError)
	local stepDict = lua_arcade_survivor_dialog_step.configDict[groupId]

	if not stepDict and nilError then
		logError(string.format("ArcadeSurvivorConfig:getDialogStepDict error, stepDict is nil, groupId:%s", groupId))
	end

	return stepDict
end

function ArcadeSurvivorConfig:getDialogStepCfg(groupId, step, nilError)
	local stepDict = self:getDialogStepDict(groupId, nilError)
	local cfg = stepDict and stepDict[step]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getDialogStepCfg error, cfg is nil, groupId:%s, step:%s", groupId, step))
	end

	return cfg
end

function ArcadeSurvivorConfig:getDialogStepContent(groupId, step)
	local cfg = self:getDialogStepCfg(groupId, step, true)

	return cfg and cfg.content
end

function ArcadeSurvivorConfig:getDialogStepName(groupId, step)
	local cfg = self:getDialogStepCfg(groupId, step, true)

	return cfg and cfg.name
end

function ArcadeSurvivorConfig:getDialogStepAvatar(groupId, step)
	local cfg = self:getDialogStepCfg(groupId, step, true)

	return cfg and cfg.avatar
end

function ArcadeSurvivorConfig:getBehaviorNodeDict(treeId, nilError)
	local nodeDict = lua_arcade_survivor_behavior.configDict[treeId]

	if not nodeDict and nilError then
		logError(string.format("ArcadeSurvivorConfig:getBehaviorNodeDict error, nodeDict is nil, treeId:%s", treeId))
	end

	return nodeDict
end

function ArcadeSurvivorConfig:getBehaviorNodeCfg(treeId, nodeId, nilError)
	local nodeDict = self:getBehaviorNodeDict(treeId, nilError)
	local cfg = nodeDict and nodeDict[nodeId]

	if not cfg and nilError then
		logError(string.format("ArcadeSurvivorConfig:getBehaviorNodeCfg error, cfg is nil, treeId:%s nodeId:%s", treeId, nodeId))
	end

	return cfg
end

function ArcadeSurvivorConfig:getBehaviorNodeType(treeId, nodeId)
	local cfg = self:getBehaviorNodeCfg(treeId, nodeId, true)

	return cfg and cfg.nodeType
end

function ArcadeSurvivorConfig:getBehaviorNodeParams(treeId, nodeId)
	local cfg = self:getBehaviorNodeCfg(treeId, nodeId, true)

	return cfg and cfg.params
end

function ArcadeSurvivorConfig:getBehaviorChildIdList(treeId, nodeId)
	local cache = self._behaviorChildIdListCache

	if not cache then
		cache = {}
		self._behaviorChildIdListCache = cache
	end

	local treeCache = cache[treeId]

	if treeCache then
		local childIds = treeCache[nodeId]

		if childIds then
			return childIds
		end
	end

	local result = {}
	local cfg = self:getBehaviorNodeCfg(treeId, nodeId, true)

	if cfg and not string.nilorempty(cfg.childIds) then
		result = string.splitToNumber(cfg.childIds, ",")
	end

	if treeId and nodeId then
		if not treeCache then
			treeCache = {}
			cache[treeId] = treeCache
		end

		treeCache[nodeId] = result
	end

	return result
end

ArcadeSurvivorConfig.instance = ArcadeSurvivorConfig.New()

return ArcadeSurvivorConfig
