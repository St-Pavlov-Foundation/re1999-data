-- chunkname: @modules/logic/versionactivity4_1/dungeon/view/map/VersionActivity4_1DungeonMapView.lua

module("modules.logic.versionactivity4_1.dungeon.view.map.VersionActivity4_1DungeonMapView", package.seeall)

local VersionActivity4_1DungeonMapView = class("VersionActivity4_1DungeonMapView", VersionActivityFixedDungeonMapView1)

function VersionActivity4_1DungeonMapView:_editableInitView()
	VersionActivity4_1DungeonMapView.super._editableInitView(self)

	self._goact248 = gohelper.findChild(self.viewGO, "#go_topright/#btn_investigationenter")
	self._btnact248 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_investigationenter/#btn_click")
	self._goact248reddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_investigationenter/#go_reddot")
	self._goact248finish = gohelper.findChild(self.viewGO, "#go_topright/#btn_investigationenter/#go_finished")
	self._goact248num = gohelper.findChild(self.viewGO, "#go_topright/#btn_investigationenter/numbg")
	self._txtact248num = gohelper.findChildText(self.viewGO, "#go_topright/#btn_investigationenter/numbg/#txt_num")

	gohelper.setActive(self._goact248, false)
	RedDotController.instance:addRedDot(self._goact248reddot, RedDotEnum.DotNode.Act248Enter)
end

function VersionActivity4_1DungeonMapView:addEvents()
	VersionActivity4_1DungeonMapView.super.addEvents(self)
	self._btnact248:AddClickListener(self._btnAct248OnClick, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onGainClue, self._refreshAct248Btn, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onFinishReport, self._refreshAct248Btn, self)
	self:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, self._refreshAct248Btn, self)
end

function VersionActivity4_1DungeonMapView:removeEvents()
	VersionActivity4_1DungeonMapView.super.removeEvents(self)
	self._btnact248:RemoveClickListener()
	self:removeEventCb(Act248Controller.instance, Act248Event.onGainClue, self._refreshAct248Btn, self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onFinishReport, self._refreshAct248Btn, self)
	self:removeEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, self._refreshAct248Btn, self)
end

function VersionActivity4_1DungeonMapView:_btnAct248OnClick()
	Act248Controller.instance:openAct248EnterView()
end

function VersionActivity4_1DungeonMapView:onOpen()
	VersionActivity4_1DungeonMapView.super.onOpen(self)

	local actId = Act248Model.instance:getActId()

	if ActivityHelper.isOpen(actId) then
		Act248Rpc.instance:sendAct248GetInfoRequest(actId, self._refreshAct248Btn, self)
	end
end

function VersionActivity4_1DungeonMapView:_refreshAct248Btn()
	local count, total = Act248Model.instance:getFinishFileCount()
	local isAllFinish = total <= count

	if not isAllFinish then
		local lang = luaLang("act248_progress")

		self._txtact248num.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, count, total)
	end

	gohelper.setActive(self._goact248num, not isAllFinish)
	gohelper.setActive(self._goact248finish, isAllFinish)
	gohelper.setActive(self._goact248, self:isShowAct248Btn())
end

function VersionActivity4_1DungeonMapView:isShowAct248Btn()
	return Act248Model.instance:isUnlockAct248()
end

function VersionActivity4_1DungeonMapView:onClickElement(mapElement)
	local config = mapElement._config

	if config.type == DungeonEnum.ElementType.V4a1Special then
		return
	end

	self:hideBtnUI()
	self:setNavBtnIsShow(false)
end

return VersionActivity4_1DungeonMapView
