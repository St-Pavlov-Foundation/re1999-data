module("modules.logic.versionactivity2_7.coopergarland.model.CooperGarlandGameModel", package.seeall)

slot0 = class("CooperGarlandGameModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clearAllData()
end

function slot0.reInit(slot0)
	slot0:clearAllData()
end

function slot0.clearAllData(slot0)
	slot0:setEpisodeId()
	slot0:setGameId()
	slot0:setGameRound()
	slot0:setMapId()
	slot0:setRemoveCount()
	slot0:setRemoveMode()
	slot0:setBallHasKey(false)
	slot0:setIsStopGame(false)
end

function slot0.enterGameInitData(slot0, slot1)
	slot0:setEpisodeId(slot1)

	slot2 = CooperGarlandModel.instance:getAct192Id()

	slot0:setGameId(CooperGarlandConfig.instance:getGameId(slot2, slot1))
	slot0:changeRound(CooperGarlandModel.instance:getEpisodeProgress(slot2, slot1))
end

function slot0.changeRound(slot0, slot1)
	if not slot0:getGameId() then
		return
	end

	slot0:setGameRound(slot1)
	slot0:setMapId(CooperGarlandConfig.instance:getMapId(slot2, slot1))
	slot0:setRemoveCount(CooperGarlandConfig.instance:getRemoveCount(slot2, slot1))
	slot0:setBallHasKey(false)
	slot0:setRemoveMode(false)
	slot0:setIsStopGame(false)
end

function slot0.resetGameData(slot0)
	slot0:changeRound(slot0:getGameRound())
end

function slot0.setEpisodeId(slot0, slot1)
	slot0._episodeId = slot1
end

function slot0.setGameId(slot0, slot1)
	slot0._gameId = slot1
end

function slot0.setGameRound(slot0, slot1)
	slot0._gameRound = slot1
end

function slot0.setMapId(slot0, slot1)
	slot0._mapId = slot1
end

function slot0.setRemoveCount(slot0, slot1)
	slot0._removeCount = slot1
end

function slot0.setRemoveMode(slot0, slot1)
	slot0._isRemoveMode = slot1
end

function slot0.setBallHasKey(slot0, slot1)
	slot0._hasKey = slot1
end

function slot0.setControlMode(slot0, slot1)
	slot0._controlMode = slot1

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.CooperGarlandControlMode, slot1)
end

function slot0.setIsStopGame(slot0, slot1)
	slot0._isStopGame = slot1
end

function slot0.getEpisodeId(slot0)
	return slot0._episodeId
end

function slot0.getGameId(slot0)
	return slot0._gameId
end

function slot0.getGameRound(slot0)
	return slot0._gameRound
end

function slot0.getMapId(slot0)
	return slot0._mapId
end

function slot0.getRemoveCount(slot0)
	return slot0._removeCount or 0
end

function slot0.getIsRemoveMode(slot0)
	return slot0._isRemoveMode
end

function slot0.getBallHasKey(slot0)
	return slot0._hasKey
end

function slot0.getControlMode(slot0)
	if not slot0._controlMode then
		slot0._controlMode = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.CooperGarlandControlMode, CooperGarlandEnum.Const.JoystickModeRight)
	end

	return slot0._controlMode
end

function slot0.getIsJoystick(slot0)
	return slot0:getControlMode() == CooperGarlandEnum.Const.JoystickModeRight or slot1 == CooperGarlandEnum.Const.JoystickModeLeft
end

function slot0.isFinishedStoryComponent(slot0, slot1, slot2)
	slot3 = false
	slot6 = CooperGarlandConfig.instance:getMapComponentExtraParams(slot1, slot2) and tonumber(slot5)

	if CooperGarlandConfig.instance:getMapComponentType(slot1, slot2) == CooperGarlandEnum.ComponentType.Story and slot6 then
		slot3 = GuideModel.instance:isGuideFinish(slot6)
	end

	return slot3
end

function slot0.getIsStopGame(slot0)
	return slot0._isStopGame
end

slot0.instance = slot0.New()

return slot0
