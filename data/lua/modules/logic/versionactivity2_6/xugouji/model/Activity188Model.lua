module("modules.logic.versionactivity2_6.xugouji.model.Activity188Model", package.seeall)

slot0 = class("Activity188Model", BaseModel)

function slot0.onInit(slot0)
	slot0:_initData()
end

function slot0.reInit(slot0)
	slot0:_initData()
end

function slot0._initData(slot0)
	slot0._passEpisodes = {}
	slot0._unlockEpisodes = {}
	slot0._episodeDatas = {}
	slot0._unLockCount = 0
	slot0._finishedCount = 0

	slot0:clearGameInfo()
end

function slot0.clearGameInfo(slot0)
	slot0._round = 0
	slot0._isMyTurn = true
	slot0._curTurnOperateTime = 0
	slot0._gameState = XugoujiEnum.GameStatus.Operatable
	slot0._gameViewState = XugoujiEnum.GameViewState.PlayerOperating
	slot0._playerInitialHP = 0
	slot0._enemyInitialHP = 0
	slot0._curHP = 0
	slot0._enenyHP = 0
	slot0._curPairCount = 0
	slot0._enenyPairCount = 0
	slot0._playerAbilityIds = {}
	slot0._enemyAbilityIds = {}
	slot0._curTurnOperateTime = 0
	slot0._enemyOperateTimeLeft = 0
	slot0._curCardUid = 0
	slot0._cardsInfo = {}
	slot0._cardsInfoList = {}
	slot0._cardsEffect = {}
	slot0._cardItemState = {}
	slot0._lastCardStatus = 0
	slot0._lastCardId = 0
	slot0._lastCardInfoUId = 0
	slot0._playerBuffs = {}
	slot0._enemyBuffs = {}
	slot0._guideMode = false
	slot0._isHpZero = false
end

function slot0.onAct188GameInfoUpdate(slot0, slot1)
	slot0:clearGameInfo()

	slot0._cardsInfo = slot0._cardsInfo and slot0._cardsInfo or {}
	slot0._gameId = Activity188Config.instance:getEpisodeCfgByEpisodeId(uv0.instance:getCurEpisodeId()).gameId

	if slot0._gameId then
		slot0:setRound(slot1.round)
		slot0:updateCardInfo(slot1.cards)
		slot0:_setCurHP(slot1.team.hp)
		slot0:_setEnemyHP(slot1.bossTeam.hp)
		slot0:setInitialHP(slot1.team.hp, slot1.bossTeam.hp)
		slot0:_setCurPairCount(slot1.team.pairCount)
		slot0:_setEnemyPairCount(slot1.bossTeam.pairCount)
		slot0:setPlayerAbilityIds(slot1.team.abilityIds)
		slot0:setEnemyAbilityIds(slot1.bossTeam.abilityIds)
		slot0:setCurTurnOperateTime(slot1.team.maxReverseCount)
		slot0:setCurTurnOperateTime(slot1.bossTeam.maxReverseCount, true)
	end
end

function slot0.updateCardInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._cardsInfo[slot6.uid] = slot6
		slot0._cardsInfoList[slot5] = slot6
	end
end

function slot0.updateCardStatus(slot0, slot1, slot2)
	if slot0:getCardInfo(slot1) then
		slot3.status = slot2
		slot0._lastUid = slot1
		slot0._lastCardStatus = slot2
		slot0._lastCardId = slot3.id
	end
end

function slot0.updateCardEffectStatus(slot0, slot1, slot2, slot3)
	if not slot0:getCardEffect(slot1) then
		slot0._cardsEffect[slot1] = {}
	end

	if slot2 then
		slot0._cardsEffect[slot1][slot3] = true
	elseif slot3 == 0 then
		slot0._cardsEffect[slot1] = {}
	else
		slot0._cardsEffect[slot1][slot3] = false
	end
end

function slot0.clearCardsInfo(slot0)
	slot0._cardsInfo = {}
	slot0._cardsInfoList = {}
	slot0._cardsEffect = {}
	slot0._cardItemState = {}
end

function slot0.getCardsInfo(slot0)
	return slot0._cardsInfo
end

function slot0.getCardsInfoList(slot0)
	return slot0._cardsInfoList
end

function slot0.getCardsInfoSortedList(slot0)
	for slot6, slot7 in ipairs(slot0._cardsInfoList) do
		-- Nothing
	end

	return {
		[slot7.y + 1 + slot7.x * uv0.instance:getCardColNum()] = slot7
	}
end

function slot0.getCardColNum(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0._cardsInfoList) do
		if slot1 < slot6.y then
			slot1 = slot6.y or slot1
		end
	end

	return slot1 + 1
end

function slot0.getCardInfo(slot0, slot1)
	return slot0._cardsInfo[slot1]
end

function slot0.getCardEffect(slot0, slot1)
	return slot0._cardsEffect[slot1]
end

function slot0.addOpenedCard(slot0, slot1)
	slot0._openedCardList = slot0._openedCardList and slot0._openedCardList or {}
	slot0._openedCardList[#slot0._openedCardList + 1] = slot1
end

function slot0.getLastCardPair(slot0)
	if not slot0._openedCardList or #slot0._openedCardList < 2 then
		return nil
	end

	return slot0._openedCardList[#slot0._openedCardList], slot0._openedCardList[#slot0._openedCardList - 1]
end

function slot0.getLastCardUid(slot0)
	return slot0._lastUid
end

function slot0.getLastCardStatus(slot0)
	return slot0._lastCardStatus
end

function slot0.getLastCardId(slot0)
	return slot0._lastCardId
end

function slot0.setLastCardInfoUId(slot0, slot1)
	slot0._lastCardInfoUId = slot1
end

function slot0.getLastCardInfoUId(slot0)
	return slot0._lastCardInfoUId
end

function slot0.setCurCardUid(slot0, slot1)
	slot0._curCardUid = slot1
end

function slot0.getCurCardUid(slot0)
	return slot0._curCardUid
end

function slot0.setCurActId(slot0, slot1)
	slot0._curActId = slot1
end

function slot0.getCurActId(slot0)
	return slot0._curActId
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId
end

function slot0.setCurBattleEpisodeId(slot0, slot1)
	slot0._curBattleEpisodeId = slot1
end

function slot0.getCurBattleEpisodeId(slot0)
	return slot0._curBattleEpisodeId
end

function slot0.isEpisodeFinish(slot0, slot1)
	return slot0._passEpisodes[slot1]
end

function slot0.getCurGameId(slot0)
	return slot0._gameId
end

function slot0.setCurTurnOperateTime(slot0, slot1, slot2)
	if slot2 then
		slot0._enemyOperateTimeLeft = slot1
	else
		slot0._curTurnOperateTime = slot1
	end
end

function slot0.getCurTurnOperateTime(slot0)
	return slot0._curTurnOperateTime
end

function slot0.getEnemyOperateTime(slot0)
	return slot0._enemyOperateTimeLeft
end

function slot0.setRound(slot0, slot1)
	slot0._round = slot1
end

function slot0.getRound(slot0)
	return slot0._round
end

function slot0.getGameTurn(slot0)
	return slot0._curCardUid
end

function slot0.isMyTurn(slot0)
	return slot0._isMyTurn
end

function slot0.setTurn(slot0, slot1)
	if slot0._isMyTurn == false and slot1 then
		slot0:setRound(slot0:getRound() + 1)
	end

	slot0._isMyTurn = slot1
end

function slot0.updateHp(slot0, slot1, slot2)
	if slot1 then
		slot0._curHP = slot0._curHP + tonumber(slot2)
	else
		slot0._enenyHP = slot0._enenyHP + slot3
	end
end

function slot0.checkHpZero(slot0, slot1)
	slot0._isHpZero = slot0._curHP + tonumber(slot1) <= 0

	return slot0._isHpZero
end

function slot0.isHpZero(slot0)
	return slot0._isHpZero
end

function slot0._setCurHP(slot0, slot1)
	slot0._curHP = slot1 and slot1 or 0
end

function slot0.getCurHP(slot0)
	return slot0._curHP
end

function slot0._setEnemyHP(slot0, slot1)
	slot0._enenyHP = slot1 and slot1 or 0
end

function slot0.getEnemyHP(slot0)
	return slot0._enenyHP
end

function slot0.setInitialHP(slot0, slot1, slot2)
	slot0._playerInitialHP = tonumber(slot1)
	slot0._enemyInitialHP = tonumber(slot2)
end

function slot0.getPlayerInitialHP(slot0)
	return slot0._playerInitialHP
end

function slot0.getEnemyInitialHP(slot0)
	return slot0._enemyInitialHP
end

function slot0.setPairCount(slot0, slot1, slot2)
	if slot2 then
		slot0._curPairCount = slot1
	else
		slot0._enenyPairCount = slot1
	end
end

function slot0._setCurPairCount(slot0, slot1)
	slot0._curPairCount = slot1
end

function slot0.getCurPairCount(slot0)
	return slot0._curPairCount
end

function slot0._setEnemyPairCount(slot0, slot1)
	slot0._enenyPairCount = slot1
end

function slot0.getEnemyPairCount(slot0)
	return slot0._enenyPairCount
end

function slot0.setPlayerAbilityIds(slot0, slot1)
	slot0._playerAbilityIds = slot1
end

function slot0.getPlayerAbilityIds(slot0)
	return slot0._playerAbilityIds
end

function slot0.setEnemyAbilityIds(slot0, slot1)
	slot0._enemyAbilityIds = slot1
end

function slot0.getEnemyAbilityIds(slot0)
	return slot0._enemyAbilityIds
end

function slot0.setBuffs(slot0, slot1, slot2)
	if slot2 then
		slot0._playerBuffs = slot1
	else
		slot0._enemyBuffs = slot1
	end
end

function slot0.getBuffs(slot0, slot1)
	return slot1 and slot0._playerBuffs or slot0._enemyBuffs
end

function slot0.setGameState(slot0, slot1)
	slot0._gameState = slot1
end

function slot0.getGameState(slot0)
	return slot0._gameState
end

function slot0.setGameViewState(slot0, slot1)
	slot0._gameViewState = slot1
end

function slot0.getGameViewState(slot0)
	return slot0._gameViewState
end

function slot0.setCardItemStatue(slot0, slot1, slot2)
	slot0._cardItemState[slot1] = slot2
end

function slot0.getCardItemStatue(slot0, slot1)
	return slot0._cardItemState[slot1]
end

function slot0.setGameGuideMode(slot0, slot1)
	slot0._guideMode = slot1 and tonumber(slot1) == 1
end

function slot0.isGameGuideMode(slot0)
	return slot0._guideMode
end

function slot0.onGetActInfoReply(slot0, slot1)
	slot0._unLockCount = 0
	slot0._finishedCount = 0

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.episodeId
		slot0._episodeDatas[slot7] = slot6
		slot0._unlockEpisodes[slot7] = true
		slot0._unLockCount = slot0._unLockCount + 1

		if slot6.isFinished then
			slot0._passEpisodes[slot7] = true
			slot0._finishedCount = slot0._finishedCount + 1
		end
	end
end

function slot0.onEpisodeInfoUpdate(slot0, slot1, slot2)
	if Activity188Config.instance:getEpisodeCfgByEpisodeId(slot1) and not slot0._unlockEpisodes[slot1] then
		slot0._unlockEpisodes[slot1] = true
		slot0._unLockCount = slot0._unLockCount + 1

		if not slot0._passEpisodes[slot3.preEpisodeId] then
			slot0._passEpisodes[slot4] = true
			slot0._finishedCount = slot0._finishedCount + 1
		end
	end
end

function slot0.onStoryEpisodeFinish(slot0, slot1)
	if not slot0._passEpisodes[slot1] then
		slot0._passEpisodes[slot1] = true
		slot0._finishedCount = slot0._finishedCount + 1
	end

	if Activity188Config.instance:getEpisodeCfgByPreEpisodeId(slot1) and not slot0._unlockEpisodes[slot2.episodeId] then
		slot0._unlockEpisodes[slot2.episodeId] = true
		slot0._unLockCount = slot0._unLockCount + 1
	end
end

function slot0.getUnlockCount(slot0)
	return slot0._unLockCount and slot0._unLockCount or 10
end

function slot0.getFinishedCount(slot0)
	return slot0._finishedCount
end

function slot0.isEpisodeUnlock(slot0, slot1)
	return slot0._unlockEpisodes[slot1]
end

function slot0.isEpisodeFinished(slot0, slot1)
	return slot0._passEpisodes[slot1]
end

slot0.instance = slot0.New()

return slot0
