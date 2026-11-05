-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248ClueDecryptionView.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248ClueDecryptionView", package.seeall)

local Act248ClueDecryptionView = class("Act248ClueDecryptionView", BaseView)

function Act248ClueDecryptionView:onInitView()
	self._goclue = gohelper.findChild(self.viewGO, "root/#go_clue")
	self._gocluecard = gohelper.findChild(self.viewGO, "root/#go_clue/middle/cluecard")
	self._btntickgrey = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_clue/middle/cluecard/#btn_tickgrey")
	self._btntick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_clue/middle/cluecard/#btn_tick")
	self._goclueinfo1 = gohelper.findChild(self.viewGO, "root/#go_clue/middle/clueinfo/#go_clueinfo1")
	self._goclueinfo2 = gohelper.findChild(self.viewGO, "root/#go_clue/middle/clueinfo/#go_clueinfo2")
	self._goempty = gohelper.findChild(self.viewGO, "root/#go_clue/middle/clueinfo/#go_empty")
	self._gotips = gohelper.findChild(self.viewGO, "root/#go_clue/#go_tips")
	self._txtdesc1 = gohelper.findChildText(self.viewGO, "root/#go_clue/#go_tips/bg/#txt_desc")
	self._btnTip = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_clue/#go_tips/bg")
	self._goTipCut = gohelper.findChild(self.viewGO, "root/#go_clue/#go_tips/bg/tipcut")
	self._btnTipPre = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_clue/#go_tips/bg/tipcut/#btn_pre")
	self._btnTipNext = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_clue/#go_tips/bg/tipcut/#btn_next")
	self._txtdesc2 = gohelper.findChildText(self.viewGO, "root/#go_clue/#go_tips/bg/#txt_desc2")
	self._goarrow1 = gohelper.findChild(self.viewGO, "root/#go_clue/#go_tips/bg/#go_arrow1")
	self._goarrow2 = gohelper.findChild(self.viewGO, "root/#go_clue/#go_tips/bg/#go_arrow2")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248ClueDecryptionView:addEvents()
	self._btntickgrey:AddClickListener(self._btntickgreyOnClick, self)
	self._btntick:AddClickListener(self._btntickOnClick, self)
	self._btnTip:AddClickListener(self._btntipOnClick, self)
	self._btnTipPre:AddClickListener(self._btntippreOnClick, self)
	self._btnTipNext:AddClickListener(self._btntipnextOnClick, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onClickClueItem, self._onClickClueItem, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onFillClueItem, self._onFillClueItem, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onSlotMoveFinish, self._onSlotMoveFinish, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onConfirmFillClue, self._onConfirmFillClue, self)
end

function Act248ClueDecryptionView:removeEvents()
	self._btntickgrey:RemoveClickListener()
	self._btntick:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnTipPre:RemoveClickListener()
	self._btnTipNext:RemoveClickListener()
	self:removeEventCb(Act248Controller.instance, Act248Event.onClickClueItem, self._onClickClueItem, self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onFillClueItem, self._onFillClueItem, self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onSlotMoveFinish, self._onSlotMoveFinish, self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onConfirmFillClue, self._onConfirmFillClue, self)
end

function Act248ClueDecryptionView:_onSlotMoveFinish()
	if self._isShowView then
		self:_checkCorrectClues()
		self:_onShow(true)
	end

	self.viewContainer:setCanEditor(true)
end

function Act248ClueDecryptionView:_onConfirmFillClue()
	return
end

function Act248ClueDecryptionView:_playSlotItemsAni()
	if not self.viewContainer:isShowClue() then
		return
	end

	local delayTime = 0
	local isAllCorrect = true

	for i, item in ipairs(self._slotItems) do
		if item:isShow() and item:_getStatus() ~= Act248Enum.SlotFillStatus.Correct then
			local clueId = item:getCurFillClue()
			local isCorrectFill = self._slotGroupMo:isCorrectClueId(clueId)

			item:checkCorrectFillAni(delayTime, isCorrectFill)

			delayTime = delayTime + 1

			if not isCorrectFill then
				isAllCorrect = false
			end
		end
	end

	if not isAllCorrect then
		self.viewContainer:clearSelectClueId()
	end

	gohelper.setActive(self._btntickgrey.gameObject, true)
	gohelper.setActive(self._btntick.gameObject, false)
	self.viewContainer:refreshClueDetail()
	self.viewContainer:setCanEditor(false)
	TaskDispatcher.cancelTask(self._onFinishCheckAnim, self)
	TaskDispatcher.runDelay(self._onFinishCheckAnim, self, delayTime)
end

function Act248ClueDecryptionView:_onFinishCheckAnim()
	self.viewContainer:setCanEditor(true)

	if self._slotGroupMo:getStatus() == Act248Enum.SlotFillStatus.Correct then
		Act248Controller.instance:dispatchEvent(Act248Event.onShowSlotTip, self._slotGroupMo, true)
	end

	self:_refreshNeedTipSlotMos()

	self._cutTipIndex = 1

	self:_refreshTipDesc()

	local slotDict = self._slotGroupMo:getSortSlots()

	if self._slotItems and slotDict then
		for i, item in ipairs(self._slotItems) do
			if item:isShow() then
				item:onUpdateMO(slotDict[i], self._slotGroupMo)
			end
		end
	end
end

function Act248ClueDecryptionView:_onClickClueItem(clueId)
	if not self._selectSlotIndex then
		return
	end

	local item = self:_getSlotItems(self._selectSlotIndex)

	item:onFillClue(clueId)
end

function Act248ClueDecryptionView:_onFillClueItem(clueId)
	for i, item in ipairs(self._slotItems) do
		if item:isShow() then
			local fillClue = item:getCurFillClue()

			if fillClue and fillClue > 0 and clueId == fillClue and i ~= self._selectSlotIndex then
				if item:_getStatus() == Act248Enum.SlotFillStatus.Correct then
					return
				end

				item:forceClearFillClue()
				item:playSwitchAnim()
			end
		end
	end

	self:_checkCorrectClues()
	self.viewContainer:refreshEditorFillClues()
end

function Act248ClueDecryptionView:_btntickgreyOnClick()
	return
end

function Act248ClueDecryptionView:_btntickOnClick()
	local isAllFill = self:_isAllFill()

	if not isAllFill then
		return
	end

	if self._slotGroupMo:getStatus() == Act248Enum.SlotFillStatus.Correct then
		return
	end

	self:_playSlotItemsAni()

	local clues = {}

	if self._slotItems then
		for i, item in ipairs(self._slotItems) do
			if item:isShow() then
				local fillClue = item:getCurFillClue()

				if fillClue and fillClue > 0 then
					clues[i] = fillClue
				end
			end
		end
	end

	local clueDict = self._slotGroupMo:setFillClues(clues)

	Act248Rpc.instance:sendAct248FillClueRequest(self._fileMo.id, clueDict)
end

function Act248ClueDecryptionView:_btntipOnClick()
	if not self._isOver2Line then
		return
	end

	self:_refreshTipFoldDesc(not self._isFoldTipDesc)
end

function Act248ClueDecryptionView:_btntippreOnClick()
	self._cutTipIndex = self._cutTipIndex - 1

	self:_refreshTipDesc()
end

function Act248ClueDecryptionView:_btntipnextOnClick()
	self._cutTipIndex = self._cutTipIndex + 1

	self:_refreshTipDesc()
end

function Act248ClueDecryptionView:_editableInitView()
	self._slotItems = self:getUserDataTb_()
	self._slotPath = self.viewContainer:getSetting().otherRes[1]
	self._gocluecardroot = gohelper.findChild(self._gocluecard, "#go_cluecardpos")
	self._cluecardroots = self:getUserDataTb_()

	local childCount = self._gocluecardroot.transform.childCount

	for i = 1, childCount do
		self._cluecardroots[i] = self:getUserDataTb_()

		for j = 1, i do
			self._cluecardroots[i][j] = gohelper.findChild(self._gocluecardroot, string.format("%s/%s", i, j))
		end
	end

	local gotipdesc = gohelper.clone(self._txtdesc2.gameObject, self._goclue)

	self._txttipdesc = gotipdesc:GetComponent(gohelper.Type_TextMesh)
	self._txttipdesc.text = ""

	local color = self._txttipdesc.color

	color.a = 0
	self._txttipdesc.color = color

	recthelper.setWidth(gotipdesc.transform, 1170)
	gohelper.setAsFirstSibling(gotipdesc)
	gohelper.setActive(gotipdesc, true)
end

function Act248ClueDecryptionView:onUpdateParam()
	return
end

function Act248ClueDecryptionView:onOpen()
	self._fileMo = self.viewParam.fileMo

	self:hideView()
	self.viewContainer:setCanEditor(true)
end

function Act248ClueDecryptionView:showView(slotMo)
	self._slotGroupMo = slotMo
	self._isShowView = true

	self:_refreshNeedTipSlotMos()
	self:_refreshClueSlot()

	for i, item in ipairs(self._slotItems) do
		if item:isShow() then
			item:forceClearFillClue(true)
		end
	end
end

function Act248ClueDecryptionView:hideView()
	self._isShowView = false
	self._selectSlotIndex = nil

	self:_onShow(false)
	TaskDispatcher.cancelTask(self._onFinishCheckAnim, self)
	self.viewContainer:setCanEditor(true)

	local clueDict = {}

	if self._slotItems then
		for i, item in ipairs(self._slotItems) do
			if item:isShow() then
				local fillClue = item:getCurFillClue()

				if fillClue and fillClue > 0 and item:_getStatus() == Act248Enum.SlotFillStatus.Normal then
					item:forceClearFillClue()

					local mo = item._mo

					clueDict[mo.id] = 0
				end
			end
		end
	end

	Act248Rpc.instance:sendAct248FillClueRequest(self._fileMo.id, clueDict)
end

function Act248ClueDecryptionView:isShowReturnSlotTip()
	if self._slotItems then
		for i, item in ipairs(self._slotItems) do
			if item:isChangeFillClue() then
				return true
			end
		end
	end
end

function Act248ClueDecryptionView:_onShow(isShow)
	gohelper.setActive(self._goclue, isShow)
end

function Act248ClueDecryptionView:_refreshClueSlot()
	local mos = self._slotGroupMo and self._slotGroupMo:getSortSlots()
	local selectSlotIndex

	if mos then
		local type = #mos

		for i, mo in ipairs(mos) do
			local root = self._cluecardroots[type] and self._cluecardroots[type][i]

			if root then
				local item = self:_getSlotItems(i)

				if item then
					item:onUpdateMO(mo, self._slotGroupMo)

					item.slotId = mo.id

					gohelper.addChild(root, item.viewGO)
					recthelper.setAnchor(item.viewGO.transform, 0, 0)
					transformhelper.setLocalScale(item.viewGO.transform, 1, 1, 1)
					transformhelper.setEulerAngles(item.viewGO.transform, 0, 0, 0)

					if not selectSlotIndex and not mo:isAutoFill() then
						selectSlotIndex = i
					end
				end
			else
				logError("没有这个槽位位置_" .. type .. "  " .. i)
			end
		end
	end

	self:onSelectSlot(selectSlotIndex)

	local count = mos and #mos or 0

	for i, item in ipairs(self._slotItems) do
		item:onShow(i <= count)
	end

	self._cutTipIndex = 1

	self:_refreshTipDesc()
end

function Act248ClueDecryptionView:onSelectSlot(index)
	if self._selectSlotIndex == index then
		return
	end

	self._selectSlotIndex = index

	local fillClue

	for i, item in ipairs(self._slotItems) do
		if i == index then
			fillClue = item:getCurFillClue()
		end

		item:checkSelect(index)
	end

	self.viewContainer:onSelectSlot(index)
	self.viewContainer:onSelectClueSlot(fillClue)
end

function Act248ClueDecryptionView:_refreshNeedTipSlotMos()
	local slotMos = self._slotGroupMo:getMos()

	self._needTipSlotMos = {}

	for _, mo in ipairs(slotMos) do
		if mo:getStatus() ~= Act248Enum.SlotFillStatus.Correct then
			table.insert(self._needTipSlotMos, mo)
		end
	end
end

function Act248ClueDecryptionView:_getSlotTip(slotMo)
	local slotCo = slotMo:getConfig()
	local lang = luaLang("act248_clue_tip")
	local totalCount = #self._needTipSlotMos
	local tip = GameUtil.getSubPlaceholderLuaLangThreeParam(lang, self._cutTipIndex, totalCount, slotCo.tip)

	return tip
end

function Act248ClueDecryptionView:_refreshTipDesc()
	local slotMo = self._needTipSlotMos[self._cutTipIndex]

	if not slotMo then
		gohelper.setActive(self._goTipCut, false)

		return
	end

	local tip = self:_getSlotTip(slotMo)
	local line1Height = SLFramework.UGUI.GuiHelper.GetPreferredHeight(self._txttipdesc, " ")
	local height = SLFramework.UGUI.GuiHelper.GetPreferredHeight(self._txttipdesc, tip)
	local line2Height = line1Height * 2

	self._isOver2Line = line2Height < height

	local layout = self._txtdesc1.gameObject:GetComponent(typeof(UnityEngine.UI.LayoutElement))

	layout.preferredHeight = self._isOver2Line and line2Height or height
	self._txtdesc1.text = tip
	self._txtdesc2.text = tip

	self:_refreshTipFoldDesc(false)

	local totalCount = #self._needTipSlotMos

	gohelper.setActive(self._btnTipPre.gameObject, self._cutTipIndex > 1)
	gohelper.setActive(self._btnTipNext.gameObject, totalCount > self._cutTipIndex)
	gohelper.setActive(self._goTipCut, totalCount > 1)
end

function Act248ClueDecryptionView:_refreshTipFoldDesc(isFold)
	self._isFoldTipDesc = isFold

	gohelper.setActive(self._goarrow1, self._isOver2Line and not isFold)
	gohelper.setActive(self._goarrow2, self._isOver2Line and isFold)
	gohelper.setActive(self._txtdesc1.gameObject, not isFold)
	gohelper.setActive(self._txtdesc2.gameObject, isFold)
end

function Act248ClueDecryptionView:_getSlotItems(index)
	local item = self._slotItems[index]

	if not item then
		local go = self.viewContainer:getResInst(self._slotPath, self._gocluecardroot, index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act248ClueSlotItem)
		item.viewContainer = self.viewContainer
		item.clueView = self
		item.index = index
		self._slotItems[index] = item
	end

	return item
end

function Act248ClueDecryptionView:_isAllFill()
	if self._slotItems then
		for i, item in ipairs(self._slotItems) do
			if item:isShow() then
				local fillClue = item:getCurFillClue()

				if not fillClue or fillClue == 0 then
					return false
				end
			end
		end
	end

	return true
end

function Act248ClueDecryptionView:_checkCorrectClues()
	local isAllFill = self:_isAllFill()
	local isCorrect = self._slotGroupMo:getStatus() == Act248Enum.SlotFillStatus.Correct

	gohelper.setActive(self._btntickgrey.gameObject, not isAllFill or isCorrect)
	gohelper.setActive(self._btntick.gameObject, isAllFill and not isCorrect)
end

function Act248ClueDecryptionView:getFillClues()
	local clueDict = {}

	if self._slotItems then
		for i, item in ipairs(self._slotItems) do
			if item:isShow() then
				local fillClue = item:getCurFillClue()

				if fillClue and fillClue > 0 then
					clueDict[fillClue] = true
				end
			end
		end
	end

	return clueDict
end

function Act248ClueDecryptionView:onClose()
	TaskDispatcher.cancelTask(self._onFinishCheckAnim, self)
end

function Act248ClueDecryptionView:onDestroyView()
	return
end

return Act248ClueDecryptionView
