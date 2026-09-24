-- chunkname: @modules/logic/custompickchoice/view/SummonCustomPickView.lua

module("modules.logic.custompickchoice.view.SummonCustomPickView", package.seeall)

local SummonCustomPickView = class("SummonCustomPickView", BaseView)

function SummonCustomPickView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagedecbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/#simage_decbg")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollrule = gohelper.findChildScrollRect(self.viewGO, "#scroll_rule")
	self._goexskill = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/role/#go_exskill/#image_exskill")
	self._goclick = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/select/#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonCustomPickView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self:addEventCb(BackpackController.instance, BackpackEvent.onUseItemFinished, self._onPickFinished, self)
	self:addEventCb(SummonCustomPickController.instance, SummonCustomPickEvent.OnGetReward, self._onPickFinished, self)
	self:addEventCb(SummonCustomPickController.instance, SummonCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

function SummonCustomPickView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self:removeEventCb(BackpackController.instance, BackpackEvent.onUseItemFinished, self._onPickFinished, self)
	self:removeEventCb(SummonCustomPickController.instance, SummonCustomPickEvent.OnGetReward, self._onPickFinished, self)
	self:removeEventCb(SummonCustomPickController.instance, SummonCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

function SummonCustomPickView:_btnconfirmOnClick()
	SummonCustomPickController.instance:trySendChoice(self.viewParam)
end

function SummonCustomPickView:_btncancelOnClick()
	self:closeThis()
end

function SummonCustomPickView:_editableInitView()
	return
end

function SummonCustomPickView:onOpen()
	SummonCustomPickChoiceListModel.instance:clearSelectIds()
	self:refreshUI()
end

function SummonCustomPickView:refreshUI()
	local selectCount = SummonCustomPickModel.instance:getSelectCount()
	local maxCount = SummonCustomPickModel.instance:getMaxSelectCount()

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, selectCount ~= maxCount)
end

function SummonCustomPickView:onClose()
	SummonCustomPickModel.instance:clearSelectIds()
end

function SummonCustomPickView:_onPickFinished()
	self:closeThis()
end

function SummonCustomPickView:onDestroyView()
	return
end

return SummonCustomPickView
