module("modules.logic.sp01.enter.controller.VersionActivity2_9JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_9JumpHandleFunc")

function var_0_0.jumpTo130502(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[2]
	local var_1_1 = arg_1_1[3]
	local var_1_2 = ViewName.VersionActivity2_9EnterView
	local var_1_3 = ViewName.VersionActivity2_9DungeonMapLevelView

	table.insert(arg_1_0.waitOpenViewNames, var_1_2)
	table.insert(arg_1_0.closeViewNames, var_1_3)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	if var_1_1 then
		VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1, function()
				ViewMgr.instance:openView(var_1_3, {
					isJump = true,
					episodeId = var_1_1
				})
			end)
		end, nil, var_1_0, true)
	else
		VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_9DungeonController.openVersionActivityDungeonMapView, VersionActivity2_9DungeonController.instance, var_1_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130503(arg_4_0, arg_4_1)
	table.insert(arg_4_0.waitOpenViewNames, ViewName.VersionActivity2_9StoreView)
	VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_9DungeonController.openStoreView, VersionActivity2_9DungeonController.instance, VersionActivity2_9Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130504(arg_5_0, arg_5_1)
	VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		var_0_0._handleJumpTo130504(arg_5_1)
	end, nil, VersionActivity2_9Enum.ActivityId.Outside, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0._handleJumpTo130504(arg_7_0)
	local var_7_0 = arg_7_0[3]

	if var_7_0 == 1 then
		local var_7_1

		if arg_7_0[4] then
			var_7_1 = tonumber(arg_7_0[4])
		end

		AssassinController.instance:openAssassinMapView({
			buildingType = var_7_1
		})
	elseif var_7_0 == 2 then
		AssassinController.instance:openAssassinMapView({
			questMapId = tonumber(arg_7_0[3])
		})
	elseif var_7_0 == 3 then
		AssassinController.instance:openAssassinMapView({
			questId = tonumber(arg_7_0[3])
		})
	else
		logError("not define type : %s", var_7_0)
	end
end

function var_0_0.jumpTo130507(arg_8_0, arg_8_1)
	VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(OdysseyDungeonController.openDungeonView, OdysseyDungeonController.instance, VersionActivity2_9Enum.ActivityId.Dungeon2, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130518(arg_9_0, arg_9_1)
	Activity204Controller.instance:jumpToActivity(arg_9_1[2])

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130519(arg_10_0, arg_10_1)
	Activity204Controller.instance:jumpToActivity(arg_10_1[2])

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130508(arg_11_0)
	local var_11_0 = VersionActivity3_0Enum.ActivityId.Reactivity

	if GameBranchMgr.instance:isOnVer(2, 9) then
		if not ViewMgr.instance:isOpen(ViewName.V2a3_ReactivityEnterview) then
			ViewMgr.instance:openView(ViewName.V2a3_ReactivityEnterview)
		end

		VersionActivity2_3DungeonController.instance:openStoreView()
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_3DungeonController.openStoreView, VersionActivity2_3DungeonController.instance, var_11_0, true)
	end

	return JumpEnum.JumpResult.Success
end

return var_0_0
