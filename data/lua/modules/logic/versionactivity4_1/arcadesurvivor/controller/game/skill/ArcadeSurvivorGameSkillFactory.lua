-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/ArcadeSurvivorGameSkillFactory.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.ArcadeSurvivorGameSkillFactory", package.seeall)

local ArcadeSurvivorGameSkillFactory = _M

ArcadeSurvivorGameSkillFactory.CondClsMap = {
	[ArcadeSurvivorGameEnum.ConditionType.PreRound] = ArcadeSurvivorConditionPreRound,
	[ArcadeSurvivorGameEnum.ConditionType.AnyBuff] = ArcadeSurvivorConditionAnyBuff,
	[ArcadeSurvivorGameEnum.ConditionType.BuffLayer] = ArcadeSurvivorConditionBuffLayer
}
ArcadeSurvivorGameSkillFactory.HitClsMap = {
	[ArcadeSurvivorGameEnum.EffectType.LeaveBoard] = ArcadeSurvivorGameHitLeaveBoard,
	[ArcadeSurvivorGameEnum.EffectType.ReturnBoard] = ArcadeSurvivorGameHitReturnBoard,
	[ArcadeSurvivorGameEnum.EffectType.ReturnBoardLater] = ArcadeSurvivorGameHitReturnBoardLater,
	[ArcadeSurvivorGameEnum.EffectType.Cure] = ArcadeSurvivorGameHitCure,
	[ArcadeSurvivorGameEnum.EffectType.AddBuff] = ArcadeSurvivorGameHitAddBuff,
	[ArcadeSurvivorGameEnum.EffectType.AddBuffByColl] = ArcadeSurvivorGameHitAddBuffByColl,
	[ArcadeSurvivorGameEnum.EffectType.AddBuffByCoin] = ArcadeSurvivorGameHitAddBuffByCoin,
	[ArcadeSurvivorGameEnum.EffectType.RemoveBuff] = ArcadeSurvivorGameHitRemoveBuff,
	[ArcadeSurvivorGameEnum.EffectType.Summon] = ArcadeSurvivorGameHitSummon,
	[ArcadeSurvivorGameEnum.EffectType.Kill] = ArcadeSurvivorGameHitKill,
	[ArcadeSurvivorGameEnum.EffectType.Damage] = ArcadeSurvivorGameHitDamage,
	[ArcadeSurvivorGameEnum.EffectType.DamageLater] = ArcadeSurvivorGameHitDamageLater,
	[ArcadeSurvivorGameEnum.EffectType.DamageByBuff] = ArcadeSurvivorGameHitDamageByBuff,
	[ArcadeSurvivorGameEnum.EffectType.Boom] = ArcadeSurvivorGameHitBoom,
	[ArcadeSurvivorGameEnum.EffectType.ChangeGrid] = ArcadeSurvivorGameHitChangeGrid,
	[ArcadeSurvivorGameEnum.EffectType.Dash] = ArcadeSurvivorGameHitDash,
	[ArcadeSurvivorGameEnum.EffectType.Flop] = ArcadeSurvivorGameHitFlop,
	[ArcadeSurvivorGameEnum.EffectType.Pushback] = ArcadeSurvivorGameHitPushback,
	[ArcadeSurvivorGameEnum.EffectType.Morph] = ArcadeSurvivorGameHitMorph,
	[ArcadeSurvivorGameEnum.EffectType.ChangePos] = ArcadeSurvivorGameHitChangePos,
	[ArcadeSurvivorGameEnum.EffectType.ChangePosLater] = ArcadeSurvivorGameHitChangePosLater
}
ArcadeSurvivorGameSkillFactory.SelectorClsMap = {
	[ArcadeSurvivorGameEnum.SelectorType.Owner] = ArcadeSurvivorSelectorOwner,
	[ArcadeSurvivorGameEnum.SelectorType.Rect] = ArcadeSurvivorSelectorRect,
	[ArcadeSurvivorGameEnum.SelectorType.RectRandom] = ArcadeSurvivorSelectorRectRandom,
	[ArcadeSurvivorGameEnum.SelectorType.Follow] = ArcadeSurvivorSelectorFollow,
	[ArcadeSurvivorGameEnum.SelectorType.CoordinateRel] = ArcadeSurvivorSelectorCoordinateRel,
	[ArcadeSurvivorGameEnum.SelectorType.CoordinateRelRandom] = ArcadeSurvivorSelectorCoordinateRelRandom,
	[ArcadeSurvivorGameEnum.SelectorType.Hitter] = ArcadeSurvivorSelectorHitter,
	[ArcadeSurvivorGameEnum.SelectorType.Attacker] = ArcadeSurvivorSelectorAttacker,
	[ArcadeSurvivorGameEnum.SelectorType.SelfXY] = ArcadeSurvivorSelectorSelfXY,
	[ArcadeSurvivorGameEnum.SelectorType.CoordinateAbs] = ArcadeSurvivorSelectorCoordinateAbs,
	[ArcadeSurvivorGameEnum.SelectorType.Dynamic] = ArcadeSurvivorSelectorDynamic
}

function ArcadeSurvivorGameSkillFactory.createCondition(effectId)
	local conditionType = ArcadeSurvivorConfig.instance:getSkillEffectCondition(effectId)

	if string.nilorempty(conditionType) then
		return
	end

	local cls = ArcadeSurvivorGameSkillFactory.CondClsMap[conditionType]

	if not cls then
		logError(string.format("ArcadeSurvivorGameSkillFactory.createCondition error, can't find cls define, effectId:%s conditionType:%s", effectId, conditionType))

		return
	end

	local conditionParam = ArcadeSurvivorConfig.instance:getSkillEffectConditionParam(effectId)

	return cls.New(conditionParam)
end

function ArcadeSurvivorGameSkillFactory.createEffect(skill, effectId, triggerIndex)
	local effectType = ArcadeSurvivorConfig.instance:getSkillEffectType(effectId)
	local cls = ArcadeSurvivorGameSkillFactory.HitClsMap[effectType]

	if cls then
		return cls.New(skill, effectId, triggerIndex)
	else
		logError(string.format("ArcadeSurvivorGameSkillFactory.createEffect error, can't find cls define, effectId:%s effectType:%s", effectId, effectType))
	end
end

function ArcadeSurvivorGameSkillFactory.createSelector(effectId)
	local selectorArr = ArcadeSurvivorConfig.instance:getSkillEffectTarget(effectId)
	local selectorType = selectorArr[1]

	if not selectorType then
		return
	end

	local cls = ArcadeSurvivorGameSkillFactory.SelectorClsMap[selectorType]

	if cls then
		return cls.New(selectorArr)
	else
		logError(string.format("ArcadeSurvivorGameSkillFactory.createSelector error, can't find cls define, effectId:%s selectorType:%s", effectId, selectorType))
	end
end

function ArcadeSurvivorGameSkillFactory.createSelectorByParam(paramArr)
	local selectorType = paramArr[1]

	if not selectorType then
		return
	end

	local cls = ArcadeSurvivorGameSkillFactory.SelectorClsMap[selectorType]

	if cls then
		return cls.New(paramArr)
	else
		logError(string.format("ArcadeSurvivorGameSkillFactory.createSelectorByParams error, can't find cls define, selectorType:%s", selectorType))
	end
end

return ArcadeSurvivorGameSkillFactory
