-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_PageImpl.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_PageImpl", package.seeall)

local V4a1_LinkGift_PageImpl = class("V4a1_LinkGift_PageImpl", RougeSimpleItemBase)

function V4a1_LinkGift_PageImpl:ctor(...)
	self:__onInit()
	V4a1_LinkGift_PageImpl.super.ctor(self, ...)

	self._rewardItemList = {}
end

function V4a1_LinkGift_PageImpl:_editableInitView()
	V4a1_LinkGift_PageImpl.super._editableInitView(self)
	self:_editableInitView_layout()
end

function V4a1_LinkGift_PageImpl:_editableAddEvents()
	PayController.instance:registerCallback(PayEvent.PayInfoChanged, self._onPayInfoChanged, self)
end

function V4a1_LinkGift_PageImpl:_editableRemoveEvents()
	PayController.instance:unregisterCallback(PayEvent.PayInfoChanged, self._onPayInfoChanged, self)
end

function V4a1_LinkGift_PageImpl:_onPayInfoChanged()
	self:_refreshRewardItemList()
end

function V4a1_LinkGift_PageImpl:_editableInitView_layout()
	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("layout/pos%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:create_V4a1_LinkGift_LayoutRewardItem(go, i)

			table.insert(self._rewardItemList, item)
		end

		i = i + 1
	until isNil
end

function V4a1_LinkGift_PageImpl:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	V4a1_LinkGift_PageImpl.super.onDestroyView(self)
	self:__onDispose()
end

function V4a1_LinkGift_PageImpl:actId()
	local p = self:_assetGetParent()

	return p:actId()
end

function V4a1_LinkGift_PageImpl:actCO()
	local p = self:_assetGetParent()

	return p:actCO()
end

function V4a1_LinkGift_PageImpl:getLinkageActivityCO()
	local p = self:_assetGetParent()

	return p:getLinkageActivityCO()
end

function V4a1_LinkGift_PageImpl:getDataList()
	local p = self:_assetGetParent()

	return p:getDataList()
end

function V4a1_LinkGift_PageImpl:getTempDataList()
	local p = self:_assetGetParent()

	return p:getTempDataList()
end

function V4a1_LinkGift_PageImpl:selectedPage(index)
	local p = self:_assetGetParent()

	return p:selectedPage(index)
end

function V4a1_LinkGift_PageImpl:getDurationTimeStr()
	local CO = self:getLinkageActivityCO()

	return StoreController.instance:getRecommendStoreTime(CO)
end

function V4a1_LinkGift_PageImpl:jump()
	local CO = self:getLinkageActivityCO()

	GameFacade.jumpByAdditionParam(CO.systemJumpCode or "10173")
end

function V4a1_LinkGift_PageImpl:getLinkageActivityCO_item(index)
	local CO = self:getLinkageActivityCO()

	return CO["item" .. index]
end

function V4a1_LinkGift_PageImpl:getLinkageActivityCO_res_video(index)
	local CO = self:getLinkageActivityCO()

	return CO["res_video" .. index]
end

function V4a1_LinkGift_PageImpl:getLinkageActivityCO_desc(index)
	local CO = self:getLinkageActivityCO()

	return CO["desc" .. index]
end

function V4a1_LinkGift_PageImpl:getItemIconResUrl(index)
	local itemCO = self:getLinkageActivityCO_item(index)
	local c = self:_assetGetViewContainer()

	return c:getItemIconResUrl(c:itemCo2TIQ(itemCO))
end

function V4a1_LinkGift_PageImpl:getItemConfig(index)
	local itemCO = self:getLinkageActivityCO_item(index)
	local c = self:_assetGetViewContainer()

	return c:getItemConfig(c:itemCo2TIQ(itemCO))
end

function V4a1_LinkGift_PageImpl:itemCo2TIQ(index)
	local itemCO = self:getLinkageActivityCO_item(index)
	local c = self:_assetGetViewContainer()

	return c:itemCo2TIQ(itemCO)
end

function V4a1_LinkGift_PageImpl:setData(mo)
	V4a1_LinkGift_PageImpl.super.setData(self, mo)
	self:_refreshRewardItemList()
end

function V4a1_LinkGift_PageImpl:_refreshRewardItemList()
	local c = self:baseViewContainer()
	local productList = c:getChargeGoodsProductListByIndex(self:index())
	local maxCount = #productList

	for i = 1, maxCount do
		local item = self._rewardItemList[i]
		local itemCO = productList[i]

		if not item then
			if isDebugBuild then
				logError("[V4a1_LinkGift_PageImpl] item count out of range! index:" .. i)
			end

			break
		end

		item:onUpdateMO(itemCO)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._rewardItemList do
		local item = self._rewardItemList[i]

		item:setActive(false)
	end
end

function V4a1_LinkGift_PageImpl:_btnvideo1OnClick()
	self:selectedVideo(1, true)
end

function V4a1_LinkGift_PageImpl:_btnvideo2OnClick()
	self:selectedVideo(2, true)
end

function V4a1_LinkGift_PageImpl:create_V4a1_LinkGift_LayoutRewardItem(parentGO, index)
	local c = self:baseViewContainer()
	local sourceGO = c:rewarditemGoTemplate()

	if isDebugBuild then
		assert(not gohelper.isNil(sourceGO), "[V4a1_LinkGift_PageImpl] sourceGO is nil")
	end

	local go = gohelper.clone(sourceGO, parentGO, V4a1_LinkGift_LayoutRewardItem.__cname)
	local item = V4a1_LinkGift_LayoutRewardItem.New({
		parent = self,
		baseViewContainer = c
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V4a1_LinkGift_PageImpl:onLayoutRewardItemClick(item)
	local mo = item._mo

	if mo then
		local itemType = mo[1]
		local itemId = mo[2]
		local itemCO = ItemModel.instance:getItemConfig(itemType, itemId)
		local c = self:baseViewContainer()
		local desc = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge2_careerattributetipsview_attrbuff"), {
			itemId,
			itemCO.name
		})

		c:trackButtonClick(desc)
	end

	return true
end

function V4a1_LinkGift_PageImpl:isClaimedLayoutItem(item)
	local c = self:baseViewContainer()

	return c:isSoldOutByIndex(self:index())
end

function V4a1_LinkGift_PageImpl:videoFullScreenRootGo()
	local c = self:baseViewContainer()

	return c:videoFullScreenRootGo()
end

function V4a1_LinkGift_PageImpl:onPostSelectedPage(curPage, lastPage)
	return
end

function V4a1_LinkGift_PageImpl:onClickExitFullScreen()
	return
end

return V4a1_LinkGift_PageImpl
