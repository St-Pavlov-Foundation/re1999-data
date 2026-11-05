-- chunkname: @modules/logic/gm/view/fight/FightDataShowPanel.lua

module("modules.logic.gm.view.fight.FightDataShowPanel", package.seeall)

local FightDataShowPanel = class("FightDataShowPanel", BaseView)

function FightDataShowPanel:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._btnviewToggle = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bg/#btn_viewToggle")
	self._gocenter = gohelper.findChild(self.viewGO, "#go_bg/#go_center")
	self._txtcurType = gohelper.findChildText(self.viewGO, "#go_bg/#go_center/#txt_curType")
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bg/#go_center/#btn_change")
	self._txtchangeType = gohelper.findChildText(self.viewGO, "#go_bg/#go_center/#btn_change/image/#txt_changeType")
	self._godamage = gohelper.findChild(self.viewGO, "#go_bg/#go_center/#go_damage")
	self._txttotaldamage = gohelper.findChildText(self.viewGO, "#go_bg/#go_center/#go_damage/#txt_totaldamage")
	self._txtroundtotaldamage = gohelper.findChildText(self.viewGO, "#go_bg/#go_center/#go_damage/#txt_roundtotaldamage")
	self._goitem = gohelper.findChild(self.viewGO, "#go_bg/#go_center/#go_damage/Scroll View/Viewport/Content/#go_item")
	self._goplayer = gohelper.findChild(self.viewGO, "#go_bg/#go_center/#go_player")
	self._gocarditem = gohelper.findChild(self.viewGO, "#go_bg/#go_center/#go_player/Scroll View/Viewport/Content/#go_card_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightDataShowPanel:addEvents()
	self._btnviewToggle:AddClickListener(self._btnviewToggleOnClick, self)
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
end

function FightDataShowPanel:removeEvents()
	self._btnviewToggle:RemoveClickListener()
	self._btnchange:RemoveClickListener()
end

function FightDataShowPanel:_btnchangeOnClick()
	if self._curViewType == FightDataShowPanel.ViewType.Damage then
		self._curViewType = FightDataShowPanel.ViewType.PlayCard
	else
		self._curViewType = FightDataShowPanel.ViewType.Damage
	end

	self:_applyViewType()
end

FightDataShowPanel.ViewType = {
	Damage = 1,
	PlayCard = 2
}
FightDataShowPanel.ViewTypeName = {
	[FightDataShowPanel.ViewType.Damage] = "战斗统计（伤害）",
	[FightDataShowPanel.ViewType.PlayCard] = "战斗统计（出牌）"
}
FightDataShowPanel.BarColors = {
	{
		0.18,
		0.75,
		0.9
	},
	{
		0.97,
		0.76,
		0.27
	},
	{
		0.92,
		0.39,
		0.61
	},
	{
		0.61,
		0.78,
		0.35
	},
	{
		0.58,
		0.55,
		0.93
	},
	{
		0.98,
		0.6,
		0.34
	}
}
FightDataShowPanel.ExpandHeight = 340
FightDataShowPanel.CollapseHeight = 60

function FightDataShowPanel:_applyViewType()
	local isDamage = self._curViewType == FightDataShowPanel.ViewType.Damage

	gohelper.setActive(self._godamage, isDamage and not self._isCollapsed)
	gohelper.setActive(self._goplayer, not isDamage and not self._isCollapsed)

	self._txtcurType.text = FightDataShowPanel.ViewTypeName[self._curViewType]
	self._txtchangeType.text = isDamage and "切换出牌统计" or "切换伤害统计"

	if self._isCollapsed then
		return
	end

	if isDamage and self._damageDirty then
		self._damageDirty = false

		self:_refreshView()
	elseif not isDamage and self._playCardDirty then
		self._playCardDirty = false

		self:_rebuildRoundCardList()
	end
end

function FightDataShowPanel:_btnviewToggleOnClick()
	self._isCollapsed = not self._isCollapsed

	self:_applyFoldState()
end

function FightDataShowPanel:_applyFoldState()
	local height = self._isCollapsed and FightDataShowPanel.CollapseHeight or FightDataShowPanel.ExpandHeight
	local rt = self._gobg.transform

	rt.sizeDelta = Vector2(rt.sizeDelta.x, height)
	self._goToggleArrow.transform.localEulerAngles = Vector3(0, 0, self._isCollapsed and 180 or 0)

	self:_applyViewType()
end

function FightDataShowPanel:_editableInitView()
	self._itemList = self:getUserDataTb_()
	self._roundItemList = self:getUserDataTb_()
	self._goToggleArrow = gohelper.findChild(self._gobg, "#btn_viewToggle/image/label")

	gohelper.setActive(self._gocarditem, false)
end

function FightDataShowPanel:onUpdateParam()
	return
end

function FightDataShowPanel:onOpen()
	if not FightRealTimeDamageStatModel.instance:isEnabled() then
		self:closeThis()

		return
	end

	self:_buildItems()
	self:_refreshView()
	self:_initDrag()
	self:_rebuildRoundCardList()

	self._damageDirty = false
	self._playCardDirty = false
	self._curViewType = FightDataShowPanel.ViewType.Damage
	self._isCollapsed = true

	gohelper.setActive(self._gocenter, true)
	self:_applyFoldState()
	self:addEventCb(FightController.instance, FightEvent.FightRoundEnd, self._onFightRoundEnd, self)
	self:addEventCb(FightController.instance, FightEvent.OnRealTimeDamageChange, self._onRealTimeDamageChange, self)
	TaskDispatcher.runRepeat(self._checkInput, self, 0, -1)
end

function FightDataShowPanel:onClose()
	CommonDragHelper.instance:unregisterDragObj(self._gobg)
	self:removeEventCb(FightController.instance, FightEvent.FightRoundEnd, self._onFightRoundEnd, self)
	self:removeEventCb(FightController.instance, FightEvent.OnRealTimeDamageChange, self._onRealTimeDamageChange, self)
	TaskDispatcher.cancelTask(self._checkInput, self)
end

function FightDataShowPanel:_initDrag()
	if FightDataShowPanel.fixedLocalPosX then
		recthelper.setAnchor(self._gobg.transform, FightDataShowPanel.fixedLocalPosX, FightDataShowPanel.fixedLocalPosY)
	end

	self._openAnchorX, self._openAnchorY = recthelper.getAnchor(self._gobg.transform)

	CommonDragHelper.instance:registerDragObj(self._gobg, self._onDragBegin, self._onDragMove, self._onDragEnd, nil, self, nil, true)
end

function FightDataShowPanel:_getAnchorPivotOffset(trans)
	local width = trans.rect.width
	local height = trans.rect.height
	local pivotX, pivotY = trans.pivot.x, trans.pivot.y
	local anchorX = (trans.anchorMin.x + trans.anchorMax.x) * 0.5
	local anchorY = (trans.anchorMin.y + trans.anchorMax.y) * 0.5

	return (pivotX - anchorX) * width, (pivotY - anchorY) * height
end

function FightDataShowPanel:_onDragBegin(_, pointerEventData)
	local trans = self._gobg.transform
	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, trans.parent)
	local curX, curY = recthelper.getAnchor(trans)
	local offsetX, offsetY = self:_getAnchorPivotOffset(trans)

	self._dragOffsetX = curX + offsetX - anchorPos.x
	self._dragOffsetY = curY + offsetY - anchorPos.y
end

function FightDataShowPanel:_onDragMove(_, pointerEventData)
	local trans = self._gobg.transform
	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, trans.parent)
	local offsetX, offsetY = self:_getAnchorPivotOffset(trans)

	recthelper.setAnchor(trans, anchorPos.x + self._dragOffsetX - offsetX, anchorPos.y + self._dragOffsetY - offsetY)
end

function FightDataShowPanel:_onDragEnd()
	local x, y = recthelper.getAnchor(self._gobg.transform)

	FightDataShowPanel.fixedLocalPosX = x
	FightDataShowPanel.fixedLocalPosY = y
end

function FightDataShowPanel:_checkInput()
	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.F5) then
		self:_resetPosition()
	end
end

function FightDataShowPanel:_resetPosition()
	recthelper.setAnchor(self._gobg.transform, self._openAnchorX, self._openAnchorY)
end

function FightDataShowPanel:onDestroyView()
	self:_clearItems()
	self:_clearRoundCardList()
end

function FightDataShowPanel:_onFightRoundEnd()
	if self._isCollapsed or self._curViewType ~= FightDataShowPanel.ViewType.PlayCard then
		self._playCardDirty = true

		return
	end

	local round = FightRealTimeDamageStatModel.instance:getCurRoundId() - 1

	self:_buildRoundCardItem(round)
end

function FightDataShowPanel:_rebuildRoundCardList()
	self:_clearRoundCardList()

	local history = FightRealTimeDamageStatModel.instance:getAllRoundPlayRecords()
	local rounds = self:getUserDataTb_()

	for round in pairs(history) do
		table.insert(rounds, round)
	end

	table.sort(rounds)

	for _, round in ipairs(rounds) do
		self:_buildRoundCardItem(round)
	end
end

function FightDataShowPanel:_buildRoundCardItem(round)
	if gohelper.isNil(self._gocarditem) then
		return
	end

	local itemGO = gohelper.cloneInPlace(self._gocarditem, "roundPlay_" .. tostring(round))

	gohelper.setActive(itemGO, true)

	local txtRound = gohelper.findChildText(itemGO, "round")
	local cardParent = gohelper.findChild(itemGO, "Scroll View/Viewport/Content")
	local records = FightRealTimeDamageStatModel.instance:getRoundPlayRecords(round)

	txtRound.text = #records > 0 and "第" .. round + 1 .. "回合" or "第" .. round + 1 .. "回合 无出牌"

	table.insert(self._roundItemList, itemGO)

	if #records == 0 then
		return
	end

	local cardPrefab = self.viewContainer:getSetting().otherRes[1]

	if not cardPrefab then
		logError("FightDataShowPanel: otherRes[1] card prefab not configured")

		return
	end

	for _, record in ipairs(records) do
		local cardGO = self:getResInst(cardPrefab, cardParent)

		cardGO.transform.localScale = Vector3(0.5, 0.5, 0.5)

		local cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardGO, FightViewCardItem, FightEnum.CardShowType.Deck)

		cardItem:updateItem(record.uid, record.skillId, record)
	end
end

function FightDataShowPanel:_clearRoundCardList()
	for _, itemGO in ipairs(self._roundItemList or {}) do
		gohelper.destroy(itemGO)
	end

	self._roundItemList = self:getUserDataTb_()
end

function FightDataShowPanel:_buildItems()
	self:_clearItems()
	gohelper.setActive(self._goitem, false)

	local entityMgr = FightDataHelper.entityMgr

	if not entityMgr then
		return
	end

	for _, entityMO in ipairs(entityMgr:getSideList(FightEnum.TeamType.MySide, nil, true)) do
		self:_createDamageItem(entityMO)
	end
end

function FightDataShowPanel:_ensureItems()
	local entityMgr = FightDataHelper.entityMgr

	if not entityMgr then
		return
	end

	for _, entityMO in ipairs(entityMgr:getSideList(FightEnum.TeamType.MySide, nil, true)) do
		if not self:_getItemByEntityId(entityMO.uid) then
			self:_createDamageItem(entityMO)
		end
	end
end

function FightDataShowPanel:_getItemByEntityId(entityId)
	for _, item in ipairs(self._itemList) do
		if item.entityId == entityId then
			return item
		end
	end

	return nil
end

function FightDataShowPanel:_createDamageItem(entityMO)
	if entityMO.uid == "0" then
		return
	end

	local parentGO = self._goitem.transform.parent.gameObject
	local itemGO = gohelper.clone(self._goitem, parentGO, "damageItem_" .. tostring(entityMO.uid))

	gohelper.setActive(itemGO, true)

	local item = {
		go = itemGO,
		entityId = entityMO.uid,
		txtName = gohelper.findChildText(itemGO, "name"),
		imgTotalPercent = gohelper.findChildImage(itemGO, "img_total_percent"),
		txtRoundDamage = gohelper.findChildText(itemGO, "roundDamage"),
		txtPercent = gohelper.findChildText(itemGO, "percent")
	}

	item.imgTotalPercent.color = self:_getBarColor(#self._itemList + 1)
	item.txtName.text = self:_getEntityName(entityMO.uid)

	table.insert(self._itemList, item)
end

function FightDataShowPanel:_getBarColor(index)
	local colors = FightDataShowPanel.BarColors
	local color = colors[(index - 1) % #colors + 1]

	return Color(color[1], color[2], color[3], 1)
end

function FightDataShowPanel:_clearItems()
	for _, item in ipairs(self._itemList or {}) do
		gohelper.destroy(item.go)
	end

	self._itemList = {}
end

function FightDataShowPanel:_onRealTimeDamageChange(fromId, totalDamage, record)
	if self._isCollapsed or self._curViewType ~= FightDataShowPanel.ViewType.Damage then
		self._damageDirty = true

		return
	end

	self:_refreshView()
end

function FightDataShowPanel:_refreshView()
	local statModel = FightRealTimeDamageStatModel.instance

	if not statModel then
		return
	end

	self:_ensureItems()

	self._txttotaldamage.text = "总伤害：" .. tostring(statModel:getMySideTotalDamage())
	self._txtroundtotaldamage.text = statModel:getCurRoundId() .. "回合总伤害：" .. tostring(statModel:getMySideRoundTotalDamage())

	for _, item in ipairs(self._itemList) do
		local totalDamage = statModel:getMySideTotalDamageByEntityId(item.entityId)
		local percent = statModel:getMySideDamagePercent(item.entityId)

		item._percent = percent
		item.txtRoundDamage.text = tostring(totalDamage)
		item.txtPercent.text = string.format("%.1f%%", percent)
		item.imgTotalPercent.fillAmount = math.min(percent / 100, 1)
	end

	self:_sortItemsByPercent()
end

function FightDataShowPanel:_sortItemsByPercent()
	table.sort(self._itemList, function(a, b)
		local percentA = a._percent or 0
		local percentB = b._percent or 0

		if percentA == percentB then
			return a.entityId < b.entityId
		end

		return percentB < percentA
	end)

	for index, item in ipairs(self._itemList) do
		item.go.transform:SetSiblingIndex(index)
	end
end

function FightDataShowPanel:_getEntityName(entityId)
	local entityMgr = FightDataHelper.entityMgr
	local entityMO = entityMgr and entityMgr:getById(entityId)

	return entityMO:getEntityName()
end

return FightDataShowPanel
