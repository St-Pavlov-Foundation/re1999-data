-- chunkname: @modules/logic/sodache/view/outside/SodacheHandbookViewFold.lua

module("modules.logic.sodache.view.outside.SodacheHandbookViewFold", package.seeall)

local SodacheHandbookViewFold = class("SodacheHandbookViewFold", BaseView)

function SodacheHandbookViewFold:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheHandbookViewFold:_editableInitView()
	self.modelInst = SodacheHandbookListModel.instance
end

function SodacheHandbookViewFold:onOpen()
	self:addEventCb(SodacheController.instance, SodacheEvent.OnClickGroupFoldBtn, self.onClickGroupFoldBtn, self)
end

function SodacheHandbookViewFold:onClose()
	TaskDispatcher.cancelTask(self.onEndPlayGroupFadeAnim, self)
	TaskDispatcher.cancelTask(self.onPreEndPlayGroupFadeAnim, self)
	TaskDispatcher.cancelTask(self.onDispatchFadeAnimationEvent, self)

	self.modifyMap = nil

	self:onEndPlayGroupFadeAnim()
end

function SodacheHandbookViewFold:onClickGroupFoldBtn(subType, isFold)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("SodacheHandbookViewFold_BeginPlayGroupFadeAnim")
	self:doFadeAnimation(subType, isFold)
end

function SodacheHandbookViewFold:onEndPlayGroupFadeAnim()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("SodacheHandbookViewFold_BeginPlayGroupFadeAnim")
end

local foldoutDurationPerHeight = 0.0004
local foldInDurationPerHeight = 0.0004
local minFadeAnimDuration = 0
local maxFadeAnimDuration = 0.35

function SodacheHandbookViewFold:doFadeAnimation(subType, isFold)
	local moList = self.modelInst:getCurSubTypeMoList(subType)
	local firstMO = moList and moList[1]
	local groupTopIndex = self.modelInst:getIndex(firstMO)

	self.isFold = isFold
	self.modifySubType = subType

	local lastModifyMO
	local lastFadeAnimDuration = 0

	self.modifyMap = self:getUserDataTb_()

	local cellRenderCount = self:getCurRenderCellCount(subType, moList)
	local startIndex = isFold and cellRenderCount or 1
	local endIndex = isFold and 1 or cellRenderCount
	local step = isFold and -1 or 1

	for i = startIndex, endIndex, step do
		local mo = moList[i]

		self.modifyMap[mo] = true

		mo:clearOverrideLineHeight()

		if not isFold and not mo.isGroupTop then
			local insertIndex = groupTopIndex + i - 1

			self.modelInst:addAt(mo, insertIndex)
		end

		local effectParams = self:getEffectParams(isFold, mo, lastModifyMO)

		if not isFold and not mo.isGroupTop then
			mo:overrideLineHeight(0)
		end

		TaskDispatcher.runDelay(self.onDispatchFadeAnimationEvent, effectParams, lastFadeAnimDuration)

		lastFadeAnimDuration = lastFadeAnimDuration + effectParams.duration
		lastModifyMO = mo
	end

	if isFold then
		self:onBeginFoldIn(self.modifySubType, self.isFold)
	end

	TaskDispatcher.cancelTask(self.onPreEndPlayGroupFadeAnim, self)
	TaskDispatcher.runDelay(self.onPreEndPlayGroupFadeAnim, self, lastFadeAnimDuration)
	TaskDispatcher.cancelTask(self.onEndPlayGroupFadeAnim, self)
	TaskDispatcher.runDelay(self.onEndPlayGroupFadeAnim, self, lastFadeAnimDuration)
end

function SodacheHandbookViewFold:onBeginFoldIn(subType, isFold)
	local moList = self.modelInst:getCurSubTypeMoList(subType)

	if moList then
		for i = 1, #moList do
			local mo = moList[i]

			if not self.modifyMap[mo] then
				mo:setIsFold(isFold)
				mo:clearOverrideLineHeight()
				self.modelInst:remove(mo)
			end
		end

		self.modelInst:onModelUpdate()
	end
end

function SodacheHandbookViewFold:onPreEndPlayGroupFadeAnim()
	local moList = self.modelInst:getCurSubTypeMoList(self.modifySubType)

	if moList then
		local firstMO = moList and moList[1]
		local groupTopIndex = self.modelInst:getIndex(firstMO)

		for i = 1, #moList do
			local mo = moList[i]

			mo:setIsFold(self.isFold)
			mo:clearOverrideLineHeight()

			if not self.isFold and not self.modifyMap[mo] then
				local insertIndex = groupTopIndex + i - 1

				self.modelInst:addAt(mo, insertIndex)
			end
		end

		self.modelInst:onModelUpdate()
	end
end

function SodacheHandbookViewFold:getEffectParams(isFold, mo, lastModifyMO)
	local orginLineHeight = mo:getLineHeight(not isFold)
	local targetLineHeight = mo:getLineHeight(isFold)
	local durationPerHeight = isFold and foldInDurationPerHeight or foldoutDurationPerHeight
	local duration = math.abs(targetLineHeight - orginLineHeight) * durationPerHeight

	duration = Mathf.Clamp(duration, minFadeAnimDuration, maxFadeAnimDuration)

	local effectParams = {
		mo = mo,
		isFold = isFold,
		orginLineHeight = orginLineHeight,
		targetLineHeight = targetLineHeight,
		duration = duration,
		lastModifyMO = lastModifyMO
	}

	return effectParams
end

function SodacheHandbookViewFold.onDispatchFadeAnimationEvent(effectParams)
	local isFold = effectParams.isFold
	local lastModifyMO = effectParams.lastModifyMO

	if isFold and lastModifyMO and not lastModifyMO.isGroupTop then
		SodacheHandbookListModel.instance:remove(lastModifyMO)
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnPlayGroupFadeAnim, effectParams)
end

local maxShowCount = 4

function SodacheHandbookViewFold:getCurRenderCellCount(subType, moList)
	local luaScrollView = self.viewContainer.scrollView
	local csListScrollView = luaScrollView:getCsScroll()
	local renderCellCount = 0

	if self.isFold then
		renderCellCount = self:getCurRenderCellCountWhileFoldOut(subType, moList, luaScrollView, csListScrollView)
	else
		renderCellCount = self:getCurRenderCellCountWhileFoldIn(moList, csListScrollView)
	end

	renderCellCount = Mathf.Clamp(renderCellCount, 1, maxShowCount)

	return renderCellCount
end

function SodacheHandbookViewFold:getCurRenderCellCountWhileFoldIn(moList, csListScrollView)
	local renderCellCount = 0
	local scrollPixel = csListScrollView.VerticalScrollPixel
	local viewHeight = recthelper.getHeight(csListScrollView.transform)
	local remainShowPixel = Mathf.Clamp(viewHeight - scrollPixel, 0, viewHeight)

	for i = 1, #moList do
		local mo = moList[i]
		local itemHeight = mo:getLineHeight(false)

		remainShowPixel = remainShowPixel - itemHeight
		renderCellCount = renderCellCount + 1

		if remainShowPixel <= 0 then
			break
		end
	end

	return renderCellCount
end

function SodacheHandbookViewFold:getCurRenderCellCountWhileFoldOut(subType, moList, listScrollView, csListScrollView)
	local cellDict = listScrollView._cellCompDict
	local renderCellMap = {}
	local renderCellCount = 0

	for cell, _ in pairs(cellDict) do
		local cellsubType = cell.mo.subType

		if cellsubType == subType then
			renderCellMap[cell.mo.id] = cell
		end
	end

	for i = 1, #moList do
		local mo = moList[i]
		local cellItem = renderCellMap[mo.id]
		local cellIndex = cellItem and cellItem._index - 1 or -1

		if not cellItem then
			break
		end

		if not csListScrollView:IsVisual(cellIndex) then
			break
		end

		renderCellCount = renderCellCount + 1
	end

	return renderCellCount
end

return SodacheHandbookViewFold
