﻿-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionCollectView.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionCollectView", package.seeall)

local Rouge2_CollectionCollectView = class("Rouge2_CollectionCollectView", BaseView)

function Rouge2_CollectionCollectView:onInitView()
	self._gocollectionitem = gohelper.findChild(self.viewGO, "collection/#go_collectionitem")
	self._txtcurrent = gohelper.findChildText(self.viewGO, "numbg/#txt_current")
	self._txttotal = gohelper.findChildText(self.viewGO, "numbg/#txt_total")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CollectionCollectView:addEvents()
	return
end

function Rouge2_CollectionCollectView:removeEvents()
	return
end

function Rouge2_CollectionCollectView:_editableInitView()
	self._goRound1 = gohelper.findChild(self.viewGO, "collection/round1")
	self._goRound2 = gohelper.findChild(self.viewGO, "collection/round2")
	self._goRound3 = gohelper.findChild(self.viewGO, "collection/round3")
	self._goRefresh = gohelper.findChild(self.viewGO, "rouge2_collectioncollectview/numbg/#refresh")
	self._roundGoList = {
		self._goRound1,
		self._goRound2,
		self._goRound3
	}
	self._roundChildGoList = self:getUserDataTb_()
	self._roundPosDic = {}
	self._itemRotationZList = {}

	local itemIndex = 0

	for index, roundParent in ipairs(self._roundGoList) do
		local transform = roundParent.transform
		local itemGoCount = transform.childCount

		for i = 1, itemGoCount do
			local childParent = transform:GetChild(i - 1)
			local childGo = childParent.gameObject

			table.insert(self._roundChildGoList, childGo)

			local rotationZ = childParent.transform.localRotation.z

			itemIndex = itemIndex + 1
			self._itemRotationZList[index] = rotationZ
			self._roundPosDic[itemIndex] = index
		end
	end

	self._collectionItemList = self:getUserDataTb_()
	self._newItemList = {}
end

function Rouge2_CollectionCollectView:onUpdateParam()
	return
end

function Rouge2_CollectionCollectView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_collectible)
	self:refreshUI()
	self:rotationRound()
end

local rotationTime = 0.05

function Rouge2_CollectionCollectView:rotationRound()
	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.CollectRotateParam)

	if constConfig then
		self._rotateDataList = GameUtil.splitString2(constConfig.value, true)

		TaskDispatcher.runRepeat(self.onRotation, self, rotationTime)
	end
end

function Rouge2_CollectionCollectView:onRotation()
	for index, parent in ipairs(self._roundGoList) do
		local rotateData = self._rotateDataList[index]

		if rotateData then
			local deltaValue = rotateData[1] * rotateData[2] * rotationTime
			local finalValue = self._itemRotationZList[index] + deltaValue

			if finalValue > 360 or finalValue < -360 then
				finalValue = 0
			end

			transformhelper.setLocalRotation(parent.transform, 0, 0, finalValue)

			self._itemRotationZList[index] = finalValue
		end
	end
end

function Rouge2_CollectionCollectView:refreshUI()
	local allConfig = Rouge2_OutSideConfig.instance:getAllInteractCollections()
	local result = {}

	for _, config in ipairs(allConfig) do
		local type = Rouge2_BackpackHelper.itemId2Tag(config.id)

		if type and type == Rouge2_OutsideEnum.CollectionListType.Collection then
			table.insert(result, config)
		end
	end

	local newCount = 0

	self.totalCount = #result

	for index, config in ipairs(result) do
		local parent = self._roundChildGoList[index]

		if not parent then
			logError("造物收集界面 不存在的索引:" .. index)
		elseif Rouge2_OutsideModel.instance:collectionIsUnlock(config.id) and Rouge2_OutsideModel.instance:collectionIsPass(config.id) then
			local itemGo = gohelper.clone(self._gocollectionitem, parent)

			gohelper.setActive(itemGo, true)

			local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, Rouge2_CollectionCollectItem)

			item:setInfo(config)

			local num = math.random(0, 5)
			local isNew = num >= 3

			if isNew then
				table.insert(self._newItemList, item)

				newCount = newCount + 1
			end

			table.insert(self._collectionItemList, item)
		end
	end

	local totalCount = self.totalCount

	self._txttotal.text = totalCount

	if newCount > 0 then
		TaskDispatcher.runDelay(self.onOpenAnimPlayFinish, self, 0.5)
	else
		self._txtcurrent.text = #self._collectionItemList
	end
end

function Rouge2_CollectionCollectView:onOpenAnimPlayFinish()
	TaskDispatcher.cancelTask(self.onOpenAnimPlayFinish, self)

	for _, item in ipairs(self._newItemList) do
		item.animator:Play("firstin", 0, 0)
	end

	self:refreshCountInfo()
	TaskDispatcher.runDelay(self.onUnlockPlayFinish, self, 1.167)
end

function Rouge2_CollectionCollectView:onUnlockPlayFinish()
	TaskDispatcher.cancelTask(self.onUnlockPlayFinish, self)

	for _, item in ipairs(self._newItemList) do
		item.animator:Play("idle", 0, 0)
	end
end

function Rouge2_CollectionCollectView:refreshCountInfo()
	local totalCount = self.totalCount
	local finalCount = #self._collectionItemList
	local previousCount = finalCount - #self._newItemList

	self._txtcurrent.text = previousCount

	if self._collectCountTweenId then
		ZProj.TweenHelper.KillById(self._collectCountTweenId)

		self._collectCountTweenId = nil
	end

	gohelper.setActive(self._goRefresh, true)

	self._collectCountTweenId = ZProj.TweenHelper.DOTweenFloat(previousCount, finalCount, 1.167, self.framChangeScoreCallBack, self.changeScoreDone, self)
end

function Rouge2_CollectionCollectView:framChangeScoreCallBack(finalScore)
	self._txtcurrent.text = math.ceil(finalScore)
end

function Rouge2_CollectionCollectView:changeScoreDone()
	self._collectCountTweenId = nil

	gohelper.setActive(self._goRefresh, true)
end

function Rouge2_CollectionCollectView:onClose()
	TaskDispatcher.cancelTask(self.onUnlockPlayFinish, self)
	TaskDispatcher.cancelTask(self.onRotation, self)
	TaskDispatcher.cancelTask(self.onOpenAnimPlayFinish, self)

	if self._collectCountTweenId then
		ZProj.TweenHelper.KillById(self._collectCountTweenId)

		self._collectCountTweenId = nil
	end
end

function Rouge2_CollectionCollectView:onDestroyView()
	return
end

return Rouge2_CollectionCollectView
