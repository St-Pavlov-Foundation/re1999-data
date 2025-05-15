module("modules.logic.survival.view.shelter.SurvivalShelterRewardView", package.seeall)

local var_0_0 = class("SurvivalShelterRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/title/#txt_score")
	arg_1_0._gonormalline = gohelper.findChild(arg_1_0.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	arg_1_0._rectnormalline = arg_1_0._gonormalline.transform
	arg_1_0.startSpace = 2
	arg_1_0.cellWidth = 268
	arg_1_0.space = 0

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnGainReward, arg_2_0.onGainReward, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnGainReward, arg_3_0.onGainReward, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onGainReward(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.refreshView(arg_7_0)
	arg_7_0:refreshReward()
	arg_7_0:refreshProgress()
end

function var_0_0.refreshProgress(arg_8_0)
	local var_8_0 = SurvivalModel.instance:getOutSideInfo()
	local var_8_1 = var_8_0:getScore()

	arg_8_0._txtScore.text = var_8_1

	local var_8_2 = SurvivalShelterRewardListModel.instance:getList()
	local var_8_3 = #var_8_2
	local var_8_4

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		if var_8_4 == nil and not var_8_0:isGainReward(iter_8_1.id) then
			var_8_4 = iter_8_0
		end

		if var_8_1 < iter_8_1.score then
			var_8_3 = iter_8_0 - 1

			break
		end
	end

	local var_8_5 = var_8_2[var_8_3] and var_8_2[var_8_3].score or 0
	local var_8_6 = var_8_2[var_8_3 + 1] and var_8_2[var_8_3 + 1].score or var_8_5
	local var_8_7 = 0
	local var_8_8 = arg_8_0:getNodeWidth(var_8_3, var_8_7)
	local var_8_9 = arg_8_0:getNodeWidth(var_8_3 + 1, var_8_7) - var_8_8
	local var_8_10 = 0

	if var_8_5 < var_8_6 then
		var_8_10 = (var_8_1 - var_8_5) / (var_8_6 - var_8_5) * var_8_9
	end

	recthelper.setWidth(arg_8_0._rectnormalline, var_8_8 + var_8_10)

	if not arg_8_0.isPlayMove then
		arg_8_0.isPlayMove = true

		if var_8_4 ~= nil then
			arg_8_0.viewContainer:getScrollView():moveToByIndex(var_8_4, 0.2)
		end
	end
end

function var_0_0.getNodeWidth(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or 0

	local var_9_0 = arg_9_2

	if arg_9_1 > 0 then
		var_9_0 = (arg_9_1 - 1) * (arg_9_0.cellWidth + arg_9_0.space) + (arg_9_0.startSpace + arg_9_0.cellWidth * 0.5) + arg_9_2
	end

	return var_9_0
end

function var_0_0.refreshReward(arg_10_0)
	SurvivalShelterRewardListModel.instance:refreshList()
end

function var_0_0.checkGetReward(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = RoleStoryConfig.instance:getRewardList(arg_11_0.storyId)

	if var_11_1 then
		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			if RoleStoryModel.instance:getRewardState(iter_11_1.storyId, iter_11_1.id, iter_11_1.score) == 1 then
				table.insert(var_11_0, iter_11_1.id)
			end
		end
	end

	if #var_11_0 > 0 then
		HeroStoryRpc.instance:sendGetScoreBonusRequest(var_11_0)
	end
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.checkGetReward, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
