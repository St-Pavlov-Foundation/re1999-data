-- chunkname: @modules/logic/versionactivity4_1/common/VersionActivity4_1JumpHandleFunc.lua

module("modules.logic.versionactivity4_1.common.VersionActivity4_1JumpHandleFunc", package.seeall)

local VersionActivity4_1JumpHandleFunc = class("VersionActivity4_1JumpHandleFunc")

function VersionActivity4_1JumpHandleFunc:jumpTo14102(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity4_1EnterView)
	table.insert(self.closeViewNames, mapLevelViewName)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	if episodeId then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			dungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openVersionActivityDungeonMapView, dungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity4_1JumpHandleFunc:jumpTo14103(paramsList)
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(dungeonController.openStoreView, dungeonController.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity4_1JumpHandleFunc:jumpTo14104(paramsList)
	local dungeonActId = VersionActivity4_1Enum.ActivityId.Dungeon
	local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity4_1EnterView)
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		dungeonController.instance:openVersionActivityDungeonMapView(nil, nil, function()
			Act248Controller.instance:openAct248EnterView()
		end)
	end, nil, dungeonActId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity4_1JumpHandleFunc:jumpTo14120(paramsList)
	local actId = paramsList[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		EvelynController.instance:enterEpisodeLevelView()
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity4_1JumpHandleFunc:jumpTo14121(paramsList)
	local actId = paramsList[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		PeiShiTaController.instance:enterEpisodeLevelView()
	end, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

return VersionActivity4_1JumpHandleFunc
