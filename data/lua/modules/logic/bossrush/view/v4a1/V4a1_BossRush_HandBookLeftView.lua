-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_HandBookLeftView.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_HandBookLeftView", package.seeall)

local V4a1_BossRush_HandBookLeftView = class("V4a1_BossRush_HandBookLeftView", BaseView)

function V4a1_BossRush_HandBookLeftView:onInitView()
	self._goTypeItem = gohelper.findChild(self.viewGO, "scroll_Type/viewport/content/#go_TypeItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_BossRush_HandBookLeftView:addEvents()
	self:addEventCb(BossRushController.instance, BossRushEvent.onClaimRankBonus, self._refreshItemReddot, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self._refreshItemReddot, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128UnlockMonsterReply, self._refreshItemReddot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshReddot, self)
end

function V4a1_BossRush_HandBookLeftView:removeEvents()
	self:removeEventCb(BossRushController.instance, BossRushEvent.onClaimRankBonus, self._refreshItemReddot, self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self._refreshItemReddot, self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128UnlockMonsterReply, self._refreshItemReddot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshReddot, self)
end

function V4a1_BossRush_HandBookLeftView:_editableInitView()
	gohelper.setActive(self._goTypeItem, false)

	self._seasonItems = self:getUserDataTb_()

	local mos = V4a1_BossRushModel.instance:getSeasonMos()

	for i, mo in ipairs(mos) do
		local item = self:_getSeasonItem(i)

		item.txtname1.text = mo.co.name
		item.txtname2.text = mo.co.name
		item.txtnameen1.text = mo.co.name_en
		item.txtnameen2.text = mo.co.name_en
		item.season = mo.season

		gohelper.setActive(item.go, true)
	end

	self:_refreshReddot()
end

function V4a1_BossRush_HandBookLeftView:_refreshItemReddot()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.BossRushHankBookBossMainView
	})
end

function V4a1_BossRush_HandBookLeftView:_refreshReddot()
	for i, item in ipairs(self._seasonItems) do
		local isShow = V4a1_BossRushModel.instance:isShowSeasonHandBookRedddot(item.season)

		gohelper.setActive(item.goreddot, isShow)
	end
end

function V4a1_BossRush_HandBookLeftView:_getSeasonItem(index)
	local item = self._seasonItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goTypeItem)
		item.gounselect = gohelper.findChild(item.go, "go_unselected")
		item.txtname1 = gohelper.findChildText(item.gounselect, "txt_itemcn1")
		item.txtnameen1 = gohelper.findChildText(item.gounselect, "txt_itemen1")
		item.goselect = gohelper.findChild(item.go, "go_selected")
		item.txtname2 = gohelper.findChildText(item.goselect, "txt_itemcn2")
		item.txtnameen2 = gohelper.findChildText(item.goselect, "txt_itemen2")
		item.goreddot = gohelper.findChild(item.go, "#go_reddot")

		local goClick = gohelper.findChild(item.go, "clickArea")

		item.btnClick = gohelper.getClickWithDefaultAudio(goClick)

		item.btnClick:AddClickListener(self._btnClickSeason, self, index)

		self._seasonItems[index] = item
	end

	return item
end

function V4a1_BossRush_HandBookLeftView:onOpen()
	local handbookMo = self.viewParam.handbookMo
	local season = self.viewParam.season

	self:_onSelectSeason(season or 1, handbookMo)
end

function V4a1_BossRush_HandBookLeftView:_btnClickSeason(season)
	self:_onSelectSeason(season)
end

function V4a1_BossRush_HandBookLeftView:_onSelectSeason(season, handbookMo)
	if not handbookMo then
		local _, mo = V3a2_BossRush_HandBookListModel.instance:getCanClaimSeasonHandBookMo(season)

		if not mo then
			local moList = V3a2_BossRush_HandBookListModel.instance:getMoList(season)

			if moList and moList[1] then
				mo = moList[1].bossGroup[1]
			end
		end

		handbookMo = mo
	end

	if handbookMo then
		season = handbookMo.season

		V3a2_BossRush_HandBookListModel.instance:onSelect(handbookMo)
	end

	V3a2_BossRush_HandBookListModel.instance:onSelectSeason(season)

	for i, item in ipairs(self._seasonItems) do
		gohelper.setActive(item.gounselect, i ~= season)
		gohelper.setActive(item.goselect, i == season)
	end
end

function V4a1_BossRush_HandBookLeftView:onClose()
	return
end

function V4a1_BossRush_HandBookLeftView:onDestroyView()
	for i, item in ipairs(self._seasonItems) do
		item.btnClick:RemoveClickListener()
	end
end

return V4a1_BossRush_HandBookLeftView
