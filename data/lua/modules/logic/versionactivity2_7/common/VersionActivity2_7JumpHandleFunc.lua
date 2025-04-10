module("modules.logic.versionactivity2_7.common.VersionActivity2_7JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity2_7JumpHandleFunc")

function slot0.jumpTo12003(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_7EnterView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity2_0DungeonMapLevelView)

	if slot1[3] then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				if VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState() then
					ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
				end

				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_0DungeonController.openVersionActivityDungeonMapView, VersionActivity2_0DungeonController.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12713(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_7EnterView)
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity2_7Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12005(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_0DungeonMapView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_0DungeonGraffitiView)

	function slot2()
		Activity161Controller.instance:openGraffitiView()
	end

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function ()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity2_0DungeonMapView) then
			uv0()
		else
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, , uv0)
		end
	end, nil, , true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12701(slot0)
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterView(function ()
		Activity191Controller.instance:openMainView()
	end, nil, VersionActivity2_7Enum.ActivityId.Act191, true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12706(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_7EnterView)
	table.insert(slot0.closeViewNames, VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName())
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	slot5 = VersionActivityFixedHelper.getVersionActivityDungeonController()

	if slot1[3] then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function ()
			uv0.instance:openVersionActivityDungeonMapView(nil, uv1, function ()
				ViewMgr.instance:openView(uv0, {
					isJump = true,
					episodeId = uv1
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(slot5.openVersionActivityDungeonMapView, slot5.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12707(slot0, slot1)
	slot2 = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(slot2.openStoreView, slot2.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12714(slot0, slot1)
	slot2 = slot1[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(uv0.enterRoleActivity, slot2, slot2)

	return JumpEnum.JumpResult.Success
end

function slot0.enterRoleActivity(slot0)
	RoleActivityController.instance:enterActivity(slot0)
end

function slot0.jumpTo12702(slot0, slot1)
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12703(slot0, slot1)
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12704(slot0, slot1)
	VersionActivityFixedHelper.getVersionActivityEnterController():openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

return slot0
