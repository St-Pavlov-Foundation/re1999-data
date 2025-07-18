﻿module("modules.logic.fight.controller.FightHelper", package.seeall)

local var_0_0 = _M
local var_0_1 = 1000001
local var_0_2 = -1000001
local var_0_3 = Vector2.zero

function var_0_0.getEntityStanceId(arg_1_0, arg_1_1)
	local var_1_0 = FightEnum.MySideDefaultStanceId

	if arg_1_0 and arg_1_0.side == FightEnum.EntitySide.MySide then
		local var_1_1 = FightModel.instance:getFightParam()
		local var_1_2 = var_1_1 and var_1_1.battleId
		local var_1_3 = var_1_2 and lua_battle.configDict[var_1_2]

		if var_1_3 and not string.nilorempty(var_1_3.myStance) then
			var_1_0 = tonumber(var_1_3.myStance)

			if not var_1_0 then
				local var_1_4 = FightStrUtil.instance:getSplitToNumberCache(var_1_3.myStance, "#")

				if #var_1_4 > 0 then
					arg_1_1 = arg_1_1 or FightModel.instance:getCurWaveId()
					var_1_0 = var_1_4[arg_1_1 <= #var_1_4 and arg_1_1 or #var_1_4]
				else
					logError("站位配置有误，战斗id = " .. var_1_1.battleId)
				end
			end
		end

		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			var_1_0 = SkillEditorMgr.instance.stance_id
		end
	else
		local var_1_5 = FightModel.instance:getCurMonsterGroupId()
		local var_1_6 = lua_monster_group.configDict[var_1_5]

		var_1_0 = var_1_6 and var_1_6.stanceId or FightEnum.EnemySideDefaultStanceId

		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			var_1_0 = SkillEditorMgr.instance.enemy_stance_id
		end
	end

	return var_1_0
end

function var_0_0.getEntityStandPos(arg_2_0, arg_2_1)
	if arg_2_0:isVorpalith() then
		return 0, 0, 0, 1
	end

	if arg_2_0:isAssistBoss() then
		return var_0_0.getAssistBossStandPos(arg_2_0, arg_2_1)
	end

	if FightEntityDataHelper.isPlayerUid(arg_2_0.uid) then
		return 0, 0, 0, 1
	end

	local var_2_0 = var_0_0.getEntityStanceId(arg_2_0, arg_2_1)
	local var_2_1 = lua_stance.configDict[var_2_0]

	if not var_2_1 then
		if arg_2_0.side == FightEnum.EntitySide.MySide then
			local var_2_2 = FightModel.instance:getFightParam()
			local var_2_3 = var_2_2 and var_2_2.battleId

			logError("我方用了不存在的站位，战斗id=" .. (var_2_3 or "nil") .. "， 站位id=" .. var_2_0)
		else
			local var_2_4 = FightModel.instance:getCurMonsterGroupId()

			logError("敌方用了不存在的站位，怪物组=" .. (var_2_4 or "nil") .. "， 站位id=" .. var_2_0)
		end
	end

	local var_2_5 = FightDataHelper.entityMgr:isSub(arg_2_0.uid)
	local var_2_6

	if var_2_5 then
		var_2_6 = var_2_1.subPos1
	else
		var_2_6 = var_2_1["pos" .. arg_2_0.position]
	end

	if not var_2_6 or not var_2_6[1] or not var_2_6[2] or not var_2_6[3] then
		if isDebugBuild then
			logError("stance pos nil: stance_" .. (var_2_0 or "nil") .. " posIndex_" .. (arg_2_0.position or "nil"))
		end

		return 0, 0, 0, 1
	end

	local var_2_7 = var_2_6[1]
	local var_2_8 = var_2_6[4] or 1
	local var_2_9 = arg_2_0.skin
	local var_2_10 = lua_fight_skin_scale_by_z.configDict[var_2_9]

	if var_2_10 and not var_2_5 then
		local var_2_11 = {}

		for iter_2_0, iter_2_1 in pairs(var_2_10) do
			table.insert(var_2_11, iter_2_1)
		end

		table.sort(var_2_11, var_0_0.sortScaleBySkinPosZConfig)

		for iter_2_2, iter_2_3 in ipairs(var_2_11) do
			if var_2_6[3] <= iter_2_3.posZ then
				var_2_8 = iter_2_3.scale

				local var_2_12 = iter_2_3.posXOffset or 0

				if arg_2_0:isEnemySide() then
					var_2_12 = -var_2_12
				end

				var_2_7 = var_2_7 + var_2_12

				break
			end
		end
	end

	return var_2_7, var_2_6[2], var_2_6[3], var_2_8
end

function var_0_0.sortScaleBySkinPosZConfig(arg_3_0, arg_3_1)
	return arg_3_0.priority < arg_3_1.priority
end

function var_0_0.getAssistBossStandPos(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or FightModel.instance:getCurWaveId()

	local var_4_0 = FightModel.instance:getFightParam()
	local var_4_1 = arg_4_0.skin
	local var_4_2 = var_4_0:getScene(arg_4_1)
	local var_4_3 = lua_assist_boss_stance.configDict[var_4_1]
	local var_4_4 = var_4_3 and var_4_3[var_4_2]

	var_4_4 = var_4_4 or var_4_3 and var_4_3[0]

	if not var_4_4 then
		logError(string.format("协助boss站位表未配置 皮肤id：%s, 场景id : %s", var_4_1, var_4_2))

		return 9.4, 0, -2.75, 0.9
	end

	local var_4_5 = var_4_4.position

	return var_4_5[1], var_4_5[2], var_4_5[3], var_4_4.scale
end

function var_0_0.getSpineLookDir(arg_5_0)
	return arg_5_0 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
end

function var_0_0.getEntitySpineLookDir(arg_6_0)
	if arg_6_0 then
		local var_6_0 = arg_6_0.side
		local var_6_1 = FightConfig.instance:getSkinCO(arg_6_0.skin)

		if var_6_1 and var_6_1.flipX and var_6_1.flipX == 1 then
			return var_6_0 == FightEnum.EntitySide.MySide and SpineLookDir.Right or SpineLookDir.Left
		else
			return var_6_0 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
		end
	end
end

function var_0_0.getEffectLookDir(arg_7_0)
	return arg_7_0 == FightEnum.EntitySide.MySide and FightEnum.EffectLookDir.Left or FightEnum.EffectLookDir.Right
end

function var_0_0.getEffectLookDirQuaternion(arg_8_0)
	if arg_8_0 == FightEnum.EntitySide.MySide then
		return FightEnum.RotationQuaternion.Zero
	else
		return FightEnum.RotationQuaternion.Ohae
	end
end

function var_0_0.getEntity(arg_9_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return GameSceneMgr.instance:getCurScene().entityMgr:getEntity(arg_9_0)
	end
end

function var_0_0.getDefenders(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.actEffect) do
		local var_10_1 = false

		if arg_10_2 and arg_10_2[iter_10_1.effectType] then
			var_10_1 = true
		end

		if iter_10_1.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(iter_10_1) then
			var_10_1 = true
		end

		if not var_10_1 then
			local var_10_2 = var_0_0.getEntity(iter_10_1.targetId)

			if var_10_2 then
				table.insert(var_10_0, var_10_2)
			else
				logNormal("get defender fail, entity not exist: " .. iter_10_1.targetId)
			end
		end
	end

	if arg_10_1 then
		local var_10_3 = var_0_0.getEntity(arg_10_0.toId)

		if not tabletool.indexOf(var_10_0, var_10_3) then
			table.insert(var_10_0, var_10_3)
		end
	end

	return var_10_0
end

function var_0_0.getPreloadAssetItem(arg_11_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return FightPreloadController.instance:getFightAssetItem(arg_11_0)
	end
end

function var_0_0.getEnemySideEntitys(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0.getEntity(arg_12_0)

	if var_12_0 then
		local var_12_1 = var_12_0:getSide()

		if var_12_1 == FightEnum.EntitySide.EnemySide then
			return var_0_0.getSideEntitys(FightEnum.EntitySide.MySide, arg_12_1)
		elseif var_12_1 == FightEnum.EntitySide.MySide then
			return var_0_0.getSideEntitys(FightEnum.EntitySide.EnemySide, arg_12_1)
		end
	end

	return {}
end

function var_0_0.getSideEntitys(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_13_2 = arg_13_0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_13_3 = var_13_1:getTagUnitDict(var_13_2)

	if var_13_3 then
		for iter_13_0, iter_13_1 in pairs(var_13_3) do
			if not FightDataHelper.entityMgr:isAssistBoss(iter_13_1.id) and (arg_13_1 or not FightDataHelper.entityMgr:isSub(iter_13_1.id)) then
				table.insert(var_13_0, iter_13_1)
			end
		end
	end

	return var_13_0
end

function var_0_0.getAllSideEntitys(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_14_2 = arg_14_0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_14_3 = var_14_1:getTagUnitDict(var_14_2)

	if var_14_3 then
		for iter_14_0, iter_14_1 in pairs(var_14_3) do
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_0.getSubEntity(arg_15_0)
	local var_15_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_15_1 = arg_15_0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_15_2 = var_15_0:getTagUnitDict(var_15_1)

	if var_15_2 then
		for iter_15_0, iter_15_1 in pairs(var_15_2) do
			if not iter_15_1.isDead and FightDataHelper.entityMgr:isSub(iter_15_1.id) then
				return iter_15_1
			end
		end
	end
end

function var_0_0.getAllEntitys()
	local var_16_0 = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local var_16_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_16_2 = var_16_1:getTagUnitDict(SceneTag.UnitPlayer)
		local var_16_3 = var_16_1:getTagUnitDict(SceneTag.UnitMonster)

		if var_16_2 then
			for iter_16_0, iter_16_1 in pairs(var_16_2) do
				table.insert(var_16_0, iter_16_1)
			end
		end

		if var_16_3 then
			for iter_16_2, iter_16_3 in pairs(var_16_3) do
				table.insert(var_16_0, iter_16_3)
			end
		end
	end

	return var_16_0
end

function var_0_0.isAllEntityDead(arg_17_0)
	local var_17_0 = true
	local var_17_1

	if arg_17_0 then
		var_17_1 = var_0_0.getSideEntitys(arg_17_0, true)
	else
		var_17_1 = var_0_0.getAllEntitys()
	end

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if not iter_17_1.isDead then
			var_17_0 = false
		end
	end

	return var_17_0
end

function var_0_0.getAllEntitysContainUnitNpc()
	local var_18_0 = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local var_18_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_18_2 = var_18_1:getTagUnitDict(SceneTag.UnitPlayer)
		local var_18_3 = var_18_1:getTagUnitDict(SceneTag.UnitMonster)
		local var_18_4 = var_18_1:getTagUnitDict(SceneTag.UnitNpc)

		LuaUtil.mergeTable(var_18_0, var_18_2, var_18_3, var_18_4)
	end

	return var_18_0
end

function var_0_0.validEntityEffectType(arg_19_0)
	if arg_19_0 == FightEnum.EffectType.EXPOINTCHANGE then
		return false
	end

	if arg_19_0 == FightEnum.EffectType.INDICATORCHANGE then
		return false
	end

	if arg_19_0 == FightEnum.EffectType.POWERCHANGE then
		return false
	end

	return true
end

function var_0_0.getRelativeEntityIdDict(arg_20_0, arg_20_1)
	local var_20_0 = {}

	if arg_20_0.fromId then
		var_20_0[arg_20_0.fromId] = true
	end

	if arg_20_0.toId then
		var_20_0[arg_20_0.toId] = true
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.actEffect) do
		local var_20_1 = false

		if arg_20_1 and arg_20_1[iter_20_1.effectType] then
			var_20_1 = true
		end

		if iter_20_1.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(iter_20_1) then
			var_20_1 = true
		end

		if not var_20_1 and iter_20_1.effectType ~= FightEnum.EffectType.EXPOINTCHANGE and iter_20_1.targetId then
			var_20_0[iter_20_1.targetId] = true
		end
	end

	return var_20_0
end

function var_0_0.getSkillTargetEntitys(arg_21_0, arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.actEffect) do
		local var_21_1 = false

		if arg_21_1 and arg_21_1[iter_21_1.effectType] then
			var_21_1 = true
		end

		if iter_21_1.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(iter_21_1) then
			var_21_1 = true
		end

		if not var_21_1 and iter_21_1.effectType ~= FightEnum.EffectType.EXPOINTCHANGE then
			local var_21_2 = var_0_0.getEntity(iter_21_1.targetId)

			if var_21_2 and not tabletool.indexOf(var_21_0, var_21_2) then
				table.insert(var_21_0, var_21_2)
			end
		end
	end

	return var_21_0
end

function var_0_0.getTargetLimits(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0 == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	local var_22_1 = var_0_0.getSideEntitys(arg_22_0, false)
	local var_22_2 = var_0_0.getSideEntitys(var_22_0, false)
	local var_22_3 = lua_skill.configDict[arg_22_1]
	local var_22_4 = {}

	if not var_22_3 then
		for iter_22_0, iter_22_1 in ipairs(var_22_2) do
			table.insert(var_22_4, iter_22_1.id)
		end

		logError("no target limits, skillId_" .. arg_22_1)
	elseif var_22_3.targetLimit == FightEnum.TargetLimit.None then
		-- block empty
	elseif var_22_3.targetLimit == FightEnum.TargetLimit.EnemySide then
		for iter_22_2, iter_22_3 in ipairs(var_22_2) do
			table.insert(var_22_4, iter_22_3.id)
		end
	elseif var_22_3.targetLimit == FightEnum.TargetLimit.MySide then
		for iter_22_4, iter_22_5 in ipairs(var_22_1) do
			table.insert(var_22_4, iter_22_5.id)
		end
	else
		for iter_22_6, iter_22_7 in ipairs(var_22_2) do
			table.insert(var_22_4, iter_22_7.id)
		end

		logError("target limit type not implement:" .. var_22_3.targetLimit .. " skillId = " .. arg_22_1)
	end

	if var_22_3.logicTarget == 3 then
		local var_22_5 = arg_22_2

		if var_22_5 then
			for iter_22_8 = #var_22_4, 1, -1 do
				if var_22_4[iter_22_8] == var_22_5 then
					table.remove(var_22_4, iter_22_8)
				end
			end
		end
	elseif var_22_3.logicTarget == 1 then
		for iter_22_9 = 1, FightEnum.MaxBehavior do
			local var_22_6 = var_22_3["behavior" .. iter_22_9]

			if FightStrUtil.instance:getSplitCache(var_22_6, "#")[1] == "60032" then
				for iter_22_10 = #var_22_4, 1, -1 do
					local var_22_7 = FightDataHelper.entityMgr:getById(var_22_4[iter_22_10])

					if var_22_7 and (#var_22_7.skillGroup1 == 0 or #var_22_7.skillGroup2 == 0) then
						table.remove(var_22_4, iter_22_10)
					end
				end
			end
		end
	end

	return var_22_4
end

function var_0_0.getEntityWorldTopPos(arg_23_0)
	local var_23_0, var_23_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_23_0)
	local var_23_2, var_23_3, var_23_4 = var_0_0.getProcessEntitySpinePos(arg_23_0)

	return var_23_2 + var_23_1.x, var_23_3 + var_23_1.y + var_23_0.y / 2, var_23_4
end

function var_0_0.getEntityWorldCenterPos(arg_24_0)
	local var_24_0, var_24_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_24_0)
	local var_24_2, var_24_3, var_24_4 = var_0_0.getProcessEntitySpinePos(arg_24_0)

	return var_24_2 + var_24_1.x, var_24_3 + var_24_1.y, var_24_4
end

function var_0_0.getEntityHangPointPos(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getHangPoint(arg_25_1).transform.position

	return var_25_0.x, var_25_0.y, var_25_0.z
end

function var_0_0.getEntityWorldBottomPos(arg_26_0)
	local var_26_0, var_26_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_26_0)
	local var_26_2, var_26_3, var_26_4 = var_0_0.getProcessEntitySpinePos(arg_26_0)

	return var_26_2 + var_26_1.x, var_26_3 + var_26_1.y - var_26_0.y / 2, var_26_4
end

function var_0_0.getEntityLocalTopPos(arg_27_0)
	local var_27_0, var_27_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_27_0)

	return var_27_1.x, var_27_1.y + var_27_0.y / 2, 0
end

function var_0_0.getEntityLocalCenterPos(arg_28_0)
	local var_28_0, var_28_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_28_0)

	return var_28_1.x, var_28_1.y, 0
end

function var_0_0.getEntityLocalBottomPos(arg_29_0)
	local var_29_0, var_29_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_29_0)

	return var_29_1.x, var_29_1.y - var_29_0.y / 2, 0
end

function var_0_0.getEntityBoxSizeOffsetV2(arg_30_0)
	if var_0_0.isAssembledMonster(arg_30_0) then
		local var_30_0 = arg_30_0:getMO()
		local var_30_1 = lua_fight_assembled_monster.configDict[var_30_0.skin]

		return {
			x = var_30_1.virtualSpineSize[1],
			y = var_30_1.virtualSpineSize[2]
		}, var_0_3
	end

	local var_30_2 = arg_30_0.spine and arg_30_0.spine:getSpineGO()

	if var_30_2 then
		local var_30_3 = var_30_2:GetComponent("BoxCollider2D")

		if var_30_3 then
			local var_30_4, var_30_5, var_30_6 = transformhelper.getLocalScale(arg_30_0.go.transform)
			local var_30_7 = var_30_3.size
			local var_30_8 = var_30_3.offset

			var_30_8.x = var_30_8.x * var_30_4
			var_30_8.y = var_30_8.y * var_30_5

			if arg_30_0.spine:getLookDir() == SpineLookDir.Right then
				var_30_8.x = -var_30_8.x
			end

			var_30_7.x = var_30_7.x * var_30_4
			var_30_7.y = var_30_7.y * var_30_5

			return var_30_7, var_30_8
		end
	end

	return var_0_3, var_0_3
end

function var_0_0.getModelSize(arg_31_0)
	local var_31_0, var_31_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_31_0)
	local var_31_2 = var_31_0.x + var_31_0.y

	if var_31_2 > 14 then
		return 4
	elseif var_31_2 > 7 then
		return 3
	elseif var_31_2 > 3 then
		return 2
	else
		return 1
	end
end

function var_0_0.getEffectUrlWithLod(arg_32_0)
	return ResUrl.getEffect(arg_32_0)
end

function var_0_0.tempNewStepProto(arg_33_0)
	local var_33_0 = {}

	setmetatable(var_33_0, {
		__index = arg_33_0
	})

	local var_33_1 = {}

	var_33_0.actEffect = var_33_1

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.actEffect) do
		local var_33_2 = {}

		setmetatable(var_33_2, {
			__index = iter_33_1
		})
		table.insert(var_33_1, var_33_2)

		if iter_33_1.effectType == FightEnum.EffectType.FIGHTSTEP then
			var_33_2.fightStep = var_0_0.tempNewStepProto(iter_33_1.fightStep)
		end
	end

	return var_33_0
end

function var_0_0.tempProcessStepListProto(arg_34_0)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_0) do
		local var_34_1 = var_0_0.tempNewStepProto(iter_34_1)

		table.insert(var_34_0, var_34_1)
	end

	return var_34_0
end

local var_0_4 = 0
local var_0_5 = 0

function var_0_0.processRoundStep(arg_35_0)
	arg_35_0 = var_0_0.tempProcessStepListProto(arg_35_0)
	var_0_4 = 0
	var_0_5 = 0

	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_0) do
		var_0_0.addRoundStep(var_35_0, iter_35_1)
	end

	return var_35_0
end

function var_0_0.addRoundStep(arg_36_0, arg_36_1)
	table.insert(arg_36_0, arg_36_1)
	var_0_0.detectStepEffect(arg_36_0, arg_36_1.actEffect)
end

function var_0_0.detectStepEffect(arg_37_0, arg_37_1)
	if arg_37_1 and #arg_37_1 > 0 then
		local var_37_0 = 1

		while arg_37_1[var_37_0] do
			local var_37_1 = arg_37_1[var_37_0]

			if var_37_1.effectType == FightEnum.EffectType.SPLITSTART then
				var_0_4 = var_0_4 + 1
			elseif var_37_1.effectType == FightEnum.EffectType.SPLITEND then
				var_0_4 = var_0_4 - 1
			end

			if var_37_1.effectType == FightEnum.EffectType.FIGHTSTEP then
				if var_0_4 > 0 then
					table.remove(arg_37_1, var_37_0)

					var_37_0 = var_37_0 - 1
					var_0_5 = var_0_5 + 1

					var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)

					var_0_5 = var_0_5 - 1
				else
					local var_37_2 = var_37_1.fightStep

					if var_37_2.fakeTimeline then
						var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)
					elseif var_37_2.actType == FightEnum.ActType.SKILL then
						if var_0_0.needAddRoundStep(var_37_2) then
							var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)
						else
							var_0_0.detectStepEffect(arg_37_0, var_37_2.actEffect)
						end
					elseif var_37_2.actType == FightEnum.ActType.CHANGEHERO then
						var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)
					elseif var_37_2.actType == FightEnum.ActType.CHANGEWAVE then
						var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)
					else
						var_0_0.detectStepEffect(arg_37_0, var_37_2.actEffect)
					end
				end
			elseif var_0_4 > 0 and var_0_5 == 0 then
				table.remove(arg_37_1, var_37_0)

				var_37_0 = var_37_0 - 1

				local var_37_3 = {
					actType = FightEnum.ActType.EFFECT
				}

				var_37_3.fromId = "0"
				var_37_3.toId = "0"
				var_37_3.actId = 0
				var_37_3.actEffect = {
					var_37_1
				}
				var_37_3.cardIndex = 0
				var_37_3.supportHeroId = 0
				var_37_3.fakeTimeline = false

				table.insert(arg_37_0, var_37_3)
			end

			var_37_0 = var_37_0 + 1
		end
	end
end

function var_0_0.needAddRoundStep(arg_38_0)
	if arg_38_0 then
		if var_0_0.isTimelineStep(arg_38_0) then
			return true
		elseif arg_38_0.actType == FightEnum.ActType.CHANGEHERO then
			return true
		elseif arg_38_0.actType == FightEnum.ActType.CHANGEWAVE then
			return true
		end
	end
end

function var_0_0.buildInfoMOs(arg_39_0, arg_39_1)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_0) do
		local var_39_1 = arg_39_1.New()

		var_39_1:init(iter_39_1)
		table.insert(var_39_0, var_39_1)
	end

	return var_39_0
end

function var_0_0.logForPCSkillEditor(arg_40_0)
	if not SkillEditorMgr.instance.inEditMode or SLFramework.FrameworkSettings.IsEditor then
		logNormal(arg_40_0)
	end
end

function var_0_0.getEffectLabel(arg_41_0, arg_41_1)
	if gohelper.isNil(arg_41_0) then
		return
	end

	local var_41_0 = arg_41_0:GetComponentsInChildren(typeof(ZProj.EffectLabel))

	if not var_41_0 or var_41_0.Length <= 0 then
		return
	end

	local var_41_1 = {}

	for iter_41_0 = 0, var_41_0.Length - 1 do
		local var_41_2 = var_41_0[iter_41_0]

		if not arg_41_1 or var_41_2.label == arg_41_1 then
			table.insert(var_41_1, var_41_2)
		end
	end

	return var_41_1
end

function var_0_0.shouUIPoisoningEffect(arg_42_0)
	if FightConfig.instance:hasBuffFeature(arg_42_0, FightEnum.BuffType_Dot) then
		local var_42_0 = lua_skill_buff.configDict[arg_42_0]

		if var_42_0 and lua_fight_buff_use_poison_ui_effect.configDict[var_42_0.typeId] then
			return true
		end
	end

	return false
end

function var_0_0.dealDirectActEffectData(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = var_0_0.filterActEffect(arg_43_0, arg_43_2)
	local var_43_1 = #var_43_0
	local var_43_2 = {}

	if var_43_0[arg_43_1] then
		var_43_2 = var_43_0[arg_43_1]
	elseif var_43_1 > 0 then
		var_43_2 = var_43_0[var_43_1]
	end

	return var_43_2
end

function var_0_0.filterActEffect(arg_44_0, arg_44_1)
	local var_44_0 = {}
	local var_44_1 = {}
	local var_44_2 = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_0) do
		local var_44_3 = iter_44_1
		local var_44_4 = false

		if var_44_3.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(var_44_3) then
			var_44_4 = true
		end

		if not var_44_4 and arg_44_1[iter_44_1.effectType] then
			if not var_44_1[iter_44_1.targetId] then
				var_44_1[iter_44_1.targetId] = {}

				table.insert(var_44_2, iter_44_1.targetId)
			end

			table.insert(var_44_1[iter_44_1.targetId], iter_44_1)
		end
	end

	for iter_44_2, iter_44_3 in ipairs(var_44_2) do
		var_44_0[iter_44_2] = var_44_1[iter_44_3]
	end

	return var_44_0
end

function var_0_0.detectAttributeCounter()
	local var_45_0 = FightModel.instance:getFightParam()
	local var_45_1, var_45_2 = var_0_0.getAttributeCounter(var_45_0.monsterGroupIds, GameSceneMgr.instance:isSpScene())

	return var_45_1, var_45_2
end

function var_0_0.getAttributeCounter(arg_46_0, arg_46_1)
	local var_46_0
	local var_46_1 = {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_0) do
		if not string.nilorempty(lua_monster_group.configDict[iter_46_1].bossId) then
			local var_46_2 = lua_monster_group.configDict[iter_46_1].bossId
		end

		local var_46_3 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_46_1].monster, "#")

		for iter_46_2, iter_46_3 in ipairs(var_46_3) do
			if not lua_monster.configDict[iter_46_3] then
				logError("怪物表找不到id:" .. iter_46_3)
			end

			local var_46_4 = lua_monster.configDict[iter_46_3].career

			if var_46_4 ~= 5 and var_46_4 ~= 6 then
				var_46_1[var_46_4] = (var_46_1[var_46_4] or 0) + 1

				if var_0_0.isBossId(lua_monster_group.configDict[iter_46_1].bossId, iter_46_3) then
					var_46_1[var_46_4] = (var_46_1[var_46_4] or 0) + 1
				end
			end
		end
	end

	local var_46_5 = {}
	local var_46_6 = {}

	if arg_46_1 then
		return var_46_5, var_46_6
	end

	if #var_46_5 == 0 then
		local var_46_7 = 0
		local var_46_8 = 0
		local var_46_9 = {}
		local var_46_10 = {}

		for iter_46_4, iter_46_5 in pairs(var_46_1) do
			if iter_46_5 >= 2 then
				var_46_7 = var_46_7 + 1

				table.insert(var_46_10, iter_46_4)
			else
				var_46_8 = var_46_8 + 1

				table.insert(var_46_9, iter_46_4)
			end
		end

		if var_46_7 == 1 then
			table.insert(var_46_5, FightConfig.instance:restrainedBy(var_46_10[1]))
			table.insert(var_46_6, FightConfig.instance:restrained(var_46_10[1]))
		elseif var_46_7 == 2 then
			if var_0_0.checkHadRestrain(var_46_10[1], var_46_10[2]) then
				table.insert(var_46_5, FightConfig.instance:restrainedBy(var_46_10[1]))
				table.insert(var_46_5, FightConfig.instance:restrainedBy(var_46_10[2]))
				table.insert(var_46_6, FightConfig.instance:restrained(var_46_10[1]))
				table.insert(var_46_6, FightConfig.instance:restrained(var_46_10[2]))
			end
		elseif var_46_7 == 0 then
			if var_46_8 == 1 then
				table.insert(var_46_5, FightConfig.instance:restrainedBy(var_46_9[1]))
				table.insert(var_46_6, FightConfig.instance:restrained(var_46_9[1]))
			elseif var_46_8 == 2 and var_0_0.checkHadRestrain(var_46_9[1], var_46_9[2]) then
				table.insert(var_46_5, FightConfig.instance:restrainedBy(var_46_9[1]))
				table.insert(var_46_5, FightConfig.instance:restrainedBy(var_46_9[2]))
				table.insert(var_46_6, FightConfig.instance:restrained(var_46_9[1]))
				table.insert(var_46_6, FightConfig.instance:restrained(var_46_9[2]))
			end
		end
	end

	for iter_46_6 = #var_46_6, 1, -1 do
		if tabletool.indexOf(var_46_5, var_46_6[1]) then
			table.remove(var_46_6, iter_46_6)
		end
	end

	return var_46_5, var_46_6
end

function var_0_0.checkHadRestrain(arg_47_0, arg_47_1)
	return FightConfig.instance:getRestrain(arg_47_0, arg_47_1) > 1000 or FightConfig.instance:getRestrain(arg_47_1, arg_47_0) > 1000
end

function var_0_0.setMonsterGuideFocusState(arg_48_0)
	local var_48_0 = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(arg_48_0)

	PlayerPrefsHelper.setNumber(var_48_0, 1)

	if not string.nilorempty(arg_48_0.completeWithGroup) then
		local var_48_1 = FightStrUtil.instance:getSplitCache(arg_48_0.completeWithGroup, "|")

		for iter_48_0, iter_48_1 in ipairs(var_48_1) do
			local var_48_2 = FightStrUtil.instance:getSplitToNumberCache(iter_48_1, "#")
			local var_48_3 = FightConfig.instance:getMonsterGuideFocusConfig(var_48_2[1], var_48_2[2], var_48_2[3], var_48_2[4])

			if var_48_3 then
				local var_48_4 = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(var_48_3)

				PlayerPrefsHelper.setNumber(var_48_4, 1)
			else
				logError("怪物指引图表找不到id：", var_48_2[1], var_48_2[2], var_48_2[3], var_48_2[4])
			end
		end
	end
end

function var_0_0.detectTimelinePlayEffectCondition(arg_49_0, arg_49_1, arg_49_2)
	if string.nilorempty(arg_49_1) or arg_49_1 == "0" then
		return true
	end

	if arg_49_1 == "1" then
		local var_49_0 = false

		for iter_49_0, iter_49_1 in pairs(arg_49_0.actEffect) do
			if iter_49_1.effectType == FightEnum.EffectType.DEAD then
				var_49_0 = true
			end
		end

		return var_49_0
	end

	local var_49_1 = FightStrUtil.instance:getSplitToNumberCache(arg_49_1, "#")
	local var_49_2 = var_49_1[1]

	if var_49_2 == 2 then
		for iter_49_2, iter_49_3 in ipairs(arg_49_0.actEffect) do
			if iter_49_3.effectType == FightEnum.EffectType.MISS or iter_49_3.effectType == FightEnum.EffectType.DAMAGE or iter_49_3.effectType == FightEnum.EffectType.CRIT or iter_49_3.effectType == FightEnum.EffectType.SHIELD then
				local var_49_3 = var_0_0.getEntity(iter_49_3.targetId)

				for iter_49_4 = 2, #var_49_1 do
					if arg_49_2 then
						if arg_49_2 == var_49_3 and var_0_0.detectEntityIncludeBuffType(var_49_3, var_49_1[iter_49_4]) then
							return true
						end
					elseif var_0_0.detectEntityIncludeBuffType(var_49_3, var_49_1[iter_49_4]) then
						return true
					end
				end
			end
		end
	end

	if var_49_2 == 3 then
		local var_49_4 = var_0_0.getEntity(arg_49_0.fromId)

		if var_49_4 then
			for iter_49_5 = 2, #var_49_1 do
				if var_0_0.detectEntityIncludeBuffType(var_49_4, var_49_1[iter_49_5]) then
					return true
				end
			end
		end
	end

	if var_49_2 == 4 then
		for iter_49_6, iter_49_7 in ipairs(arg_49_0.actEffect) do
			if iter_49_7.effectType == FightEnum.EffectType.MISS or iter_49_7.effectType == FightEnum.EffectType.DAMAGE or iter_49_7.effectType == FightEnum.EffectType.CRIT or iter_49_7.effectType == FightEnum.EffectType.SHIELD then
				local var_49_5 = var_0_0.getEntity(iter_49_7.targetId)

				for iter_49_8 = 2, #var_49_1 do
					if arg_49_2 then
						if arg_49_2 == var_49_5 and arg_49_2.buff and arg_49_2.buff:haveBuffId(var_49_1[iter_49_8]) then
							return true
						end
					elseif var_49_5.buff and var_49_5.buff:haveBuffId(var_49_1[iter_49_8]) then
						return true
					end
				end
			end
		end
	end

	if var_49_2 == 5 then
		local var_49_6 = var_0_0.getEntity(arg_49_0.fromId)

		if var_49_6 and var_49_6.buff then
			for iter_49_9 = 2, #var_49_1 do
				if var_49_6.buff:haveBuffId(var_49_1[iter_49_9]) then
					return true
				end
			end
		end
	end

	if var_49_2 == 6 then
		for iter_49_10, iter_49_11 in ipairs(arg_49_0.actEffect) do
			if iter_49_11.effectType == FightEnum.EffectType.MISS or iter_49_11.effectType == FightEnum.EffectType.DAMAGE or iter_49_11.effectType == FightEnum.EffectType.CRIT or iter_49_11.effectType == FightEnum.EffectType.SHIELD then
				local var_49_7 = var_0_0.getEntity(iter_49_11.targetId)

				for iter_49_12 = 2, #var_49_1 do
					if arg_49_2 then
						if arg_49_2 == var_49_7 then
							local var_49_8 = arg_49_2:getMO()

							if var_49_8 and var_49_8.skin == var_49_1[iter_49_12] then
								return true
							end
						end
					else
						local var_49_9 = var_49_7:getMO()

						if var_49_9 and var_49_9.skin == var_49_1[iter_49_12] then
							return true
						end
					end
				end
			end
		end
	end

	if var_49_2 == 7 then
		for iter_49_13, iter_49_14 in ipairs(arg_49_0.actEffect) do
			if iter_49_14.targetId == arg_49_0.fromId and iter_49_14.configEffect == var_49_1[2] then
				if iter_49_14.configEffect == 30011 then
					if iter_49_14.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if var_49_2 == 8 then
		for iter_49_15, iter_49_16 in ipairs(arg_49_0.actEffect) do
			if iter_49_16.targetId ~= arg_49_0.fromId and iter_49_16.configEffect == var_49_1[2] then
				if iter_49_16.configEffect == 30011 then
					if iter_49_16.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if var_49_2 == 9 then
		local var_49_10 = var_0_0.getEntity(arg_49_0.fromId)

		if var_49_10 and var_49_10.buff then
			for iter_49_17 = 2, #var_49_1 do
				if var_49_10.buff:haveBuffId(var_49_1[iter_49_17]) then
					return false
				end
			end

			return true
		end
	elseif var_49_2 == 10 then
		local var_49_11 = arg_49_0.playerOperationCountForPlayEffectTimeline

		if var_49_11 and var_49_1[2] == var_49_11 then
			return true
		end
	elseif var_49_2 == 11 then
		local var_49_12 = var_49_1[2]
		local var_49_13 = var_49_1[3]
		local var_49_14 = FightDataHelper.entityMgr:getById(arg_49_0.fromId)

		if var_49_14 then
			local var_49_15 = var_49_14:getPowerInfo(FightEnum.PowerType.Power)

			if var_49_15 then
				if var_49_12 == 1 then
					return var_49_13 < var_49_15.num
				elseif var_49_12 == 2 then
					return var_49_13 > var_49_15.num
				elseif var_49_12 == 3 then
					return var_49_15.num == var_49_13
				elseif var_49_12 == 4 then
					return var_49_13 <= var_49_15.num
				elseif var_49_12 == 5 then
					return var_49_13 >= var_49_15.num
				end
			end
		end
	elseif var_49_2 == 12 then
		return arg_49_0.playerOperationCountForPlayEffectTimeline == arg_49_0.maxPlayerOperationCountForPlayEffectTimeline
	end

	return false
end

function var_0_0.detectEntityIncludeBuffType(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_0 and arg_50_0:getMO()

	arg_50_2 = arg_50_2 or var_50_0 and var_50_0:getBuffList() or {}

	for iter_50_0, iter_50_1 in ipairs(arg_50_2) do
		local var_50_1 = lua_skill_buff.configDict[iter_50_1.buffId]

		if arg_50_1 == lua_skill_bufftype.configDict[var_50_1.typeId].type then
			return true
		end
	end
end

function var_0_0.hideDefenderBuffEffect(arg_51_0, arg_51_1)
	local var_51_0 = lua_skin_monster_hide_buff_effect.configDict[arg_51_0.actId]
	local var_51_1 = {}

	if var_51_0 then
		local var_51_2 = {}
		local var_51_3

		if var_51_0.effectName == "all" then
			var_51_3 = true
		end

		local var_51_4 = FightStrUtil.instance:getSplitCache(var_51_0.effectName, "#")
		local var_51_5 = var_0_0.getDefenders(arg_51_0, true)
		local var_51_6 = {}

		for iter_51_0, iter_51_1 in ipairs(var_51_5) do
			if not var_51_6[iter_51_1.id] then
				var_51_6[iter_51_1.id] = true

				if var_0_0.isAssembledMonster(iter_51_1) then
					local var_51_7 = var_0_0.getSideEntitys(iter_51_1:getSide())

					for iter_51_2, iter_51_3 in ipairs(var_51_7) do
						if var_0_0.isAssembledMonster(iter_51_3) and not var_51_6[iter_51_3.id] then
							var_51_6[iter_51_3.id] = true

							table.insert(var_51_5, iter_51_3)
						end
					end
				end
			end
		end

		for iter_51_4, iter_51_5 in ipairs(var_51_5) do
			if var_51_3 then
				local var_51_8 = iter_51_5.skinSpineEffect

				if var_51_8 then
					var_51_1[iter_51_5.id] = iter_51_5.id

					if var_51_8._effectWrapDict then
						for iter_51_6, iter_51_7 in pairs(var_51_8._effectWrapDict) do
							table.insert(var_51_2, iter_51_7)
						end
					end
				end
			end

			local var_51_9 = iter_51_5.buff and iter_51_5.buff._buffEffectDict

			if var_51_9 then
				for iter_51_8, iter_51_9 in pairs(var_51_9) do
					if var_51_3 then
						var_51_1[iter_51_5.id] = iter_51_5.id

						table.insert(var_51_2, iter_51_9)
					else
						for iter_51_10, iter_51_11 in ipairs(var_51_4) do
							if var_0_0.getEffectUrlWithLod(iter_51_11) == iter_51_9.path then
								var_51_1[iter_51_5.id] = iter_51_5.id

								table.insert(var_51_2, iter_51_9)
							end
						end
					end
				end
			end

			local var_51_10 = iter_51_5.buff and iter_51_5.buff._loopBuffEffectWrapDict

			if var_51_10 then
				for iter_51_12, iter_51_13 in pairs(var_51_10) do
					if var_51_3 then
						var_51_1[iter_51_5.id] = iter_51_5.id

						table.insert(var_51_2, iter_51_13)
					else
						for iter_51_14, iter_51_15 in ipairs(var_51_4) do
							if var_0_0.getEffectUrlWithLod(iter_51_15) == iter_51_13.path then
								var_51_1[iter_51_5.id] = iter_51_5.id

								table.insert(var_51_2, iter_51_13)
							end
						end
					end
				end
			end
		end

		local var_51_11 = FightStrUtil.instance:getSplitCache(var_51_0.exceptEffect, "#")
		local var_51_12 = {}

		for iter_51_16, iter_51_17 in ipairs(var_51_11) do
			var_51_12[var_0_0.getEffectUrlWithLod(iter_51_17)] = true
		end

		for iter_51_18, iter_51_19 in ipairs(var_51_2) do
			local var_51_13 = var_51_2[iter_51_18]

			if not var_51_12[var_51_13.path] then
				var_51_13:setActive(false, arg_51_1)
			end
		end
	end

	return var_51_1
end

function var_0_0.revertDefenderBuffEffect(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in ipairs(arg_52_0) do
		local var_52_0 = var_0_0.getEntity(iter_52_1)

		if var_52_0 then
			if var_52_0.buff then
				var_52_0.buff:showBuffEffects(arg_52_1)
			end

			if var_52_0.skinSpineEffect then
				var_52_0.skinSpineEffect:showEffects(arg_52_1)
			end
		end
	end
end

function var_0_0.getEffectAbPath(arg_53_0)
	if GameResMgr.IsFromEditorDir or string.find(arg_53_0, "/buff/") or string.find(arg_53_0, "/always/") then
		return arg_53_0
	else
		if isDebugBuild and string.find(arg_53_0, "always") then
			logError(arg_53_0)
		end

		return SLFramework.FileHelper.GetUnityPath(System.IO.Path.GetDirectoryName(arg_53_0))
	end
end

function var_0_0.getRolesTimelinePath(arg_54_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getSkillTimeline(arg_54_0)
	else
		return ResUrl.getRolesTimeline()
	end
end

function var_0_0.getCameraAniPath(arg_55_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getCameraAnim(arg_55_0)
	else
		return ResUrl.getCameraAnimABUrl()
	end
end

function var_0_0.getEntityAniPath(arg_56_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getEntityAnim(arg_56_0)
	else
		return ResUrl.getEntityAnimABUrl()
	end
end

function var_0_0.refreshCombinativeMonsterScaleAndPos(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:getMO()

	if not var_57_0 then
		return
	end

	local var_57_1 = FightConfig.instance:getSkinCO(var_57_0.skin)

	if var_57_1 and var_57_1.canHide == 1 then
		-- block empty
	else
		return
	end

	local var_57_2 = var_0_0.getSideEntitys(arg_57_0:getSide())
	local var_57_3

	for iter_57_0, iter_57_1 in ipairs(var_57_2) do
		iter_57_1:setScale(arg_57_1)

		local var_57_4 = iter_57_1:getMO()

		if var_57_4 then
			local var_57_5 = FightConfig.instance:getSkinCO(var_57_4.skin)

			if var_57_5 and var_57_5.mainBody == 1 then
				var_57_3 = iter_57_1
			end
		end
	end

	if var_57_3 then
		local var_57_6, var_57_7, var_57_8 = var_0_0.getEntityStandPos(var_57_3:getMO())
		local var_57_9, var_57_10, var_57_11 = transformhelper.getPos(var_57_3.go.transform)

		for iter_57_2, iter_57_3 in ipairs(var_57_2) do
			if iter_57_3 ~= var_57_3 then
				local var_57_12, var_57_13, var_57_14 = var_0_0.getEntityStandPos(iter_57_3:getMO())
				local var_57_15 = var_57_12 - var_57_6
				local var_57_16 = var_57_13 - var_57_7
				local var_57_17 = var_57_14 - var_57_8

				transformhelper.setPos(iter_57_3.go.transform, var_57_15 * arg_57_1 + var_57_9, var_57_16 * arg_57_1 + var_57_10, var_57_17 * arg_57_1 + var_57_11)
			end
		end
	end
end

function var_0_0.getEntityDefaultIdleAniName(arg_58_0)
	local var_58_0 = arg_58_0:getMO()

	if var_58_0 and var_58_0.modelId == 3025 then
		local var_58_1 = var_0_0.getSideEntitys(arg_58_0:getSide(), true)

		for iter_58_0, iter_58_1 in ipairs(var_58_1) do
			if iter_58_1:getMO().modelId == 3028 then
				return SpineAnimState.idle_special
			end
		end
	end

	return SpineAnimState.idle1
end

var_0_0.XingTiSpineUrl2Special = {
	["roles/500502_xingti2hao/500502_xingti2hao_fight.prefab"] = "roles/500502_xingti2hao_special/500502_xingti2hao_special_fight.prefab",
	["roles/500503_xingti2hao/500503_xingti2hao_fight.prefab"] = "roles/500503_xingti2hao_special/500503_xingti2hao_special_fight.prefab",
	["roles/500501_xingti2hao/500501_xingti2hao_fight.prefab"] = "roles/500501_xingti2hao_special/500501_xingti2hao_special_fight.prefab"
}

function var_0_0.preloadXingTiSpecialUrl(arg_59_0)
	if var_0_0.isShowTogether(FightEnum.EntitySide.MySide, {
		3025,
		3028
	}) then
		for iter_59_0, iter_59_1 in ipairs(arg_59_0) do
			if iter_59_1 == 3025 then
				return 2
			end
		end

		return 1
	end
end

function var_0_0.detectXingTiSpecialUrl(arg_60_0)
	if arg_60_0:isMySide() then
		local var_60_0 = arg_60_0:getSide()

		return var_0_0.isShowTogether(var_60_0, {
			3025,
			3028
		})
	end
end

function var_0_0.isShowTogether(arg_61_0, arg_61_1)
	local var_61_0 = FightDataHelper.entityMgr:getSideList(arg_61_0)
	local var_61_1 = 0

	for iter_61_0, iter_61_1 in ipairs(var_61_0) do
		if tabletool.indexOf(arg_61_1, iter_61_1.modelId) then
			var_61_1 = var_61_1 + 1
		end
	end

	if var_61_1 == #arg_61_1 then
		return true
	end
end

function var_0_0.getPredeductionExpoint(arg_62_0)
	local var_62_0 = 0

	if FightModel.instance:getCurStage() == FightEnum.Stage.Card then
		local var_62_1 = var_0_0.getEntity(arg_62_0)

		if var_62_1 then
			local var_62_2 = var_62_1:getMO()
			local var_62_3 = FightDataHelper.operationDataMgr:getOpList()

			for iter_62_0, iter_62_1 in ipairs(var_62_3) do
				if arg_62_0 == iter_62_1.belongToEntityId and iter_62_1:isPlayCard() and FightCardDataHelper.isBigSkill(iter_62_1.skillId) and not FightCardDataHelper.isSkill3(iter_62_1.cardInfoMO) then
					local var_62_4 = true
					local var_62_5 = lua_skill.configDict[iter_62_1.skillId]

					if var_62_5 and var_62_5.needExPoint == 1 then
						var_62_4 = false
					end

					if var_62_4 then
						var_62_0 = var_62_0 + var_62_2:getUniqueSkillPoint()
					end
				end
			end
		end
	end

	return var_62_0
end

function var_0_0.setBossSkillSpeed(arg_63_0)
	local var_63_0 = var_0_0.getEntity(arg_63_0)
	local var_63_1 = var_63_0 and var_63_0:getMO()

	if var_63_1 then
		local var_63_2 = lua_monster_skin.configDict[var_63_1.skin]

		if var_63_2 and var_63_2.bossSkillSpeed == 1 then
			FightModel.instance.useBossSkillSpeed = true

			FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
		end
	end
end

function var_0_0.cancelBossSkillSpeed()
	if FightModel.instance.useBossSkillSpeed then
		FightModel.instance.useBossSkillSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.setTimelineExclusiveSpeed(arg_65_0)
	local var_65_0 = lua_fight_timeline_speed.configDict[arg_65_0]

	if var_65_0 then
		local var_65_1 = FightModel.instance:getUserSpeed()
		local var_65_2 = FightStrUtil.instance:getSplitToNumberCache(var_65_0.speed, "#")

		FightModel.instance.useExclusiveSpeed = var_65_2[var_65_1]

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.cancelExclusiveSpeed()
	if FightModel.instance.useExclusiveSpeed then
		FightModel.instance.useExclusiveSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.needPlayTransitionAni(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0 and arg_67_0:getMO()

	if var_67_0 then
		local var_67_1 = var_67_0.skin
		local var_67_2 = lua_fight_transition_act.configDict[var_67_1]

		if var_67_2 then
			local var_67_3 = arg_67_0.spine:getAnimState()

			if var_67_2[var_67_3] and var_67_2[var_67_3][arg_67_1] then
				return true, var_67_2[var_67_3][arg_67_1].transitionAct
			end
		end
	end
end

function var_0_0._stepBuffDealStackedBuff(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = false

	if arg_68_3 then
		local var_68_1 = arg_68_3.actEffectData

		if var_68_1 and not FightSkillBuffMgr.instance:hasPlayBuff(var_68_1) then
			local var_68_2 = lua_skill_buff.configDict[var_68_1.buff.buffId]

			if var_68_2 and var_68_2.id == arg_68_2.id and var_68_1.effectType == FightEnum.EffectType.BUFFADD then
				var_68_0 = true
			end
		end
	end

	table.insert(arg_68_1, FunctionWork.New(function()
		local var_69_0 = var_0_0.getEntity(arg_68_0)

		if var_69_0 then
			var_69_0.buff.lockFloat = var_68_0
		end
	end))
	table.insert(arg_68_1, WorkWaitSeconds.New(0.01))
end

function var_0_0.hideAllEntity()
	local var_70_0 = var_0_0.getAllEntitys()

	for iter_70_0, iter_70_1 in ipairs(var_70_0) do
		iter_70_1:setActive(false, true)
		iter_70_1:setVisibleByPos(false)
		iter_70_1:setAlpha(0, 0)
	end
end

function var_0_0.isBossId(arg_71_0, arg_71_1)
	local var_71_0 = FightStrUtil.instance:getSplitToNumberCache(arg_71_0, "#")

	for iter_71_0, iter_71_1 in ipairs(var_71_0) do
		if arg_71_1 == iter_71_1 then
			return true
		end
	end
end

function var_0_0.getCurBossId()
	local var_72_0 = FightModel.instance:getCurMonsterGroupId()
	local var_72_1 = var_72_0 and lua_monster_group.configDict[var_72_0]

	return var_72_1 and not string.nilorempty(var_72_1.bossId) and var_72_1.bossId or nil
end

function var_0_0.setEffectEntitySide(arg_73_0, arg_73_1)
	if FightModel.instance:getVersion() >= 1 then
		return
	end

	local var_73_0 = arg_73_0.targetId

	if var_73_0 == FightEntityScene.MySideId then
		arg_73_1.side = FightEnum.EntitySide.MySide

		return
	elseif var_73_0 == FightEntityScene.EnemySideId then
		arg_73_1.side = FightEnum.EntitySide.EnemySide

		return
	end

	local var_73_1 = FightDataHelper.entityMgr:getById(var_73_0)

	if var_73_1 then
		arg_73_1.side = var_73_1.side
	end
end

function var_0_0.preloadZongMaoShaLiMianJu(arg_74_0, arg_74_1)
	local var_74_0 = var_0_0.getZongMaoShaLiMianJuPath(arg_74_0)

	if var_74_0 then
		table.insert(arg_74_1, var_74_0)
	end
end

function var_0_0.setZongMaoShaLiMianJuSpineUrl(arg_75_0, arg_75_1)
	local var_75_0 = var_0_0.getZongMaoShaLiMianJuPath(arg_75_0)

	if var_75_0 then
		arg_75_1[var_75_0] = true
	end
end

function var_0_0.getZongMaoShaLiMianJuPath(arg_76_0)
	local var_76_0 = lua_skin.configDict[arg_76_0]

	if var_76_0 and var_76_0.characterId == 3072 then
		local var_76_1 = string.format("roles/v1a3_%d_zongmaoshali_m/%d_zongmaoshali_m_fight.prefab", arg_76_0, arg_76_0)

		if var_76_0.id == 307203 then
			var_76_1 = "roles/v2a2_307203_zmsl_m/307203_zmsl_m_fight.prefab"
		end

		return var_76_1
	end
end

function var_0_0.getEnemyEntityByMonsterId(arg_77_0)
	local var_77_0 = var_0_0.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for iter_77_0, iter_77_1 in ipairs(var_77_0) do
		local var_77_1 = iter_77_1:getMO()

		if var_77_1 and var_77_1.modelId == arg_77_0 then
			return iter_77_1
		end
	end
end

function var_0_0.sortAssembledMonster(arg_78_0)
	local var_78_0 = arg_78_0:getByIndex(1)

	if var_78_0 and lua_fight_assembled_monster.configDict[var_78_0.skin] then
		arg_78_0:sort(var_0_0.sortAssembledMonsterFunc)
	end
end

function var_0_0.sortAssembledMonsterFunc(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0 and lua_fight_assembled_monster.configDict[arg_79_0.skin]
	local var_79_1 = arg_79_1 and lua_fight_assembled_monster.configDict[arg_79_1.skin]

	if var_79_0 and not var_79_1 then
		return true
	elseif not var_79_0 and var_79_1 then
		return false
	elseif var_79_0 and var_79_1 then
		return var_79_0.part < var_79_1.part
	else
		return tonumber(arg_79_0.id) > tonumber(arg_79_1.id)
	end
end

function var_0_0.sortBuffReplaceSpineActConfig(arg_80_0, arg_80_1)
	return arg_80_0.priority > arg_80_1.priority
end

function var_0_0.processEntityActionName(arg_81_0, arg_81_1, arg_81_2)
	if not arg_81_1 then
		return
	end

	local var_81_0 = arg_81_0:getMO()

	if var_81_0 then
		local var_81_1 = lua_fight_buff_replace_spine_act.configDict[var_81_0.skin]

		if var_81_1 then
			local var_81_2 = {}

			for iter_81_0, iter_81_1 in pairs(var_81_1) do
				for iter_81_2, iter_81_3 in pairs(iter_81_1) do
					table.insert(var_81_2, iter_81_3)
				end
			end

			table.sort(var_81_2, var_0_0.sortBuffReplaceSpineActConfig)

			local var_81_3 = arg_81_0.buff

			if var_81_3 then
				for iter_81_4, iter_81_5 in ipairs(var_81_2) do
					if var_81_3:haveBuffId(iter_81_5.buffId) then
						local var_81_4 = 0

						for iter_81_6, iter_81_7 in ipairs(iter_81_5.combination) do
							if var_81_3:haveBuffId(iter_81_7) then
								var_81_4 = var_81_4 + 1
							end
						end

						if var_81_4 == #iter_81_5.combination and arg_81_0.spine and arg_81_0.spine:hasAnimation(arg_81_1 .. iter_81_5.suffix) then
							arg_81_1 = arg_81_1 .. iter_81_5.suffix

							break
						end
					end
				end
			end
		end
	end

	if arg_81_1 and var_81_0 then
		local var_81_5 = lua_fight_skin_special_behaviour.configDict[var_81_0.skin]

		if var_81_5 then
			local var_81_6 = arg_81_0.buff

			if var_81_6 then
				local var_81_7 = arg_81_1

				if string.find(var_81_7, "hit") then
					var_81_7 = "hit"
				end

				if not string.nilorempty(var_81_5[var_81_7]) then
					local var_81_8 = GameUtil.splitString2(var_81_5[var_81_7])

					for iter_81_8, iter_81_9 in ipairs(var_81_8) do
						local var_81_9 = tonumber(iter_81_9[1])

						if var_81_6:haveBuffId(var_81_9) then
							arg_81_1 = iter_81_9[2]
						end
					end
				end
			end
		end
	end

	if var_0_0.isAssembledMonster(arg_81_0) and arg_81_1 == "hit" then
		local var_81_10 = arg_81_0:getPartIndex()

		if arg_81_2 then
			for iter_81_10, iter_81_11 in ipairs(arg_81_2.actEffect) do
				if FightTLEventDefHit.directCharacterHitEffectType[iter_81_11.effectType] and iter_81_11.targetId ~= arg_81_0.id then
					local var_81_11 = var_0_0.getEntity(iter_81_11.targetId)

					if isTypeOf(var_81_11, FightEntityAssembledMonsterMain) or isTypeOf(var_81_11, FightEntityAssembledMonsterSub) then
						return arg_81_1
					end
				end
			end
		end

		arg_81_1 = string.format("%s_part_%d", arg_81_1, var_81_10)
	end

	return arg_81_1
end

function var_0_0.getProcessEntityStancePos(arg_82_0)
	local var_82_0, var_82_1, var_82_2 = var_0_0.getEntityStandPos(arg_82_0)
	local var_82_3 = var_0_0.getEntity(arg_82_0.id)

	if var_82_3 and var_0_0.isAssembledMonster(var_82_3) then
		local var_82_4 = lua_fight_assembled_monster.configDict[arg_82_0.skin].virtualStance

		return var_82_0 + var_82_4[1], var_82_1 + var_82_4[2], var_82_2 + var_82_4[3]
	end

	return var_82_0, var_82_1, var_82_2
end

function var_0_0.isAssembledMonster(arg_83_0)
	if isTypeOf(arg_83_0, FightEntityAssembledMonsterMain) or isTypeOf(arg_83_0, FightEntityAssembledMonsterSub) then
		return true
	end
end

function var_0_0.getProcessEntitySpinePos(arg_84_0)
	local var_84_0, var_84_1, var_84_2 = transformhelper.getPos(arg_84_0.go.transform)

	if var_0_0.isAssembledMonster(arg_84_0) then
		local var_84_3 = arg_84_0:getMO()
		local var_84_4 = lua_fight_assembled_monster.configDict[var_84_3.skin]

		var_84_0 = var_84_0 + var_84_4.virtualStance[1]
		var_84_1 = var_84_1 + var_84_4.virtualStance[2]
		var_84_2 = var_84_2 + var_84_4.virtualStance[3]
	end

	return var_84_0, var_84_1, var_84_2
end

function var_0_0.getProcessEntitySpineLocalPos(arg_85_0)
	local var_85_0 = 0
	local var_85_1 = 0
	local var_85_2 = 0

	if var_0_0.isAssembledMonster(arg_85_0) then
		local var_85_3 = arg_85_0:getMO()
		local var_85_4 = lua_fight_assembled_monster.configDict[var_85_3.skin]

		var_85_0 = var_85_0 + var_85_4.virtualStance[1]
		var_85_1 = var_85_1 + var_85_4.virtualStance[2]
		var_85_2 = var_85_2 + var_85_4.virtualStance[3]
	end

	return var_85_0, var_85_1, var_85_2
end

local var_0_6 = {}

function var_0_0.getAssembledEffectPosOfSpineHangPointRoot(arg_86_0, arg_86_1)
	if var_0_6[arg_86_1] then
		return 0, 0, 0
	end

	return var_0_0.getProcessEntitySpineLocalPos(arg_86_0)
end

function var_0_0.processBuffEffectPath(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4)
	local var_87_0 = lua_fight_effect_buff_skin.configDict[arg_87_2]

	if var_87_0 then
		local var_87_1 = {
			delEffect = "delAudio",
			effectPath = "audio",
			triggerEffect = "triggerAudio"
		}
		local var_87_2 = arg_87_1:getSide()

		if var_87_0[1] then
			var_87_2 = FightEnum.EntitySide.MySide == var_87_2 and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
			var_87_0 = var_87_0[1]
		else
			var_87_0 = var_87_0[2]
		end

		local var_87_3 = var_0_0.getSideEntitys(var_87_2, true)

		for iter_87_0, iter_87_1 in ipairs(var_87_3) do
			local var_87_4 = iter_87_1:getMO()

			if var_87_4 then
				local var_87_5 = var_87_4.skin

				if var_87_0[var_87_5] and not string.nilorempty(var_87_0[var_87_5][arg_87_3]) then
					local var_87_6 = var_87_0[var_87_5][var_87_1[arg_87_3]]

					return var_87_0[var_87_5][arg_87_3], var_87_6 ~= 0 and var_87_6 or arg_87_4, var_87_0[var_87_5]
				end
			end
		end
	end

	return arg_87_0, arg_87_4
end

function var_0_0.filterBuffEffectBySkin(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	local var_88_0 = lua_fight_buff_effect_to_skin.configDict[arg_88_0]

	if not var_88_0 then
		return arg_88_2, arg_88_3
	end

	local var_88_1 = arg_88_1 and arg_88_1:getMO()
	local var_88_2 = var_88_1 and var_88_1.skin

	if not var_88_2 then
		return "", 0
	end

	local var_88_3 = FightStrUtil.instance:getSplitToNumberCache(var_88_0.skinIdList, "|")

	if tabletool.indexOf(var_88_3, var_88_2) then
		return arg_88_2, arg_88_3
	end

	return "", 0
end

function var_0_0.getBuffListForReplaceTimeline(arg_89_0, arg_89_1, arg_89_2)
	local var_89_0 = var_0_0.getEntitysCloneBuff(arg_89_1)

	if arg_89_0 and arg_89_0.simulate == 1 then
		var_89_0 = var_0_0.simulateFightStepData(arg_89_2, var_89_0)
	end

	local var_89_1 = {}

	for iter_89_0, iter_89_1 in pairs(var_89_0) do
		tabletool.addValues(var_89_1, iter_89_1)
	end

	return var_89_1
end

function var_0_0.getTimelineListByName(arg_90_0, arg_90_1)
	local var_90_0 = arg_90_0
	local var_90_1 = {}
	local var_90_2 = lua_fight_replace_timeline.configDict[arg_90_0]

	if var_90_2 then
		for iter_90_0, iter_90_1 in pairs(var_90_2) do
			local var_90_3 = FightStrUtil.instance:getSplitCache(iter_90_1.condition, "#")

			if var_90_3[1] == "5" then
				local var_90_4 = {}

				for iter_90_2 = 2, #var_90_3 do
					var_90_4[tonumber(var_90_3[iter_90_2])] = true
				end

				if var_90_4[arg_90_1] then
					var_90_0 = iter_90_1.timeline
				end
			else
				table.insert(var_90_1, iter_90_1.timeline)
			end
		end
	end

	table.insert(var_90_1, var_90_0)

	return var_90_1
end

local var_0_7 = {}

function var_0_0.detectReplaceTimeline(arg_91_0, arg_91_1)
	local var_91_0 = lua_fight_replace_timeline.configDict[arg_91_0]

	if var_91_0 then
		local var_91_1 = {}

		for iter_91_0, iter_91_1 in pairs(var_91_0) do
			table.insert(var_91_1, iter_91_1)
		end

		table.sort(var_91_1, var_0_0.sortReplaceTimelineConfig)

		for iter_91_2, iter_91_3 in ipairs(var_91_1) do
			local var_91_2 = {}

			if iter_91_3.target == 1 then
				var_91_2[arg_91_1.fromId] = FightDataHelper.entityMgr:getById(arg_91_1.fromId)
			elseif iter_91_3.target == 2 then
				var_91_2[arg_91_1.toId] = FightDataHelper.entityMgr:getById(arg_91_1.toId)
			elseif iter_91_3.target == 3 or iter_91_3.target == 4 then
				local var_91_3
				local var_91_4 = arg_91_1.fromId

				if var_91_4 == FightEntityScene.MySideId then
					var_91_3 = FightEnum.EntitySide.MySide
				elseif var_91_4 == FightEntityScene.EnemySideId then
					var_91_3 = FightEnum.EntitySide.EnemySide
				else
					local var_91_5 = FightDataHelper.entityMgr:getById(arg_91_1.fromId)

					if var_91_5 then
						var_91_3 = var_91_5.side
					else
						var_91_3 = FightEnum.EntitySide.MySide
					end
				end

				local var_91_6 = FightDataHelper.entityMgr:getSideList(var_91_3, nil, iter_91_3.target == 4)

				for iter_91_4, iter_91_5 in ipairs(var_91_6) do
					var_91_2[iter_91_5.id] = iter_91_5
				end
			end

			local var_91_7 = FightStrUtil.instance:getSplitCache(iter_91_3.condition, "#")
			local var_91_8 = var_91_7[1]

			if var_91_8 == "1" then
				local var_91_9 = var_0_0.getBuffListForReplaceTimeline(iter_91_3, var_91_2, arg_91_1)
				local var_91_10 = tonumber(var_91_7[2])
				local var_91_11 = tonumber(var_91_7[3])

				for iter_91_6, iter_91_7 in ipairs(var_91_9) do
					if iter_91_7.buffId == var_91_10 and var_91_11 <= iter_91_7.count then
						return iter_91_3.timeline
					end
				end
			elseif var_91_8 == "2" then
				for iter_91_8, iter_91_9 in pairs(arg_91_1.actEffect) do
					if iter_91_9.effectType == FightEnum.EffectType.DEAD then
						return iter_91_3.timeline
					end
				end
			elseif var_91_8 == "3" then
				local var_91_12 = var_0_0.getBuffListForReplaceTimeline(iter_91_3, var_91_2, arg_91_1)

				for iter_91_10 = 2, #var_91_7 do
					if var_0_0.detectEntityIncludeBuffType(nil, tonumber(var_91_7[iter_91_10]), var_91_12) then
						return iter_91_3.timeline
					end
				end
			elseif var_91_8 == "4" then
				local var_91_13 = {}

				for iter_91_11 = 2, #var_91_7 do
					var_91_13[tonumber(var_91_7[iter_91_11])] = true
				end

				local var_91_14 = var_0_0.getBuffListForReplaceTimeline(iter_91_3, var_91_2, arg_91_1)

				for iter_91_12, iter_91_13 in ipairs(var_91_14) do
					if var_91_13[iter_91_13.buffId] then
						return iter_91_3.timeline
					end
				end
			elseif var_91_8 == "5" then
				local var_91_15 = {}

				for iter_91_14 = 2, #var_91_7 do
					var_91_15[tonumber(var_91_7[iter_91_14])] = true
				end

				for iter_91_15, iter_91_16 in pairs(var_91_2) do
					local var_91_16 = iter_91_16.skin

					if iter_91_3.target == 1 then
						var_91_16 = var_0_0.processSkinByStepData(arg_91_1, iter_91_16)
					end

					if iter_91_16 and var_91_15[var_91_16] then
						return iter_91_3.timeline
					end
				end
			elseif var_91_8 == "6" then
				local var_91_17 = {}

				for iter_91_17 = 2, #var_91_7 do
					var_91_17[tonumber(var_91_7[iter_91_17])] = true
				end

				for iter_91_18, iter_91_19 in ipairs(arg_91_1.actEffect) do
					if var_91_2[iter_91_19.targetId] and var_91_17[iter_91_19.configEffect] then
						return iter_91_3.timeline
					end
				end
			elseif var_91_8 == "7" then
				local var_91_18 = {}

				for iter_91_20 = 2, #var_91_7 do
					var_91_18[tonumber(var_91_7[iter_91_20])] = true
				end

				local var_91_19 = var_0_0.getBuffListForReplaceTimeline(iter_91_3, var_91_2, arg_91_1)

				for iter_91_21, iter_91_22 in ipairs(var_91_19) do
					if var_91_18[iter_91_22.buffId] then
						return arg_91_0
					end
				end

				return iter_91_3.timeline
			elseif var_91_8 == "8" then
				local var_91_20 = tonumber(var_91_7[2])
				local var_91_21 = tonumber(var_91_7[3])
				local var_91_22 = var_0_0.getEntitysCloneBuff(var_91_2)

				if iter_91_3.simulate == 1 then
					local var_91_23 = var_0_0.getBuffListForReplaceTimeline(nil, var_91_2, arg_91_1)

					for iter_91_23, iter_91_24 in ipairs(var_91_23) do
						if iter_91_24.buffId == var_91_20 and var_91_21 <= iter_91_24.count then
							return iter_91_3.timeline
						end
					end

					if var_0_0.simulateFightStepData(arg_91_1, var_91_22, var_0_0.detectBuffCountEnough, {
						buffId = var_91_20,
						count = var_91_21
					}) == true then
						return iter_91_3.timeline
					end
				else
					local var_91_24 = var_0_0.getBuffListForReplaceTimeline(iter_91_3, var_91_2, arg_91_1)

					for iter_91_25, iter_91_26 in ipairs(var_91_24) do
						if iter_91_26.buffId == var_91_20 and var_91_21 <= iter_91_26.count then
							return iter_91_3.timeline
						end
					end
				end
			elseif var_91_8 == "9" then
				local var_91_25 = {}

				for iter_91_27, iter_91_28 in ipairs(var_91_1) do
					local var_91_26 = tonumber(string.split(iter_91_28.condition, "#")[2])

					for iter_91_29, iter_91_30 in pairs(var_91_2) do
						local var_91_27 = iter_91_30.skin

						if iter_91_3.target == 1 then
							var_91_27 = var_0_0.processSkinByStepData(arg_91_1, iter_91_30)
						end

						if var_91_27 == var_91_26 then
							table.insert(var_91_25, iter_91_28)
						end
					end
				end

				local var_91_28 = #var_91_25

				if var_91_28 > 1 then
					local var_91_29 = var_0_7[arg_91_0]

					while true do
						local var_91_30 = math.random(1, var_91_28)

						if var_91_30 ~= var_91_29 then
							var_0_7[arg_91_0] = var_91_30

							return var_91_25[var_91_30].timeline
						end
					end
				elseif var_91_28 > 0 then
					return var_91_25[1].timeline
				end
			elseif var_91_8 == "10" then
				local var_91_31 = tonumber(var_91_7[2])

				if var_91_31 == 1 then
					if arg_91_1.fromId == arg_91_1.toId then
						return iter_91_3.timeline
					end
				elseif var_91_31 == 2 and arg_91_1.fromId ~= arg_91_1.toId then
					return iter_91_3.timeline
				end
			elseif var_91_8 == "11" then
				local var_91_32 = {}
				local var_91_33 = tonumber(var_91_7[2])

				for iter_91_31 = 3, #var_91_7 do
					var_91_32[tonumber(var_91_7[iter_91_31])] = true
				end

				for iter_91_32, iter_91_33 in pairs(var_91_2) do
					local var_91_34 = iter_91_33.skin

					if iter_91_3.target == 1 then
						var_91_34 = var_0_0.processSkinByStepData(arg_91_1, iter_91_33)
					end

					if var_91_33 == var_91_34 then
						local var_91_35 = var_0_0.getBuffListForReplaceTimeline(iter_91_3, var_91_2, arg_91_1)

						for iter_91_34, iter_91_35 in ipairs(var_91_35) do
							if var_91_32[iter_91_35.buffId] then
								return iter_91_3.timeline
							end
						end
					end
				end
			elseif var_91_8 == "12" then
				local var_91_36 = {}

				for iter_91_36 = 2, #var_91_7 - 1 do
					var_91_36[tonumber(var_91_7[iter_91_36])] = true
				end

				for iter_91_37, iter_91_38 in pairs(var_91_2) do
					local var_91_37 = iter_91_38.skin

					if iter_91_3.target == 1 then
						var_91_37 = var_0_0.processSkinByStepData(arg_91_1, iter_91_38)
					end

					if iter_91_38 and var_91_36[var_91_37] then
						local var_91_38 = var_91_7[#var_91_7]

						if var_91_38 == "1" then
							if arg_91_1.fromId == arg_91_1.toId then
								return iter_91_3.timeline
							end
						elseif var_91_38 == "2" then
							local var_91_39 = FightDataHelper.entityMgr:getById(arg_91_1.fromId)
							local var_91_40 = FightDataHelper.entityMgr:getById(arg_91_1.toId)

							if var_91_39 and var_91_40 and var_91_39.id ~= var_91_40.id and var_91_39.side == var_91_40.side then
								return iter_91_3.timeline
							end
						elseif var_91_38 == "3" then
							local var_91_41 = FightDataHelper.entityMgr:getById(arg_91_1.fromId)
							local var_91_42 = FightDataHelper.entityMgr:getById(arg_91_1.toId)

							if var_91_41 and var_91_42 and var_91_41.side ~= var_91_42.side then
								return iter_91_3.timeline
							end
						end
					end
				end
			end
		end
	end

	return arg_91_0
end

function var_0_0.detectBuffCountEnough(arg_92_0, arg_92_1)
	local var_92_0 = arg_92_1.buffId
	local var_92_1 = arg_92_1.count

	for iter_92_0, iter_92_1 in ipairs(arg_92_0) do
		if var_92_0 == iter_92_1.buffId and var_92_1 <= iter_92_1.count then
			return true
		end
	end
end

function var_0_0.simulateFightStepData(arg_93_0, arg_93_1, arg_93_2, arg_93_3)
	for iter_93_0, iter_93_1 in ipairs(arg_93_0.actEffect) do
		local var_93_0 = iter_93_1.targetId
		local var_93_1 = var_0_0.getEntity(var_93_0)
		local var_93_2 = var_93_1 and var_93_1:getMO()
		local var_93_3 = arg_93_1 and arg_93_1[var_93_0]

		if var_93_2 and var_93_3 then
			if iter_93_1.effectType == FightEnum.EffectType.BUFFADD then
				if not var_93_2:getBuffMO(iter_93_1.buff.uid) then
					local var_93_4 = FightBuffMO.New()

					var_93_4:init(iter_93_1.buff, iter_93_1.targetId)
					table.insert(var_93_3, var_93_4)
				end

				if arg_93_2 and arg_93_2(var_93_3, arg_93_3) then
					return true
				end
			elseif iter_93_1.effectType == FightEnum.EffectType.BUFFDEL or iter_93_1.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
				for iter_93_2, iter_93_3 in ipairs(var_93_3) do
					if iter_93_3.uid == iter_93_1.buff.uid then
						table.remove(var_93_3, iter_93_2)

						break
					end
				end

				if arg_93_2 and arg_93_2(var_93_3, arg_93_3) then
					return true
				end
			elseif iter_93_1.effectType == FightEnum.EffectType.BUFFUPDATE then
				for iter_93_4, iter_93_5 in ipairs(var_93_3) do
					if iter_93_5.uid == iter_93_1.buff.uid then
						iter_93_5:init(iter_93_1.buff, var_93_0)
					end
				end

				if arg_93_2 and arg_93_2(var_93_3, arg_93_3) then
					return true
				end
			end
		end
	end

	return arg_93_1
end

function var_0_0.getEntitysCloneBuff(arg_94_0)
	local var_94_0 = {}

	for iter_94_0, iter_94_1 in pairs(arg_94_0) do
		local var_94_1 = {}
		local var_94_2 = iter_94_1:getBuffList()

		for iter_94_2, iter_94_3 in ipairs(var_94_2) do
			local var_94_3 = iter_94_3:clone()

			table.insert(var_94_1, var_94_3)
		end

		var_94_0[iter_94_1.id] = var_94_1
	end

	return var_94_0
end

function var_0_0.sortReplaceTimelineConfig(arg_95_0, arg_95_1)
	return arg_95_0.priority < arg_95_1.priority
end

function var_0_0.getMagicSide(arg_96_0)
	local var_96_0 = FightDataHelper.entityMgr:getById(arg_96_0)

	if var_96_0 then
		return var_96_0.side
	elseif arg_96_0 == FightEntityScene.MySideId then
		return FightEnum.EntitySide.MySide
	elseif arg_96_0 == FightEntityScene.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	end

	return FightEnum.EntitySide.MySide
end

function var_0_0.isBossRushChannelSkill(arg_97_0)
	local var_97_0 = lua_skill.configDict[arg_97_0]

	if var_97_0 then
		local var_97_1 = var_97_0.skillEffect
		local var_97_2 = lua_skill_effect.configDict[var_97_1]

		if var_97_2 then
			for iter_97_0 = 1, FightEnum.MaxBehavior do
				local var_97_3 = var_97_2["behavior" .. iter_97_0]

				if not string.nilorempty(var_97_3) then
					local var_97_4 = FightStrUtil.instance:getSplitCache(var_97_3, "#")

					if var_97_4[1] == "1" then
						local var_97_5 = tonumber(var_97_4[2])
						local var_97_6 = lua_skill_buff.configDict[var_97_5]

						if var_97_6 then
							local var_97_7 = FightStrUtil.instance:getSplitCache(var_97_6.features, "#")

							if var_97_7[1] == "742" then
								return true, tonumber(var_97_7[2]), tonumber(var_97_7[5])
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0.processEntitySkin(arg_98_0, arg_98_1)
	local var_98_0 = HeroModel.instance:getById(arg_98_1)

	if var_98_0 and var_98_0.skin > 0 then
		return var_98_0.skin
	end

	return arg_98_0
end

function var_0_0.isPlayerCardSkill(arg_99_0)
	if not arg_99_0.cardIndex then
		return
	end

	if arg_99_0.cardIndex == 0 then
		return
	end

	local var_99_0 = arg_99_0.fromId

	if var_99_0 == FightEntityScene.MySideId then
		return true
	end

	local var_99_1 = FightDataHelper.entityMgr:getById(var_99_0)

	if not var_99_1 then
		return
	end

	return var_99_1.teamType == FightEnum.TeamType.MySide
end

function var_0_0.isEnemyCardSkill(arg_100_0)
	if not arg_100_0.cardIndex then
		return
	end

	if arg_100_0.cardIndex == 0 then
		return
	end

	local var_100_0 = arg_100_0.fromId

	if var_100_0 == FightEntityScene.EnemySideId then
		return true
	end

	local var_100_1 = FightDataHelper.entityMgr:getById(var_100_0)

	if not var_100_1 then
		return
	end

	return var_100_1.teamType == FightEnum.TeamType.EnemySide
end

function var_0_0.buildMonsterA2B(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = lua_fight_boss_evolution_client.configDict[arg_101_1.skin]

	arg_101_2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.BeforeMonsterA2B, arg_101_1.modelId))

	if var_101_0 then
		arg_101_2:addWork(Work2FightWork.New(FightWorkPlayTimeline, arg_101_0, var_101_0.timeline))

		if var_101_0.nextSkinId ~= 0 then
			arg_101_2:registWork(FightWorkFunction, var_0_0.setBossEvolution, var_0_0, arg_101_0, var_101_0)
		else
			arg_101_2:registWork(FightWorkFunction, var_0_0.removeEntity, arg_101_0.id)
		end
	end

	if arg_101_3 then
		arg_101_2:addWork(arg_101_3)
	end

	arg_101_2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.AfterMonsterA2B, arg_101_1.modelId))
end

function var_0_0.removeEntity(arg_102_0)
	local var_102_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_102_1 = var_0_0.getEntity(arg_102_0)

	if var_102_1 then
		var_102_0:removeUnit(var_102_1:getTag(), var_102_1.id)
	end
end

function var_0_0.setBossEvolution(arg_103_0, arg_103_1, arg_103_2)
	FightController.instance:dispatchEvent(FightEvent.SetBossEvolution, arg_103_1, arg_103_2.nextSkinId)
	FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, arg_103_1, arg_103_2.nextSkinId)

	local var_103_0 = GameSceneMgr.instance:getCurScene().entityMgr

	if var_0_0.getEntity(arg_103_1.id) == arg_103_1 then
		var_103_0:removeUnitData(arg_103_1:getTag(), arg_103_1.id)
	end
end

function var_0_0.buildDeadPerformanceWork(arg_104_0, arg_104_1)
	local var_104_0 = FlowSequence.New()

	for iter_104_0 = 1, FightEnum.DeadPerformanceMaxNum do
		local var_104_1 = arg_104_0["actType" .. iter_104_0]
		local var_104_2 = arg_104_0["actParam" .. iter_104_0]

		if var_104_1 == 0 then
			break
		end

		if var_104_1 == 1 then
			var_104_0:addWork(FightWorkPlayTimeline.New(arg_104_1, var_104_2))
		elseif var_104_1 == 2 then
			var_104_0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.DeadPerformanceNoCondition, tonumber(var_104_2)))
		end
	end

	return var_104_0
end

function var_0_0.compareData(arg_105_0, arg_105_1, arg_105_2)
	local var_105_0 = type(arg_105_0)

	if var_105_0 == "function" then
		return true
	elseif var_105_0 == "table" then
		for iter_105_0, iter_105_1 in pairs(arg_105_0) do
			local var_105_1 = false

			if type(iter_105_0) == "table" then
				var_105_1 = true
			end

			if arg_105_2 and arg_105_2[iter_105_0] then
				var_105_1 = true
			end

			if not arg_105_1 then
				return false
			end

			if type(arg_105_1) ~= "table" then
				return false
			end

			if not var_105_1 and not var_0_0.compareData(iter_105_1, arg_105_1[iter_105_0], arg_105_2) then
				return false, iter_105_0, iter_105_1, arg_105_1[iter_105_0]
			end
		end

		return true
	else
		return arg_105_0 == arg_105_1
	end
end

local var_0_8 = 0

function var_0_0.logStr(arg_106_0, arg_106_1)
	local var_106_0 = ""

	var_0_8 = 0

	if type(arg_106_0) == "table" then
		var_106_0 = var_106_0 .. var_0_0.logTable(arg_106_0, arg_106_1)
	else
		var_106_0 = var_106_0 .. tostring(arg_106_0)
	end

	return var_106_0
end

function var_0_0.logTable(arg_107_0, arg_107_1)
	local var_107_0 = "" .. "{\n"

	var_0_8 = var_0_8 + 1

	local var_107_1 = tabletool.len(arg_107_0)
	local var_107_2 = 0

	for iter_107_0, iter_107_1 in pairs(arg_107_0) do
		local var_107_3 = false

		if arg_107_1 and arg_107_1[iter_107_0] then
			var_107_3 = true
		end

		if not var_107_3 then
			for iter_107_2 = 1, var_0_8 do
				var_107_0 = var_107_0 .. "\t"
			end

			var_107_0 = var_107_0 .. iter_107_0 .. " = "

			if type(iter_107_1) == "table" then
				var_107_0 = var_107_0 .. var_0_0.logTable(iter_107_1, arg_107_1)
			else
				var_107_0 = var_107_0 .. tostring(iter_107_1)
			end

			var_107_2 = var_107_2 + 1

			if var_107_2 < var_107_1 then
				var_107_0 = var_107_0 .. ","
			end

			var_107_0 = var_107_0 .. "\n"
		end
	end

	var_0_8 = var_0_8 - 1

	for iter_107_3 = 1, var_0_8 do
		var_107_0 = var_107_0 .. "\t"
	end

	return var_107_0 .. "}"
end

function var_0_0.deepCopySimpleWithMeta(arg_108_0, arg_108_1)
	if type(arg_108_0) ~= "table" then
		return arg_108_0
	else
		local var_108_0 = {}

		for iter_108_0, iter_108_1 in pairs(arg_108_0) do
			local var_108_1 = false

			if arg_108_1 and arg_108_1[iter_108_0] then
				var_108_1 = true
			end

			if not var_108_1 then
				var_108_0[iter_108_0] = var_0_0.deepCopySimpleWithMeta(iter_108_1, arg_108_1)
			end
		end

		local var_108_2 = getmetatable(arg_108_0)

		if var_108_2 then
			setmetatable(var_108_0, var_108_2)
		end

		return var_108_0
	end
end

function var_0_0.getPassiveSkill(arg_109_0, arg_109_1)
	local var_109_0 = FightDataHelper.entityMgr:getById(arg_109_0)

	if not var_109_0 then
		return arg_109_1
	end

	local var_109_1 = var_109_0.upgradedOptions

	for iter_109_0, iter_109_1 in pairs(var_109_1) do
		local var_109_2 = lua_hero_upgrade_options.configDict[iter_109_1]

		if var_109_2 and not string.nilorempty(var_109_2.replacePassiveSkill) then
			local var_109_3 = GameUtil.splitString2(var_109_2.replacePassiveSkill, true)

			for iter_109_2, iter_109_3 in ipairs(var_109_3) do
				if arg_109_1 == iter_109_3[1] and var_109_0:isPassiveSkill(iter_109_3[2]) then
					return iter_109_3[2]
				end
			end
		end
	end

	return arg_109_1
end

function var_0_0.isSupportCard(arg_110_0)
	if arg_110_0.cardType == FightEnum.CardType.SUPPORT_NORMAL or arg_110_0.cardType == FightEnum.CardType.SUPPORT_EX then
		return true
	end
end

function var_0_0.curIsRougeFight()
	local var_111_0 = FightModel.instance:getFightParam()

	if not var_111_0 then
		return false
	end

	local var_111_1 = var_111_0.chapterId
	local var_111_2 = DungeonConfig.instance:getChapterCO(var_111_1)

	return var_111_2 and var_111_2.type == DungeonEnum.ChapterType.Rouge
end

function var_0_0.processSkinByStepData(arg_112_0, arg_112_1)
	arg_112_1 = arg_112_1 or FightDataHelper.entityMgr:getById(arg_112_0.fromId)

	local var_112_0 = arg_112_0.supportHeroId

	if var_112_0 ~= 0 and arg_112_1 and arg_112_1.modelId ~= var_112_0 then
		if var_0_0.curIsRougeFight() then
			local var_112_1 = RougeModel.instance:getTeamInfo()
			local var_112_2 = var_112_1 and var_112_1:getAssistHeroMo(var_112_0)

			if var_112_2 then
				return var_112_2.skin
			end
		end

		local var_112_3 = HeroModel.instance:getByHeroId(var_112_0)

		if var_112_3 and var_112_3.skin > 0 then
			return var_112_3.skin
		else
			local var_112_4 = lua_character.configDict[var_112_0]

			if var_112_4 then
				return var_112_4.skinId
			end
		end
	end

	return arg_112_1 and arg_112_1.skin or 0
end

function var_0_0.processSkinId(arg_113_0, arg_113_1)
	if (arg_113_1.cardType == FightEnum.CardType.SUPPORT_NORMAL or arg_113_1.cardType == FightEnum.CardType.SUPPORT_EX) and arg_113_1.heroId ~= arg_113_0.modelId then
		local var_113_0 = HeroModel.instance:getByHeroId(arg_113_1.heroId)

		if var_113_0 and var_113_0.skin > 0 then
			return var_113_0.skin
		else
			local var_113_1 = lua_character.configDict[arg_113_1.heroId]

			if var_113_1 then
				return var_113_1.skinId
			end
		end
	end

	return arg_113_0.skin
end

function var_0_0.processNextSkillId(arg_114_0)
	local var_114_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_114_0 and var_114_0.type == DungeonEnum.EpisodeType.Rouge then
		local var_114_1 = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.SupportHeroSkill)

		if var_114_1 then
			local var_114_2 = cjson.decode(var_114_1)

			for iter_114_0, iter_114_1 in pairs(var_114_2) do
				if iter_114_1.skill1 then
					for iter_114_2, iter_114_3 in ipairs(iter_114_1.skill1) do
						local var_114_3 = iter_114_1.skill1[iter_114_2 + 1]

						if iter_114_3 == arg_114_0 and var_114_3 then
							return var_114_3
						end
					end
				end

				if iter_114_1.skill2 then
					for iter_114_4, iter_114_5 in ipairs(iter_114_1.skill2) do
						local var_114_4 = iter_114_1.skill2[iter_114_4 + 1]

						if iter_114_5 == arg_114_0 and var_114_4 then
							return var_114_4
						end
					end
				end
			end
		end
	end
end

function var_0_0.isTimelineStep(arg_115_0)
	if arg_115_0 and arg_115_0.actType == FightEnum.ActType.SKILL then
		local var_115_0 = FightDataHelper.entityMgr:getById(arg_115_0.fromId)
		local var_115_1 = var_115_0 and var_115_0.skin
		local var_115_2 = FightConfig.instance:getSkinSkillTimeline(var_115_1, arg_115_0.actId)

		if not string.nilorempty(var_115_2) then
			return true
		end
	end
end

function var_0_0.getClickEntity(arg_116_0, arg_116_1, arg_116_2)
	table.sort(arg_116_0, var_0_0.sortEntityList)

	for iter_116_0, iter_116_1 in ipairs(arg_116_0) do
		local var_116_0 = iter_116_1:getMO()

		if var_116_0 then
			local var_116_1
			local var_116_2
			local var_116_3
			local var_116_4
			local var_116_5
			local var_116_6
			local var_116_7
			local var_116_8
			local var_116_9 = var_0_0.getEntity(var_116_0.id)

			if isTypeOf(var_116_9, FightEntityAssembledMonsterMain) or isTypeOf(var_116_9, FightEntityAssembledMonsterSub) then
				local var_116_10 = lua_fight_assembled_monster.configDict[var_116_0.skin]
				local var_116_11, var_116_12, var_116_13 = transformhelper.getPos(iter_116_1.go.transform)
				local var_116_14 = var_116_11 + var_116_10.virtualSpinePos[1]
				local var_116_15 = var_116_12 + var_116_10.virtualSpinePos[2]
				local var_116_16 = var_116_13 + var_116_10.virtualSpinePos[3]

				var_116_7, var_116_8 = recthelper.worldPosToAnchorPosXYZ(var_116_14, var_116_15, var_116_16, arg_116_1)

				local var_116_17 = var_116_10.virtualSpineSize[1] * 0.5
				local var_116_18 = var_116_10.virtualSpineSize[2] * 0.5
				local var_116_19 = var_116_14 - var_116_17
				local var_116_20 = var_116_15 - var_116_18
				local var_116_21 = var_116_16
				local var_116_22 = var_116_14 + var_116_17
				local var_116_23 = var_116_15 + var_116_18
				local var_116_24 = var_116_16
				local var_116_25, var_116_26, var_116_27 = recthelper.worldPosToAnchorPosXYZ(var_116_19, var_116_20, var_116_21, arg_116_1)
				local var_116_28, var_116_29, var_116_30 = recthelper.worldPosToAnchorPosXYZ(var_116_22, var_116_23, var_116_24, arg_116_1)
				local var_116_31 = (var_116_28 - var_116_25) / 2

				var_116_2 = var_116_7 - var_116_31
				var_116_3 = var_116_7 + var_116_31

				local var_116_32 = (var_116_29 - var_116_26) / 2

				var_116_5 = var_116_8 - var_116_32
				var_116_6 = var_116_8 + var_116_32
			else
				local var_116_33, var_116_34, var_116_35, var_116_36 = var_0_0.calcRect(iter_116_1, arg_116_1)
				local var_116_37 = iter_116_1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

				if var_116_37 then
					local var_116_38, var_116_39, var_116_40 = transformhelper.getPos(var_116_37.transform)

					var_116_7, var_116_8 = recthelper.worldPosToAnchorPosXYZ(var_116_38, var_116_39, var_116_40, arg_116_1)
				else
					var_116_7 = (var_116_33 + var_116_35) / 2
					var_116_8 = (var_116_34 + var_116_36) / 2
				end

				local var_116_41 = math.abs(var_116_33 - var_116_35)
				local var_116_42 = math.abs(var_116_34 - var_116_36)
				local var_116_43 = lua_monster_skin.configDict[var_116_0.skin]
				local var_116_44 = var_116_43 and var_116_43.clickBoxUnlimit == 1
				local var_116_45 = var_116_44 and 800 or 200
				local var_116_46 = var_116_44 and 800 or 500
				local var_116_47 = Mathf.Clamp(var_116_41, 150, var_116_45)
				local var_116_48 = Mathf.Clamp(var_116_42, 150, var_116_46)
				local var_116_49 = var_116_47 / 2

				var_116_2 = var_116_7 - var_116_49
				var_116_3 = var_116_7 + var_116_49

				local var_116_50 = var_116_48 / 2

				var_116_5 = var_116_8 - var_116_50
				var_116_6 = var_116_8 + var_116_50
			end

			local var_116_51, var_116_52 = recthelper.screenPosToAnchorPos2(arg_116_2, arg_116_1)

			if var_116_2 <= var_116_51 and var_116_51 <= var_116_3 and var_116_5 <= var_116_52 and var_116_52 <= var_116_6 then
				return iter_116_1.id, var_116_7, var_116_8
			end
		end
	end
end

function var_0_0.calcRect(arg_117_0, arg_117_1)
	if not arg_117_0 then
		return 10000, 10000, 10000, 10000
	end

	local var_117_0 = arg_117_0:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic)

	if not var_117_0 then
		return 10000, 10000, 10000, 10000
	end

	local var_117_1, var_117_2, var_117_3 = transformhelper.getPos(var_117_0.transform)
	local var_117_4, var_117_5 = var_0_0.getEntityBoxSizeOffsetV2(arg_117_0)
	local var_117_6 = arg_117_0:isMySide() and 1 or -1
	local var_117_7, var_117_8 = recthelper.worldPosToAnchorPosXYZ(var_117_1 - var_117_4.x * 0.5, var_117_2 - var_117_4.y * 0.5 * var_117_6, var_117_3, arg_117_1)
	local var_117_9, var_117_10 = recthelper.worldPosToAnchorPosXYZ(var_117_1 + var_117_4.x * 0.5, var_117_2 + var_117_4.y * 0.5 * var_117_6, var_117_3, arg_117_1)

	return var_117_7, var_117_8, var_117_9, var_117_10
end

function var_0_0.sortEntityList(arg_118_0, arg_118_1)
	local var_118_0 = arg_118_0:getMO()
	local var_118_1 = arg_118_1:getMO()
	local var_118_2 = isTypeOf(arg_118_0, FightEntityAssembledMonsterMain) or isTypeOf(arg_118_0, FightEntityAssembledMonsterSub)
	local var_118_3 = isTypeOf(arg_118_1, FightEntityAssembledMonsterMain) or isTypeOf(arg_118_1, FightEntityAssembledMonsterSub)

	if var_118_2 and var_118_3 then
		local var_118_4 = lua_fight_assembled_monster.configDict[var_118_0.skin]
		local var_118_5 = lua_fight_assembled_monster.configDict[var_118_1.skin]

		return var_118_4.clickIndex > var_118_5.clickIndex
	elseif var_118_2 and not var_118_3 then
		return true
	elseif not var_118_2 and var_118_3 then
		return false
	else
		local var_118_6, var_118_7, var_118_8 = var_0_0.getEntityStandPos(var_118_0)
		local var_118_9, var_118_10, var_118_11 = var_0_0.getEntityStandPos(var_118_1)

		if var_118_8 ~= var_118_11 then
			return var_118_8 < var_118_11
		else
			return tonumber(var_118_0.id) > tonumber(var_118_1.id)
		end
	end
end

function var_0_0.sortNextRoundGetCardConfig(arg_119_0, arg_119_1)
	return arg_119_0.priority > arg_119_1.priority
end

function var_0_0.sortNextRoundGetCard(arg_120_0, arg_120_1)
	return arg_120_0.index < arg_120_1.index
end

function var_0_0.getNextRoundGetCardList()
	local var_121_0 = {}
	local var_121_1 = {}
	local var_121_2 = FightDataHelper.operationDataMgr:getOpList()

	for iter_121_0, iter_121_1 in ipairs(var_121_2) do
		if iter_121_1:isPlayCard() then
			local var_121_3 = iter_121_1.skillId
			local var_121_4 = lua_fight_next_round_get_card.configDict[var_121_3]

			if var_121_4 then
				local var_121_5 = {}

				for iter_121_2, iter_121_3 in pairs(var_121_4) do
					table.insert(var_121_5, iter_121_3)
				end

				table.sort(var_121_5, var_0_0.sortNextRoundGetCardConfig)

				for iter_121_4, iter_121_5 in ipairs(var_121_5) do
					local var_121_6 = iter_121_5.condition

					if var_0_0.checkNextRoundCardCondition(iter_121_1, var_121_6) then
						if iter_121_5.exclusion ~= 0 then
							var_121_0[iter_121_5.exclusion] = var_121_0[iter_121_5.exclusion] or {}
							var_121_0[iter_121_5.exclusion].index = iter_121_0
							var_121_0[iter_121_5.exclusion].skillId = iter_121_5.skillId
							var_121_0[iter_121_5.exclusion].entityId = iter_121_1.belongToEntityId
							var_121_0[iter_121_5.exclusion].tempCard = iter_121_5.tempCard

							break
						end

						local var_121_7 = {
							index = iter_121_0,
							skillId = iter_121_5.skillId,
							entityId = iter_121_1.belongToEntityId,
							tempCard = iter_121_5.tempCard
						}

						table.insert(var_121_1, var_121_7)

						break
					end
				end
			end
		end
	end

	for iter_121_6, iter_121_7 in pairs(var_121_0) do
		table.insert(var_121_1, iter_121_7)
	end

	table.sort(var_121_1, var_0_0.sortNextRoundGetCard)

	local var_121_8 = {}

	for iter_121_8, iter_121_9 in ipairs(var_121_1) do
		local var_121_9 = string.splitToNumber(iter_121_9.skillId, "#")

		for iter_121_10, iter_121_11 in ipairs(var_121_9) do
			local var_121_10 = {
				uid = iter_121_9.entityId,
				skillId = iter_121_11,
				tempCard = iter_121_9.tempCard
			}
			local var_121_11 = FightCardInfoData.New(var_121_10)

			table.insert(var_121_8, var_121_11)
		end
	end

	return var_121_8
end

function var_0_0.checkNextRoundCardCondition(arg_122_0, arg_122_1)
	if string.nilorempty(arg_122_1) then
		return true
	end

	local var_122_0 = string.split(arg_122_1, "&")

	if #var_122_0 > 1 then
		local var_122_1 = 0

		for iter_122_0, iter_122_1 in ipairs(var_122_0) do
			if var_0_0.checkNextRoundCardSingleCondition(arg_122_0, iter_122_1) then
				var_122_1 = var_122_1 + 1
			end
		end

		return var_122_1 == #var_122_0
	else
		return var_0_0.checkNextRoundCardSingleCondition(arg_122_0, var_122_0[1])
	end
end

function var_0_0.checkNextRoundCardSingleCondition(arg_123_0, arg_123_1)
	local var_123_0 = arg_123_0.belongToEntityId
	local var_123_1 = var_0_0.getEntity(var_123_0)
	local var_123_2 = var_123_1 and var_123_1:getMO()
	local var_123_3 = string.split(arg_123_1, "#")

	if var_123_3[1] == "1" then
		if var_123_3[2] and var_123_2 then
			local var_123_4, var_123_5 = HeroConfig.instance:getShowLevel(var_123_2.level)

			if var_123_5 - 1 >= tonumber(var_123_3[2]) then
				return true
			end
		end
	elseif var_123_3[1] == "2" and var_123_3[2] and var_123_2 then
		return var_123_2.exSkillLevel == tonumber(var_123_3[2])
	end
end

function var_0_0.checkShieldHit(arg_124_0)
	if arg_124_0.effectNum1 == FightEnum.EffectType.SHAREHURT then
		return false
	end

	return true
end

var_0_0.SkillEditorHp = 2000

function var_0_0.buildMySideFightEntityMOList(arg_125_0)
	local var_125_0 = FightEnum.EntitySide.MySide
	local var_125_1 = {}
	local var_125_2 = {}

	for iter_125_0 = 1, SkillEditorMgr.instance.stance_count_limit do
		local var_125_3 = HeroModel.instance:getById(arg_125_0.mySideUids[iter_125_0])

		if var_125_3 then
			var_125_1[iter_125_0] = var_125_3.heroId
			var_125_2[iter_125_0] = var_125_3.skin
		end
	end

	local var_125_4 = {}
	local var_125_5 = {}

	for iter_125_1, iter_125_2 in ipairs(arg_125_0.mySideSubUids) do
		local var_125_6 = HeroModel.instance:getById(iter_125_2)

		if var_125_6 then
			table.insert(var_125_4, var_125_6.heroId)
			table.insert(var_125_5, var_125_6.skin)
		end
	end

	return var_0_0.buildHeroEntityMOList(var_125_0, var_125_1, var_125_2, var_125_4, var_125_5)
end

function var_0_0.getEmptyFightEntityMO(arg_126_0, arg_126_1, arg_126_2, arg_126_3)
	if not arg_126_1 or arg_126_1 == 0 then
		return
	end

	local var_126_0 = lua_character.configDict[arg_126_1]
	local var_126_1 = FightEntityMO.New()

	var_126_1.id = tostring(arg_126_0)
	var_126_1.uid = var_126_1.id
	var_126_1.modelId = arg_126_1 or 0
	var_126_1.entityType = 1
	var_126_1.exPoint = 0
	var_126_1.side = FightEnum.EntitySide.MySide
	var_126_1.currentHp = 0
	var_126_1.attrMO = var_0_0._buildAttr(var_126_0)
	var_126_1.skillIds = var_0_0._buildHeroSkills(var_126_0)
	var_126_1.shieldValue = 0
	var_126_1.level = arg_126_2 or 1
	var_126_1.skin = arg_126_3 or var_126_0.skinId
	var_126_1.originSkin = arg_126_3 or var_126_0.skinId

	if not string.nilorempty(var_126_0.powerMax) then
		local var_126_2 = FightStrUtil.instance:getSplitToNumberCache(var_126_0.powerMax, "#")
		local var_126_3 = {
			{
				num = 0,
				powerId = var_126_2[1],
				max = var_126_2[2]
			}
		}

		var_126_1:setPowerInfos(var_126_3)
	end

	return var_126_1
end

function var_0_0.buildHeroEntityMOList(arg_127_0, arg_127_1, arg_127_2, arg_127_3, arg_127_4)
	local function var_127_0(arg_128_0, arg_128_1, arg_128_2)
		local var_128_0 = FightEntityMO.New()

		var_128_0.id = tostring(var_0_1)
		var_128_0.uid = var_128_0.id
		var_128_0.modelId = arg_128_0 or 0
		var_128_0.entityType = 1
		var_128_0.exPoint = 0
		var_128_0.side = arg_127_0
		var_128_0.currentHp = var_0_0.SkillEditorHp
		var_128_0.attrMO = var_0_0._buildAttr(arg_128_1)

		local var_128_1 = arg_128_1.uniqueSkill_point

		var_128_0.exPointType = string.splitToNumber(var_128_1, "#")[1] or 0

		if arg_128_2 == 312002 then
			var_128_0.skillIds = var_0_0._buildHeroSkills(arg_128_1, 2)
		else
			var_128_0.skillIds = var_0_0._buildHeroSkills(arg_128_1)
		end

		var_128_0.shieldValue = 0
		var_128_0.level = 1
		var_128_0.storedExPoint = 0

		if not string.nilorempty(arg_128_1.powerMax) then
			local var_128_2 = FightStrUtil.instance:getSplitToNumberCache(arg_128_1.powerMax, "#")
			local var_128_3 = {
				{
					num = 0,
					powerId = var_128_2[1],
					max = var_128_2[2]
				}
			}

			var_128_0:setPowerInfos(var_128_3)
		end

		var_0_1 = var_0_1 + 1

		return var_128_0
	end

	local var_127_1 = {}
	local var_127_2 = {}
	local var_127_3 = arg_127_1 and #arg_127_1 or SkillEditorMgr.instance.stance_count_limit

	for iter_127_0 = 1, var_127_3 do
		local var_127_4 = arg_127_1[iter_127_0]

		if var_127_4 and var_127_4 ~= 0 then
			local var_127_5 = lua_character.configDict[var_127_4]

			if var_127_5 then
				local var_127_6 = arg_127_2 and arg_127_2[iter_127_0] or var_127_5.skinId
				local var_127_7 = var_127_0(var_127_4, var_127_5, var_127_6)

				var_127_7.position = iter_127_0
				var_127_7.skin = var_127_6
				var_127_7.originSkin = var_127_6

				table.insert(var_127_1, var_127_7)
			else
				local var_127_8 = arg_127_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的角色配置已被删除，角色id=%d", var_127_8, iter_127_0, var_127_4))
			end
		end
	end

	if arg_127_3 then
		for iter_127_1, iter_127_2 in ipairs(arg_127_3) do
			local var_127_9 = lua_character.configDict[iter_127_2]

			if var_127_9 then
				local var_127_10 = var_127_0(iter_127_2, var_127_9)

				var_127_10.position = -1
				var_127_10.skin = arg_127_4 and arg_127_4[iter_127_1] or var_127_9.skinId
				var_127_10.originSkin = arg_127_4 and arg_127_4[iter_127_1] or var_127_9.skinId

				table.insert(var_127_2, var_127_10)
			else
				local var_127_11 = arg_127_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(var_127_11 .. "替补角色的配置已被删除，角色id=" .. iter_127_2)
			end
		end
	end

	return var_127_1, var_127_2
end

function var_0_0.buildEnemySideFightEntityMOList(arg_129_0, arg_129_1)
	local var_129_0 = FightEnum.EntitySide.EnemySide
	local var_129_1 = arg_129_0.monsterGroupIds[arg_129_1]
	local var_129_2 = lua_monster_group.configDict[var_129_1]
	local var_129_3 = FightStrUtil.instance:getSplitToNumberCache(var_129_2.monster, "#")
	local var_129_4 = var_129_2.subMonsters

	return var_0_0.buildMonsterEntityMOList(var_129_0, var_129_3, var_129_4)
end

function var_0_0.buildMonsterEntityMOList(arg_130_0, arg_130_1, arg_130_2)
	local var_130_0 = {}
	local var_130_1 = {}

	for iter_130_0 = 1, SkillEditorMgr.instance.enemy_stance_count_limit do
		local var_130_2 = arg_130_1[iter_130_0]

		if var_130_2 and var_130_2 ~= 0 then
			local var_130_3 = lua_monster.configDict[var_130_2]

			if var_130_3 then
				local var_130_4 = FightEntityMO.New()

				var_130_4.id = tostring(var_0_2)
				var_130_4.uid = var_130_4.id
				var_130_4.modelId = var_130_2
				var_130_4.position = iter_130_0
				var_130_4.entityType = 2
				var_130_4.exPoint = 0
				var_130_4.skin = var_130_3.skinId
				var_130_4.originSkin = var_130_3.skinId
				var_130_4.side = arg_130_0
				var_130_4.currentHp = var_0_0.SkillEditorHp
				var_130_4.attrMO = var_0_0._buildAttr(var_130_3)
				var_130_4.skillIds = var_0_0._buildMonsterSkills(var_130_3)
				var_130_4.shieldValue = 0
				var_130_4.level = 1
				var_130_4.storedExPoint = 0
				var_130_4.exPointType = 0
				var_0_2 = var_0_2 - 1

				table.insert(var_130_0, var_130_4)
			else
				local var_130_5 = arg_130_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的怪物配置已被删除，怪物id=%d", var_130_5, iter_130_0, var_130_2))
			end
		end
	end

	if arg_130_2 then
		for iter_130_1, iter_130_2 in ipairs(arg_130_2) do
			local var_130_6 = lua_monster.configDict[iter_130_2]

			if var_130_6 then
				local var_130_7 = FightEntityMO.New()

				var_130_7.id = tostring(var_0_2)
				var_130_7.uid = var_130_7.id
				var_130_7.modelId = iter_130_2
				var_130_7.position = 5
				var_130_7.entityType = 2
				var_130_7.exPoint = 0
				var_130_7.skin = var_130_6.skinId
				var_130_7.originSkin = var_130_6.skinId
				var_130_7.side = arg_130_0
				var_130_7.currentHp = var_0_0.SkillEditorHp
				var_130_7.attrMO = var_0_0._buildAttr(var_130_6)
				var_130_7.skillIds = var_0_0._buildMonsterSkills(var_130_6)
				var_130_7.shieldValue = 0
				var_130_7.level = 1
				var_0_2 = var_0_2 - 1

				table.insert(var_130_1, var_130_7)
			else
				local var_130_8 = arg_130_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(var_130_8 .. "替补怪物的配置已被删除，怪物id=" .. iter_130_2)
			end
		end
	end

	return var_130_0, var_130_1
end

function var_0_0.buildSkills(arg_131_0)
	local var_131_0 = lua_character.configDict[arg_131_0]

	if var_131_0 then
		return var_0_0._buildHeroSkills(var_131_0)
	end

	local var_131_1 = lua_monster.configDict[arg_131_0]

	if var_131_1 then
		return var_0_0._buildMonsterSkills(var_131_1)
	end
end

function var_0_0._buildHeroSkills(arg_132_0, arg_132_1)
	local var_132_0 = {}
	local var_132_1 = lua_character.configDict[arg_132_0.id]
	local var_132_2

	if arg_132_1 and arg_132_1 >= 2 then
		var_132_2 = lua_character_rank_replace.configDict[arg_132_0.id]
	end

	if var_132_1 then
		local var_132_3 = GameUtil.splitString2(var_132_1.skill, true)

		if var_132_2 then
			var_132_3 = GameUtil.splitString2(var_132_2.skill, true)
		end

		for iter_132_0, iter_132_1 in pairs(var_132_3) do
			for iter_132_2 = 2, #iter_132_1 do
				if iter_132_1[iter_132_2] ~= 0 then
					table.insert(var_132_0, iter_132_1[iter_132_2])
				else
					logError(arg_132_0.id .. " 角色技能id=0，检查下角色表-角色")
				end
			end
		end
	end

	if var_132_2 then
		if var_132_2.exSkill ~= 0 then
			table.insert(var_132_0, var_132_2.exSkill)
		end
	elseif var_132_1.exSkill ~= 0 then
		table.insert(var_132_0, var_132_1.exSkill)
	end

	local var_132_4 = lua_skill_ex_level.configDict[arg_132_0.id]

	if var_132_4 then
		for iter_132_3, iter_132_4 in pairs(var_132_4) do
			if iter_132_4.skillEx ~= 0 then
				table.insert(var_132_0, iter_132_4.skillEx)
			end
		end
	end

	local var_132_5 = lua_skill_passive_level.configDict[arg_132_0.id]

	if var_132_5 then
		for iter_132_5, iter_132_6 in pairs(var_132_5) do
			if iter_132_6.skillPassive ~= 0 then
				table.insert(var_132_0, iter_132_6.skillPassive)
			else
				logError(arg_132_0.id .. " 角色被动技能id=0，检查下角色养成表-被动升级")
			end
		end
	end

	return var_132_0
end

function var_0_0._buildMonsterSkills(arg_133_0)
	local var_133_0 = {}

	if not string.nilorempty(arg_133_0.activeSkill) then
		local var_133_1 = FightStrUtil.instance:getSplitString2Cache(arg_133_0.activeSkill, true, "|", "#")

		for iter_133_0, iter_133_1 in ipairs(var_133_1) do
			for iter_133_2, iter_133_3 in ipairs(iter_133_1) do
				if lua_skill.configDict[iter_133_3] then
					table.insert(var_133_0, iter_133_3)
				end
			end
		end
	end

	if arg_133_0.uniqueSkill and #arg_133_0.uniqueSkill > 0 then
		for iter_133_4, iter_133_5 in ipairs(arg_133_0.uniqueSkill) do
			table.insert(var_133_0, iter_133_5)
		end
	end

	tabletool.addValues(var_133_0, FightConfig.instance:getPassiveSkills(arg_133_0.id))

	return var_133_0
end

function var_0_0._buildAttr(arg_134_0)
	local var_134_0 = HeroAttributeMO.New()

	var_134_0.hp = var_0_0.SkillEditorHp
	var_134_0.attack = 100
	var_134_0.defense = 100
	var_134_0.crit = 100
	var_134_0.crit_damage = 100
	var_134_0.multiHpNum = 0
	var_134_0.multiHpIdx = 0

	return var_134_0
end

function var_0_0.getEpisodeRecommendLevel(arg_135_0, arg_135_1)
	local var_135_0 = DungeonConfig.instance:getEpisodeBattleId(arg_135_0)

	if not var_135_0 then
		return 0
	end

	return var_0_0.getBattleRecommendLevel(var_135_0, arg_135_1)
end

function var_0_0.getBattleRecommendLevel(arg_136_0, arg_136_1)
	local var_136_0 = arg_136_1 and "levelEasy" or "level"
	local var_136_1 = lua_battle.configDict[arg_136_0]

	if not var_136_1 then
		return 0
	end

	local var_136_2 = {}
	local var_136_3 = {}
	local var_136_4
	local var_136_5

	for iter_136_0, iter_136_1 in ipairs(FightStrUtil.instance:getSplitToNumberCache(var_136_1.monsterGroupIds, "#")) do
		local var_136_6 = lua_monster_group.configDict[iter_136_1].bossId
		local var_136_7 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_136_1].monster, "#")

		for iter_136_2, iter_136_3 in ipairs(var_136_7) do
			if var_0_0.isBossId(var_136_6, iter_136_3) then
				table.insert(var_136_3, iter_136_3)
			else
				table.insert(var_136_2, iter_136_3)
			end
		end
	end

	if #var_136_3 > 0 then
		return lua_monster.configDict[var_136_3[1]][var_136_0]
	elseif #var_136_2 > 0 then
		local var_136_8 = 0

		for iter_136_4, iter_136_5 in ipairs(var_136_2) do
			var_136_8 = var_136_8 + lua_monster.configDict[iter_136_5][var_136_0]
		end

		return math.ceil(var_136_8 / #var_136_2)
	else
		return 0
	end
end

function var_0_0.initBuildSceneAndLevelHandle()
	if var_0_0.buildSceneAndLevelHandleDict then
		return
	end

	var_0_0.buildSceneAndLevelHandleDict = {
		[DungeonEnum.EpisodeType.Cachot] = var_0_0.buildCachotSceneAndLevel,
		[DungeonEnum.EpisodeType.Rouge] = var_0_0.buildRougeSceneAndLevel,
		[DungeonEnum.EpisodeType.Survival] = var_0_0.buildSurvivalSceneAndLevel
	}
end

function var_0_0.buildDefaultSceneAndLevel(arg_138_0, arg_138_1)
	local var_138_0 = {}
	local var_138_1 = {}
	local var_138_2 = lua_battle.configDict[arg_138_1].sceneIds
	local var_138_3 = string.splitToNumber(var_138_2, "#")

	for iter_138_0, iter_138_1 in ipairs(var_138_3) do
		local var_138_4 = SceneConfig.instance:getSceneLevelCOs(iter_138_1)[1].id

		table.insert(var_138_0, iter_138_1)
		table.insert(var_138_1, var_138_4)
	end

	return var_138_0, var_138_1
end

function var_0_0.buildCachotSceneAndLevel(arg_139_0, arg_139_1)
	local var_139_0 = 0
	local var_139_1 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if var_139_1 and lua_rogue_event_fight.configDict[var_139_1:getEventCo().eventId].isChangeScene ~= 1 then
		var_139_0 = V1a6_CachotModel.instance:getRogueInfo().layer
	end

	if var_139_0 > 0 then
		local var_139_2 = V1a6_CachotEventConfig.instance:getSceneIdByLayer(var_139_0)

		if var_139_2 then
			local var_139_3 = {}
			local var_139_4 = {}

			table.insert(var_139_3, var_139_2.sceneId)
			table.insert(var_139_4, var_139_2.levelId)

			return var_139_3, var_139_4
		else
			logError("肉鸽战斗场景配置不存在" .. var_139_0)

			return var_0_0.buildDefaultSceneAndLevel(arg_139_0, arg_139_1)
		end
	else
		return var_0_0.buildDefaultSceneAndLevel(arg_139_0, arg_139_1)
	end
end

function var_0_0.buildSurvivalSceneAndLevel(...)
	local var_140_0 = SurvivalMapModel.instance:getSceneMo()

	if var_140_0 then
		local var_140_1 = lua_survival_map_group_mapping.configDict[var_140_0.mapId].id
		local var_140_2 = SurvivalConfig.instance:getCopyCo(var_140_1)
		local var_140_3 = {}
		local var_140_4 = {}

		table.insert(var_140_3, var_140_2.useScene)
		table.insert(var_140_4, var_140_2.useScene)

		return var_140_3, var_140_4
	end

	return var_0_0.buildDefaultSceneAndLevel(...)
end

function var_0_0.buildRougeSceneAndLevel(arg_141_0, arg_141_1)
	local var_141_0 = RougeMapModel.instance:getCurEvent()
	local var_141_1 = var_141_0 and var_141_0.type
	local var_141_2 = RougeMapHelper.isFightEvent(var_141_1) and lua_rouge_fight_event.configDict[var_141_0.id]

	if var_141_2 and var_141_2.isChangeScene == 1 then
		local var_141_3 = RougeMapModel.instance:getLayerCo()
		local var_141_4 = var_141_3 and var_141_3.sceneId
		local var_141_5 = var_141_3 and var_141_3.levelId

		if var_141_4 ~= 0 and var_141_5 ~= 0 then
			return {
				var_141_4
			}, {
				var_141_5
			}
		end

		logError(string.format("layerId : %s, config Incorrect, sceneId : %s, levelId : %s", var_141_3 and var_141_3.id, var_141_4, var_141_5))

		return var_0_0.buildDefaultSceneAndLevel(arg_141_0, arg_141_1)
	else
		return var_0_0.buildDefaultSceneAndLevel(arg_141_0, arg_141_1)
	end
end

function var_0_0.buildSceneAndLevel(arg_142_0, arg_142_1)
	var_0_0.initBuildSceneAndLevelHandle()

	local var_142_0 = lua_episode.configDict[arg_142_0]
	local var_142_1 = var_142_0 and var_0_0.buildSceneAndLevelHandleDict[var_142_0.type]

	var_142_1 = var_142_1 or var_0_0.buildDefaultSceneAndLevel

	return var_142_1(arg_142_0, arg_142_1)
end

function var_0_0.getStressStatus(arg_143_0, arg_143_1)
	arg_143_1 = arg_143_1 or FightEnum.StressThreshold

	if not arg_143_0 then
		logError("stress is nil")

		return FightEnum.Status.Positive
	end

	for iter_143_0 = 1, 2 do
		if arg_143_0 <= arg_143_1[iter_143_0] then
			return iter_143_0
		end
	end

	return nil
end

function var_0_0.getResistanceKeyById(arg_144_0)
	if not var_0_0.resistanceId2KeyDict then
		var_0_0.resistanceId2KeyDict = {}

		for iter_144_0, iter_144_1 in pairs(FightEnum.Resistance) do
			var_0_0.resistanceId2KeyDict[iter_144_1] = iter_144_0
		end
	end

	return var_0_0.resistanceId2KeyDict[arg_144_0]
end

function var_0_0.canAddPoint(arg_145_0)
	if not arg_145_0 then
		return false
	end

	if arg_145_0:hasBuffFeature(FightEnum.BuffType_TransferAddExPoint) then
		return false
	end

	if arg_145_0:hasBuffFeature(FightEnum.ExPointCantAdd) then
		return false
	end

	return true
end

function var_0_0.getEntityName(arg_146_0)
	local var_146_0 = arg_146_0 and arg_146_0:getMO()
	local var_146_1 = var_146_0 and var_146_0:getEntityName()

	return tostring(var_146_1)
end

function var_0_0.getEntityById(arg_147_0)
	local var_147_0 = var_0_0.getEntity(arg_147_0)

	return var_0_0.getEntityName(var_147_0)
end

function var_0_0.isSameCardMo(arg_148_0, arg_148_1)
	if arg_148_0 == arg_148_1 then
		return true
	end

	if not arg_148_0 or not arg_148_1 then
		return false
	end

	return arg_148_0.clientData.custom_enemyCardIndex == arg_148_1.clientData.custom_enemyCardIndex
end

function var_0_0.getAssitHeroInfoByUid(arg_149_0, arg_149_1)
	local var_149_0 = FightDataHelper.entityMgr:getById(arg_149_0)

	if var_149_0 and var_149_0:isCharacter() then
		local var_149_1 = HeroConfig.instance:getHeroCO(var_149_0.modelId)

		return {
			skin = var_149_0.skin,
			level = var_149_0.level,
			config = var_149_1
		}
	end
end

function var_0_0.canSelectEnemyEntity(arg_150_0)
	if not arg_150_0 then
		return false
	end

	local var_150_0 = FightDataHelper.entityMgr:getById(arg_150_0)

	if not var_150_0 then
		return false
	end

	if var_150_0.side == FightEnum.EntitySide.MySide then
		return false
	end

	if var_150_0:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if var_150_0:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	return true
end

function var_0_0.clearNoUseEffect()
	local var_151_0 = FightEffectPool.releaseUnuseEffect()

	for iter_151_0, iter_151_1 in pairs(var_151_0) do
		FightPreloadController.instance:releaseAsset(iter_151_0)
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC)
end

function var_0_0.isASFDSkill(arg_152_0)
	return arg_152_0 == FightASFDConfig.instance.skillId
end

function var_0_0.isXiTiSpecialSkill(arg_153_0)
	return arg_153_0 == FightASFDConfig.instance.xiTiSpecialSkillId
end

function var_0_0.isPreDeleteSkill(arg_154_0)
	local var_154_0 = arg_154_0 and lua_skill.configDict[arg_154_0]

	return var_154_0 and var_154_0.icon == FightEnum.CardIconId.PreDelete
end

function var_0_0.getASFDMgr()
	local var_155_0 = GameSceneMgr.instance:getCurScene()
	local var_155_1 = var_155_0 and var_155_0.mgr

	return var_155_1 and var_155_1:getASFDMgr()
end

function var_0_0.getEntityCareer(arg_156_0)
	local var_156_0 = arg_156_0 and FightDataHelper.entityMgr:getById(arg_156_0)

	return var_156_0 and var_156_0:getCareer() or 0
end

function var_0_0.isRestrain(arg_157_0, arg_157_1)
	local var_157_0 = var_0_0.getEntityCareer(arg_157_0)
	local var_157_1 = var_0_0.getEntityCareer(arg_157_1)

	return (FightConfig.instance:getRestrain(var_157_0, var_157_1) or 1000) > 1000
end

var_0_0.tempEntityMoList = {}

function var_0_0.hasSkinId(arg_158_0)
	local var_158_0 = var_0_0.tempEntityMoList

	tabletool.clear(var_158_0)

	local var_158_1 = FightDataHelper.entityMgr:getMyNormalList(var_158_0)

	for iter_158_0, iter_158_1 in ipairs(var_158_1) do
		if iter_158_1.originSkin == arg_158_0 then
			return true
		end
	end

	return false
end

function var_0_0.getBloodPoolSkillId()
	return tonumber(lua_fight_xcjl_const.configDict[4].value)
end

function var_0_0.isBloodPoolSkill(arg_160_0)
	return arg_160_0 == var_0_0.getBloodPoolSkillId()
end

function var_0_0.getSurvivalEntityHealth(arg_161_0)
	local var_161_0 = FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]

	if not var_161_0 then
		return
	end

	if not var_161_0.hero2Health then
		return
	end

	local var_161_1 = FightDataHelper.entityMgr:getById(arg_161_0)

	if not var_161_1 then
		return
	end

	local var_161_2 = var_161_1.modelId

	return var_161_0.hero2Health[tostring(var_161_2)]
end

function var_0_0.getSurvivalMaxHealth()
	local var_162_0 = FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]

	if not var_162_0 then
		return
	end

	return var_162_0.maxHealth
end

return var_0_0
