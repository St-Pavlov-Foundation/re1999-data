-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgDraggingCmdFlow.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgDraggingCmdFlow", package.seeall)

local Base = ChgCmdFlowBase
local ChgDraggingCmdFlow = class("ChgDraggingCmdFlow", Base)
local abs = math.abs

local function _approximately(f0, f1, eps)
	return abs(f0 - f1) < (eps or 1e-06)
end

function ChgDraggingCmdFlow:ctor(...)
	Base.ctor(self, ...)

	if math.abs(self._diffInfo.deltaEnergy) > 0 then
		local fromEnergy = self._lastDisplayFrame.detectFinalEnergy
		local toEnergy = self._displayFrame.detectFinalEnergy
		local flow = ChgSimpleFlowSequence.New()
		local w1 = flow:addWork(ChgDragging_EditEnergyWork.s_create(fromEnergy, toEnergy))

		w1:setRootInternal(self)

		if toEnergy == 0 then
			local detectFinalEndItem = self._lastDisplayFrame.detectFinalEndItem

			if detectFinalEndItem then
				if detectFinalEndItem:isLine() then
					local ptItem = detectFinalEndItem:getNeighborItemByDir(self._displayFrame.lineItem:getDir())

					if not ptItem:isEnd() then
						local w2 = flow:addWork(FunctionWork.New(GameFacade.showToast, ToastEnum.ChgOnNoEnergy))

						w2:setRootInternal(self)
					end
				elseif not detectFinalEndItem:isEnd() then
					local w2 = flow:addWork(FunctionWork.New(GameFacade.showToast, ToastEnum.ChgOnNoEnergy))

					w2:setRootInternal(self)
				end
			else
				local w2 = flow:addWork(FunctionWork.New(GameFacade.showToast, ToastEnum.ChgOnNoEnergy))

				w2:setRootInternal(self)
			end
		end

		self:addWork(flow)
	end
end

function ChgDraggingCmdFlow:onStart()
	self:_debugOnScreen()
	self:_onDrawFrame()
	self:_tryPlayLoopSFX()
	self:_processDetectInfoList()
end

function ChgDraggingCmdFlow:_onDrawFrame()
	self._displayFrame.lineItem:setWidth(self._displayFrame.detectFinalWidth)

	if self._displayFrame.snapLineItem then
		self._displayFrame.snapLineItem:bindEnd(self._displayFrame.snapLineEndItem)
	end
end

function ChgDraggingCmdFlow:_tryPlayLoopSFX()
	local bTriggerPlayLoopSFX = self._displayFrame.deltaDistance > 0

	if self._lastDisplayFrame then
		if self._lastDisplayFrame.deltaDistance == 0 then
			bTriggerPlayLoopSFX = self._displayFrame.deltaDistance > 0
		elseif self._displayFrame.deltaDistance == 0 then
			bTriggerPlayLoopSFX = false
		end
	end

	if bTriggerPlayLoopSFX and not self._displayFrame.snapLineItem then
		bTriggerPlayLoopSFX = not _approximately(self._displayFrame.detectFinalWidth, self._lastDisplayFrame.detectFinalWidth)
	end

	self:triggerPlayLoopSFX(bTriggerPlayLoopSFX)
end

function ChgDraggingCmdFlow:_processDetectInfoList()
	for _, info in ipairs(self._displayFrame.detectInfoList) do
		local item = info.item

		self:_processDetectedItem(item)
	end
end

function ChgDraggingCmdFlow:_processDetectedItem(item)
	local mapObj = item:mapObj()

	if mapObj:isNone() then
		return
	end

	if mapObj:hasInvokedEffect() then
		return
	end

	local addHpFlow = FlowSequence.New()
	local startItem = self:startItem()
	local startObj = startItem:mapObj()
	local newHP = startObj:curHP()

	local function _addHpWorkHandler(_item)
		if not _item then
			return
		end

		local _mapObj = _item:mapObj()

		if _mapObj:hasInvokedEffect() then
			return
		end

		_mapObj:setHasInvokedEffect(true)
		_item:setInvoked(true)

		local effects = _mapObj:effects()

		for _, effect in ipairs(effects) do
			local tp = effect.type

			if tp == ChgEnum.PuzzleMazeEffectType.V3a4_AddStartHp then
				local addHP = tonumber(effect.param)
				local fromHP = newHP
				local toHP = newHP + addHP

				addHpFlow:addWork(ChgAddStartHPWork.s_create(startItem, fromHP, toHP))

				newHP = toHP
			end
		end
	end

	_addHpWorkHandler(item)

	local groupList = self:getGroupListByGroupId(mapObj:group())

	for _, gpMapObj in ipairs(groupList) do
		if mapObj ~= gpMapObj then
			local gpItem = self:getItemByKey(gpMapObj:key())

			_addHpWorkHandler(gpItem)
			gpMapObj:setHasSaved(true)
		end
	end

	if newHP ~= startObj:curHP() then
		startObj:setHP(newHP)
		addHpFlow:registerDoneListener(function(_refStartItem)
			_refStartItem:stopDeltaNumAnim()
			_refStartItem:_refreshNum()
		end, startItem)
	end

	local addHpFlowWorkList = addHpFlow:getWorkList() or {}

	if #addHpFlowWorkList > 0 then
		self:addWork(addHpFlow)
	end
end

function ChgDraggingCmdFlow:_debugOnScreen()
	if not ChgEnum.rDir then
		return
	end

	self:setText_txtTips(self._displayFrame.lineItem:debugStr())
	self:setText_txtNum(string.format("\n(%.2f, %.2f)\ndt: %.2f\ntot: %.2f", self._displayFrame.deltaV2.x, self._displayFrame.deltaV2.y, self._displayFrame.deltaDistance, self._displayFrame.detectFinalWidth))
end

return ChgDraggingCmdFlow
