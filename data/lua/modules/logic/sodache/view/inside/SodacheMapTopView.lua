-- chunkname: @modules/logic/sodache/view/inside/SodacheMapTopView.lua

module("modules.logic.sodache.view.inside.SodacheMapTopView", package.seeall)

local SodacheMapTopView = class("SodacheMapTopView", BaseView)

function SodacheMapTopView:onInitView()
	self._txtEvilLv = gohelper.findChildTextMesh(self.viewGO, "Top/#btn_evil/#txt_evil")
	self._btnevil = gohelper.findChildButtonWithAudio(self.viewGO, "Top/#btn_evil")
	self._btnsubmit = gohelper.findChildButtonWithAudio(self.viewGO, "Top/#btn_submit")
	self._btnaction = gohelper.findChildButtonWithAudio(self.viewGO, "Top/#btn_action")
	self._goactioninfo = gohelper.findChild(self.viewGO, "Top/#btn_action/#go_infocontainer")
	self._btncloseactioninfo = gohelper.findChildButtonWithAudio(self.viewGO, "Top/#btn_action/#go_infocontainer/#btn_click")
	self._btnmonster = gohelper.findChildButtonWithAudio(self.viewGO, "Top/#btn_monster")
	self._btntime = gohelper.findChildButtonWithAudio(self.viewGO, "Top/#btn_time")
	self._imagetime = gohelper.findChildImage(self.viewGO, "Top/#btn_time/#image_weather")
	self._animactionPoint = gohelper.findChildAnim(self.viewGO, "Top/#btn_action/layout/#txt_action")
	self._txtActionPoint = gohelper.findChildTextMesh(self.viewGO, "Top/#btn_action/layout/#txt_action")
	self._txtActionPoint2 = gohelper.findChildTextMesh(self.viewGO, "Top/#btn_action/#go_infocontainer/info/#scroll_info/viewport/content/#go_info/title/txt_time")
end

function SodacheMapTopView:addEvents()
	self._btnevil:AddClickListener(self._onClickEvil, self)
	self._btnsubmit:AddClickListener(self._onClickWorship, self)
	self._btnmonster:AddClickListener(self._onClickMonster, self)
	self._btntime:AddClickListener(self._onClickTime, self)
	self._btnaction:AddClickListener(self._onClickAction, self)
	self._btncloseactioninfo:AddClickListener(self._onClickActionClose, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnAttrUpdate, self.onAttrChange, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnScenePropUpdate, self.refreshTimeShow, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnPathCostStrChange, self.onCostStrChange, self)
end

function SodacheMapTopView:removeEvents()
	self._btnevil:RemoveClickListener()
	self._btnsubmit:RemoveClickListener()
	self._btnmonster:RemoveClickListener()
	self._btntime:RemoveClickListener()
	self._btnaction:RemoveClickListener()
	self._btncloseactioninfo:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnAttrUpdate, self.onAttrChange, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnScenePropUpdate, self.refreshTimeShow, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnPathCostStrChange, self.onCostStrChange, self)
end

function SodacheMapTopView:onOpen()
	self._costStr = ""
	self._insideMo = SodacheModel.instance:getInsideMo()

	self:onAttrChange()
	self:refreshTimeShow()
	gohelper.setActive(self._goactioninfo, false)
end

function SodacheMapTopView:refreshTimeShow()
	local timeCardId = self._insideMo.prop.timeCardId
	local copyCo = self._insideMo.copyCo
	local arr = string.splitToNumber(copyCo.time, "#") or {}
	local arr2 = string.split(copyCo.icon, "#") or {}
	local iconName = arr2[tabletool.indexOf(arr, timeCardId)]

	gohelper.setActive(self._btntime, iconName)

	if iconName then
		UISpriteSetMgr.instance:setSodache2Sprite(self._imagetime, iconName)
	end
end

function SodacheMapTopView:onAttrChange()
	local evilLv = SodacheUtil.getAttr(SodacheEnum.AttrId.EvilValue)

	self._txtEvilLv.text = evilLv

	self:refreshActionPoint()
end

function SodacheMapTopView:onCostStrChange(str)
	self._costStr = str

	self:refreshActionPoint()
end

function SodacheMapTopView:refreshActionPoint()
	local actionPoint = SodacheUtil.getAttr(SodacheEnum.AttrId.ActionPoint)

	self._txtActionPoint.text = string.format("%d<size=28><#878787>%s</size></color>", actionPoint, self._costStr)
	self._txtActionPoint2.text = actionPoint

	self._animactionPoint:Play(string.nilorempty(self._costStr) and "idle" or "loop")
end

function SodacheMapTopView:_onClickEvil()
	ViewMgr.instance:openView(ViewName.SodacheAltarView)
end

function SodacheMapTopView:_onClickWorship()
	if #self._insideMo.prop.offerRelicIds <= 0 then
		GameFacade.showToast(ToastEnum.SodacheToastId373005)

		return
	end

	ViewMgr.instance:openView(ViewName.SodacheWorshipView, {})
end

function SodacheMapTopView:_onClickMonster()
	ViewMgr.instance:openView(ViewName.SodacheMapMonsterAttrView)
end

function SodacheMapTopView:_onClickTime()
	local timeCardId = self._insideMo.prop.timeCardId

	ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
		cardMo = SodacheCardMo.Create(timeCardId)
	})
end

function SodacheMapTopView:_onClickAction()
	return
end

function SodacheMapTopView:_onClickActionClose()
	gohelper.setActive(self._goactioninfo, false)
end

return SodacheMapTopView
