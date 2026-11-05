-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248SlotClueCategoryChildItem.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248SlotClueCategoryChildItem", package.seeall)

local Act248SlotClueCategoryChildItem = class("Act248SlotClueCategoryChildItem", Act248ClueCategoryChildItem)

function Act248SlotClueCategoryChildItem:_btnclickOnClick()
	local slotGroupMo = self.viewContainer:getSelectSlotGroupMo()
	local isError = slotGroupMo and slotGroupMo:isErrorClueId(self._mo.id)

	if isError then
		return
	end

	local slotMo = self.viewContainer:getSelectSlotMo()

	if not slotMo or slotMo:getStatus() == Act248Enum.SlotFillStatus.Correct then
		ToastController.instance:showToast(Act248Enum.Toast.CorrectClue)

		return
	end

	slotMo:setStatus(Act248Enum.SlotFillStatus.Normal)
	Act248SlotClueCategoryChildItem.super._btnclickOnClick(self)
end

function Act248SlotClueCategoryChildItem:refreshStatus(isFill, isSelect)
	gohelper.setActive(self._golocked, not self._isUnlock)
	gohelper.setActive(self._gonormal, self._isUnlock)

	local slotGroupMo = self.viewContainer:getSelectSlotGroupMo()
	local isError = slotGroupMo and slotGroupMo:isErrorClueId(self._mo.id) and self._isUnlock

	self:onSelect(isSelect and not isError)

	local isFinish = (isFill or isSelect) and not isError

	self:_refreshFillStatus(isError, isFinish)
end

function Act248SlotClueCategoryChildItem:onReset()
	gohelper.setActive(self._golocked, not self._isUnlock)
	gohelper.setActive(self._gonormal, self._isUnlock)
	gohelper.setActive(self._goselect, false)

	local slotGroupMo = self.viewContainer:getSelectSlotGroupMo()
	local isError = slotGroupMo and slotGroupMo:isErrorClueId(self._mo.id) and self._isUnlock
	local isFinish = self:_isFillClue(slotGroupMo) and not isError

	self:_refreshFillStatus(isError, isFinish)
end

function Act248SlotClueCategoryChildItem:_isFillClue(slotGroupMo)
	local mos = slotGroupMo:getMos()

	for _, mo in pairs(mos) do
		if mo:getFillClueId() == self._mo.id then
			return true
		end
	end
end

function Act248SlotClueCategoryChildItem:_refreshFillStatus(isError, isFinish)
	gohelper.setActive(self._gowrong, isError)
	gohelper.setActive(self._gofinished, isFinish)

	if isFinish and self._isHasIcon then
		gohelper.addChildPosStay(self._gofinishedbg, self._gobg)
	else
		gohelper.addChildPosStay(self.viewGO, self._gobg)
		gohelper.setAsFirstSibling(self._gobg)
	end

	ZProj.UGUIHelper.SetGrayscale(self._simgicon.gameObject, isError)
	ZProj.UGUIHelper.SetGrayscale(self._gobg.gameObject, isError)

	for _, txt in ipairs(self._nameItems) do
		ZProj.UGUIHelper.SetGrayscale(txt.gameObject, isError)
	end
end

return Act248SlotClueCategoryChildItem
