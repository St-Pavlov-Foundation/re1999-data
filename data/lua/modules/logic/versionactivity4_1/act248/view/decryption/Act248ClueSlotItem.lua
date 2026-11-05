-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248ClueSlotItem.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248ClueSlotItem", package.seeall)

local Act248ClueSlotItem = class("Act248ClueSlotItem", Act248SlotItem)

function Act248ClueSlotItem:_btnclickcharacterOnClick()
	if not self.viewContainer:isCanEditor() then
		return
	end

	local isAutoFill = self._mo:isAutoFill()

	if isAutoFill or self:_getStatus() == Act248Enum.SlotFillStatus.Correct then
		ToastController.instance:showToast(Act248Enum.Toast.CorrectClue)

		return
	end

	if self.viewContainer then
		self.viewContainer:onSelectSlot(self.index)
	end
end

function Act248ClueSlotItem:_isShowTag()
	return false
end

function Act248ClueSlotItem:onUpdateMO(mo, slotGroupMo, fileMo)
	self._mo = mo
	self._fileMo = fileMo
	self._co = mo:getConfig()
	self._slotGroupMo = slotGroupMo
	self._fillClueId = mo:getFillClueId()

	self:_refreshStatus()

	self._txtname.text = self._co.tagId
end

function Act248ClueSlotItem:_getStatus()
	if not self._mo or not self._isShow then
		return Act248Enum.SlotFillStatus.Normal
	end

	return self._mo:getStatus()
end

function Act248ClueSlotItem:checkSelect(selectId)
	gohelper.setActive(self._goselect, selectId == self.index)
end

function Act248ClueSlotItem:isChangeFillClue()
	if not self:isShow() then
		return false
	end

	local fillClue = self:getCurFillClue()

	if fillClue and fillClue > 0 and self:_getStatus() == Act248Enum.SlotFillStatus.Normal then
		local saveFillClueId = self._mo:getFillClueId()

		if saveFillClueId ~= fillClue then
			return true
		end
	end
end

function Act248ClueSlotItem:onFillClue(clueId)
	self:setFillClue(clueId)
	self._mo:setStatus(Act248Enum.SlotFillStatus.Normal)
end

function Act248ClueSlotItem:setFillClue(clueId)
	if self._fillClueId == clueId then
		return
	end

	local mos = self._slotGroupMo:getMos()

	for i, mo in ipairs(mos) do
		if mo.id ~= self._mo.id and clueId and clueId > 0 and clueId == mo:getFillClueId() then
			if mo:getStatus() == Act248Enum.SlotFillStatus.Correct then
				if self.viewContainer then
					self.viewContainer:onSelectSlot(i)
				end

				return
			else
				mo:setFillClueId()
			end
		end
	end

	self._fillClueId = clueId

	Act248Controller.instance:dispatchEvent(Act248Event.onFillClueItem, clueId)
	self:playSwitchAnim()

	if clueId and clueId > 0 then
		AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_task_page)
	end
end

function Act248ClueSlotItem:playSwitchAnim()
	self:playAni(Act248Enum.AniName.switch)
	TaskDispatcher.cancelTask(self._refreshStatus, self)
	TaskDispatcher.runDelay(self._refreshStatus, self, 0.16)
end

function Act248ClueSlotItem:forceClearFillClue(isFill)
	self._fillClueId = isFill and self._mo:getFillClueId() or 0

	self:_refreshStatus()
end

function Act248ClueSlotItem:_refreshStatus()
	Act248ClueSlotItem.super._refreshStatus(self)
end

function Act248ClueSlotItem:_isSingle()
	return true
end

function Act248ClueSlotItem:_correctFillAniCB()
	local status = self._isCorrectFill and Act248Enum.SlotFillStatus.Correct or Act248Enum.SlotFillStatus.Error

	self._mo:setStatus(status)
	Act248ClueSlotItem.super._correctFillAniCB(self)

	local audioId = self._isCorrectFill and AudioEnum4_1.Act248.play_ui_activity_subject_choose or AudioEnum4_1.Act248.play_ui_atlantis_clue_error

	AudioMgr.instance:trigger(audioId)
end

function Act248ClueSlotItem:onDestroyView()
	Act248ClueSlotItem.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._refreshStatus, self)
end

return Act248ClueSlotItem
