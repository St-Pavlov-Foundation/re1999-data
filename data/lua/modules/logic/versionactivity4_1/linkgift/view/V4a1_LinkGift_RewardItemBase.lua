-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_RewardItemBase.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_RewardItemBase", package.seeall)

local V4a1_LinkGift_RewardItemBase = class("V4a1_LinkGift_RewardItemBase", RougeSimpleItemBase)

function V4a1_LinkGift_RewardItemBase:ctor(ctorParam)
	self:__onInit()
	V4a1_LinkGift_RewardItemBase.super.ctor(self, ctorParam)
end

function V4a1_LinkGift_RewardItemBase:onDestroyView()
	V4a1_LinkGift_RewardItemBase.super.onDestroyView(self)
	self:__onDispose()
end

function V4a1_LinkGift_RewardItemBase:actId()
	local p = self:_assetGetParent()

	return p:actId()
end

function V4a1_LinkGift_RewardItemBase:isType101RewardCouldGetAnyOne()
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(self:actId())
end

function V4a1_LinkGift_RewardItemBase:isType101RewardGet()
	return ActivityType101Model.instance:isType101RewardGet(self:actId(), self._index)
end

function V4a1_LinkGift_RewardItemBase:isType101RewardCouldGet()
	return ActivityType101Model.instance:isType101RewardCouldGet(self:actId(), self._index)
end

function V4a1_LinkGift_RewardItemBase:getType101LoginCount()
	return ActivityType101Model.instance:getType101LoginCount(self:actId())
end

function V4a1_LinkGift_RewardItemBase:getNorSignActivityCo()
	return ActivityConfig.instance:getNorSignActivityCo(self:actId(), self._index)
end

function V4a1_LinkGift_RewardItemBase:sendGet101BonusRequest(cb, cbObj)
	return Activity101Rpc.instance:sendGet101BonusRequest(self:actId(), self._index, cb, cbObj)
end

function V4a1_LinkGift_RewardItemBase:claimAll(cb, cbObj)
	return ActivityType101Model.instance:claimAll(self:actId(), cb, cbObj)
end

function V4a1_LinkGift_RewardItemBase:isActOnLine()
	return ActivityModel.instance:isActOnLine(self:actId())
end

function V4a1_LinkGift_RewardItemBase:refreshRewardItem(item, itemCo)
	item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item:setCountFontSize(46)
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:isShowQuality(false)
	item:customOnClickCallback(function()
		if not self:isActOnLine() then
			GameFacade.showToast(ToastEnum.BattlePass)

			return
		end

		local couldGet = self:isType101RewardCouldGet()

		if couldGet then
			self:claimAll(self._onClaimAllCb, self)

			return
		end

		MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
	end)
end

return V4a1_LinkGift_RewardItemBase
