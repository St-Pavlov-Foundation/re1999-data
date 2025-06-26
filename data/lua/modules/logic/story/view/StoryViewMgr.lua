module("modules.logic.story.view.StoryViewMgr", package.seeall)

local var_0_0 = class("StoryViewMgr")

function var_0_0.open(arg_1_0, arg_1_1)
	return
end

function var_0_0.close(arg_2_0)
	return
end

function var_0_0.getStoryBackgroundView(arg_3_0)
	local var_3_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView)

	if not var_3_0 then
		return nil
	end

	return var_3_0.viewGO
end

function var_0_0.getStoryFrontBgGo(arg_4_0)
	local var_4_0 = arg_4_0:getStoryBackgroundView()

	if not var_4_0 then
		return nil
	end

	return (gohelper.findChild(var_4_0, "#go_upbg"))
end

function var_0_0.getStoryHeroView(arg_5_0)
	return
end

function var_0_0.getStoryView(arg_6_0)
	return
end

function var_0_0.getStoryLeadRoleSpineView(arg_7_0)
	return
end

function var_0_0.getStoryFrontView(arg_8_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
