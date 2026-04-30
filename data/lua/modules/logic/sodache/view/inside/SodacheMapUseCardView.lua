-- chunkname: @modules/logic/sodache/view/inside/SodacheMapUseCardView.lua

module("modules.logic.sodache.view.inside.SodacheMapUseCardView", package.seeall)

local SodacheMapUseCardView = class("SodacheMapUseCardView", BaseView)

function SodacheMapUseCardView:onInitView()
	self._btncard = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_card")
	self._gocardcontainer = gohelper.findChild(self.viewGO, "Left/#btn_card/#go_cardcontainer")
	self._btnclosecardcontainer = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_card/#go_cardcontainer/#btn_click")
	self._txtcardNum = gohelper.findChildTextMesh(self.viewGO, "Left/#btn_card/#txt_level")
	self._cardgoitem = gohelper.findChild(self.viewGO, "Left/#btn_card/#go_cardcontainer/card/#scroll_card/viewport/content/carditem")
	self._gocontent = gohelper.findChild(self.viewGO, "Left/#btn_card/#go_cardcontainer/card/#scroll_card/viewport/content")
	self._goscroll = gohelper.findChild(self.viewGO, "Left/#btn_card/#go_cardcontainer/card/#scroll_card")
	self._godragItem = gohelper.findChild(self.viewGO, "Left/#btn_card/#go_cardcontainer/#go_dragitem")
	self._animMask = gohelper.findChildAnim(self.viewGO, "mask2")
	self._animCard = gohelper.findChildAnim(self.viewGO, "Left/#btn_card/#go_cardcontainer/card")
end

function SodacheMapUseCardView:addEvents()
	self._btncard:AddClickListener(self._onClickCard, self)
	self._btnclosecardcontainer:AddClickListener(self._onClickCardClose, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnBagUpdate, self._refreshCardNum, self)
	CommonDragHelper.instance:registerDragObj(self._gocontent, self._onBeginDrag, self._onDrag, self._onEndDrag, nil, self, nil, true)
end

function SodacheMapUseCardView:removeEvents()
	CommonDragHelper.instance:unregisterDragObj(self._gocontent)
	self._btncard:RemoveClickListener()
	self._btnclosecardcontainer:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnBagUpdate, self._refreshCardNum, self)
end

function SodacheMapUseCardView:onOpen()
	gohelper.setActive(self._gocardcontainer, false)

	self._dragItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._godragItem, SodacheMapCardUseItem)

	self._dragItem:setActive(false)
	self:_refreshCardNum()
end

function SodacheMapUseCardView:_onClickCard()
	if #self._canUseCards <= 0 then
		GameFacade.showToast(ToastEnum.SodacheToastId373004)

		return
	end

	gohelper.setActive(self._gocardcontainer, true)
	self:refreshCardList()
end

function SodacheMapUseCardView:_onClickCardClose()
	self._animCard:Play("close")
	UIBlockHelper.instance:startBlock("SodacheMapUseCardView_CardClose", 0.2)
	TaskDispatcher.runDelay(self._delayHideCardContainer, self, 0.2)
end

function SodacheMapUseCardView:_delayHideCardContainer()
	gohelper.setActive(self._gocardcontainer, false)
end

function SodacheMapUseCardView:_refreshCardNum()
	self._canUseCards = {}

	local items = SodacheUtil.getItemsByCardType(SodacheEnum.CardType.Adventure, SodacheEnum.BagType.Inside)

	for i, v in ipairs(items) do
		if v.itemCo.directUse == 1 then
			table.insert(self._canUseCards, v:toCardMo())
		end
	end

	self._txtcardNum.text = #self._canUseCards

	if self._gocardcontainer.activeSelf then
		if #self._canUseCards <= 0 then
			gohelper.setActive(self._gocardcontainer, false)
		else
			self:refreshCardList()
		end
	end
end

function SodacheMapUseCardView:refreshCardList()
	self._allCardGos = {}

	gohelper.CreateObjList(self, self._createCardItem, self._canUseCards, nil, self._cardgoitem, SodacheMapCardUseItem, nil, nil, 1)
end

function SodacheMapUseCardView:_createCardItem(obj, data, index)
	obj:updateMo(data)

	self._allCardGos[index] = obj
end

function SodacheMapUseCardView:_onBeginDrag(_, pointerEventData)
	ZProj.UGUIHelper.PassEvent(self._goscroll, pointerEventData, 4)

	for _, obj in pairs(self._allCardGos) do
		if gohelper.isMouseOverGo(obj.go) then
			self._curPressItem = obj

			break
		end
	end
end

function SodacheMapUseCardView:_onDrag(_, pointerEventData)
	local isFirst

	if not self._isDragOut then
		ZProj.UGUIHelper.PassEvent(self._goscroll, pointerEventData, 5)

		if self._curPressItem and pointerEventData.position.y - pointerEventData.pressPosition.y > 50 then
			self._isDragOut = true

			self._dragItem:updateMo(self._curPressItem.data)
			self._dragItem:setActive(true)
			self._curPressItem:setActive(false)

			isFirst = true

			ZProj.UGUIHelper.PassEvent(self._goscroll, pointerEventData, 6)
		end
	end

	if self._isDragOut then
		local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewGO.transform)
		local trans = self._dragItem.go.transform
		local curAnchorX, curAnchorY = recthelper.getAnchor(trans)

		if not isFirst and (math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10) then
			ZProj.TweenHelper.DOAnchorPos(trans, anchorPos.x, anchorPos.y, 0.2)
		else
			recthelper.setAnchor(trans, anchorPos.x, anchorPos.y)
		end

		local isCanUse = pointerEventData.position.y - pointerEventData.pressPosition.y > 111

		if isCanUse ~= self._isCanUse then
			self._isCanUse = isCanUse

			self._animMask:Play(self._isCanUse and "switch1" or "switch2")
		end
	end
end

function SodacheMapUseCardView:_onEndDrag(_, pointerEventData)
	if self._isDragOut then
		self._isDragOut = nil

		self._dragItem:setActive(false)
		self._curPressItem:setActive(true)

		if self._isCanUse then
			SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.UseCard, tostring(self._curPressItem.data.serverMo.configId))
		end
	else
		ZProj.UGUIHelper.PassEvent(self._goleftscroll, pointerEventData, 6)
	end

	self._curPressItem = nil

	if self._isCanUse then
		self._isCanUse = false

		self._animMask:Play("switch2")
	end
end

function SodacheMapUseCardView:onClose()
	TaskDispatcher.cancelTask(self._delayHideCardContainer, self)
end

return SodacheMapUseCardView
