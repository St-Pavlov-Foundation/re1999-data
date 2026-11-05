-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248DecryptionMainViewContainer.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248DecryptionMainViewContainer", package.seeall)

local Act248DecryptionMainViewContainer = class("Act248DecryptionMainViewContainer", BaseViewContainer)

function Act248DecryptionMainViewContainer:buildViews()
	local views = {}

	self._mainView = Act248DecryptionMainView.New()
	self._slotView = Act248SlotView.New()
	self._clueView = Act248ClueDecryptionView.New()
	self._dialogView = Act248DialogView.New()
	self._slotTipView = Act248SlotTipView.New()

	table.insert(views, self._mainView)
	table.insert(views, self._slotView)
	table.insert(views, self._clueView)
	table.insert(views, self._dialogView)
	table.insert(views, self._slotTipView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/#go_clue/left"))
	table.insert(views, TabViewGroup.New(3, "root/#go_clue/middle/clueinfo"))

	return views
end

function Act248DecryptionMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self._leftView = Act248SlotClueLeftListView.New()

		return {
			self._leftView
		}
	elseif tabContainerId == 3 then
		self._clueInfo = Act248ClueInfo.New()

		return {
			self._clueInfo
		}
	end
end

function Act248DecryptionMainViewContainer:_overrideCloseFunc()
	if self._isShowClue then
		if self._clueView:isShowReturnSlotTip() then
			GameFacade.showOptionMessageBox(MessageBoxIdDefine.V4a1Act248ReturnSlotView, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.openSlotView, nil, nil, self)
		else
			self:openSlotView()
		end
	else
		self:closeThis()
	end

	TaskDispatcher.cancelTask(self._refreshClueInfo, self)
end

function Act248DecryptionMainViewContainer:openSlotView()
	if self._isShowClue == false or not self._isCanEditor then
		return
	end

	self._slotView:showView()
	self._clueView:hideView()
	self._leftView:hideView()
	self._slotTipView:hideView()

	self._isShowClue = false
	self._selectSlotGroupMo = nil
	self._selectSlotIndex = nil

	self._mainView:playAni(Act248Enum.AniName.to_slot)
	Act248Controller.instance:dispatchEvent(Act248Event.onOpenSlotView)
	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_mail_open_1)
end

function Act248DecryptionMainViewContainer:openClueEditorView(slotGroupMo)
	if self._isShowClue == true or not self._isCanEditor then
		return
	end

	self._selectSlotGroupMo = slotGroupMo
	self._selectSlotIndex = 1

	local clueId = slotGroupMo and slotGroupMo:getFillClueId()

	self:showClueInfo(clueId)

	self._editorFillClues = {}

	if slotGroupMo then
		local mos = slotGroupMo:getMos()

		for _, mo in ipairs(mos) do
			local fillClue = mo:getFillClueId()

			if fillClue and fillClue > 0 then
				self._editorFillClues[fillClue] = true
			end
		end
	end

	self._slotView:hideView(slotGroupMo)
	self._clueView:showView(slotGroupMo)
	self._leftView:showView(slotGroupMo, clueId)
	self._slotTipView:hideView()

	self._isShowClue = true

	self._mainView:playAni(Act248Enum.AniName.to_clue)
	Act248Controller.instance:dispatchEvent(Act248Event.onOpenClueEditorView)
	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_mail_open_1)
end

function Act248DecryptionMainViewContainer:isShowClue()
	return self._isShowClue
end

function Act248DecryptionMainViewContainer:showClueInfo(clueId, delayTime)
	if self._selectClueId == clueId then
		return
	end

	self._selectClueId = clueId

	TaskDispatcher.cancelTask(self._refreshClueInfo, self)

	delayTime = delayTime or 0

	if delayTime == 0 then
		self:_refreshClueInfo()
	else
		self._mainView:playAni(Act248Enum.AniName.clue_switch)
		TaskDispatcher.runDelay(self._refreshClueInfo, self, delayTime)
	end
end

function Act248DecryptionMainViewContainer:_refreshClueInfo()
	self._clueInfo:refreshClue(self._selectClueId)
end

function Act248DecryptionMainViewContainer:refreshClueDetail()
	self._clueInfo:refreshClueDetail()
end

function Act248DecryptionMainViewContainer:getSelectClueId()
	return self._selectClueId
end

function Act248DecryptionMainViewContainer:clearSelectClueId()
	self._selectClueId = nil
end

function Act248DecryptionMainViewContainer:getFillClues()
	return self._clueView:getFillClues()
end

function Act248DecryptionMainViewContainer:onSelectSlot(index)
	self._selectSlotIndex = index

	self._clueView:onSelectSlot(index)
end

function Act248DecryptionMainViewContainer:getSelectSlotGroupMo()
	return self._selectSlotGroupMo
end

function Act248DecryptionMainViewContainer:getSelectSlotMo()
	return self._selectSlotGroupMo:getSlotMoByIndex(self._selectSlotIndex or 1)
end

function Act248DecryptionMainViewContainer:onSelectClueSlot(fillClue)
	self:showClueInfo(fillClue, Act248Enum.ClueInfoSwitchDelayTime)
	self._leftView:onSelectClueId(fillClue)
end

function Act248DecryptionMainViewContainer:showDialogs(list)
	self._dialogView:showDialogs(list)
end

function Act248DecryptionMainViewContainer:onFinishDialog()
	self._slotView:onFinishDialog()
end

function Act248DecryptionMainViewContainer:getEditorFillClues()
	return self._editorFillClues or {}
end

function Act248DecryptionMainViewContainer:refreshEditorFillClues()
	self._editorFillClues = self._clueView:getFillClues()
end

function Act248DecryptionMainViewContainer:setCanEditor(isCan)
	self._isCanEditor = isCan
end

function Act248DecryptionMainViewContainer:isCanEditor()
	return self._isCanEditor
end

return Act248DecryptionMainViewContainer
