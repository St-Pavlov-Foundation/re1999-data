module("modules.logic.guide.controller.action.impl.WaitGuideActionPlayStoryStep", package.seeall)

slot0 = class("WaitGuideActionPlayStoryStep", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, slot0._onStep, slot0)

	if #string.splitToNumber(slot0.actionParam, "#") == 2 then
		slot0.storyId = slot2[1]
		slot0.stepId = slot2[2]
	end
end

function slot0._onStep(slot0, slot1)
	if slot0.storyId and slot0.stepId and slot0.storyId == slot1.storyId and slot0.stepId == slot1.stepId then
		StoryController.instance:unregisterCallback(StoryEvent.RefreshStep, slot0._onStep, slot0)

		if StoryModel.instance:isStoryAuto() then
			StoryModel.instance:setStoryAuto(false)
			StoryController.instance:dispatchEvent(StoryEvent.Auto)
		end

		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.RefreshStep, slot0._onStep, slot0)
end

return slot0
