-- chunkname: @modules/logic/fight/view/FightYiFuLinMoveView.lua

module("modules.logic.fight.view.FightYiFuLinMoveView", package.seeall)

local FightYiFuLinMoveView = class("FightYiFuLinMoveView", FightBaseView)

function FightYiFuLinMoveView:onInitView()
	self._groupGO = gohelper.findChild(self.viewGO, "swapContainer")
	self._groupLayout = self._groupGO:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._itemList = {}
	self._positionToEntityId = {}
	self._totalPositions = 0
	self._dragSourceIndex = nil
	self._dragSiblingIndex = nil
end

function FightYiFuLinMoveView:addEvents()
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self:addEventCb(FightController.instance, FightEvent.StartPlayClothSkill, self.closeThis, self, LuaEventSystem.High)
	self:addEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, self.closeThis, self, LuaEventSystem.High)
end

function FightYiFuLinMoveView:removeEvents()
	self._btnConfirm:RemoveClickListener()
end

function FightYiFuLinMoveView:onOpen()
	AudioMgr.instance:trigger(410062)
	PostProcessingMgr.instance:setBlurWeight(1)
	self:_initPositionData()

	local itemPath = self.viewContainer:getSetting().otherRes[1]

	for i = 1, self._totalPositions do
		local itemView = self._itemList[i]

		if not itemView then
			local itemGO = self:getResInst(itemPath, self._groupGO, "item" .. i)

			itemView = self:com_openSubView(FightYiFuLinMoveItemView, itemGO, nil, i, self)

			table.insert(self._itemList, itemView)
		end

		gohelper.setActive(itemView.viewGO, true)
		self:_refreshItem(itemView, i)
	end

	for i = self._totalPositions + 1, #self._itemList do
		gohelper.setActive(self._itemList[i].viewGO, false)
	end

	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnEsc, self)
end

function FightYiFuLinMoveView:_initPositionData()
	local battleId = FightModel.instance:getBattleId()
	local battleCo = battleId and lua_battle.configDict[battleId]

	self._totalPositions = battleCo and battleCo.playerMax or 3
	self._positionToEntityId = {}

	local entityList = FightDataHelper.entityMgr:getMyNormalList()

	if entityList then
		for _, entityMO in ipairs(entityList) do
			local pos = entityMO.position

			if pos and pos > 0 and pos <= self._totalPositions then
				self._positionToEntityId[pos] = entityMO.uid
			end
		end
	end
end

function FightYiFuLinMoveView:_refreshItem(itemView, position)
	local entityId = self._positionToEntityId[position]

	itemView:refreshItem(position, entityId)
end

function FightYiFuLinMoveView:onItemDragBegin(index)
	self._dragSourceIndex = index

	self:_raiseDragOrder(self._itemList[index])
	AudioMgr.instance:trigger(410063)
end

function FightYiFuLinMoveView:onItemDragEnd(index, pointerEventData)
	local itemView = self._itemList[index]

	if not itemView then
		return
	end

	local targetIndex = self:_findTargetIndex(pointerEventData.position, index)

	self:_restoreDragOrder(itemView)

	if targetIndex and targetIndex ~= index then
		self:_swapItems(index, targetIndex)
	end

	self._dragSourceIndex = nil
end

function FightYiFuLinMoveView:_raiseDragOrder(itemView)
	if not itemView then
		return
	end

	if self._groupLayout then
		self._groupLayout.enabled = false
	end

	self._dragSiblingIndex = itemView.viewGO.transform:GetSiblingIndex()

	gohelper.setAsLastSibling(itemView.viewGO)
end

function FightYiFuLinMoveView:_restoreDragOrder(itemView)
	if itemView and self._dragSiblingIndex then
		gohelper.setSibling(itemView.viewGO, self._dragSiblingIndex)
	end

	self._dragSiblingIndex = nil

	if self._groupLayout then
		self._groupLayout.enabled = true
	end
end

function FightYiFuLinMoveView:_findTargetIndex(screenPos, excludeIndex)
	local uiCamera = CameraMgr.instance:getUICamera()

	for i, itemView in ipairs(self._itemList) do
		if i ~= excludeIndex then
			local rectTransform = itemView:getRectTransform()
			local isInside = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(rectTransform, screenPos, uiCamera)

			if isInside then
				return i
			end
		end
	end

	return nil
end

function FightYiFuLinMoveView:_swapItems(index1, index2)
	local entityId1 = self._positionToEntityId[index1]
	local entityId2 = self._positionToEntityId[index2]

	self._positionToEntityId[index1] = entityId2
	self._positionToEntityId[index2] = entityId1

	local itemView1 = self._itemList[index1]
	local itemView2 = self._itemList[index2]

	self:_refreshItem(itemView1, index1)
	self:_refreshItem(itemView2, index2)
	AudioMgr.instance:trigger(320002)

	if not itemView1.hasMatch and not itemView2.hasMatch then
		AudioMgr.instance:trigger(410066)
	end
end

function FightYiFuLinMoveView:_onClickConfirm()
	AudioMgr.instance:trigger(410067)

	local positionData = {}

	for position, entityId in pairs(self._positionToEntityId) do
		if entityId then
			positionData[entityId] = position
		end
	end

	local jsonStr = cjson.encode(positionData)

	FightRpc.instance:sendUseClothSkillRequest(0, self.viewParam.entityId, nil, FightEnum.ClothSkillType.PositionSort, jsonStr)
	self:closeThis()
end

function FightYiFuLinMoveView:_onBtnEsc()
	return
end

function FightYiFuLinMoveView:onClose()
	AudioMgr.instance:trigger(410062)
	PostProcessingMgr.instance:setBlurWeight(0)
end

function FightYiFuLinMoveView:onClickModalMask()
	self:closeThis()
end

function FightYiFuLinMoveView:onDestroyView()
	return
end

return FightYiFuLinMoveView
