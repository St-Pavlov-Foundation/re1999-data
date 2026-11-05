-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorEventSelectView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorEventSelectView", package.seeall)

local ArcadeSurvivorEventSelectView = class("ArcadeSurvivorEventSelectView", BaseView)

function ArcadeSurvivorEventSelectView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "root")
	self._gowishlist = gohelper.findChild(self.viewGO, "root/#go_wishlist")
	self._gowishItem = gohelper.findChild(self.viewGO, "root/#go_wishlist/#go_wishItem")
	self._btnchoose = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "root/btn/#btn_choose")
	self._btnbattlefield = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.viewGO, "root/#btn_battlefield")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorEventSelectView:addEvents()
	self._btnchoose:AddClickListener(self._btnchooseOnClick, self)
	self._btnbattlefield:AddClickListener(self._btnbattlefieldOnClick, self)
	NavigateMgr.instance:addEscape(self.viewName, self._onBtnEsc, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.BackToShopOrEventView, self._onBtnEsc, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.TipViewCloseBlurRefresh, self._onTipViewCloseBlurRefresh, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeSurvivorEventSelectView:removeEvents()
	self._btnchoose:RemoveClickListener()
	self._btnbattlefield:RemoveClickListener()
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.BackToShopOrEventView, self._onBtnEsc, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.TipViewCloseBlurRefresh, self._onTipViewCloseBlurRefresh, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeSurvivorEventSelectView:_onTipViewCloseBlurRefresh(isBeforeClose)
	if not self._viewBattleField then
		return
	end

	if isBeforeClose then
		PostProcessingMgr.instance:setViewBlur(self.viewName, nil)
	else
		PostProcessingMgr.instance:setViewBlur(self.viewName, 0)
	end
end

function ArcadeSurvivorEventSelectView:_btnclickOnClick(index)
	local eventItem = self._eventItemList[index]
	local selectedEventId = eventItem and eventItem.eventId

	if not selectedEventId or self._selectedIndex == index then
		return
	end

	self._selectedIndex = index

	self:refreshEventSelected()
end

function ArcadeSurvivorEventSelectView:_btnchooseOnClick()
	local eventItem = self._eventItemList[self._selectedIndex]
	local eventId = eventItem and eventItem.eventId

	if not eventId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.play_ui_atlantis_event_choose)
	UIBlockMgr.instance:startBlock(ArcadeSurvivorEnum.BlockKey.SelectedEvent)

	self._selectEventId = eventId

	eventItem.animPlayer:Play(UIAnimationName.Close, self._afterItemClose, self)
	self._btnanimator:Play(UIAnimationName.Click, 0, 0)
end

function ArcadeSurvivorEventSelectView:_afterItemClose()
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.SelectedEvent)
	ArcadeSurvivorGameController.instance:selectStageEvent(self._selectEventId)
	self:closeThis()
end

function ArcadeSurvivorEventSelectView:_btnbattlefieldOnClick()
	if self._viewBattleField then
		return
	end

	self._viewBattleField = true

	gohelper.setActive(self._goRoot, false)
	PostProcessingMgr.instance:setViewBlur(self.viewName, 0)
end

function ArcadeSurvivorEventSelectView:_onResetGame()
	self:closeThis()
end

function ArcadeSurvivorEventSelectView:_onBtnEsc()
	if self._viewBattleField then
		self._viewBattleField = false

		PostProcessingMgr.instance:setViewBlur(self.viewName, nil)
		ArcadeSurvivorController.instance:closeTipView()
		gohelper.setActive(self._goRoot, true)
		self._animatorPlayer:Play(UIAnimationName.Open, nil, nil)
	else
		self:_btnbattlefieldOnClick()
	end
end

function ArcadeSurvivorEventSelectView:_onCloseView(viewName)
	if viewName == ViewName.ArcadeSurvivorGameView then
		self:closeThis()
	end
end

function ArcadeSurvivorEventSelectView:_editableInitView()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._btnanimator = self._btnchoose:GetComponent(gohelper.Type_Animator)
	self._selectedIndex = nil
	self._eventItemList = {}

	local usedEventIdList = {}
	local eventIdPool = {}
	local stageId = ArcadeSurvivorGameModel.instance:getCurStageId()
	local stageEventPool = ArcadeSurvivorConfig.instance:getStageEventPool(stageId)
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	for _, eventId in ipairs(stageEventPool) do
		local skillId = ArcadeSurvivorConfig.instance:getEventNeedSkillId(eventId)

		if not skillId or skillId == 0 or characterMO:hasSkill(skillId) then
			eventIdPool[#eventIdPool + 1] = eventId
		end
	end

	local indexList = ArcadeGameHelper.getUniqueRandomNumbers(1, #eventIdPool, ArcadeSurvivorGameEnum.Const.EventCount)

	for _, idx in ipairs(indexList) do
		local eventId = eventIdPool[idx]

		if eventId then
			usedEventIdList[#usedEventIdList + 1] = eventId
		end
	end

	if #usedEventIdList > 0 then
		gohelper.CreateObjList(self, self._onCreateEventItem, usedEventIdList, self._gowishlist, self._gowishItem)
	end
end

function ArcadeSurvivorEventSelectView:_onCreateEventItem(obj, data, index)
	local item = self:getUserDataTb_()

	item.go = obj
	item.eventId = data
	item.animPlayer = SLFramework.AnimatorPlayer.Get(item.go)

	local txttitle = gohelper.findChildText(item.go, "#txt_Name")

	txttitle.text = ArcadeSurvivorConfig.instance:getEventTitle(item.eventId)

	local txtdesc = gohelper.findChildText(item.go, "txt_Scroll/Viewport/content/#txt_Desc")

	txtdesc.text = ArcadeSurvivorConfig.instance:getEventDesc(item.eventId)
	item.simageicon = gohelper.findChildSingleImage(item.go, "portraitMask/#simage_icon")

	local icon = ArcadeSurvivorConfig.instance:getEventPopupImage(item.eventId)

	if not string.nilorempty(icon) then
		local offsetX, offsetY = 0, 0
		local offsetArr = ArcadeSurvivorConfig.instance:getEventImgOffset(item.eventId)

		if offsetArr then
			offsetX = tonumber(offsetArr[1]) or 0
			offsetY = tonumber(offsetArr[2]) or 0
		end

		recthelper.setAnchor(item.simageicon.transform, offsetX, offsetY)

		local iconPath = ResUrl.getArcadeSurvivorIcon(icon)

		item.simageicon:LoadImage(iconPath)
	end

	item.goselect = gohelper.findChild(item.go, "#go_select")
	item.btnclick = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(item.go, "#btn_click")

	item.btnclick:AddClickListener(self._btnclickOnClick, self, index)

	self._eventItemList[index] = item
end

function ArcadeSurvivorEventSelectView:onUpdateParam()
	return
end

local DEFAULT_SELECT_INDEX = 1

function ArcadeSurvivorEventSelectView:onOpen()
	self:_btnclickOnClick(DEFAULT_SELECT_INDEX)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
end

function ArcadeSurvivorEventSelectView:onOpenFinish()
	if #self._eventItemList <= 0 then
		self:closeThis()
	end
end

function ArcadeSurvivorEventSelectView:refreshEventSelected()
	for i, item in ipairs(self._eventItemList) do
		gohelper.setActive(item.goselect, i == self._selectedIndex)
	end
end

function ArcadeSurvivorEventSelectView:onClose()
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.SelectedEvent)

	self._viewBattleField = nil

	PostProcessingMgr.instance:setViewBlur(self.viewName, nil)

	for _, item in ipairs(self._eventItemList) do
		item.btnclick:RemoveClickListener()
		item.simageicon:UnLoadImage()
	end

	self._selectedIndex = nil

	ArcadeSurvivorGameController.instance:resumeGame(ArcadeSurvivorGameEnum.StopSource.SelectEvent)
end

function ArcadeSurvivorEventSelectView:onDestroyView()
	return
end

return ArcadeSurvivorEventSelectView
