module("modules.logic.versionactivity2_5.autochess.model.AutoChessModel", package.seeall)

slot0 = class("AutoChessModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.chessMoDic = {}
end

function slot0.enterSceneReply(slot0, slot1, slot2)
	slot0.curModuleId = slot1
	slot3 = AutoChessMO.New()

	slot3:updateSvrScene(slot2)

	slot0.chessMoDic[slot1] = slot3
end

function slot0.setEpisodeId(slot0, slot1)
	slot0.episodeId = slot1
end

function slot0.getCurModuleId(slot0)
	return slot0.curModuleId
end

function slot0.getChessMo(slot0, slot1, slot2)
	if slot0.chessMoDic[slot1 or slot0.curModuleId] then
		return slot3
	end

	if not slot2 then
		logError(string.format("异常:不存在游戏数据%s", slot1))
	end
end

function slot0.svrResultData(slot0, slot1)
	slot0.resultData = slot1
end

function slot0.svrSettleData(slot0, slot1)
	slot0.settleData = {
		remainingHp = slot1.remainingHp,
		totalInjury = slot1.totalInjury,
		isFirstPass = slot1.isFirstPass,
		moduleId = slot1.moduleId,
		rank = slot1.rank,
		score = slot1.score,
		chessIds = slot1.chessIds,
		episodeId = slot1.episodeId,
		masterId = slot1.masterId,
		round = slot1.round,
		changeScore = slot1.score - Activity182Model.instance:getActMo().score
	}
end

slot0.instance = slot0.New()

return slot0
