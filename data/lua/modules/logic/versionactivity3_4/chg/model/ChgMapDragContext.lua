-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgMapDragContext.lua

local ti = table.insert
local sf = string.format
local string_rep = string.rep
local abs = math.abs
local _B = Bitwise

local function myAssert(...)
	local res = ...

	return res
end

local assert = isDebugBuild and _G.assert or myAssert
local MyDPadInput = _G.class("ChgMapDragContext_MyDPadInput")
local kMinSqrDistance = 100

function MyDPadInput:ctor(root)
	self._root = root
	self._totalDelta = Vector2.New(0, 0)

	self:clear()
end

function MyDPadInput:clear()
	self._totalDelta:Set(0, 0)

	self._totCaptureCount = 0
end

function MyDPadInput:snapshot(frameData)
	self._totalDelta = self._totalDelta + frameData.deltaV2
end

function MyDPadInput:isValid()
	return self._totalDelta:SqrMagnitude() > kMinSqrDistance
end

function MyDPadInput:peak()
	local deltaV2 = self._totalDelta
	local absX = abs(deltaV2.x)
	local absY = abs(deltaV2.y)
	local eDir = absY < absX and (deltaV2.x > 0 and ChgEnum.Dir.Right or ChgEnum.Dir.Left) or deltaV2.y > 0 and ChgEnum.Dir.Up or ChgEnum.Dir.Down

	return eDir, deltaV2
end

function MyDPadInput:pop()
	local eDir, deltaV2 = self:peak()
	local outV2 = deltaV2:Clone()

	self:clear()

	return eDir, outV2
end

local kCacheFrameCount = 3
local MyFrameData = _G.class("ChgMapDragContext_MyFrameData")

function MyFrameData:ctor(root)
	self._root = root
	self._ctx = root._ctx
	self._viewContainer = root._viewContainer
	self.deltaV2 = Vector2.New(0, 0)

	self:clear()
end

function MyFrameData:clear()
	self.frameIndex = -1
	self.dir = ChgEnum.Dir.None

	self.deltaV2:Set(0, 0)

	self.deltaDistance = 0
	self.isDirectionLocked = false
	self.lineItem = false
	self.startItem = false
	self.detectFinalEndItem = false
	self.detectFinalWidth = 0
	self.detectFinalEnergy = 0
	self.detectInfoList = {}
	self.detectVisitedKeyDict = {}
	self.snapLineItem = false
	self.snapLineEndItem = false
end

function MyFrameData:snapshot(dragObj)
	self:clear()

	local frameCount = self._root.frameCount

	self.frameIndex = frameCount

	local dragInfo = dragObj:dragInfo()

	self:_setupInput(dragInfo.dirHorV, dragInfo.deltaNorm)
	self:_startJudge()
end

function MyFrameData:_setupInput(eDir, deltaV2)
	self.dir = eDir

	self.deltaV2:Set(deltaV2.x, deltaV2.y)

	self.deltaDistance = ChgEnum.deltaV2ToDeltaDistance(eDir, deltaV2)
end

function MyFrameData:_setupByDeltaDistance(newDeltaDistance, eDir)
	eDir = eDir or self.dir
	self.dir = eDir
	self.deltaDistance = newDeltaDistance

	local newDeltaV2 = ChgEnum.deltaDistanceToDeltaV2(eDir, newDeltaDistance)

	self.deltaV2:Set(newDeltaV2.x, newDeltaV2.y)
end

function MyFrameData:_startJudge()
	if self.frameIndex == 1 then
		self:_defaultJudge()
	else
		self:_judgeByLastFrame()
	end
end

function MyFrameData:_defaultJudge()
	local eDir = self.dir
	local lastEnergy = self._root.editEnergy
	local lineItem = self._ctx:getOrCreateLineItem(nil, eDir, lastEnergy)

	if ChgEnum.rDir and not lineItem then
		self:dumpLog()
		assert(false)
	end

	local startItem = lineItem:startItem()
	local judgeInfo = self:_getJudgeInfo(startItem, eDir, self.deltaDistance, lastEnergy)
	local detectInfoList = judgeInfo.detectInfoList
	local detectFinalEndItem = judgeInfo.detectFinalEndItem

	self.startItem = startItem
	self.lineItem = lineItem
	self.detectFinalEndItem = detectFinalEndItem
	self.detectFinalEnergy = judgeInfo.endUpEnergy
	self.detectInfoList = detectInfoList
	self.detectFinalWidth = startItem:clampMovableDistance(eDir, self.deltaDistance)
end

function MyFrameData:_internal_diff_dirInfo(refInfo, rhs)
	refInfo.isSameDir = self.dir == rhs.dir
	refInfo.isFlipDir = ChgEnum.isFlipDir(self.dir, rhs.dir)
	refInfo.isParallelDir = refInfo.isSameDir or refInfo.isFlipDir
	refInfo.isPerpendicularDir = not refInfo.isParallelDir
end

function MyFrameData:_internal_diff_distInfo(refInfo, rhs)
	refInfo.diffDtDist = self.deltaDistance - rhs.deltaDistance
end

function MyFrameData:_internal_diff(rhs)
	local isValid = self.frameIndex > 0 and rhs.frameIndex > 0
	local info = {
		isValid = isValid
	}

	if not isValid then
		return info
	end

	self:_internal_diff_dirInfo(info, rhs)
	self:_internal_diff_distInfo(info, rhs)

	return info
end

function MyFrameData:_copyFrame(rhs)
	self.dir = rhs.dir
	self.deltaV2 = rhs.deltaV2
	self.deltaDistance = rhs.deltaDistance
	self.lineItem = rhs.lineItem
	self.startItem = rhs.startItem
	self.detectFinalEndItem = rhs.detectFinalEndItem
	self.detectFinalWidth = rhs.detectFinalWidth
	self.detectInfoList = rhs.detectInfoList
	self.detectFinalEnergy = rhs.detectFinalEnergy
	self.snapLineItem = rhs.snapLineItem
	self.snapLineEndItem = rhs.snapLineEndItem
end

function MyFrameData:_doWithoutInput(optNewDir)
	self.deltaV2:Set(0, 0)

	self.deltaDistance = 0

	if optNewDir then
		self.dir = optNewDir
	end
end

function MyFrameData:_copyFrame_WithoutInput(rhs)
	self:_copyFrame(rhs)
	self:_doWithoutInput()

	self.snapLineItem = false
	self.snapLineEndItem = false
end

function MyFrameData:isVisited(...)
	return self._root:isVisited(...)
end

function MyFrameData:addVisit(...)
	self._root:addVisit(...)
end

function MyFrameData:addVisitByLine(...)
	self._root:addVisitByLine(...)
end

function MyFrameData:_getJudgeInfo(targetItem, eDir, deltaDistance, startUpEnergy)
	local detectInfoList = targetItem:getItemInfoListByVector(eDir, deltaDistance)
	local ptList = {}
	local checkPointList = {}
	local endUpEnergy = startUpEnergy or 0
	local breakIndex
	local isSnapToEnd = false

	for i, info in ipairs(detectInfoList) do
		local item = info.item
		local mapObj = item:mapObj()
		local isPt = item:isPoint()

		if mapObj:isObstacle() then
			breakIndex = i

			break
		end

		if self:isVisited(item, eDir) then
			breakIndex = i
			isSnapToEnd = true

			break
		end

		if mapObj:isCheckPoint() then
			ti(checkPointList, item)
		end

		if isPt then
			ti(ptList, item)

			if item ~= targetItem then
				endUpEnergy = endUpEnergy - 1

				if endUpEnergy <= 0 then
					breakIndex = i

					break
				end
			end
		end

		if mapObj:isEnd() then
			breakIndex = i

			break
		end
	end

	if breakIndex then
		local tot = #detectInfoList

		for i = breakIndex + 1, tot do
			table.remove(detectInfoList)
		end
	end

	local lastInfo = detectInfoList[#detectInfoList]
	local detectFinalEndItem = assert(lastInfo.item)

	isSnapToEnd = isSnapToEnd or endUpEnergy <= 0 or detectFinalEndItem:isObstacle() or detectFinalEndItem:isEnd()

	return {
		detectInfoList = detectInfoList,
		endUpEnergy = endUpEnergy,
		ptList = ptList,
		checkPointList = checkPointList,
		detectFinalEndItem = detectFinalEndItem,
		isSnapToEnd = isSnapToEnd
	}
end

function MyFrameData:_makeDetectData(lineItem, detectEnergy, lastFinalWidth, detectItem)
	local eDir = lineItem:getDir()
	local deltaDistance = self.deltaDistance

	self.lineItem = assert(lineItem)

	local startItem = lineItem:startItem()

	lastFinalWidth = lastFinalWidth or 0
	detectItem = detectItem or startItem
	detectEnergy = detectEnergy or lineItem:startEnergy()

	local detectItemFinalWidth = lineItem:calcDistFromStart(detectItem)
	local detectDistance = deltaDistance + math.max(0, lastFinalWidth - detectItemFinalWidth)
	local judgeInfo = self:_getJudgeInfo(detectItem, eDir, detectDistance, detectEnergy)
	local detectInfoList = judgeInfo.detectInfoList
	local detectFinalEnergy = judgeInfo.endUpEnergy
	local detectFinalEndItem = judgeInfo.detectFinalEndItem
	local isSnapToEnd = judgeInfo.isSnapToEnd

	self.startItem = startItem
	self.detectInfoList = detectInfoList
	self.detectFinalEndItem = detectFinalEndItem
	self.detectFinalEnergy = detectFinalEnergy

	if isSnapToEnd then
		self.detectFinalWidth = lineItem:calcDistFromStart(detectFinalEndItem)
	else
		self.detectFinalWidth = startItem:clampMovableDistance(eDir, lastFinalWidth + deltaDistance)
	end
end

function MyFrameData:_judgeWithSameDir(last, diffInfo)
	self:_myDPadInput():clear()
	self:_makeDetectData(last.lineItem, last.detectFinalEnergy, last.detectFinalWidth, last.detectFinalEndItem)
end

function MyFrameData:_judgeWithDiffDir(last, diffInfo)
	self:_myDPadInput():snapshot(self)

	if ChgEnum.rDir and not last.detectFinalEndItem then
		last:dumpLog()
		assert(false)
	end

	if self:_myDPadInput():isValid() then
		local peakDir, peakDeltaV2 = self:_myDPadInput():peak()
		local popDeltaDistance = ChgEnum.deltaV2ToDeltaDistance(self.dir, peakDeltaV2)

		if peakDir == self.dir or abs(popDeltaDistance - self.deltaDistance) > 10 then
			local popDir, popDeltaV2 = self:_myDPadInput():pop()

			self:_setupInput(popDir, popDeltaV2)
			self:_judgeWithDiffDirImpl(last)

			return
		end
	end

	self:_copyFrame_WithoutInput(last)
end

function MyFrameData:debug_dirStr(eDir)
	if ChgEnum.rDir then
		return ChgEnum.rDir[eDir or self.dir]
	end

	return ""
end

local kLineFastSnapDtDistF = 20
local kLineFastSnapDtDistB = 10

function MyFrameData:_judgeWithDiffDirImpl(last)
	local lastEnergy = self._root.editEnergy
	local lastEndItem = last.detectFinalEndItem
	local eDir = self.dir

	if not last:isValid() then
		self:_copyFrame_WithoutInput(last)

		return
	end

	if lastEndItem:isPoint() then
		self.snapLineItem = last.lineItem
		self.snapLineEndItem = lastEndItem

		local lastLineDir = last.lineItem:getDirStr()
		local bLastLineZero = last.lineItem:isZero()

		if bLastLineZero then
			lastLineDir = last.dir
		end

		if self.snapLineItem:isZero() and self.snapLineItem:startItem() ~= self.snapLineEndItem then
			self.snapLineItem:setWidth(0.1)
		end

		local lineItem = self._ctx:getOrCreateLineItem(lastEndItem, eDir, lastEnergy)

		if not lineItem._refLineItem then
			local newRefLineItem

			if self.snapLineEndItem == lastEndItem then
				newRefLineItem = self._ctx:recentValidLineItemBySpecificEnd(lastEndItem)
			else
				newRefLineItem = self._ctx:recentValidLineItem()
			end

			if newRefLineItem then
				local newRefLineDir = newRefLineItem:getDir()
				local _isSameDir, _isFlipDir = ChgEnum.isSameFlipDir(lastLineDir, newRefLineDir)

				if _isSameDir or _isFlipDir then
					lineItem:reset(newRefLineDir, newRefLineItem)

					if _isFlipDir then
						self:_doWithoutInput(newRefLineDir)
					end
				elseif newRefLineDir == eDir then
					lineItem:reset(eDir, newRefLineItem)
				elseif ChgEnum.isFlipDir(newRefLineDir, eDir) then
					lineItem:reset(newRefLineDir, newRefLineItem)
					self:_doWithoutInput(newRefLineDir)
				end
			end
		end

		self:_makeDetectData(lineItem)
	else
		local forwardItem = lastEndItem:getNeighborItemByDir(last.dir)
		local backwardItem = lastEndItem:getNeighborItemByDir(ChgEnum.simpleFlipDir(last.dir))
		local isExistsF = forwardItem ~= nil
		local isExistsB = backwardItem ~= nil
		local deltaDistanceF = isExistsF and last.lineItem:calcDistFromStart(forwardItem) or 1999999
		local deltaDistanceB = isExistsB and last.lineItem:calcDistFromStart(backwardItem) or 1999999
		local diffFOfLine = math.abs(deltaDistanceF - last.detectFinalWidth)
		local diffBOfLine = math.abs(deltaDistanceB - last.detectFinalWidth)
		local isAllowNormalSnap = diffFOfLine < kLineFastSnapDtDistF or diffBOfLine < kLineFastSnapDtDistB

		if not isAllowNormalSnap and kLineFastSnapDtDistF < self.deltaDistance then
			isAllowNormalSnap = true

			local newDeltaDistance = math.min(self.deltaDistance - kLineFastSnapDtDistF, kLineFastSnapDtDistF * 0.5)

			self:_setupByDeltaDistance(newDeltaDistance, eDir)
		end

		if isAllowNormalSnap then
			local isChooseF = diffFOfLine < diffBOfLine

			self.snapLineItem = last.lineItem

			local deltaEnergy = 0

			if isChooseF then
				deltaEnergy = deltaEnergy - 1
				self.snapLineEndItem = forwardItem
			else
				self.snapLineEndItem = backwardItem
			end

			if self.snapLineItem:isZero() and self.snapLineItem:startItem() ~= self.snapLineEndItem then
				self.snapLineItem:setWidth(0.1)
			end

			local lineItem = self._ctx:getOrCreateLineItem(self.snapLineEndItem, eDir, lastEnergy + deltaEnergy)

			self:_makeDetectData(lineItem)
		else
			self:_copyFrame_WithoutInput(last)
		end
	end
end

function MyFrameData:_judgeByLastFrame()
	local last = self._root:lastFrame()
	local diffInfo = self:_internal_diff(last)
	local isSameDir = diffInfo.isSameDir
	local isFlipDir = diffInfo.isFlipDir

	if last.lineItem then
		isSameDir, isFlipDir = ChgEnum.isSameFlipDir(last.lineItem:getDir(), self.dir)
	end

	if last.detectFinalEnergy <= 0 or isFlipDir then
		self:_copyFrame_WithoutInput(last)

		return
	end

	if isSameDir then
		self:_judgeWithSameDir(last, diffInfo)
	else
		self:_judgeWithDiffDir(last, diffInfo)
	end

	self:_checkVisited(last)
end

function MyFrameData:_checkVisited(last)
	if not last then
		return
	end

	if last.lineItem == self.lineItem then
		return
	end

	local editLastSaved = self._root.editLastSaved
	local _, using = self._ctx:lastUsedAndUsing()

	if editLastSaved > using - 2 then
		return
	end

	local lineItemList = self._ctx:getValidLineItemListFromEnd(editLastSaved + 1, using)

	if #lineItemList < 2 then
		return
	end

	for i = 2, #lineItemList do
		local lineItem = lineItemList[i]
		local infoList = lineItem:getValidItemInfoList(true)
		local itemCount = #infoList

		for j, info in ipairs(infoList) do
			local item = info.item

			self:addVisitByLine(j, itemCount, lineItem:getDir(), item)
		end
	end

	self._root.editLastSaved = math.max(self._root.editLastSaved, using - 2)
end

function MyFrameData:dumpLog()
	local refStrBuf = {}

	self:dump(refStrBuf)
	logError(table.concat(refStrBuf, "\n"))
end

function MyFrameData:dump(refStrBuf, depth)
	if not ChgEnum.rDir then
		return
	end

	depth = depth or 0

	local tab = string_rep("\t", depth)
	local tab2 = string_rep("\t", depth + 1)
	local setColor = ChgTesting.setColorDesc
	local kYellow = ChgTesting.kYellow
	local kGreen = ChgTesting.kGreen

	ti(refStrBuf, tab .. "============ MyFrameData ============")
	ti(refStrBuf, tab .. sf("Frame: #%s", self.frameIndex))
	ti(refStrBuf, tab .. sf("Dir: %s", setColor(ChgEnum.rDir[self.dir], kYellow)))
	ti(refStrBuf, tab .. sf("deltaV2: { x = %.2f, y = %.2f}", self.deltaV2.x, self.deltaV2.y))
	ti(refStrBuf, tab .. sf("deltaDistance: %s", setColor(self.deltaDistance, kGreen)))

	if self.lineItem then
		ti(refStrBuf, tab .. sf("lineItem: %s(%s) w:%.2f", self.lineItem:name(), self.lineItem:getDirStr(), self.lineItem:getWidth()))
	else
		ti(refStrBuf, tab .. sf("lineItem: %s", setColor("Nil", kYellow)))
	end

	if self.startItem then
		ti(refStrBuf, tab .. sf("startItem: %s", setColor(self.startItem:debugName(), kYellow)))
	else
		ti(refStrBuf, tab .. sf("startItem: %s", setColor("Nil", kYellow)))
	end

	if self.detectFinalEndItem then
		ti(refStrBuf, tab .. sf("detectFinalEndItem: %s", setColor(self.detectFinalEndItem:debugName(), kYellow)))
	else
		ti(refStrBuf, tab .. sf("detectFinalEndItem: %s", setColor("Nil", kYellow)))
	end

	local strList = {}

	ti(refStrBuf, tab .. sf("#detectInfoList: %s", #self.detectInfoList))

	for i, info in ipairs(self.detectInfoList) do
		local item = info.item

		ti(strList, tab2 .. sf("%s: %s", i, item:debugName()))
	end

	if #strList > 0 then
		ti(refStrBuf, table.concat(strList, "\n"))
	end

	ti(refStrBuf, tab .. sf("detectFinalWidth: %s", setColor(self.detectFinalWidth, kYellow)))
	ti(refStrBuf, tab .. sf("detectFinalEnergy: %s", self.detectFinalEnergy))

	if self.snapLineItem then
		ti(refStrBuf, tab .. sf("snapLineItem: %s(%s) w:%.2f", self.snapLineItem:name(), self.snapLineItem:getDirStr(), self.snapLineItem:getWidth()))
	else
		ti(refStrBuf, tab .. sf("snapLineItem: %s", setColor("Nil", kYellow)))
	end

	if self.snapLineEndItem then
		ti(refStrBuf, tab .. sf("snapLineEndItem: %s", setColor(self.snapLineEndItem:debugName(), kYellow)))
	else
		ti(refStrBuf, tab .. sf("snapLineEndItem: %s", setColor("Nil", kYellow)))
	end
end

function MyFrameData:_myDPadInput()
	return self._root._myDPadInput
end

function MyFrameData:isValid()
	return self.frameIndex >= kCacheFrameCount
end

function MyFrameData:isDirNone()
	return self.dir == ChgEnum.Dir.None
end

function MyFrameData:getDirDeltaValue()
	if self:isDirNone() then
		return 0
	end

	return ChgEnum.isVertical(self.dir) and self.deltaV2.y or self.deltaV2.x
end

function MyFrameData:diff(rhs)
	local info = self:_internal_diff(rhs)

	if not info.isValid then
		return info
	end

	info.deltaEnergy = self.detectFinalEnergy - rhs.detectFinalEnergy

	return info
end

local MyData = _G.class("ChgMapDragContext_Data")

function MyData:ctor(ctx)
	assert(kCacheFrameCount >= 3)

	self._ctx = ctx
	self._viewContainer = ctx._viewContainer
	self._myDPadInput = MyDPadInput.New(self)
	self._frameDataList = {}

	for i = 0, kCacheFrameCount do
		self._frameDataList[i] = MyFrameData.New(self)
	end

	self:clearAllFrames()
end

function MyData:_onNewFrame()
	self.frameCount = self.frameCount + 1
end

function MyData:addVisit(item, eDir)
	if not item then
		return
	end

	local key = item:key()
	local newSaved = self.editVisitedKeyDict[key] or ChgEnum.Dir.None

	self.editVisitedKeyDict[key] = _B.set(newSaved, eDir)
end

function MyData:addVisitByLine(itemIndex, itemCount, lineDir, item)
	local isLast = itemIndex > 1 and itemIndex == itemCount
	local blockDir = isLast and ChgEnum.simpleFlipDir(lineDir) or lineDir

	self:addVisit(item, blockDir)

	if itemIndex > 1 and not isLast then
		self:addVisit(item, ChgEnum.Dir.All)
	end
end

function MyData:isVisited(item, lineDir)
	if not item then
		return false
	end

	if not lineDir then
		return false
	end

	local key = item:key()
	local saved = self.editVisitedKeyDict[key] or ChgEnum.Dir.None

	if _B.hasAny(saved, lineDir) then
		return true
	end

	if self._ctx:_roundMO():isVisited(key, lineDir) then
		return true
	end

	return false
end

function MyData:curFrame()
	local curFrameIndex = self.frameCount % kCacheFrameCount

	return self._frameDataList[curFrameIndex]
end

function MyData:lastFrame()
	local lastFrameIndex = (self.frameCount + kCacheFrameCount - 1) % kCacheFrameCount

	return self._frameDataList[lastFrameIndex]
end

function MyData:cacheFrame()
	local cacheFrameIndex = (self.frameCount + kCacheFrameCount - 2) % kCacheFrameCount

	return self._frameDataList[cacheFrameIndex]
end

function MyData:clearAllFrames()
	for i = 0, kCacheFrameCount do
		self._frameDataList[i]:clear()
	end

	self.frameCount = 0
	self.editVisitedKeyDict = {}
	self.editEnergy = self._viewContainer:curEnergy()
	self.editLastSaved = self._ctx:lastUsedAndUsing()
end

function MyData:_isZeroEnergy()
	local displayFrame = self:lastFrame()

	if displayFrame:isValid() then
		if displayFrame.detectFinalEnergy <= 0 then
			return true
		end
	elseif self.editEnergy <= 0 then
		return true
	end

	return false
end

function MyData:_isValidDrag()
	if self:_isZeroEnergy() then
		return false
	end

	return true
end

function MyData:resetToIdle()
	self._ctx:resetToIdle()
	self:clearAllFrames()
end

function MyData:onDragBegin(dragObj)
	self:resetToIdle()

	if not self:_isValidDrag() then
		if self:_isZeroEnergy() then
			GameFacade.showToast(ToastEnum.IconId, "TODO onDragBegin No Energy")
		end

		return
	end

	self._ctx:execDragBegin(self)
end

function MyData:onDrag(dragObj)
	if not self:_isValidDrag() then
		return
	end

	if self.frameCount <= kCacheFrameCount then
		self:_onDrag_CacheFrame(dragObj)
	else
		self:_onNewFrame()
		self:curFrame():snapshot(dragObj)
		self:_onDragImpl()
	end
end

function MyData:_onDrag_CacheFrame(dragObj)
	local dragInfo = dragObj:dragInfo()

	if dragObj:isDirNone() then
		return
	end

	local curDir = self._ctx:currentDir()

	if ChgEnum.isFlipDir(curDir, dragInfo.dirHorV) then
		return
	end

	self:_onNewFrame()
	self:curFrame():snapshot(dragObj)

	if self.frameCount == kCacheFrameCount then
		self._ctx:execDragging_FirstFrame(ChgDragBeginCmdFlow.New(self))
	end
end

function MyData:_onDragImpl()
	self._ctx:execDragging(ChgDraggingCmdFlow.New(self))
end

function MyData:onDragEnd(dragObj)
	if self.frameCount <= kCacheFrameCount then
		return
	end

	self:_onDragEndImpl()
end

function MyData:_onDragEndImpl()
	self._ctx:execDragEnd(ChgDragEndCmdFlow.New(self))
end

module("modules.logic.versionactivity3_4.chg.model.ChgMapDragContext", package.seeall)

local ChgMapDragContext = class("ChgMapDragContext", UserDataDispose)

function ChgMapDragContext:_mapMO()
	return ChgBattleModel.instance:mapMO()
end

function ChgMapDragContext:_roundMO()
	return self:_mapMO():curRoundMO()
end

function ChgMapDragContext:_lineSegmentList()
	return self._viewObj._lineSegmentList
end

function ChgMapDragContext:getOrCreateLineItem(...)
	return self:_lineSegmentList():getOrCreateLineItem(...)
end

function ChgMapDragContext:resetToIdle(...)
	return self:_lineSegmentList():resetToIdle(...)
end

function ChgMapDragContext:recentValidLineItem(...)
	return self:_lineSegmentList():recentValidLineItem(...)
end

function ChgMapDragContext:recentValidLineItemBySpecificEnd(...)
	return self:_lineSegmentList():recentValidLineItemBySpecificEnd(...)
end

function ChgMapDragContext:checkIsCompleted(...)
	return self:_lineSegmentList():checkIsCompleted(...)
end

function ChgMapDragContext:currentDir(...)
	return self:_lineSegmentList():currentDir(...)
end

function ChgMapDragContext:getAllVisitedCheckpointItemList(...)
	return self:_lineSegmentList():getAllVisitedCheckpointItemList(...)
end

function ChgMapDragContext:lastUsedAndUsing(...)
	return self:_lineSegmentList():lastUsedAndUsing(...)
end

function ChgMapDragContext:getValidLineItemListFromEnd(...)
	return self:_lineSegmentList():getValidLineItemListFromEnd(...)
end

function ChgMapDragContext:ctor()
	self:clear()
end

function ChgMapDragContext:clear()
	GameUtil.onDestroyViewMember_TweenId(self, "_previewTweenId")
	GameUtil.onDestroyViewMemberList(self, "_cmdFlowList")
	self:__onDispose()
	self:__onInit()

	self._enabled = false
	self._viewObj = false
	self._viewContainer = false
	self._isCompleted = false
	self._cmdFlowList = {}
end

function ChgMapDragContext:reset(current_V3a4_Chg_GameView)
	self:clear()

	self._viewObj = current_V3a4_Chg_GameView
	self._viewContainer = self._viewObj.viewContainer

	self._viewContainer:triggerPlayLoopSFX(false)
	self:setEnabled(true)
end

function ChgMapDragContext:onDragBegin(dragObj, userParams)
	self._viewContainer:triggerPlayLoopSFX(false)

	if not self._enabled then
		return
	end

	if not userParams._myData then
		userParams._myData = MyData.New(self)
	end

	userParams._myData:onDragBegin(dragObj)
end

function ChgMapDragContext:onDrag(dragObj, userParams)
	if not self._enabled then
		return
	end

	if userParams._myData then
		userParams._myData:onDrag(dragObj)
	end
end

function ChgMapDragContext:onDragEnd(dragObj, userParams)
	self._viewContainer:triggerPlayLoopSFX(false)

	if not self._enabled then
		return
	end

	if userParams._myData then
		userParams._myData:onDragEnd(dragObj)
	end
end

function ChgMapDragContext:execDragBegin(myData)
	return
end

function ChgMapDragContext:execDragging_FirstFrame(cmdFlow)
	self:_execImpl(cmdFlow)
end

function ChgMapDragContext:execDragging(cmdFlow)
	self:_execImpl(cmdFlow)
end

function ChgMapDragContext:execDragEnd(cmdFlow)
	self:_execImpl(cmdFlow)
end

function ChgMapDragContext:_execImpl(cmdFlow)
	ti(self._cmdFlowList, cmdFlow)
	cmdFlow:start(self)
end

function ChgMapDragContext:setEnabled(isEnabled)
	self._enabled = isEnabled and true or false
end

function ChgMapDragContext:_critical_beforeClear()
	if self._viewContainer then
		self._viewContainer:triggerPlayLoopSFX(false)
	end

	GameUtil.onDestroyViewMemberList(self, "_cmdFlowList")

	self._cmdFlowList = {}

	self:setEnabled(false)
end

function ChgMapDragContext:isCompleted()
	return self._isCompleted
end

function ChgMapDragContext:setCompleted()
	if self._isCompleted then
		return
	end

	self._isCompleted = true

	self:setEnabled(false)
	self._viewObj:completeRound()
end

return ChgMapDragContext
