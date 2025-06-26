module("modules.logic.commandstation.model.CommandStationTaskListModel", package.seeall)

local var_0_0 = class("CommandStationTaskListModel", ListScrollModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0.allNormalTaskMos = {}
	arg_1_0.allCatchTaskMos = {}
	arg_1_0.curSelectType = 1

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.initServerData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.allNormalTaskMos = {}
	arg_2_0.allCatchTaskMos = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = lua_copost_version_task.configDict[iter_2_1.id]

		if var_2_0 then
			local var_2_1 = TaskMo.New()

			var_2_1:init(iter_2_1, var_2_0)
			table.insert(arg_2_0.allNormalTaskMos, var_2_1)
		else
			logError("指挥部任务ID不存在" .. iter_2_1.id)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_2) do
		local var_2_2 = lua_copost_catch_task.configDict[iter_2_3.id]

		if var_2_2 then
			local var_2_3 = TaskMo.New()

			var_2_3:init(iter_2_3, var_2_2)
			table.insert(arg_2_0.allCatchTaskMos, var_2_3)
		else
			logError("指挥部任务ID不存在" .. iter_2_3.id)
		end
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.OnTaskUpdate)
end

function var_0_0.init(arg_3_0)
	local var_3_0 = arg_3_0.curSelectType == 1 and arg_3_0.allNormalTaskMos or arg_3_0.allCatchTaskMos
	local var_3_1 = {}
	local var_3_2 = 0

	if var_3_0 ~= nil then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			local var_3_3 = CommandStationTaskMo.New()

			var_3_3:init(iter_3_1.config, iter_3_1)

			if var_3_3:alreadyGotReward() then
				var_3_2 = var_3_2 + 1
			end

			table.insert(var_3_1, var_3_3)
		end
	end

	if var_3_2 > 1 then
		local var_3_4 = CommandStationTaskMo.New()

		var_3_4.id = -99999

		table.insert(var_3_1, var_3_4)
	end

	table.sort(var_3_1, var_0_0.sortMO)

	arg_3_0._hasRankDiff = false

	arg_3_0:setList(var_3_1)
end

function var_0_0.sortMO(arg_4_0, arg_4_1)
	local var_4_0 = var_0_0.getSortIndex(arg_4_0)
	local var_4_1 = var_0_0.getSortIndex(arg_4_1)

	if var_4_0 ~= var_4_1 then
		return var_4_0 < var_4_1
	elseif arg_4_0.id ~= arg_4_1.id then
		return arg_4_0.id < arg_4_1.id
	end
end

function var_0_0.getSortIndex(arg_5_0)
	if arg_5_0.id == -99999 then
		return 1
	elseif arg_5_0:isFinished() then
		return 100
	elseif arg_5_0:alreadyGotReward() then
		return 2
	end

	return 50
end

function var_0_0.createMO(arg_6_0, arg_6_1, arg_6_2)
	return {
		config = arg_6_2.config,
		originTaskMO = arg_6_2
	}
end

function var_0_0.getRankDiff(arg_7_0, arg_7_1)
	if arg_7_0._hasRankDiff and arg_7_1 then
		local var_7_0 = tabletool.indexOf(arg_7_0._idIdxList, arg_7_1.id)
		local var_7_1 = arg_7_0:getIndex(arg_7_1)

		if var_7_0 and var_7_1 then
			arg_7_0._idIdxList[var_7_0] = -2

			return var_7_1 - var_7_0
		end
	end

	return 0
end

function var_0_0.refreshRankDiff(arg_8_0)
	arg_8_0._idIdxList = {}

	local var_8_0 = arg_8_0:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		table.insert(arg_8_0._idIdxList, iter_8_1.id)
	end
end

function var_0_0.preFinish(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = false

	arg_9_0._hasRankDiff = false

	arg_9_0:refreshRankDiff()

	local var_9_1 = 0
	local var_9_2 = arg_9_0:getList()

	if arg_9_1.id == -99999 then
		for iter_9_0, iter_9_1 in ipairs(var_9_2) do
			if iter_9_1:alreadyGotReward() and iter_9_1.id ~= -99999 then
				iter_9_1.preFinish = true
				var_9_0 = true
				var_9_1 = var_9_1 + 1
			end
		end
	elseif arg_9_1:alreadyGotReward() then
		arg_9_1.preFinish = true
		var_9_0 = true
		var_9_1 = var_9_1 + 1
	end

	if var_9_0 then
		local var_9_3 = arg_9_0:getById(-99999)

		if var_9_3 and arg_9_0:getGotRewardCount() < var_9_1 + 1 then
			tabletool.removeValue(var_9_2, var_9_3)
		end

		arg_9_0._hasRankDiff = true

		table.sort(var_9_2, var_0_0.sortMO)
		arg_9_0:setList(var_9_2)

		arg_9_0._hasRankDiff = false
	end
end

function var_0_0.getGotRewardCount(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 or arg_10_0:getList()
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1:alreadyGotReward() and not iter_10_1.preFinish and iter_10_1.id ~= -99999 then
			var_10_1 = var_10_1 + 1
		end
	end

	return var_10_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
