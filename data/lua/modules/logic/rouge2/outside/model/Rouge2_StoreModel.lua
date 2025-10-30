-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_StoreModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_StoreModel", package.seeall)

local Rouge2_StoreModel = class("Rouge2_StoreModel", BaseModel)

function Rouge2_StoreModel:onInit()
	logNormal("Rouge2_StoreModel onInit")
	self:reInit()
end

function Rouge2_StoreModel:reInit()
	logNormal("Rouge2_StoreModel reInit")

	self.storeBuyCountDic = {}
	self._openStoreStageDic = {}
	self._openStoreStageList = {}
	self.storeSaleOutDic = {}
	self.rewardPoint = 0
end

function Rouge2_StoreModel:refreshStoreStage()
	tabletool.clear(self._openStoreStageDic)
	tabletool.clear(self._openStoreStageList)

	local stageConfigList = Rouge2_OutSideConfig.instance:getRewardStateList()
	local nowTime = ServerTime.now()

	for _, config in ipairs(stageConfigList) do
		local endTime = TimeUtil.stringToTimestamp(config.endTime)

		if nowTime < endTime then
			local id = config.id

			self._openStoreStageDic[id] = id

			table.insert(self._openStoreStageList, id)
		end
	end
end

function Rouge2_StoreModel:updateInfo(outsideInfo)
	self:refreshBuyCount(outsideInfo)
	self:refreshStoreStage()
	self:refreshAllBuyState()
	self:refreshPoint(outsideInfo.rewardPoint)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnStoreInfoUpdate)
end

function Rouge2_StoreModel:onBuyGoodsSuccess(goodsInfo, num)
	self.storeBuyCountDic[goodsInfo.id] = num

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnBuyStoreGoodsSuccess, goodsInfo.id)
end

function Rouge2_StoreModel:refreshPoint(rewardPoint)
	self.rewardPoint = rewardPoint or 0

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnStorePointUpdate, rewardPoint)
end

function Rouge2_StoreModel:refreshBuyCount(outsideInfo)
	tabletool.clear(self.storeBuyCountDic)

	local rewardInfo = outsideInfo.rewardInfo

	if rewardInfo and #rewardInfo > 0 then
		for _, info in ipairs(rewardInfo) do
			self.storeBuyCountDic[info.id] = info.buyCount
		end
	end
end

function Rouge2_StoreModel:refreshAllBuyState()
	tabletool.clear(self.storeSaleOutDic)

	local stageConfigList = Rouge2_OutSideConfig.instance:getRewardStateList()

	for _, config in ipairs(stageConfigList) do
		if not self._openStoreStageDic[config.id] then
			self.storeSaleOutDic[config.id] = true
		else
			local storeGroupDict = Rouge2_OutSideConfig.instance:getAllRewardConfigListByStage(config.id)

			if storeGroupDict then
				for _, goodConfig in ipairs(storeGroupDict) do
					local buyCount = self:getGoodsBuyCount(goodConfig.id)

					if buyCount < goodConfig.maxBuyCount then
						self.storeSaleOutDic[config.id] = true

						break
					end
				end

				if self.storeSaleOutDic[config.id] then
					self.storeSaleOutDic[config.id] = false
				end
			else
				logError("肉鸽2 商店不存在 期数:" .. config.id)
			end
		end
	end
end

function Rouge2_StoreModel:getGoodsBuyCount(id)
	return self.storeBuyCountDic[id] or 0
end

function Rouge2_StoreModel:isStoreAllClaimed(stageId)
	return self.storeSaleOutDic[stageId]
end

function Rouge2_StoreModel:getCurUseScore()
	return self.rewardPoint
end

function Rouge2_StoreModel:setCurStageId(stageId)
	self._curStageId = stageId

	if stageId == nil then
		self._curStageConfig = nil
	else
		local stageConfigId = Rouge2_StoreModel.instance:getCurStageId()
		local config = Rouge2_OutSideConfig.instance:getRewardStageConfigById(stageConfigId)

		if config == nil then
			logError("Rouge2 Store stageConfig is nil stageId" .. stageConfigId)
		end

		self._curStageConfig = config
	end
end

function Rouge2_StoreModel:getCurStageId()
	return self._curStageId
end

function Rouge2_StoreModel:isCurStoreOpen(showToast)
	if self._curStageId and self._curStageConfig == nil then
		if showToast then
			GameFacade.showToast(ToastEnum.Rouge2StoreNotOpen)
		end

		return false
	end

	local openTime = TimeUtil.stringToTimestamp(self._curStageConfig.startTime)
	local endTime = TimeUtil.stringToTimestamp(self._curStageConfig.endTime)

	openTime = ServerTime.timeInLocal(openTime)
	endTime = ServerTime.timeInLocal(endTime)

	local nowTime = ServerTime.now()
	local isOpen = openTime <= nowTime and nowTime < endTime

	if isOpen == false and showToast then
		GameFacade.showToast(ToastEnum.Rouge2StoreNotOpen)
	end

	return isOpen
end

function Rouge2_StoreModel:getOpenStageIdList()
	return self._openStoreStageList
end

Rouge2_StoreModel.instance = Rouge2_StoreModel.New()

return Rouge2_StoreModel
