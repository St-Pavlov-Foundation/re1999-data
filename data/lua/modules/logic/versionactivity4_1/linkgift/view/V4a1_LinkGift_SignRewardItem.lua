-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_SignRewardItem.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_SignRewardItem", package.seeall)

local V4a1_LinkGift_SignRewardItem = class("V4a1_LinkGift_SignRewardItem", V4a1_LinkGift_RewardItemBase)

function V4a1_LinkGift_SignRewardItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_icon/#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_LinkGift_SignRewardItem:addEvents()
	return
end

function V4a1_LinkGift_SignRewardItem:removeEvents()
	return
end

local split = string.split

function V4a1_LinkGift_SignRewardItem:_onBtnClick()
	self:_onClick()
end

function V4a1_LinkGift_SignRewardItem:ctor(...)
	V4a1_LinkGift_SignRewardItem.super.ctor(self, ...)
end

function V4a1_LinkGift_SignRewardItem:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_itemIcon")
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	V4a1_LinkGift_SignRewardItem.super.onDestroyView(self)
end

function V4a1_LinkGift_SignRewardItem:_editableAddEvents()
	self._btnClick:AddClickListener(self._onBtnClick, self)
end

function V4a1_LinkGift_SignRewardItem:_editableRemoveEvents()
	self._btnClick:RemoveClickListener()
end

function V4a1_LinkGift_SignRewardItem:_editableInitView()
	V4a1_LinkGift_SignRewardItem.super._editableInitView(self)

	self._btnClick = gohelper.findChildButton(self.viewGO, "")
	self._goCanGet = gohelper.findChild(self.viewGO, "go_canget")
	self._goGet = gohelper.findChild(self.viewGO, "go_receive") or gohelper.findChild(self.viewGO, "go_hasget")
	self.goTomorrow = gohelper.findChild(self.viewGO, "go_tomorrow")
	self.go_icon = gohelper.findChild(self.viewGO, "#go_icon")
	self._txtnum.text = ""

	self:setActive_goGet(false)
	self:setActive_goCanGet(false)
	self:setActive_goTmr(false)
end

function V4a1_LinkGift_SignRewardItem:setData(mo)
	V4a1_LinkGift_SignRewardItem.super.setData(self, mo)

	local isClaimed = self:isType101RewardGet()
	local hexColor = isClaimed and "#808080" or "#ffffff"
	local co = self:getNorSignActivityCo()
	local index = self._index
	local rewards = split(co.bonus, "|")
	local rewardCount = #rewards

	if isDebugBuild then
		assert(rewardCount == 1, string.format("[V4a1_LinkGift_SignRewardItem] rewardCount=%s", tostring(rewardCount)))
	end

	local itemCo = string.splitToNumber(rewards[1], "#")
	local itemType = itemCo[1]
	local itemId = itemCo[2]
	local itemCount = itemCo[3]
	local totalday = self:getType101LoginCount()
	local itemConfig, iconUrl = ItemModel.instance:getItemConfigAndIcon(itemType, itemId, true)

	mo._itemCo = itemCo

	self._simageicon:LoadImage(iconUrl)
	self:setActive_goGet(isClaimed)
	self:setActive_goCanGet(self:isType101RewardCouldGet())
	self:setActive_goTmr(totalday + 1 == index)
end

function V4a1_LinkGift_SignRewardItem:setActive_goCanGet(isActive)
	gohelper.setActive(self._goCanGet, isActive)
end

function V4a1_LinkGift_SignRewardItem:setActive_goGet(isActive)
	gohelper.setActive(self._goGet, isActive)
end

function V4a1_LinkGift_SignRewardItem:setActive_goTmr(isActive)
	gohelper.setActive(self._goTomorrow, isActive)
end

function V4a1_LinkGift_SignRewardItem:_onClaimAllCb()
	if not self:isType101RewardCouldGetAnyOne() then
		FrameTimerController.onDestroyViewMember(self, "_frameTimer")

		self._frameTimer = FrameTimerController.instance:register(function()
			if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomBlockPackageGetView) then
				FrameTimerController.onDestroyViewMember(self, "_frameTimer")

				local c = self:_assetGetViewContainer()

				c:switchPage(1)
			end
		end, nil, 6, 6)

		self._frameTimer:Start()
	end
end

function V4a1_LinkGift_SignRewardItem:_onClick()
	if not self:isActOnLine() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local couldGet = self:isType101RewardCouldGet()

	if couldGet then
		self:sendGet101BonusRequest(self._onClaimAllCb, self)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tags_2000013)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_25050217)

	local mo = self._mo
	local itemCo = mo._itemCo

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function V4a1_LinkGift_SignRewardItem:_OnOpenView(viewName)
	if viewName == ViewName.RoomBlockPackageGetView then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_building_collect_20234002)
	end
end

return V4a1_LinkGift_SignRewardItem
