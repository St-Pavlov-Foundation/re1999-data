﻿-- chunkname: @modules/logic/gm/view/GMSubViewNewFightView.lua

module("modules.logic.gm.view.GMSubViewNewFightView", package.seeall)

local GMSubViewNewFightView = class("GMSubViewNewFightView", GMSubViewBase)

function GMSubViewNewFightView:ctor()
	self.tabName = "战斗·新"
end

function GMSubViewNewFightView:_onToggleValueChanged(toggleId, isOn)
	GMSubViewNewFightView.super._onToggleValueChanged(self, toggleId, isOn)

	self.scrollRect = gohelper.findChildComponent(self._subViewGo, "viewport", gohelper.Type_ScrollRect)

	ZProj.UGUIHelper.RebuildLayout(self.scrollRect:GetComponent(gohelper.Type_RectTransform))

	self.scrollRect.verticalNormalizedPosition = 0.38659590482712
end

function GMSubViewNewFightView:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewNewFightView:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewNewFightView:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 0

	self:addLineIndex()

	self.gmInput = self:addInputText(self:getLineGroup(), "", "GM 命令 ...", nil, nil, {
		w = 500
	})
	self.btnSend = self:addButton(self:getLineGroup(), "发送", self.onClickSendBtn, self)

	self:addTitleSplitLine("战前GM")
	self:addLineIndex()

	self.battleInput = self:addInputText(self:getLineGroup(), "", "怪物组/战斗id")
	self.btnEnterFightByMonsterGroupId = self:addButton(self:getLineGroup(), "进战斗怪物组", self.onClickBtnEnterFightByMonsterGroupId, self)
	self.btnEnterFightByBattleId = self:addButton(self:getLineGroup(), "进战斗战斗ID", self.onClickBtnEnterFightByBattleId, self)

	self:addLineIndex()

	self.btnSimulateBattle = self:addButton(self:getLineGroup(), "战场模拟", self.onClickSimulateBattle, self)
	self.btnSkillEditor = self:addButton(self:getLineGroup(), "技能编辑器", self.onClickSkillEditor, self)

	self:addLineIndex()
	self:initFightFloatCo()

	self.fightFloatDrop = self:addDropDown(self:getLineGroup(), "战斗飘字:", self.floatPrefabList)

	local prefabPath = GMController.instance:getFightFloatPath()
	local index = 1

	for _index, path in ipairs(self.floatPrefabList) do
		if path == prefabPath then
			index = _index

			break
		end
	end

	self.fightFloatDrop:SetValue(index - 1)

	self.btnReplaceFloatPrefab = self:addButton(self:getLineGroup(), "替换战斗飘字", self.onClickReplaceFloatPrefab, self)

	self:addTitleSplitLine("战中GM")
	self:addLineIndex()
	self:addFightNumToggle()
	self:addShowFightUIToggle()

	self.btnLockLifeMySide = self:addButton(self:getLineGroup(), "我方锁血", self.onClickLockLifeMySide, self)
	self.btnLockLifeEnemySide = self:addButton(self:getLineGroup(), "敌方锁血", self.onClickLockLifeEnemySide, self)
	self.btnLogSkin = self:addButton(self:getLineGroup(), "打印皮肤id", self.onClickLogSkinBtn, self)

	self:addLineIndex()

	self.btnAddHurtMySide = self:addButton(self:getLineGroup(), "我方伤害*10", self.onClickAddHurtMySide, self)
	self.btnAddHurtEnemySide = self:addButton(self:getLineGroup(), "敌方伤害*10", self.onClickAddHurtEnemySide, self)
	self.btnReduceDamageMySide = self:addButton(self:getLineGroup(), "我方承伤/10", self.onClickReduceDamageMySide, self)
	self.btnReduceDamageEnemySide = self:addButton(self:getLineGroup(), "敌方承伤/10", self.onClickReduceDamageEnemySide, self)

	self:addLineIndex()

	self.costInput = self:addInputText(self:getLineGroup(), "", "增加cost...")
	self.btnAddCost = self:addButton(self:getLineGroup(), "增加cost", self.onClickAddCost, self)
	self.btnAddExPointMySide = self:addButton(self:getLineGroup(), "获取我方激情", self.onClickAddExPointMySide, self)
	self.btnAddExPointEnemySide = self:addButton(self:getLineGroup(), "获取敌方激情", self.onClickAddExPointEnemySide, self)

	self:addLineIndex()

	self.btnChangeCard = self:addButton(self:getLineGroup(), "修改手牌", self.onClickChangeCard, self)
	self.btnFightGm = self:addButton(self:getLineGroup(), "战中外挂", self.onClickFightGm, self)

	self:addButton(self:getLineGroup(), "我方牌库", self.onClickMyCardDeck, self)
	self:addButton(self:getLineGroup(), "敌方牌库", self.onClickEnemyCardDeck, self)
	self:getEntityNameList()
	self:getMountList()
	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "特效预览：", {
		fsize = 30,
		w = 100
	})

	self.effectPath = self:addInputText(self:getLineGroup(), "", "特效资源名...")
	self.entityDrop = self:addDropDown(self:getLineGroup(), "挂载对象:", self.entityNameList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	self.mountDrop = self:addDropDown(self:getLineGroup(), "挂载节点:", self.mountList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	self.btnMount = self:addButton(self:getLineGroup(), "挂载", self.onClickBtnMount, self)

	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "播放timeline：", {
		fsize = 30,
		w = 100
	})

	self.skillIdInput = self:addInputText(self:getLineGroup(), "", "技能id")
	self.playTimelineEntityDrop = self:addDropDown(self:getLineGroup(), "技能释放者:", self.entityNameList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	self.targetEnumDrop = self:addDropDown(self:getLineGroup(), "群体or单体:", {
		"单体",
		"群体"
	}, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	self.btnPlayTimeline = self:addButton(self:getLineGroup(), "播放timeline", self.onClickBtnPlayTimeline, self)

	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "播放指定动作：", {
		fsize = 30,
		w = 100
	})

	self.actionNameInput = self:addInputText(self:getLineGroup(), "", "动作名称")
	self.actionEntityDrop = self:addDropDown(self:getLineGroup(), "动作播放者:", self.entityNameList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	self.btnPlayAction = self:addButton(self:getLineGroup(), "播放动作", self.onClickBtnPlayAction, self)
	self.btnActionReset = self:addButton(self:getLineGroup(), "动作复原", self.onClickBtnActionReset, self)

	self:addTitleSplitLine("奥术飞弹GM")
	self:addLineIndex()

	self.emitterList, self.missileList, self.explosionList = self:getASFDUnitList()
	self.emitterDrop = self:addDropDown(self:getLineGroup(), "发射器特效配置:", self.emitterList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	self.missileDrop = self:addDropDown(self:getLineGroup(), "飞弹特效配置:", self.missileList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	self.explosionDrop = self:addDropDown(self:getLineGroup(), "爆点特效配置:", self.explosionList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})

	local emitterId = GMController.instance.emitterId and tostring(GMController.instance.emitterId) or self.emitterList[1]
	local missileId = GMController.instance.missileId and tostring(GMController.instance.missileId) or self.missileList[1]
	local explosionId = GMController.instance.explosionId and tostring(GMController.instance.explosionId) or self.explosionList[1]

	self.emitterDrop:SetValue((tabletool.indexOf(self.emitterList, emitterId) or 1) - 1)
	self.missileDrop:SetValue((tabletool.indexOf(self.missileList, missileId) or 1) - 1)
	self.explosionDrop:SetValue((tabletool.indexOf(self.explosionList, explosionId) or 1) - 1)
	self:addLineIndex()

	self.countASFDInput = self:addInputText(self:getLineGroup(), "", "奥术飞弹数量...", nil, nil, {
		fsize = 30,
		w = 200
	})
	self.optionStrList = {
		"我方",
		"敌方"
	}
	self.optionValueList = {
		FightEnum.EntitySide.MySide,
		FightEnum.EntitySide.EnemySide
	}
	self.sideASFDDrop = self:addDropDown(self:getLineGroup(), "奥术飞弹发射方:", self.optionStrList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	self.toEntityASFDInput = self:addInputText(self:getLineGroup(), "", "奥术飞弹目标uid...")
	self.btnSendASFD = self:addButton(self:getLineGroup(), "发射", self.onClickSendASFDBtn, self)

	self:addTitleSplitLine("战中打印")
	self:addLineIndex()

	self.btnEnableFightLog = self:addButton(self:getLineGroup(), "开启战斗打印", self.onClickEnableFightLog, self)
	self.btnLogAttr = self:addButton(self:getLineGroup(), "打印当前属性", self.onClickLogAttr, self)
	self.btnLogBaseAttr = self:addButton(self:getLineGroup(), "打印基础属性", self.onClickLogBaseAttr, self)
	self.btnLogLife = self:addButton(self:getLineGroup(), "打印生命百分比", self.onClickLogLife, self)
end

function GMSubViewNewFightView:initFightFloatCo()
	self.floatPrefabList = {}

	for _, config in ipairs(lua_fight_float_effect.configList) do
		table.insert(self.floatPrefabList, config.prefabPath)
	end
end

function GMSubViewNewFightView:getASFDUnitList()
	local emitterList = {}
	local missileList = {}
	local explosionList = {}

	for _, co in ipairs(lua_fight_asfd.configList) do
		local unit = co.unit

		if unit == FightEnum.ASFDUnit.Emitter then
			table.insert(emitterList, tostring(co.id))
		elseif unit == FightEnum.ASFDUnit.Missile then
			table.insert(missileList, tostring(co.id))
		elseif unit == FightEnum.ASFDUnit.Explosion then
			table.insert(explosionList, tostring(co.id))
		end
	end

	return emitterList, missileList, explosionList
end

function GMSubViewNewFightView:getEntityNameList()
	self.entityNameList = {}
	self.entityList = {}

	FightDataHelper.entityMgr:getAllEntityList(self.entityList)

	for _, entityMo in ipairs(self.entityList) do
		local co = entityMo:getCO()
		local name = co and co.name

		name = name or entityMo.id

		table.insert(self.entityNameList, name)
	end
end

function GMSubViewNewFightView:getMountList()
	self.mountList = {
		ModuleEnum.SpineHangPointRoot
	}

	for _, mount in pairs(ModuleEnum.SpineHangPoint) do
		table.insert(self.mountList, mount)
	end
end

function GMSubViewNewFightView:addFightNumToggle()
	self.showFightNumToggle = self:addToggle(self:getLineGroup(), "显示战斗数值", self.onFightNumToggleValueChange, self)
	self.showFightNumToggle.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1
end

function GMSubViewNewFightView:addShowFightUIToggle()
	self.showFightUIToggle = self:addToggle(self:getLineGroup(), "显示战斗UI", self.onFightUIToggleValueChange, self)
	self.showFightUIToggle.isOn = true
end

function GMSubViewNewFightView:onClickMyCardDeck()
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.MySide)
end

function GMSubViewNewFightView:onClickEnemyCardDeck()
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.EnemySide)
end

function GMSubViewNewFightView:onClickSendBtn()
	local text = self.gmInput:GetText()

	if string.nilorempty(text) then
		return
	end

	GMRpc.instance:sendGMRequest(text)
end

function GMSubViewNewFightView:onClickBtnEnterFightByMonsterGroupId()
	local inputText = self.battleInput:GetText()

	if not string.nilorempty(inputText) then
		local temp = string.splitToNumber(inputText, "#")

		if #temp > 0 then
			PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, inputText)
			HeroGroupModel.instance:setParam(nil, nil, nil)

			local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

			if not curGroupMO then
				logError("current HeroGroupMO is nil")
				GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

				return
			end

			local main, mainCount = curGroupMO:getMainList()
			local sub, subCount = curGroupMO:getSubList()
			local equips = curGroupMO:getAllHeroEquips()

			self:closeThis()

			local fightParam = FightParam.New()

			fightParam.monsterGroupIds = temp
			fightParam.isTestFight = true

			fightParam:setSceneLevel(10601)
			fightParam:setMySide(curGroupMO.clothId, main, sub, equips)
			FightModel.instance:setFightParam(fightParam)
			FightController.instance:sendTestFight(fightParam)

			return
		end
	end
end

function GMSubViewNewFightView:onClickBtnEnterFightByBattleId()
	local inputText = self.battleInput:GetText()
	local battleId = tonumber(inputText)
	local battleCO = battleId and lua_battle.configDict[battleId]

	if not battleCO then
		local str = string.format("没有找到战斗id ：%s 对应的配置", battleId)

		logError(str)
		ToastController.instance:showToastWithString(str)

		return
	end

	local episodeCo

	for _, v in ipairs(lua_episode.configList) do
		if v.battleId == battleId or v.firstBattleId == battleId then
			episodeCo = v

			break
		end
	end

	if not episodeCo then
		logError("没有找到战斗id对应的关卡id")
		ToastController.instance:showToastWithString("没有找到战斗id对应的关卡id")

		return
	end

	local fightParam = FightController.instance:setFightParamByBattleId(battleId)

	HeroGroupModel.instance:setParam(battleId, nil, nil)

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()
	local equips = curGroupMO:getAllHeroEquips()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, inputText)
	self:closeThis()

	fightParam.episodeId = episodeCo.id
	FightResultModel.instance.episodeId = episodeCo.id

	DungeonModel.instance:SetSendChapterEpisodeId(episodeCo.chapterId, episodeCo.id)
	fightParam:setMySide(curGroupMO.clothId, main, sub, equips)
	FightController.instance:sendTestFightId(fightParam)
end

function GMSubViewNewFightView:onClickSimulateBattle()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightSimulateView)
end

function GMSubViewNewFightView:onClickSkillEditor()
	SkillEditorMgr.instance:start()
end

function GMSubViewNewFightView:onFightNumToggleValueChange()
	local isOn = self.showFightNumToggle.isOn

	FightFloatMgr.instance:setCanShowFightNumUI(isOn)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FightShowFightNum, isOn and 1 or 0)
end

function GMSubViewNewFightView:onFightUIToggleValueChange()
	local list = GMFightShowState.getList()

	for _, mo in ipairs(list) do
		GMFightShowState.setStatus(mo.valueKey, true)
	end

	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function GMSubViewNewFightView:onClickLockLifeMySide()
	GMRpc.instance:sendGMRequest("fight lockLife 0")
end

function GMSubViewNewFightView:onClickLockLifeEnemySide()
	GMRpc.instance:sendGMRequest("fight lockLife 1")
end

function GMSubViewNewFightView:onClickAddHurtMySide()
	GMRpc.instance:sendGMRequest("fight addHurt 0")
end

function GMSubViewNewFightView:onClickAddHurtEnemySide()
	GMRpc.instance:sendGMRequest("fight addHurt 1")
end

function GMSubViewNewFightView:onClickReduceDamageMySide()
	GMRpc.instance:sendGMRequest("fight reduceDamage 0")
end

function GMSubViewNewFightView:onClickReduceDamageEnemySide()
	GMRpc.instance:sendGMRequest("fight reduceDamage 1")
end

function GMSubViewNewFightView:onClickAddCost()
	local cost = self.costInput:GetText()

	if string.nilorempty(cost) then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("fight addPower %s 0", cost))
end

function GMSubViewNewFightView:onClickAddExPointMySide()
	GMRpc.instance:sendGMRequest("fight addExpoint 5 0")
end

function GMSubViewNewFightView:onClickAddExPointEnemySide()
	GMRpc.instance:sendGMRequest("fight addExpoint 5 1")
end

function GMSubViewNewFightView:onClickChangeCard()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		self:closeThis()
		ViewMgr.instance:openView(ViewName.GMResetCardsView)
	else
		GameFacade.showToast(ToastEnum.IconId, "not in fight")
	end
end

function GMSubViewNewFightView:onClickFightGm()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightEntityView)
end

function GMSubViewNewFightView:onClickEnableFightLog()
	GMRpc.instance:sendGMRequest("fight log 2")
end

function GMSubViewNewFightView:onClickLogAttr()
	GMRpc.instance:sendGMRequest("fight printAttrWithCompute")
end

function GMSubViewNewFightView:onClickLogBaseAttr()
	GMRpc.instance:sendGMRequest("fight printAttr")
end

function GMSubViewNewFightView:onClickLogLife()
	GMRpc.instance:sendGMRequest("fight printLife")
end

function GMSubViewNewFightView:onClickSendASFDBtn()
	local count = tonumber(self.countASFDInput:GetText()) or 1
	local selectIndex = self.sideASFDDrop:GetValue() + 1
	local side = self.optionValueList[selectIndex]
	local toEntityId = self.toEntityASFDInput:GetText()
	local toEntity = FightHelper.getEntity(toEntityId)

	if not toEntity then
		local entityMoList

		if side == FightEnum.TeamType.MySide then
			entityMoList = FightDataHelper.entityMgr:getEnemyNormalList()
		else
			entityMoList = FightDataHelper.entityMgr:getMyNormalList()
		end

		toEntityId = entityMoList and entityMoList[1] and entityMoList[1].id
		toEntity = FightHelper.getEntity(toEntityId)

		if not toEntityId then
			ToastController.instance:showToastWithString("没有找到奥术飞弹目标实体")

			return
		end
	end

	local emitterIndex = self.emitterDrop:GetValue() + 1
	local missileIndex = self.missileDrop:GetValue() + 1
	local explosionIndex = self.explosionDrop:GetValue() + 1

	GMController.instance:setRecordASFDCo(self.emitterList[emitterIndex], self.missileList[missileIndex], self.explosionList[explosionIndex])
	GMController.instance:startASFDFlow(count, side, toEntityId)
	self:closeThis()
end

function GMSubViewNewFightView:onClickBtnMount()
	local effectPath = self.effectPath:GetText()
	local entityIndex = self.entityDrop:GetValue() + 1
	local mountIndex = self.mountDrop:GetValue() + 1

	if string.nilorempty(effectPath) then
		ToastController.instance:showToastWithString("特效资源名 不能为空 ！")

		return
	end

	local entityMo = self.entityList[entityIndex]
	local entity = entityMo and FightHelper.getEntity(entityMo.id)

	if not entity then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	local mount = self.mountList[mountIndex]
	local effectWrap = entity.effect:addHangEffect(effectPath, mount)

	if effectWrap then
		effectWrap:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
	end

	self:closeThis()
end

function GMSubViewNewFightView:onClickBtnPlayTimeline()
	local skillId = self.skillIdInput:GetText()

	skillId = tonumber(skillId) or 0

	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		ToastController.instance:showToastWithString("技能不存在 ！")

		return
	end

	local skillTimeline = skillCo.timeline

	if string.nilorempty(skillTimeline) then
		ToastController.instance:showToastWithString("技能不存在timeline ！")

		return
	end

	local attackIndex = self.playTimelineEntityDrop:GetValue() + 1
	local entityMo = self.entityList[attackIndex]
	local entity = entityMo and FightHelper.getEntity(entityMo.id)

	if not entity then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	local targetEnumDropIndex = self.targetEnumDrop:GetValue()
	local isSingle = targetEnumDropIndex == 0
	local attackSide = entityMo.side
	local enemySide = attackSide == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	local enemyList = FightDataHelper.entityMgr:getNormalList(enemySide)
	local fightStepData = FightStepData.New()

	fightStepData.actType = 1
	fightStepData.fromId = entityMo.id
	fightStepData.toId = enemyList[1].uid
	fightStepData.actId = skillId
	fightStepData.actEffect = {}

	self:buildDamageEffect(isSingle, enemyList, fightStepData.actEffect)
	entity.skill:playSkill(skillId, fightStepData)
	self:closeThis()
end

function GMSubViewNewFightView:buildDamageEffect(isSingle, enemyList, effectList)
	for i = 1, #enemyList do
		if i == 1 or not isSingle then
			table.insert(effectList, self:createDamageActEffect(enemyList[i].uid, math.random(1, 100)))
		end
	end
end

function GMSubViewNewFightView:createDamageActEffect(targetId, effectNum)
	local actEffectData = FightActEffectData.New()

	actEffectData.targetId = targetId
	actEffectData.effectType = FightEnum.EffectType.DAMAGE
	actEffectData.effectNum = effectNum

	return actEffectData
end

function GMSubViewNewFightView:onClickReplaceFloatPrefab()
	local index = self.fightFloatDrop:GetValue() + 1
	local prefabPath = self.floatPrefabList[index]

	GMController.instance:setFightFloatPath(prefabPath)
	GMController.instance:replaceGetFloatPathFunc()
end

function GMSubViewNewFightView:onClickBtnPlayAction()
	local actionName = self.actionNameInput:GetText()

	if string.nilorempty(actionName) then
		return
	end

	local attackIndex = self.actionEntityDrop:GetValue() + 1
	local entityMo = self.entityList[attackIndex]
	local entity = entityMo and FightHelper.getEntity(entityMo.id)

	if not entity then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	entity.spine:play(actionName, nil, true)
	self:closeThis()
end

function GMSubViewNewFightView:onClickBtnActionReset()
	local attackIndex = self.actionEntityDrop:GetValue() + 1
	local entityMo = self.entityList[attackIndex]
	local entity = entityMo and FightHelper.getEntity(entityMo.id)

	if not entity then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	entity:resetAnimState()
	self:closeThis()
end

function GMSubViewNewFightView:onClickLogSkinBtn()
	for _, entityMo in ipairs(self.entityList) do
		local entity = FightHelper.getEntity(entityMo.id)
		local co = entityMo:getCO()
		local name = co and co.name

		name = name or entityMo.id

		local str = string.format("entityId : %s, entityName : %s, skinId : %s, goName : %s", entityMo.id, name, entityMo.skin, entity.go.name)

		logError(str)
	end
end

return GMSubViewNewFightView
