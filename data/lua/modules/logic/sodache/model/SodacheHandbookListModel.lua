-- chunkname: @modules/logic/sodache/model/SodacheHandbookListModel.lua

module("modules.logic.sodache.model.SodacheHandbookListModel", package.seeall)

local SodacheHandbookListModel = class("SodacheHandbookListModel", MixScrollModel)

function SodacheHandbookListModel:getInfoList()
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		local nextMo = list[i + 1]
		local nextTop = nextMo and nextMo.isGroupTop
		local listItemHeight = mo:getLineHeight(mo.isFold)

		listItemHeight = nextTop and listItemHeight + 20 or listItemHeight

		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(1, listItemHeight, i)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

function SodacheHandbookListModel:setData(type)
	self.type = type

	local moList = self:getCurTypeMoList()

	self:setList(moList)
end

function SodacheHandbookListModel:getCurTypeMoList()
	if not self.groupMoMap then
		self.groupMoMap = {}
	end

	local moListMap = self.groupMoMap[self.type]

	if moListMap then
		self:clearFoldStatus(self.type)
	else
		moListMap = self:buildHandbookMoList(self.type)
	end

	local list = {}

	for _, v in pairs(moListMap) do
		tabletool.addValues(list, v)
	end

	return list
end

function SodacheHandbookListModel:getCurSubTypeMoList(subType)
	return self.groupMoMap[self.type][subType]
end

function SodacheHandbookListModel:buildHandbookMoList(type)
	self.groupMoMap[type] = {}

	local subTypes

	if type == SodacheEnum.HandBookType.Card then
		subTypes = {
			SodacheEnum.HandBookSubType.Supplies,
			SodacheEnum.HandBookSubType.Offering,
			SodacheEnum.HandBookSubType.Adventure,
			SodacheEnum.HandBookSubType.Ammo
		}
	else
		subTypes = {
			SodacheEnum.HandBookSubType.Moster1,
			SodacheEnum.HandBookSubType.Moster2
		}
	end

	for _, subType in ipairs(subTypes) do
		local moList = {}
		local handBookCfgs = SodacheConfig.instance:getHandBookCfgList(subType)
		local buildCnt = math.ceil(#handBookCfgs / 5)

		for i = 1, buildCnt do
			local mo = SodacheHandbookGroupMo.New()
			local cfgs = {}

			for j = 1, 5 do
				local addCfg = handBookCfgs[(i - 1) * 5 + j]

				if addCfg then
					cfgs[#cfgs + 1] = addCfg
				end
			end

			mo:init(type, subType, cfgs, i == 1)

			moList[#moList + 1] = mo
		end

		self.groupMoMap[type][subType] = moList
	end

	return self.groupMoMap[type]
end

function SodacheHandbookListModel:getTypeFirstHnadbookId(type)
	local list = self:getList()

	for _, mo in ipairs(list) do
		if mo.type == type and mo.isGroupTop then
			return mo.firstHandBookCfg.id
		end
	end
end

function SodacheHandbookListModel:getSubTypeCount(subType)
	local box = SodacheModel.instance:getOutsideMo().handBookBox
	local activeCnt = 0
	local allCnt = 0
	local list = self:getCurSubTypeMoList(subType)

	for _, mo in ipairs(list) do
		if mo.subType == subType then
			for _, config in ipairs(mo.handbookCfgs) do
				if box:isActive(config.id) then
					activeCnt = activeCnt + 1
				end

				allCnt = allCnt + 1
			end
		end
	end

	return activeCnt, allCnt
end

function SodacheHandbookListModel:clearFoldStatus(clearType)
	if clearType then
		local list = self.groupMoMap[clearType]

		for _, list1 in pairs(list) do
			for _, mo in ipairs(list1) do
				mo:setIsFold(false)
			end
		end
	else
		for _, list1 in pairs(self.groupMoMap) do
			for _, list2 in pairs(list1) do
				for _, mo in ipairs(list2) do
					mo:setIsFold(false)
				end
			end
		end
	end
end

SodacheHandbookListModel.instance = SodacheHandbookListModel.New()

return SodacheHandbookListModel
