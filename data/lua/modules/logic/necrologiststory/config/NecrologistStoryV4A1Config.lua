-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryV4A1Config.lua

module("modules.logic.necrologiststory.config.NecrologistStoryV4A1Config", package.seeall)

local NecrologistStoryV4A1Config = class("NecrologistStoryV4A1Config", NecrologistStoryVersionConfigBase)

function NecrologistStoryV4A1Config:ctor()
	return
end

function NecrologistStoryV4A1Config:reqConfigNames()
	return {
		"hero_story_mode_v4a1_role",
		"hero_story_mode_v4a1_check"
	}
end

function NecrologistStoryV4A1Config:onLoadhero_story_mode_v4a1_role(configTable)
	self._roleConfig = configTable
end

function NecrologistStoryV4A1Config:onLoadhero_story_mode_v4a1_check(configTable)
	self._checkConfig = configTable
end

function NecrologistStoryV4A1Config:getRoleConfig(id)
	return self._roleConfig.configDict[id]
end

function NecrologistStoryV4A1Config:getRoleList()
	return self._roleConfig.configList
end

function NecrologistStoryV4A1Config:getCheckConfig(id)
	return self._checkConfig.configDict[id]
end

function NecrologistStoryV4A1Config:getCheckList(storyId)
	if not self.storyId2CheckList then
		self.storyId2CheckList = {}

		for _, checkConfig in pairs(self._checkConfig.configList) do
			local storyId = checkConfig.storyId

			if not self.storyId2CheckList[storyId] then
				self.storyId2CheckList[storyId] = {}
			end

			table.insert(self.storyId2CheckList[storyId], checkConfig.id)
		end
	end

	return self.storyId2CheckList[storyId]
end

NecrologistStoryV4A1Config.instance = NecrologistStoryV4A1Config.New()

return NecrologistStoryV4A1Config
