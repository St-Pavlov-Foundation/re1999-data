module("modules.logic.survival.model.shelter.SurvivalShelterChooseNpcListModel", package.seeall)

local var_0_0 = class("SurvivalShelterChooseNpcListModel", ListScrollModel)

function var_0_0.isQuickSelect(arg_1_0)
	return arg_1_0._isQuickSelect
end

function var_0_0.changeQuickSelect(arg_2_0)
	arg_2_0._isQuickSelect = not arg_2_0._isQuickSelect
end

function var_0_0.setSelectPos(arg_3_0, arg_3_1)
	if arg_3_0._selectPos == arg_3_1 then
		return false
	end

	arg_3_0._selectPos = arg_3_1

	return true
end

function var_0_0.setSelectNpcToPos(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 ~= nil and arg_4_2 or arg_4_0._selectPos

	if arg_4_2 == nil then
		return
	end

	if arg_4_0._pos2NpcId == nil then
		arg_4_0._pos2NpcId = {}
	end

	arg_4_0._pos2NpcId[arg_4_2] = arg_4_1

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSelectFinish)
end

function var_0_0.getSelectNpcByPos(arg_5_0, arg_5_1)
	if arg_5_1 == nil or arg_5_0._pos2NpcId == nil then
		return nil
	end

	return arg_5_0._pos2NpcId[arg_5_1]
end

function var_0_0.getAllSelectPosNpc(arg_6_0)
	local var_6_0 = {}

	if arg_6_0._pos2NpcId then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._pos2NpcId) do
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function var_0_0.npcIdIsSelect(arg_7_0, arg_7_1)
	if arg_7_0._pos2NpcId ~= nil then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._pos2NpcId) do
			if arg_7_1 == iter_7_1 then
				return iter_7_0
			end
		end
	end

	return nil
end

function var_0_0.getSelectPos(arg_8_0)
	return arg_8_0._selectPos
end

function var_0_0.setSelectNpc(arg_9_0, arg_9_1)
	if arg_9_0.selectNpcId == arg_9_1 then
		arg_9_0.selectNpcId = 0
	else
		arg_9_0.selectNpcId = arg_9_1
	end

	return true
end

function var_0_0.getSelectNpc(arg_10_0)
	return arg_10_0.selectNpcId
end

function var_0_0.clearSelectList(arg_11_0)
	if arg_11_0._npcList ~= nil then
		tabletool.clear(arg_11_0._npcList)
	else
		arg_11_0._npcList = {}
	end
end

function var_0_0.setNeedSelectNpcList(arg_12_0, arg_12_1)
	arg_12_0.selectNpcId = nil
	arg_12_0._pos2NpcId = nil
	arg_12_0._isQuickSelect = false
	arg_12_0._selectPos = nil

	if arg_12_1 == nil then
		return
	end

	arg_12_0:clearSelectList()

	for iter_12_0 = 1, #arg_12_1 do
		local var_12_0 = arg_12_1[iter_12_0]

		if SurvivalConfig.instance:getNpcConfig(var_12_0).subType ~= SurvivalEnum.NpcSubType.Story then
			local var_12_1 = SurvivalShelterNpcMo.New()

			var_12_1:init({
				id = var_12_0
			})
			table.insert(arg_12_0._npcList, var_12_1)
		end
	end
end

function var_0_0.getShowList(arg_13_0)
	return arg_13_0._npcList or {}
end

function var_0_0.filterNpc(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 or not next(arg_14_1) then
		return true
	end

	local var_14_0 = SurvivalConfig.instance:getNpcConfigTag(arg_14_2.id)
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2 = lua_survival_tag.configDict[iter_14_1]

		if var_14_2 then
			var_14_1[var_14_2.tagType] = true
		end
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_1) do
		if var_14_1[iter_14_3.type] then
			return true
		end
	end
end

function var_0_0.sort(arg_15_0, arg_15_1)
	return arg_15_0.id < arg_15_1.id
end

function var_0_0.refreshNpcList(arg_16_0, arg_16_1)
	local var_16_0 = {}

	if arg_16_0._npcList then
		for iter_16_0 = 1, #arg_16_0._npcList do
			local var_16_1 = arg_16_0._npcList[iter_16_0]

			if arg_16_0:filterNpc(arg_16_1, var_16_1) then
				table.insert(var_16_0, var_16_1)
			end
		end
	end

	if #var_16_0 > 1 then
		table.sort(var_16_0, arg_16_0.sort)
	end

	arg_16_0:setList(var_16_0)
end

local var_0_1 = 3

function var_0_0.quickSelectNpc(arg_17_0, arg_17_1)
	local var_17_0 = true

	for iter_17_0 = 1, var_0_1 do
		if arg_17_0._pos2NpcId and arg_17_0._pos2NpcId[iter_17_0] == arg_17_1 then
			arg_17_0:setSelectNpcToPos(nil, iter_17_0)
			arg_17_0:setSelectNpc(arg_17_1)

			var_17_0 = false
		end
	end

	if var_17_0 then
		local var_17_1 = 1

		for iter_17_1 = 1, var_0_1 do
			if arg_17_0._pos2NpcId == nil or arg_17_0._pos2NpcId[iter_17_1] == nil then
				var_17_1 = iter_17_1

				break
			end
		end

		if arg_17_0._pos2NpcId == nil or arg_17_0._pos2NpcId[var_17_1] == nil then
			arg_17_0:setSelectNpcToPos(arg_17_1, var_17_1)
			arg_17_0:setSelectNpc(arg_17_1)
		end
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSelectFinish)
end

var_0_0.instance = var_0_0.New()

return var_0_0
