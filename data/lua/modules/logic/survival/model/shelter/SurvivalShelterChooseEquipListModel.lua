module("modules.logic.survival.model.shelter.SurvivalShelterChooseEquipListModel", package.seeall)

local var_0_0 = class("SurvivalShelterChooseEquipListModel", ListScrollModel)

function var_0_0.setSelectEquip(arg_1_0, arg_1_1)
	if arg_1_0.selectEquipId == arg_1_1 then
		arg_1_0.selectEquipId = 0
	else
		arg_1_0.selectEquipId = arg_1_1
	end

	return true
end

function var_0_0.setSelectPos(arg_2_0, arg_2_1)
	if arg_2_0._selectPos == arg_2_1 then
		return
	end

	arg_2_0._selectPos = arg_2_1

	return true
end

function var_0_0.getSelectPos(arg_3_0)
	return arg_3_0._selectPos
end

function var_0_0.getSelectEquip(arg_4_0)
	return arg_4_0.selectEquipId
end

function var_0_0.setNeedSelectEquipList(arg_5_0, arg_5_1)
	arg_5_0.selectEquipId = nil
	arg_5_0._pos2Id = nil
	arg_5_0._selectPos = nil

	if arg_5_1 == nil then
		return
	end

	arg_5_0._equipList = {}

	for iter_5_0 = 1, #arg_5_1 do
		local var_5_0 = SurvivalBagItemMo.New()

		var_5_0:init({
			id = arg_5_1[iter_5_0]
		})
		table.insert(arg_5_0._equipList, var_5_0)
	end
end

function var_0_0.getShowList(arg_6_0)
	return arg_6_0._equipList or {}
end

function var_0_0.setSelectIdToPos(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 ~= nil and arg_7_2 or arg_7_0._selectPos

	if arg_7_2 == nil then
		return
	end

	if arg_7_0._pos2Id == nil then
		arg_7_0._pos2Id = {}
	end

	arg_7_0._pos2Id[arg_7_2] = arg_7_1

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSelectFinish)
end

function var_0_0.getAllSelectPosEquip(arg_8_0)
	local var_8_0 = {}

	if arg_8_0._pos2Id then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._pos2Id) do
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.getSelectIdByPos(arg_9_0, arg_9_1)
	if arg_9_1 == nil or arg_9_0._pos2Id == nil then
		return nil
	end

	return arg_9_0._pos2Id[arg_9_1]
end

function var_0_0.npcIdIsSelect(arg_10_0, arg_10_1)
	if arg_10_0._pos2Id ~= nil then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._pos2Id) do
			if arg_10_1 == iter_10_1 then
				return iter_10_0
			end
		end
	end

	return nil
end

function var_0_0.filterEquip(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 or not next(arg_11_1) then
		return true
	end

	local var_11_0 = lua_survival_equip.configDict[arg_11_2.id].tag
	local var_11_1 = SurvivalConfig.instance:getSplitTag(var_11_0)
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		var_11_2[iter_11_1] = true
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_1) do
		if var_11_2[iter_11_3.type] then
			return true
		end
	end
end

function var_0_0.sort(arg_12_0, arg_12_1)
	return arg_12_0.id < arg_12_1.id
end

function var_0_0.refreshList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if arg_13_0._equipList then
		for iter_13_0 = 1, #arg_13_0._equipList do
			local var_13_1 = arg_13_0._equipList[iter_13_0]

			if arg_13_0:filterEquip(arg_13_1, var_13_1) then
				table.insert(var_13_0, var_13_1)
			end
		end
	end

	if #var_13_0 > 1 then
		table.sort(var_13_0, arg_13_0.sort)
	end

	arg_13_0:setList(var_13_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
