-- chunkname: @modules/logic/fight/system/work/FightWorkCardRemove.lua

module("modules.logic.fight.system.work.FightWorkCardRemove", package.seeall)

local FightWorkCardRemove = class("FightWorkCardRemove", FightEffectBase)
local SKILLID = {
	DEVICE_REMOVE_CARD = 30010701
}

function FightWorkCardRemove:onConstructor()
	self.SAFETIME = 3
end

function FightWorkCardRemove:beforePlayEffectData()
	self.oldCardList = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function FightWorkCardRemove:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local skillId = self.actEffectData.effectNum
	local removeIndexes = string.splitToNumber(self.actEffectData.reserveStr, "#")

	if #removeIndexes > 0 then
		local cards = self.oldCardList

		table.sort(removeIndexes, FightWorkCardRemove2.sort)

		for i, v in ipairs(removeIndexes) do
			table.remove(cards, v)
		end

		local version = FightModel.instance:getVersion()

		if version >= 4 then
			if skillId == SKILLID.DEVICE_REMOVE_CARD then
				FightController.instance:registerCallback(FightEvent.OnDevice_RemoveHandCardDone, self._delayAfterPerformance, self)
				FightController.instance:dispatchEvent(FightEvent.OnDevice_RemoveHandCard, removeIndexes)
			else
				local delayTime = FightCardDataHelper.calcRemoveCardTime(cards, removeIndexes)

				delayTime = delayTime / FightModel.instance:getUISpeed()

				self:com_registTimer(self._delayAfterPerformance, delayTime)
				FightController.instance:dispatchEvent(FightEvent.CardRemove, removeIndexes)
			end
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			self:onDone(true)
		end

		return
	end

	self:onDone(true)
end

function FightWorkCardRemove:_onCombineDone()
	self:onDone(true)
end

function FightWorkCardRemove:_delayAfterPerformance()
	self:onDone(true)
end

function FightWorkCardRemove:_delayDone()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkCardRemove:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnDevice_RemoveHandCardDone, self._delayAfterPerformance, self)

	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkCardRemove
