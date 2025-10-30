﻿-- chunkname: @modules/logic/fight/controller/FightHelper.lua

module("modules.logic.fight.controller.FightHelper", package.seeall)

local FightHelper = _M
local mySideIdCounter = 1000001
local enemySideIdCounter = -1000001
local Vector2Zero = Vector2.zero

function FightHelper.getEntityStanceId(fightEntityMO, waveId)
	local stanceId = FightEnum.MySideDefaultStanceId

	if fightEntityMO and fightEntityMO.side == FightEnum.EntitySide.MySide then
		local fightParam = FightModel.instance:getFightParam()
		local battleId = fightParam and fightParam.battleId
		local battleCO = battleId and lua_battle.configDict[battleId]

		if battleCO and not string.nilorempty(battleCO.myStance) then
			stanceId = tonumber(battleCO.myStance)

			if not stanceId then
				local sp = FightStrUtil.instance:getSplitToNumberCache(battleCO.myStance, "#")

				if #sp > 0 then
					waveId = waveId or FightModel.instance:getCurWaveId()

					local index = waveId <= #sp and waveId or #sp

					stanceId = sp[index]
				else
					logError("站位配置有误，战斗id = " .. fightParam.battleId)
				end
			end
		end

		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			stanceId = SkillEditorMgr.instance.stance_id
		end
	else
		local curMonsterGroupId = FightModel.instance:getCurMonsterGroupId()
		local monsterGroupCO = lua_monster_group.configDict[curMonsterGroupId]

		stanceId = monsterGroupCO and monsterGroupCO.stanceId or FightEnum.EnemySideDefaultStanceId

		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			stanceId = SkillEditorMgr.instance.enemy_stance_id
		end
	end

	return stanceId
end

function FightHelper.getEntityStandPos(fightEntityMO, waveId)
	if fightEntityMO:isVorpalith() then
		return 0, 0, 0, 1
	end

	if fightEntityMO:isAssistBoss() then
		return FightHelper.getAssistBossStandPos(fightEntityMO, waveId)
	end

	if fightEntityMO:isAct191Boss() then
		local config = fightEntityMO:getCO()

		if config and config.offset then
			local arr = string.split(config.offset, "#")
			local posX = tonumber(arr[1]) or 0

			if fightEntityMO:isEnemySide() then
				posX = -posX
			end

			return posX, tonumber(arr[2]) or 0, tonumber(arr[3]) or 0, 1
		end
	end

	if FightEntityDataHelper.isPlayerUid(fightEntityMO.uid) then
		return 0, 0, 0, 1
	end

	local stanceId = FightHelper.getEntityStanceId(fightEntityMO, waveId)
	local stanceCO = lua_stance.configDict[stanceId]

	if not stanceCO then
		if fightEntityMO.side == FightEnum.EntitySide.MySide then
			local fightParam = FightModel.instance:getFightParam()
			local battleId = fightParam and fightParam.battleId

			logError("我方用了不存在的站位，战斗id=" .. (battleId or "nil") .. "， 站位id=" .. stanceId)
		else
			local curMonsterGroupId = FightModel.instance:getCurMonsterGroupId()

			logError("敌方用了不存在的站位，怪物组=" .. (curMonsterGroupId or "nil") .. "， 站位id=" .. stanceId)
		end
	end

	local isSub = FightDataHelper.entityMgr:isSub(fightEntityMO.uid)
	local pos

	if isSub then
		pos = stanceCO.subPos1
	else
		pos = stanceCO["pos" .. fightEntityMO.position]
	end

	if not pos or not pos[1] or not pos[2] or not pos[3] then
		if isDebugBuild then
			logError("stance pos nil: stance_" .. (stanceId or "nil") .. " posIndex_" .. (fightEntityMO.position or "nil"))
		end

		return 0, 0, 0, 1
	end

	local posX = pos[1]
	local scale = pos[4] or 1
	local skin = fightEntityMO.skin
	local scaleBySkinPosZConfig = lua_fight_skin_scale_by_z.configDict[skin]

	if scaleBySkinPosZConfig and not isSub then
		local list = {}

		for k, v in pairs(scaleBySkinPosZConfig) do
			table.insert(list, v)
		end

		table.sort(list, FightHelper.sortScaleBySkinPosZConfig)

		for i, v in ipairs(list) do
			if pos[3] <= v.posZ then
				scale = v.scale

				local offsetX = v.posXOffset or 0

				if fightEntityMO:isEnemySide() then
					offsetX = -offsetX
				end

				posX = posX + offsetX

				break
			end
		end
	end

	local scaleOffsetDic = FightDataHelper.entityExMgr:getById(fightEntityMO.id).scaleOffsetDic

	if scaleOffsetDic then
		for k, offset in pairs(scaleOffsetDic) do
			scale = scale * offset
		end
	end

	return posX, pos[2], pos[3], scale
end

function FightHelper.sortScaleBySkinPosZConfig(a, b)
	return a.priority < b.priority
end

function FightHelper.getAssistBossStandPos(fightEntityMo, waveId)
	waveId = waveId or FightModel.instance:getCurWaveId()

	local fightParam = FightModel.instance:getFightParam()
	local skinId = fightEntityMo.skin
	local sceneId = fightParam:getScene(waveId)
	local skinDict = lua_assist_boss_stance.configDict[skinId]
	local bossStanceCo = skinDict and skinDict[sceneId]

	bossStanceCo = bossStanceCo or skinDict and skinDict[0]

	if not bossStanceCo then
		logError(string.format("协助boss站位表未配置 皮肤id：%s, 场景id : %s", skinId, sceneId))

		return 9.4, 0, -2.75, 0.9
	end

	local pos = bossStanceCo.position

	return pos[1], pos[2], pos[3], bossStanceCo.scale
end

function FightHelper.getSpineLookDir(entitySide)
	return entitySide == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
end

function FightHelper.getEntitySpineLookDir(entityMO)
	if entityMO then
		local entitySide = entityMO.side
		local skinCO = FightConfig.instance:getSkinCO(entityMO.skin)

		if skinCO and skinCO.flipX and skinCO.flipX == 1 then
			return entitySide == FightEnum.EntitySide.MySide and SpineLookDir.Right or SpineLookDir.Left
		else
			return entitySide == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
		end
	end
end

function FightHelper.getEffectLookDir(entitySide)
	return entitySide == FightEnum.EntitySide.MySide and FightEnum.EffectLookDir.Left or FightEnum.EffectLookDir.Right
end

function FightHelper.getEffectLookDirQuaternion(entitySide)
	if entitySide == FightEnum.EntitySide.MySide then
		return FightEnum.RotationQuaternion.Zero
	else
		return FightEnum.RotationQuaternion.Ohae
	end
end

function FightHelper.getEntity(id)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

		return entityMgr:getEntity(id)
	end
end

function FightHelper.getDefenders(fightStepData, includeToId, filterEffectType)
	local defenders = {}

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		local continue = false

		if filterEffectType and filterEffectType[actEffectData.effectType] then
			continue = true
		end

		if actEffectData.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(actEffectData) then
			continue = true
		end

		if not continue then
			local oneDefender = FightHelper.getEntity(actEffectData.targetId)

			if oneDefender then
				table.insert(defenders, oneDefender)
			else
				logNormal("get defender fail, entity not exist: " .. actEffectData.targetId)
			end
		end
	end

	if includeToId then
		local to = FightHelper.getEntity(fightStepData.toId)

		if not tabletool.indexOf(defenders, to) then
			table.insert(defenders, to)
		end
	end

	return defenders
end

function FightHelper.getPreloadAssetItem(path)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return FightPreloadController.instance:getFightAssetItem(path)
	end
end

function FightHelper.getEnemySideEntitys(attackerId, includeSub)
	local attacker = FightHelper.getEntity(attackerId)

	if attacker then
		local side = attacker:getSide()

		if side == FightEnum.EntitySide.EnemySide then
			return FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, includeSub)
		elseif side == FightEnum.EntitySide.MySide then
			return FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, includeSub)
		end
	end

	return {}
end

function FightHelper.getSideEntitys(side, includeSub)
	local list = {}
	local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	local tag = side == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local entitys = entityMgr:getTagUnitDict(tag)

	if entitys then
		for _, entity in pairs(entitys) do
			if not FightDataHelper.entityMgr:isAssistBoss(entity.id) and not FightDataHelper.entityMgr:isAct191Boss(entity.id) and (includeSub or not FightDataHelper.entityMgr:isSub(entity.id)) then
				table.insert(list, entity)
			end
		end
	end

	return list
end

function FightHelper.getAllSideEntitys(side)
	local list = {}
	local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	local tag = side == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local entitys = entityMgr:getTagUnitDict(tag)

	if entitys then
		for _, entity in pairs(entitys) do
			table.insert(list, entity)
		end
	end

	return list
end

function FightHelper.getSubEntity(side)
	local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	local tag = side == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local entitys = entityMgr:getTagUnitDict(tag)

	if entitys then
		for _, entity in pairs(entitys) do
			if not entity.isDead and FightDataHelper.entityMgr:isSub(entity.id) then
				return entity
			end
		end
	end
end

function FightHelper.getAllEntitys()
	local list = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
		local mySide = entityMgr:getTagUnitDict(SceneTag.UnitPlayer)
		local enemySide = entityMgr:getTagUnitDict(SceneTag.UnitMonster)

		if mySide then
			for _, entity in pairs(mySide) do
				table.insert(list, entity)
			end
		end

		if enemySide then
			for _, entity in pairs(enemySide) do
				table.insert(list, entity)
			end
		end
	end

	return list
end

function FightHelper.isAllEntityDead(side)
	local allDead = true
	local all

	if side then
		all = FightHelper.getSideEntitys(side, true)
	else
		all = FightHelper.getAllEntitys()
	end

	for _, entity in ipairs(all) do
		if not entity.isDead then
			allDead = false
		end
	end

	return allDead
end

function FightHelper.getAllEntitysContainUnitNpc()
	local list = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
		local mySide = entityMgr:getTagUnitDict(SceneTag.UnitPlayer)
		local enemySide = entityMgr:getTagUnitDict(SceneTag.UnitMonster)
		local npcSide = entityMgr:getTagUnitDict(SceneTag.UnitNpc)

		LuaUtil.mergeTable(list, mySide, enemySide, npcSide)
	end

	return list
end

function FightHelper.validEntityEffectType(effectType)
	if effectType == FightEnum.EffectType.EXPOINTCHANGE then
		return false
	end

	if effectType == FightEnum.EffectType.INDICATORCHANGE then
		return false
	end

	if effectType == FightEnum.EffectType.POWERCHANGE then
		return false
	end

	return true
end

function FightHelper.getRelativeEntityIdDict(fightStepData, filterEffectType)
	local dict = {}

	if fightStepData.fromId then
		dict[fightStepData.fromId] = true
	end

	if fightStepData.toId then
		dict[fightStepData.toId] = true
	end

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		local continue = false

		if filterEffectType and filterEffectType[actEffectData.effectType] then
			continue = true
		end

		if actEffectData.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(actEffectData) then
			continue = true
		end

		if not continue and actEffectData.effectType ~= FightEnum.EffectType.EXPOINTCHANGE and actEffectData.targetId then
			dict[actEffectData.targetId] = true
		end
	end

	return dict
end

function FightHelper.getSkillTargetEntitys(fightStepData, filterEffectType)
	local list = {}

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		local continue = false

		if filterEffectType and filterEffectType[actEffectData.effectType] then
			continue = true
		end

		if actEffectData.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(actEffectData) then
			continue = true
		end

		if not continue and actEffectData.effectType ~= FightEnum.EffectType.EXPOINTCHANGE then
			local entity = FightHelper.getEntity(actEffectData.targetId)

			if entity and not tabletool.indexOf(list, entity) then
				table.insert(list, entity)
			end
		end
	end

	return list
end

function FightHelper.getTargetLimits(side, skillId, fromId)
	local oppoSide = side == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	local atkEntitys = FightHelper.getSideEntitys(side, false)
	local defEntitys = FightHelper.getSideEntitys(oppoSide, false)
	local skillCO = lua_skill.configDict[skillId]
	local targetUids = {}

	if not skillCO then
		for _, entity in ipairs(defEntitys) do
			table.insert(targetUids, entity.id)
		end

		logError("no target limits, skillId_" .. skillId)
	elseif skillCO.targetLimit == FightEnum.TargetLimit.None then
		-- block empty
	elseif skillCO.targetLimit == FightEnum.TargetLimit.EnemySide then
		for _, entity in ipairs(defEntitys) do
			table.insert(targetUids, entity.id)
		end
	elseif skillCO.targetLimit == FightEnum.TargetLimit.MySide then
		for _, entity in ipairs(atkEntitys) do
			table.insert(targetUids, entity.id)
		end
	else
		for _, entity in ipairs(defEntitys) do
			table.insert(targetUids, entity.id)
		end

		logError("target limit type not implement:" .. skillCO.targetLimit .. " skillId = " .. skillId)
	end

	if skillCO.logicTarget == "3" then
		local atkEntityId = fromId

		if atkEntityId then
			for i = #targetUids, 1, -1 do
				if targetUids[i] == atkEntityId then
					table.remove(targetUids, i)
				end
			end
		end
	elseif skillCO.logicTarget == "1" then
		for i = 1, FightEnum.MaxBehavior do
			local behavior = skillCO["behavior" .. i]
			local arr = FightStrUtil.instance:getSplitCache(behavior, "#")

			if arr[1] == "60032" then
				for index = #targetUids, 1, -1 do
					local entityMO = FightDataHelper.entityMgr:getById(targetUids[index])

					if entityMO and (#entityMO.skillGroup1 == 0 or #entityMO.skillGroup2 == 0) then
						table.remove(targetUids, index)
					end
				end
			end
		end
	end

	return targetUids
end

function FightHelper.getEntityWorldTopPos(entity)
	local size, offset = FightHelper.getEntityBoxSizeOffsetV2(entity)
	local posX, posY, posZ = FightHelper.getProcessEntitySpinePos(entity)

	return posX + offset.x, posY + offset.y + size.y / 2, posZ
end

function FightHelper.getEntityWorldCenterPos(entity)
	local size, offset = FightHelper.getEntityBoxSizeOffsetV2(entity)
	local posX, posY, posZ = FightHelper.getProcessEntitySpinePos(entity)

	return posX + offset.x, posY + offset.y, posZ
end

function FightHelper.getEntityHangPointPos(entity, hangPoint)
	local pos = entity:getHangPoint(hangPoint).transform.position

	return pos.x, pos.y, pos.z
end

function FightHelper.getEntityWorldBottomPos(entity)
	local size, offset = FightHelper.getEntityBoxSizeOffsetV2(entity)
	local posX, posY, posZ = FightHelper.getProcessEntitySpinePos(entity)

	return posX + offset.x, posY + offset.y - size.y / 2, posZ
end

function FightHelper.getEntityLocalTopPos(entity)
	local size, offset = FightHelper.getEntityBoxSizeOffsetV2(entity)

	return offset.x, offset.y + size.y / 2, 0
end

function FightHelper.getEntityLocalCenterPos(entity)
	local size, offset = FightHelper.getEntityBoxSizeOffsetV2(entity)

	return offset.x, offset.y, 0
end

function FightHelper.getEntityLocalBottomPos(entity)
	local size, offset = FightHelper.getEntityBoxSizeOffsetV2(entity)

	return offset.x, offset.y - size.y / 2, 0
end

function FightHelper.getEntityBoxSizeOffsetV2(entity)
	if FightHelper.isAssembledMonster(entity) then
		local entityMO = entity:getMO()
		local config = lua_fight_assembled_monster.configDict[entityMO.skin]
		local size = {}

		size.x = config.virtualSpineSize[1]
		size.y = config.virtualSpineSize[2]

		return size, Vector2Zero
	end

	local spineGO = entity.spine and entity.spine:getSpineGO()

	if spineGO then
		local boxCollider2D = spineGO:GetComponent("BoxCollider2D")

		if boxCollider2D then
			local scaleX, scaleY, _ = transformhelper.getLocalScale(entity.go.transform)
			local size, offset = boxCollider2D.size, boxCollider2D.offset

			offset.x = offset.x * scaleX
			offset.y = offset.y * scaleY

			if entity.spine:getLookDir() == SpineLookDir.Right then
				offset.x = -offset.x
			end

			size.x = size.x * scaleX
			size.y = size.y * scaleY

			return size, offset
		end
	end

	return Vector2Zero, Vector2Zero
end

function FightHelper.getModelSize(entity)
	local size, _ = FightHelper.getEntityBoxSizeOffsetV2(entity)
	local xy = size.x + size.y

	if xy > 14 then
		return 4
	elseif xy > 7 then
		return 3
	elseif xy > 3 then
		return 2
	else
		return 1
	end
end

function FightHelper.getEffectUrlWithLod(effectName)
	return ResUrl.getEffect(effectName)
end

function FightHelper.tempNewStepProto(stepProto)
	local newStep = {}

	setmetatable(newStep, {
		__index = stepProto
	})

	local actEffect = {}

	newStep.actEffect = actEffect

	for i, effect in ipairs(stepProto.actEffect) do
		local newEffect = {}

		setmetatable(newEffect, {
			__index = effect
		})
		table.insert(actEffect, newEffect)

		if effect.effectType == FightEnum.EffectType.FIGHTSTEP then
			newEffect.fightStep = FightHelper.tempNewStepProto(effect.fightStep)
		end
	end

	return newStep
end

function FightHelper.tempProcessStepListProto(stepProtoList)
	local list = {}

	for i, oneStep in ipairs(stepProtoList) do
		local step = FightHelper.tempNewStepProto(oneStep)

		table.insert(list, step)
	end

	return list
end

local effectSplitIndex = 0
local effectStepDeep = 0

function FightHelper.processRoundStep(stepList)
	stepList = FightHelper.tempProcessStepListProto(stepList)
	effectSplitIndex = 0
	effectStepDeep = 0

	local list = {}

	for i, step in ipairs(stepList) do
		FightHelper.addRoundStep(list, step)
	end

	return list
end

function FightHelper.addRoundStep(list, step)
	table.insert(list, step)
	FightHelper.detectStepEffect(list, step.actEffect)
end

function FightHelper.detectStepEffect(list, actEffect)
	if actEffect and #actEffect > 0 then
		local index = 1

		while actEffect[index] do
			local effect = actEffect[index]

			if effect.effectType == FightEnum.EffectType.SPLITSTART then
				effectSplitIndex = effectSplitIndex + 1
			elseif effect.effectType == FightEnum.EffectType.SPLITEND then
				effectSplitIndex = effectSplitIndex - 1
			end

			if effect.effectType == FightEnum.EffectType.FIGHTSTEP then
				if effectSplitIndex > 0 then
					table.remove(actEffect, index)

					index = index - 1
					effectStepDeep = effectStepDeep + 1

					FightHelper.addRoundStep(list, effect.fightStep)

					effectStepDeep = effectStepDeep - 1
				else
					local fightStep = effect.fightStep

					if fightStep.fakeTimeline then
						FightHelper.addRoundStep(list, effect.fightStep)
					elseif fightStep.actType == FightEnum.ActType.SKILL then
						if FightHelper.needAddRoundStep(fightStep) then
							FightHelper.addRoundStep(list, effect.fightStep)
						else
							FightHelper.detectStepEffect(list, fightStep.actEffect)
						end
					elseif fightStep.actType == FightEnum.ActType.CHANGEHERO then
						FightHelper.addRoundStep(list, effect.fightStep)
					elseif fightStep.actType == FightEnum.ActType.CHANGEWAVE then
						FightHelper.addRoundStep(list, effect.fightStep)
					else
						FightHelper.detectStepEffect(list, fightStep.actEffect)
					end
				end
			elseif effectSplitIndex > 0 and effectStepDeep == 0 then
				table.remove(actEffect, index)

				index = index - 1

				local newStep = {}

				newStep.actType = FightEnum.ActType.EFFECT
				newStep.fromId = "0"
				newStep.toId = "0"
				newStep.actId = 0
				newStep.actEffect = {
					effect
				}
				newStep.cardIndex = 0
				newStep.supportHeroId = 0
				newStep.fakeTimeline = false

				table.insert(list, newStep)
			end

			index = index + 1
		end
	end
end

function FightHelper.needAddRoundStep(fightStep)
	if fightStep then
		if FightHelper.isTimelineStep(fightStep) then
			return true
		elseif fightStep.actType == FightEnum.ActType.CHANGEHERO then
			return true
		elseif fightStep.actType == FightEnum.ActType.CHANGEWAVE then
			return true
		end
	end
end

function FightHelper.buildInfoMOs(infos, cls)
	local list = {}

	for _, info in ipairs(infos) do
		local mo = cls.New()

		mo:init(info)
		table.insert(list, mo)
	end

	return list
end

function FightHelper.logForPCSkillEditor(str)
	local isInPCSkillEditor = not SkillEditorMgr.instance.inEditMode or SLFramework.FrameworkSettings.IsEditor

	if isInPCSkillEditor then
		logNormal(str)
	end
end

function FightHelper.getEffectLabel(effectRootGO, label)
	if gohelper.isNil(effectRootGO) then
		return
	end

	local effecLabels = effectRootGO:GetComponentsInChildren(typeof(ZProj.EffectLabel))

	if not effecLabels or effecLabels.Length <= 0 then
		return
	end

	local ans = {}

	for i = 0, effecLabels.Length - 1 do
		local effectLabel = effecLabels[i]

		if not label or effectLabel.label == label then
			table.insert(ans, effectLabel)
		end
	end

	return ans
end

function FightHelper.shouUIPoisoningEffect(buffId)
	local feature = FightConfig.instance:hasBuffFeature(buffId, FightEnum.BuffType_Dot)

	if feature then
		local buffConfig = lua_skill_buff.configDict[buffId]

		if buffConfig and lua_fight_buff_use_poison_ui_effect.configDict[buffConfig.typeId] then
			return true
		end
	end

	return false
end

function FightHelper.dealDirectActEffectData(actEffect, act_on_index_entity, active_type)
	local effect_list = FightHelper.filterActEffect(actEffect, active_type)
	local data_len = #effect_list
	local invoke_list = {}

	if effect_list[act_on_index_entity] then
		invoke_list = effect_list[act_on_index_entity]
	elseif data_len > 0 then
		invoke_list = effect_list[data_len]
	end

	return invoke_list
end

function FightHelper.filterActEffect(actEffect, active_type)
	local effect_list = {}
	local target_dic = {}
	local id_list = {}

	for i, v in ipairs(actEffect) do
		local actEffectData = v
		local continue = false

		if actEffectData.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(actEffectData) then
			continue = true
		end

		if not continue and active_type[v.effectType] then
			if not target_dic[v.targetId] then
				target_dic[v.targetId] = {}

				table.insert(id_list, v.targetId)
			end

			table.insert(target_dic[v.targetId], v)
		end
	end

	for i, v in ipairs(id_list) do
		effect_list[i] = target_dic[v]
	end

	return effect_list
end

function FightHelper.detectAttributeCounter()
	local fight_param = FightModel.instance:getFightParam()
	local recommended, counter = FightHelper.getAttributeCounter(fight_param.monsterGroupIds, GameSceneMgr.instance:isSpScene())

	return recommended, counter
end

function FightHelper.getAttributeCounter(monsterGroupIds, isSpScene)
	local is_boss
	local enemy_career_tab = {}
	local isTowerDeepEpisode = FightHelper.checkIsTowerDeepEpisode()

	if isTowerDeepEpisode then
		local monsterId = TowerPermanentDeepModel.instance:getCurDeepMonsterId()
		local enemy_career = lua_monster.configDict[monsterId].career

		if enemy_career ~= 5 and enemy_career ~= 6 then
			enemy_career_tab[enemy_career] = (enemy_career_tab[enemy_career] or 0) + 1
		end
	else
		for i, v in ipairs(monsterGroupIds) do
			if not string.nilorempty(lua_monster_group.configDict[v].bossId) then
				is_boss = lua_monster_group.configDict[v].bossId
			end

			local ids = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[v].monster, "#")

			for index, id in ipairs(ids) do
				if not lua_monster.configDict[id] then
					logError("怪物表找不到id:" .. id)
				end

				local enemy_career = lua_monster.configDict[id].career

				if enemy_career ~= 5 and enemy_career ~= 6 then
					enemy_career_tab[enemy_career] = (enemy_career_tab[enemy_career] or 0) + 1

					if FightHelper.isBossId(lua_monster_group.configDict[v].bossId, id) then
						enemy_career_tab[enemy_career] = (enemy_career_tab[enemy_career] or 0) + 1
					end
				end
			end
		end
	end

	local recommended = {}
	local counter = {}

	if isSpScene then
		return recommended, counter
	end

	if #recommended == 0 then
		local more_than_2 = 0
		local less_than_2 = 0
		local data_less_than_2 = {}
		local data_more_than_2 = {}

		for k, v in pairs(enemy_career_tab) do
			if v >= 2 then
				more_than_2 = more_than_2 + 1

				table.insert(data_more_than_2, k)
			else
				less_than_2 = less_than_2 + 1

				table.insert(data_less_than_2, k)
			end
		end

		if more_than_2 == 1 then
			table.insert(recommended, FightConfig.instance:restrainedBy(data_more_than_2[1]))
			table.insert(counter, FightConfig.instance:restrained(data_more_than_2[1]))
		elseif more_than_2 == 2 then
			if FightHelper.checkHadRestrain(data_more_than_2[1], data_more_than_2[2]) then
				table.insert(recommended, FightConfig.instance:restrainedBy(data_more_than_2[1]))
				table.insert(recommended, FightConfig.instance:restrainedBy(data_more_than_2[2]))
				table.insert(counter, FightConfig.instance:restrained(data_more_than_2[1]))
				table.insert(counter, FightConfig.instance:restrained(data_more_than_2[2]))
			end
		elseif more_than_2 == 0 then
			if less_than_2 == 1 then
				table.insert(recommended, FightConfig.instance:restrainedBy(data_less_than_2[1]))
				table.insert(counter, FightConfig.instance:restrained(data_less_than_2[1]))
			elseif less_than_2 == 2 and FightHelper.checkHadRestrain(data_less_than_2[1], data_less_than_2[2]) then
				table.insert(recommended, FightConfig.instance:restrainedBy(data_less_than_2[1]))
				table.insert(recommended, FightConfig.instance:restrainedBy(data_less_than_2[2]))
				table.insert(counter, FightConfig.instance:restrained(data_less_than_2[1]))
				table.insert(counter, FightConfig.instance:restrained(data_less_than_2[2]))
			end
		end
	end

	for i = #counter, 1, -1 do
		if tabletool.indexOf(recommended, counter[1]) then
			table.remove(counter, i)
		end
	end

	return recommended, counter
end

function FightHelper.checkHadRestrain(career1, career2)
	return FightConfig.instance:getRestrain(career1, career2) > 1000 or FightConfig.instance:getRestrain(career2, career1) > 1000
end

function FightHelper.checkIsTowerDeepEpisode()
	local fight_param = FightModel.instance:getFightParam()

	if not fight_param or not fight_param.episodeId then
		return false
	end

	local isDeepEpisode = TowerPermanentDeepModel.instance:checkIsDeepEpisode(fight_param.episodeId)

	return isDeepEpisode
end

function FightHelper.setMonsterGuideFocusState(config)
	local key = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(config)

	PlayerPrefsHelper.setNumber(key, 1)

	if not string.nilorempty(config.completeWithGroup) then
		local arr = FightStrUtil.instance:getSplitCache(config.completeWithGroup, "|")

		for i, v in ipairs(arr) do
			local key_arr = FightStrUtil.instance:getSplitToNumberCache(v, "#")
			local target_config = FightConfig.instance:getMonsterGuideFocusConfig(key_arr[1], key_arr[2], key_arr[3], key_arr[4])

			if target_config then
				local key = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(target_config)

				PlayerPrefsHelper.setNumber(key, 1)
			else
				logError("怪物指引图表找不到id：", key_arr[1], key_arr[2], key_arr[3], key_arr[4])
			end
		end
	end
end

function FightHelper.detectTimelinePlayEffectCondition(fightStepData, condition, target_entity)
	if string.nilorempty(condition) or condition == "0" then
		return true
	end

	if condition == "1" then
		local dead = false

		for i, actEffectData in pairs(fightStepData.actEffect) do
			if actEffectData.effectType == FightEnum.EffectType.DEAD then
				dead = true
			end
		end

		return dead
	end

	local arr = FightStrUtil.instance:getSplitToNumberCache(condition, "#")
	local conditionType = arr[1]

	if conditionType == 2 then
		for _, actEffectData in ipairs(fightStepData.actEffect) do
			if actEffectData.effectType == FightEnum.EffectType.MISS or actEffectData.effectType == FightEnum.EffectType.DAMAGE or actEffectData.effectType == FightEnum.EffectType.CRIT or actEffectData.effectType == FightEnum.EffectType.SHIELD then
				local oneDefender = FightHelper.getEntity(actEffectData.targetId)

				for i = 2, #arr do
					if target_entity then
						if target_entity == oneDefender and FightHelper.detectEntityIncludeBuffType(oneDefender, arr[i]) then
							return true
						end
					elseif FightHelper.detectEntityIncludeBuffType(oneDefender, arr[i]) then
						return true
					end
				end
			end
		end
	end

	if conditionType == 3 then
		local target_entity = FightHelper.getEntity(fightStepData.fromId)

		if target_entity then
			for i = 2, #arr do
				if FightHelper.detectEntityIncludeBuffType(target_entity, arr[i]) then
					return true
				end
			end
		end
	end

	if conditionType == 4 then
		for _, actEffectData in ipairs(fightStepData.actEffect) do
			if actEffectData.effectType == FightEnum.EffectType.MISS or actEffectData.effectType == FightEnum.EffectType.DAMAGE or actEffectData.effectType == FightEnum.EffectType.CRIT or actEffectData.effectType == FightEnum.EffectType.SHIELD then
				local oneDefender = FightHelper.getEntity(actEffectData.targetId)

				for i = 2, #arr do
					if target_entity then
						if target_entity == oneDefender and target_entity.buff and target_entity.buff:haveBuffId(arr[i]) then
							return true
						end
					elseif oneDefender.buff and oneDefender.buff:haveBuffId(arr[i]) then
						return true
					end
				end
			end
		end
	end

	if conditionType == 5 then
		local target_entity = FightHelper.getEntity(fightStepData.fromId)

		if target_entity and target_entity.buff then
			for i = 2, #arr do
				if target_entity.buff:haveBuffId(arr[i]) then
					return true
				end
			end
		end
	end

	if conditionType == 6 then
		for _, actEffectData in ipairs(fightStepData.actEffect) do
			if actEffectData.effectType == FightEnum.EffectType.MISS or actEffectData.effectType == FightEnum.EffectType.DAMAGE or actEffectData.effectType == FightEnum.EffectType.CRIT or actEffectData.effectType == FightEnum.EffectType.SHIELD then
				local oneDefender = FightHelper.getEntity(actEffectData.targetId)

				for i = 2, #arr do
					if target_entity then
						if target_entity == oneDefender then
							local entity_mo = target_entity:getMO()

							if entity_mo and entity_mo.skin == arr[i] then
								return true
							end
						end
					else
						local entity_mo = oneDefender:getMO()

						if entity_mo and entity_mo.skin == arr[i] then
							return true
						end
					end
				end
			end
		end
	end

	if conditionType == 7 then
		for _, actEffectData in ipairs(fightStepData.actEffect) do
			if actEffectData.targetId == fightStepData.fromId and actEffectData.configEffect == arr[2] then
				if actEffectData.configEffect == 30011 then
					if actEffectData.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if conditionType == 8 then
		for _, actEffectData in ipairs(fightStepData.actEffect) do
			if actEffectData.targetId ~= fightStepData.fromId and actEffectData.configEffect == arr[2] then
				if actEffectData.configEffect == 30011 then
					if actEffectData.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if conditionType == 9 then
		local target_entity = FightHelper.getEntity(fightStepData.fromId)

		if target_entity and target_entity.buff then
			for i = 2, #arr do
				if target_entity.buff:haveBuffId(arr[i]) then
					return false
				end
			end

			return true
		end
	elseif conditionType == 10 then
		local count = fightStepData.playerOperationCountForPlayEffectTimeline

		if count and arr[2] == count then
			return true
		end
	elseif conditionType == 11 then
		local compareType = arr[2]
		local num = arr[3]
		local fromEntityData = FightDataHelper.entityMgr:getById(fightStepData.fromId)

		if fromEntityData then
			local powerInfo = fromEntityData:getPowerInfo(FightEnum.PowerType.Power)

			if powerInfo then
				if compareType == 1 then
					return num < powerInfo.num
				elseif compareType == 2 then
					return num > powerInfo.num
				elseif compareType == 3 then
					return powerInfo.num == num
				elseif compareType == 4 then
					return num <= powerInfo.num
				elseif compareType == 5 then
					return num >= powerInfo.num
				end
			end
		end
	elseif conditionType == 12 then
		return fightStepData.playerOperationCountForPlayEffectTimeline == fightStepData.maxPlayerOperationCountForPlayEffectTimeline
	elseif conditionType == 13 then
		for _, actEffectData in ipairs(fightStepData.actEffect) do
			if actEffectData.effectType == FightEnum.EffectType.MISS or actEffectData.effectType == FightEnum.EffectType.DAMAGE or actEffectData.effectType == FightEnum.EffectType.CRIT or actEffectData.effectType == FightEnum.EffectType.SHIELD then
				local oneDefender = FightHelper.getEntity(actEffectData.targetId)

				for i = 2, #arr do
					if target_entity then
						if target_entity == oneDefender then
							local entity_mo = target_entity:getMO()

							if entity_mo and entity_mo.skin == arr[i] then
								return false
							end
						end
					else
						local entity_mo = oneDefender:getMO()

						if entity_mo and entity_mo.skin == arr[i] then
							return false
						end
					end
				end
			end
		end

		return true
	end

	return false
end

function FightHelper.detectEntityIncludeBuffType(entity, buff_type, buffList)
	local entityMO = entity and entity:getMO()

	buffList = buffList or entityMO and entityMO:getBuffList() or {}

	for i, v in ipairs(buffList) do
		local buff_config = lua_skill_buff.configDict[v.buffId]
		local buff_type_config = lua_skill_bufftype.configDict[buff_config.typeId]

		if buff_type == buff_type_config.type then
			return true
		end
	end
end

function FightHelper.hideDefenderBuffEffect(fightStepData, nonActiveKey)
	local config = lua_skin_monster_hide_buff_effect.configDict[fightStepData.actId]
	local hideEntityIdDic = {}

	if config then
		local hideEffectList = {}
		local hideAllEffect

		if config.effectName == "all" then
			hideAllEffect = true
		end

		local hide_effect_names = FightStrUtil.instance:getSplitCache(config.effectName, "#")
		local defenders = FightHelper.getDefenders(fightStepData, true)
		local defEntityIdDic = {}

		for i, v in ipairs(defenders) do
			if not defEntityIdDic[v.id] then
				defEntityIdDic[v.id] = true

				if FightHelper.isAssembledMonster(v) then
					local sideEntitys = FightHelper.getSideEntitys(v:getSide())

					for index, entitys in ipairs(sideEntitys) do
						if FightHelper.isAssembledMonster(entitys) and not defEntityIdDic[entitys.id] then
							defEntityIdDic[entitys.id] = true

							table.insert(defenders, entitys)
						end
					end
				end
			end
		end

		for i, tar_entity in ipairs(defenders) do
			if hideAllEffect then
				local skinSpineEffect = tar_entity.skinSpineEffect

				if skinSpineEffect then
					hideEntityIdDic[tar_entity.id] = tar_entity.id

					if skinSpineEffect._effectWrapDict then
						for index, effect in pairs(skinSpineEffect._effectWrapDict) do
							table.insert(hideEffectList, effect)
						end
					end
				end
			end

			local effect_dic = tar_entity.buff and tar_entity.buff._buffEffectDict

			if effect_dic then
				for k, effect in pairs(effect_dic) do
					if hideAllEffect then
						hideEntityIdDic[tar_entity.id] = tar_entity.id

						table.insert(hideEffectList, effect)
					else
						for index, effect_name in ipairs(hide_effect_names) do
							local url = FightHelper.getEffectUrlWithLod(effect_name)

							if url == effect.path then
								hideEntityIdDic[tar_entity.id] = tar_entity.id

								table.insert(hideEffectList, effect)
							end
						end
					end
				end
			end

			local loopBuffDict = tar_entity.buff and tar_entity.buff._loopBuffEffectWrapDict

			if loopBuffDict then
				for _, effect in pairs(loopBuffDict) do
					if hideAllEffect then
						hideEntityIdDic[tar_entity.id] = tar_entity.id

						table.insert(hideEffectList, effect)
					else
						for index, effect_name in ipairs(hide_effect_names) do
							local url = FightHelper.getEffectUrlWithLod(effect_name)

							if url == effect.path then
								hideEntityIdDic[tar_entity.id] = tar_entity.id

								table.insert(hideEffectList, effect)
							end
						end
					end
				end
			end
		end

		local arr = FightStrUtil.instance:getSplitCache(config.exceptEffect, "#")
		local filterEffect = {}

		for i, v in ipairs(arr) do
			local url = FightHelper.getEffectUrlWithLod(v)

			filterEffect[url] = true
		end

		for i, v in ipairs(hideEffectList) do
			local effectWrap = hideEffectList[i]

			if not filterEffect[effectWrap.path] then
				effectWrap:setActive(false, nonActiveKey)
			end
		end
	end

	return hideEntityIdDic
end

function FightHelper.revertDefenderBuffEffect(entity_ids, nonActiveKey)
	for i, v in ipairs(entity_ids) do
		local tar_entity = FightHelper.getEntity(v)

		if tar_entity then
			if tar_entity.buff then
				tar_entity.buff:showBuffEffects(nonActiveKey)
			end

			if tar_entity.skinSpineEffect then
				tar_entity.skinSpineEffect:showEffects(nonActiveKey)
			end
		end
	end
end

function FightHelper.getEffectAbPath(path)
	if GameResMgr.IsFromEditorDir or string.find(path, "/buff/") or string.find(path, "/always/") then
		return path
	else
		if isDebugBuild and string.find(path, "always") then
			logError(path)
		end

		return SLFramework.FileHelper.GetUnityPath(System.IO.Path.GetDirectoryName(path))
	end
end

function FightHelper.getRolesTimelinePath(timelineName)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getSkillTimeline(timelineName)
	else
		return ResUrl.getRolesTimeline()
	end
end

function FightHelper.getCameraAniPath(resName)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getCameraAnim(resName)
	else
		return ResUrl.getCameraAnimABUrl()
	end
end

function FightHelper.getEntityAniPath(resName)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getEntityAnim(resName)
	else
		return ResUrl.getEntityAnimABUrl()
	end
end

function FightHelper.refreshCombinativeMonsterScaleAndPos(entity, scale)
	local entity_mo = entity:getMO()

	if not entity_mo then
		return
	end

	local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

	if skin_config and skin_config.canHide == 1 then
		-- block empty
	else
		return
	end

	local entity_list = FightHelper.getSideEntitys(entity:getSide())
	local main_body

	for i, entity in ipairs(entity_list) do
		entity:setScale(scale)

		local entity_mo = entity:getMO()

		if entity_mo then
			local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

			if skin_config and skin_config.mainBody == 1 then
				main_body = entity
			end
		end
	end

	if main_body then
		local start_x, start_y, start_z = FightHelper.getEntityStandPos(main_body:getMO())
		local cur_x, cur_y, cur_z = transformhelper.getPos(main_body.go.transform)

		for i, entity in ipairs(entity_list) do
			if entity ~= main_body then
				local entity_x, entity_y, entity_z = FightHelper.getEntityStandPos(entity:getMO())
				local offset_x = entity_x - start_x
				local offset_y = entity_y - start_y
				local offset_z = entity_z - start_z

				transformhelper.setPos(entity.go.transform, offset_x * scale + cur_x, offset_y * scale + cur_y, offset_z * scale + cur_z)
			end
		end
	end
end

function FightHelper.getEntityDefaultIdleAniName(entity)
	local entity_mo = entity:getMO()

	if entity_mo and entity_mo.modelId == 3025 then
		local entity_list = FightHelper.getSideEntitys(entity:getSide(), true)

		for i, v in ipairs(entity_list) do
			local tar_mo = v:getMO()

			if tar_mo.modelId == 3028 then
				return SpineAnimState.idle_special
			end
		end
	end

	return SpineAnimState.idle1
end

FightHelper.XingTiSpineUrl2Special = {
	["roles/500502_xingti2hao/500502_xingti2hao_fight.prefab"] = "roles/500502_xingti2hao_special/500502_xingti2hao_special_fight.prefab",
	["roles/500503_xingti2hao/500503_xingti2hao_fight.prefab"] = "roles/500503_xingti2hao_special/500503_xingti2hao_special_fight.prefab",
	["roles/500501_xingti2hao/500501_xingti2hao_fight.prefab"] = "roles/500501_xingti2hao_special/500501_xingti2hao_special_fight.prefab"
}

function FightHelper.preloadXingTiSpecialUrl(enemyModelIds)
	local show_together = FightHelper.isShowTogether(FightEnum.EntitySide.MySide, {
		3025,
		3028
	})

	if show_together then
		for i, v in ipairs(enemyModelIds) do
			if v == 3025 then
				return 2
			end
		end

		return 1
	end
end

function FightHelper.detectXingTiSpecialUrl(entity)
	if entity:isMySide() then
		local side = entity:getSide()

		return FightHelper.isShowTogether(side, {
			3025,
			3028
		})
	end
end

function FightHelper.isShowTogether(side, hero_ids)
	local list = FightDataHelper.entityMgr:getSideList(side)
	local count = 0

	for i, v in ipairs(list) do
		if tabletool.indexOf(hero_ids, v.modelId) then
			count = count + 1
		end
	end

	if count == #hero_ids then
		return true
	end
end

function FightHelper.getPredeductionExpoint(entity_id)
	local deduct_num = 0

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local tar_entity = FightHelper.getEntity(entity_id)

		if tar_entity then
			local entity_mo = tar_entity:getMO()
			local card_ops = FightDataHelper.operationDataMgr:getOpList()

			for i, v in ipairs(card_ops) do
				if entity_id == v.belongToEntityId and v:isPlayCard() and FightCardDataHelper.isBigSkill(v.skillId) and not FightCardDataHelper.isSkill3(v.cardInfoMO) then
					local cost = true
					local skillConfig = lua_skill.configDict[v.skillId]

					if skillConfig and skillConfig.needExPoint == 1 then
						cost = false
					end

					if cost then
						deduct_num = deduct_num + entity_mo:getUniqueSkillPoint()
					end
				end
			end
		end
	end

	return deduct_num
end

function FightHelper.setBossSkillSpeed(entity_id)
	local tar_entity = FightHelper.getEntity(entity_id)
	local entity_mo = tar_entity and tar_entity:getMO()

	if entity_mo then
		local config = lua_monster_skin.configDict[entity_mo.skin]

		if config and config.bossSkillSpeed == 1 then
			FightModel.instance.useBossSkillSpeed = true

			FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
		end
	end
end

function FightHelper.cancelBossSkillSpeed()
	if FightModel.instance.useBossSkillSpeed then
		FightModel.instance.useBossSkillSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function FightHelper.setTimelineExclusiveSpeed(timeline_name)
	local config = lua_fight_timeline_speed.configDict[timeline_name]

	if config then
		local user_speed = FightModel.instance:getUserSpeed()
		local arr = FightStrUtil.instance:getSplitToNumberCache(config.speed, "#")

		FightModel.instance.useExclusiveSpeed = arr[user_speed]

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function FightHelper.cancelExclusiveSpeed()
	if FightModel.instance.useExclusiveSpeed then
		FightModel.instance.useExclusiveSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function FightHelper.needPlayTransitionAni(tar_entity, animState)
	local entity_mo = tar_entity and tar_entity:getMO()

	if entity_mo then
		local skin = entity_mo.skin
		local config = lua_fight_transition_act.configDict[skin]

		if config then
			local cur_ani = tar_entity.spine:getAnimState()

			if config[cur_ani] and config[cur_ani][animState] then
				return true, config[cur_ani][animState].transitionAct
			end
		end
	end
end

function FightHelper._stepBuffDealStackedBuff(_entityId, instantWorkList, buffCO, next_work)
	local lock_float = false

	if next_work then
		local actEffectData = next_work.actEffectData

		if actEffectData and not FightSkillBuffMgr.instance:hasPlayBuff(actEffectData) then
			local next_buff_co = lua_skill_buff.configDict[actEffectData.buff.buffId]

			if next_buff_co and next_buff_co.id == buffCO.id and actEffectData.effectType == FightEnum.EffectType.BUFFADD then
				lock_float = true
			end
		end
	end

	table.insert(instantWorkList, FunctionWork.New(function()
		local tar_entity = FightHelper.getEntity(_entityId)

		if tar_entity then
			tar_entity.buff.lockFloat = lock_float
		end
	end))
	table.insert(instantWorkList, WorkWaitSeconds.New(0.01))
end

function FightHelper.hideAllEntity()
	local entityList = FightHelper.getAllEntitys()

	for _, entity in ipairs(entityList) do
		entity:setActive(false, true)
		entity:setVisibleByPos(false)
		entity:setAlpha(0, 0)
	end
end

function FightHelper.isBossId(bossId, monsterId)
	local bossIds = FightStrUtil.instance:getSplitToNumberCache(bossId, "#")

	for i, v in ipairs(bossIds) do
		if monsterId == v then
			return true
		end
	end
end

function FightHelper.getCurBossId()
	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
	local bossId = monsterGroupCO and not string.nilorempty(monsterGroupCO.bossId) and monsterGroupCO.bossId or nil

	return bossId
end

function FightHelper.checkIsBossByMonsterId(monsterId)
	local bossId = FightHelper.getCurBossId()

	if not bossId then
		return false
	end

	return FightHelper.isBossId(bossId, monsterId)
end

function FightHelper.setEffectEntitySide(actEffectData, entityMO)
	local version = FightModel.instance:getVersion()

	if version >= 1 then
		return
	end

	local targetId = actEffectData.targetId

	if targetId == FightEntityScene.MySideId then
		entityMO.side = FightEnum.EntitySide.MySide

		return
	elseif targetId == FightEntityScene.EnemySideId then
		entityMO.side = FightEnum.EntitySide.EnemySide

		return
	end

	local targetEntityMO = FightDataHelper.entityMgr:getById(targetId)

	if targetEntityMO then
		entityMO.side = targetEntityMO.side
	end
end

function FightHelper.preloadZongMaoShaLiMianJu(skinId, roleSkinUrlList)
	local path = FightHelper.getZongMaoShaLiMianJuPath(skinId)

	if path then
		table.insert(roleSkinUrlList, path)
	end
end

function FightHelper.setZongMaoShaLiMianJuSpineUrl(skinId, tab)
	local path = FightHelper.getZongMaoShaLiMianJuPath(skinId)

	if path then
		tab[path] = true
	end
end

function FightHelper.getZongMaoShaLiMianJuPath(skinId)
	local skinConfig = lua_skin.configDict[skinId]

	if skinConfig and skinConfig.characterId == 3072 then
		local path = string.format("roles/v1a3_%d_zongmaoshali_m/%d_zongmaoshali_m_fight.prefab", skinId, skinId)

		if skinConfig.id == 307203 then
			path = "roles/v2a2_307203_zmsl_m/307203_zmsl_m_fight.prefab"
		end

		return path
	end
end

function FightHelper.getEnemyEntityByMonsterId(monsterId)
	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for i, entity in ipairs(entityList) do
		local entityMO = entity:getMO()

		if entityMO and entityMO.modelId == monsterId then
			return entity
		end
	end
end

function FightHelper.sortAssembledMonster(model)
	local entityMO = model:getByIndex(1)

	if entityMO then
		local config = lua_fight_assembled_monster.configDict[entityMO.skin]

		if config then
			model:sort(FightHelper.sortAssembledMonsterFunc)
		end
	end
end

function FightHelper.sortAssembledMonsterFunc(item1, item2)
	local config1 = item1 and lua_fight_assembled_monster.configDict[item1.skin]
	local config2 = item2 and lua_fight_assembled_monster.configDict[item2.skin]

	if config1 and not config2 then
		return true
	elseif not config1 and config2 then
		return false
	elseif config1 and config2 then
		return config1.part < config2.part
	else
		return tonumber(item1.id) > tonumber(item2.id)
	end
end

function FightHelper.sortBuffReplaceSpineActConfig(item1, item2)
	return item1.priority > item2.priority
end

function FightHelper.processEntityActionName(entity, actName, fightStepData)
	if not actName then
		return
	end

	local entityMO = entity:getMO()

	if entityMO then
		local config = lua_fight_buff_replace_spine_act.configDict[entityMO.skin]

		if config then
			local list = {}

			for i, v in pairs(config) do
				for key, value in pairs(v) do
					table.insert(list, value)
				end
			end

			table.sort(list, FightHelper.sortBuffReplaceSpineActConfig)

			local buffComp = entity.buff

			if buffComp then
				for i, v in ipairs(list) do
					if buffComp:haveBuffId(v.buffId) then
						local count = 0

						for index, buffId in ipairs(v.combination) do
							if buffComp:haveBuffId(buffId) then
								count = count + 1
							end
						end

						if count == #v.combination and entity.spine and entity.spine:hasAnimation(actName .. v.suffix) then
							actName = actName .. v.suffix

							break
						end
					end
				end
			end
		end
	end

	if actName and entityMO then
		local skinBehaviourConfig = lua_fight_skin_special_behaviour.configDict[entityMO.skin]

		if skinBehaviourConfig then
			local buffComp = entity.buff

			if buffComp then
				local tempActName = actName

				if string.find(tempActName, "hit") then
					tempActName = "hit"
				end

				if not string.nilorempty(skinBehaviourConfig[tempActName]) then
					local arr = GameUtil.splitString2(skinBehaviourConfig[tempActName])

					for i, v in ipairs(arr) do
						local buffId = tonumber(v[1])

						if buffComp:haveBuffId(buffId) then
							actName = v[2]
						end
					end
				end
			end
		end
	end

	if FightHelper.isAssembledMonster(entity) and actName == "hit" then
		local index = entity:getPartIndex()

		if fightStepData then
			for i, v in ipairs(fightStepData.actEffect) do
				if FightTLEventDefHit.directCharacterHitEffectType[v.effectType] and v.targetId ~= entity.id then
					local targetEntity = FightHelper.getEntity(v.targetId)

					if isTypeOf(targetEntity, FightEntityAssembledMonsterMain) or isTypeOf(targetEntity, FightEntityAssembledMonsterSub) then
						return actName
					end
				end
			end
		end

		actName = string.format("%s_part_%d", actName, index)
	end

	return actName
end

function FightHelper.getProcessEntityStancePos(entityMO)
	local posX, posY, posZ = FightHelper.getEntityStandPos(entityMO)
	local entity = FightHelper.getEntity(entityMO.id)

	if entity and FightHelper.isAssembledMonster(entity) then
		local config = lua_fight_assembled_monster.configDict[entityMO.skin]
		local stanceOffset = config.virtualStance

		return posX + stanceOffset[1], posY + stanceOffset[2], posZ + stanceOffset[3]
	end

	return posX, posY, posZ
end

function FightHelper.isAssembledMonster(entity)
	if isTypeOf(entity, FightEntityAssembledMonsterMain) or isTypeOf(entity, FightEntityAssembledMonsterSub) then
		return true
	end
end

function FightHelper.isPata500mMonster(entity)
	local entityMo = entity and entity:getMO()

	if not entityMo then
		return false
	end

	local modelCo = lua_fight_sp_500m_model.configDict[entityMo.modelId]

	return modelCo ~= nil
end

function FightHelper.getProcessEntitySpinePos(entity)
	local posX, posY, posZ = transformhelper.getPos(entity.go.transform)

	if FightHelper.isAssembledMonster(entity) then
		local entityMO = entity:getMO()
		local config = lua_fight_assembled_monster.configDict[entityMO.skin]

		posX = posX + config.virtualStance[1]
		posY = posY + config.virtualStance[2]
		posZ = posZ + config.virtualStance[3]
	elseif FightHelper.isPata500mMonster(entity) then
		local offsetX, offsetY, offsetZ = entity.spine:getCenterSpineOffset()

		posX = posX + offsetX
		posY = posY + offsetY
		posZ = posZ + offsetZ
	end

	return posX, posY, posZ
end

function FightHelper.getProcessEntitySpineLocalPos(entity)
	local posX, posY, posZ = 0, 0, 0

	if FightHelper.isAssembledMonster(entity) then
		local entityMO = entity:getMO()
		local config = lua_fight_assembled_monster.configDict[entityMO.skin]

		posX = posX + config.virtualStance[1]
		posY = posY + config.virtualStance[2]
		posZ = posZ + config.virtualStance[3]
	end

	return posX, posY, posZ
end

local assembledFilterEffectNameOfSpineHangPointRoot = {}

function FightHelper.getAssembledEffectPosOfSpineHangPointRoot(entity, effectName)
	if assembledFilterEffectNameOfSpineHangPointRoot[effectName] then
		return 0, 0, 0
	end

	return FightHelper.getProcessEntitySpineLocalPos(entity)
end

function FightHelper.processBuffEffectPath(path, entity, buffId, fieldName, audioId)
	local config = lua_fight_effect_buff_skin.configDict[buffId]

	if config then
		local fieldName2Audio = {
			delEffect = "delAudio",
			effectPath = "audio",
			triggerEffect = "triggerAudio"
		}
		local side = entity:getSide()

		if config[1] then
			side = FightEnum.EntitySide.MySide == side and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
			config = config[1]
		else
			config = config[2]
		end

		local entityList = FightHelper.getSideEntitys(side, true)

		for i, v in ipairs(entityList) do
			local entityMO = v:getMO()

			if entityMO then
				local skin = entityMO.skin

				if config[skin] and not string.nilorempty(config[skin][fieldName]) then
					local replaceAudio = config[skin][fieldName2Audio[fieldName]]

					return config[skin][fieldName], replaceAudio ~= 0 and replaceAudio or audioId, config[skin]
				end
			end
		end
	end

	return path, audioId
end

function FightHelper.filterBuffEffectBySkin(buffId, entity, buffEffectPath, audioId)
	local co = lua_fight_buff_effect_to_skin.configDict[buffId]

	if not co then
		return buffEffectPath, audioId
	end

	local entityMo = entity and entity:getMO()
	local skinId = entityMo and entityMo.skin

	if not skinId then
		return "", 0
	end

	local skinIdList = FightStrUtil.instance:getSplitToNumberCache(co.skinIdList, "|")

	if tabletool.indexOf(skinIdList, skinId) then
		return buffEffectPath, audioId
	end

	return "", 0
end

function FightHelper.getBuffListForReplaceTimeline(config, entityDataDic, fightStepData)
	local buffDic = FightHelper.getEntitysCloneBuff(entityDataDic)

	if config and config.simulate == 1 then
		buffDic = FightHelper.simulateFightStepData(fightStepData, buffDic)
	end

	local buffList = {}

	for i, v in pairs(buffDic) do
		tabletool.addValues(buffList, v)
	end

	return buffList
end

function FightHelper.getTimelineListByName(timelineName, skin)
	local originTimelineName = timelineName
	local list = {}
	local configDict = lua_fight_replace_timeline.configDict[timelineName]

	if configDict then
		for k, v in pairs(configDict) do
			local condition = FightStrUtil.instance:getSplitCache(v.condition, "#")
			local sign = condition[1]

			if sign == "5" then
				local conditionDic = {}

				for i = 2, #condition do
					conditionDic[tonumber(condition[i])] = true
				end

				if conditionDic[skin] then
					originTimelineName = v.timeline
				end
			else
				table.insert(list, v.timeline)
			end
		end
	end

	table.insert(list, originTimelineName)

	return list
end

local lastRandomTimeline = {}

function FightHelper.detectReplaceTimeline(timelineName, fightStepData)
	local configDict = lua_fight_replace_timeline.configDict[timelineName]

	if configDict then
		local configList = {}

		for k, v in pairs(configDict) do
			table.insert(configList, v)
		end

		table.sort(configList, FightHelper.sortReplaceTimelineConfig)

		for j, config in ipairs(configList) do
			local entityDataDic = {}

			if config.target == 1 then
				entityDataDic[fightStepData.fromId] = FightDataHelper.entityMgr:getById(fightStepData.fromId)
			elseif config.target == 2 then
				entityDataDic[fightStepData.toId] = FightDataHelper.entityMgr:getById(fightStepData.toId)
			elseif config.target == 3 or config.target == 4 then
				local fromSide
				local fromId = fightStepData.fromId

				if fromId == FightEntityScene.MySideId then
					fromSide = FightEnum.EntitySide.MySide
				elseif fromId == FightEntityScene.EnemySideId then
					fromSide = FightEnum.EntitySide.EnemySide
				else
					local entityMo = FightDataHelper.entityMgr:getById(fightStepData.fromId)

					if entityMo then
						fromSide = entityMo.side
					else
						fromSide = FightEnum.EntitySide.MySide
					end
				end

				local dataList = FightDataHelper.entityMgr:getSideList(fromSide, nil, config.target == 4)

				for i, v in ipairs(dataList) do
					entityDataDic[v.id] = v
				end
			end

			local condition = FightStrUtil.instance:getSplitCache(config.condition, "#")
			local sign = condition[1]

			if sign == "1" then
				local buffList = FightHelper.getBuffListForReplaceTimeline(config, entityDataDic, fightStepData)
				local buffId = tonumber(condition[2])
				local count = tonumber(condition[3])

				for index, buffMO in ipairs(buffList) do
					if buffMO.buffId == buffId and count <= buffMO.count then
						return config.timeline
					end
				end
			elseif sign == "2" then
				for i, actEffectData in pairs(fightStepData.actEffect) do
					if actEffectData.effectType == FightEnum.EffectType.DEAD then
						return config.timeline
					end
				end
			elseif sign == "3" then
				local buffList = FightHelper.getBuffListForReplaceTimeline(config, entityDataDic, fightStepData)

				for i = 2, #condition do
					if FightHelper.detectEntityIncludeBuffType(nil, tonumber(condition[i]), buffList) then
						return config.timeline
					end
				end
			elseif sign == "4" then
				local conditionDic = {}

				for i = 2, #condition do
					conditionDic[tonumber(condition[i])] = true
				end

				local buffList = FightHelper.getBuffListForReplaceTimeline(config, entityDataDic, fightStepData)

				for index, buffMO in ipairs(buffList) do
					if conditionDic[buffMO.buffId] then
						return config.timeline
					end
				end
			elseif sign == "5" then
				local conditionDic = {}

				for i = 2, #condition do
					conditionDic[tonumber(condition[i])] = true
				end

				for k, entityMO in pairs(entityDataDic) do
					local tempSkin = entityMO.skin

					if config.target == 1 then
						tempSkin = FightHelper.processSkinByStepData(fightStepData, entityMO)
					end

					if entityMO and conditionDic[tempSkin] then
						return config.timeline
					end
				end
			elseif sign == "6" then
				local conditionDic = {}

				for i = 2, #condition do
					conditionDic[tonumber(condition[i])] = true
				end

				for index, actEffectData in ipairs(fightStepData.actEffect) do
					if entityDataDic[actEffectData.targetId] and conditionDic[actEffectData.configEffect] then
						return config.timeline
					end
				end
			elseif sign == "7" then
				local conditionDic = {}

				for i = 2, #condition do
					conditionDic[tonumber(condition[i])] = true
				end

				local buffList = FightHelper.getBuffListForReplaceTimeline(config, entityDataDic, fightStepData)

				for index, buffMO in ipairs(buffList) do
					if conditionDic[buffMO.buffId] then
						return timelineName
					end
				end

				return config.timeline
			elseif sign == "8" then
				local buffId = tonumber(condition[2])
				local count = tonumber(condition[3])
				local buffDic = FightHelper.getEntitysCloneBuff(entityDataDic)

				if config.simulate == 1 then
					local buffList = FightHelper.getBuffListForReplaceTimeline(nil, entityDataDic, fightStepData)

					for index, buffMO in ipairs(buffList) do
						if buffMO.buffId == buffId and count <= buffMO.count then
							return config.timeline
						end
					end

					buffDic = FightHelper.simulateFightStepData(fightStepData, buffDic, FightHelper.detectBuffCountEnough, {
						buffId = buffId,
						count = count
					})

					if buffDic == true then
						return config.timeline
					end
				else
					local buffList = FightHelper.getBuffListForReplaceTimeline(config, entityDataDic, fightStepData)

					for index, buffMO in ipairs(buffList) do
						if buffMO.buffId == buffId and count <= buffMO.count then
							return config.timeline
						end
					end
				end
			elseif sign == "9" then
				local list = {}

				for i, v in ipairs(configList) do
					local tarSkin = tonumber(string.split(v.condition, "#")[2])

					for k, entityMO in pairs(entityDataDic) do
						local tempSkin = entityMO.skin

						if config.target == 1 then
							tempSkin = FightHelper.processSkinByStepData(fightStepData, entityMO)
						end

						if tempSkin == tarSkin then
							table.insert(list, v)
						end
					end
				end

				local listCount = #list

				if listCount > 1 then
					local lastIndex = lastRandomTimeline[timelineName]

					while true do
						local random = math.random(1, listCount)

						if random ~= lastIndex then
							lastRandomTimeline[timelineName] = random

							return list[random].timeline
						end
					end
				elseif listCount > 0 then
					return list[1].timeline
				end
			elseif sign == "10" then
				local selectCondition = tonumber(condition[2])

				if selectCondition == 1 then
					if fightStepData.fromId == fightStepData.toId then
						return config.timeline
					end
				elseif selectCondition == 2 and fightStepData.fromId ~= fightStepData.toId then
					return config.timeline
				end
			elseif sign == "11" then
				local conditionDic = {}
				local checkSkin = tonumber(condition[2])

				for i = 3, #condition do
					conditionDic[tonumber(condition[i])] = true
				end

				for k, entityMO in pairs(entityDataDic) do
					local tempSkin = entityMO.skin

					if config.target == 1 then
						tempSkin = FightHelper.processSkinByStepData(fightStepData, entityMO)
					end

					if checkSkin == tempSkin then
						local buffList = FightHelper.getBuffListForReplaceTimeline(config, entityDataDic, fightStepData)

						for b_index, buffMO in ipairs(buffList) do
							if conditionDic[buffMO.buffId] then
								return config.timeline
							end
						end
					end
				end
			elseif sign == "12" then
				local conditionDic = {}

				for i = 2, #condition - 1 do
					conditionDic[tonumber(condition[i])] = true
				end

				for k, entityMO in pairs(entityDataDic) do
					local tempSkin = entityMO.skin

					if config.target == 1 then
						tempSkin = FightHelper.processSkinByStepData(fightStepData, entityMO)
					end

					if entityMO and conditionDic[tempSkin] then
						local toIdType = condition[#condition]

						if toIdType == "1" then
							if fightStepData.fromId == fightStepData.toId then
								return config.timeline
							end
						elseif toIdType == "2" then
							local fromEntityMO = FightDataHelper.entityMgr:getById(fightStepData.fromId)
							local toEntityMO = FightDataHelper.entityMgr:getById(fightStepData.toId)

							if fromEntityMO and toEntityMO and fromEntityMO.id ~= toEntityMO.id and fromEntityMO.side == toEntityMO.side then
								return config.timeline
							end
						elseif toIdType == "3" then
							local fromEntityMO = FightDataHelper.entityMgr:getById(fightStepData.fromId)
							local toEntityMO = FightDataHelper.entityMgr:getById(fightStepData.toId)

							if fromEntityMO and toEntityMO and fromEntityMO.side ~= toEntityMO.side then
								return config.timeline
							end
						end
					end
				end
			elseif sign == "13" then
				return FightHelper.getBLETimeLine(timelineName, fightStepData)
			end
		end
	end

	return timelineName
end

FightHelper.TempMaxCrystalList = {}

function FightHelper.getBLETimeLine(timelineName, fightStepData)
	local entityMo = FightDataHelper.entityMgr:getById(fightStepData.fromId)
	local side = entityMo and entityMo.side
	local heatScale = side and FightDataHelper.getHeatScale(side)

	if not heatScale then
		return timelineName
	end

	local blue, purple, green = heatScale:getCrystalNum()
	local max = math.max(blue, purple, green)
	local maxCrystalList = FightHelper.TempMaxCrystalList

	tabletool.clear(maxCrystalList)

	if max <= blue then
		table.insert(maxCrystalList, FightEnum.CrystalEnum.Blue)
	end

	if max <= purple then
		table.insert(maxCrystalList, FightEnum.CrystalEnum.Purple)
	end

	if max <= green then
		table.insert(maxCrystalList, FightEnum.CrystalEnum.Green)
	end

	local crystal = maxCrystalList[1]

	if #maxCrystalList > 1 then
		crystal = maxCrystalList[math.random(1, #maxCrystalList)]
	end

	local co = FightHeroSpEffectConfig.instance:getBLECrystalCo(crystal)

	return co.skill3Timeline
end

function FightHelper.detectBuffCountEnough(buffList, param)
	local buffId = param.buffId
	local count = param.count

	for i, v in ipairs(buffList) do
		if buffId == v.buffId and count <= v.count then
			return true
		end
	end
end

function FightHelper.simulateFightStepData(fightStepData, buffDic, func, param)
	for index, actEffectData in ipairs(fightStepData.actEffect) do
		local entityId = actEffectData.targetId
		local tarEntity = FightHelper.getEntity(entityId)
		local entityMO = tarEntity and tarEntity:getMO()
		local buffList = buffDic and buffDic[entityId]

		if entityMO and buffList then
			if actEffectData.effectType == FightEnum.EffectType.BUFFADD then
				local hasUid = entityMO:getBuffMO(actEffectData.buff.uid)

				if not hasUid then
					local buffMO = FightBuffInfoData.New(actEffectData.buff, actEffectData.targetId)

					table.insert(buffList, buffMO)
				end

				if func and func(buffList, param) then
					return true
				end
			elseif actEffectData.effectType == FightEnum.EffectType.BUFFDEL or actEffectData.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
				for i, buffMO in ipairs(buffList) do
					if buffMO.uid == actEffectData.buff.uid then
						table.remove(buffList, i)

						break
					end
				end

				if func and func(buffList, param) then
					return true
				end
			elseif actEffectData.effectType == FightEnum.EffectType.BUFFUPDATE then
				for i, buffMO in ipairs(buffList) do
					if buffMO.uid == actEffectData.buff.uid then
						FightDataUtil.coverData(actEffectData.buff, buffMO)
					end
				end

				if func and func(buffList, param) then
					return true
				end
			end
		end
	end

	return buffDic
end

function FightHelper.getEntitysCloneBuff(entityDataDic)
	local buffDic = {}

	for k, entityMO in pairs(entityDataDic) do
		local buffList = {}
		local list = entityMO:getBuffList()

		for index, buffMO in ipairs(list) do
			local clone = buffMO:clone()

			table.insert(buffList, clone)
		end

		buffDic[entityMO.id] = buffList
	end

	return buffDic
end

function FightHelper.sortReplaceTimelineConfig(item1, item2)
	return item1.priority < item2.priority
end

function FightHelper.getMagicSide(entityId)
	local targetEntityMO = FightDataHelper.entityMgr:getById(entityId)

	if targetEntityMO then
		return targetEntityMO.side
	elseif entityId == FightEntityScene.MySideId then
		return FightEnum.EntitySide.MySide
	elseif entityId == FightEntityScene.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	end

	return FightEnum.EntitySide.MySide
end

function FightHelper.isBossRushChannelSkill(skillId)
	local skillConfig = lua_skill.configDict[skillId]

	if skillConfig then
		local skillEffect = skillConfig.skillEffect
		local skillEffectConfig = lua_skill_effect.configDict[skillEffect]

		if skillEffectConfig then
			for i = 1, FightEnum.MaxBehavior do
				local behavior = skillEffectConfig["behavior" .. i]

				if not string.nilorempty(behavior) then
					local arr = FightStrUtil.instance:getSplitCache(behavior, "#")

					if arr[1] == "1" then
						local buffId = tonumber(arr[2])
						local buffConfig = lua_skill_buff.configDict[buffId]

						if buffConfig then
							local arr = FightStrUtil.instance:getSplitCache(buffConfig.features, "#")

							if arr[1] == "742" then
								return true, tonumber(arr[2]), tonumber(arr[5])
							end
						end
					end
				end
			end
		end
	end
end

function FightHelper.processEntitySkin(skin, uid)
	local heroMo = HeroModel.instance:getById(uid)

	if heroMo and heroMo.skin > 0 then
		return heroMo.skin
	end

	return skin
end

function FightHelper.isPlayerCardSkill(fightStepData)
	if not fightStepData.cardIndex then
		return
	end

	if fightStepData.cardIndex == 0 then
		return
	end

	local fromId = fightStepData.fromId

	if fromId == FightEntityScene.MySideId then
		return true
	end

	local entityMO = FightDataHelper.entityMgr:getById(fromId)

	if not entityMO then
		return
	end

	return entityMO.teamType == FightEnum.TeamType.MySide
end

function FightHelper.isEnemyCardSkill(fightStepData)
	if not fightStepData.cardIndex then
		return
	end

	if fightStepData.cardIndex == 0 then
		return
	end

	local fromId = fightStepData.fromId

	if fromId == FightEntityScene.EnemySideId then
		return true
	end

	local entityMO = FightDataHelper.entityMgr:getById(fromId)

	if not entityMO then
		return
	end

	return entityMO.teamType == FightEnum.TeamType.EnemySide
end

function FightHelper.buildMonsterA2B(entity, oldEntityMO, fightFlow, work)
	local config = lua_fight_boss_evolution_client.configDict[oldEntityMO.skin]

	fightFlow:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.BeforeMonsterA2B, oldEntityMO.modelId))

	if config then
		fightFlow:addWork(Work2FightWork.New(FightWorkPlayTimeline, entity, config.timeline))

		if config.nextSkinId ~= 0 then
			fightFlow:registWork(FightWorkFunction, FightHelper.setBossEvolution, FightHelper, entity, config)
		else
			fightFlow:registWork(FightWorkFunction, FightHelper.removeEntity, entity.id)
		end
	end

	if work then
		fightFlow:addWork(work)
	end

	fightFlow:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.AfterMonsterA2B, oldEntityMO.modelId))
end

function FightHelper.removeEntity(entityId)
	local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	local entity = FightHelper.getEntity(entityId)

	if entity then
		entityMgr:removeUnit(entity:getTag(), entity.id)
	end
end

function FightHelper.setBossEvolution(fighthelper, entity, config)
	FightController.instance:dispatchEvent(FightEvent.SetBossEvolution, entity, config.nextSkinId)
	FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, entity, config.nextSkinId)

	local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	local tarEntity = FightHelper.getEntity(entity.id)

	if tarEntity == entity then
		entityMgr:removeUnitData(entity:getTag(), entity.id)
	end
end

function FightHelper.buildDeadPerformanceWork(config, entity)
	local fightFlow = FlowSequence.New()

	for i = 1, FightEnum.DeadPerformanceMaxNum do
		local actType = config["actType" .. i]
		local param = config["actParam" .. i]

		if actType == 0 then
			break
		end

		if actType == 1 then
			fightFlow:addWork(FightWorkPlayTimeline.New(entity, param))
		elseif actType == 2 then
			fightFlow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.DeadPerformanceNoCondition, tonumber(param)))
		end
	end

	return fightFlow
end

function FightHelper.compareData(data1, data2, filterKey)
	local valType = type(data1)

	if valType == "function" then
		return true
	elseif valType == "table" then
		for k, v in pairs(data1) do
			local continue = false

			if type(k) == "table" then
				continue = true
			end

			if filterKey and filterKey[k] then
				continue = true
			end

			if not data2 then
				return false
			end

			if type(data2) ~= "table" then
				return false
			end

			if not continue and not FightHelper.compareData(v, data2[k], filterKey) then
				return false, k, v, data2[k]
			end
		end

		return true
	else
		return data1 == data2
	end
end

local logTabCount = 0

function FightHelper.logStr(data, filterKey)
	local str = ""

	logTabCount = 0

	if type(data) == "table" then
		str = str .. FightHelper.logTable(data, filterKey)
	else
		str = str .. tostring(data)
	end

	return str
end

function FightHelper.logTable(data, filterKey)
	local str = ""

	str = str .. "{\n"
	logTabCount = logTabCount + 1

	local tabLen = tabletool.len(data)
	local count = 0

	for k, v in pairs(data) do
		local continue = false

		if filterKey and filterKey[k] then
			continue = true
		end

		if not continue then
			for i = 1, logTabCount do
				str = str .. "\t"
			end

			str = str .. k .. " = "

			if type(v) == "table" then
				str = str .. FightHelper.logTable(v, filterKey)
			else
				str = str .. tostring(v)
			end

			count = count + 1

			if count < tabLen then
				str = str .. ","
			end

			str = str .. "\n"
		end
	end

	logTabCount = logTabCount - 1

	for i = 1, logTabCount do
		str = str .. "\t"
	end

	str = str .. "}"

	return str
end

function FightHelper.deepCopySimpleWithMeta(obj, filterKey)
	if type(obj) ~= "table" then
		return obj
	else
		local table = {}

		for k, v in pairs(obj) do
			local continue = false

			if filterKey and filterKey[k] then
				continue = true
			end

			if not continue then
				table[k] = FightHelper.deepCopySimpleWithMeta(v, filterKey)
			end
		end

		local meta = getmetatable(obj)

		if meta then
			setmetatable(table, meta)
		end

		return table
	end
end

function FightHelper.getPassiveSkill(entityId, skillId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		return skillId
	end

	local upgradedOptions = entityMO.upgradedOptions

	if upgradedOptions then
		for k, v in pairs(upgradedOptions) do
			local config = lua_hero_upgrade_options.configDict[v]

			if config and not string.nilorempty(config.replacePassiveSkill) then
				local arr = GameUtil.splitString2(config.replacePassiveSkill, true)

				for index, value in ipairs(arr) do
					if skillId == value[1] and entityMO:isPassiveSkill(value[2]) then
						return value[2]
					end
				end
			end
		end
	end

	return skillId
end

function FightHelper.isSupportCard(cardInfoMO)
	if cardInfoMO.cardType == FightEnum.CardType.SUPPORT_NORMAL or cardInfoMO.cardType == FightEnum.CardType.SUPPORT_EX then
		return true
	end
end

function FightHelper.curIsRougeFight()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local chapterId = fightParam.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	return chapterCo and chapterCo.type == DungeonEnum.ChapterType.Rouge
end

function FightHelper.processSkinByStepData(fightStepData, entityMO)
	entityMO = entityMO or FightDataHelper.entityMgr:getById(fightStepData.fromId)

	local modelId = fightStepData.supportHeroId

	if modelId ~= 0 and entityMO and entityMO.modelId ~= modelId then
		if FightHelper.curIsRougeFight() then
			local teamInfo = RougeModel.instance:getTeamInfo()
			local heroMo = teamInfo and teamInfo:getAssistHeroMo(modelId)

			if heroMo then
				return heroMo.skin
			end
		end

		local heroMo = HeroModel.instance:getByHeroId(modelId)

		if heroMo and heroMo.skin > 0 then
			return heroMo.skin
		else
			local heroConfig = lua_character.configDict[modelId]

			if heroConfig then
				return heroConfig.skinId
			end
		end
	end

	return entityMO and entityMO.skin or 0
end

function FightHelper.processSkinId(entityMO, cardInfoMO)
	if (cardInfoMO.cardType == FightEnum.CardType.SUPPORT_NORMAL or cardInfoMO.cardType == FightEnum.CardType.SUPPORT_EX) and cardInfoMO.heroId ~= entityMO.modelId then
		local heroMo = HeroModel.instance:getByHeroId(cardInfoMO.heroId)

		if heroMo and heroMo.skin > 0 then
			return heroMo.skin
		else
			local heroConfig = lua_character.configDict[cardInfoMO.heroId]

			if heroConfig then
				return heroConfig.skinId
			end
		end
	end

	return entityMO.skin
end

function FightHelper.processNextSkillId(skillId)
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if episode_config and episode_config.type == DungeonEnum.EpisodeType.Rouge then
		local supportHeroSkill = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.SupportHeroSkill)

		if supportHeroSkill then
			supportHeroSkill = cjson.decode(supportHeroSkill)

			for k, v in pairs(supportHeroSkill) do
				if v.skill1 then
					for index, value in ipairs(v.skill1) do
						local nextSupportSkill = v.skill1[index + 1]

						if value == skillId and nextSupportSkill then
							return nextSupportSkill
						end
					end
				end

				if v.skill2 then
					for index, value in ipairs(v.skill2) do
						local nextSupportSkill = v.skill2[index + 1]

						if value == skillId and nextSupportSkill then
							return nextSupportSkill
						end
					end
				end
			end
		end
	end
end

function FightHelper.isTimelineStep(step)
	if step and step.actType == FightEnum.ActType.SKILL then
		local entityMO = FightDataHelper.entityMgr:getById(step.fromId)
		local skinId = entityMO and entityMO.skin
		local timeline = FightConfig.instance:getSkinSkillTimeline(skinId, step.actId)

		if not string.nilorempty(timeline) then
			return true
		end
	end
end

function FightHelper.getClickEntity(entityList, transform, screenPosition)
	table.sort(entityList, FightHelper.sortEntityList)

	for i, entity in ipairs(entityList) do
		local entityMO = entity:getMO()

		if entityMO then
			local halfWidth, leftX, rightX, halfHeight, bottomY, topY, rectPosX, rectPosY
			local tarEntity = FightHelper.getEntity(entityMO.id)

			if isTypeOf(tarEntity, FightEntityAssembledMonsterMain) or isTypeOf(tarEntity, FightEntityAssembledMonsterSub) then
				local config = lua_fight_assembled_monster.configDict[entityMO.skin]
				local entityPosX, entityPosY, entityPosZ = transformhelper.getPos(entity.go.transform)

				entityPosX = entityPosX + config.virtualSpinePos[1]
				entityPosY = entityPosY + config.virtualSpinePos[2]
				entityPosZ = entityPosZ + config.virtualSpinePos[3]
				rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(entityPosX, entityPosY, entityPosZ, transform)

				local halfX = config.virtualSpineSize[1] * 0.5
				local halfY = config.virtualSpineSize[2] * 0.5
				local worldPos1X = entityPosX - halfX
				local worldPos1Y = entityPosY - halfY
				local worldPos1Z = entityPosZ
				local worldPos2X = entityPosX + halfX
				local worldPos2Y = entityPosY + halfY
				local worldPos2Z = entityPosZ
				local rectPos1X, rectPos1Y, rectPos1Z = recthelper.worldPosToAnchorPosXYZ(worldPos1X, worldPos1Y, worldPos1Z, transform)
				local rectPos2X, rectPos2Y, rectPos2Z = recthelper.worldPosToAnchorPosXYZ(worldPos2X, worldPos2Y, worldPos2Z, transform)

				halfWidth = (rectPos2X - rectPos1X) / 2
				leftX = rectPosX - halfWidth
				rightX = rectPosX + halfWidth
				halfHeight = (rectPos2Y - rectPos1Y) / 2
				bottomY = rectPosY - halfHeight
				topY = rectPosY + halfHeight
			else
				local rectPos1X, rectPos1Y, rectPos2X, rectPos2Y = FightHelper.calcRect(entity, transform)
				local mountmiddleGO = entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

				if mountmiddleGO then
					local trposX, trposY, trposZ = transformhelper.getPos(mountmiddleGO.transform)

					rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(trposX, trposY, trposZ, transform)
				else
					rectPosX = (rectPos1X + rectPos2X) / 2
					rectPosY = (rectPos1Y + rectPos2Y) / 2
				end

				local width = math.abs(rectPos1X - rectPos2X)
				local height = math.abs(rectPos1Y - rectPos2Y)
				local monsterSkinCO = lua_monster_skin.configDict[entityMO.skin]
				local clickBoxUnlimit = monsterSkinCO and monsterSkinCO.clickBoxUnlimit == 1
				local maxWidth = clickBoxUnlimit and 800 or 200
				local maxHeight = clickBoxUnlimit and 800 or 500
				local fixWidth = Mathf.Clamp(width, 150, maxWidth)
				local fixHeight = Mathf.Clamp(height, 150, maxHeight)

				halfWidth = fixWidth / 2
				leftX = rectPosX - halfWidth
				rightX = rectPosX + halfWidth
				halfHeight = fixHeight / 2
				bottomY = rectPosY - halfHeight
				topY = rectPosY + halfHeight
			end

			local clickPosX, clickPosY = recthelper.screenPosToAnchorPos2(screenPosition, transform)

			if leftX <= clickPosX and clickPosX <= rightX and bottomY <= clickPosY and clickPosY <= topY then
				return entity.id, rectPosX, rectPosY
			end
		end
	end
end

FightHelper.TempSize = {
	x = 0,
	y = 0
}

function FightHelper.calcRect(entity, transform)
	if not entity then
		return 10000, 10000, 10000, 10000
	end

	local bodyStaticGO = entity:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic)

	if not bodyStaticGO then
		return 10000, 10000, 10000, 10000
	end

	local bodyPosX, bodyPosY, bodyPosZ = transformhelper.getPos(bodyStaticGO.transform)
	local entityMo = entity:getMO()
	local skin = entityMo and entityMo.skin
	local clickBoxCo = skin and lua_monster_skin_custom_click_box.configDict[skin]
	local size

	if clickBoxCo then
		size = FightStrUtil.instance:getSplitToNumberCache(clickBoxCo.box, "#")
		FightHelper.TempSize.x = size[1]
		FightHelper.TempSize.y = size[2]
		size = FightHelper.TempSize
	else
		size = FightHelper.getEntityBoxSizeOffsetV2(entity)
	end

	local sideOp = entity:isMySide() and 1 or -1
	local rectPos1X, rectPos1Y = recthelper.worldPosToAnchorPosXYZ(bodyPosX - size.x * 0.5, bodyPosY - size.y * 0.5 * sideOp, bodyPosZ, transform)
	local rectPos2X, rectPos2Y = recthelper.worldPosToAnchorPosXYZ(bodyPosX + size.x * 0.5, bodyPosY + size.y * 0.5 * sideOp, bodyPosZ, transform)

	return rectPos1X, rectPos1Y, rectPos2X, rectPos2Y
end

function FightHelper.sortEntityList(item1, item2)
	local entityMO1 = item1:getMO()
	local entityMO2 = item2:getMO()
	local isAssembled1 = isTypeOf(item1, FightEntityAssembledMonsterMain) or isTypeOf(item1, FightEntityAssembledMonsterSub)
	local isAssembled2 = isTypeOf(item2, FightEntityAssembledMonsterMain) or isTypeOf(item2, FightEntityAssembledMonsterSub)

	if isAssembled1 and isAssembled2 then
		local config1 = lua_fight_assembled_monster.configDict[entityMO1.skin]
		local config2 = lua_fight_assembled_monster.configDict[entityMO2.skin]

		return config1.clickIndex > config2.clickIndex
	elseif isAssembled1 and not isAssembled2 then
		return true
	elseif not isAssembled1 and isAssembled2 then
		return false
	else
		local _, _, stancePos1 = FightHelper.getEntityStandPos(entityMO1)
		local _, _, stancePos2 = FightHelper.getEntityStandPos(entityMO2)

		if stancePos1 ~= stancePos2 then
			return stancePos1 < stancePos2
		else
			return tonumber(entityMO1.id) > tonumber(entityMO2.id)
		end
	end
end

function FightHelper.sortNextRoundGetCardConfig(item1, item2)
	return item1.priority > item2.priority
end

function FightHelper.sortNextRoundGetCard(item1, item2)
	return item1.index < item2.index
end

function FightHelper.getNextRoundGetCardList()
	local exclusionDic = {}
	local list = {}
	local cardOps = FightDataHelper.operationDataMgr:getOpList()

	for i, v in ipairs(cardOps) do
		if v:isPlayCard() then
			local skillId = v.skillId
			local configDic = lua_fight_next_round_get_card.configDict[skillId]

			if configDic then
				local configList = {}

				for key, value in pairs(configDic) do
					table.insert(configList, value)
				end

				table.sort(configList, FightHelper.sortNextRoundGetCardConfig)

				for index, config in ipairs(configList) do
					local condition = config.condition

					if FightHelper.checkNextRoundCardCondition(v, condition) then
						if config.exclusion ~= 0 then
							exclusionDic[config.exclusion] = exclusionDic[config.exclusion] or {}
							exclusionDic[config.exclusion].index = i
							exclusionDic[config.exclusion].skillId = config.skillId
							exclusionDic[config.exclusion].entityId = v.belongToEntityId
							exclusionDic[config.exclusion].tempCard = config.tempCard

							break
						end

						do
							local tab = {}

							tab.index = i
							tab.skillId = config.skillId
							tab.entityId = v.belongToEntityId
							tab.tempCard = config.tempCard

							table.insert(list, tab)
						end

						break
					end
				end
			end
		end
	end

	for k, v in pairs(exclusionDic) do
		table.insert(list, v)
	end

	table.sort(list, FightHelper.sortNextRoundGetCard)

	local cardList = {}

	for i, v in ipairs(list) do
		local skillIds = string.splitToNumber(v.skillId, "#")

		for index, id in ipairs(skillIds) do
			local tab = {
				uid = v.entityId,
				skillId = id,
				tempCard = v.tempCard
			}
			local cardInfoMO = FightCardInfoData.New(tab)

			table.insert(cardList, cardInfoMO)
		end
	end

	return cardList
end

function FightHelper.checkNextRoundCardCondition(cardOp, condition)
	if string.nilorempty(condition) then
		return true
	end

	local arr = string.split(condition, "&")

	if #arr > 1 then
		local count = 0

		for i, v in ipairs(arr) do
			if FightHelper.checkNextRoundCardSingleCondition(cardOp, v) then
				count = count + 1
			end
		end

		return count == #arr
	else
		return FightHelper.checkNextRoundCardSingleCondition(cardOp, arr[1])
	end
end

function FightHelper.checkNextRoundCardSingleCondition(cardOp, condition)
	local belongToEntityId = cardOp.belongToEntityId
	local tarEntity = FightHelper.getEntity(belongToEntityId)
	local entityMO = tarEntity and tarEntity:getMO()
	local arr = string.split(condition, "#")

	if arr[1] == "1" then
		if arr[2] and entityMO then
			local showLevel, rank = HeroConfig.instance:getShowLevel(entityMO.level)

			if rank - 1 >= tonumber(arr[2]) then
				return true
			end
		end
	elseif arr[1] == "2" and arr[2] and entityMO then
		return entityMO.exSkillLevel == tonumber(arr[2])
	end
end

function FightHelper.checkShieldHit(actEffectData)
	if actEffectData.effectNum1 == FightEnum.EffectType.SHAREHURT then
		return false
	end

	return true
end

FightHelper.SkillEditorHp = 2000

function FightHelper.buildMySideFightEntityMOList(fightParam)
	local side = FightEnum.EntitySide.MySide
	local heroIds = {}
	local skinIds = {}

	for i = 1, SkillEditorMgr.instance.stance_count_limit do
		local heroMO = HeroModel.instance:getById(fightParam.mySideUids[i])

		if heroMO then
			heroIds[i] = heroMO.heroId
			skinIds[i] = heroMO.skin
		end
	end

	local subHeroIds = {}
	local subHeroSkinIds = {}

	for _, heroId in ipairs(fightParam.mySideSubUids) do
		local heroMO = HeroModel.instance:getById(heroId)

		if heroMO then
			table.insert(subHeroIds, heroMO.heroId)
			table.insert(subHeroSkinIds, heroMO.skin)
		end
	end

	return FightHelper.buildHeroEntityMOList(side, heroIds, skinIds, subHeroIds, subHeroSkinIds)
end

function FightHelper.getEmptyFightEntityMO(heroUid, heroId, level, skin)
	if not heroId or heroId == 0 then
		return
	end

	local heroCO = lua_character.configDict[heroId]
	local fightEntityMO = FightEntityMO.New()

	fightEntityMO.id = tostring(heroUid)
	fightEntityMO.uid = fightEntityMO.id
	fightEntityMO.modelId = heroId or 0
	fightEntityMO.entityType = 1
	fightEntityMO.exPoint = 0
	fightEntityMO.side = FightEnum.EntitySide.MySide
	fightEntityMO.currentHp = 0
	fightEntityMO.attrMO = FightHelper._buildAttr(heroCO)
	fightEntityMO.skillIds = FightHelper._buildHeroSkills(heroCO)
	fightEntityMO.shieldValue = 0
	fightEntityMO.level = level or 1
	fightEntityMO.skin = skin or heroCO.skinId
	fightEntityMO.originSkin = skin or heroCO.skinId

	if not string.nilorempty(heroCO.powerMax) then
		local temp = FightStrUtil.instance:getSplitToNumberCache(heroCO.powerMax, "#")
		local info = {
			{
				num = 0,
				powerId = temp[1],
				max = temp[2]
			}
		}

		fightEntityMO:setPowerInfos(info)
	end

	return fightEntityMO
end

function FightHelper.buildHeroEntityMOList(side, heroIds, skinIds, subHeroIds, subHeroSkinIds)
	local function buildEntityMOFunc(heroId, heroCO, skin)
		local fightEntityMO = FightEntityMO.New()

		fightEntityMO.id = tostring(mySideIdCounter)
		fightEntityMO.uid = fightEntityMO.id
		fightEntityMO.modelId = heroId or 0
		fightEntityMO.entityType = 1
		fightEntityMO.exPoint = 0
		fightEntityMO.side = side
		fightEntityMO.currentHp = FightHelper.SkillEditorHp
		fightEntityMO.attrMO = FightHelper._buildAttr(heroCO)

		local exPointStr = heroCO.uniqueSkill_point
		local array = string.splitToNumber(exPointStr, "#")

		fightEntityMO.exPointType = array[1] or 0

		if skin == 312002 then
			fightEntityMO.skillIds = FightHelper._buildHeroSkills(heroCO, 2)
		else
			fightEntityMO.skillIds = FightHelper._buildHeroSkills(heroCO)
		end

		fightEntityMO.shieldValue = 0
		fightEntityMO.level = 1
		fightEntityMO.storedExPoint = 0

		if not string.nilorempty(heroCO.powerMax) then
			local temp = FightStrUtil.instance:getSplitToNumberCache(heroCO.powerMax, "#")
			local info = {
				{
					num = 0,
					powerId = temp[1],
					max = temp[2]
				}
			}

			fightEntityMO:setPowerInfos(info)
		end

		mySideIdCounter = mySideIdCounter + 1

		return fightEntityMO
	end

	local entityMOList = {}
	local subEntityMOList = {}
	local len = heroIds and #heroIds or SkillEditorMgr.instance.stance_count_limit

	for i = 1, len do
		local heroId = heroIds[i]

		if heroId and heroId ~= 0 then
			local heroCO = lua_character.configDict[heroId]

			if heroCO then
				local skin = skinIds and skinIds[i] or heroCO.skinId
				local fightEntityMO = buildEntityMOFunc(heroId, heroCO, skin)

				fightEntityMO.position = i
				fightEntityMO.skin = skin
				fightEntityMO.originSkin = skin

				table.insert(entityMOList, fightEntityMO)
			else
				local sideStr = side == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的角色配置已被删除，角色id=%d", sideStr, i, heroId))
			end
		end
	end

	if subHeroIds then
		for _, heroId in ipairs(subHeroIds) do
			local heroCO = lua_character.configDict[heroId]

			if heroCO then
				local fightEntityMO = buildEntityMOFunc(heroId, heroCO)

				fightEntityMO.position = -1
				fightEntityMO.skin = subHeroSkinIds and subHeroSkinIds[_] or heroCO.skinId
				fightEntityMO.originSkin = subHeroSkinIds and subHeroSkinIds[_] or heroCO.skinId

				table.insert(subEntityMOList, fightEntityMO)
			else
				local sideStr = side == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(sideStr .. "替补角色的配置已被删除，角色id=" .. heroId)
			end
		end
	end

	return entityMOList, subEntityMOList
end

function FightHelper.buildEnemySideFightEntityMOList(fightParam, roundId)
	local side = FightEnum.EntitySide.EnemySide
	local monsterGroupId = fightParam.monsterGroupIds[roundId]
	local monsterGroupCO = lua_monster_group.configDict[monsterGroupId]
	local monsterIds = FightStrUtil.instance:getSplitToNumberCache(monsterGroupCO.monster, "#")
	local subMonsterIds = monsterGroupCO.subMonsters

	return FightHelper.buildMonsterEntityMOList(side, monsterIds, subMonsterIds)
end

function FightHelper.buildMonsterEntityMOList(side, monsterIds, subMonsterIds)
	local entityMOList = {}
	local subEntityMOList = {}

	for i = 1, SkillEditorMgr.instance.enemy_stance_count_limit do
		local monsterId = monsterIds[i]

		if monsterId and monsterId ~= 0 then
			local monsterCO = lua_monster.configDict[monsterId]

			if monsterCO then
				local fightEntityMO = FightEntityMO.New()

				fightEntityMO.id = tostring(enemySideIdCounter)
				fightEntityMO.uid = fightEntityMO.id
				fightEntityMO.modelId = monsterId
				fightEntityMO.position = i
				fightEntityMO.entityType = 2
				fightEntityMO.exPoint = 0
				fightEntityMO.skin = monsterCO.skinId
				fightEntityMO.originSkin = monsterCO.skinId
				fightEntityMO.side = side
				fightEntityMO.currentHp = FightHelper.SkillEditorHp
				fightEntityMO.attrMO = FightHelper._buildAttr(monsterCO)
				fightEntityMO.skillIds = FightHelper._buildMonsterSkills(monsterCO)
				fightEntityMO.shieldValue = 0
				fightEntityMO.level = 1
				fightEntityMO.storedExPoint = 0
				fightEntityMO.exPointType = 0
				enemySideIdCounter = enemySideIdCounter - 1

				table.insert(entityMOList, fightEntityMO)
			else
				local sideStr = side == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的怪物配置已被删除，怪物id=%d", sideStr, i, monsterId))
			end
		end
	end

	if subMonsterIds then
		for _, monsterId in ipairs(subMonsterIds) do
			local monsterCO = lua_monster.configDict[monsterId]

			if monsterCO then
				local fightEntityMO = FightEntityMO.New()

				fightEntityMO.id = tostring(enemySideIdCounter)
				fightEntityMO.uid = fightEntityMO.id
				fightEntityMO.modelId = monsterId
				fightEntityMO.position = 5
				fightEntityMO.entityType = 2
				fightEntityMO.exPoint = 0
				fightEntityMO.skin = monsterCO.skinId
				fightEntityMO.originSkin = monsterCO.skinId
				fightEntityMO.side = side
				fightEntityMO.currentHp = FightHelper.SkillEditorHp
				fightEntityMO.attrMO = FightHelper._buildAttr(monsterCO)
				fightEntityMO.skillIds = FightHelper._buildMonsterSkills(monsterCO)
				fightEntityMO.shieldValue = 0
				fightEntityMO.level = 1
				enemySideIdCounter = enemySideIdCounter - 1

				table.insert(subEntityMOList, fightEntityMO)
			else
				local sideStr = side == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(sideStr .. "替补怪物的配置已被删除，怪物id=" .. monsterId)
			end
		end
	end

	return entityMOList, subEntityMOList
end

function FightHelper.buildSkills(modelId)
	local heroCO = lua_character.configDict[modelId]

	if heroCO then
		return FightHelper._buildHeroSkills(heroCO)
	end

	local monsterCO = lua_monster.configDict[modelId]

	if monsterCO then
		return FightHelper._buildMonsterSkills(monsterCO)
	end
end

function FightHelper._buildHeroSkills(co, checkRankReplace)
	local arr = {}
	local heroCO = lua_character.configDict[co.id]
	local rankReplaceConfig

	if checkRankReplace and checkRankReplace >= 2 then
		rankReplaceConfig = lua_character_rank_replace.configDict[co.id]
	end

	if heroCO then
		local activeSkills = GameUtil.splitString2(heroCO.skill, true)

		if rankReplaceConfig then
			activeSkills = GameUtil.splitString2(rankReplaceConfig.skill, true)
		end

		for _, oneArr in pairs(activeSkills) do
			for i = 2, #oneArr do
				if oneArr[i] ~= 0 then
					table.insert(arr, oneArr[i])
				else
					logError(co.id .. " 角色技能id=0，检查下角色表-角色")
				end
			end
		end
	end

	if rankReplaceConfig then
		if rankReplaceConfig.exSkill ~= 0 then
			table.insert(arr, rankReplaceConfig.exSkill)
		end
	elseif heroCO.exSkill ~= 0 then
		table.insert(arr, heroCO.exSkill)
	end

	local exSkills = lua_skill_ex_level.configDict[co.id]

	if exSkills then
		for _, exSkillCO in pairs(exSkills) do
			if exSkillCO.skillEx ~= 0 then
				table.insert(arr, exSkillCO.skillEx)
			end
		end
	end

	local passiveSkills = lua_skill_passive_level.configDict[co.id]

	if passiveSkills then
		for _, passiveSkillCO in pairs(passiveSkills) do
			if passiveSkillCO.skillPassive ~= 0 then
				table.insert(arr, passiveSkillCO.skillPassive)
			else
				logError(co.id .. " 角色被动技能id=0，检查下角色养成表-被动升级")
			end
		end
	end

	return arr
end

function FightHelper._buildMonsterSkills(co)
	local arr = {}

	if not string.nilorempty(co.activeSkill) then
		local activeSkill = FightStrUtil.instance:getSplitString2Cache(co.activeSkill, true, "|", "#")

		for _, ids in ipairs(activeSkill) do
			for _, skillId in ipairs(ids) do
				local skillCO = lua_skill.configDict[skillId]

				if skillCO then
					table.insert(arr, skillId)
				end
			end
		end
	end

	if co.uniqueSkill and #co.uniqueSkill > 0 then
		for _, skillId in ipairs(co.uniqueSkill) do
			table.insert(arr, skillId)
		end
	end

	tabletool.addValues(arr, FightConfig.instance:getPassiveSkills(co.id))

	return arr
end

function FightHelper._buildAttr(co)
	local heroAttribute = HeroAttributeMO.New()

	heroAttribute.hp = FightHelper.SkillEditorHp
	heroAttribute.attack = 100
	heroAttribute.defense = 100
	heroAttribute.crit = 100
	heroAttribute.crit_damage = 100
	heroAttribute.multiHpNum = 0
	heroAttribute.multiHpIdx = 0

	return heroAttribute
end

function FightHelper.getEpisodeRecommendLevel(episodeId, isSimple)
	local battleId = DungeonConfig.instance:getEpisodeBattleId(episodeId)

	if not battleId then
		return 0
	end

	return FightHelper.getBattleRecommendLevel(battleId, isSimple)
end

function FightHelper.getBattleRecommendLevel(battleId, isSimple)
	local levelStr = isSimple and "levelEasy" or "level"
	local battleCo = lua_battle.configDict[battleId]

	if not battleCo then
		return 0
	end

	local enemyList = {}
	local enemyBossList = {}
	local bossId, monsterIdList

	for _, v in ipairs(FightStrUtil.instance:getSplitToNumberCache(battleCo.monsterGroupIds, "#")) do
		bossId = lua_monster_group.configDict[v].bossId
		monsterIdList = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[v].monster, "#")

		for _, id in ipairs(monsterIdList) do
			if FightHelper.isBossId(bossId, id) then
				table.insert(enemyBossList, id)
			else
				table.insert(enemyList, id)
			end
		end
	end

	if #enemyBossList > 0 then
		return lua_monster.configDict[enemyBossList[1]][levelStr]
	elseif #enemyList > 0 then
		local level = 0

		for _, v in ipairs(enemyList) do
			level = level + lua_monster.configDict[v][levelStr]
		end

		return math.ceil(level / #enemyList)
	else
		return 0
	end
end

function FightHelper.initBuildSceneAndLevelHandle()
	if FightHelper.buildSceneAndLevelHandleDict then
		return
	end

	FightHelper.buildSceneAndLevelHandleDict = {
		[DungeonEnum.EpisodeType.Cachot] = FightHelper.buildCachotSceneAndLevel,
		[DungeonEnum.EpisodeType.Rouge] = FightHelper.buildRougeSceneAndLevel,
		[DungeonEnum.EpisodeType.Survival] = FightHelper.buildSurvivalSceneAndLevel,
		[DungeonEnum.EpisodeType.Rouge2] = FightHelper.buildRouge2SceneAndLevel
	}
end

function FightHelper.buildDefaultSceneAndLevel(episodeId, battleId)
	local sceneIds = {}
	local levelIds = {}
	local battleConfig = lua_battle.configDict[battleId]
	local sceneIdsConfig = battleConfig.sceneIds
	local sp = string.splitToNumber(sceneIdsConfig, "#")

	for _, sceneId in ipairs(sp) do
		local levelId = SceneConfig.instance:getSceneLevelCOs(sceneId)[1].id

		table.insert(sceneIds, sceneId)
		table.insert(levelIds, levelId)
	end

	return sceneIds, levelIds
end

function FightHelper.buildCachotSceneAndLevel(episodeId, battleId)
	local cachotLayer = 0
	local topBattleEventMo = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if topBattleEventMo and lua_rogue_event_fight.configDict[topBattleEventMo:getEventCo().eventId].isChangeScene ~= 1 then
		local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

		cachotLayer = rogueInfo.layer
	end

	if cachotLayer > 0 then
		local sceneInfo = V1a6_CachotEventConfig.instance:getSceneIdByLayer(cachotLayer)

		if sceneInfo then
			local sceneIds = {}
			local levelIds = {}

			table.insert(sceneIds, sceneInfo.sceneId)
			table.insert(levelIds, sceneInfo.levelId)

			return sceneIds, levelIds
		else
			logError("肉鸽战斗场景配置不存在" .. cachotLayer)

			return FightHelper.buildDefaultSceneAndLevel(episodeId, battleId)
		end
	else
		return FightHelper.buildDefaultSceneAndLevel(episodeId, battleId)
	end
end

function FightHelper.buildSurvivalSceneAndLevel(...)
	local mo = SurvivalMapModel.instance:getSceneMo()

	if mo then
		local groupId = lua_survival_map_group_mapping.configDict[mo.mapId].id
		local co = lua_survival_map_group.configDict[groupId]
		local sceneIds = {}
		local levelIds = {}

		table.insert(sceneIds, co.useScene)
		table.insert(levelIds, co.useScene)

		return sceneIds, levelIds
	end

	return FightHelper.buildDefaultSceneAndLevel(...)
end

function FightHelper.buildRougeSceneAndLevel(episodeId, battleId)
	local curEvent = RougeMapModel.instance:getCurEvent()
	local type = curEvent and curEvent.type
	local fightEventCo = RougeMapHelper.isFightEvent(type) and lua_rouge_fight_event.configDict[curEvent.id]
	local isChangeScene = fightEventCo and fightEventCo.isChangeScene == 1

	if isChangeScene then
		local layerCo = RougeMapModel.instance:getLayerCo()
		local sceneId = layerCo and layerCo.sceneId
		local levelId = layerCo and layerCo.levelId

		if sceneId ~= 0 and levelId ~= 0 then
			return {
				sceneId
			}, {
				levelId
			}
		end

		logError(string.format("layerId : %s, config Incorrect, sceneId : %s, levelId : %s", layerCo and layerCo.id, sceneId, levelId))

		return FightHelper.buildDefaultSceneAndLevel(episodeId, battleId)
	else
		return FightHelper.buildDefaultSceneAndLevel(episodeId, battleId)
	end
end

function FightHelper.buildRouge2SceneAndLevel(episodeId, battleId)
	local curEvent = Rouge2_MapModel.instance:getCurEvent()
	local type = curEvent and curEvent.type
	local fightEventCo = Rouge2_MapHelper.isFightEvent(type) and Rouge2_MapConfig.instance:eventId2FightEventCo(curEvent.id)
	local isChangeScene = fightEventCo and fightEventCo.isChangeScene == 1

	if isChangeScene then
		local layerCo = Rouge2_MapModel.instance:getLayerCo()
		local sceneId = layerCo and layerCo.sceneId
		local levelId = layerCo and layerCo.levelId

		if sceneId ~= 0 and levelId ~= 0 then
			return {
				sceneId
			}, {
				levelId
			}
		end

		logError(string.format("layerId : %s, config Incorrect, sceneId : %s, levelId : %s", layerCo and layerCo.id, sceneId, levelId))

		return FightHelper.buildDefaultSceneAndLevel(episodeId, battleId)
	else
		return FightHelper.buildDefaultSceneAndLevel(episodeId, battleId)
	end
end

function FightHelper.buildSceneAndLevel(episodeId, battleId)
	FightHelper.initBuildSceneAndLevelHandle()

	local episodeCO = lua_episode.configDict[episodeId]
	local handle = episodeCO and FightHelper.buildSceneAndLevelHandleDict[episodeCO.type]

	handle = handle or FightHelper.buildDefaultSceneAndLevel

	return handle(episodeId, battleId)
end

function FightHelper.getStressStatus(stress, thresholdDict)
	thresholdDict = thresholdDict or FightEnum.StressThreshold

	if not stress then
		logError("stress is nil")

		return FightEnum.Status.Positive
	end

	for i = 1, 2 do
		if stress <= thresholdDict[i] then
			return i
		end
	end

	return nil
end

function FightHelper.getResistanceKeyById(id)
	if not FightHelper.resistanceId2KeyDict then
		FightHelper.resistanceId2KeyDict = {}

		for resistance, resistanceId in pairs(FightEnum.Resistance) do
			FightHelper.resistanceId2KeyDict[resistanceId] = resistance
		end
	end

	return FightHelper.resistanceId2KeyDict[id]
end

function FightHelper.canAddPoint(entityMo)
	if not entityMo then
		return false
	end

	if entityMo:hasBuffFeature(FightEnum.BuffType_TransferAddExPoint) then
		return false
	end

	if entityMo:hasBuffFeature(FightEnum.ExPointCantAdd) then
		return false
	end

	return true
end

function FightHelper.getEntityName(entity)
	local entityMo = entity and entity:getMO()
	local entityName = entityMo and entityMo:getEntityName()

	return tostring(entityName)
end

function FightHelper.getEntityById(entityId)
	local entity = FightHelper.getEntity(entityId)

	return FightHelper.getEntityName(entity)
end

function FightHelper.isSameCardMo(cardMoA, cardMoB)
	if cardMoA == cardMoB then
		return true
	end

	if not cardMoA or not cardMoB then
		return false
	end

	return cardMoA.clientData.custom_enemyCardIndex == cardMoB.clientData.custom_enemyCardIndex
end

function FightHelper.getAssitHeroInfoByUid(heroUid, isSub)
	local entityMo = FightDataHelper.entityMgr:getById(heroUid)

	if entityMo and entityMo:isCharacter() then
		local heroCfg = HeroConfig.instance:getHeroCO(entityMo.modelId)

		return {
			skin = entityMo.skin,
			level = entityMo.level,
			config = heroCfg
		}
	end
end

function FightHelper.canSelectEnemyEntity(entityId)
	if not entityId then
		return false
	end

	local entityMo = FightDataHelper.entityMgr:getById(entityId)

	if not entityMo then
		return false
	end

	if entityMo.side == FightEnum.EntitySide.MySide then
		return false
	end

	if entityMo:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if entityMo:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	return true
end

function FightHelper.clearNoUseEffect()
	local releasePathSet = FightEffectPool.releaseUnuseEffect()

	for path, _ in pairs(releasePathSet) do
		FightPreloadController.instance:releaseAsset(path)
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC)
end

function FightHelper.isASFDSkill(skillId)
	return skillId == FightASFDConfig.instance.skillId
end

function FightHelper.isXiTiSpecialSkill(skillId)
	return skillId == FightASFDConfig.instance.xiTiSpecialSkillId
end

function FightHelper.isPreDeleteSkill(skillId)
	local skillCO = skillId and lua_skill.configDict[skillId]

	return skillCO and skillCO.icon == FightEnum.CardIconId.PreDelete
end

function FightHelper.getASFDMgr()
	local curScene = GameSceneMgr.instance:getCurScene()
	local sceneMgr = curScene and curScene.mgr
	local asfdMgr = sceneMgr and sceneMgr:getASFDMgr()

	return asfdMgr
end

function FightHelper.getEntityCareer(entityId)
	local entityMo = entityId and FightDataHelper.entityMgr:getById(entityId)

	return entityMo and entityMo:getCareer() or 0
end

function FightHelper.isRestrain(entityId1, entityId2)
	local career1 = FightHelper.getEntityCareer(entityId1)
	local career2 = FightHelper.getEntityCareer(entityId2)
	local restrain = FightConfig.instance:getRestrain(career1, career2) or 1000

	return restrain > 1000
end

FightHelper.tempEntityMoList = {}

function FightHelper.hasSkinId(skinId)
	local entityMoList = FightHelper.tempEntityMoList

	tabletool.clear(entityMoList)

	local entityList = FightDataHelper.entityMgr:getMyNormalList(entityMoList)

	for _, entityMo in ipairs(entityList) do
		if entityMo.originSkin == skinId then
			return true
		end
	end

	return false
end

function FightHelper.getBloodPoolSkillId()
	return tonumber(lua_fight_xcjl_const.configDict[4].value)
end

function FightHelper.isBloodPoolSkill(skillId)
	return skillId == FightHelper.getBloodPoolSkillId()
end

function FightHelper.getSurvivalEntityHealth(entityId)
	local customData = FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]

	if not customData then
		return
	end

	if not customData.hero2Health then
		return
	end

	local entityMo = FightDataHelper.entityMgr:getById(entityId)

	if not entityMo then
		return
	end

	local modelId = entityMo.modelId
	local health = customData.hero2Health[tostring(modelId)]

	return health
end

function FightHelper.getSurvivalMaxHealth()
	local customData = FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]

	if not customData then
		return
	end

	return customData.maxHealth
end

function FightHelper.getCurBattleIdBossHpType()
	local battleId = FightDataHelper.fieldMgr.battleId
	local battleCo = lua_battle.configDict[battleId]
	local type = battleCo and battleCo.bossHpType
	local typeArr = not string.nilorempty(type) and FightStrUtil.instance:getSplitCache(type, "#")

	return typeArr and tonumber(typeArr[1])
end

function FightHelper.getCurBossEntityMo()
	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
	local bossId = monsterGroupCO and monsterGroupCO.bossId

	if string.nilorempty(bossId) then
		return
	end

	local enemyEntityMoList = FightDataHelper.entityMgr:getEnemyNormalList()

	for _, entityMo in ipairs(enemyEntityMoList) do
		if FightHelper.isBossId(bossId, entityMo.modelId) then
			return entityMo
		end
	end

	local t = {}

	for _, entityMo in ipairs(enemyEntityMoList) do
		table.insert(t, entityMo.modelId)
	end

	logError(string.format("获取boss数据失败： monsterGroupId ： %s, bossId : %s, curEnemyList : %s", monsterGroupId, bossId, table.concat(t, ",")))
end

function FightHelper.getBossCurStageCo_500M(bossEntityMo)
	local entityMo = bossEntityMo or FightHelper.getCurBossEntityMo()

	if not entityMo then
		logError("entityMo is nil")

		return lua_fight_tower_500m_boss_behaviour.configList[1]
	end

	for _, co in ipairs(lua_fight_tower_500m_boss_behaviour.configList) do
		local monsterIdList = FightStrUtil.instance:getSplitToNumberCache(co.monsterid, "#")

		if monsterIdList then
			for _, monsterId in ipairs(monsterIdList) do
				if monsterId == entityMo.modelId then
					return co
				end
			end
		end
	end

	logError(string.format("获取阶段数据失败： bossId : %s", entityMo.modelId))

	return lua_fight_tower_500m_boss_behaviour.configList[1]
end

function FightHelper.isOppositeSide(side1, side2)
	if side1 == FightEnum.EntitySide.MySide then
		return side2 == FightEnum.EntitySide.EnemySide
	elseif side1 == FightEnum.EntitySide.EnemySide then
		return side2 == FightEnum.EntitySide.MySide
	else
		return false
	end
end

function FightHelper.isOppositeByEntityId(entityId1, entityId2)
	local entityMo1 = FightDataHelper.entityMgr:getById(entityId1)
	local entityMo2 = FightDataHelper.entityMgr:getById(entityId2)
	local side1 = entityMo1 and entityMo1.side
	local side2 = entityMo2 and entityMo2.side

	return FightHelper.isOppositeSide(side1, side2)
end

function FightHelper.buildCrystalNum(crystal1, crystal2, crystal3)
	return crystal1 * 100 + crystal2 * 10 + crystal3
end

function FightHelper.getCrystalNum(crystalNum)
	crystalNum = tonumber(crystalNum) or 0

	local crystal1 = math.floor(crystalNum / 100)
	local crystal2 = math.floor(crystalNum / 10) % 10
	local crystal3 = crystalNum % 10

	return crystal1, crystal2, crystal3
end

function FightHelper.getBLECrystalParam()
	local entityMoList = FightDataHelper.entityMgr:getMyNormalList()

	if not entityMoList then
		return
	end

	local BLEHeroId = FightEnum.HeroId.BLE
	local buffActId = FightEnum.BuffActId.CrystalNotifySelect

	for _, entityMo in ipairs(entityMoList) do
		if entityMo.modelId == BLEHeroId then
			local buffDict = entityMo:getBuffDic()

			for _, buffMo in pairs(buffDict) do
				for _, buffActInfo in ipairs(buffMo.actInfo) do
					if buffActInfo.actId == buffActId then
						local totalSelectCount = buffActInfo.param[1]
						local perSelectCount = buffActInfo.param[2]
						local selected = buffActInfo.param[3] == 1

						return totalSelectCount, perSelectCount, selected, entityMo.uid
					end
				end
			end
		end
	end
end

function FightHelper.getRouge2Career()
	local customData = FightDataHelper.fieldMgr.customData
	local rouge2Data = customData and customData[FightCustomData.CustomDataType.Rouge2]

	return rouge2Data and rouge2Data.career
end

function FightHelper.checkBuffMoIsRouge2CheckCountBuff(buffMo)
	local buffActList = buffMo and buffMo.actInfo

	if buffActList then
		for _, buffAct in ipairs(buffActList) do
			if buffAct.actId == FightEnum.BuffActId.Rouge2CheckCount then
				return true
			end
		end
	end

	return false
end

function FightHelper.getRouge2CheckCountValue(buffMo)
	local buffActList = buffMo.actInfo

	if buffActList then
		for _, buffAct in ipairs(buffActList) do
			if buffAct.actId == FightEnum.BuffActId.Rouge2CheckCount then
				return buffAct.param[1]
			end
		end
	end

	return 0
end

function FightHelper.getTaskLevelAndCost(taskId)
	local co = taskId and lua_rouge2_funnyfight_event.configDict[taskId]
	local taskLevel = co and co.taskLevel
	local levelList = taskLevel and FightStrUtil.instance:getSplitCache(taskLevel, "#")
	local level = taskLevel and levelList[1]
	local cost = taskLevel and tonumber(levelList[2])

	return level, cost
end

function FightHelper.getRouge2FunnyTaskStartId()
	local taskBox = FightDataHelper.fieldMgr.fightTaskBox
	local taskDict = taskBox and taskBox.tasks

	if not taskDict then
		return
	end

	local startTaskId
	local minLevel = FightEnum.Rouge2FunnyTaskLevel.S

	for taskId, taskData in pairs(taskDict) do
		local levelName = FightHelper.getTaskLevelAndCost(taskData.taskId)
		local level = levelName and FightEnum.Rouge2FunnyTaskLevelName2Level[levelName] or FightEnum.Rouge2FunnyTaskLevel.S

		if level <= minLevel then
			minLevel = level
			startTaskId = taskId
		end
	end

	return startTaskId
end

function FightHelper.getRouge2FunnyTaskCurLevelAndTaskIdAndProgress()
	local taskBox = FightDataHelper.fieldMgr.fightTaskBox
	local taskDict = taskBox and taskBox.tasks

	if not taskDict then
		return
	end

	local startTaskId = FightHelper.getRouge2FunnyTaskStartId()

	if not startTaskId then
		return
	end

	local rougeData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Rouge2]
	local indicatorId = rougeData and rougeData.fightTaskWinIndicatorId
	local indicatorValue = indicatorId and FightDataHelper.fieldMgr:getIndicatorNum(indicatorId) or 0
	local lastTaskId = startTaskId
	local level = FightEnum.Rouge2FunnyTaskLevel.S

	for _ = 1, 10 do
		if not startTaskId then
			return level, lastTaskId, 1
		end

		local taskMo = taskDict[startTaskId]
		local value = taskMo and taskMo.values[1]

		if not value then
			logError("任务 value is nil")

			return level, lastTaskId, 1
		end

		local levelName, cost = FightHelper.getTaskLevelAndCost(startTaskId)

		if not cost or cost <= 1 then
			logError("任务 cost is valid .. cost : " .. tostring(cost))

			cost = indicatorValue
		end

		level = levelName and FightEnum.Rouge2FunnyTaskLevelName2Level[levelName] or FightEnum.Rouge2FunnyTaskLevel.S

		if not value.finished then
			return level, startTaskId, indicatorValue / cost
		end

		lastTaskId = startTaskId

		local co = startTaskId and lua_rouge2_funnyfight_event.configDict[startTaskId]

		startTaskId = co and co.nextTask
		indicatorValue = indicatorValue - cost
	end

	return level, lastTaskId, 1
end

return FightHelper
