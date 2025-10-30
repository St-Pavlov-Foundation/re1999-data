﻿-- chunkname: @modules/logic/fight/view/work/FightViewWorkAddUseCard.lua

module("modules.logic.fight.view.work.FightViewWorkAddUseCard", package.seeall)

local FightViewWorkAddUseCard = class("FightViewWorkAddUseCard", BaseWork)

function FightViewWorkAddUseCard:onStart()
	local duration = 0.16 / FightModel.instance:getUISpeed()
	local usedCards = FightPlayCardModel.instance:getUsedCards()
	local count = #usedCards
	local class = self.context
	local cardItemList = class._cardItemList
	local oldPosX = {}

	for i, cardItem in ipairs(cardItemList) do
		if cardItem.go.activeInHierarchy then
			local index = tabletool.indexOf(usedCards, cardItem._cardInfoMO)

			oldPosX[index] = recthelper.getAnchorX(cardItem.go.transform.parent)
		end
	end

	class:_onSetUseCards()

	self._flow = FlowParallel.New()

	for i, cardItem in ipairs(cardItemList) do
		local transform = cardItem.go.transform.parent

		if cardItem.go.activeInHierarchy and oldPosX[i] then
			recthelper.setAnchorX(transform, oldPosX[i])

			local posX = FightViewWaitingAreaVersion1.getCardPos(i, count)

			self._flow:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = transform,
				to = posX,
				t = duration
			}))
		end

		recthelper.setAnchorY(transform, 150)
	end

	local createTime = 0.2 / FightModel.instance:getUISpeed()
	local posYTime = 0.25 / FightModel.instance:getUISpeed()

	for i, cardItem in ipairs(cardItemList) do
		if cardItem.go.activeInHierarchy then
			cardItem:hideCardAppearEffect()
			cardItem:onCardAniFinish()

			gohelper.onceAddComponent(cardItem.go, gohelper.Type_CanvasGroup).alpha = 1

			local cardInfo = cardItem._cardInfoMO

			if cardInfo.CUSTOMADDUSECARD then
				gohelper.onceAddComponent(cardItem.go, gohelper.Type_CanvasGroup).alpha = 0

				if self:checkCanPlayAppearEffect(cardInfo) then
					cardItem:playAppearEffect()
				end

				cardItem:playCardAni(ViewAnim.FightCardAppear, "fightcard_apper")
				cardItem:tryPlayAlfEffect()

				local sequence = FlowSequence.New()

				sequence:addWork(WorkWaitSeconds.New(createTime))

				local transform = cardItem.go.transform.parent

				recthelper.setAnchorY(transform, 300)
				sequence:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = 150,
					tr = transform,
					t = posYTime,
					ease = EaseType.OutQuart
				}))
				self._flow:addWork(sequence)
			end
		end
	end

	self._flow:addWork(FunctionWork.New(self._clearSign, self))
	AudioMgr.instance:trigger(20211406)
	self._flow:start()
end

function FightViewWorkAddUseCard:checkCanPlayAppearEffect(cardInfoMo)
	if FightHelper.isASFDSkill(cardInfoMo.skillId) then
		return false
	end

	if cardInfoMo.clientData.custom_fromSkillId and FightHeroALFComp.ALFSkillDict[cardInfoMo.clientData.custom_fromSkillId] then
		return false
	end

	return true
end

function FightViewWorkAddUseCard:_clearSign()
	local cardList = FightPlayCardModel.instance:getUsedCards()

	for i, card in ipairs(cardList) do
		card.CUSTOMADDUSECARD = nil
	end
end

function FightViewWorkAddUseCard:_delayDone()
	return
end

function FightViewWorkAddUseCard:clearWork()
	if self._flow then
		self._flow:stop()

		self._flow = nil
	end
end

return FightViewWorkAddUseCard
