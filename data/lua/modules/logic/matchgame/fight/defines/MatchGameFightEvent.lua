-- chunkname: @modules/logic/matchgame/fight/defines/MatchGameFightEvent.lua

module("modules.logic.matchgame.fight.defines.MatchGameFightEvent", package.seeall)

local MatchGameFightEvent = _M
local _get = GameUtil.getUniqueTb(1000)

MatchGameFightEvent.MoveFillElementItemFinish = _get()
MatchGameFightEvent.BombElementItemFinish = _get()
MatchGameFightEvent.HeroAttackStart = _get()
MatchGameFightEvent.HeroAttackFinish = _get()
MatchGameFightEvent.EnemyAttackStart = _get()
MatchGameFightEvent.EnemyAttackFinish = _get()
MatchGameFightEvent.ContinueGame = _get()
MatchGameFightEvent.QuitGame = _get()
MatchGameFightEvent.RefreshTargetGoal = _get()
MatchGameFightEvent.OnSkillNoneCondition = _get()
MatchGameFightEvent.OnSkillCastCondition = _get()
MatchGameFightEvent.OnMatchCountMoreThanCondition = _get()
MatchGameFightEvent.OnFeverEnterCondition = _get()
MatchGameFightEvent.OnBattleStartCondition = _get()
MatchGameFightEvent.OnTurnStartCondition = _get()
MatchGameFightEvent.OnTurnEndCondition = _get()
MatchGameFightEvent.OnRemoveSkillBuff = _get()
MatchGameFightEvent.OnChainNumAdd = _get()
MatchGameFightEvent.RefreshChallengeScore = _get()

return MatchGameFightEvent
