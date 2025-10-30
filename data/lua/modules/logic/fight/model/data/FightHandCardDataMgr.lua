﻿-- chunkname: @modules/logic/fight/model/data/FightHandCardDataMgr.lua

module("modules.logic.fight.model.data.FightHandCardDataMgr", package.seeall)

local FightHandCardDataMgr = FightDataClass("FightHandCardDataMgr", FightDataMgrBase)

function FightHandCardDataMgr:onConstructor()
	self.handCard = {}
	self.originCard = {}
	self.redealCard = {}
end

function FightHandCardDataMgr:onStageChanged(curStage, preStage)
	for i = 1, #self.handCard do
		self.handCard[i].originHandCardIndex = i
	end

	FightDataUtil.coverData(self.handCard, self.originCard)
end

function FightHandCardDataMgr:onCancelOperation()
	FightDataUtil.coverData(self.originCard, self.handCard)
end

function FightHandCardDataMgr:getHandCard()
	return self.handCard
end

function FightHandCardDataMgr:coverCard(cardList)
	FightDataUtil.coverData(cardList, self.handCard)
end

function FightHandCardDataMgr:setOriginCard()
	FightDataUtil.coverData(self.handCard, self.originCard)
end

function FightHandCardDataMgr:updateHandCardByProto(proto)
	local cards = FightCardDataHelper.newCardList(proto)

	FightDataUtil.coverData(cards, self.handCard)
end

function FightHandCardDataMgr:cacheDistributeCard(round)
	self.beforeCards1 = FightCardDataHelper.newCardList(round.beforeCards1)
	self.teamACards1 = FightCardDataHelper.newCardList(round.teamACards1)
	self.beforeCards2 = FightCardDataHelper.newCardList(round.beforeCards2)
	self.teamACards2 = FightCardDataHelper.newCardList(round.teamACards2)
end

function FightHandCardDataMgr:cacheRedealCard(proto)
	table.insert(self.redealCard, FightCardDataHelper.newCardList(proto))
end

function FightHandCardDataMgr:getRedealCard()
	return table.remove(self.redealCard, 1)
end

function FightHandCardDataMgr:distribute(beforeCards, distribute)
	FightDataUtil.coverData(beforeCards, self.handCard)

	distribute = FightDataUtil.coverData(distribute)

	tabletool.addValues(self.handCard, distribute)
	FightCardDataHelper.combineCardList(self.handCard, self.dataMgr.entityMgr)
end

return FightHandCardDataMgr
