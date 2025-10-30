﻿-- chunkname: @modules/logic/versionactivity2_5/common/VersionActivity2_5JumpHandleFunc.lua

module("modules.logic.versionactivity2_5.common.VersionActivity2_5JumpHandleFunc", package.seeall)

local VersionActivity2_5JumpHandleFunc = class("VersionActivity2_5JumpHandleFunc")

function VersionActivity2_5JumpHandleFunc:jumpTo12301()
	VersionActivity2_5EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_5JumpHandleFunc:jumpTo12502(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity2_5DungeonMapLevelView)
	VersionActivity2_5DungeonModel.instance:setMapNeedTweenState(true)

	if episodeId then
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_5DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_5DungeonController.openVersionActivityDungeonMapView, VersionActivity2_5DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_5JumpHandleFunc:jumpTo12503(paramsList)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_5DungeonController.openStoreView, VersionActivity2_5DungeonController.instance, VersionActivity2_5Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_5JumpHandleFunc.enterRoleActivity(actId)
	RoleActivityController.instance:enterActivity(actId)
end

function VersionActivity2_5JumpHandleFunc:jumpTo11602(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)

	if episodeId then
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_6DungeonController.openVersionActivityDungeonMapView, VersionActivity1_6DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_5JumpHandleFunc:jumpTo12514(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity2_5Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_5JumpHandleFunc:jumpTo12505(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	table.insert(self.waitOpenViewNames, ViewName.Act183MainView)
	table.insert(self.waitOpenViewNames, ViewName.Act183DungeonView)
	table.insert(self.closeViewNames, ViewName.Act183TaskView)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		local episodeId = paramsList and paramsList[3]
		local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
		local groupType = episodeCo and episodeCo.type
		local groupId = episodeCo and episodeCo.groupId
		local viewParam = Act183Helper.generateDungeonViewParams(groupType, groupId)

		if not ViewMgr.instance:isOpen(ViewName.Act183MainView) then
			Act183Controller.instance:openAct183MainView(nil, function()
				Act183Controller.instance:openAct183DungeonView(viewParam)
			end)
		else
			Act183Controller.instance:openAct183DungeonView(viewParam)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_5JumpHandleFunc:jumpTo12512(paramsList)
	local actId = paramsList[2]

	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_5JumpHandleFunc:jumpTo12513(paramsList)
	local actId = paramsList[2]

	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_5JumpHandleFunc:jumpTo12520(paramsList)
	Activity187Controller.instance:openAct187View()

	return JumpEnum.JumpResult.Success
end

return VersionActivity2_5JumpHandleFunc
