-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_HandBookView.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_HandBookView", package.seeall)

local V4a1_BossRush_HandBookView = class("V4a1_BossRush_HandBookView", BaseView)

function V4a1_BossRush_HandBookView:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._scrollboss = gohelper.findChildScrollRect(self.viewGO, "boss/#scroll_boss")
	self._gogroup = gohelper.findChild(self.viewGO, "boss/#scroll_boss/Viewport/Content/#go_group")
	self._gorank = gohelper.findChild(self.viewGO, "#go_rank")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_BossRush_HandBookView:addEvents()
	self:addEventCb(BossRushController.instance, BossRushEvent.V3a2_BossRush_HandBook_SelectMonster, self._onSelectMonster, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onSelectHandBookSeason, self._onSelectHandBookSeason, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128UnlockMonsterReply, self._onReceiveAct128UnlockMonsterReply, self)
end

function V4a1_BossRush_HandBookView:removeEvents()
	self:removeEventCb(BossRushController.instance, BossRushEvent.V3a2_BossRush_HandBook_SelectMonster, self._onSelectMonster, self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.onSelectHandBookSeason, self._onSelectHandBookSeason, self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128UnlockMonsterReply, self._onReceiveAct128UnlockMonsterReply, self)
end

function V4a1_BossRush_HandBookView:_onSelectMonster()
	local mo = V3a2_BossRush_HandBookListModel.instance:getSelectMo()

	if self._selectBossType == mo.config.type then
		return
	end

	self._selectBossType = mo.config.type

	local animName = self._isOpenView and V3a2BossRushEnum.AnimName.Open or V3a2BossRushEnum.AnimName.Switch

	self._anim:Play(animName, 0, 0)

	if self._isOpenView then
		self._isOpenView = nil
	end

	TaskDispatcher.cancelTask(self._onSelectMonsterCB, self)
	TaskDispatcher.runDelay(self._onSelectMonsterCB, self, 0.16)
end

function V4a1_BossRush_HandBookView:_onSelectMonsterCB()
	local mo = V3a2_BossRush_HandBookListModel.instance:getSelectMo()

	BossRushController.instance:dispatchEvent(BossRushEvent.V3a2_BossRush_HandBook_SelectMonsterCB, mo)
end

function V4a1_BossRush_HandBookView:_onSelectHandBookSeason(season)
	V3a2_BossRush_HandBookListModel.instance:setMoList()
	self:_refreshBossGroups()
	self:_onSelectMonsterCB()
	self:_refreshRankBtn(season)
end

function V4a1_BossRush_HandBookView:_onReceiveAct128UnlockMonsterReply(msg)
	local moList = V3a2_BossRush_HandBookListModel.instance:getList()

	if moList then
		for i in ipairs(moList) do
			local item = self:_getBossGroupItem(i)

			item:checkUnlock(msg.targetActivityId, msg.bossId)
		end
	end
end

function V4a1_BossRush_HandBookView:_editableInitView()
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._bossGroupItems = self:getUserDataTb_()
	self._rankBtnItems = self:getUserDataTb_()

	gohelper.setActive(self._gogroup, false)
end

function V4a1_BossRush_HandBookView:playRankBtnAnim()
	TaskDispatcher.cancelTask(self._playRankBtnAnimCB, self)
	TaskDispatcher.runDelay(self._playRankBtnAnimCB, self, 0.1)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.BossRushHankBookBoss
	})
end

function V4a1_BossRush_HandBookView:_playRankBtnAnimCB()
	if self._rankBtn then
		self._rankBtn:playAnim()
	end
end

function V4a1_BossRush_HandBookView:onOpen()
	local handbookMo = self.viewParam.handbookMo

	self._isOpenView = true

	if handbookMo and self.viewParam.isEnterLevelReviewView then
		V4a1_BossRushController.instance:openLevelReviewView(handbookMo)
	end
end

function V4a1_BossRush_HandBookView:_refreshRankBtn(season)
	local item, path = self:_getRankItem(season)

	for i, v in pairs(self._rankBtnItems) do
		gohelper.setActive(v.viewGO, i == path)
	end

	self._rankBtn = item

	item:refreshUI()
end

function V4a1_BossRush_HandBookView:_getRankItem(season)
	local seasonParam = V4a1BossRushEnum.SeasonParam[season]
	local path = seasonParam.RankBtnPath
	local item = self._rankBtnItems[path]

	if not item then
		local go = self.viewContainer:getResInst(path, self._gorank, season)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a2_BossRush_RankBtn, season)
		self._rankBtnItems[path] = item
	end

	return item, path
end

function V4a1_BossRush_HandBookView:onClose()
	return
end

function V4a1_BossRush_HandBookView:onDestroyView()
	TaskDispatcher.cancelTask(self._onSelectMonsterCB, self)
	TaskDispatcher.cancelTask(self._playRankBtnAnimCB, self)
	TaskDispatcher.cancelTask(self._refreshScroll, self)
end

function V4a1_BossRush_HandBookView:_refreshBossGroups()
	local moList = V3a2_BossRush_HandBookListModel.instance:getList()
	local handbookMo = V3a2_BossRush_HandBookListModel.instance:getSelectMo()

	if not handbookMo then
		local season = V3a2_BossRush_HandBookListModel.instance:getSelectSeason()
		local _, mo = V3a2_BossRush_HandBookListModel.instance:getCanClaimSeasonHandBookMo(season)

		handbookMo = mo
	end

	if moList then
		for i, mo in ipairs(moList) do
			local item = self:_getBossGroupItem(i)

			item:onUpdateMO(mo)

			if handbookMo.config.minType == mo.config.mintype then
				self._claimGroupIndex = i or 1
			end
		end
	end

	local count = moList and #moList or 0

	for i, item in ipairs(self._bossGroupItems) do
		gohelper.setActive(item.viewGO, i <= count)
	end

	self._moList = moList

	TaskDispatcher.cancelTask(self._refreshScroll, self)
	TaskDispatcher.runDelay(self._refreshScroll, self, 0)
end

function V4a1_BossRush_HandBookView:_refreshScroll()
	local vnp = 0
	local itemCount = self._moList and #self._moList or 0

	if itemCount > 0 and self._claimGroupIndex > 1 then
		local lastItem = self:_getBossGroupItem(itemCount)
		local lastItemHeight = recthelper.getHeight(lastItem.viewGO.transform)
		local totalHeight = recthelper.getHeight(self._scrollboss.content.transform) - lastItemHeight
		local claimHeight = 0
		local item = self._bossGroupItems[self._claimGroupIndex]

		if item then
			claimHeight = -recthelper.getAnchorY(item.viewGO.transform)
			vnp = claimHeight / totalHeight
		end
	end

	self._scrollboss.verticalNormalizedPosition = 1 - vnp
end

function V4a1_BossRush_HandBookView:_getBossGroupItem(index)
	local item = self._bossGroupItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gogroup)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a5_BossRush_HandBookGroupItem)
		item.viewContainer = self.viewContainer
		self._bossGroupItems[index] = item
	end

	return item
end

return V4a1_BossRush_HandBookView
