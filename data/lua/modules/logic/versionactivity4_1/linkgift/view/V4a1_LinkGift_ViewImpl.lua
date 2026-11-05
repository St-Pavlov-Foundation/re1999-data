-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_ViewImpl.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_ViewImpl", package.seeall)

local V4a1_LinkGift_ViewImpl = class("V4a1_LinkGift_ViewImpl", Activity101SignViewBase)
local kPageType = {
	Video = 1,
	HeadPortrait = 2
}

V4a1_LinkGift_ViewImpl.kPageType = kPageType

function V4a1_LinkGift_ViewImpl:ctor(...)
	V4a1_LinkGift_ViewImpl.super.ctor(self, ...)

	self._rewardItemList = {}
	self._tabItemList = {}
	self._pageItemList = {}
	self._curPageIndex = false
end

function V4a1_LinkGift_ViewImpl:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_flow")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(self, "_tabItemList")
	GameUtil.onDestroyViewMemberList(self, "_pageItemList")
	Activity101SignViewBase._internal_onDestroy(self)
end

function V4a1_LinkGift_ViewImpl:addEvents()
	V4a1_LinkGift_ViewImpl.super.addEvents(self)
	self._btnmaxsize:AddClickListener(self._btnmaxsizeOnClick, self)
	PayController.instance:registerCallback(PayEvent.PayInfoChanged, self._onPayInfoChanged, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function V4a1_LinkGift_ViewImpl:removeEvents()
	self._btnmaxsize:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	PayController.instance:unregisterCallback(PayEvent.PayInfoChanged, self._onPayInfoChanged, self)
	V4a1_LinkGift_ViewImpl.super.removeEvents(self)
end

function V4a1_LinkGift_ViewImpl:_onTouchScreen()
	GameUtil.onDestroyViewMember(self, "_flow")
end

function V4a1_LinkGift_ViewImpl:_onPayInfoChanged()
	self:_refreshBtnStatus()

	if self.viewContainer:isOnStoreState() then
		self:closeThis()

		return
	end

	if not self.viewContainer:isAllSoldOut() then
		self:_selectAnotherPage()
	end
end

function V4a1_LinkGift_ViewImpl:_getAnotherPage()
	if isDebugBuild then
		assert(self._curPageIndex <= 2)
	end

	return 3 - self._curPageIndex
end

function V4a1_LinkGift_ViewImpl:_selectAnotherPage(bNoAnim)
	self:selectedPage(self:_getAnotherPage(), bNoAnim)
end

function V4a1_LinkGift_ViewImpl:selectedPage(index, bNoAnim)
	if self._curPageIndex == index then
		return
	end

	local lastIndex = self._curPageIndex

	self._curPageIndex = index

	if not bNoAnim then
		if index == kPageType.Video then
			self:playAnimPageHeadToPageVideo()
		elseif index == kPageType.HeadPortrait then
			self:playAnimPageVideoToPageHead()
		end
	end

	self:onSelectedPage(index, lastIndex)
end

function V4a1_LinkGift_ViewImpl:getPage(index)
	return self._pageItemList[index]
end

function V4a1_LinkGift_ViewImpl:addPage(clsDefine, go, index)
	local item = clsDefine.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)
	item:setActive(false)
	table.insert(self._pageItemList, item)

	return item
end

function V4a1_LinkGift_ViewImpl:getLinkageActivityCO()
	return ActivityType101Config.instance:getLinkageActivityCO(self:actId())
end

function V4a1_LinkGift_ViewImpl:rewarditemGoTemplate()
	return self._gorewarditem
end

function V4a1_LinkGift_ViewImpl:videoFullScreenRootGo()
	return self._page1_switchGo
end

local CSAnimatorPlayer = SLFramework.AnimatorPlayer

function V4a1_LinkGift_ViewImpl:_editableInitView()
	self._txttime.text = ""
	self._txtprice.text = ""
	self._page1_switchGo = gohelper.findChild(self.viewGO, "root/page1_switch")
	self._btnmaxsize = gohelper.findChildButtonWithAudio(self.viewGO, "root/page1_switch/switch/#btn_maxsize")

	self:_editableInitView_signRewardItemList()
	self:_editableInitView_tabItemList()

	self._gorewarditem = gohelper.findChild(self.viewGO, "root/go_rewarditem")
	self._animatorPlayer = CSAnimatorPlayer.Get(self.viewGO)
	self._animator = self._animatorPlayer.animator

	self:addPage(V4a1_LinkGift_Page1, gohelper.findChild(self.viewGO, "root/page1"), kPageType.Video)
	self:addPage(V4a1_LinkGift_Page2, gohelper.findChild(self.viewGO, "root/page2"), kPageType.HeadPortrait)

	self._btngotoGo = self._btngoto.gameObject
	self._btnbuyGo = self._btnbuy.gameObject
	self._signRewardGo = gohelper.findChild(self.viewGO, "root/signReward")
	self._tab1Go = gohelper.findChild(self.viewGO, "root/panelbg/#btn_tab1")
	self._tab2Go = gohelper.findChild(self.viewGO, "root/panelbg/#btn_tab2")

	self:_setActive_signRewardGo(true)
	self:_setActive_tab1Go(true)
	self:_setActive_tab2Go(true)
end

function V4a1_LinkGift_ViewImpl:_setActive_signRewardGo(bActive)
	gohelper.setActive(self._signRewardGo, bActive)
end

function V4a1_LinkGift_ViewImpl:_setActive_tab1Go(bActive)
	gohelper.setActive(self._tab1Go, bActive)
end

function V4a1_LinkGift_ViewImpl:_setActive_tab2Go(bActive)
	gohelper.setActive(self._tab2Go, bActive)
end

function V4a1_LinkGift_ViewImpl:_refreshBtnStatus()
	local bSoldOut = self.viewContainer:isSoldOutByIndex(self._curPageIndex)

	gohelper.setActive(self._btngotoGo, false)
	gohelper.setActive(self._btnbuyGo, false)
	gohelper.setActive(self._goowned, bSoldOut)

	if self.viewContainer:isOnPatfaceState() then
		gohelper.setActive(self._btngotoGo, not bSoldOut)
	else
		gohelper.setActive(self._btnbuyGo, not bSoldOut)
	end

	self:_refreshPrice()
end

function V4a1_LinkGift_ViewImpl:_playAnim(animName, cb, cbObj)
	self._animatorPlayer:Play(animName, cb or function()
		return
	end, cbObj or self)
end

function V4a1_LinkGift_ViewImpl:playAnimOpen(cb, cbObj)
	self:_playAnim(UIAnimationName.Open, cb, cbObj)
end

function V4a1_LinkGift_ViewImpl:playAnimClose(cb, cbObj)
	self:_playAnim(UIAnimationName.Close, cb, cbObj)
end

function V4a1_LinkGift_ViewImpl:playAnimPageVideoToPageHead()
	self:_playAnim("switch2")
end

function V4a1_LinkGift_ViewImpl:playAnimPageHeadToPageVideo()
	self:_playAnim("switch1")
end

function V4a1_LinkGift_ViewImpl:_editableInitView_signRewardItemList()
	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("root/signReward/day_%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a1_LinkGift_SignRewardItem(go, i)

			table.insert(self._rewardItemList, item)
		end

		i = i + 1
	until isNil
end

function V4a1_LinkGift_ViewImpl:_create_V4a1_LinkGift_SignRewardItem(srcGo, index)
	local item = V4a1_LinkGift_SignRewardItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function V4a1_LinkGift_ViewImpl:_editableInitView_tabItemList()
	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("root/panelbg/#btn_tab%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a1_LinkGift_TabItem(go, i)

			table.insert(self._tabItemList, item)
		end

		i = i + 1
	until isNil
end

function V4a1_LinkGift_ViewImpl:_create_V4a1_LinkGift_TabItem(srcGo, index)
	local item = V4a1_LinkGift_TabItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function V4a1_LinkGift_ViewImpl:onClickTabItem(item)
	GameUtil.onDestroyViewMember(self, "_flow")

	local pageIndex = item:index()

	if pageIndex == self._curPageIndex then
		return
	end

	self:selectedPage(pageIndex)
	self.viewContainer:trackSwitchPageOnClick(pageIndex)
end

function V4a1_LinkGift_ViewImpl:selectedPage_Video(bNoAnim)
	self:selectedPage(kPageType.Video, bNoAnim)
end

function V4a1_LinkGift_ViewImpl:selectedPage_HeadPortrait(bNoAnim)
	self:selectedPage(kPageType.HeadPortrait, bNoAnim)
end

function V4a1_LinkGift_ViewImpl:_btncloseOnClick()
	self:closeThis()
end

function V4a1_LinkGift_ViewImpl:onClickModalMask()
	if self.viewContainer:bFullScreen() then
		for _, item in ipairs(self._pageItemList) do
			item:onClickExitFullScreen()
		end

		return
	end

	self:closeThis()
end

function V4a1_LinkGift_ViewImpl:_btntipsOnClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.V3a9_BDuckLinkageTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.V3a9_BDuckLinkageDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

function V4a1_LinkGift_ViewImpl:_btngotoOnClick()
	local lua_store_charge_goods_id = self.viewContainer:getChargeIdByIndex(self._curPageIndex)
	local storeGoodsMo = self.viewContainer:getGoodsMO(lua_store_charge_goods_id)

	StoreController.instance:openPackageStoreGoodsView(storeGoodsMo)
end

function V4a1_LinkGift_ViewImpl:_btnbuyOnClick()
	self.viewContainer:startPayByIndex(self._curPageIndex)
end

function V4a1_LinkGift_ViewImpl:onStart()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.ui_wulu_aizila_level_open)
	GameUtil.onDestroyViewMember(self, "_flow")

	local selectPageIndex = self.viewParam and self.viewParam.selectPageIndex

	if self.viewContainer:isOnStoreState() then
		self:_setActive_signRewardGo(false)
		self:_setActive_tab1Go(false)
		self:_setActive_tab2Go(false)
	end

	self:_selectPageOnStart(selectPageIndex)
	self:playAnimOpen(self._onAnimDone, self)
end

function V4a1_LinkGift_ViewImpl:_onAnimDone()
	if self.viewContainer:isOnPatfaceState() and not self.viewContainer:isAllSoldOut() and not self.viewContainer:getSavedPlayedAnimOpen() then
		self._flow = V4a1_LinkGift_ViewOpenFlow.New()

		self._flow:start(self)

		return
	end
end

function V4a1_LinkGift_ViewImpl:_selectPageOnStart(optPageIndex)
	if optPageIndex then
		self:selectedPage(optPageIndex, true)

		return
	end

	if self.viewContainer:isSoldOutByIndex(kPageType.HeadPortrait) or not self.viewContainer:isSoldOutByIndex(kPageType.Video) then
		self:selectedPage_Video(true)
	else
		self:selectedPage_HeadPortrait(true)
	end
end

function V4a1_LinkGift_ViewImpl:onSelectedPage(index, lastIndex)
	local curItem = self:getPage(index)
	local lastItem

	if lastIndex then
		lastItem = self:getPage(lastIndex)

		lastItem:setActive(false)
	end

	curItem:setActive(true)

	for _, item in ipairs(self._pageItemList) do
		item:onPostSelectedPage(curItem, lastItem)
	end

	self:_refreshTabItemList()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper3)
end

function V4a1_LinkGift_ViewImpl:_refreshTabItemList()
	for i, item in ipairs(self._tabItemList) do
		item:onSelect(i == self._curPageIndex)
	end

	self:_refreshBtnStatus()
end

function V4a1_LinkGift_ViewImpl:onRefresh()
	self:_refreshTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refreshRewardItemList()

	for _, item in ipairs(self._pageItemList) do
		item:onUpdateMO()
	end
end

function V4a1_LinkGift_ViewImpl:_refreshPrice()
	local lua_store_charge_goods_id = self.viewContainer:getChargeIdByIndex(self._curPageIndex)

	self._txtprice.text = PayModel.instance:getProductPrice(lua_store_charge_goods_id)
end

function V4a1_LinkGift_ViewImpl:_refreshTimeTick()
	self._txttime.text = self:getRemainTimeStr()
end

function V4a1_LinkGift_ViewImpl:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V4a1_LinkGift_ViewImpl:_refreshRewardItemList()
	local dataList = self:getDataList()
	local maxCount = #dataList

	for i = 1, maxCount do
		local item = self._rewardItemList[i]

		if not item then
			if isDebugBuild then
				logError("reward item count out of range! index:" .. i)
			end

			break
		end

		local mo = dataList[i]

		item:onUpdateMO(mo)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._rewardItemList do
		local item = self._rewardItemList[i]

		item:setActive(false)
	end
end

function V4a1_LinkGift_ViewImpl:curPageIndex()
	return self._curPageIndex
end

function V4a1_LinkGift_ViewImpl:getCurPage()
	return self:getPage(self._curPageIndex)
end

function V4a1_LinkGift_ViewImpl:_btnmaxsizeOnClick()
	local item = self:getCurPage()

	if item then
		item:onClickExitFullScreen()
	end
end

return V4a1_LinkGift_ViewImpl
