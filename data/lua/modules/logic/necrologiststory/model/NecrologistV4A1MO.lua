-- chunkname: @modules/logic/necrologiststory/model/NecrologistV4A1MO.lua

module("modules.logic.necrologiststory.model.NecrologistV4A1MO", package.seeall)

local NecrologistV4A1MO = class("NecrologistV4A1MO", NecrologistStoryGameBaseMO)

function NecrologistV4A1MO:onInit()
	return
end

function NecrologistV4A1MO:onUpdateData()
	local data = self:getData()

	self.checkDict = {}

	if data.checkList then
		for _, checkData in ipairs(data.checkList) do
			self.checkDict[checkData.id] = checkData.isSuc and true or false
		end
	end
end

function NecrologistV4A1MO:onSaveData()
	local data = self:getData()

	data.checkList = {}

	for checkId, isSuccess in pairs(self.checkDict) do
		table.insert(data.checkList, {
			id = checkId,
			isSuc = isSuccess
		})
	end
end

function NecrologistV4A1MO:isStoryUnlock(storyId)
	local config = NecrologistStoryConfig.instance:getPlotGroupCo(storyId)
	local state = self:calStoryStateByPreId(config.preId)

	return state == NecrologistStoryEnum.StoryState.Normal
end

function NecrologistV4A1MO:isCheckSuccess(checkId)
	return self.checkDict[checkId]
end

function NecrologistV4A1MO:setCheckSuccess(checkId, isSuccess)
	local oldSuccess = self:isCheckSuccess(checkId)

	if oldSuccess or oldSuccess == isSuccess then
		return
	end

	self.checkDict[checkId] = isSuccess and true or false

	self:setDataDirty()
end

function NecrologistV4A1MO:getCheckCount()
	local count = 0

	for checkId, isSuccess in pairs(self.checkDict) do
		if isSuccess then
			count = count + 1
		end
	end

	return count
end

return NecrologistV4A1MO
