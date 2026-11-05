-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248FileItem.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248FileItem", package.seeall)

local Act248FileItem = class("Act248FileItem", ListScrollCellExtend)

function Act248FileItem:onInitView()
	self._gocasenotfinished = gohelper.findChild(self.viewGO, "#go_casenotfinished")
	self._txtname1 = gohelper.findChildText(self.viewGO, "#go_casenotfinished/#txt_name")
	self._scrolldesc1 = gohelper.findChildScrollRect(self.viewGO, "#go_casenotfinished/#scroll_desc")
	self._txtdesc1 = gohelper.findChildText(self.viewGO, "#go_casenotfinished/#scroll_desc/Viewport/Content/#txt_desc")
	self._txtlacktips = gohelper.findChildText(self.viewGO, "#go_casenotfinished/#txt_lacktip")
	self._gocasefinished = gohelper.findChild(self.viewGO, "#go_casefinished")
	self._txtname2 = gohelper.findChildText(self.viewGO, "#go_casefinished/#txt_name")
	self._scrolldesc2 = gohelper.findChildScrollRect(self.viewGO, "#go_casefinished/#scroll_desc")
	self._txtdesc2 = gohelper.findChildText(self.viewGO, "#go_casefinished/#scroll_desc/Viewport/Content/#txt_desc")
	self._btnglass = gohelper.findChildButtonWithAudio(self.viewGO, "#go_casefinished/#btn_glass")
	self._simgIcon = gohelper.findChildSingleImage(self.viewGO, "#go_casefinished/#simage_pic")
	self._gocaselocked = gohelper.findChild(self.viewGO, "#go_caselocked")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_caselocked/#txt_tips")
	self._goreddot = gohelper.findChild(self.viewGO, "reddot")

	local goClick = gohelper.findChild(self.viewGO, "#go_casenotfinished/bg")
	local goFinishClick = gohelper.findChild(self.viewGO, "#go_casefinished/bg")

	self._btnClick = gohelper.getClickWithDefaultAudio(goClick)
	self._btnFinishClick = gohelper.getClickWithDefaultAudio(goFinishClick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248FileItem:addEvents()
	self._btnglass:AddClickListener(self._btnglassOnClick, self)
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnFinishClick:AddClickListener(self._btnClickOnClick, self)
end

function Act248FileItem:removeEvents()
	self._btnglass:RemoveClickListener()
	self._btnClick:RemoveClickListener()
	self._btnFinishClick:RemoveClickListener()
end

function Act248FileItem:_btnglassOnClick()
	Act248Controller.instance:openAct248ReportView(self._mo.id)
end

function Act248FileItem:_btnClickOnClick()
	local isLock = self._mo:isLock()

	if isLock then
		return
	end

	if self._mo:isNew() then
		self._mo:cancelNew()
		Act248Model.instance:refreshFileNew()
	end

	Act248Controller.instance:openAct248DecryptionMainView(self._mo)
end

function Act248FileItem:_editableInitView()
	gohelper.setActive(self._gocasenotfinished, true)
	gohelper.setActive(self._gocasefinished, true)
	gohelper.setActive(self._gocaselocked, true)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._actId = Act248Model.instance:getActId()

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.Act248File)
end

function Act248FileItem:_editableAddEvents()
	self:addEventCb(Act248Controller.instance, Act248Event.OnRefreshNew, self._refreshNew, self)
end

function Act248FileItem:_editableRemoveEvents()
	self:removeEventCb(Act248Controller.instance, Act248Event.OnRefreshNew, self._refreshNew, self)
end

function Act248FileItem:onUpdateMO(mo)
	self._mo = mo

	local co = mo:getConfig()
	local isLock = self._mo:isLock()
	local isFinish = self._mo:isFinish()
	local isTipLack = not isLock and not isFinish and mo:isLackClue()

	gohelper.setActive(self._txtlacktips.gameObject, isTipLack)
	self:_refreshNew()

	self._txtname1.text = co.name
	self._txtname2.text = co.name
	self._txtdesc1.text = co.desc
	self._txtdesc2.text = co.desc

	if not string.nilorempty(co.complete) then
		self._simgIcon:LoadImage(ResUrl.getV4a1InvestigationSingleBg(co.complete))
	end

	self._txttips.text = co.tip
end

function Act248FileItem:refreshStatusAnim()
	local isLock = self._mo:isLock()
	local isFinish = self._mo:isFinish()
	local key = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.FileAnimStatus, self._actId, self._mo.id)
	local statusValue = GameUtil.playerPrefsGetNumberByUserId(key, Act248Enum.FileStatus.Lock)
	local curStatus = isLock and Act248Enum.FileStatus.Lock or isFinish and Act248Enum.FileStatus.Finish or Act248Enum.FileStatus.Unlock
	local aniName

	if isLock then
		aniName = Act248Enum.AniName.lock_idle
	elseif statusValue == curStatus then
		if isFinish then
			aniName = Act248Enum.AniName.finish_idle
		else
			aniName = Act248Enum.AniName.unlock_idle
		end
	elseif isFinish then
		aniName = Act248Enum.AniName.finish
	else
		aniName = Act248Enum.AniName.unlock
	end

	self._animator:Play(aniName, 0, 0)

	if statusValue ~= curStatus then
		GameUtil.playerPrefsSetNumberByUserId(key, curStatus)
	end
end

function Act248FileItem:_refreshNew()
	local isNew = self._mo:isNew()

	gohelper.setActive(self._goreddot, isNew)
end

function Act248FileItem:onDestroyView()
	self._simgIcon:UnLoadImage()
end

return Act248FileItem
