﻿-- chunkname: @modules/logic/rouge2/map/view/relicsdrop/Rouge2_RelicsDropView.lua

module("modules.logic.rouge2.map.view.relicsdrop.Rouge2_RelicsDropView", package.seeall)

local Rouge2_RelicsDropView = class("Rouge2_RelicsDropView", BaseView)

function Rouge2_RelicsDropView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goSelect = gohelper.findChild(self.viewGO, "Title/#go_Select")
	self._goDrop = gohelper.findChild(self.viewGO, "Title/#go_Drop")
	self._goLoss = gohelper.findChild(self.viewGO, "Title/#go_Loss")
	self._goStrength = gohelper.findChild(self.viewGO, "Title/#go_Strength")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "scroll_view")
	self._goContent = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content")
	self._goRelicsItem = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content/#go_RelicsItem")
	self._goBottomLeft = gohelper.findChild(self.viewGO, "#go_bottomleft")
	self._goTopLeft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goTopRight = gohelper.findChild(self.viewGO, "#go_topright")
	self._goLevelUpSuccEffect = gohelper.findChild(self.viewGO, "#go_successEffect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_RelicsDropView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_RelicsDropView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_RelicsDropView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_RelicsDropView:_editableInitView()
	self._goScroll = self._scrollView.gameObject

	Rouge2_AttributeToolBar.Load(self._goBottomLeft, Rouge2_Enum.AttributeToolType.Default)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goTopRight, Rouge2_Enum.ItemDescModeDataKey.RelicsDrop)
end

function Rouge2_RelicsDropView:onOpen()
	self:initViewParam()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.DropRelics)
end

function Rouge2_RelicsDropView:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_RelicsDropView:initViewParam()
	self._viewEnum = self.viewParam and self.viewParam.viewEnum
	self._dataType = self.viewParam and self.viewParam.dataType
	self._relicsList = self.viewParam and self.viewParam.itemList or {}
	self._reason = self.viewParam and self.viewParam.reason

	if self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select or self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.LevelUp then
		NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
	end
end

function Rouge2_RelicsDropView:refreshUI()
	self:refreshTitle()
	self:refreshButton()
	self:refreshRelicsList()
end

function Rouge2_RelicsDropView:refreshTitle()
	gohelper.setActive(self._goSelect, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goDrop, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._goLoss, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Loss)
	gohelper.setActive(self._goStrength, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.LevelUp)
	gohelper.setActive(self._goLevelUpSuccEffect, self._reason == Rouge2_MapEnum.ItemDropReason.LevelUpSucc)
end

function Rouge2_RelicsDropView:refreshButton()
	gohelper.setActive(self._btnClose.gameObject, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select and self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.LevelUp)
	gohelper.setActive(self._goTopLeft, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select and self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.LevelUp)
end

function Rouge2_RelicsDropView:refreshRelicsList()
	gohelper.CreateObjList(self, self._refreshRelicsItem, self._relicsList, self._goContent, self._goRelicsItem, Rouge2_RelicsDropItem)

	self._scrollView.horizontalNormalizedPosition = 0
end

function Rouge2_RelicsDropView:_refreshRelicsItem(relicsItem, relicsId, index)
	relicsItem:setParentScroll(self._goScroll)
	relicsItem:onUpdateMO(index, self._viewEnum, self._dataType, relicsId, self)
end

return Rouge2_RelicsDropView
