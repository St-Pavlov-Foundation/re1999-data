-- chunkname: @modules/logic/gm/view/GMSubViewArcadeSurvivor.lua

module("modules.logic.gm.view.GMSubViewArcadeSurvivor", package.seeall)

local GMSubViewArcadeSurvivor = class("GMSubViewArcadeSurvivor", GMSubViewBase)

function GMSubViewArcadeSurvivor:ctor()
	self.tabName = "街机幸存者"
end

function GMSubViewArcadeSurvivor:addEvents()
	return
end

function GMSubViewArcadeSurvivor:removeEvents()
	return
end

function GMSubViewArcadeSurvivor:initViewContent()
	if self._isInit then
		return
	end

	self._isInit = true

	self:_initL1()
	self:_initL2()
	self:_initL3()
	self:_initL4()
	self:addSplitLine()
	self:_initL6()
	self:_initL7()
	self:addSplitLine()
	self:_initL5()
end

function GMSubViewArcadeSurvivor:_isLockClick()
	if self._nextUnLockTime and self._nextUnLockTime > Time.time then
		GameFacade.showToast(ToastEnum.IconId, "点击太快了")

		return true
	end

	self._nextUnLockTime = Time.time + 0.2

	return false
end

function GMSubViewArcadeSurvivor:getLogEntityMO()
	if not self._selectedEntityType then
		GameFacade.showToast(ToastEnum.IconId, "请选择单位类型")

		return
	end

	local uidText = self._logEntityUidText:GetText()
	local uid = tonumber(uidText)

	if self._selectedEntityType == ArcadeSurvivorEnum.EntityType.Character then
		uid = ArcadeSurvivorGameEnum.Const.CharacterUid
	end

	if not uid then
		GameFacade.showToast(ToastEnum.IconId, "请输入uid")

		return
	end

	local mo = ArcadeSurvivorGameModel.instance:getEntityMO(self._selectedEntityType, uid)

	if not mo then
		GameFacade.showToast(ToastEnum.IconId, string.format("单位不存在\n类型：%s\nuid：%s", self._selectedEntityType, uidText))
	end

	return mo
end

function GMSubViewArcadeSurvivor:_initL1()
	local LStr = "L1"

	self:addLabel(LStr, "怪物Id")

	self._addMonsterText = self:addInputText(LStr, nil, "怪物id#x#y")

	self:addButton(LStr, "添加怪物", self._addMonsterId, self)
	self:addLabel(LStr, "藏品Id")

	self._actCollectionId = self:addInputText(LStr, nil, "藏品Id")

	self:addButton(LStr, "添加藏品", self._addCollectionId, self)
end

function GMSubViewArcadeSurvivor:_addMonsterId()
	local text = self._addMonsterText:GetText()
	local textArr = string.splitToNumber(text, "#")
	local monsterId = textArr[1]

	if monsterId == 0 then
		return
	end

	local cfg = ArcadeSurvivorConfig.instance:getMonsterCfg(monsterId)

	if not cfg then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在怪物id:%s", monsterId))

		return
	end

	local gridX = textArr[2]
	local gridY = textArr[3]
	local sizeX, sizeY = ArcadeSurvivorConfig.instance:getMonsterSize(monsterId)
	local mo = ArcadeSurvivorGameController.instance:addEntityOne(ArcadeSurvivorEnum.EntityType.Monster, monsterId, gridX, gridY, sizeX, sizeY)

	if mo then
		GameFacade.showToast(ToastEnum.IconId, string.format("添加成功[%s-%s](%s,%s)", cfg.name, monsterId, gridX, gridY))
	else
		GameFacade.showToast(ToastEnum.IconId, string.format("添加失败[%s-%s](%s,%s)", cfg.name, monsterId, gridX, gridY))
	end
end

function GMSubViewArcadeSurvivor:_addCollectionId()
	local collectionId = tonumber(self._actCollectionId:GetText())
	local cfg = ArcadeSurvivorConfig.instance:getCollectionCfg(collectionId)

	if not cfg then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在藏品id:[%s]", collectionId))

		return
	end

	local result = ArcadeSurvivorGameController.instance:gainCollection(collectionId)

	if result then
		GameFacade.showToast(ToastEnum.IconId, string.format("成功添加[%s-%s]", collectionId, cfg.name))
	else
		GameFacade.showToast(ToastEnum.IconId, string.format("失败"))
	end
end

function GMSubViewArcadeSurvivor:_initL2()
	local LStr = "L2"

	self:addLabel(LStr, "技能Id")

	self._skillIdInputText = self:addInputText(LStr, nil, "技能Id")

	self:addButton(LStr, "使用技能", self._onClickUseSkillOk, self)
	self:addLabel(LStr, "跳转到关卡")

	self._levelInputText = self:addInputText(LStr, nil, "阶段序号#关卡序号")

	self:addButton(LStr, "跳转", self._jump2Level, self)
end

function GMSubViewArcadeSurvivor:_onClickUseSkillOk()
	if self:_isLockClick() then
		return
	end

	local skillId = tonumber(self._skillIdInputText:GetText())

	if not skillId or skillId <= 0 then
		GameFacade.showToast(ToastEnum.IconId, "请输入技能ID")

		return
	end

	local skillCfg = ArcadeSurvivorConfig.instance:getSkillCfg(skillId)

	if not skillCfg then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在技能id:%s", skillId))

		return
	end

	local target = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not target or not target:getIsAlive() then
		GameFacade.showToast(ToastEnum.IconId, "玩家不存在或已死亡")

		return
	end

	target:addSkill(skillId)

	local result = ArcadeSurvivorGameSkillController.instance:castSkill(target:getEntityType(), target:getUid(), skillId)

	GameFacade.showToast(ToastEnum.IconId, result and string.format("使用技能成功:%s", skillId) or string.format("使用技能失败:%s", skillId))
end

function GMSubViewArcadeSurvivor:_jump2Level()
	if self:_isLockClick() then
		return
	end

	local strTargetLevel = self._levelInputText:GetText()
	local arr = string.splitToNumber(strTargetLevel, "#")
	local stageIndex, levelIndex = tonumber(arr[1]), tonumber(arr[2])
	local difficulty = ArcadeSurvivorGameModel.instance:getDifficulty()
	local stageId = ArcadeSurvivorConfig.instance:getDifficultyStageId(difficulty, stageIndex)

	if not stageId then
		GameFacade.showToast(ToastEnum.IconId, string.format("难度%s不存在序号为%s的阶段", difficulty, stageIndex))

		return
	end

	local levelId = ArcadeSurvivorConfig.instance:getStageLevelId(stageId, levelIndex)

	if not levelId then
		GameFacade.showToast(ToastEnum.IconId, string.format("阶段%s不存在序号为%s的关卡", stageId, levelIndex))

		return
	end

	ArcadeSurvivorGameController.instance:pauseGame(ArcadeSurvivorGameEnum.StopSource.GameTransfer)
	ArcadeSurvivorGameController.instance:removeAllEntity()
	ArcadeSurvivorGameModel.instance:setCurStageIndex(stageIndex)
	ArcadeSurvivorGameModel.instance:setCurLevelIndex(levelIndex)
	ArcadeSurvivorGameController.instance:saveGame()
	ArcadeSurvivorGameController.instance:_enterStage(self._afterEnterStage, self)
end

function GMSubViewArcadeSurvivor:_afterEnterStage()
	ArcadeSurvivorGameController.instance:_enterLevel()
	ArcadeSurvivorGameController.instance:_gameTransferFinish()
	self:closeThis()
end

function GMSubViewArcadeSurvivor:_initL3()
	local LStr = "L3"

	self:addLabel(LStr, "技能效果")

	self._skillHitInputText = self:addInputText(LStr, nil, "效果配置")

	self:addButton(LStr, "确定", self._onClickSkillHitOk, self)
	self:addButton(LStr, "完成当前关", self._onClickFinishLevel, self)
	self:addButton(LStr, "完成整个难度", self._onClickFinishDifficulty, self)
	self:addButton(LStr, "打开商店", self._onClickOpenShop, self)
end

function GMSubViewArcadeSurvivor:_onClickSkillHitOk()
	if self:_isLockClick() then
		return
	end

	local effectId = tonumber(self._skillHitInputText:GetText())

	if not effectId or effectId <= 0 then
		GameFacade.showToast(ToastEnum.IconId, "请输入效果ID")

		return
	end

	local effectCfg = ArcadeSurvivorConfig.instance:getSkillEffectCfg(effectId)

	if not effectCfg then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在效果id:%s", effectId))

		return
	end

	local target = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not target or not target:getIsAlive() then
		GameFacade.showToast(ToastEnum.IconId, "玩家不存在或已死亡")

		return
	end

	local trigger = ArcadeSurvivorGameTrigger.New(nil, effectId, 1)
	local effectList = trigger:getEffectList()

	for _, effect in ipairs(effectList) do
		local delayTurn = effect:getDelayTurn()

		if delayTurn and delayTurn > 0 then
			GameFacade.showToast(ToastEnum.IconId, "延迟效果请通过技能使用")

			return
		end
	end

	local context = ArcadeSurvivorGameTriggerContext.New(ArcadeSurvivorGameEnum.TriggerPoint.None, nil, target)
	local result = trigger:triggerDirectly(context)

	GameFacade.showToast(ToastEnum.IconId, result and string.format("执行效果成功:%s", effectId) or string.format("执行效果失败:%s", effectId))
end

function GMSubViewArcadeSurvivor:_onClickFinishLevel()
	ArcadeSurvivorGameController.instance:_finishLevel()
	self:closeThis()
end

function GMSubViewArcadeSurvivor:_onClickFinishDifficulty()
	if self:_isLockClick() then
		return
	end

	local model = ArcadeSurvivorGameModel.instance

	if not model:getCharacterMO() then
		GameFacade.showToast(ToastEnum.IconId, "请先进入局内")

		return
	end

	if model:getGameIsEnd() then
		GameFacade.showToast(ToastEnum.IconId, "本局已结束")

		return
	end

	local difficulty = model:getDifficulty()
	local stageCount = ArcadeSurvivorConfig.instance:getDifficultyStageCount(difficulty)
	local lastStageId = ArcadeSurvivorConfig.instance:getDifficultyStageId(difficulty, stageCount)
	local levelCount = lastStageId and ArcadeSurvivorConfig.instance:getStageLevelCount(lastStageId) or 0

	if levelCount <= 0 then
		GameFacade.showToast(ToastEnum.IconId, string.format("难度%s没有可完成的关卡", difficulty))

		return
	end

	model:setCurStageIndex(stageCount)
	model:setCurLevelIndex(levelCount)
	ArcadeSurvivorGameController.instance:_finishLevel()
	self:closeThis()
end

function GMSubViewArcadeSurvivor:_onClickOpenShop()
	local shopId = ArcadeSurvivorGameModel.instance:getShopId()

	ArcadeSurvivorGameController.instance:openShopView(shopId, nil, true)
	self:closeThis()
end

local CURRENCY_PREFS_KEY = "GMSubViewArcadeSurvivorSelectedCurrencyIndex"

function GMSubViewArcadeSurvivor:_initL4()
	local LStr = "L4"
	local strList = {
		"选择货币"
	}

	self._currencyList = {}

	local configList = lua_arcade_survivor_currency.configList

	for _, cfg in ipairs(configList) do
		self._currencyList[#self._currencyList + 1] = cfg.id
		strList[#strList + 1] = cfg.name
	end

	local dropDown = self:addDropDown(LStr, "添加货币", strList, self._onCurrencySelectChange, self, {
		tempH = 450,
		total_w = 650,
		drop_w = 415
	})
	local index = PlayerPrefsHelper.getNumber(CURRENCY_PREFS_KEY, 0)

	dropDown:SetValue(index)

	self._changeCurrencyCountText = self:addInputText(LStr, nil, "数量")

	self:addButton(LStr, "确定", self._onClickCurrencyChangeOk, self)
end

function GMSubViewArcadeSurvivor:_onCurrencySelectChange(index)
	PlayerPrefsHelper.setNumber(CURRENCY_PREFS_KEY, index)

	self._selectedCurrency = self._currencyList[index]
end

function GMSubViewArcadeSurvivor:_onClickCurrencyChangeOk()
	if not self._selectedCurrency then
		GameFacade.showToast(ToastEnum.IconId, "未选择货币")

		return
	end

	local changeCount = tonumber(self._changeCurrencyCountText:GetText())

	if not changeCount or changeCount == 0 then
		GameFacade.showToast(ToastEnum.IconId, "未填写变更数量")

		return
	end

	local isLockClick = self:_isLockClick()

	if isLockClick then
		return
	end

	ArcadeSurvivorGameController.instance:changeCurrencyCount(self._selectedCurrency, changeCount)

	local name = ArcadeSurvivorConfig.instance:getCurrencyName(self._selectedCurrency)

	GameFacade.showToast(ToastEnum.IconId, string.format("%s数量更改：%s", name, changeCount))
end

function GMSubViewArcadeSurvivor:_initL5()
	local LStr1 = "L5_1"

	self:addLabel(LStr1, "随从")

	self._allyIdInputText = self:addInputText(LStr1, nil, "随从id#x#y")

	self:addButton(LStr1, "生成", self._onClickCreateAllyOk, self)
	self:addLabel(LStr1, "地块")

	self._floorIdInputText = self:addInputText(LStr1, nil, "地块id")

	self:addButton(LStr1, "生成", self._onClickCreateFloorOk, self)
	self:addButton(LStr1, "清除", self._onClickClearFloorOk, self)

	local LStr2 = "L5_2"

	self:addButton(LStr2, "清除局外缓存", self._onClickClearOutSidePrefs, self)
end

function GMSubViewArcadeSurvivor:_onClickCreateAllyOk()
	if self:_isLockClick() then
		return
	end

	local text = self._allyIdInputText:GetText()
	local textArr = string.splitToNumber(text, "#")
	local allyId = textArr[1]

	if not allyId or allyId <= 0 then
		GameFacade.showToast(ToastEnum.IconId, "请输入随从id")

		return
	end

	local cfg = ArcadeSurvivorConfig.instance:getAllyCfg(allyId)

	if not cfg then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在随从id:%s", textArr[1]))

		return
	end

	local gridX = textArr[2]
	local gridY = textArr[3]
	local summonerMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not summonerMO or not summonerMO:getIsAlive() then
		GameFacade.showToast(ToastEnum.IconId, "玩家不存在或已死亡")

		return
	end

	local sizeX, sizeY = ArcadeSurvivorConfig.instance:getAllySize(allyId)
	local mo = ArcadeSurvivorGameController.instance:addEntityOne(ArcadeSurvivorEnum.EntityType.Ally, allyId, gridX, gridY, sizeX, sizeY)

	if mo then
		mo:setSummon(summonerMO)
		GameFacade.showToast(ToastEnum.IconId, string.format("添加成功[%s-%s](%s,%s)", cfg.name, allyId, gridX, gridY))
	else
		GameFacade.showToast(ToastEnum.IconId, string.format("添加失败[%s-%s](%s,%s)", cfg.name, allyId, gridX, gridY))
	end
end

function GMSubViewArcadeSurvivor:_getInputFloorId()
	local floorIdStr = self._floorIdInputText:GetText()

	if string.nilorempty(floorIdStr) then
		GameFacade.showToast(ToastEnum.IconId, "请输入地块id")

		return
	end

	local floorId = tonumber(floorIdStr)

	if not floorId or floorId <= 0 then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在地块Id:%s", floorIdStr))

		return
	end

	local floorCfg = ArcadeSurvivorConfig.instance:getFloorCfg(floorId)

	if not floorCfg then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在地块Id:%s", floorId))

		return
	end

	return floorId
end

function GMSubViewArcadeSurvivor:_onClickCreateFloorOk()
	if self:_isLockClick() then
		return
	end

	local floorId = self:_getInputFloorId()

	if not floorId then
		return
	end

	local sizeX, sizeY = ArcadeSurvivorConfig.instance:getFloorSize(floorId)

	if sizeX <= 0 or sizeY <= 0 then
		GameFacade.showToast(ToastEnum.IconId, string.format("地块尺寸无效:%s", floorId))

		return
	end

	local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()

	if mapSizeX <= 0 or mapSizeY <= 0 then
		GameFacade.showToast(ToastEnum.IconId, "棋盘未初始化")

		return
	end

	local centerGridX = math.floor((mapSizeX + 1) * 0.5)
	local centerGridY = math.floor((mapSizeY + 1) * 0.5)
	local startGridX = math.max(1, centerGridX - 2)
	local startGridY = math.max(1, centerGridY - 2)
	local endGridX = math.min(mapSizeX, startGridX + 4)
	local endGridY = math.min(mapSizeY, startGridY + 3)
	local successCount = 0

	for gridX = startGridX, endGridX do
		for gridY = startGridY, endGridY do
			local isReplaced = ArcadeSurvivorGameController.instance:replaceFloor(floorId, gridX, gridY)

			if isReplaced then
				successCount = successCount + 1
			end
		end
	end

	GameFacade.showToast(ToastEnum.IconId, string.format("生成地块[%s]成功:%s", floorId, successCount))
end

function GMSubViewArcadeSurvivor:_onClickClearFloorOk()
	if self:_isLockClick() then
		return
	end

	local floorId = self:_getInputFloorId()

	if not floorId then
		return
	end

	local entityType = ArcadeSurvivorEnum.EntityType.Floor
	local entityMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(entityType)
	local floorMOList = {}

	if entityMOList then
		tabletool.addValues(floorMOList, entityMOList)
	end

	local removeCount = 0

	for _, floorMO in ipairs(floorMOList) do
		if floorMO and floorMO:getId() == floorId then
			ArcadeSurvivorGameController.instance:removeEntityOne(entityType, floorMO:getUid())

			removeCount = removeCount + 1
		end
	end

	GameFacade.showToast(ToastEnum.IconId, string.format("清除地块[%s]成功:%s", floorId, removeCount))
end

function GMSubViewArcadeSurvivor:_onClickClearOutSidePrefs()
	if self:_isLockClick() then
		return
	end

	self:clearPlayerPrefs()
	GameFacade.showToast(ToastEnum.IconId, "局外本地缓存已清除")
end

function GMSubViewArcadeSurvivor:clearPlayerPrefs()
	local characterMOList = ArcadeSurvivorHandBookModel.instance:getMOListByType(ArcadeSurvivorHallEnum.HandBookType.Character)

	for _, mo in ipairs(characterMOList) do
		local developHeroNewKey = ArcadeSurvivorOutSideModel.instance:getPlayerPrefsKey(ArcadeSurvivorHallEnum.PlayerPrefsKey.DevelopHeroNew, mo:getId())
		local developHeroPlayUnlockAnimKey = ArcadeSurvivorOutSideModel.instance:getPlayerPrefsKey(ArcadeSurvivorHallEnum.PlayerPrefsKey.DevelopHeroPlayUnlockAnim, mo:getId())

		GameUtil.deleteKey(developHeroNewKey)
		GameUtil.deleteKey(developHeroPlayUnlockAnimKey)
	end

	local hallUnitIdList = ArcadeSurvivorConfig.instance:getHallUnitIdList()

	for _, unitId in ipairs(hallUnitIdList) do
		local hallNPCFirstKey = ArcadeSurvivorOutSideModel.instance:getPlayerPrefsKey(ArcadeSurvivorHallEnum.PlayerPrefsKey.HallNPCFirst, unitId)

		GameUtil.deleteKey(hallNPCFirstKey)
	end

	local difficultyIdList = ArcadeSurvivorConfig.instance:getDifficultyIdList()

	for _, difficultyId in ipairs(difficultyIdList) do
		local difficultyFinishAnimKey = ArcadeSurvivorOutSideModel.instance:getPlayerPrefsKey(ArcadeSurvivorHallEnum.PlayerPrefsKey.DifficultyFinishAnim, difficultyId)

		GameUtil.deleteKey(difficultyFinishAnimKey)
	end
end

local ENTITY_TYPE_PREFS_KEY = "GMArcadeSurvivorSelectedEntityTypeIndex"
local ATTR_PREFS_KEY = "GMArcadeSurvivorSelectedAttrIndex"

function GMSubViewArcadeSurvivor:_initL6()
	local LStr1 = "L6_1"
	local LStr2 = "L6_2"

	self:_initL6Entity(LStr1)
	self:_initL6ChangeAttr(LStr2)
end

function GMSubViewArcadeSurvivor:_initL6Entity(LStr)
	local strList = {
		"单位类型"
	}
	local typeEnum = ArcadeSurvivorEnum.EntityType
	local typeDataList = {
		{
			name = "角色",
			entityType = typeEnum.Character
		},
		{
			name = "怪物",
			entityType = typeEnum.Monster
		},
		{
			name = "随从",
			entityType = typeEnum.Ally
		},
		{
			name = "地板",
			entityType = typeEnum.Floor
		}
	}

	self._entityTypeList = {}

	for _, typeData in ipairs(typeDataList) do
		self._entityTypeList[#self._entityTypeList + 1] = typeData.entityType
		strList[#strList + 1] = typeData.name
	end

	local dropDown = self:addDropDown(LStr, "选择单位", strList, self._onSelectedEntityTypeChange, self, {
		tempH = 450,
		total_w = 550,
		drop_w = 380
	})
	local index = PlayerPrefsHelper.getNumber(ENTITY_TYPE_PREFS_KEY, 0)

	if index < 0 or index > #typeDataList then
		index = 0
	end

	dropDown:SetValue(index or 0)

	self._selectedEntityType = self._entityTypeList[index]
	self._logEntityUidText = self:addInputText(LStr, nil, "uid")
end

function GMSubViewArcadeSurvivor:_onSelectedEntityTypeChange(index)
	PlayerPrefsHelper.setNumber(ENTITY_TYPE_PREFS_KEY, index)

	self._selectedEntityType = self._entityTypeList[index]
end

function GMSubViewArcadeSurvivor:_initL6ChangeAttr(LStr)
	local attrIdList = {}
	local attrStrList = {
		"属性"
	}

	for _, attrId in pairs(ArcadeSurvivorEnum.Attribute) do
		if ArcadeSurvivorConfig.instance:getAttributeCfg(attrId) then
			attrIdList[#attrIdList + 1] = attrId
		end
	end

	table.sort(attrIdList)

	self._attrIdList = {}

	for i, attrId in ipairs(attrIdList) do
		local attrName = ArcadeSurvivorConfig.instance:getAttributeName(attrId)

		self._attrIdList[#self._attrIdList + 1] = attrId
		attrStrList[#attrStrList + 1] = string.format("%s-%s", attrId, attrName)
	end

	self._attrDropDown = self:addDropDown(LStr, "选择属性", attrStrList, self._onSelectedAttrChange, self, {
		tempH = 450,
		total_w = 550,
		drop_w = 380
	})

	local attrIndex = PlayerPrefsHelper.getNumber(ATTR_PREFS_KEY, 0)

	if attrIndex < 0 or attrIndex > #attrIdList then
		attrIndex = 0
	end

	self._attrDropDown:SetValue(attrIndex)

	self._selectedAttrId = self._attrIdList[attrIndex]
	self._attrValueText = self:addInputText(LStr, nil, "属性变化值")

	self:addButton(LStr, "修改属性", self._onClickModifyAttr, self)
end

function GMSubViewArcadeSurvivor:_onSelectedAttrChange(index)
	PlayerPrefsHelper.setNumber(ATTR_PREFS_KEY, index)

	self._selectedAttrId = self._attrIdList[index]
end

function GMSubViewArcadeSurvivor:_onClickModifyAttr()
	if self:_isLockClick() then
		return
	end

	local mo = self:getLogEntityMO()

	if not mo then
		return
	end

	local attrId = self._selectedAttrId

	if not attrId then
		GameFacade.showToast(ToastEnum.IconId, "请选择属性")

		return
	end

	local valueText = self._attrValueText:GetText()
	local value = tonumber(valueText)

	if not value or value == 0 then
		GameFacade.showToast(ToastEnum.IconId, "请输入属性变化值")

		return
	end

	ArcadeSurvivorGameController.instance:changeEntityAttr(self._selectedEntityType, mo:getUid(), attrId, value)
	GameFacade.showToast(ToastEnum.IconId, string.format("修改属性:%s-%s", attrId, ArcadeSurvivorConfig.instance:getAttributeName(attrId)))
end

function GMSubViewArcadeSurvivor:_initL7()
	local LStr = "L7"

	self:_initL7AddBUFF(LStr)
	self:addButton(LStr, "输出Buff", self._onClickLogBuff, self)
	self:addButton(LStr, "输出技能", self._onClickLogSkill, self)
	self:addButton(LStr, "输出属性", self._onClickLogAttr, self)
end

function GMSubViewArcadeSurvivor:_initL7AddBUFF(LStr)
	self._addBuffIdText = self:addInputText(LStr, nil, "buffId", nil, nil, {
		w = 250
	})

	self:addButton(LStr, "添加Buff", self._onClickAddBuff, self)
end

function GMSubViewArcadeSurvivor:_onClickAddBuff()
	if self:_isLockClick() then
		return
	end

	local mo = self:getLogEntityMO()

	if not mo then
		return
	end

	local buffIdText = self._addBuffIdText:GetText()
	local buffId = tonumber(buffIdText)

	if not buffId then
		GameFacade.showToast(ToastEnum.IconId, "请输入buffId")

		return
	end

	local cfg = ArcadeSurvivorConfig.instance:getBuffCfg(buffId)

	if not cfg then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在buffId:%s", buffIdText))

		return
	end

	ArcadeSurvivorGameController.instance:addBuff2Entity(self._selectedEntityType, mo:getUid(), buffId, 1)
	GameFacade.showToast(ToastEnum.IconId, string.format("添加Buff:%s-%s", buffId, ArcadeSurvivorConfig.instance:getBuffName(buffId)))
end

function GMSubViewArcadeSurvivor:_onClickLogBuff()
	local mo = self:getLogEntityMO()

	if not mo then
		return
	end

	local log = string.format("============================%s-%s-BUFF============================", self._selectedEntityType, self._logEntityUidText:GetText())
	local buffSet = mo:getBuffSet()
	local buffList = buffSet and buffSet:getBuffList()

	if buffList then
		for _, buff in ipairs(buffList) do
			local buffId = buff:getId()

			log = log .. string.format("\nId:<color=green>%s</color>    名称:<color=green>%s</color>    层数:<color=green>%s</color>", buffId, ArcadeSurvivorConfig.instance:getBuffName(buffId), buff:getStackCount())
		end
	end

	logError(log)
end

function GMSubViewArcadeSurvivor:_onClickLogSkill()
	local mo = self:getLogEntityMO()

	if not mo then
		return
	end

	local log = string.format("============================%s-%s-技能============================", self._selectedEntityType, self._logEntityUidText:GetText())
	local skillSet = mo:getSkillSet()

	if skillSet then
		local sourceCountMapList = skillSet:getSkillSourceCountMapListInSet()

		if sourceCountMapList then
			table.sort(sourceCountMapList, function(left, right)
				return left.skillId < right.skillId
			end)

			for _, sourceCountMap in ipairs(sourceCountMapList) do
				local skillId = sourceCountMap.skillId
				local skillName = ArcadeSurvivorConfig.instance:getSkillName(skillId)

				log = log .. string.format("\nId:<color=green>%s</color>    名称:<color=green>%s</color>", skillId, skillName)
			end
		end
	end

	logError(log)
end

function GMSubViewArcadeSurvivor:_onClickLogAttr()
	local mo = self:getLogEntityMO()

	if not mo then
		return
	end

	local attrList = {}
	local maxAttrPrefixLen = self:_getAttrList(ArcadeSurvivorEnum.Attribute, attrList)
	local log = string.format("============================%s-%s-属性============================", self._selectedEntityType, self._logEntityUidText:GetText())

	log = log .. self:_getAttrLog(attrList, maxAttrPrefixLen, mo.getAttrValue, mo)

	logError(log)
end

function GMSubViewArcadeSurvivor:_getAttrList(attrDict, refAttrList)
	local maxAttrPrefixLen = 0

	for _, attrId in pairs(attrDict) do
		if ArcadeSurvivorConfig.instance:getAttributeCfg(attrId) then
			local name = ArcadeSurvivorConfig.instance:getAttributeName(attrId)
			local strPrefix = string.format("\n%s-%s", attrId, name)
			local prefixLen = LuaUtil.getStrLen(strPrefix)

			refAttrList[#refAttrList + 1] = {
				id = attrId,
				prefix = strPrefix,
				prefixLen = prefixLen
			}

			if maxAttrPrefixLen < prefixLen then
				maxAttrPrefixLen = prefixLen
			end
		end
	end

	table.sort(refAttrList, function(a, b)
		return a.id < b.id
	end)

	return maxAttrPrefixLen
end

function GMSubViewArcadeSurvivor:_getAttrLog(attrList, maxPrefixLen, getValFunc, getValFuncObj)
	local log = ""

	for _, attr in ipairs(attrList) do
		local val = getValFunc(getValFuncObj, attr.id)
		local color = "green"

		if not val then
			color = "red"
		end

		local strVal = string.format(" <color=%s>%s</color>", color, tostring(val))

		log = log .. attr.prefix .. string.rep(" ", (maxPrefixLen - attr.prefixLen) * 2) .. strVal
	end

	return log
end

return GMSubViewArcadeSurvivor
