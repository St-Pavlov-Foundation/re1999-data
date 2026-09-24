-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightSceneView.lua

module("modules.logic.matchgame.fight.view.MatchGameFightSceneView", package.seeall)

local MatchGameFightSceneView = class("MatchGameFightSceneView", BaseView)

function MatchGameFightSceneView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg")
	self._gohardBg = gohelper.findChild(self.viewGO, "root/#go_hardBg")
	self._gofeverPlane = gohelper.findChild(self.viewGO, "root/planeRoot/#go_feverPlane")
	self._goplane = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane")
	self._goplaneContent = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_planeContent")
	self._golineContent = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_lineContent")
	self._goelementContent = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_elementContent")
	self._goplaneItem = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_planeItem")
	self._goelementItem = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_elementItem")
	self._goclickMask = gohelper.findChild(self.viewGO, "#go_clickMask")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goroundTimeBar = gohelper.findChild(self.viewGO, "root/planeRoot/#go_roundTimeBar")
	self._imageroundTimeBar = gohelper.findChildImage(self.viewGO, "root/topInfo/#go_roundTimeBar/#image_roundTimeBar")
	self._txtroundTime = gohelper.findChildText(self.viewGO, "root/topInfo/#go_roundTimeBar/#txt_roundTime")
	self._gofeverNormal = gohelper.findChild(self.viewGO, "root/planeRoot/feverTimeBar/#go_feverNormal")
	self._gofeverFull = gohelper.findChild(self.viewGO, "root/planeRoot/feverTimeBar/#go_feverFull")
	self._goaddTime = gohelper.findChild(self.viewGO, "root/planeRoot/feverTimeBar/#go_feverFull/#go_addTime")
	self._txtaddTime = gohelper.findChildText(self.viewGO, "root/planeRoot/feverTimeBar/#go_feverFull/#go_addTime/#txt_addTime")
	self._imagefeverBar = gohelper.findChildImage(self.viewGO, "root/planeRoot/feverTimeBar/#image_feverBar")
	self._txtfeverNum = gohelper.findChildText(self.viewGO, "root/planeRoot/feverTimeBar/#txt_feverNum")
	self._gofever = gohelper.findChild(self.viewGO, "root/#go_fever")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameFightSceneView:addEvents()
	self:addEventCb(MatchGameController.instance, MatchGameFightEvent.ContinueGame, self.continueGame, self)
	self:addEventCb(MatchGameController.instance, MatchGameFightEvent.QuitGame, self.quitGame, self)
end

function MatchGameFightSceneView:removeEvents()
	self:removeEventCb(MatchGameController.instance, MatchGameFightEvent.ContinueGame, self.continueGame, self)
	self:removeEventCb(MatchGameController.instance, MatchGameFightEvent.QuitGame, self.quitGame, self)
end

function MatchGameFightSceneView:_editableInitView()
	self.planeItemMap = self:getUserDataTb_()
	self.lineItemMap = self:getUserDataTb_()
	self.elementItemMap = self:getUserDataTb_()
	self.curSelectItemMap = self:getUserDataTb_()
	self.curSelectItemList = self:getUserDataTb_()
	self.pendingMoveItemList = self:getUserDataTb_()
	self.lastMatchSelectPos = {}
	self.actId = MatchGameModel.instance:getCurActId()
	self.planeWidthNum = tonumber(MatchGameConfig.instance:getConstValue(self.actId, MatchGameFightEnum.ConstId.PlaneWidthNum))
	self.planeHeightNum = tonumber(MatchGameConfig.instance:getConstValue(self.actId, MatchGameFightEnum.ConstId.PlaneHeightNum))
	self.planeSizeWidth = self.planeWidthNum * MatchGameFightEnum.planeItemWidth + (self.planeWidthNum - 1) * MatchGameFightEnum.planeItemSpace

	recthelper.setSize(self._goplane.transform, self.planeSizeWidth, self.planeSizeWidth)
	gohelper.setActive(self._goplaneItem, false)
	gohelper.setActive(self._goelementItem, false)
	gohelper.setActive(self._goclickMask, false)

	self.UILineComp = self._golineContent:GetComponent(typeof(ZProj.UILine))
	self.isGameRunning = false
	self._imageroundTimeBar.fillAmount = 1
	self._imagefeverBar.fillAmount = 0
	self.curChainNum = 0
	self.isDragging = false
	self.maxChainNum = 0
	self.isRoundEnding = false

	gohelper.setActive(self._gofeverPlane, false)
	gohelper.setActive(self._gofever, false)

	self.feverPlaneAnim = self._gofeverPlane:GetComponent(typeof(UnityEngine.Animator))
	self.feverAnim = self._gofever:GetComponent(typeof(UnityEngine.Animator))
	self.feverFullAnim = self._gofeverFull:GetComponent(typeof(UnityEngine.Animator))
end

function MatchGameFightSceneView:onUpdateParam()
	return
end

function MatchGameFightSceneView:onOpen()
	self:initConfigData()
	self:refreshUI()
	self:setCloseOverrideFunc()
end

function MatchGameFightSceneView:initConfigData()
	self.episodeId = self.viewParam.episodeId
	self.gameInfoData = MatchGameFightModel.instance:getGameInfoData()
	self.gameInfoMo = {}
	self.gameInfoMo.maxFeverTime = self.gameInfoData.gameConfig.feverTime
	self.gameInfoMo.curFeverTime = self.gameInfoMo.maxFeverTime
	self.gameInfoMo.maxFeverNum = self.gameInfoData.gameConfig.feverCost
	self.gameInfoMo.curFeverNum = 0
	self.gameInfoMo.addRoundTime = 5
	self.gameInfoMo.maxRoundTime = self.gameInfoData.gameConfig.matchTime
	self.gameInfoMo.curRoundTime = self.gameInfoMo.maxRoundTime
	self.gameInfoMo.skillBuffMoMap = {}
	self.fightResult = MatchGameFightEnum.FightResult.None

	local episodeCo = lua_activity244_episode.configDict[self.episodeId]

	self._simagebg:LoadImage(ResUrl.getMatchGameSingleBg(episodeCo.episodeImage, "fight"))
	gohelper.setActive(self._gohardBg, episodeCo.isHard == 1)
end

function MatchGameFightSceneView:getViewContent()
	local fightView = self.viewContainer:getFightView()
	local skillView = self.viewContainer:getSkillView()

	return {
		fightView = fightView,
		sceneView = self,
		skillView = skillView
	}
end

function MatchGameFightSceneView:getGameInfoMo()
	return self.gameInfoMo
end

function MatchGameFightSceneView:refreshUI()
	self:createAndRefreshPlaneItem()
	self:createAndRefreshElementItem()
	self:refreshFeverUI()
	self:refreshRoundTime()
end

function MatchGameFightSceneView:createAndRefreshPlaneItem()
	for posXIndex = 1, self.planeWidthNum do
		for posYIndex = 1, self.planeHeightNum do
			self.planeItemMap[posXIndex] = self.planeItemMap[posXIndex] or {}

			local planeItem = self.planeItemMap[posXIndex][posYIndex]

			if not planeItem then
				planeItem = {
					go = gohelper.clone(self._goplaneItem, self._goplaneContent, "planeItem" .. posXIndex .. "_" .. posYIndex)
				}

				local initData = {
					posXIndex = posXIndex,
					posYIndex = posYIndex,
					planeSizeWidth = self.planeSizeWidth,
					sceneView = self
				}

				planeItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(planeItem.go, MatchGameFightPlaneItem, initData)
				planeItem.posXIndex = posXIndex
				planeItem.posYIndex = posYIndex
				planeItem.posX, planeItem.posY = MatchGameFightModel.instance:getPlaneItemAnchorPos(posXIndex, posYIndex)
				planeItem.btnclick = gohelper.findChildButtonWithAudio(planeItem.go, "btn_click")

				planeItem.btnclick:AddClickListener(self._btnPlaneItemOnClick, self, planeItem)
				CommonDragHelper.instance:registerDragObj(planeItem.go, self.onItemDragBegin, self.onItemDrag, self.onItemDragEnd, nil, self, planeItem, true)

				self.planeItemMap[posXIndex][posYIndex] = planeItem

				planeItem.comp:setPlaneItemPos()
			end

			gohelper.setActive(planeItem.go, true)
			planeItem.comp:refreshUI()
		end
	end
end

function MatchGameFightSceneView:createAndRefreshElementItem()
	for index, elementCo in pairs(self.gameInfoData.elementConfig) do
		local posIndexList = string.splitToNumber(elementCo.posIndex, "#")
		local posXIndex = posIndexList[1]
		local posYIndex = posIndexList[2]

		self.elementItemMap[posXIndex] = self.elementItemMap[posXIndex] or {}

		local elementItem = self.elementItemMap[posXIndex][posYIndex]

		if not elementItem then
			elementItem = {
				go = gohelper.clone(self._goelementItem, self._goelementContent, "elementItem" .. posXIndex .. "_" .. posYIndex)
			}

			local initData = {
				elementCo = elementCo,
				posXIndex = posXIndex,
				posYIndex = posYIndex,
				sceneView = self
			}

			elementItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(elementItem.go, MatchGameFightElementItem, initData)
			elementItem.posXIndex = posXIndex
			elementItem.posYIndex = posYIndex
			self.elementItemMap[posXIndex][posYIndex] = elementItem
		end

		gohelper.setActive(elementItem.go, true)
		elementItem.comp:refreshUI()
		elementItem.comp:updatePos(posXIndex, posYIndex)
		elementItem.comp:playAnim("open")
	end
end

function MatchGameFightSceneView:_btnPlaneItemOnClick(planeItem)
	self:setLastMatchSelectPos(nil)

	local clickPosXIndex = planeItem.posXIndex
	local clickPosYIndex = planeItem.posYIndex
	local elementItem = self.elementItemMap[clickPosXIndex] and self.elementItemMap[clickPosXIndex][clickPosYIndex]

	if elementItem and elementItem.comp.lockState then
		return
	end

	self.isFeverState = MatchGameFightModel.instance:getisFeverState()

	if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bomb then
		if not self.isGameRunning then
			self:startRoundTime()
		end

		self:doBombMatchAnim(elementItem)
	elseif elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Cure then
		elementItem.comp:setMatchEffectType(MatchGameFightEnum.ItemMatchEffect.Heal)
		self:doElementCureHeroAnim(elementItem, true)

		self.curChainNum = self.curChainNum + 1
		self.maxChainNum = Mathf.Max(self.maxChainNum, self.curChainNum)

		MatchGameFightModel.instance:setMaxChainNum(self.maxChainNum)
		self:updateChainNumUI(true)

		if not self.isGameRunning then
			self:startRoundTime()
		end
	elseif elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and self.isFeverState then
		self:doFeverBeadMatch(elementItem)
	end
end

function MatchGameFightSceneView:onItemDragBegin(planeItem, pointerEventData)
	self:setLastMatchSelectPos(nil)

	self.isDragging = true
	self.lastDragAnchorX, self.lastDragAnchorY = self:getMouseAnchorPos(pointerEventData.pressPosition)
	self.lastDragPosXIndex, self.lastDragPosYIndex = self:getMousePosIndex(self.lastDragAnchorX, self.lastDragAnchorY)
	self.curSelectItemMap[self.lastDragPosXIndex] = self.curSelectItemMap[self.lastDragPosXIndex] or {}

	local elementItem = self.elementItemMap[self.lastDragPosXIndex][self.lastDragPosYIndex]

	if not self:checkCanDrag(elementItem) then
		return
	end

	if not self.curSelectItemMap[self.lastDragPosXIndex][self.lastDragPosYIndex] then
		table.insert(self.curSelectItemList, elementItem)
		elementItem.comp:setSelectState(true)
	end

	self.curSelectItemMap[self.lastDragPosXIndex][self.lastDragPosYIndex] = elementItem

	local anchorPosX, anchorPosY = MatchGameFightModel.instance:getPlaneItemAnchorPos(elementItem.posXIndex, elementItem.posYIndex)
	local linePosX = anchorPosX - self.planeSizeWidth / 2
	local linePosY = anchorPosY + self.planeSizeWidth / 2

	self.UILineComp:SetPointAt(0, linePosX, linePosY)
end

function MatchGameFightSceneView:onItemDrag(planeItem, pointerEventData)
	local lastElementItem = self.elementItemMap[self.lastDragPosXIndex][self.lastDragPosYIndex]

	if not self:checkCanDrag(lastElementItem) then
		return
	end

	local len = pointerEventData.delta:Magnitude()
	local stepLen = 15
	local lerpCount = math.ceil(len / stepLen)

	if lerpCount > 1 then
		local prePos = pointerEventData.position - pointerEventData.delta

		for i = 1, lerpCount do
			local lerpPos = Vector2.Lerp(prePos, pointerEventData.position, i / lerpCount)

			self:onRealDrag(lerpPos)
		end
	else
		self:onRealDrag(pointerEventData.position)
	end
end

function MatchGameFightSceneView:onRealDrag(pointerEventDataPos)
	self.isDragging = true
	self.curDragAnchorX, self.curDragAnchorY = self:getMouseAnchorPos(pointerEventDataPos)
	self.curDragPosXIndex, self.curDragPosYIndex = self:getMousePosIndex(self.curDragAnchorX, self.curDragAnchorY)

	if self:checkCanBeSelected() and self:checkIsInSelectDistance() then
		local curElementItem = self.elementItemMap[self.curDragPosXIndex][self.curDragPosYIndex]
		local alreadySelected = false

		for _, item in ipairs(self.curSelectItemList) do
			if item == curElementItem then
				alreadySelected = true

				break
			end
		end

		if not alreadySelected then
			self.curSelectItemMap[self.curDragPosXIndex] = self.curSelectItemMap[self.curDragPosXIndex] or {}
			self.curSelectItemMap[self.curDragPosXIndex][self.curDragPosYIndex] = curElementItem

			table.insert(self.curSelectItemList, curElementItem)

			local anchorPosX, anchorPosY = MatchGameFightModel.instance:getPlaneItemAnchorPos(curElementItem.posXIndex, curElementItem.posYIndex)
			local linePosX = anchorPosX - self.planeSizeWidth / 2
			local linePosY = anchorPosY + self.planeSizeWidth / 2

			self.UILineComp:SetPointAt(#self.curSelectItemList - 1, linePosX, linePosY)

			self.lastDragPosXIndex = self.curDragPosXIndex
			self.lastDragPosYIndex = self.curDragPosYIndex

			curElementItem.comp:setSelectState(true)
		elseif #self.curSelectItemList > 1 then
			local removedItem = self.curSelectItemList[#self.curSelectItemList]
			local removedLastItem = self.curSelectItemList[#self.curSelectItemList - 1]

			if removedLastItem.posXIndex == self.curDragPosXIndex and removedLastItem.posYIndex == self.curDragPosYIndex then
				table.remove(self.curSelectItemList)

				self.curSelectItemMap[removedItem.posXIndex][removedItem.posYIndex] = nil

				removedItem.comp:setSelectState(false)

				local lastElementItem = self.curSelectItemList[#self.curSelectItemList]

				self.UILineComp:SetPointCount(#self.curSelectItemList)

				self.lastDragPosXIndex = lastElementItem.posXIndex
				self.lastDragPosYIndex = lastElementItem.posYIndex
			end
		end
	end

	self:drawLine()
end

function MatchGameFightSceneView:checkCanBeSelected()
	local lastElementItem = self.elementItemMap[self.lastDragPosXIndex][self.lastDragPosYIndex]
	local curElementItem = self.elementItemMap[self.curDragPosXIndex][self.curDragPosYIndex]

	if not lastElementItem or not curElementItem then
		return false
	end

	if lastElementItem.itemType ~= curElementItem.itemType then
		return false
	end

	if curElementItem.comp.lockState then
		return false
	end

	local offsetXIndex = self.curDragPosXIndex - self.lastDragPosXIndex
	local offsetYIndex = self.curDragPosYIndex - self.lastDragPosYIndex
	local isInSelectRange = false

	for _, offset in ipairs(MatchGameFightEnum.EightRangeOffsetList) do
		if offsetXIndex == offset[1] and offsetYIndex == offset[2] then
			isInSelectRange = true

			break
		end
	end

	if isInSelectRange and lastElementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and curElementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and lastElementItem.comp.itemParam == curElementItem.comp.itemParam then
		return true
	end

	return false
end

function MatchGameFightSceneView:checkIsInSelectDistance()
	local curPlaneItem = self.planeItemMap[self.curDragPosXIndex][self.curDragPosYIndex]
	local curPlanePosVec = Vector2(curPlaneItem.posX, curPlaneItem.posY)
	local dragDistance = Vector2.Distance(curPlanePosVec, Vector2(self.curDragAnchorX, self.curDragAnchorY))

	return dragDistance <= MatchGameFightEnum.planeItemWidth / 2 * MatchGameFightEnum.DragAdsorbPower
end

function MatchGameFightSceneView:checkCanDrag(elementItem)
	if self.isFeverState or not elementItem or elementItem.comp.itemType ~= MatchGameFightEnum.ElementItemType.Bead or elementItem.comp.lockState or self._goclickMask.activeSelf or self.isRoundEnding then
		return false
	end

	return true
end

function MatchGameFightSceneView:drawLine()
	local curDragLinePosX = self.curDragAnchorX - self.planeSizeWidth / 2
	local curDragLinePosY = self.curDragAnchorY + self.planeSizeWidth / 2

	self.UILineComp:SetPointAt(#self.curSelectItemList, curDragLinePosX, curDragLinePosY)
end

function MatchGameFightSceneView:onItemDragEnd(planeItem, pointerEventData)
	self.UILineComp:SetPointCount(0)

	if #self.curSelectItemList >= MatchGameFightEnum.MinMatchCount then
		for _, elementItem in ipairs(self.curSelectItemList) do
			elementItem.comp:setMatchEffectType(MatchGameFightEnum.ItemMatchEffect.MatchNormal)
		end

		self:setLastMatchSelectPos({
			posXIndex = self.curSelectItemList[#self.curSelectItemList].posXIndex,
			posYIndex = self.curSelectItemList[#self.curSelectItemList].posYIndex
		})
		self:doMatchAnim()

		if not self.isGameRunning then
			self:startRoundTime()
		end

		self.curChainNum = self.curChainNum + 1
		self.maxChainNum = Mathf.Max(self.maxChainNum, self.curChainNum)

		MatchGameFightModel.instance:setMaxChainNum(self.maxChainNum)
		self:updateChainNumUI(true)

		local params = {
			conditionId = MatchGameFightEnum.SkillConditionType.OnMatchCountMoreThan
		}

		MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnMatchCountMoreThanCondition, params)
	else
		for _, elementItem in ipairs(self.curSelectItemList) do
			elementItem.comp:setSelectState(false)
		end
	end

	self.curSelectItemMap = {}
	self.curSelectItemList = {}
	self.isDragging = false
end

function MatchGameFightSceneView:setLastMatchSelectPos(posData)
	self.lastMatchSelectPos = posData
end

function MatchGameFightSceneView:getLastMatchSelectPos()
	return self.lastMatchSelectPos
end

function MatchGameFightSceneView:doSkillMatchAnim(skillMatchMap, canAddFever, canAddEnergy, onlyRemove)
	gohelper.setActive(self._goclickMask, true)

	self.matchMoveFillSequence = FlowSequence.New()

	self.matchMoveFillSequence:addWork(FunctionWork.New(MatchGameFightSceneView.skillMatchSelectItem, {
		self,
		skillMatchMap,
		canAddFever,
		canAddEnergy,
		onlyRemove
	}))
	self.matchMoveFillSequence:addWork(TimerWork.New(MatchGameFightEnum.MatchSelectItemToCreateTime))
	self.matchMoveFillSequence:addWork(FunctionWork.New(MatchGameFightSceneView.createElementItem, {
		self
	}))
	self.matchMoveFillSequence:addWork(MatchGameElementItemMoveFillWork.New(self.elementItemMap))
	self.matchMoveFillSequence:addWork(TimerWork.New(MatchGameFightEnum.MatchMoveFillDoneTime))
	self.matchMoveFillSequence:registerDoneListener(self.onMatchMoveFillDone, self)
	self.matchMoveFillSequence:start()
end

function MatchGameFightSceneView.skillMatchSelectItem(params)
	local self = params[1]
	local skillMatchElementMap, canAddFever, canAddEnergy, onlyRemove = params[2], params[3], params[4], params[5]
	local skillMatchElementCount = tabletool.len(skillMatchElementMap)
	local matchEffectType = MatchGameFightEnum.ItemMatchEffect.MatchNormal

	for posXIndex, elementMap in pairs(skillMatchElementMap) do
		for posYIndex, elementItem in pairs(elementMap) do
			elementItem.comp:setMatchEffectType(matchEffectType)
			table.insert(self.curSelectItemList, elementItem)
		end
	end

	for _, elementItem in ipairs(self.curSelectItemList) do
		elementItem.comp:doPlayRemoveElementAnim()
	end

	if not onlyRemove then
		local setBoxBrokenMap = self:getMatchSelectItemNearBox()

		for posXIndex, itemDataMap in pairs(setBoxBrokenMap) do
			for posYIndex, elementItem in pairs(itemDataMap) do
				elementItem.comp:reduceBoxBrokenCount(1, false)
			end
		end

		if canAddFever and not self.isFeverState then
			local addFeverNum = 0

			for index, elementItem in ipairs(self.curSelectItemList) do
				if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and not elementItem.comp.lockState then
					addFeverNum = addFeverNum + 1
				end
			end

			self:addFeverNum(addFeverNum)
		end

		if canAddEnergy then
			self:updateHeroEnergy(skillMatchElementMap)
		end

		self:updateHeroDamage(skillMatchElementMap)
		self:doHeroDebuffHurtAnim(skillMatchElementMap)
		self:checkFeverAndAddRoundTime()
		MatchGameController.instance:dispatchEvent(MatchGameFightEvent.RefreshTargetGoal)
	end

	self.curSelectItemMap = {}
	self.curSelectItemList = {}
end

function MatchGameFightSceneView:doMatchAnim()
	gohelper.setActive(self._goclickMask, true)

	self.matchMoveFillSequence = FlowSequence.New()

	self.matchMoveFillSequence:addWork(FunctionWork.New(MatchGameFightSceneView.matchSelectItem, {
		self
	}))
	self.matchMoveFillSequence:addWork(TimerWork.New(MatchGameFightEnum.MatchSelectItemToCreateTime))
	self.matchMoveFillSequence:addWork(FunctionWork.New(MatchGameFightSceneView.createElementItem, {
		self
	}))
	self.matchMoveFillSequence:addWork(MatchGameElementItemMoveFillWork.New(self.elementItemMap))
	self.matchMoveFillSequence:addWork(TimerWork.New(MatchGameFightEnum.MatchMoveFillDoneTime))
	self.matchMoveFillSequence:registerDoneListener(self.onMatchMoveFillDone, self)
	self.matchMoveFillSequence:start()
end

function MatchGameFightSceneView.matchSelectItem(params)
	local self = params[1]

	for _, elementItem in ipairs(self.curSelectItemList) do
		elementItem.comp:playRemoveElementAnim()
	end

	local setBoxBrokenMap = self:getMatchSelectItemNearBox()

	for posXIndex, itemDataMap in pairs(setBoxBrokenMap) do
		for posYIndex, elementItem in pairs(itemDataMap) do
			elementItem.comp:reduceBoxBrokenCount(1, false)
		end
	end

	local setRemoveLockStateItemMap = self:getRemoveLockStateItemMap()
	local skillView = self.viewContainer:getSkillView()

	for posXIndex, itemDataMap in pairs(setRemoveLockStateItemMap) do
		for posYIndex, elementItem in pairs(itemDataMap) do
			MatchGameSkillBuffHandler.instance:removeTargetBuffByEffectType(elementItem.comp, MatchGameFightEnum.BuffEffectType.Seal, self:getViewContent())
		end
	end

	if not self.isFeverState then
		local addFeverNum = 0

		for index, elementItem in ipairs(self.curSelectItemList) do
			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and not elementItem.comp.lockState then
				addFeverNum = addFeverNum + 1
			end
		end

		self:addFeverNum(addFeverNum)
	end

	self:updateHeroDamage(self.curSelectItemMap)
	self:updateHeroEnergy(self.curSelectItemMap)
	self:doHeroDebuffHurtAnim(self.curSelectItemMap)

	self.curSelectItemMap = {}
	self.curSelectItemList = {}

	self:checkFeverAndAddRoundTime()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.RefreshTargetGoal)
end

function MatchGameFightSceneView:addFeverNum(addNum)
	if addNum == 0 then
		return
	end

	local lastFeverNum = self.gameInfoMo.curFeverNum

	self.gameInfoMo.curFeverNum = self.gameInfoMo.curFeverNum + addNum

	self:cleanFeverTimeTween()

	self.feverBarTweenId = ZProj.TweenHelper.DOTweenFloat(lastFeverNum, self.gameInfoMo.curFeverNum, MatchGameFightEnum.FeverBarChangeTime, self.refreshFeverUI, nil, self, nil, EaseType.Linear)
end

function MatchGameFightSceneView:getMatchSelectItemNearBox()
	local setBoxBrokenMap = {}

	for _, selectElementItem in ipairs(self.curSelectItemList) do
		for _, offsetData in ipairs(MatchGameFightEnum.FourRangeOffsetList) do
			local offsetXIndex = offsetData[1]
			local offsetYIndex = offsetData[2]
			local posXIndex = selectElementItem.posXIndex + offsetXIndex
			local posYIndex = selectElementItem.posYIndex + offsetYIndex

			if posXIndex >= 1 and posXIndex <= self.planeWidthNum and posYIndex >= 1 and posYIndex <= self.planeHeightNum then
				local elementItem = self.elementItemMap[posXIndex] and self.elementItemMap[posXIndex][posYIndex]

				if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Box then
					setBoxBrokenMap[elementItem.posXIndex] = setBoxBrokenMap[elementItem.posXIndex] or {}
					setBoxBrokenMap[elementItem.posXIndex][elementItem.posYIndex] = elementItem
				end
			end
		end
	end

	return setBoxBrokenMap
end

function MatchGameFightSceneView:getRemoveLockStateItemMap()
	local setRemoveLockStateItemMap = {}

	for _, selectElementItem in ipairs(self.curSelectItemList) do
		for _, offsetData in ipairs(MatchGameFightEnum.FourRangeOffsetList) do
			local offsetXIndex = offsetData[1]
			local offsetYIndex = offsetData[2]
			local posXIndex = selectElementItem.posXIndex + offsetXIndex
			local posYIndex = selectElementItem.posYIndex + offsetYIndex

			if posXIndex >= 1 and posXIndex <= self.planeWidthNum and posYIndex >= 1 and posYIndex <= self.planeHeightNum then
				local elementItem = self.elementItemMap[posXIndex] and self.elementItemMap[posXIndex][posYIndex]

				if elementItem and elementItem.comp.itemType ~= MatchGameFightEnum.ElementItemType.Box and elementItem.comp.lockState then
					setRemoveLockStateItemMap[elementItem.posXIndex] = setRemoveLockStateItemMap[elementItem.posXIndex] or {}
					setRemoveLockStateItemMap[elementItem.posXIndex][elementItem.posYIndex] = elementItem
				end
			end
		end
	end

	return setRemoveLockStateItemMap
end

function MatchGameFightSceneView.createElementItem(params)
	local self = params[1]

	self.fillRounds = MatchGameFightModel.instance:computeGravityAndFill(self.elementItemMap)

	self:markFinalArriveMove()

	self.curRoundIndex = 0

	self:playNextFillRound()
end

function MatchGameFightSceneView:markFinalArriveMove()
	if not self.fillRounds then
		return
	end

	local moveOutRoundMap = {}

	for roundIndex, round in ipairs(self.fillRounds) do
		for _, move in ipairs(round) do
			if not move.isNew then
				local fromKey = move.fromX * (self.planeWidthNum + 1) + move.fromY

				moveOutRoundMap[fromKey] = moveOutRoundMap[fromKey] or {}

				table.insert(moveOutRoundMap[fromKey], roundIndex)
			end
		end
	end

	for roundIndex, round in ipairs(self.fillRounds) do
		for _, move in ipairs(round) do
			local toKey = move.toX * (self.planeWidthNum + 1) + move.toY
			local hasNextMove = false

			for _, moveOutRoundIndex in ipairs(moveOutRoundMap[toKey] or {}) do
				if roundIndex < moveOutRoundIndex then
					hasNextMove = true

					break
				end
			end

			move.isFinalArrive = not hasNextMove
		end
	end
end

function MatchGameFightSceneView:playNextFillRound()
	self.curRoundIndex = self.curRoundIndex + 1

	local round = self.fillRounds and self.fillRounds[self.curRoundIndex]

	if not round then
		self.fillRounds = nil

		self:onAllMovesFinished()

		return
	end

	self.pendingMoveCount = #round

	if self.pendingMoveCount == 0 then
		self:playNextFillRound()

		return
	end

	for _, move in ipairs(round) do
		if not move.isNew then
			local elementItem = self.elementItemMap[move.fromX] and self.elementItemMap[move.fromX][move.fromY]

			if elementItem then
				self.elementItemMap[move.fromX][move.fromY] = nil
				self.pendingMoveItemList[#self.pendingMoveItemList + 1] = {
					item = elementItem,
					move = move
				}
			else
				self:onElementMoveStepDone()
			end
		end
	end

	for _, data in ipairs(self.pendingMoveItemList) do
		local elementItem = data.item
		local move = data.move

		self.elementItemMap[move.toX] = self.elementItemMap[move.toX] or {}
		self.elementItemMap[move.toX][move.toY] = elementItem
		elementItem.posXIndex = move.toX
		elementItem.posYIndex = move.toY

		elementItem.comp:doItemAnchorPosMove(move.toX, move.toY, move.isFinalArrive)
	end

	self.pendingMoveItemList = {}

	for _, move in ipairs(round) do
		if move.isNew then
			self:spawnNewElementItem(move)
		end
	end
end

function MatchGameFightSceneView:onElementMoveStepDone()
	if not self.pendingMoveCount then
		return
	end

	self.pendingMoveCount = self.pendingMoveCount - 1

	if self.pendingMoveCount <= 0 then
		self.pendingMoveCount = nil

		self:playNextFillRound()
	end
end

function MatchGameFightSceneView:spawnNewElementItem(move)
	local elementCo = {
		itemType = move.itemType,
		param = move.itemParam,
		posIndex = move.toX .. "#" .. move.toY
	}
	local elementItem = {}

	elementItem.go = gohelper.clone(self._goelementItem, self._goelementContent, "elementItem" .. move.toX .. "_" .. move.toY)

	local initData = {
		elementCo = elementCo,
		posXIndex = move.toX,
		posYIndex = move.toY,
		sceneView = self
	}

	elementItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(elementItem.go, MatchGameFightElementItem, initData)
	elementItem.posXIndex = move.toX
	elementItem.posYIndex = move.toY
	self.elementItemMap[move.toX] = self.elementItemMap[move.toX] or {}
	self.elementItemMap[move.toX][move.toY] = elementItem

	gohelper.setActive(elementItem.go, true)
	elementItem.comp:refreshUI()

	local spawnPosX, spawnPosY = MatchGameFightModel.instance:getPlaneItemAnchorPos(move.spawnX, move.spawnY)

	recthelper.setAnchor(elementItem.go.transform, spawnPosX, spawnPosY)

	elementItem.comp.posXIndex = move.spawnX
	elementItem.comp.posYIndex = move.spawnY

	elementItem.comp:doItemAnchorPosMove(move.toX, move.toY, move.isFinalArrive)
end

function MatchGameFightSceneView:onAllMovesFinished()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.MoveFillElementItemFinish)
end

function MatchGameFightSceneView:onMatchMoveFillDone()
	gohelper.setActive(self._goclickMask, false)
	self:setLastMatchSelectPos(nil)

	if self.isFeverState then
		self:refreshFeverStateElementUI()
	elseif self.gameInfoMo.curFeverNum >= self.gameInfoMo.maxFeverNum then
		self:startFeverState()
		self:refreshFeverStateElementUI()
	end

	self:checkNotMatchConvertElement()
end

function MatchGameFightSceneView:checkNotMatchConvertElement()
	TaskDispatcher.cancelTask(self.checkNotMatchConvertElementFinish, self)

	local nearSameBeadList = self:getNearSameBeadList()

	if #nearSameBeadList > 0 then
		return
	end

	for posXIndex, elementMap in pairs(self.elementItemMap) do
		for posYIndex, elementItem in pairs(elementMap) do
			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
				local newItemType, newItemParam = MatchGameFightModel.instance:getRandomBeadType(true)
				local elementId = MatchGameFightConfig.instance:getElementId(newItemType, newItemParam)

				elementItem.comp:convertToOtherElement(elementId)
			end
		end
	end

	self:makeMatchableBeadGroup()
	self:pauseGame()
	TaskDispatcher.runDelay(self.checkNotMatchConvertElementFinish, self, MatchGameFightEnum.NotMatchConvertTime)
end

function MatchGameFightSceneView:checkNotMatchConvertElementFinish()
	self:continueGame()

	if self.gameInfoMo.curFeverNum >= self.gameInfoMo.maxFeverNum then
		self:refreshFeverStateElementUI()
	end
end

function MatchGameFightSceneView:makeMatchableBeadGroup()
	local beadItemList = {}

	for posXIndex = 1, self.planeWidthNum do
		for posYIndex = 1, self.planeHeightNum do
			local elementItem = self.elementItemMap[posXIndex] and self.elementItemMap[posXIndex][posYIndex]

			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and not elementItem.comp.lockState then
				table.insert(beadItemList, elementItem)
			end
		end
	end

	local beadCount = #beadItemList

	if beadCount < MatchGameFightEnum.MinMatchCount then
		return
	end

	local startIndex = math.random(1, beadCount)
	local matchGroup

	for offsetIndex = 0, beadCount - 1 do
		local startItem = beadItemList[(startIndex + offsetIndex - 1) % beadCount + 1]

		matchGroup = self:getMatchableBeadGroup(startItem)

		if matchGroup then
			break
		end
	end

	if not matchGroup then
		return
	end

	local newItemType, newItemParam = MatchGameFightModel.instance:getRandomBeadType(true)
	local elementId = MatchGameFightConfig.instance:getElementId(newItemType, newItemParam)

	for _, elementItem in ipairs(matchGroup) do
		elementItem.comp:convertToOtherElement(elementId)
	end
end

function MatchGameFightSceneView:getMatchableBeadGroup(startItem)
	local matchGroup = {
		startItem
	}
	local isInGroupMap = {
		[self:getElementPosKey(startItem.posXIndex, startItem.posYIndex)] = true
	}
	local headIndex = 1

	while headIndex <= #matchGroup and #matchGroup < MatchGameFightEnum.MinMatchCount do
		local currentItem = matchGroup[headIndex]

		headIndex = headIndex + 1

		for _, offset in ipairs(MatchGameFightEnum.EightRangeOffsetList) do
			local posXIndex = currentItem.posXIndex + offset[1]
			local posYIndex = currentItem.posYIndex + offset[2]
			local posKey = self:getElementPosKey(posXIndex, posYIndex)

			if not isInGroupMap[posKey] then
				local elementItem = self.elementItemMap[posXIndex] and self.elementItemMap[posXIndex][posYIndex]

				if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and not elementItem.comp.lockState then
					isInGroupMap[posKey] = true

					table.insert(matchGroup, elementItem)

					if #matchGroup >= MatchGameFightEnum.MinMatchCount then
						break
					end
				end
			end
		end
	end

	if #matchGroup < MatchGameFightEnum.MinMatchCount then
		return nil
	end

	return matchGroup
end

function MatchGameFightSceneView:getElementPosKey(posXIndex, posYIndex)
	return posXIndex * (self.planeWidthNum + 1) + posYIndex
end

function MatchGameFightSceneView:checkFeverAndAddRoundTime()
	if self.gameInfoMo.curFeverNum >= self.gameInfoMo.maxFeverNum and not self.isFeverState then
		MatchGameFightModel.instance:setFeverState(true)
		gohelper.setActive(self._gofeverPlane, false)
		gohelper.setActive(self._gofeverPlane, true)
		gohelper.setActive(self._gofever, false)
		gohelper.setActive(self._gofever, true)

		self.gameInfoMo.curRoundTime = self.gameInfoMo.curRoundTime + self.gameInfoMo.addRoundTime
		self.gameInfoMo.maxRoundTime = Mathf.Max(self.gameInfoMo.maxRoundTime, self.gameInfoMo.curRoundTime)

		self:startRoundTime()
	end
end

function MatchGameFightSceneView:doBombMatchAnim(elementItem)
	gohelper.setActive(self._goclickMask, true)
	self:pauseGame()

	self.bombMatchSequence = FlowSequence.New()

	self.bombMatchSequence:addWork(FunctionWork.New(MatchGameFightSceneView.bombSelectItem, {
		self,
		elementItem
	}))
	self.bombMatchSequence:addWork(MatchGameElementBombWork.New())
	self.bombMatchSequence:addWork(TimerWork.New(MatchGameFightEnum.ClickToCreateTime))
	self.bombMatchSequence:addWork(FunctionWork.New(MatchGameFightSceneView.createElementItem, {
		self
	}))
	self.bombMatchSequence:addWork(MatchGameElementItemMoveFillWork.New(self.elementItemMap))
	self.bombMatchSequence:addWork(TimerWork.New(MatchGameFightEnum.MatchMoveFillDoneTime))
	self.bombMatchSequence:registerDoneListener(self.onMatchMoveFillDone, self)
	self.bombMatchSequence:start()
end

function MatchGameFightSceneView.bombSelectItem(params)
	local self = params[1]
	local bombElementItem = params[2]

	self.hasBombElementItemMap = {}
	self.pendingBombList = {}

	self:addWaitingBomb(bombElementItem)
	self:playNextBombRound()
end

function MatchGameFightSceneView:addWaitingBomb(bombItem)
	if not bombItem then
		return
	end

	local posX = bombItem.posXIndex
	local posY = bombItem.posYIndex

	if self.hasBombElementItemMap[posX] and self.hasBombElementItemMap[posX][posY] then
		return
	end

	self.hasBombElementItemMap[posX] = self.hasBombElementItemMap[posX] or {}
	self.hasBombElementItemMap[posX][posY] = bombItem

	bombItem.comp:setMatchEffectType(MatchGameFightEnum.ItemMatchEffect.Bomb)
	table.insert(self.pendingBombList, bombItem)
end

function MatchGameFightSceneView:playNextBombRound()
	if not self.pendingBombList or #self.pendingBombList == 0 then
		TaskDispatcher.cancelTask(self.playNextBombRound, self)
		self:continueGame()
		MatchGameController.instance:dispatchEvent(MatchGameFightEvent.BombElementItemFinish)
		self:updateHeroDamage(self.hasBombElementItemMap)
		self:updateHeroEnergy(self.hasBombElementItemMap)
		self:doHeroDebuffHurtAnim(self.hasBombElementItemMap)

		local removeBeadItemNum = 0

		for posXIndex, elementItemMap in pairs(self.hasBombElementItemMap) do
			for posYIndex, elementItem in pairs(elementItemMap) do
				if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and not elementItem.comp.lockState then
					removeBeadItemNum = removeBeadItemNum + 1
				end
			end
		end

		if not self.isFeverState then
			self:addFeverNum(removeBeadItemNum)
		end

		self:checkFeverAndAddRoundTime()

		self.hasBombElementItemMap = {}
		self.pendingBombList = nil

		MatchGameController.instance:dispatchEvent(MatchGameFightEvent.RefreshTargetGoal)

		return
	end

	local currentBombs = self.pendingBombList

	self.pendingBombList = {}

	for _, bombItem in ipairs(currentBombs) do
		self:removeBombItem(bombItem)
	end

	TaskDispatcher.runDelay(self.playNextBombRound, self, MatchGameFightEnum.PlayNextBombRoundTime)
end

function MatchGameFightSceneView:removeBombItem(bombItem)
	bombItem.comp:playRemoveElementAnim()

	self.curChainNum = self.curChainNum + 1
	self.maxChainNum = Mathf.Max(self.maxChainNum, self.curChainNum)

	MatchGameFightModel.instance:setMaxChainNum(self.maxChainNum)
	self:updateChainNumUI(true)

	self.hasBombElementItemMap[bombItem.posXIndex] = self.hasBombElementItemMap[bombItem.posXIndex] or {}
	self.hasBombElementItemMap[bombItem.posXIndex][bombItem.posYIndex] = bombItem

	local bombRangeOffsetList = self:getBombRangeOffsetList()

	for _, offset in ipairs(bombRangeOffsetList) do
		local posXIndex = bombItem.posXIndex + offset[1]
		local posYIndex = bombItem.posYIndex + offset[2]

		if posXIndex >= 1 and posXIndex <= self.planeWidthNum and posYIndex >= 1 and posYIndex <= self.planeHeightNum then
			local elementItem = self.elementItemMap[posXIndex] and self.elementItemMap[posXIndex][posYIndex]
			local isItemHasBomb = self.hasBombElementItemMap[posXIndex] and self.hasBombElementItemMap[posXIndex][posYIndex]

			if elementItem and not isItemHasBomb then
				if elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bomb then
					self:addWaitingBomb(elementItem)
				elseif elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Box then
					self:showElementEffect(MatchGameFightEnum.ItemMatchEffect.Bomb, posXIndex, posYIndex)

					local dropElementType = elementItem.comp:reduceBoxBrokenCount(1, true)

					if not dropElementType or dropElementType == MatchGameFightEnum.ElementItemType.Empty then
						self.hasBombElementItemMap[posXIndex] = self.hasBombElementItemMap[posXIndex] or {}
						self.hasBombElementItemMap[posXIndex][posYIndex] = elementItem
					end
				elseif elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Cure then
					elementItem.comp:setMatchEffectType(MatchGameFightEnum.ItemMatchEffect.Heal)
					self:doElementCureHeroAnim(elementItem, false)

					self.hasBombElementItemMap[posXIndex] = self.hasBombElementItemMap[posXIndex] or {}
					self.hasBombElementItemMap[posXIndex][posYIndex] = elementItem
				else
					elementItem.comp:setMatchEffectType(MatchGameFightEnum.ItemMatchEffect.Bomb)
					elementItem.comp:playRemoveElementAnim()

					self.hasBombElementItemMap[posXIndex] = self.hasBombElementItemMap[posXIndex] or {}
					self.hasBombElementItemMap[posXIndex][posYIndex] = elementItem
				end
			end
		end
	end
end

function MatchGameFightSceneView:setBombRangeOffsetList(bombRangeOffsetList)
	self.bombRangeOffsetList = bombRangeOffsetList
end

function MatchGameFightSceneView:getBombRangeOffsetList()
	return self.bombRangeOffsetList or MatchGameFightEnum.FourRangeOffsetList
end

function MatchGameFightSceneView:doElementCureHeroAnim(elementItem, needCreateElement)
	if needCreateElement then
		gohelper.setActive(self._goclickMask, true)

		self.cureMatchSequence = FlowSequence.New()

		self.cureMatchSequence:addWork(FunctionWork.New(MatchGameFightSceneView.doCureHero, {
			self,
			elementItem
		}))
		self.cureMatchSequence:addWork(TimerWork.New(MatchGameFightEnum.ClickToCreateTime))
		self.cureMatchSequence:addWork(FunctionWork.New(MatchGameFightSceneView.createElementItem, {
			self
		}))
		self.cureMatchSequence:addWork(MatchGameElementItemMoveFillWork.New(self.elementItemMap))
		self.cureMatchSequence:addWork(TimerWork.New(MatchGameFightEnum.MatchMoveFillDoneTime))
		self.cureMatchSequence:registerDoneListener(self.onMatchMoveFillDone, self)
		self.cureMatchSequence:start()
	else
		elementItem.comp:playRemoveElementAnim()
		self:OnCureElementCureHero()
	end
end

function MatchGameFightSceneView.doCureHero(params)
	local self, elementItem = params[1], params[2]

	self:OnCureElementCureHero()
	elementItem.comp:playRemoveElementAnim()
	table.insert(self.curSelectItemList, elementItem)

	local setBoxBrokenMap = self:getMatchSelectItemNearBox()

	for posXIndex, itemDataMap in pairs(setBoxBrokenMap) do
		for posYIndex, elementItem in pairs(itemDataMap) do
			elementItem.comp:reduceBoxBrokenCount(1, false)
		end
	end

	local setRemoveLockStateItemMap = self:getRemoveLockStateItemMap()

	for posXIndex, itemDataMap in pairs(setRemoveLockStateItemMap) do
		for posYIndex, elementItem in pairs(itemDataMap) do
			MatchGameSkillBuffHandler.instance:removeTargetBuffByEffectType(elementItem.comp, MatchGameFightEnum.BuffEffectType.Seal, self:getViewContent())
		end
	end

	self.curSelectItemList = {}
end

function MatchGameFightSceneView:OnCureElementCureHero()
	local fightView = self.viewContainer:getFightView()

	if fightView then
		fightView:onCureElementCureHero()
	end
end

function MatchGameFightSceneView:refreshFeverStateElementUI()
	self.isFeverState = MatchGameFightModel.instance:getisFeverState()

	local nearSameBeadList = self:getNearSameBeadList()

	for posXIndex = 1, self.planeWidthNum do
		for posYIndex = 1, self.planeHeightNum do
			local elementItem = self.elementItemMap[posXIndex] and self.elementItemMap[posXIndex][posYIndex]

			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
				elementItem.comp:setFeverState(false)
			end
		end
	end

	for index, matchGroup in ipairs(nearSameBeadList) do
		for _, elementItem in ipairs(matchGroup) do
			elementItem.comp:setFeverState(self.isFeverState)
		end
	end

	if not self.isFeverState then
		self.curSelectItemMap = {}
		self.curSelectItemList = {}
	end
end

function MatchGameFightSceneView:startFeverState()
	local feverState = MatchGameFightModel.instance:getisFeverState()

	if not feverState then
		gohelper.setActive(self._gofeverPlane, false)
		gohelper.setActive(self._gofever, false)
	end

	self.isFeverState = true

	MatchGameFightModel.instance:setFeverState(true)
	gohelper.setActive(self._gofeverPlane, true)
	gohelper.setActive(self._gofever, true)

	self.gameInfoMo.curFeverTime = self.gameInfoMo.maxFeverTime
	self.feverBarTweenId = ZProj.TweenHelper.DOTweenFloat(self.gameInfoMo.curFeverTime, 0, self.gameInfoMo.curFeverTime, self.refreshFeverUI, self.onFeverTimeEnd, self, nil, EaseType.Linear)

	local params = {
		conditionId = MatchGameFightEnum.SkillConditionType.OnFeverEnter
	}

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnFeverEnterCondition, params)
end

function MatchGameFightSceneView:refreshFeverUI(value)
	local feverNum = value or self.gameInfoMo.curFeverNum

	if value and self.isFeverState then
		self.gameInfoMo.curFeverTime = value
	end

	if self.lastFeverState == nil then
		self.lastFeverState = self.isFeverState
	end

	if self.lastFeverState and not self.isFeverState then
		self.feverFullAnim:Play("close", 0, 0)
		self.feverFullAnim:Update(0)
		TaskDispatcher.cancelTask(self.hideFeverFull, self)
		TaskDispatcher.runDelay(self.hideFeverFull, self, 0.233)
	elseif not self.lastFeverState and self.isFeverState then
		gohelper.setActive(self._gofeverFull, false)
		gohelper.setActive(self._gofeverFull, true)
	elseif self.isFeverState then
		gohelper.setActive(self._gofeverFull, true)
	end

	self.lastFeverState = self.isFeverState

	gohelper.setActive(self._gofeverNormal, not self.isFeverState)

	self._txtaddTime.text = string.format("+%ds", self.gameInfoMo.addRoundTime)

	if self.isFeverState then
		self._imagefeverBar.fillAmount = feverNum / self.gameInfoMo.maxFeverTime
		self._txtfeverNum.text = string.format("%d%%", math.floor(feverNum * 100) / self.gameInfoMo.maxFeverTime)

		UISpriteSetMgr.instance:setMatchGameSprite(self._imagefeverBar, "matchgamefight_fever_bar2")
	else
		self._imagefeverBar.fillAmount = Mathf.Min(feverNum, self.gameInfoMo.maxFeverNum) / self.gameInfoMo.maxFeverNum
		self._txtfeverNum.text = string.format("%d/%d", feverNum, self.gameInfoMo.maxFeverNum)

		UISpriteSetMgr.instance:setMatchGameSprite(self._imagefeverBar, "matchgamefight_fever_bar1")
	end
end

function MatchGameFightSceneView:hideFeverFull()
	gohelper.setActive(self._gofeverFull, false)
end

function MatchGameFightSceneView:onFeverTimeEnd()
	self.gameInfoMo.curFeverNum = 0
	self.gameInfoMo.maxFeverTime = self.gameInfoData.gameConfig.feverTime

	MatchGameFightModel.instance:setFeverState(false)
	self.feverPlaneAnim:Play("close", 0, 0)
	self.feverPlaneAnim:Update(0)
	self.feverAnim:Play("close", 0, 0)
	self.feverAnim:Update(0)
	TaskDispatcher.cancelTask(self.hideFeverPlane, self)
	TaskDispatcher.runDelay(self.hideFeverPlane, self, 0.33)

	self.isFeverState = false

	self:cleanFeverTimeTween()
	self:refreshFeverStateElementUI()
	self:refreshFeverUI()
end

function MatchGameFightSceneView:hideFeverPlane()
	gohelper.setActive(self._gofeverPlane, false)
	gohelper.setActive(self._gofever, false)
end

function MatchGameFightSceneView:doFeverBeadMatch(clickedElementItem)
	local nearSameBeadList = self:getNearSameBeadList()
	local feverGroupIndex = 0

	for index, matchGroup in ipairs(nearSameBeadList) do
		for _, elementItem in ipairs(matchGroup) do
			if elementItem.posXIndex == clickedElementItem.posXIndex and elementItem.posYIndex == clickedElementItem.posYIndex then
				feverGroupIndex = index

				break
			end
		end
	end

	if feverGroupIndex > 0 then
		gohelper.setActive(self._goclickMask, true)

		local matchGroup = nearSameBeadList[feverGroupIndex]

		for _, elementItem in ipairs(matchGroup) do
			self.curSelectItemMap[elementItem.posXIndex] = self.curSelectItemMap[elementItem.posXIndex] or {}
			self.curSelectItemMap[elementItem.posXIndex][elementItem.posYIndex] = elementItem

			elementItem.comp:setMatchEffectType(MatchGameFightEnum.ItemMatchEffect.MatchNormal)
			table.insert(self.curSelectItemList, elementItem)
		end

		self:doMatchAnim()

		self.curChainNum = self.curChainNum + 1
		self.maxChainNum = Mathf.Max(self.maxChainNum, self.curChainNum)

		MatchGameFightModel.instance:setMaxChainNum(self.maxChainNum)
		self:updateChainNumUI(true)
	end
end

function MatchGameFightSceneView:getNearSameBeadList()
	local allMatchGroups = {}
	local isVisitedMap = {}
	local maxLoopCount = self.planeWidthNum * self.planeHeightNum * 2 + self.planeWidthNum

	for posXIndex = 1, self.planeWidthNum do
		for posYIndex = 1, self.planeHeightNum do
			local elementItem = self.elementItemMap[posXIndex] and self.elementItemMap[posXIndex][posYIndex]

			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and not elementItem.comp.lockState then
				local curKey = posXIndex * (self.planeWidthNum + 1) + posYIndex

				isVisitedMap[curKey] = true

				local matchGroup = {
					elementItem
				}
				local headIndex = 1

				while headIndex <= #matchGroup and headIndex < maxLoopCount do
					local currentItem = matchGroup[headIndex]

					headIndex = headIndex + 1

					for _, offset in ipairs(MatchGameFightEnum.EightRangeOffsetList) do
						local nearPosXIndex = currentItem.posXIndex + offset[1]
						local nearPosYIndex = currentItem.posYIndex + offset[2]

						if nearPosXIndex >= 1 and nearPosXIndex <= self.planeWidthNum and nearPosYIndex >= 1 and nearPosYIndex <= self.planeHeightNum then
							local nearKey = nearPosXIndex * (self.planeWidthNum + 1) + nearPosYIndex

							if not isVisitedMap[nearKey] then
								local nearElementItem = self.elementItemMap[nearPosXIndex] and self.elementItemMap[nearPosXIndex][nearPosYIndex]

								if nearElementItem and nearElementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and nearElementItem.comp.itemParam == elementItem.comp.itemParam and not nearElementItem.comp.lockState then
									isVisitedMap[nearKey] = true
									matchGroup[#matchGroup + 1] = nearElementItem
								end
							end
						end
					end
				end

				if headIndex > MatchGameFightEnum.MinMatchCount then
					table.insert(allMatchGroups, matchGroup)
				end
			end
		end
	end

	return allMatchGroups
end

function MatchGameFightSceneView:startRoundTime()
	TaskDispatcher.cancelTask(self.startRoundTime, self)
	self:cleanRoundTimeTween()

	if not self.isGameRunning then
		local params = {
			conditionId = MatchGameFightEnum.SkillConditionType.OnTurnStart
		}

		MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnTurnStartCondition, params)
	end

	self.isGameRunning = true

	local curTime = self.gameInfoMo.curRoundTime

	self.roundTimeTweenId = ZProj.TweenHelper.DOTweenFloat(curTime, 0, curTime, self.refreshRoundTime, self.onRoundTimeEnd, self, nil, EaseType.Linear)
	self.gameTimePauseCount = 0

	self:startGameTimeCount()
end

function MatchGameFightSceneView:refreshRoundTime(value)
	self.gameInfoMo.curRoundTime = value or self.gameInfoMo.maxRoundTime
	self._txtroundTime.text = string.format("%ds", Mathf.Ceil(self.gameInfoMo.curRoundTime))
	self._imageroundTimeBar.fillAmount = self.gameInfoMo.curRoundTime / self.gameInfoMo.maxRoundTime
end

function MatchGameFightSceneView:skillChangeRoundTime(value)
	if not self.isGameRunning then
		self:refreshRoundTime(value)
	else
		self:startRoundTime()
	end
end

function MatchGameFightSceneView:onRoundTimeEnd()
	self:cleanRoundTimeTween()
	self:stopGameTimeCount()

	if self.isFeverState then
		self:onFeverTimeEnd()
	end

	self.gameInfoMo.curRoundTime = self.gameInfoMo.maxRoundTime

	self.UILineComp:SetPointCount(0)

	for _, elementItem in ipairs(self.curSelectItemList) do
		elementItem.comp:setSelectState(false)
	end

	self.curSelectItemMap = {}
	self.curSelectItemList = {}
	self.isDragging = false
	self.isGameRunning = false
	self.roundEndSequence = FlowSequence.New()

	self.roundEndSequence:addWork(MatchGameHeroAttackWork.New())
	self.roundEndSequence:addWork(TimerWork.New(MatchGameFightEnum.HeroAttackToEnemyAttackTime))
	self.roundEndSequence:addWork(MatchGameEnemyAttackWork.New())
	self.roundEndSequence:registerDoneListener(self.roundEndSequenceDone, self)
	self.roundEndSequence:start()
	gohelper.setActive(self._goclickMask, true)

	self.isRoundEnding = true
end

function MatchGameFightSceneView:setGameFightResult(result)
	self.fightResult = result
end

function MatchGameFightSceneView:roundEndSequenceDone()
	TaskDispatcher.cancelTask(self.startRoundTime, self)
	self:addAndUpdateRoundInfo()

	local params = {
		conditionId = MatchGameFightEnum.SkillConditionType.OnTurnEnd
	}

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.OnTurnEndCondition, params)
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.RefreshTargetGoal)

	if self.fightResult == MatchGameFightEnum.FightResult.None then
		self:refreshRoundTime()
	else
		self:checkAndOpenResultView()
	end

	self.curChainNum = 0

	self:updateChainNumUI(false)
	self:resetRoundData()
	gohelper.setActive(self._goclickMask, false)

	self.isRoundEnding = false
end

function MatchGameFightSceneView:checkAndOpenResultView()
	if self.fightResult == MatchGameFightEnum.FightResult.Succ then
		self:sendGameResultData(true)
	elseif self.fightResult == MatchGameFightEnum.FightResult.Fail then
		self:sendGameResultData(false)
	end

	self.isGameRunning = false

	self:cleanFeverTimeTween()
	self:cleanRoundTimeTween()
	TaskDispatcher.cancelTask(self.startRoundTime, self)
end

function MatchGameFightSceneView:sendGameResultData(isPass)
	local fightView = self.viewContainer:getFightView()
	local stars = fightView:getTargetGoalFinishIndexList()
	local score = fightView.curChallengeScore
	local roundCount = fightView.curRoundCount
	local maxRoundDamage = fightView.maxRoundDamage

	MatchGameController.instance:onEpisodeSuccess(self.episodeId, isPass, stars, score, roundCount, self.maxChainNum, maxRoundDamage)
end

function MatchGameFightSceneView:resetRoundData()
	local fightView = self.viewContainer:getFightView()

	if fightView then
		fightView:resetRoundData()
	end
end

function MatchGameFightSceneView:cleanRoundTimeTween()
	if self.roundTimeTweenId then
		ZProj.TweenHelper.KillById(self.roundTimeTweenId)

		self.roundTimeTweenId = nil
	end
end

function MatchGameFightSceneView:cleanFeverTimeTween()
	if self.feverBarTweenId then
		ZProj.TweenHelper.KillById(self.feverBarTweenId)

		self.feverBarTweenId = nil
	end
end

function MatchGameFightSceneView:setCloseOverrideFunc()
	self.viewContainer:setOverrideCloseClick(self.openFightQuitTipView, self)
end

function MatchGameFightSceneView:pauseGame()
	self:cleanFeverTimeTween()
	self:cleanRoundTimeTween()
	TaskDispatcher.cancelTask(self.startRoundTime, self)
	self:pauseGameTimeCount()
end

function MatchGameFightSceneView:openFightQuitTipView()
	if self._goclickMask.activeSelf or self.isDragging or self.isRoundEnding then
		return
	end

	self:pauseGame()
	MatchGameController.instance:openMatchGameFightQuitTipView()
end

function MatchGameFightSceneView:continueGame()
	if self.isGameRunning then
		self:startRoundTime()
	end

	if self.isFeverState then
		self:cleanFeverTimeTween()

		local curTime = self.gameInfoMo.curFeverTime

		self.feverBarTweenId = ZProj.TweenHelper.DOTweenFloat(curTime, 0, curTime, self.refreshFeverUI, self.onFeverTimeEnd, self, nil, EaseType.Linear)
	end

	self:resumeGameTimeCount()
end

function MatchGameFightSceneView:startGameTimeCount()
	if (self.gameTimePauseCount or 0) > 0 then
		return
	end

	TaskDispatcher.cancelTask(self.onGameTimeCount, self)
	TaskDispatcher.runRepeat(self.onGameTimeCount, self, MatchGameFightEnum.GameTimeCountInterval)
end

function MatchGameFightSceneView:onGameTimeCount()
	local curGameTime = MatchGameFightModel.instance:getCurGameTime() + MatchGameFightEnum.GameTimeCountInterval

	MatchGameFightModel.instance:setCurGameTime(curGameTime)

	local skillView = self.viewContainer:getSkillView()

	if skillView then
		skillView:checkBuffDurationData(MatchGameFightEnum.BuffDurationType.Second)
	end
end

function MatchGameFightSceneView:pauseGameTimeCount()
	self.gameTimePauseCount = (self.gameTimePauseCount or 0) + 1

	TaskDispatcher.cancelTask(self.onGameTimeCount, self)
end

function MatchGameFightSceneView:resumeGameTimeCount()
	self.gameTimePauseCount = Mathf.Max(0, (self.gameTimePauseCount or 0) - 1)

	if self.gameTimePauseCount > 0 or not self.isGameRunning then
		return
	end

	self:startGameTimeCount()
end

function MatchGameFightSceneView:stopGameTimeCount()
	TaskDispatcher.cancelTask(self.onGameTimeCount, self)
end

function MatchGameFightSceneView:getMouseAnchorPos(mousePos)
	local posX, posY = recthelper.screenPosToAnchorPos2(mousePos, self._goplaneContent.transform)
	local anchorX = posX + self.planeSizeWidth / 2
	local anchorY = posY - self.planeSizeWidth / 2

	return anchorX, anchorY
end

function MatchGameFightSceneView:getMousePosIndex(posX, posY)
	local posXIndex = Mathf.Clamp(Mathf.Ceil((posX + MatchGameFightEnum.planeItemSpace / 2) / (MatchGameFightEnum.planeItemWidth + MatchGameFightEnum.planeItemSpace)), 1, self.planeWidthNum)
	local posYIndex = Mathf.Clamp(Mathf.Ceil((MatchGameFightEnum.planeItemSpace / 2 - posY) / (MatchGameFightEnum.planeItemWidth + MatchGameFightEnum.planeItemSpace)), 1, self.planeHeightNum)

	return posXIndex, posYIndex
end

function MatchGameFightSceneView:getCurChainNum()
	return self.curChainNum
end

function MatchGameFightSceneView:updateHeroDamage(elementItemMap)
	local fightView = self.viewContainer:getFightView()

	if fightView then
		fightView:updateHeroDamage(elementItemMap)
	end
end

function MatchGameFightSceneView:updateHeroEnergy(elementItemMap)
	local fightView = self.viewContainer:getFightView()

	if fightView then
		fightView:updateHeroEnergy(elementItemMap)
	end
end

function MatchGameFightSceneView:doHeroDebuffHurtAnim(elementItemMap)
	local fightView = self.viewContainer:getFightView()

	if fightView then
		fightView:doHeroDebuffHurtAnim(elementItemMap)
	end
end

function MatchGameFightSceneView:updateChainNumUI(showState)
	local fightView = self.viewContainer:getFightView()

	if fightView then
		fightView:showChainNum(showState)
	end
end

function MatchGameFightSceneView:addAndUpdateRoundInfo()
	local fightView = self.viewContainer:getFightView()

	if fightView then
		local curRoundCount = fightView.curRoundCount

		curRoundCount = curRoundCount + 1

		if curRoundCount > fightView.totalRoundCount then
			self.fightResult = MatchGameFightEnum.FightResult.Fail
		else
			fightView:setCurRoundCount(curRoundCount)
		end
	end
end

function MatchGameFightSceneView:removeElementItem(posXIndex, posYIndex)
	local elementItem = self.elementItemMap[posXIndex][posYIndex]

	if elementItem and elementItem.go then
		gohelper.destroy(elementItem.go)
	end

	self.elementItemMap[posXIndex][posYIndex] = nil
end

function MatchGameFightSceneView:getElementItemMap()
	return self.elementItemMap
end

function MatchGameFightSceneView:quitGame()
	self:sendGameResultData(false)
end

function MatchGameFightSceneView:showElementEffect(effectType, posXIndex, posYIndex)
	local fightView = self.viewContainer:getFightView()

	if fightView then
		fightView:showElementEffect(effectType, posXIndex, posYIndex)
	end
end

function MatchGameFightSceneView:onClose()
	for posXIndex = 1, self.planeWidthNum do
		for posYIndex = 1, self.planeHeightNum do
			local planeItem = self.planeItemMap[posXIndex][posYIndex]

			if planeItem then
				CommonDragHelper.instance:unregisterDragObj(planeItem.go)
				planeItem.btnclick:RemoveClickListener()
			end
		end
	end

	self.fillRounds = {}
	self.bombRounds = {}
	self.pendingBombList = nil
	self.hasBombElementItemMap = {}
	self.curSelectItemMap = {}
	self.curSelectItemList = {}
	self.isGameRunning = false

	TaskDispatcher.cancelTask(self.playNextBombRound, self)
	TaskDispatcher.cancelTask(self.startRoundTime, self)
	TaskDispatcher.cancelTask(self.checkNotMatchConvertElementFinish, self)
	TaskDispatcher.cancelTask(self.hideFeverPlane, self)
	TaskDispatcher.cancelTask(self.hideFeverFull, self)
	self:stopGameTimeCount()

	self.gameTimePauseCount = 0

	self:cleanRoundTimeTween()
	self:cleanFeverTimeTween()
	MatchGameFightModel.instance:setFeverState(false)
	gohelper.setActive(self._gofeverPlane, false)
	gohelper.setActive(self._gofever, false)
	MatchGameFightModel.instance:cleanMatchGameData()
end

function MatchGameFightSceneView:onDestroyView()
	if self.matchMoveFillSequence then
		self.matchMoveFillSequence:unregisterDoneListener(self.onMatchMoveFillDone, self)
		self.matchMoveFillSequence:destroy()

		self.matchMoveFillSequence = nil
	end

	if self.bombMatchSequence then
		self.bombMatchSequence:unregisterDoneListener(self.onMatchMoveFillDone, self)
		self.bombMatchSequence:destroy()

		self.bombMatchSequence = nil
	end

	if self.cureMatchSequence then
		self.cureMatchSequence:unregisterDoneListener(self.onMatchMoveFillDone, self)
		self.cureMatchSequence:destroy()

		self.cureMatchSequence = nil
	end

	if self.roundEndSequence then
		self.roundEndSequence:unregisterDoneListener(self.roundEndSequenceDone, self)
		self.roundEndSequence:destroy()

		self.roundEndSequence = nil
	end

	MatchGameFightModel.instance:setCurGameTime(0)
	self._simagebg:UnLoadImage()
end

return MatchGameFightSceneView
