module("modules.logic.rouge.map.work.WaitRougeStoryDoneWork", package.seeall)

local var_0_0 = class("WaitRougeStoryDoneWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.storyId = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0.storyId or arg_2_0.storyId == 0 then
		return arg_2_0:onDone(true)
	end

	StoryController.instance:playStory(arg_2_0.storyId, nil, arg_2_0.onStoryDone, arg_2_0)
end

function var_0_0.onStoryDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
