module("modules.logic.rouge.map.work.WaitRougeStoryDoneWork", package.seeall)

slot0 = class("WaitRougeStoryDoneWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.storyId = slot1
end

function slot0.onStart(slot0)
	if not slot0.storyId or slot0.storyId == 0 then
		return slot0:onDone(true)
	end

	StoryController.instance:playStory(slot0.storyId, nil, slot0.onStoryDone, slot0)
end

function slot0.onStoryDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
