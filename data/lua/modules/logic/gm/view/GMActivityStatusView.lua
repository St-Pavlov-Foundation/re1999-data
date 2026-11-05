-- chunkname: @modules/logic/gm/view/GMActivityStatusView.lua

module("modules.logic.gm.view.GMActivityStatusView", package.seeall)

local GMActivityStatusView = class("GMActivityStatusView", BaseView)
local StateShow, StateHide, StateTweening = 1, 2, 3

function GMActivityStatusView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnClose")
	self._btnShow = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnShow")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnHide")
	self._rect = gohelper.findChild(self.viewGO, "view").transform
	self._btnOp = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnOp")
	self._btnScroll = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnScroll")
	self._btnDelete = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnDelete")
	self._btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnFinish")
	self._btnReverse = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnReverse")
	self._textBtnReverse = gohelper.findChildText(self.viewGO, "view/title/btnReverse/Text")
	self._inputSearch = gohelper.findChildTextMeshInputField(self.viewGO, "view/title/btnOp/InputField")
end

function GMActivityStatusView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnOp:AddClickListener(self._onClickOp, self)
	self._btnScroll:AddClickListener(self._onClickScroll, self)
	self._btnDelete:AddClickListener(self._onClickRefresh, self)
	self._btnFinish:AddClickListener(self._onClickCopyAll, self)
	self._btnReverse:AddClickListener(self._onClickReverse, self)
end

function GMActivityStatusView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnOp:RemoveClickListener()
	self._btnScroll:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._btnFinish:RemoveClickListener()
	self._btnReverse:RemoveClickListener()

	if self._inputSearch then
		self._inputSearch:RemoveOnValueChanged()
		self._inputSearch:RemoveOnEndEdit()
	end
end

function GMActivityStatusView:onOpen()
	self._state = StateShow

	self:_updateBtns()
	self:_updateUI()
	TaskDispatcher.runRepeat(self._updateUI, self, 0.5)
	self:_updateBtnReverseText()
end

function GMActivityStatusView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self._updateUI, self)
end

function GMActivityStatusView:_updateUI()
	GMActivityStatusModel.instance:reInit()
	GMActivityStatusModel.instance:updateModel()
end

function GMActivityStatusView:_onClickShow()
	if self._state == StateHide then
		self._state = StateTweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, 0, 0.2, self._onShow, self)
	end
end

function GMActivityStatusView:_onShow()
	self._tweenId = nil
	self._state = StateShow

	self:_updateBtns()
end

function GMActivityStatusView:_onClickHide()
	if self._state == StateShow then
		self._state = StateTweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, -800, 0.2, self._onHide, self)
	end
end

function GMActivityStatusView:_onHide()
	self._tweenId = nil
	self._state = StateHide

	self:_updateBtns()
end

function GMActivityStatusView:_updateBtns()
	gohelper.setActive(self._btnShow.gameObject, self._state == StateHide)
	gohelper.setActive(self._btnHide.gameObject, self._state == StateShow)
end

function GMActivityStatusView:_onClickOp()
	if self._inputSearch then
		self._inputSearch:SetText(GMActivityStatusModel.instance:getSearch())
		gohelper.setActive(self._inputSearch.gameObject, true)
		self._inputSearch:AddOnValueChanged(self._onSearchValueChanged, self)
		self._inputSearch:AddOnEndEdit(self._onSearchEndEdit, self)
	end
end

function GMActivityStatusView:_onSearchValueChanged(value)
	GMActivityStatusModel.instance:setSearch(value)
end

function GMActivityStatusView:_onSearchEndEdit()
	gohelper.setActive(self._inputSearch.gameObject, false)
end

function GMActivityStatusView:_onClickScroll()
	local scrollCG = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "view/scroll"), typeof(UnityEngine.CanvasGroup))

	scrollCG.blocksRaycasts = not scrollCG.blocksRaycasts

	GMActivityStatusModel.instance:onClickShowOpBtn()

	gohelper.findChildText(self._btnScroll.gameObject, "Text").text = scrollCG.blocksRaycasts and "点击穿透" or "允许操作"
end

function GMActivityStatusView:_onClickRefresh()
	self:_updateUI()
end

function GMActivityStatusView:_onClickCopyAll()
	local ids = {}

	for _, actInfo in pairs(ActivityModel.instance:getActivityInfo()) do
		table.insert(ids, tostring(actInfo.id))
	end

	table.sort(ids)
	ZProj.UGUIHelper.CopyText(table.concat(ids, ","))
	GameFacade.showToast(ToastEnum.IconId, "已复制活动ID列表")
end

function GMActivityStatusView:_onClickReverse()
	GMActivityStatusModel.instance:onClickReverse()
	self:_updateBtnReverseText()
end

function GMActivityStatusView:_updateBtnReverseText()
	self._textBtnReverse.text = GMActivityStatusModel.instance.idReverse and luaLang("p_roombuildingfilterview_raredown") or luaLang("p_roombuildingfilterview_rareup")
end

return GMActivityStatusView
