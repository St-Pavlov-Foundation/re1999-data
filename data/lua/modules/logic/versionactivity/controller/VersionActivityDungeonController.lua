module("modules.logic.versionactivity.controller.VersionActivityDungeonController", package.seeall)

local var_0_0 = class("VersionActivityDungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivityDungeonMapView(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.rpcCallback = arg_3_3
	arg_3_0.rpcCallbackObj = arg_3_4
	arg_3_0.openViewParam = {
		chapterId = arg_3_1,
		episodeId = arg_3_2
	}

	if arg_3_5 then
		for iter_3_0, iter_3_1 in pairs(arg_3_5) do
			arg_3_0.openViewParam[iter_3_0] = iter_3_1
		end
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, arg_3_0._openVersionActivityDungeonMapView, arg_3_0)
end

function var_0_0._openVersionActivityDungeonMapView(arg_4_0)
	ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapView, arg_4_0.openViewParam)

	if arg_4_0.rpcCallback then
		arg_4_0.rpcCallback(arg_4_0.rpcCallbackObj)
	end
end

function var_0_0.getEpisodeMapConfig(arg_5_0, arg_5_1)
	local var_5_0 = DungeonConfig.instance:getEpisodeCO(arg_5_1)

	if var_5_0.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard then
		local var_5_1 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(arg_5_1)
		local var_5_2 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)

		for iter_5_0, iter_5_1 in ipairs(var_5_2) do
			if var_5_1 == DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(iter_5_1.id) then
				var_5_0 = iter_5_1

				break
			end
		end
	else
		while var_5_0.chapterId ~= VersionActivityEnum.DungeonChapterId.LeiMiTeBei do
			var_5_0 = DungeonConfig.instance:getEpisodeCO(var_5_0.preEpisode)
		end
	end

	return DungeonConfig.instance:getChapterMapCfg(VersionActivityEnum.DungeonChapterId.LeiMiTeBei, var_5_0.preEpisode)
end

var_0_0.instance = var_0_0.New()

return var_0_0
