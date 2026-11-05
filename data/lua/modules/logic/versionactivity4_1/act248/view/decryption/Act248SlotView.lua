-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248SlotView.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248SlotView", package.seeall)

local Act248SlotView = class("Act248SlotView", BaseView)

function Act248SlotView:onInitView()
	self._goslot = gohelper.findChild(self.viewGO, "root/#go_slot")
	self._gocluecard = gohelper.findChild(self.viewGO, "root/#go_slot/board")
	self._cluecardItem1 = gohelper.findChild(self.viewGO, "root/#go_clue/middle/cluecard/#go_cluecardpos/1/1")
	self._gobtn = gohelper.findChild(self.viewGO, "root/#go_slot/#go_btn")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_slot/#go_btn/#btn_start")
	self._btnstartgrey = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_slot/#go_btn/#btn_startgrey")
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_slot/#go_btn/#btn_look")
	self._gofinish = gohelper.findChild(self.viewGO, "root/#go_slot/#go_btn/#go_finish")
	self._gotips = gohelper.findChild(self.viewGO, "root/#go_tips")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/#go_tips/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#go_tips/#scroll_desc/Viewport/Content/#txt_desc")
	self._godialogue = gohelper.findChild(self.viewGO, "root/#go_slot/#go_dialogue")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248SlotView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnstartgrey:AddClickListener(self._btnstartgreyOnClick, self)
	self._btnlook:AddClickListener(self._btnlookOnClick, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onSlotMoveFinish, self._onSlotMoveFinish, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onConfirmFillClue, self._onConfirmFillClue, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onGenerateReport, self._onGenerateReport, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Act248SlotView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnstartgrey:RemoveClickListener()
	self._btnlook:RemoveClickListener()
	self:removeEventCb(Act248Controller.instance, Act248Event.onSlotMoveFinish, self._onSlotMoveFinish, self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onConfirmFillClue, self._onConfirmFillClue, self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onGenerateReport, self._onGenerateReport, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Act248SlotView:_onSlotMoveFinish()
	if self._isShowView then
		self:_refreshSlotItems()
	else
		gohelper.setActive(self._goslot, false)
	end
end

function Act248SlotView:_onConfirmFillClue()
	self:_refreshSlotItems()
end

function Act248SlotView:_onGenerateReport()
	self:_refreshBtn()
end

function Act248SlotView:onFinishDialog()
	self.viewContainer:setCanEditor(true)
end

function Act248SlotView:_checkFinishStatus()
	local slotGroupMo = self._fileMo:getSlotMos()
	local isAllCorrect = true

	if slotGroupMo then
		for i, mo in ipairs(slotGroupMo) do
			local isCorrectFill = mo:isCorrectFill()

			if not isCorrectFill then
				isAllCorrect = false
			end
		end
	end

	if isAllCorrect and not self._fileMo:isFinishFill() then
		Act248Rpc.instance:sendAct248GenerateReportRequest(self._actId, self._fileMo.id, self._onFinishFill, self)
	end
end

function Act248SlotView:_playDecideAni()
	return
end

function Act248SlotView:_btnstartOnClick()
	self:_checkFinishStatus()
end

function Act248SlotView:_onFinishFill()
	self:_refreshBtn()
	Act248Controller.instance:dispatchEvent(Act248Event.onFinishFileFill)
end

function Act248SlotView:_btnstartgreyOnClick()
	return
end

function Act248SlotView:_btnlookOnClick()
	Act248Controller.instance:openAct248ReportView(self._fileMo.id)
end

function Act248SlotView:_editableInitView()
	gohelper.setActive(self._godialogue, false)
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._gofinish, false)
	gohelper.setActive(self._btnlook, false)
	gohelper.setActive(self._btnstart, false)
	gohelper.setActive(self._btnstartgrey, false)

	self._txttitle = gohelper.findChildText(self.viewGO, "root/#go_slot/txt_title")
	self._imgeTarget = gohelper.findChildImage(self.viewGO, "root/#go_slot/board/target/simage_role")
	self._slotPath = self.viewContainer:getSetting().otherRes[1]
	self._slotItems = self:getUserDataTb_()

	for i = 1, 6 do
		self:_getSlotItems(i)
	end

	self._finishAnimator = self._gofinish:GetComponent(typeof(UnityEngine.Animator))
end

function Act248SlotView:onUpdateParam()
	return
end

function Act248SlotView:onOpen()
	self._fileMo = self.viewParam.fileMo
	self._fileCo = self._fileMo:getConfig()
	self._actId = Act248Model.instance:getActId()

	UISpriteSetMgr.instance:setAct248Sprite(self._imgeTarget, self._fileCo.portrait)
	self:_refreshSlotItems()
	self:showView()
	self.viewContainer:setCanEditor(true)
end

function Act248SlotView:showView()
	self:_onShow(true)
	gohelper.setActive(self._goslot, true)

	if self._curSlotItem then
		self._curSlotItem:onShow(true)
		self._curSlotItem:onMove(false)
	end

	self:_checkFinishStatus()
	self:_refreshBtn()
end

function Act248SlotView:hideView(slotGroupMo)
	self:_onShow(false)

	for i, item in ipairs(self._slotItems) do
		if item.slotGroupMo and slotGroupMo and item.slotGroupMo.id == slotGroupMo.id then
			item:onMove(true)

			self._curSlotItem = item
		else
			item:onShow(false)
		end
	end
end

function Act248SlotView:_onShow(isShow)
	if self._isShowView == isShow then
		return
	end

	gohelper.setActive(self._gocluecard, isShow)
	gohelper.setActive(self._gobtn, isShow)

	self._isShowView = isShow
end

function Act248SlotView:_refreshBtn()
	local isFinish = self._fileMo:isFinish()
	local isFinishFill = self._fileMo:isFinishFill()

	gohelper.setActive(self._gofinish, isFinish)
	gohelper.setActive(self._btnlook.gameObject, isFinishFill)

	if not self._isFinishFill and isFinishFill then
		AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_wulu_kerandian_unlock)

		self._isFinishFill = isFinishFill
	end
end

function Act248SlotView:_onCloseViewFinish(viewName)
	if viewName == ViewName.Act248ReportView then
		self:_refreshBtn()

		local isFinish = self._fileMo:isFinish()

		if isFinish then
			local key = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.FileFirstFinish, self._actId, self._fileMo.id)
			local statusValue = GameUtil.playerPrefsGetNumberByUserId(key, 0)

			if statusValue == 0 then
				self._finishAnimator:Play(Act248Enum.AniName.finish, 0, 0)
				GameUtil.playerPrefsSetNumberByUserId(key, 1)
			end
		end
	end
end

function Act248SlotView:_refreshSlotItems()
	local slotGroupMo = self._fileMo:getSlotMos()
	local count = 0

	if slotGroupMo then
		for i, mo in ipairs(slotGroupMo) do
			local item = self:_getSlotItems(i)

			if item then
				item:onUpdateMO(mo, self._fileMo)

				item.slotGroupMo = mo
				count = count + 1
			end
		end
	end

	for i, item in ipairs(self._slotItems) do
		if count < i then
			item.slotGroupMo = nil
		end

		item:onShow(i <= count)
	end
end

function Act248SlotView:_getSlotItems(index)
	local item = self._slotItems[index]

	if not item then
		local root = gohelper.findChild(self._goslot, "card/#go_cluecarditem" .. index)
		local line = gohelper.findChild(self._gocluecard, "line/line" .. index)

		if root then
			local go = self.viewContainer:getResInst(self._slotPath, root)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act248SlotGroupItem)
			item.viewContainer = self.viewContainer

			item:setRoot(root, line, self._cluecardItem1)
		else
			logError("没有这个节点：" .. index)
		end

		self._slotItems[index] = item
	end

	return item
end

function Act248SlotView:_isFillAllSlotItem()
	for _, item in ipairs(self._slotItems) do
		if item:isShow() then
			local fillClueId = item:getCurFillClue()

			if not fillClueId or fillClueId == 0 then
				return false
			end
		end
	end

	return true
end

function Act248SlotView:onClose()
	TaskDispatcher.cancelTask(self._checkFinishStatus, self)
end

function Act248SlotView:onDestroyView()
	return
end

return Act248SlotView
