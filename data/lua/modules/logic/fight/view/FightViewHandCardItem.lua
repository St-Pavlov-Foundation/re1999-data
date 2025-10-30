﻿-- chunkname: @modules/logic/fight/view/FightViewHandCardItem.lua

module("modules.logic.fight.view.FightViewHandCardItem", package.seeall)

local FightViewHandCardItem = class("FightViewHandCardItem", LuaCompBase)

function FightViewHandCardItem:ctor(subViewInst)
	self._subViewInst = subViewInst
end

function FightViewHandCardItem:init(go)
	self.go = go
	self.tr = go.transform
	self._cardItemAni = gohelper.onceAddComponent(self.go, typeof(UnityEngine.Animator))
	self._forAnimGO = gohelper.findChild(go, "foranim")

	local path = self._subViewInst.viewContainer:getSetting().otherRes[1]

	self._innerGO = self._subViewInst:getResInst(path, self._forAnimGO, "card")

	gohelper.setAsFirstSibling(self._innerGO)

	self._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._innerGO, FightViewCardItem, FightEnum.CardShowType.HandCard)
	self._cardAni = self._innerGO:GetComponent(typeof(UnityEngine.Animator))
	self._cardAni.enabled = false
	self._innerTr = self._innerGO.transform
	self._universalGO = gohelper.findChild(self._forAnimGO, "universal")
	self._spEffectGO = gohelper.findChild(self._forAnimGO, "spEffect")
	self.goRouge2Treasure = gohelper.findChild(self._forAnimGO, "rouge2_treasure")

	gohelper.setActive(self.goRouge2Treasure, false)
	self._cardItem:setRouge2TreasureRoot(self.goRouge2Treasure)

	self._foranim = self._forAnimGO:GetComponent(typeof(UnityEngine.Animator))
	self._itemWidth = recthelper.getWidth(self.tr)
	self._oldParentX = -999999
	self._click = SLFramework.UGUI.UIClickListener.Get(self.go)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self.go)
	self._long = SLFramework.UGUI.UILongPressListener.Get(self.go)
	self._longPressArr = {
		0.5,
		99999
	}
	self._isDraging = false
	self._isLongPress = false

	self:setUniversal(false)

	self._keyOffset = 8
	self._keyMaxTipsNum = 9
	self._restrainComp = MonoHelper.addLuaComOnceToGo(self.go, FightViewHandCardItemRestrain, self)
	self._lockComp = MonoHelper.addLuaComOnceToGo(self.go, FightViewHandCardItemLock, self)
	self._loader = self._loader or LoaderComponent.New()
	self._lockGO = gohelper.findChild(self.go, "foranim/lock")

	if FightCardDataHelper.getCardSkin() == 672801 then
		FightViewHandCardItem.replaceLockBg(self._lockGO)
	end

	self._cardConvertEffect = gohelper.findChild(self.go, "foranim/cardConvertEffect")

	self:setASFDActive(true)
end

function FightViewHandCardItem:addEventListeners()
	if not FightDataHelper.stateMgr.isReplay then
		self._click:AddClickListener(self._onClickThis, self)
		self._drag:AddDragBeginListener(self._onDragBegin, self)
		self._drag:AddDragListener(self._onDragThis, self)
		self._drag:AddDragEndListener(self._onDragEnd, self)
		self._long:SetLongPressTime(self._longPressArr)
		self._long:AddLongPressListener(self._onLongPress, self)

		if PCInputController.instance:getIsUse() then
			self._long:AddHoverListener(self._onHover, self)
		end
	end

	self:addEventCb(FightController.instance, FightEvent.SelectSkillTarget, self._onSelectSkillTarget, self)
	self:addEventCb(FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self:addEventCb(FightController.instance, FightEvent.DragHandCardBegin, self._onDragHandCardBegin, self)
	self:addEventCb(FightController.instance, FightEvent.DragHandCardEnd, self._onDragHandCardEnd, self)
	self:addEventCb(FightController.instance, FightEvent.SimulateDragHandCardBegin, self._simulateDragHandCardBegin, self)
	self:addEventCb(FightController.instance, FightEvent.SimulateDragHandCard, self._simulateDragHandCard, self)
	self:addEventCb(FightController.instance, FightEvent.SimulateDragHandCardEnd, self._simulateDragHandCardEnd, self)
	self:addEventCb(FightController.instance, FightEvent.SimulatePlayHandCard, self._simulatePlayHandCard, self)
	self:addEventCb(FightController.instance, FightEvent.StartReplay, self._checkStartReplay, self)
	self:addEventCb(FightController.instance, FightEvent.RefreshOneHandCard, self._onRefreshOneHandCard, self)
	self:addEventCb(FightController.instance, FightEvent.CardLevelChangeDone, self._onCardLevelChangeDone, self)
	self:addEventCb(FightController.instance, FightEvent.GMForceRefreshNameUIBuff, self._onGMForceRefreshNameUIBuff, self)
	self:addEventCb(FightController.instance, FightEvent.SeasonSelectChangeHeroTarget, self._onSeasonSelectChangeHeroTarget, self)
	self:addEventCb(FightController.instance, FightEvent.ExitOperateState, self._onExitOperateState, self)
	self:addEventCb(FightController.instance, FightEvent.CancelOperation, self._onCancelOperation, self)
	self:addEventCb(FightController.instance, FightEvent.ASFD_AllocateCardEnergyDone, self._allocateEnergyDone, self)
	self:addEventCb(FightController.instance, FightEvent.PlayCardOver, self._showASFD, self)
end

function FightViewHandCardItem:removeEventListeners()
	self._click:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self._long:RemoveLongPressListener()

	if PCInputController.instance:getIsUse() then
		self._long:RemoveHoverListener()
	end

	self:removeEventCb(FightController.instance, FightEvent.SelectSkillTarget, self._onSelectSkillTarget, self)
	self:removeEventCb(FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self:removeEventCb(FightController.instance, FightEvent.DragHandCardBegin, self._onDragHandCardBegin, self)
	self:removeEventCb(FightController.instance, FightEvent.DragHandCardEnd, self._onDragHandCardEnd, self)
	self:removeEventCb(FightController.instance, FightEvent.SimulateDragHandCardBegin, self._simulateDragHandCardBegin, self)
	self:removeEventCb(FightController.instance, FightEvent.SimulateDragHandCard, self._simulateDragHandCard, self)
	self:removeEventCb(FightController.instance, FightEvent.SimulateDragHandCardEnd, self._simulateDragHandCardEnd, self)
	self:removeEventCb(FightController.instance, FightEvent.SimulatePlayHandCard, self._simulatePlayHandCard, self)
	self:removeEventCb(FightController.instance, FightEvent.StartReplay, self._checkStartReplay, self)
	self:removeEventCb(FightController.instance, FightEvent.RefreshOneHandCard, self._onRefreshOneHandCard, self)
	self:removeEventCb(FightController.instance, FightEvent.CardLevelChangeDone, self._onCardLevelChangeDone, self)
	self:removeEventCb(FightController.instance, FightEvent.GMForceRefreshNameUIBuff, self._onGMForceRefreshNameUIBuff, self)
	self:removeEventCb(FightController.instance, FightEvent.SeasonSelectChangeHeroTarget, self._onSeasonSelectChangeHeroTarget, self)
	self:removeEventCb(FightController.instance, FightEvent.ExitOperateState, self._onExitOperateState, self)
	self:removeEventCb(FightController.instance, FightEvent.CancelOperation, self._onCancelOperation, self)
	self:removeEventCb(FightController.instance, FightEvent.ASFD_AllocateCardEnergyDone, self._allocateEnergyDone, self)
	self:removeEventCb(FightController.instance, FightEvent.PlayCardOver, self._showASFD, self)
	TaskDispatcher.cancelTask(self._delayDisableAnim, self)
end

function FightViewHandCardItem:_allocateEnergyDone()
	if self._cardItem then
		self._cardItem:_allocateEnergyDone()
	end
end

function FightViewHandCardItem:changeEnergy()
	if self._cardItem then
		self._cardItem:changeEnergy()
	end
end

function FightViewHandCardItem:_showASFD()
	self:setASFDActive(true)
end

function FightViewHandCardItem:_onCancelOperation()
	self:setASFDActive(true)
end

function FightViewHandCardItem:_onSeasonSelectChangeHeroTarget(entityId)
	if self.cardInfoMO and self.cardInfoMO.uid == entityId then
		self._seasonChangeHeroSelecting = true

		self._cardItemAni:Play("preview")
	elseif self._seasonChangeHeroSelecting then
		self._cardItemAni:Play("idle")

		self._seasonChangeHeroSelecting = false
	end
end

function FightViewHandCardItem:_onExitOperateState()
	if self._seasonChangeHeroSelecting then
		self._cardItemAni:Play("idle")

		self._seasonChangeHeroSelecting = false
	end
end

function FightViewHandCardItem:setASFDActive(active)
	if self._cardItem then
		self._cardItem:setASFDActive(active)
	end
end

function FightViewHandCardItem:playASFDAnim(animName)
	if self._cardItem then
		self._cardItem:playASFDAnim(animName)
	end
end

function FightViewHandCardItem:onStart()
	self:_checkStartReplay()
end

function FightViewHandCardItem:_checkStartReplay()
	if FightDataHelper.stateMgr.isReplay then
		self._click:RemoveClickListener()
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
		self._long:RemoveLongPressListener()
		self._long:RemoveHoverListener()
	end
end

function FightViewHandCardItem:setUniversal(active)
	gohelper.setActive(self._universalGO, active)
end

function FightViewHandCardItem:refreshPreDelete(needPreDelete)
	if needPreDelete then
		-- block empty
	end
end

function FightViewHandCardItem:updateItem(index, cardInfoMO)
	self.index = index or self.index

	if cardInfoMO then
		self.cardInfoMO = cardInfoMO
		cardInfoMO.clientData.custom_handCardIndex = self.index

		local skillCO = lua_skill.configDict[cardInfoMO.skillId]

		if not skillCO then
			logError("skill not exist: " .. cardInfoMO.skillId)

			return
		end

		self._cardItem:updateItem(cardInfoMO.uid, cardInfoMO.skillId, cardInfoMO)

		self._isDraging = false
		self._isLongPress = false
		self._skillId = cardInfoMO.skillId

		self:setUniversal(false)
		self:_updateSpEffect()
		self._restrainComp:updateItem(cardInfoMO)
		self._lockComp:updateItem(cardInfoMO)
		self._cardItem:updateResistanceByCardInfo(cardInfoMO)
	end

	self:_hideEffect()
	self:_refreshBlueStar()
	self:showKeytips()
	self:showCardHeat()
end

function FightViewHandCardItem:showCardHeat()
	self._cardItem:showCardHeat()
end

function FightViewHandCardItem:showKeytips()
	local go = gohelper.findChild(self.go, "foranim/card/#go_pcbtn")

	gohelper.setActive(go, true)

	local cardCount = #FightDataHelper.handCardMgr.handCard

	if cardCount == 0 then
		return
	end

	local pos = cardCount - self.index + 1

	if pos >= 1 and pos <= cardCount and pos <= self._keyMaxTipsNum then
		if not self._pcTips then
			self._pcTips = PCInputController.instance:showkeyTips(go, PCInputModel.Activity.battle, pos + self._keyOffset)
		else
			self._pcTips:Refresh(PCInputModel.Activity.battle, pos + self._keyOffset)
		end

		if self._pcTips == nil then
			return
		end

		if self._cardItem and self.cardInfoMO and FightCardDataHelper.isBigSkill(self.cardInfoMO.skillId) then
			recthelper.setAnchorY(self._pcTips._go.transform, 200)
		else
			recthelper.setAnchorY(self._pcTips._go.transform, 150)
		end

		self._pcTips:Show(true)
	elseif self._pcTips then
		self._pcTips:Show(false)
	end
end

function FightViewHandCardItem:refreshCardMO(index, cardInfoMO)
	self.index = index
	self.cardInfoMO = cardInfoMO
end

function FightViewHandCardItem:onLongPressEnd()
	self._isLongPress = false
end

function FightViewHandCardItem:getCardItem()
	return self._cardItem
end

function FightViewHandCardItem:_onBuffUpdate(entityId, effectType, buffId)
	if not self.cardInfoMO then
		return
	end

	if entityId ~= self.cardInfoMO.uid then
		return
	end

	self:_updateSpEffect()

	if effectType ~= FightEnum.EffectType.BUFFUPDATE and FightConfig.instance:hasBuffFeature(buffId, FightEnum.BuffFeature.SkillLevelJudgeAdd) then
		self:_refreshBlueStar()
	end
end

function FightViewHandCardItem:_refreshBlueStar()
	local entityId = self.cardInfoMO and self.cardInfoMO.uid
	local skillId = self.cardInfoMO and self.cardInfoMO.skillId
	local skillCardLv = entityId and skillId and FightCardDataHelper.getSkillLv(entityId, skillId)

	self._cardItem:showBlueStar(skillCardLv)
end

function FightViewHandCardItem:_onDragHandCardBegin(index, position, cardInfoMO)
	if not self.cardInfoMO then
		return
	end

	if not FightEnum.UniversalCard[cardInfoMO.skillId] or cardInfoMO == self.cardInfoMO then
		return
	end

	local dragLevel = FightCardDataHelper.getSkillLv(cardInfoMO.uid, cardInfoMO.skillId)
	local thisLevel = FightCardDataHelper.getSkillLv(self.cardInfoMO.uid, self.cardInfoMO.skillId)

	if thisLevel <= dragLevel then
		return
	end

	local universalMaskGO = gohelper.findChild(self._forAnimGO, "universalMask")

	gohelper.setActive(universalMaskGO, true)

	for i = 1, 4 do
		local innerGO = gohelper.findChild(universalMaskGO, "jinengpai_" .. i)

		gohelper.setActive(innerGO, i == thisLevel)
	end
end

function FightViewHandCardItem:_onDragHandCardEnd()
	local universalMaskGO = gohelper.findChild(self._forAnimGO, "universalMask")

	gohelper.setActive(universalMaskGO, false)
end

function FightViewHandCardItem:_onSelectSkillTarget()
	self:_updateSpEffect()
end

function FightViewHandCardItem:_updateSpEffect()
	if gohelper.isNil(self._spEffectGO) then
		return
	end

	if not self.cardInfoMO then
		return
	end

	local skillCO = lua_skill.configDict[self._skillId]

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		gohelper.setActive(self._spEffectGO, false)

		return
	end

	local active = false
	local ingoreDic = {}

	for i, v in ipairs(FightStrUtil.instance:getSplitToNumberCache(skillCO.clientIgnoreCondition, "#")) do
		ingoreDic[v] = true
	end

	for i = 1, FightEnum.MaxBehavior do
		if not ingoreDic[i] then
			local condition = skillCO["condition" .. i]
			local conditionTarget = skillCO["conditionTarget" .. i]
			local behavior = skillCO["behavior" .. i]
			local result = self:_checkConditionSpEffect(condition, conditionTarget)

			result = result or self:_checkSkillRateUpBehavior(behavior, conditionTarget)

			if result then
				active = true

				break
			end
		end
	end

	if active ~= self._spEffectGO.activeSelf then
		gohelper.setActive(self._spEffectGO, active)
	end
end

function FightViewHandCardItem:_getConditionTargetUid(conditionTarget)
	if conditionTarget == "103" then
		return self.cardInfoMO.uid
	elseif conditionTarget == "0" then
		return FightDataHelper.operationDataMgr.curSelectEntityId
	elseif conditionTarget == "202" then
		for _, mo in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
			return mo.id
		end
	end
end

function FightViewHandCardItem:_getConditionTargetUids(conditionTarget)
	if conditionTarget == "103" then
		return {
			self.cardInfoMO.uid
		}
	elseif conditionTarget == "0" then
		return {
			FightDataHelper.operationDataMgr.curSelectEntityId
		}
	elseif conditionTarget == "202" then
		local temp = {}

		for _, mo in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
			table.insert(temp, mo.id)
		end

		return temp
	end

	return {}
end

function FightViewHandCardItem:_checkConditionSpEffect(condition, conditionTarget)
	if string.nilorempty(condition) then
		return
	end

	local arr = FightStrUtil.instance:getSplitCache(condition, "&")

	if #arr > 1 then
		local count = 0

		for i, v in ipairs(arr) do
			if self:_checkSingleCondition(v, conditionTarget) then
				count = count + 1
			end
		end

		if count == #arr then
			return true
		end
	else
		arr = FightStrUtil.instance:getSplitCache(condition, "|")

		if #arr > 1 then
			for i, v in ipairs(arr) do
				if self:_checkSingleCondition(v, conditionTarget) then
					return true
				end
			end
		elseif self:_checkSingleCondition(condition, conditionTarget) then
			return true
		end
	end
end

function FightViewHandCardItem:_checkSingleCondition(sin_condition, conditionTarget)
	local sp = FightStrUtil.instance:getSplitCache(sin_condition, "#")
	local typeId = tonumber(sp[1])
	local conditionCO = lua_skill_behavior_condition.configDict[typeId]

	if not conditionCO or string.nilorempty(conditionCO.type) then
		return false
	end

	local targetUid = self:_getConditionTargetUid(conditionTarget)

	if not targetUid or tostring(targetUid) == "0" then
		return false
	end

	local targetEntityMO = FightDataHelper.entityMgr:getById(targetUid)

	if not targetEntityMO then
		return false
	end

	if conditionCO.type == "LifeLess" then
		local targetPercent = tonumber(sp[2]) * 0.001
		local hpPercent = targetEntityMO.currentHp / targetEntityMO.attrMO.hp

		return hpPercent < targetPercent
	elseif conditionCO.type == "LifeMore" then
		local targetPercent = tonumber(sp[2]) * 0.001
		local hpPercent = targetEntityMO.currentHp / targetEntityMO.attrMO.hp

		return targetPercent < hpPercent
	elseif conditionCO.type == "HasBuffId" then
		local has_buff_type_dic = self:_getSimulateBuffTypeDic(targetEntityMO)

		for i = 2, #sp do
			local buff_type_id = tonumber(sp[i])

			if buff_type_id and has_buff_type_dic[buff_type_id] then
				return true
			end
		end
	elseif conditionCO.type == "HasBuff" then
		local has_buff_type_dic = self:_getSimulateBuffTypeDic(targetEntityMO)
		local has_type = {}

		for k, v in pairs(has_buff_type_dic) do
			local buff_tpye_config = lua_skill_bufftype.configDict[k]

			if buff_tpye_config then
				has_type[buff_tpye_config.type] = true
			end
		end

		for i = 2, #sp do
			local tar_type = tonumber(sp[i])

			if tar_type and has_type[tar_type] then
				return true
			end
		end
	elseif conditionCO.type == "HasBuffGroup" then
		local has_buff_type_dic = self:_getSimulateBuffTypeDic(targetEntityMO)
		local has_group = {}

		for k, v in pairs(has_buff_type_dic) do
			local buff_tpye_config = lua_skill_bufftype.configDict[k]

			if buff_tpye_config then
				has_group[buff_tpye_config.group] = true
			end
		end

		for i = 2, #sp do
			local tar_group = tonumber(sp[i])

			if tar_group and has_group[tar_group] then
				return true
			end
		end
	elseif conditionCO.type == "NoBuffId" then
		local has_buff_type_dic = self:_getBuffTypeDic(targetEntityMO)
		local splitArr = FightStrUtil.instance:getSplitCache(sp[2], ",")

		if #splitArr > 1 then
			for i = 1, #splitArr do
				local buff_type_id = tonumber(splitArr[i])

				if buff_type_id and has_buff_type_dic[buff_type_id] then
					return false
				end
			end
		else
			for i = 2, #sp do
				local buff_type_id = tonumber(sp[i])

				if buff_type_id and has_buff_type_dic[buff_type_id] then
					return false
				end
			end
		end

		return true
	elseif conditionCO.type == "NoBuff" then
		local has_buff_type_dic = self:_getBuffTypeDic(targetEntityMO)
		local has_type = {}

		for k, v in pairs(has_buff_type_dic) do
			local buff_tpye_config = lua_skill_bufftype.configDict[k]

			if buff_tpye_config then
				has_type[buff_tpye_config.type] = true
			end
		end

		local splitArr = FightStrUtil.instance:getSplitCache(sp[2], ",")

		if #splitArr > 1 then
			for i = 1, #splitArr do
				local tar_type = tonumber(splitArr[i])

				if tar_type and has_type[tar_type] then
					return false
				end
			end
		else
			for i = 2, #sp do
				local tar_type = tonumber(sp[i])

				if tar_type and has_type[tar_type] then
					return false
				end
			end
		end

		return true
	elseif conditionCO.type == "NoBuffGroup" then
		local has_buff_type_dic = self:_getBuffTypeDic(targetEntityMO)
		local has_group = {}

		for k, v in pairs(has_buff_type_dic) do
			local buff_tpye_config = lua_skill_bufftype.configDict[k]

			if buff_tpye_config then
				has_group[buff_tpye_config.group] = true
			end
		end

		local splitArr = FightStrUtil.instance:getSplitCache(sp[2], ",")

		if #splitArr > 1 then
			for i = 1, #splitArr do
				local tar_group = tonumber(splitArr[i])

				if tar_group and has_group[tar_group] then
					return false
				end
			end
		else
			for i = 2, #sp do
				local tar_group = tonumber(sp[i])

				if tar_group and has_group[tar_group] then
					return false
				end
			end
		end

		return true
	elseif conditionCO.type == "PowerCompare" then
		local curPower = targetEntityMO:getPowerInfo(tonumber(sp[3]))

		if curPower then
			if sp[2] == "1" then
				return curPower.num >= tonumber(sp[4])
			end
		else
			return false
		end
	elseif conditionCO.type == "TypeIdBuffCountMoreThan" then
		local buffTypeId = tonumber(sp[2])
		local count = tonumber(sp[3])
		local buffList = targetEntityMO:getBuffList()

		for _, buffMO in ipairs(buffList) do
			local buffConfig = lua_skill_buff.configDict[buffMO.buffId]

			if buffConfig and buffConfig.typeId == buffTypeId then
				local layer = buffMO.layer and buffMO.layer > 0 and buffMO.layer or 1

				if count <= layer then
					return true
				end
			end
		end
	elseif conditionCO.type == "SelfTeamHasBuffTypeLayerMoreThan" then
		local conditionTargetUids = self:_getConditionTargetUids(conditionTarget)
		local buffTypeId = tonumber(sp[3])
		local count = tonumber(sp[2])
		local total = 0

		for _, entityId in ipairs(conditionTargetUids) do
			local oneEntityMO = FightDataHelper.entityMgr:getById(entityId)
			local buffList = oneEntityMO:getBuffList()

			for _, buffMO in ipairs(buffList) do
				local buffConfig = lua_skill_buff.configDict[buffMO.buffId]

				if buffConfig and buffConfig.typeId == buffTypeId then
					local layer = buffMO.layer and buffMO.layer > 0 and buffMO.layer or 1

					total = total + layer
				end
			end
		end

		return count <= total
	elseif conditionCO.type == "HasTypeIdBuffMoreThan" then
		local buffTypeId = tonumber(sp[2])
		local count = tonumber(sp[3])
		local buffList = targetEntityMO:getBuffList()
		local counter = 0

		for _, buffMO in ipairs(buffList) do
			local buffConfig = lua_skill_buff.configDict[buffMO.buffId]

			if buffConfig and buffConfig.typeId == buffTypeId then
				if FightBuffHelper.isIncludeType(buffMO.buffId, FightEnum.BuffIncludeTypes.Stacked) then
					local layer = buffMO.layer and buffMO.layer > 0 and buffMO.layer or 1

					counter = counter + layer
				else
					counter = counter + 1
				end
			end
		end

		return count <= counter
	elseif conditionCO.type == "EnemyNumIncludeSpMoreThan" then
		local enemyCount = tonumber(sp[2])

		return enemyCount <= #FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)
	elseif conditionCO.type == "EnemyNumIncludeSpLessThan" then
		local enemyCount = tonumber(sp[2])

		return enemyCount >= #FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)
	end
end

function FightViewHandCardItem:_getBuffTypeDic(targetEntityMO)
	local buffList = targetEntityMO:getBuffList()
	local has_buff_type_dic = {}

	for _, buffMO in ipairs(buffList) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO then
			has_buff_type_dic[buffCO.typeId] = true
		end
	end

	return has_buff_type_dic
end

function FightViewHandCardItem:_getSimulateBuffTypeDic(targetEntityMO)
	local buffList = self:_simulateBuffList(targetEntityMO)
	local has_buff_type_dic = {}

	for _, buffMO in ipairs(buffList) do
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO then
			has_buff_type_dic[buffCO.typeId] = true
		end
	end

	return has_buff_type_dic
end

function FightViewHandCardItem:_checkSkillRateUpBehavior(behavior, conditionTarget)
	if string.nilorempty(behavior) then
		return
	end

	local sp = FightStrUtil.instance:getSplitCache(behavior, "#")
	local behaviorId = tonumber(sp[1])
	local behaviorCO = lua_skill_behavior.configDict[behaviorId]

	if not behaviorCO then
		logError("技能效果表找不导id:" .. behaviorId)

		return false
	end

	local targetUid = self:_getConditionTargetUid(conditionTarget)

	if targetUid == 0 then
		return false
	end

	local targetEntityMO = FightDataHelper.entityMgr:getById(targetUid)

	if not targetEntityMO then
		return false
	end

	local isSkillRateUp1 = behaviorCO.type == "SkillRateUp1" and conditionTarget == "103"
	local isSkillRateUp2 = behaviorCO.type == "SkillRateUp2" and conditionTarget ~= "103"
	local buffList = self:_simulateBuffList(targetEntityMO)

	if isSkillRateUp1 or isSkillRateUp2 then
		local skillRateUpBuffType = sp[4] and FightStrUtil.instance:getSplitToNumberCache(sp[4], ",") or {}

		for _, buffMO in ipairs(buffList) do
			local buffCO = lua_skill_buff.configDict[buffMO.buffId]
			local buffTypeCO = buffCO and lua_skill_bufftype.configDict[buffCO.typeId]

			if buffTypeCO and tabletool.indexOf(skillRateUpBuffType, buffTypeCO.type) then
				return true
			end
		end
	end
end

function FightViewHandCardItem:_simulateBuffList(entityMO)
	local buffList = entityMO:getBuffList()
	local ops = FightDataHelper.operationDataMgr:getOpList()

	for _, op in ipairs(ops) do
		if op:isPlayCard() then
			local skillCO = lua_skill.configDict[op.skillId]

			for i = 1, FightEnum.MaxBehavior do
				local condition = skillCO["condition" .. i]
				local behavior = skillCO["behavior" .. i]
				local behaviorTarget = skillCO["behaviorTarget" .. i]
				local conditionTarget = skillCO["conditionTarget" .. i]

				if self:_checkCanAddBuff(condition) and not string.nilorempty(behavior) then
					local targetType = behaviorTarget

					if behaviorTarget == "0" then
						targetType = skillCO.logicTarget
					elseif behaviorTarget == "999" then
						targetType = conditionTarget ~= "0" and conditionTarget or skillCO.logicTarget
					end

					self:_simulateSkillehavior(entityMO, op, behavior, targetType, buffList)
				end
			end
		end
	end

	return buffList
end

function FightViewHandCardItem:_checkCanAddBuff(condition)
	if string.nilorempty(condition) then
		return
	end

	local arr = FightStrUtil.instance:getSplitCache(condition, "&")

	if #arr > 1 then
		local count = 0

		for i, v in ipairs(arr) do
			if self:_checkSingleConditionCanAddBuff(v) then
				count = count + 1
			end
		end

		if count == #arr then
			return true
		end
	else
		arr = FightStrUtil.instance:getSplitCache(condition, "|")

		if #arr > 1 then
			for i, v in ipairs(arr) do
				if self:_checkSingleConditionCanAddBuff(v) then
					return true
				end
			end
		elseif self:_checkSingleConditionCanAddBuff(condition) then
			return true
		end
	end
end

function FightViewHandCardItem:_checkSingleConditionCanAddBuff(condition)
	local sp = FightStrUtil.instance:getSplitCache(condition, "#")
	local typeId = tonumber(sp[1])
	local conditionCO = lua_skill_behavior_condition.configDict[typeId]

	if not conditionCO or string.nilorempty(conditionCO.type) then
		return false
	end

	if conditionCO.type == "None" then
		return true
	end
end

function FightViewHandCardItem:_simulateSkillehavior(entityMO, op, behavior, targetType, buffList)
	local sp = FightStrUtil.instance:getSplitToNumberCache(behavior, "#")
	local behaviorId = sp[1]
	local behaviorCO = lua_skill_behavior.configDict[behaviorId]
	local needBehavior = false

	if FightEnum.LogicTargetClassify.Special[targetType] then
		-- block empty
	elseif FightEnum.LogicTargetClassify.Single[targetType] then
		if op.toId == entityMO.id then
			needBehavior = true
		end
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[targetType] then
		if op.toId == entityMO.id then
			needBehavior = true
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[targetType] then
		if entityMO.side == FightEnum.EntitySide.EnemySide then
			needBehavior = true
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[targetType] then
		if entityMO.side == FightEnum.EntitySide.MySide then
			needBehavior = true
		end
	elseif FightEnum.LogicTargetClassify.Me[targetType] and op.belongToEntityId == entityMO.id then
		needBehavior = true
	end

	if needBehavior and behaviorCO then
		local addBuffId

		if behaviorCO.type == "AddBuff" then
			addBuffId = sp[2]
		elseif behaviorCO.type == "CatapultBuff" then
			addBuffId = sp[5]
		end

		if addBuffId then
			local buffProto = FightDef_pb.BuffInfo()

			buffProto.uid = "9999"
			buffProto.buffId = addBuffId

			local buffMO = FightBuffInfoData.New(buffProto, entityMO.id)

			table.insert(buffList, buffMO)
		end
	end
end

function FightViewHandCardItem:onStageChange(stage)
	self:_updateSpEffect()
end

function FightViewHandCardItem:playLongPressEffect()
	TaskDispatcher.cancelTask(self._delayDisableAnim, self)
	TaskDispatcher.runDelay(self._delayDisableAnim, self, 1)
end

function FightViewHandCardItem:_delayDisableAnim()
	self:stopLongPressEffect()
end

function FightViewHandCardItem:stopLongPressEffect()
	TaskDispatcher.cancelTask(self._delayDisableAnim, self)
	recthelper.setAnchor(self._forAnimGO.transform, 0, 0)
	transformhelper.setLocalRotation(self._forAnimGO.transform, 0, 0, 0)
end

function FightViewHandCardItem:_onClickThis()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if self._isLongPress and not PCInputController.instance:getIsUse() then
		self._isLongPress = false

		logNormal("has LongPress, can't click card")

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		logNormal("is Guiding, can't click card")

		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() and FightDataHelper.stageMgr:getCurOperateState() ~= FightStageMgr.OperateStateType.Discard then
		return
	end

	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard then
		local entityMO = FightDataHelper.entityMgr:getById(self.cardInfoMO.uid)

		if entityMO and FightCardDataHelper.isBigSkill(self.cardInfoMO.skillId) then
			return
		end

		FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.Discard)
		FightController.instance:dispatchEvent(FightEvent.PlayDiscardEffect, self.index)

		return
	end

	if FightViewHandCard.blockOperate then
		logNormal("blockOperate, can't click card")

		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		logNormal("Auto Fight, can't click card")

		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		logNormal("Play Stage, can't click card")

		return
	end

	if self._isDraging then
		return
	end

	if not FightCardDataHelper.canPlayCard(self.cardInfoMO) then
		return
	end

	local skillId = self.cardInfoMO.skillId

	if FightEnum.UniversalCard[skillId] then
		return
	end

	local opCostActPoint = 0

	for _, op in ipairs(FightDataHelper.operationDataMgr:getPlayCardOpList()) do
		opCostActPoint = opCostActPoint + op.costActPoint
	end

	if opCostActPoint >= FightDataHelper.operationDataMgr.actPoint then
		return
	end

	local skillCO = lua_skill.configDict[skillId]
	local mySideList = FightDataHelper.entityMgr:getMyNormalList()
	local mySideSpList = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
	local mySideEntityCount = #mySideList + #mySideSpList

	if skillCO and skillCO.effectTag == FightEnum.EffectTag.Choice then
		local config = lua_fight_card_choice.configDict[skillCO.id]

		if config then
			local param = {
				cardData = self.cardInfoMO,
				config = config,
				callback = self._toPlayCard,
				handle = self
			}

			ViewMgr.instance:openView(ViewName.FightPlayChoiceCardView, param)

			return
		end
	end

	if skillCO and FightEnum.ShowLogicTargetView[skillCO.logicTarget] and skillCO.targetLimit == FightEnum.TargetLimit.MySide then
		if mySideEntityCount > 1 then
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				fromId = self.cardInfoMO.uid,
				skillId = skillId,
				callback = self._toPlayCard,
				callbackObj = self
			})

			return
		end

		if mySideEntityCount == 1 then
			self:_toPlayCard(mySideList[1].id)

			return
		end
	end

	self:_toPlayCard()
end

function FightViewHandCardItem:_toPlayCard(entityId, param2, param3)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.FightCardOp)
	FightController.instance:dispatchEvent(FightEvent.BeforePlayHandCard, self.index, entityId)
	FightController.instance:dispatchEvent(FightEvent.PlayHandCard, self.index, entityId, param2, param3)
end

function FightViewHandCardItem:_onDragBegin(param, pointerEventData)
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		return
	end

	local opCostActPoint = 0

	for _, op in ipairs(FightDataHelper.operationDataMgr:getPlayCardOpList()) do
		opCostActPoint = opCostActPoint + op.costActPoint
	end

	if opCostActPoint >= FightDataHelper.operationDataMgr.actPoint then
		return
	end

	local guideFlag = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightMoveCard)

	if guideFlag and guideFlag.from and guideFlag.from ~= self.index then
		return
	end

	if not FightCardDataHelper.canMoveCard(self.cardInfoMO) then
		return
	end

	self._isDraging = true

	FightController.instance:dispatchEvent(FightEvent.DragHandCardBegin, self.index, pointerEventData.position, self.cardInfoMO)
end

function FightViewHandCardItem:_onDragThis(param, pointerEventData)
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if self._isDraging then
		FightController.instance:dispatchEvent(FightEvent.DragHandCard, self.index, pointerEventData.position)
	end
end

function FightViewHandCardItem:_onDragEnd(param, pointerEventData)
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if self._isDraging then
		self._isDraging = false

		FightController.instance:dispatchEvent(FightEvent.DragHandCardEnd, self.index, pointerEventData.position)
		GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.FightCardOp)
	end
end

function FightViewHandCardItem:_onLongPress()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightModel.instance.isHideCard then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesgo)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidLongPressCard) then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard then
			return
		end

		if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.DiscardEffect then
			return
		end
	end

	if not self._isDraging then
		self._isLongPress = true

		FightController.instance:dispatchEvent(FightEvent.LongPressHandCard, self.index)
	end
end

function FightViewHandCardItem:_onHover()
	if GuideController.instance:isGuiding() then
		return
	end

	if not self._isLongPress then
		self:_onLongPress()
	end
end

function FightViewHandCardItem:_simulateDragHandCardBegin(index)
	if not self.cardInfoMO then
		return
	end

	if self.index ~= index then
		return
	end

	local pos = recthelper.uiPosToScreenPos(self.tr)

	self._isDraging = true

	FightController.instance:dispatchEvent(FightEvent.DragHandCardBegin, index, pos, self.cardInfoMO)
end

function FightViewHandCardItem:_simulateDragHandCard(index, toIndex)
	if not self.cardInfoMO then
		return
	end

	if self.index ~= index then
		return
	end

	local toItem = self._subViewInst:getHandCardItem(toIndex)

	if toItem then
		local pos = recthelper.uiPosToScreenPos(toItem.tr)

		FightController.instance:dispatchEvent(FightEvent.DragHandCard, self.index, pos)
	end
end

function FightViewHandCardItem:_simulateDragHandCardEnd(index, toIndex)
	if not self.cardInfoMO then
		return
	end

	if self.index ~= index then
		return
	end

	local pos = recthelper.uiPosToScreenPos(self.tr)

	self._isDraging = false

	FightController.instance:dispatchEvent(FightEvent.DragHandCardEnd, self.index, pos)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.FightCardOp)
end

function FightViewHandCardItem:_simulatePlayHandCard(index, toId, param2, param3)
	if not self.cardInfoMO then
		return
	end

	if self.index ~= index then
		return
	end

	self:_toPlayCard(toId, param2, param3)
end

function FightViewHandCardItem:playCardAni(aniPath, aniname)
	self._cardAniName = aniname or UIAnimationName.Open

	self._loader:loadAsset(aniPath, self._onCardAniLoaded, self)
end

function FightViewHandCardItem:_onCardAniLoaded(loader)
	self._cardAni.runtimeAnimatorController = loader:GetResource()
	self._cardAni.enabled = true
	self._cardAni.speed = FightModel.instance:getUISpeed()

	gohelper.setActive(self.go, true)
	SLFramework.AnimatorPlayer.Get(self._innerGO):Play(self._cardAniName, self._onCardAniFinish, self)
end

function FightViewHandCardItem:_onCardAniFinish()
	self._cardAni.enabled = false

	self:_hideEffect()
end

function FightViewHandCardItem:playAni(aniPath, aniname)
	self._aniName = aniname or UIAnimationName.Open

	self._loader:loadAsset(aniPath, self._onAniLoaded, self)
end

function FightViewHandCardItem:_onAniLoaded(loader)
	self._foranim.runtimeAnimatorController = loader:GetResource()
	self._foranim.enabled = true
	self._foranim.speed = FightModel.instance:getUISpeed()

	gohelper.setActive(self.go, true)
	SLFramework.AnimatorPlayer.Get(self._forAnimGO):Play(self._aniName, self._onAniFinish, self)
end

function FightViewHandCardItem:_onAniFinish()
	self._foranim.enabled = false
end

function FightViewHandCardItem:_hideEffect()
	gohelper.setActive(gohelper.findChild(self._innerGO, "vx_balance"), false)
end

function FightViewHandCardItem:_onRefreshOneHandCard(index)
	if not self.cardInfoMO then
		return
	end

	if index == self.index then
		self:updateItem(self.index, self.cardInfoMO)
	end
end

function FightViewHandCardItem:_onGMForceRefreshNameUIBuff()
	self:_onRefreshOneHandCard(self.index)
end

function FightViewHandCardItem:playDistribute()
	if not self._distributeFlow then
		self._distributeFlow = FlowSequence.New()

		self._distributeFlow:addWork(FigthCardDistributeEffect.New())
	else
		self._distributeFlow:stop()
	end

	local context = self:getUserDataTb_()

	context.cards = tabletool.copy(FightDataHelper.handCardMgr.handCard)
	context.handCardItemList = self._subViewInst._handCardItemList
	context.preCardCount = #context.cards - 1
	context.newCardCount = 1

	self._distributeFlow:start(context)
end

function FightViewHandCardItem:playMasterAddHandCard()
	if not self._masterAddHandCardFlow then
		self._masterAddHandCardFlow = FlowSequence.New()

		self._masterAddHandCardFlow:addWork(FigthMasterAddHandCardEffect.New())
	else
		self._masterAddHandCardFlow:stop()
	end

	local context = self:getUserDataTb_()

	context.card = self

	self._masterAddHandCardFlow:start(context)
end

function FightViewHandCardItem:playMasterCardRemove()
	if not self._masterCardRemoveFlow then
		self._masterCardRemoveFlow = FlowSequence.New()

		self._masterCardRemoveFlow:addWork(FigthMasterCardRemoveEffect.New())
	else
		self._masterCardRemoveFlow:stop()
	end

	local context = self:getUserDataTb_()

	context.card = self

	self._masterCardRemoveFlow:start(context)
end

function FightViewHandCardItem:dissolveEntityCard(entityId)
	if not self.cardInfoMO then
		return
	end

	if self.cardInfoMO.uid ~= entityId then
		return
	end

	self:dissolveCard()

	return true
end

function FightViewHandCardItem:dissolveCard()
	if not self.go.activeInHierarchy then
		return
	end

	self:setASFDActive(false)
	self._cardItem:dissolveCard(transformhelper.getLocalScale(self._subViewInst._handCardContainer.transform), self.go)
end

function FightViewHandCardItem:moveSelfPos(index, delayCount)
	self:_releaseMoveFlow()

	self._moveCardFlow = FlowParallel.New()

	local dt = 0.033 / FightModel.instance:getUISpeed()
	local cardItemTr = self.go.transform
	local oneCardFlow = FlowSequence.New()

	oneCardFlow:addWork(WorkWaitSeconds.New(3 * delayCount * dt))

	local cardTargetPosX = FightViewHandCard.calcCardPosX(index)
	local cardTargetPosXOver = cardTargetPosX + 10

	oneCardFlow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = cardItemTr,
		to = cardTargetPosXOver,
		t = dt * 5
	}))
	oneCardFlow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = cardItemTr,
		to = cardTargetPosX,
		t = dt * 2
	}))
	self._moveCardFlow:addWork(oneCardFlow)
	self._moveCardFlow:start()
end

function FightViewHandCardItem:playCardLevelChange(oldSkillId)
	if not self.cardInfoMO then
		return
	end

	if not self.go.activeInHierarchy then
		return
	end

	gohelper.setActive(self._lockGO, false)
	self._cardItem:playCardLevelChange(self.cardInfoMO, oldSkillId)
end

function FightViewHandCardItem:_onCardLevelChangeDone(cardInfoMO)
	if cardInfoMO == self.cardInfoMO then
		gohelper.setActive(self._lockGO, true)
		self:updateItem(self.index, self.cardInfoMO)
	end
end

function FightViewHandCardItem:playCardAConvertCardB()
	if not self.cardInfoMO then
		return
	end

	gohelper.setActive(self._cardConvertEffect, true)
	TaskDispatcher.cancelTask(self._afterConvertCardEffect, self)

	if self._convertEffect then
		local transform = self._convertEffect.transform
		local childCount = transform.childCount
		local uniqueSkill = FightCardDataHelper.isBigSkill(self.cardInfoMO.skillId)
		local animation

		if uniqueSkill then
			for i = 0, childCount - 1 do
				local obj = transform:GetChild(i).gameObject

				if i == 3 then
					gohelper.setActive(obj, true)

					animation = gohelper.onceAddComponent(obj, typeof(UnityEngine.Animation))
				else
					gohelper.setActive(obj, false)
				end
			end
		else
			local skillLv = FightCardDataHelper.getSkillLv(self.cardInfoMO.uid, self.cardInfoMO.skillId)

			for i = 0, childCount - 1 do
				local obj = transform:GetChild(i).gameObject

				if i + 1 == skillLv then
					gohelper.setActive(obj, true)

					animation = gohelper.onceAddComponent(obj, typeof(UnityEngine.Animation))
				else
					gohelper.setActive(obj, false)
				end
			end
		end

		if animation then
			animation.this:get(animation.clip.name).speed = FightModel.instance:getUISpeed()
		end

		TaskDispatcher.runDelay(self._afterConvertCardEffect, self, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
	else
		self._loader:loadAsset("ui/viewres/fight/card_intensive.prefab", self._onCardAConvertCardBLoaded, self)
	end
end

function FightViewHandCardItem:_onCardAConvertCardBLoaded(loader)
	local tarPrefab = loader:GetResource()

	self._convertEffect = gohelper.clone(tarPrefab, self._cardConvertEffect)

	self:playCardAConvertCardB()
	TaskDispatcher.runDelay(self._afterConvertCardEffect, self, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
end

function FightViewHandCardItem:_afterConvertCardEffect()
	gohelper.setActive(self._cardConvertEffect, false)
end

function FightViewHandCardItem:changeToTempCard()
	self._cardItem:changeToTempCard()
end

function FightViewHandCardItem:getASFDScreenPos()
	return self._cardItem:getASFDScreenPos()
end

function FightViewHandCardItem:refreshPreDeleteImage(needShowPreDeleteImage)
	if self._cardItem then
		self._cardItem:_refreshPreDeleteImage(needShowPreDeleteImage)
	end
end

function FightViewHandCardItem:setActiveRed(active)
	if self._cardItem then
		self._cardItem:setActiveRed(active)
	end
end

function FightViewHandCardItem:setActiveBlue(active)
	if self._cardItem then
		self._cardItem:setActiveBlue(active)
	end
end

function FightViewHandCardItem:setActiveBoth(active)
	if self._cardItem then
		self._cardItem:setActiveBoth(active)
	end
end

function FightViewHandCardItem:resetRedAndBlue()
	if self._cardItem then
		self._cardItem:resetRedAndBlue()
	end
end

function FightViewHandCardItem:_releaseMoveFlow()
	if self._moveCardFlow then
		self._moveCardFlow:stop()

		self._moveCardFlow = nil
	end
end

function FightViewHandCardItem:releaseSelf()
	TaskDispatcher.cancelTask(self._afterConvertCardEffect, self)

	if self._distributeFlow then
		self._distributeFlow:stop()

		self._distributeFlow = nil
	end

	if self._dissolveFlow then
		self._dissolveFlow:stop()

		self._dissolveFlow = nil
	end

	if self._masterAddHandCardFlow then
		self._masterAddHandCardFlow:stop()

		self._masterAddHandCardFlow = nil
	end

	if self._masterCardRemoveFlow then
		self._masterCardRemoveFlow:stop()

		self._masterCardRemoveFlow = nil
	end

	self:_releaseMoveFlow()

	if self._loader then
		self._loader:releaseSelf()

		self._loader = nil
	end
end

function FightViewHandCardItem.replaceLockBg(obj)
	if not obj then
		return
	end

	local bg, path

	for i = 0, 4 do
		local isBig = i == 4
		local spName = isBig and "card_mask_big" or "card_mask_small"
		local prefix = isBig and "bigskill" or "normal"

		path = string.format("%s/%d/seal/ani/mask/di", prefix, i)
		bg = gohelper.findChildImage(obj, path)

		if bg then
			UISpriteSetMgr.instance:setFightSkillCardSprite(bg, spName, true)
		end

		path = string.format("%s/%d/seal/notani/di", prefix, i)
		bg = gohelper.findChildImage(obj, path)

		if bg then
			UISpriteSetMgr.instance:setFightSkillCardSprite(bg, spName, true)
		end

		path = string.format("%s/%d/sealing/ani/di", prefix, i)
		bg = gohelper.findChildImage(obj, path)

		if bg then
			UISpriteSetMgr.instance:setFightSkillCardSprite(bg, spName, true)
		end

		path = string.format("%s/%d/sealing/ani/mask", prefix, i)
		bg = gohelper.findChildImage(obj, path)

		if bg then
			UISpriteSetMgr.instance:setFightSkillCardSprite(bg, spName, true)
		end

		path = string.format("%s/%d/sealing/notani/di", prefix, i)
		bg = gohelper.findChildImage(obj, path)

		if bg then
			UISpriteSetMgr.instance:setFightSkillCardSprite(bg, spName, true)
		end

		path = string.format("%s/%d/unseal/ani/di", prefix, i)
		bg = gohelper.findChildImage(obj, path)

		if bg then
			UISpriteSetMgr.instance:setFightSkillCardSprite(bg, spName, true)
		end

		path = string.format("%s/%d/unseal/ani/mask/sanjiao", prefix, i)
		bg = gohelper.findChildImage(obj, path)

		if bg then
			UISpriteSetMgr.instance:setFightSkillCardSprite(bg, spName, true)
		end
	end
end

return FightViewHandCardItem
