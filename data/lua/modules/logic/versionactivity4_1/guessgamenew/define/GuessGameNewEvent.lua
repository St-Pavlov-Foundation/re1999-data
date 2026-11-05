-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/define/GuessGameNewEvent.lua

module("modules.logic.versionactivity4_1.guessgamenew.define.GuessGameNewEvent", package.seeall)

local GuessGameNewEvent = _M

GuessGameNewEvent.OnRoundStart = GameUtil.getUniqueTb()
GuessGameNewEvent.OnRoundDistributeCardClick = GameUtil.getUniqueTb()
GuessGameNewEvent.OnRoundDistributeCardFinished = GameUtil.getUniqueTb()
GuessGameNewEvent.OnRoundGuessFinished = GameUtil.getUniqueTb()
GuessGameNewEvent.OnTaskTipReset = GameUtil.getUniqueTb()
GuessGameNewEvent.OnRefreshTaskTipUnlockChanged = GameUtil.getUniqueTb()
GuessGameNewEvent.OnShowRoleResultBubble = GameUtil.getUniqueTb()
GuessGameNewEvent.OnReduceRoleHp = GameUtil.getUniqueTb()
GuessGameNewEvent.OnRoleSelectCardStart = GameUtil.getUniqueTb()
GuessGameNewEvent.OnRoleSelectCardFinished = GameUtil.getUniqueTb()
GuessGameNewEvent.OnRoleGuessFinished = GameUtil.getUniqueTb()
GuessGameNewEvent.OnRoleGuessResultShowFinished = GameUtil.getUniqueTb()
GuessGameNewEvent.OnGuessBtnClick = GameUtil.getUniqueTb()
GuessGameNewEvent.OnShowGuessAnnounceTips = GameUtil.getUniqueTb()
GuessGameNewEvent.OnGameGuessFinished = GameUtil.getUniqueTb()
GuessGameNewEvent.OnGameFinished = GameUtil.getUniqueTb()
GuessGameNewEvent.OnFinishGameBackToMain = GameUtil.getUniqueTb()

return GuessGameNewEvent
