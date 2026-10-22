-- chunkname: @modules/logic/tips/view/HeroRecoveryWindowView.lua

module("modules.logic.tips.view.HeroRecoveryWindowView", package.seeall)

local HeroRecoveryWindowView = class("HeroRecoveryWindowView", BaseView)

function HeroRecoveryWindowView:onInitView()
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_top")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bottom")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#scroll_info")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_sure")
	self._txtsure = gohelper.findChildText(self.viewGO, "#btn_sure/#txt_sure")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroRecoveryWindowView:addEvents()
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._scrollinfo:AddOnValueChanged(self._onScrollValueChanged, self)
end

function HeroRecoveryWindowView:removeEvents()
	self._btnsure:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._scrollinfo:RemoveOnValueChanged()
end

function HeroRecoveryWindowView:_btnsureOnClick()
	if not self.viewParam then
		return
	end

	if self:isHasRefreshTime() or self._isLookFinish ~= true then
		return
	end

	local clickCb = self.viewParam.clickCb
	local clickCbObj = self.viewParam.clickCbObj

	self:closeThis()

	if clickCb then
		if clickCbObj then
			clickCb(clickCbObj)
		else
			clickCb()
		end
	end
end

function HeroRecoveryWindowView:_btncloseOnClick()
	self:closeThis()
end

function HeroRecoveryWindowView:_onScrollValueChanged()
	if not self._isLookFinish then
		local verValue = self._scrollinfo.verticalNormalizedPosition

		if verValue < 0.0001 then
			self._isLookFinish = true

			self:_updateTime()
		end
	end
end

function HeroRecoveryWindowView:_editableInitView()
	self._refreshCDTime = 5
	self._isLookFinish = false
	self._txtdesc = gohelper.findChildText(self.viewGO, "#scroll_info/Viewport/Content/txt_desc")
	self._txttilecn = gohelper.findChildText(self.viewGO, "txt/titlecn")
	self._txttilecn.text = luaLang("p_herorecoverywindowview_txt_Title")
	self._gobtnsure = gohelper.findChild(self.viewGO, "#btn_sure")
end

function HeroRecoveryWindowView:onUpdateParam()
	return
end

function HeroRecoveryWindowView:onOpen()
	self._refreshCDTime = 5

	TaskDispatcher.runRepeat(self._refreshTimeCB, self, 1)
	self:_updateTime()

	local langKeyStr = self.viewParam and self.viewParam.langKeyStr

	if string.nilorempty(langKeyStr) then
		langKeyStr = "v4a0_delete_role_rules_txt"
	end

	self._txtdesc.text = luaLang(langKeyStr)
end

function HeroRecoveryWindowView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeCB, self)
end

function HeroRecoveryWindowView:onDestroyView()
	return
end

function HeroRecoveryWindowView:_refreshTimeCB()
	self._refreshCDTime = self._refreshCDTime - 1

	if not self:isHasRefreshTime() then
		self._refreshCDTime = 0

		TaskDispatcher.cancelTask(self._refreshTimeCB, self)
	end

	self:_updateTime()
end

function HeroRecoveryWindowView:_updateTime()
	if self:isHasRefreshTime() then
		self._txtsure.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_dailyorder_refreshtime"), self._refreshCDTime)
	else
		self._txtsure.text = luaLang("confirm_text")
	end

	ZProj.UGUIHelper.SetGrayscale(self._gobtnsure, self:isHasRefreshTime() or self._isLookFinish ~= true)
end

function HeroRecoveryWindowView:isHasRefreshTime()
	return self._refreshCDTime and self._refreshCDTime > 0
end

return HeroRecoveryWindowView
