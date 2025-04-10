module("modules.logic.guide.controller.trigger.GuideTriggerStoryStep", package.seeall)

slot0 = class("GuideTriggerStoryStep", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, slot0._onStep, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	slot3 = string.splitToNumber(slot2, "_")

	if not slot1 then
		return false
	end

	if #slot3 == 1 then
		return slot3[1] == slot1.storyId
	elseif #slot3 > 1 then
		return slot3[1] == slot1.storyId and slot3[2] == slot1.stepId
	end
end

function slot0._onStep(slot0, slot1)
	if slot1.storyId and slot1.stepId then
		slot0:checkStartGuide(slot1)
	end
end

return slot0
