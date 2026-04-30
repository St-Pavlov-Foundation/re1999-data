-- chunkname: @modules/logic/sodache/model/SodacheHandbookGroupMo.lua

module("modules.logic.sodache.model.SodacheHandbookGroupMo", package.seeall)

local SodacheHandbookGroupMo = pureTable("SodacheHandbookGroupMo")

function SodacheHandbookGroupMo:init(type, subType, handbookCfgs, isGroupTop)
	self.type = type
	self.subType = subType
	self.handbookCfgs = handbookCfgs
	self.count = handbookCfgs and #handbookCfgs or 0
	self.isGroupTop = isGroupTop
	self.firstHandBookCfg = handbookCfgs and handbookCfgs[1]
	self.isFold = false
end

function SodacheHandbookGroupMo:getLineHeightFunction(isFold)
	local tabHeight = 48

	if isFold then
		return self.isGroupTop and tabHeight or 0
	elseif self.type == SodacheEnum.HandBookType.Card then
		return self.isGroupTop and tabHeight + 250 or 250
	else
		return self.isGroupTop and tabHeight + 186 or 186
	end
end

function SodacheHandbookGroupMo:overrideLineHeight(cellHeight)
	self._cellHeight = cellHeight
end

function SodacheHandbookGroupMo:clearOverrideLineHeight()
	self._cellHeight = nil
end

function SodacheHandbookGroupMo:getLineHeight(isFold)
	if self._cellHeight then
		return self._cellHeight
	end

	return self:getLineHeightFunction(isFold)
end

function SodacheHandbookGroupMo:setIsFold(isFold)
	self.isFold = isFold
end

return SodacheHandbookGroupMo
