﻿-- chunkname: @modules/logic/fight/view/cardeffect/FightCardLongPressEndEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardLongPressEndEffect", package.seeall)

local FightCardLongPressEndEffect = class("FightCardLongPressEndEffect", BaseWork)

function FightCardLongPressEndEffect:ctor()
	return
end

function FightCardLongPressEndEffect:onStart(context)
	FightCardLongPressEndEffect.super.onStart(self, context)

	self._dragItem = context.handCardItemList[context.index]
	self._cardCount = context.cardCount

	gohelper.setAsLastSibling(self._dragItem.go)
	FightController.instance:dispatchEvent(FightEvent.CardLongPressEffectEnd)

	local curScale, _, _ = transformhelper.getLocalScale(self._dragItem.tr)

	self._sequence = FlowSequence.New()

	self._sequence:addWork(TweenWork.New({
		type = "DOTweenFloat",
		to = 1,
		t = 0.05,
		from = curScale,
		frameCb = self._tweenFrameScale,
		cbObj = self
	}))
	self._sequence:registerDoneListener(self._onWorkDone, self)
	self._sequence:start()
end

function FightCardLongPressEndEffect:_tweenFrameScale(value)
	self._dragScale = value

	self:_updateDragHandCards()
end

function FightCardLongPressEndEffect:_onWorkDone()
	self._sequence:unregisterDoneListener(self._onWorkDone, self)
	self:onDone(true)
end

function FightCardLongPressEndEffect:_updateDragHandCards()
	local dragIndex = self.context.index
	local dragItem = self._dragItem
	local cardCount = self._cardCount
	local dragScale = self._dragScale
	local handCardItemList = self.context.handCardItemList
	local targetPosY = FightViewHandCard.HandCardHeight * (dragScale - 1) / 2

	recthelper.setAnchorY(dragItem.tr, targetPosY)
	transformhelper.setLocalScale(dragItem.tr, dragScale, dragScale, 1)

	for i = 1, cardCount do
		local item = handCardItemList[i]
		local curPosX = recthelper.getAnchorX(item.tr)
		local targetPosX = FightViewHandCard.calcCardPosXDraging(i, cardCount, dragIndex, dragScale)

		recthelper.setAnchorX(item.tr, targetPosX)
	end
end

return FightCardLongPressEndEffect
