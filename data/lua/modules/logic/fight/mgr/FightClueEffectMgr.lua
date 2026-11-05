-- chunkname: @modules/logic/fight/mgr/FightClueEffectMgr.lua

module("modules.logic.fight.mgr.FightClueEffectMgr", package.seeall)

local FightClueEffectMgr = class("FightClueEffectMgr", FightBaseClass)

FightClueEffectMgr.ExistEffect = "buff/buff_weiyi_zhishi"
FightClueEffectMgr.ConsumeEffect = "buff/buff_weiyi_zhishi_jihuo"
FightClueEffectMgr.RemoveDelay = 0.3
FightClueEffectMgr.OffsetConstId = 2

function FightClueEffectMgr:onConstructor()
	self.effectDic = {}
	self.effectEntryDic = {}

	self:com_registFightEvent(FightEvent.OnClueAdd, self._onClueAdd)
	self:com_registFightEvent(FightEvent.OnClueDel, self._onClueDel)
	self:com_registFightEvent(FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork)
	self:com_registFightEvent(FightEvent.QTE_BeforeEnterQte, self.onBeforeEnterQte)
	self:com_registFightEvent(FightEvent.QTE_AfterExitQte, self.onAfterExitQte)

	self.focusViewOpen = false

	self:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish)
	self:com_registMsg(FightMsgId.OnTimelineWorkCreated, self.onTimelineWorkCreated)
	self:com_registMsg(FightMsgId.OnTimelineWorkDestroyed, self.onTimelineWorkDestroyed)
end

function FightClueEffectMgr:_getEffectKey(teamType, position)
	return teamType .. "_" .. position
end

function FightClueEffectMgr:onBeforeEnterQte()
	for _, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(false, FightWorkEnterQTE.ActiveKey)
	end
end

function FightClueEffectMgr:onAfterExitQte()
	for _, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(true, FightWorkEnterQTE.ActiveKey)
	end
end

function FightClueEffectMgr:_getPositionStandPos(teamType, position)
	local myVertin = FightDataHelper.entityMgr:getMyVertin()
	local stanceId = FightHelper.getEntityStanceId(myVertin)
	local stanceCO = lua_stance.configDict[stanceId]

	if not stanceCO then
		return
	end

	local pos = stanceCO["pos" .. position]

	if not pos or not pos[1] or not pos[2] or not pos[3] then
		return
	end

	return pos[1], pos[2], pos[3]
end

function FightClueEffectMgr:_addEffect(effectName, posX, posY, posZ)
	local vertin = FightGameMgr.entityMgr:getById(FightEntityScene.MySideId)

	if not vertin then
		return
	end

	local effectWrap = vertin.effect:addGlobalEffect(effectName)

	self.effectDic[effectWrap.uniqueId] = effectWrap

	effectWrap:setLocalPos(posX, posY, posZ)

	if self.focusViewOpen then
		effectWrap:setActive(false, "FightClueEffectMgrFightFocusView")
	end

	if effectName == FightClueEffectMgr.ConsumeEffect then
		AudioMgr.instance:trigger(411000046)
	elseif effectName == FightClueEffectMgr.ExistEffect then
		AudioMgr.instance:trigger(411000045)
	end

	if effectName == FightClueEffectMgr.ExistEffect then
		effectWrap:setRenderOrder(-10, true)
	else
		effectWrap:setRenderOrder(25000, true)
	end

	AudioMgr.instance:trigger(410000151)

	return effectWrap
end

function FightClueEffectMgr:_removeEffect(effectWrap)
	if not effectWrap then
		return
	end

	self.effectDic[effectWrap.uniqueId] = nil

	local vertin = FightGameMgr.entityMgr:getById(FightEntityScene.MySideId)

	if not vertin then
		return
	end

	vertin.effect:removeEffect(effectWrap)
	AudioMgr.instance:trigger(410000152)
end

function FightClueEffectMgr:_playActivationAnim(effectWrap)
	local effectGO = effectWrap.effectGO

	if not effectGO or gohelper.isNil(effectGO) then
		return nil
	end

	local anim = gohelper.findChildComponent(effectGO, "root", gohelper.Type_Animator)

	if not anim then
		return nil
	end

	anim:Play("activation", 0, 0)
	anim:Update(0)

	anim.speed = FightModel.instance:getSpeed()

	return 2
end

function FightClueEffectMgr:_doRemoveEffect(tab)
	if tab.effectWrap then
		self:_removeEffect(tab.effectWrap)
	end
end

function FightClueEffectMgr:_getClueEffectName(clueId)
	local clueCo = lua_fight_move_clue.configDict[clueId]
	local effectName = clueCo and clueCo.effect

	if string.nilorempty(effectName) then
		return nil
	end

	if not string.find(effectName, "/") then
		effectName = "buff/" .. effectName
	end

	return effectName
end

function FightClueEffectMgr:_parseOffsetConfig()
	local config = {}
	local constCo = lua_fight_move_const.configDict[FightClueEffectMgr.OffsetConstId]

	if not constCo or string.nilorempty(constCo.value) then
		return config
	end

	for _, group in ipairs(FightStrUtil.instance:getSplitCache(constCo.value, "|")) do
		local segList = FightStrUtil.instance:getSplitCache(group, "#")
		local count = tonumber(segList[1])

		if count then
			local offsets = {}

			for i = 2, #segList do
				local xyz = FightStrUtil.instance:getSplitToNumberCache(segList[i], ",")

				offsets[#offsets + 1] = {
					xyz[1] or 0,
					xyz[2] or 0,
					xyz[3] or 0
				}
			end

			config[count] = offsets
		end
	end

	return config
end

function FightClueEffectMgr:_getClueEffectOffsets(count)
	if not self._offsetConfig then
		self._offsetConfig = self:_parseOffsetConfig()
	end

	return self._offsetConfig[count]
end

function FightClueEffectMgr:_syncPositionEffect(teamType, position)
	local key = self:_getEffectKey(teamType, position)
	local entry = self.effectEntryDic[key] or {}
	local uidToClueEffect = entry.clues or {}
	local clueArea = FightDataHelper.getClueArea(teamType)
	local positionData = clueArea and clueArea:getPositionData(position)
	local clues = positionData and positionData.clues or {}
	local validUidSet = {}

	for _, clueData in ipairs(clues) do
		validUidSet[clueData.uid] = true
	end

	for uid, effectWrap in pairs(uidToClueEffect) do
		if not validUidSet[uid] then
			self:_removeEffect(effectWrap)

			uidToClueEffect[uid] = nil
		end
	end

	local count = #clues
	local posX, posY, posZ

	if count > 0 then
		posX, posY, posZ = self:_getPositionStandPos(teamType, position)
	end

	if posX then
		if entry.exist then
			entry.exist:setLocalPos(posX, posY, posZ)
		else
			entry.exist = self:_addEffect(FightClueEffectMgr.ExistEffect, posX, posY, posZ)
		end

		local offsets = self:_getClueEffectOffsets(count)

		for i, clueData in ipairs(clues) do
			local clueEffectName = self:_getClueEffectName(clueData.clueId)

			if clueEffectName and clueEffectName ~= FightClueEffectMgr.ExistEffect then
				local offset = offsets and offsets[i]
				local offsetX = offset and offset[1] or 0
				local offsetY = offset and offset[2] or 0
				local offsetZ = offset and offset[3] or 0
				local x, y, z = posX + offsetX, posY + offsetY, posZ + offsetZ
				local effectWrap = uidToClueEffect[clueData.uid]

				if effectWrap then
					effectWrap:setLocalPos(x, y, z)
				else
					uidToClueEffect[clueData.uid] = self:_addEffect(clueEffectName, x, y, z)
				end
			elseif uidToClueEffect[clueData.uid] then
				self:_removeEffect(uidToClueEffect[clueData.uid])

				uidToClueEffect[clueData.uid] = nil
			end
		end
	elseif entry.exist then
		self:_removeEffect(entry.exist)

		entry.exist = nil
	end

	entry.clues = next(uidToClueEffect) ~= nil and uidToClueEffect or nil
	self.effectEntryDic[key] = (entry.exist or entry.clues) and entry or nil
end

function FightClueEffectMgr:_removePositionEntry(entry)
	if not entry then
		return
	end

	if entry.exist then
		self:_removeEffect(entry.exist)
	end

	if entry.clues then
		for _, effectWrap in pairs(entry.clues) do
			self:_removeEffect(effectWrap)
		end
	end
end

function FightClueEffectMgr:_onClueAdd(cluePosition, teamType)
	if not cluePosition then
		return
	end

	self:_syncPositionEffect(teamType, cluePosition.position)
end

function FightClueEffectMgr:_onClueDel(cluePosition, teamType)
	if not cluePosition then
		return
	end

	local posX, posY, posZ = self:_getPositionStandPos(teamType, cluePosition.position)

	if not posX then
		return
	end

	local animDelay = self:_playAndRemoveDeletedClueEffects(teamType, cluePosition.position)
	local jihuoWrap = self:_addEffect(FightClueEffectMgr.ConsumeEffect, posX, posY, posZ)

	self:com_registTimer(self._removeConsumeEffect, FightClueEffectMgr.RemoveDelay, {
		jihuoWrap = jihuoWrap
	})

	if animDelay and animDelay > 0 then
		self:com_registTimer(self._syncPositionEffectByTimer, animDelay, {
			teamType = teamType,
			position = cluePosition.position
		})
	else
		self:_syncPositionEffect(teamType, cluePosition.position)
	end
end

function FightClueEffectMgr:_syncPositionEffectByTimer(tab)
	self:_syncPositionEffect(tab.teamType, tab.position)
end

function FightClueEffectMgr:_playAndRemoveDeletedClueEffects(teamType, position)
	local key = self:_getEffectKey(teamType, position)
	local entry = self.effectEntryDic[key]

	if not entry or not entry.clues then
		return nil
	end

	local clueArea = FightDataHelper.getClueArea(teamType)
	local positionData = clueArea and clueArea:getPositionData(position)
	local clues = positionData and positionData.clues or {}
	local validUidSet = {}

	for _, clueData in ipairs(clues) do
		validUidSet[clueData.uid] = true
	end

	local maxAnimDelay

	for uid, effectWrap in pairs(entry.clues) do
		if not validUidSet[uid] then
			entry.clues[uid] = nil

			local animDelay = self:_playActivationAnim(effectWrap)

			if animDelay and animDelay > 0 then
				self:com_registTimer(self._doRemoveEffect, animDelay, {
					effectWrap = effectWrap
				})

				if not maxAnimDelay or maxAnimDelay < animDelay then
					maxAnimDelay = animDelay
				end
			else
				self:_removeEffect(effectWrap)
			end
		end
	end

	return maxAnimDelay
end

function FightClueEffectMgr:_removeConsumeEffect(tab)
	self:_removeEffect(tab.jihuoWrap)
end

function FightClueEffectMgr:_buildFromSnapshot()
	self:_releaseAllEffect()

	local teamTypeList = {
		FightEnum.TeamType.MySide,
		FightEnum.TeamType.EnemySide
	}

	for _, teamType in ipairs(teamTypeList) do
		local clueArea = FightDataHelper.getClueArea(teamType)

		if clueArea then
			for _, positionData in ipairs(clueArea.cluePositions) do
				self:_syncPositionEffect(teamType, positionData.position)
			end
		end
	end
end

function FightClueEffectMgr:_releaseAllEffect()
	for _, entry in pairs(self.effectEntryDic) do
		self:_removePositionEntry(entry)
	end

	self.effectEntryDic = {}
end

function FightClueEffectMgr:_onFightReconnectLastWork()
	self:_buildFromSnapshot()
end

function FightClueEffectMgr:_setAllEffectActive(isActive)
	for _, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(isActive, "FightClueEffectMgrFightFocusView")
	end
end

function FightClueEffectMgr:_onOpenView(viewName)
	if viewName == ViewName.FightFocusView then
		self.focusViewOpen = true

		self:_setAllEffectActive(false)
	end
end

function FightClueEffectMgr:_onCloseViewFinish(viewName)
	if viewName == ViewName.FightFocusView then
		self.focusViewOpen = false

		self:_setAllEffectActive(true)
	end
end

function FightClueEffectMgr:onTimelineWorkCreated(entityId, skillId, fightStepData, timelineName)
	if FightCardDataHelper.isBigSkill(skillId) then
		self:_setAllEffectActiveByStep(false, fightStepData.stepUid)
	end
end

function FightClueEffectMgr:onTimelineWorkDestroyed(entityId, skillId, fightStepData, timelineName)
	if FightCardDataHelper.isBigSkill(skillId) then
		self:_setAllEffectActiveByStep(true, fightStepData.stepUid)
	end
end

function FightClueEffectMgr:_setAllEffectActiveByStep(isActive, stepUid)
	local tag = "FightClueEffectMgrFightFocusView" .. stepUid

	for _, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(isActive, tag)
	end
end

function FightClueEffectMgr:onDestructor()
	return
end

return FightClueEffectMgr
