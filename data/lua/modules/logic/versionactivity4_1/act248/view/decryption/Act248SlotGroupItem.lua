-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248SlotGroupItem.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248SlotGroupItem", package.seeall)

local Act248SlotGroupItem = class("Act248SlotGroupItem", Act248SlotItem)

function Act248SlotGroupItem:_btnclickcharacterOnClick()
	if not self.viewContainer:isCanEditor() then
		return
	end

	if self:_isFinish() then
		Act248Controller.instance:dispatchEvent(Act248Event.onShowSlotTip, self._slotGroupMo)

		return
	end

	self.viewContainer:openClueEditorView(self._slotGroupMo)
end

function Act248SlotGroupItem:_isFinish()
	if not self._fileMo or self._fileMo:isFinishFill() then
		return true
	end

	if self:_getStatus() == Act248Enum.SlotFillStatus.Correct then
		return true
	end
end

function Act248SlotGroupItem:_isShowTag()
	return true
end

function Act248SlotGroupItem:onUpdateMO(mo, fileMo)
	self._slotGroupMo = mo
	self._fileMo = fileMo
	self._co = mo:getConfig()
	self._txtname.text = mo:getCatrgoryCo().name

	local clueId = mo:getFillClueId()

	self:setFillClue(clueId)
	self:_refreshStatus()
end

function Act248SlotGroupItem:_getStatus()
	if not self._slotGroupMo then
		return Act248Enum.SlotFillStatus.Normal
	end

	return self._slotGroupMo:getStatus()
end

function Act248SlotGroupItem:onRefreshStatus()
	self:_refreshStatus()
end

function Act248SlotGroupItem:_isSingle()
	return self._slotGroupMo:isSingle()
end

function Act248SlotGroupItem:setRoot(root, line, target)
	self._root = root
	self._line = line

	if target and self._root then
		local anchor = self._root.transform:InverseTransformPoint(target.transform.position)

		self._targetAnchorX, self._targetAnchorY = anchor.x, anchor.y
	end
end

function Act248SlotGroupItem:onShow(isShow)
	gohelper.setActive(self._line, isShow)
	Act248SlotGroupItem.super.onShow(self, isShow)
end

function Act248SlotGroupItem:onMove(isCenter)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	local x = isCenter and self._targetAnchorX or 0
	local y = isCenter and self._targetAnchorY or 0
	local time = 0.3

	self._tweenId = ZProj.TweenHelper.DOAnchorPos(self.viewGO.transform, x, y, time, self._onMoveFinish, self, nil, EaseType.Linear)
end

function Act248SlotGroupItem:_onMoveFinish()
	Act248Controller.instance:dispatchEvent(Act248Event.onSlotMoveFinish, self.viewContainer:isShowClue())
end

function Act248SlotGroupItem:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	Act248SlotGroupItem.super.onDestroyView(self)
end

return Act248SlotGroupItem
