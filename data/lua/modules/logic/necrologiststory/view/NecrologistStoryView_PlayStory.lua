-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryView_PlayStory.lua

module("modules.logic.necrologiststory.view.NecrologistStoryView_PlayStory", package.seeall)

local NecrologistStoryView_PlayStory = class("NecrologistStoryView_PlayStory", BaseView)

function NecrologistStoryView_PlayStory:onInitView()
	self.goLeftStyle = gohelper.findChild(self.viewGO, "leftstyle")
end

function NecrologistStoryView_PlayStory:getStoryView()
	return self.viewContainer:getStoryView()
end

function NecrologistStoryView_PlayStory:createStoryItemAsync(...)
	local storyView = self:getStoryView()

	storyView:createStoryItemAsync(...)
end

function NecrologistStoryView_PlayStory:playStory_location(storyConfig, isSkip)
	self:createStoryItemAsync(NecrologistStoryLocationItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_dialog(storyConfig, isSkip)
	self:createStoryItemAsync(NecrologistStoryDialogItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_aside(storyConfig, isSkip)
	self:createStoryItemAsync(NecrologistStoryAsideItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_options(storyConfig, isSkip)
	self:createStoryItemAsync(NecrologistStoryOptionsItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_system(storyConfig, isSkip)
	self:createStoryItemAsync(NecrologistStorySystemItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_pause(storyConfig, isSkip)
	self:createStoryItemAsync(NecrologistStoryPauseItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_control(storyConfig, isSkip)
	local storyView = self:getStoryView()

	storyView:addControl(storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_situationValue(storyConfig, isSkip)
	local storyView = self:getStoryView()
	local arr = GameUtil.splitString2(storyConfig.param, false, "|", "#")

	if arr then
		for i, v in ipairs(arr) do
			storyView:getStoryMo():addSituationValue(v[1], tonumber(v[2]))
		end
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSituationValue)
	storyView:runNextStep(isSkip)
end

function NecrologistStoryView_PlayStory:playStory_situation(storyConfig, isSkip)
	local storyView = self:getStoryView()
	local sectionId = storyView:getStoryMo():compareSituationValue(storyConfig.param)

	if sectionId then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSelectSection, sectionId, isSkip)
	else
		storyView:runNextStep(isSkip)
	end
end

function NecrologistStoryView_PlayStory:playStory_v3a2options(storyConfig, isSkip)
	self:createStoryItemAsync(V3A2NecrologistStoryOptionsItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_v3a4AudioControl(storyConfig, isSkip)
	self:createStoryItemAsync(NecrologistStoryClickAudioItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_v3a5Item(storyConfig, isSkip)
	self:createStoryItemAsync(V3A5NecrologistStoryLongPressItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_v3a7EmailItem(storyConfig, isSkip)
	self:createStoryItemAsync(V3A7NecrologistStoryEmailItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_commontask(storyConfig, isSkip)
	local storyView = self:getStoryView()
	local arr = GameUtil.splitString2(storyConfig.param, true, "|", "#")

	if arr then
		for i, v in ipairs(arr) do
			storyView:getStoryMo():addTaskValue(v[1], v[2])
		end
	end

	storyView:runNextStep(isSkip)
end

function NecrologistStoryView_PlayStory:playStory_time(storyConfig, isSkip)
	local storyView = self:getStoryView()
	local mo = NecrologistStoryModel.instance:getCurStoryMO()

	mo:setTime(storyConfig.param)
	storyView:runNextStep(isSkip)
end

function NecrologistStoryView_PlayStory:playStory_v3a8LeftStyle(storyConfig, isSkip)
	self:createStoryItemAsync(V3A8NecrologistStoryLeftStyle, storyConfig, isSkip, self.goLeftStyle)
end

function NecrologistStoryView_PlayStory:playStory_v3a8Interact(storyConfig, isSkip)
	self:createStoryItemAsync(V3A8NecrologistStoryInteractItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_event(storyConfig, isSkip)
	local param = string.split(storyConfig.param, "#")
	local eventName = table.remove(param, 1)
	local eventId = NecrologistStoryEvent[eventName]

	if eventId then
		local eventParam = NecrologistStoryHelper.parseEventParam(eventId, param)

		NecrologistStoryController.instance:dispatchEvent(eventId, eventParam)
	end

	local storyView = self:getStoryView()

	storyView:runNextStep(isSkip)
end

function NecrologistStoryView_PlayStory:playStory_v3a9Item(storyConfig, isSkip)
	self:createStoryItemAsync(V3A9NecrologistStoryItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_v3a9Book(storyConfig, isSkip)
	self:createStoryItemAsync(V3A9NecrologistStoryBookItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_v4a1Hero(storyConfig, isSkip)
	self:createStoryItemAsync(V4A1NecrologistStoryHeroItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_v4a1Check(storyConfig, isSkip)
	self:createStoryItemAsync(V4A1NecrologistStoryCheckItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_mulOption(storyConfig, isSkip)
	self:createStoryItemAsync(NecrologistStoryOptionsItem, storyConfig, isSkip)
end

function NecrologistStoryView_PlayStory:playStory_v4a1CheckCount(storyConfig, isSkip)
	local storyView = self:getStoryView()
	local params = string.splitToNumber(storyConfig.param, "#")
	local count = params[1] or 0
	local mo = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V4A1)
	local checkCount = mo:getCheckCount()
	local sectionId = count <= checkCount and params[2] or params[3]

	if sectionId then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSelectSection, sectionId, isSkip)
	end
end

function NecrologistStoryView_PlayStory:playStory_v4a1Result(storyConfig, isSkip)
	self:createStoryItemAsync(V4A1NecrologistStoryResultItem, storyConfig, isSkip)
end

return NecrologistStoryView_PlayStory
