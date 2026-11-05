-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_BaseViewContainer.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_BaseViewContainer", package.seeall)

local V4a1_LinkGift_BaseViewContainer = class("V4a1_LinkGift_BaseViewContainer", BaseViewContainer)

function V4a1_LinkGift_BaseViewContainer:ctor(...)
	V4a1_LinkGift_BaseViewContainer.super.ctor(self, ...)

	self._bFullScreen = nil
end

local kPrefix = "LinkGift|"

function V4a1_LinkGift_BaseViewContainer:getPrefsKeyPrefix()
	return kPrefix .. tostring(self:actId())
end

function V4a1_LinkGift_BaseViewContainer:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function V4a1_LinkGift_BaseViewContainer:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

function V4a1_LinkGift_BaseViewContainer:onContainerDestroy()
	self._lua_store_charge_goods_ids = nil
	self._bFullScreen = nil

	V4a1_LinkGift_BaseViewContainer.super.onContainerDestroy(self)
end

function V4a1_LinkGift_BaseViewContainer:playCloseTransition()
	local viewObj = self:view()

	if viewObj then
		viewObj:playAnimClose(self.onPlayCloseTransitionFinish, self)
	else
		self:onPlayCloseTransitionFinish()
	end
end

function V4a1_LinkGift_BaseViewContainer:_getStoreChargeGoodsIdList()
	if not self._lua_store_charge_goods_ids then
		local activityCo = self:getActivityCo()

		self._lua_store_charge_goods_ids = string.splitToNumber(activityCo.param, "#")

		if isDebugBuild and (not self._lua_store_charge_goods_ids or #self._lua_store_charge_goods_ids ~= 2) then
			logError("[V4a1_LinkGift_BaseViewContainer] invalid actId=" .. tostring(self:actId()) .. ", ..  activityCo.param=" .. tostring(activityCo.param))
		end
	end

	return self._lua_store_charge_goods_ids
end

function V4a1_LinkGift_BaseViewContainer:buildViews()
	assert(false, "please override this function")
end

function V4a1_LinkGift_BaseViewContainer:view()
	assert(false, "please override this function")
end

function V4a1_LinkGift_BaseViewContainer:switchPage(pageIndex)
	local viewObj = self:view()

	viewObj:selectedPage(pageIndex)
end

function V4a1_LinkGift_BaseViewContainer:itemCo2TIQ(itemCo)
	if string.nilorempty(itemCo) then
		return
	end

	local strList = string.split(itemCo, "#")

	assert(#strList >= 2, "[V4a1_LinkGift_BaseViewContainer] invalid itemCo=" .. tostring(itemCo))

	local list = string.split(itemCo, "#")
	local type = tonumber(list[1])
	local id = tonumber(list[2])
	local quantity = tonumber(list[3])

	return type, id, quantity
end

function V4a1_LinkGift_BaseViewContainer:getItemConfig(materialType, id)
	local func = ItemConfigGetDefine.instance:getItemConfigFunc(materialType)

	assert(func, "[V4a1_LinkGift_BaseViewContainer] ItemIconGetDefine-getItemConfigFunc unsupported materialType: " .. tostring(materialType))

	local config = func(id)

	assert(config, "[V4a1_LinkGift_BaseViewContainer] item config not found materialType=" .. tostring(materialType) .. " id=" .. tostring(id))

	return config
end

function V4a1_LinkGift_BaseViewContainer:getItemIconResUrl(materialType, id)
	if not materialType or not id then
		return ""
	end

	local func = ItemIconGetDefine.instance:getItemIconFunc(materialType)

	assert(func, "[V4a1_LinkGift_BaseViewContainer] ItemIconGetDefine-getItemIconFunc unsupported materialType: " .. tostring(materialType))

	local config = self:getItemConfig(materialType, id)

	return func(config) or ""
end

function V4a1_LinkGift_BaseViewContainer:getAssetItem_VideoLoadingPng()
	local otherRes = self._viewSetting.otherRes

	return self:getRes(otherRes[1])
end

function V4a1_LinkGift_BaseViewContainer:getChargeGoodsConfigByIndex(index)
	return self:getChargeGoodsConfig(self:getChargeIdByIndex(index))
end

function V4a1_LinkGift_BaseViewContainer:getChargeGoodsConfig(optLua_store_charge_goods_id)
	return StoreConfig.instance:getChargeGoodsConfig(optLua_store_charge_goods_id or self:getChargeIdByIndex())
end

function V4a1_LinkGift_BaseViewContainer:getChargeGoodsProductListByIndex(index)
	return self:getChargeGoodsProductList(self:getChargeIdByIndex(index))
end

function V4a1_LinkGift_BaseViewContainer:getChargeGoodsProductList(optLua_store_charge_goods_id)
	local chargeGoodsConfig = self:getChargeGoodsConfig(optLua_store_charge_goods_id)

	if not chargeGoodsConfig then
		return {}
	end

	return GameUtil.splitString2(chargeGoodsConfig.product, true) or {}
end

function V4a1_LinkGift_BaseViewContainer:getChargeIdByIndex(optIndex)
	return self:getStoreChargeGoodsIdByIndex(optIndex or self:curPageIndex())
end

function V4a1_LinkGift_BaseViewContainer:isPanelView()
	return ViewMgr.instance:isOpen(ViewName.LinkGift_PanelView)
end

function V4a1_LinkGift_BaseViewContainer:isFullView()
	return not self:isPanelView()
end

function V4a1_LinkGift_BaseViewContainer:isOnPatfaceState()
	return not ViewMgr.instance:isOpen(ViewName.V4a1_Library_MainView) and not ViewMgr.instance:isOpen(ViewName.StoreView) and ViewMgr.instance:isOpen(ViewName.LinkGift_PanelView)
end

function V4a1_LinkGift_BaseViewContainer:isOnStoreState()
	return not ViewMgr.instance:isOpen(ViewName.V4a1_Library_MainView) and ViewMgr.instance:isOpen(ViewName.StoreView)
end

function V4a1_LinkGift_BaseViewContainer:isSoldOutByIndex(index)
	return self:isSoldOut(self:getChargeIdByIndex(index))
end

function V4a1_LinkGift_BaseViewContainer:isSoldOut(optLua_store_charge_goods_id)
	local goodsMO = StoreModel.instance:getGoodsMO(optLua_store_charge_goods_id or self:getChargeIdByIndex())

	if not goodsMO then
		return false
	end

	return goodsMO:isSoldOut()
end

function V4a1_LinkGift_BaseViewContainer:getGoodsMO(lua_store_charge_goods_id)
	return StoreModel.instance:getGoodsMO(lua_store_charge_goods_id)
end

function V4a1_LinkGift_BaseViewContainer:startPay(lua_store_charge_goods_id)
	local storeGoodsMo = self:getGoodsMO(lua_store_charge_goods_id)

	if not storeGoodsMo then
		return
	end

	local isSoldOut = storeGoodsMo:isSoldOut()

	if isSoldOut then
		return
	end

	PayController.instance:startPay(lua_store_charge_goods_id)
end

function V4a1_LinkGift_BaseViewContainer:startPayByIndex(index)
	self:startPay(self:getChargeIdByIndex(index))
end

function V4a1_LinkGift_BaseViewContainer:actId()
	if self.viewParam then
		return self.viewParam.actId
	end

	if self:view() then
		return self:view():actId()
	end
end

function V4a1_LinkGift_BaseViewContainer:curPageIndex()
	if self:view() then
		return self:view():curPageIndex()
	end
end

function V4a1_LinkGift_BaseViewContainer:rewarditemGoTemplate()
	if self:view() then
		return self:view():rewarditemGoTemplate()
	end
end

function V4a1_LinkGift_BaseViewContainer:videoFullScreenRootGo()
	if self:view() then
		return self:view():videoFullScreenRootGo()
	end
end

function V4a1_LinkGift_BaseViewContainer:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

function V4a1_LinkGift_BaseViewContainer:getStoreChargeGoodsIdByIndex(index)
	local list = self:_getStoreChargeGoodsIdList()

	return list[index] or 0
end

function V4a1_LinkGift_BaseViewContainer:isAllSoldOut()
	return StoreModel.instance:isAllSoldOut(self:_getStoreChargeGoodsIdList())
end

local kAnimFirst = "AnimFirst|"

function V4a1_LinkGift_BaseViewContainer:_getPrefsKeyAnimFirst()
	return self:getPrefsKeyPrefix() .. kAnimFirst
end

function V4a1_LinkGift_BaseViewContainer:savePlayedAnimOpen(bPlayed)
	if self:getSavedPlayedAnimOpen() == bPlayed then
		return
	end

	local key = self:_getPrefsKeyAnimFirst()

	self:saveInt(key, bPlayed and 1 or 0)
end

function V4a1_LinkGift_BaseViewContainer:getSavedPlayedAnimOpen()
	local key = self:_getPrefsKeyAnimFirst()
	local value = self:getInt(key, 0)

	return value ~= 0
end

function V4a1_LinkGift_BaseViewContainer:getPlayNextVideoSec()
	return ActivityType101Config.instance:getConstAsNum(40100, 2)
end

function V4a1_LinkGift_BaseViewContainer:getAutoSwitchVideoCDSec()
	return ActivityType101Config.instance:getConstAsNum(40101, 2)
end

function V4a1_LinkGift_BaseViewContainer:setFullScreenSlient(bFullScreen)
	self._bFullScreen = bFullScreen
end

function V4a1_LinkGift_BaseViewContainer:bFullScreen()
	return self._bFullScreen
end

function V4a1_LinkGift_BaseViewContainer:trackButtonClick(desc)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = self.viewName,
		[StatEnum.EventProperties.ButtonName] = tostring(desc or "")
	})
end

function V4a1_LinkGift_BaseViewContainer:trackFullScreenOnClick()
	self:trackButtonClick("video_fullscreen")
end

function V4a1_LinkGift_BaseViewContainer:trackSwitchVideoOnClick(videoIndex)
	self:trackButtonClick("switch_videotab" .. tostring(videoIndex))
end

function V4a1_LinkGift_BaseViewContainer:trackSwitchPageOnClick(pageIndex)
	self:trackButtonClick("switch_goodstab" .. tostring(pageIndex))
end

return V4a1_LinkGift_BaseViewContainer
