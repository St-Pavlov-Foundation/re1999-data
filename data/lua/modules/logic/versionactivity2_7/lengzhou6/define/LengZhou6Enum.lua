module("modules.logic.versionactivity2_7.lengzhou6.define.LengZhou6Enum", package.seeall)

slot0 = class("LengZhou6Enum")
slot0.entityCamp = {
	enemy = 2,
	player = 1
}
slot0.TaskMOAllFinishId = -99999
slot0.SkillType = {
	passive = "passive",
	enemyActive = "enemyActive",
	active = "active"
}
slot0.BattleStep = {
	attackAfter = 208,
	attackComplete = 212,
	enemyCheckInterval = 900,
	attackBefore = 201,
	gameEnd = 1000,
	addBuff = 109,
	calHpBefore = 101,
	calHpAfter = 108,
	poisonSettlement = 910,
	gameBegin = 0
}
slot0.LoadingTime = 1
slot0.SkillEffect = {
	AddBuffByIntensified = "AddBuffByIntensified",
	EliminationDecreaseCd = "EliminationDecreaseCd",
	DealsDamage = "DealsDamage",
	DamageUpByIntensified = "DamageUpByIntensified",
	Heal = "Heal",
	AddBuff = "AddBuff",
	EliminationLevelUp = "EliminationLevelUp",
	Shuffle = "Shuffle",
	Contaminate = "Contaminate",
	HealUpByIntensified = "HealUpByIntensified",
	PetrifyEliminationBlock = "PetrifyEliminationBlock",
	EliminationCross = "EliminationCross",
	EliminationRange = "EliminationRange",
	EliminationDoubleAttack = "EliminationDoubleAttack",
	FreezeEliminationBlock = "FreezeEliminationBlock",
	SuccessiveElimination = "SuccessiveElimination",
	DamageUpByType = "DamageUpByType"
}
slot0.NormalEliminateEffect = "normal"
slot0.BuffEffect = {
	damageUp = "damageUp",
	petrify = "petrify",
	poison = "poison"
}
slot0.BattleModel = {
	infinite = "infinite",
	normal = "normal"
}
slot0.BattleProgress = {
	selectFinish = 2,
	selectSkill = 1
}
slot0.EnemySkillTime = 1
slot0.EnemySkillTime_2 = 0.5
slot0.EnemyBuffEffectShowTime = 0.5
slot0.enterGM = false
slot0.DebugPlayerHp = 10000000
slot0.PlayerSkillMaxCount = 3
slot0.DefaultEndLessBeginRound = 1
slot0.EndLessChangeSkillLayer = 5
slot0.BlockKey = {
	OneClickResetLevel = "LengZhou6OneClickResetLevelKey",
	OneClickClaimReward = "LengZhou6OneClickClaimRewardBlockKey"
}
slot0.openViewAniTime = 1.167
slot0.GameResult = {
	normalCancel = 3,
	lose = 2,
	infiniteCancel = 4,
	win = 1
}
slot0.defaultEnemy = 227101
slot0.defaultPlayerSkillSelectMax = 3

return slot0
