module("modules.logic.versionactivity3_0.common.VersionActivity3_0JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity3_0JumpHandleFunc")

function var_0_0.jumpTo12102(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[2]
	local var_1_1 = arg_1_1[3]

	table.insert(arg_1_0.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	table.insert(arg_1_0.closeViewNames, ViewName.VersionActivity2_1DungeonMapLevelView)
	VersionActivity2_1DungeonModel.instance:setMapNeedTweenState(true)

	if var_1_1 then
		VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
					isJump = true,
					episodeId = var_1_1
				})
			end)
		end, nil, var_1_0, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_1DungeonController.openVersionActivityDungeonMapView, VersionActivity2_1DungeonController.instance, var_1_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13010(arg_4_0, arg_4_1)
	table.insert(arg_4_0.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_4_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_0Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12104(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1[2]

	VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, function()
			Activity165Controller.instance:openActivity165EnterView()
		end)
	end, nil, var_6_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13008(arg_9_0, arg_9_1)
	VersionActivity3_0DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13011(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1[2]
	local var_10_1 = arg_10_1[3]

	table.insert(arg_10_0.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	table.insert(arg_10_0.closeViewNames, ViewName.Activity201MaLiAnNaTaskView)

	if var_10_1 and var_10_1 == 1 then
		if ActivityHelper.getActivityStatus(var_10_0) == ActivityEnum.ActivityStatus.Normal then
			local var_10_2 = ActivityConfig.instance:getActivityCo(var_10_0).tryoutEpisode

			if var_10_2 <= 0 then
				logError("没有配置对应的试用关卡")

				return JumpEnum.JumpResult.Fail
			end

			local var_10_3 = DungeonConfig.instance:getEpisodeCO(var_10_2)

			DungeonFightController.instance:enterFight(var_10_3.chapterId, var_10_2)

			return JumpEnum.JumpResult.Success
		else
			local var_10_4, var_10_5 = OpenHelper.getToastIdAndParam(arg_10_0.actCo.openId)

			if var_10_4 and var_10_4 ~= 0 then
				GameFacade.showToast(var_10_4)

				return JumpEnum.JumpResult.Fail
			end

			return JumpEnum.JumpResult.Success
		end
	else
		VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity201MaLiAnNaController.instance:enterLevelView()
		end, nil, var_10_0, true)

		return JumpEnum.JumpResult.Success
	end
end

function var_0_0.jumpTo13015(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[2]

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		ViewMgr.instance:openView(ViewName.KaRongLevelView)
	end, nil, var_12_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13000(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1[2]

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Activity104Controller.instance:openSeasonMainView()
	end, nil, var_14_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13015(arg_16_0, arg_16_1)
	table.insert(arg_16_0.closeViewNames, ViewName.KaRongTaskView)
	table.insert(arg_16_0.closeViewNames, ViewName.KaRongLevelView)

	local var_16_0 = arg_16_1[2]

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_16_0, true)

	return JumpEnum.JumpResult.Success
end

return var_0_0
