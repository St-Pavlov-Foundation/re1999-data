﻿-- chunkname: @modules/logic/rouge2/backpack/controller/Rouge2_BackpackController.lua

module("modules.logic.rouge2.backpack.controller.Rouge2_BackpackController", package.seeall)

local Rouge2_BackpackController = class("Rouge2_BackpackController", BaseController)

function Rouge2_BackpackController:tryReplaceActiveSkill(index, skillUid)
	local isCan, toastId = self:checkCanReplaceActiveSkill(index, skillUid)

	if isCan then
		local skillMo = Rouge2_BackpackSkillEditListModel.instance:getMo(skillUid)
		local skillIndex = Rouge2_BackpackSkillEditListModel.instance:getIndex(skillMo)

		Rouge2_BackpackSkillEditListModel.instance:selectCell(skillIndex, false)
		self:tryRemoveActiveSkillByUid(skillUid)
		self:sendUseActiveSkillIdsRpc(index, skillUid)
	elseif toastId then
		GameFacade.showToast(toastId)
	end

	return isCan
end

function Rouge2_BackpackController:sendUseActiveSkillIdsRpc(index, skillUid)
	Rouge2_Rpc.instance:sendRouge2EquipCareerActiveSkillRequest(index, skillUid)
end

function Rouge2_BackpackController:isCanEquipAnySkill(index)
	local isUse = Rouge2_BackpackModel.instance:isActiveSkillIndexInUse(index)

	if isUse then
		return
	end

	local notUseSkillList = Rouge2_BackpackModel.instance:getAllNotUseActiveSkillList()

	if not notUseSkillList then
		return
	end

	for _, skillMo in ipairs(notUseSkillList) do
		local skillUid = skillMo:getUid()
		local isCan = self:checkCanReplaceActiveSkill(index, skillUid)

		if isCan then
			return true
		end
	end
end

function Rouge2_BackpackController:tryRemoveActiveSkill(index)
	local isEquip = Rouge2_BackpackModel.instance:isActiveSkillIndexInUse(index)

	if isEquip then
		Rouge2_BackpackController.instance:sendUseActiveSkillIdsRpc(index, Rouge2_Enum.EmptyActiveSkill)
	end

	return isEquip
end

function Rouge2_BackpackController:tryRemoveActiveSkillByUid(skillUid)
	local index = Rouge2_BackpackModel.instance:uid2UseActiveSkillIndex(skillUid)

	return self:tryRemoveActiveSkill(index)
end

function Rouge2_BackpackController:checkCanReplaceActiveSkill(index, newSkillUid)
	if not index or index < 0 or index > Rouge2_Enum.MaxActiveSkillNum then
		return
	end

	local newSkillMo = Rouge2_BackpackModel.instance:getItem(newSkillUid)
	local oldSkillMo = Rouge2_BackpackModel.instance:index2UseActiveSkill(index)
	local isCan = true
	local toastId

	if not self:checkIfOverAssembleCost(oldSkillMo, newSkillMo) then
		isCan = false
		toastId = ToastEnum.Rouge2OverAssembleCost
	elseif not self:checkIfBXSAttrFit(index, newSkillMo) then
		isCan = false
		toastId = nil
	end

	return isCan, toastId
end

function Rouge2_BackpackController:checkIfBXSAttrFit(index, newSkillMo)
	if newSkillMo and Rouge2_Model.instance:isUseBXSCareer() then
		local bxsAttrId = Rouge2_MapConfig.instance:getBXSAttrId(index)

		if bxsAttrId ~= newSkillMo:getAttrTag() then
			return false
		end
	end

	return true
end

function Rouge2_BackpackController:checkIfOverAssembleCost(oldSkillMo, newSkillMo)
	if not newSkillMo or newSkillMo.id == 0 then
		return true
	end

	local oldSkillCost = 0
	local oldSkillId = oldSkillMo and oldSkillMo.skillId

	if oldSkillId and oldSkillId ~= 0 then
		local oldSkillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(oldSkillId)

		oldSkillCost = oldSkillCo and oldSkillCo.assembleCost or 0
	end

	local newSkillCost = 0
	local newSkillId = newSkillMo and newSkillMo.skillId

	if newSkillId and newSkillId ~= 0 then
		local newSkillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(newSkillId)

		newSkillCost = newSkillCo and newSkillCo.assembleCost or 0
	end

	local costOffset = newSkillCost - oldSkillCost
	local curAssembleCost = Rouge2_BackpackModel.instance:getUseActiveSkillAssembleCost()
	local maxAssembleCost = Rouge2_Model.instance:getAttrValue(Rouge2_MapEnum.BasicAttrId.ActiveSkillCapacity)

	return maxAssembleCost >= curAssembleCost + costOffset
end

function Rouge2_BackpackController:tryEquipSkillsAfterSelectCareer()
	local notUseSkillList = Rouge2_BackpackModel.instance:getAllNotUseActiveSkillList()
	local notUseSkillNum = notUseSkillList and #notUseSkillList or 0
	local equipSkillNum = 0

	for i = 1, notUseSkillNum do
		local skillMo = notUseSkillList and notUseSkillList[i]
		local skillUid = skillMo and skillMo:getUid()

		for j = 1, Rouge2_Enum.MaxActiveSkillNum do
			if self:tryReplaceActiveSkill(j, skillUid) then
				self:updateItemReddotStatus(skillUid, Rouge2_Enum.ItemStatus.Old)

				equipSkillNum = equipSkillNum + 1

				break
			end
		end

		if equipSkillNum >= Rouge2_Enum.MaxActiveSkillNum then
			break
		end
	end
end

function Rouge2_BackpackController:buildItemReddot()
	local redDotInfo = {}
	local hasNewItem = false

	for _, bagType in pairs(Rouge2_Enum.BagType) do
		local itemList = Rouge2_BackpackModel.instance:getItemList(bagType)
		local reddotId = Rouge2_Enum.ItemType2Reddot[bagType]
		local isBagHasNew = false

		if reddotId then
			if itemList then
				for _, itemMo in ipairs(itemList) do
					local uid = itemMo:getUid()
					local value = Rouge2_MapLocalDataHelper.getItemReddotStatus(uid)
					local info = {
						id = reddotId,
						uid = uid,
						value = value
					}

					table.insert(redDotInfo, info)

					if value == Rouge2_Enum.ItemStatus.New then
						hasNewItem = true
						isBagHasNew = true
					end
				end
			end

			local info = {
				uid = 0,
				id = reddotId,
				value = isBagHasNew and 1 or 0
			}

			table.insert(redDotInfo, info)
		end
	end

	table.insert(redDotInfo, {
		uid = 0,
		id = RedDotEnum.DotNode.Rouge2BackpackEntrance,
		value = hasNewItem and 1 or 0
	})
	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfo)
end

function Rouge2_BackpackController:updateItemReddotStatus(uid, status)
	local preStatus = Rouge2_MapLocalDataHelper.getItemReddotStatus(uid)

	if preStatus == status then
		return
	end

	Rouge2_MapLocalDataHelper.setItemReddotStatus(uid, status)
	self:buildItemReddot()
end

function Rouge2_BackpackController:readAllActiveSkills()
	local allActiveSklls = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if allActiveSklls then
		for _, skillMo in ipairs(allActiveSklls) do
			self:updateItemReddotStatus(skillMo:getUid(), Rouge2_Enum.ItemStatus.Old)
		end
	end
end

function Rouge2_BackpackController:switchItemDescMode(dataFlag, targetMode)
	local key = self:_getItemDescModeKey(dataFlag)

	GameUtil.playerPrefsSetNumberByUserId(key, targetMode)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchItemDescMode, dataFlag, targetMode)
end

function Rouge2_BackpackController:getItemDescMode(dataFlag, defaultMode)
	defaultMode = defaultMode or Rouge2_Enum.ItemDescMode.Full

	local key = self:_getItemDescModeKey(dataFlag)
	local descMode = GameUtil.playerPrefsGetNumberByUserId(key, defaultMode)

	return tonumber(descMode)
end

function Rouge2_BackpackController:_getItemDescModeKey(dataFlag)
	return PlayerPrefsKey.Rouge2ItemDescMode .. "#" .. tostring(dataFlag)
end

function Rouge2_BackpackController:showLossItemView(reason, lossItemList)
	if reason == Rouge2_MapEnum.ShowItemDropReason.LevelUpSucc then
		return
	end

	local type2ItemList = {}

	for _, itemMo in ipairs(lossItemList) do
		local itemId = itemMo.itemId
		local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)

		type2ItemList[itemType] = type2ItemList[itemType] or {}

		table.insert(type2ItemList[itemType], itemId)
	end

	for itemType, lossItems in pairs(type2ItemList) do
		local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(itemType)

		if showViewName then
			Rouge2_PopController.instance:addPopViewWithViewName(showViewName, {
				itemList = lossItems,
				dataType = Rouge2_Enum.ItemDataType.Config,
				viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Loss
			})
		end
	end
end

function Rouge2_BackpackController:showGetItemView(reason, getItemList)
	if not reason or not Rouge2_MapEnum.ShowItemDropReason[reason] then
		return
	end

	local type2ItemList = {}

	for _, itemMo in ipairs(getItemList) do
		local uid = itemMo.uid
		local itemType = Rouge2_BackpackHelper.uid2BagType(uid)

		type2ItemList[itemType] = type2ItemList[itemType] or {}

		table.insert(type2ItemList[itemType], uid)
	end

	for itemType, itemList in pairs(type2ItemList) do
		local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(itemType)

		if showViewName then
			Rouge2_PopController.instance:addPopViewWithViewName(showViewName, {
				itemList = itemList,
				dataType = Rouge2_Enum.ItemDataType.Server,
				viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Drop,
				reason = reason
			})
		end
	end
end

function Rouge2_BackpackController:buildBXSBoxReddot()
	local reddotValue = 0

	if Rouge2_Model.instance:isUseBXSCareer() then
		local curPoint = Rouge2_BackpackModel.instance:getCurBoxPoint()
		local maxPoint = Rouge2_MapConfig.instance:BXSMaxBoxPoint()

		if maxPoint <= curPoint then
			reddotValue = 1
		end
	end

	RedDotRpc.instance:clientAddRedDotGroupList({
		{
			id = RedDotEnum.DotNode.Rouge2BXSBox,
			value = reddotValue
		}
	})
end

Rouge2_BackpackController.instance = Rouge2_BackpackController.New()

return Rouge2_BackpackController
