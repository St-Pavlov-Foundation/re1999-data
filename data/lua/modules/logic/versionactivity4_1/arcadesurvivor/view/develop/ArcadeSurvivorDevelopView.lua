-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/develop/ArcadeSurvivorDevelopView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.develop.ArcadeSurvivorDevelopView", package.seeall)

local ArcadeSurvivorDevelopView = class("ArcadeSurvivorDevelopView", BaseView)

function ArcadeSurvivorDevelopView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gotab1 = gohelper.findChild(self.viewGO, "tab/#go_tab1")
	self._goselect1 = gohelper.findChild(self.viewGO, "tab/#go_tab1/#go_select")
	self._goreddot1 = gohelper.findChild(self.viewGO, "tab/#go_tab1/#go_reddot")
	self._btntab1 = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "tab/#go_tab1/#btn_tab")
	self._gotab2 = gohelper.findChild(self.viewGO, "tab/#go_tab2")
	self._goselect2 = gohelper.findChild(self.viewGO, "tab/#go_tab2/#go_select")
	self._goreddot2 = gohelper.findChild(self.viewGO, "tab/#go_tab2/#go_reddot")
	self._btntab2 = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "tab/#go_tab2/#btn_tab")
	self._goview = gohelper.findChild(self.viewGO, "#go_view")
	self._gocurrency = gohelper.findChild(self.viewGO, "#go_currency")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnclose = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorDevelopView:addEvents()
	self._btntab1:AddClickListener(self._btntab1OnClick, self)
	self._btntab2:AddClickListener(self._btntab2OnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:_editableAddEvents()
end

function ArcadeSurvivorDevelopView:removeEvents()
	self._btntab1:RemoveClickListener()
	self._btntab2:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self:_editableRemoveEvents()
end

function ArcadeSurvivorDevelopView:_btncloseOnClick()
	self:closeThis()
end

function ArcadeSurvivorDevelopView:_btntab1OnClick()
	self:_refreshTab(1)
end

function ArcadeSurvivorDevelopView:_btntab2OnClick()
	self:_refreshTab(2)
end

function ArcadeSurvivorDevelopView:onClickModalMask()
	self:_btncloseOnClick()
end

function ArcadeSurvivorDevelopView:_editableAddEvents()
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHeroItem, self._onClickSelectItem, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.UpLevelTalent, self._refreshReddot, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnOutsideCurrencyChangePush, self._refreshReddot, self, LuaEventSystem.Low)
end

function ArcadeSurvivorDevelopView:_editableRemoveEvents()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHeroItem, self._onClickSelectItem, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.UpLevelTalent, self._refreshReddot, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnOutsideCurrencyChangePush, self._refreshReddot, self, LuaEventSystem.Low)
end

function ArcadeSurvivorDevelopView:_editableInitView()
	return
end

function ArcadeSurvivorDevelopView:_onClickSelectItem()
	self:_refreshReddot()
end

function ArcadeSurvivorDevelopView:onOpen()
	self._selectTab = nil

	local defaultTabId = self.viewParam and self.viewParam.defaultTabId or 1

	self:_refreshTab(defaultTabId)
	self:_refreshReddot()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
end

function ArcadeSurvivorDevelopView:_refreshTab(index)
	if self._selectTab == index then
		return
	end

	self.viewContainer:selectActTab(index)

	self._selectTab = index

	local selectTab1 = self._selectTab == 1

	if selectTab1 then
		local selectHeroId = ArcadeSurvivorHeroModel.instance:getSelectHeroId()

		ArcadeSurvivorHeroModel.instance:markHeroRead(selectHeroId)
		ArcadeSurvivorHallModel.instance:refreshDevelopReddot()
		ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnRefreshHallBuildingReddot, ArcadeSurvivorHallEnum.HallInteractiveUnitId.Develop)
	end

	gohelper.setActive(self._goselect1, selectTab1)
	gohelper.setActive(self._goselect2, not selectTab1)
	self:_refreshReddot()
end

function ArcadeSurvivorDevelopView:_refreshReddot()
	local hasReddotCharacter = ArcadeSurvivorHeroModel.instance:hasReddotCharacter()
	local hasReddotTalent = ArcadeSurvivorHeroModel.instance:hasReddotTalent()

	gohelper.setActive(self._goreddot1, hasReddotCharacter)
	gohelper.setActive(self._goreddot2, hasReddotTalent)
end

function ArcadeSurvivorDevelopView:onClose()
	ArcadeSurvivorHeroModel.instance:setSelectHeroId()
end

function ArcadeSurvivorDevelopView:onDestroyView()
	return
end

return ArcadeSurvivorDevelopView
