module("modules.logic.versionactivity1_4.puzzle.model.Role37PuzzleModel", package.seeall)

local var_0_0 = class("Role37PuzzleModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.clear(arg_2_0)
	arg_2_0.puzzleCfg = nil
	arg_2_0.maxStep = nil
	arg_2_0.maxOper = nil
	arg_2_0.operGroupId = nil
	arg_2_0.operGroupCfg = nil
	arg_2_0.operGroupList = nil
	arg_2_0.matchList = nil
	arg_2_0.operList = nil
	arg_2_0.recordList = nil
	arg_2_0.controllRecords = nil
	arg_2_0.isSucess = nil
end

function var_0_0.setPuzzleId(arg_3_0, arg_3_1)
	arg_3_0.puzzleId = arg_3_1

	arg_3_0:initCfg()
	arg_3_0:initParam()
end

function var_0_0.initCfg(arg_4_0)
	arg_4_0.puzzleCfg = Activity130Config.instance:getActivity130DecryptCo(Activity130Enum.ActivityId.Act130, arg_4_0.puzzleId)
	arg_4_0.maxStep = arg_4_0.puzzleCfg.maxStep
	arg_4_0.maxOper = arg_4_0.puzzleCfg.maxOper
	arg_4_0.operGroupId = arg_4_0.puzzleCfg.operGroupId
	arg_4_0.operGroupCfg = Activity130Config.instance:getOperGroup(Activity130Enum.ActivityId.Act130, arg_4_0.operGroupId)
	arg_4_0.operGroupList = {}

	local var_4_0 = Activity130Config.instance:getOperGroup(Activity130Enum.ActivityId.Act130, arg_4_0.operGroupId)

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		table.insert(arg_4_0.operGroupList, iter_4_1)
	end

	table.sort(arg_4_0.operGroupList, function(arg_5_0, arg_5_1)
		return arg_5_0.operType < arg_5_1.operType
	end)

	arg_4_0.matchList = string.splitToNumber(arg_4_0.puzzleCfg.answer, "|")
end

function var_0_0.initParam(arg_6_0)
	arg_6_0.operList = {}
	arg_6_0.recordList = {}

	PuzzleRecordListModel.instance:clearRecord()

	arg_6_0.controllRecords = {}

	arg_6_0:initVariable()
	arg_6_0:setCurErrorIndex(0)

	arg_6_0.isSucess = false
end

function var_0_0.initVariable(arg_7_0)
	arg_7_0.maxDis = 8
	arg_7_0.remainDis = arg_7_0.maxDis
	arg_7_0.passDay = 1
	arg_7_0.handleBa = 0
	arg_7_0.maxHandle = 6
	arg_7_0.curPos = 1
	arg_7_0.maxPos = 7
	arg_7_0.routeBaList = {
		12,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_7_0.leftBank = {
		1,
		2,
		3
	}
	arg_7_0.rightBank = {}
	arg_7_0.boat = {}
	arg_7_0.curBank = arg_7_0.leftBank
	arg_7_0.moveCnt = 0
end

function var_0_0._addRecord(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getResultDesc(arg_8_1, arg_8_2)

	table.insert(arg_8_0.recordList, var_8_0)
end

function var_0_0._directAddRecord(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or false

	table.insert(arg_9_0.recordList, arg_9_1)

	if arg_9_2 then
		arg_9_0:_updateRecord()
	end
end

function var_0_0._repelaceRecord(arg_10_0, arg_10_1)
	arg_10_0.recordList[#arg_10_0.recordList] = arg_10_1

	arg_10_0:_updateRecord()
end

function var_0_0._updateRecord(arg_11_0)
	PuzzleRecordListModel.instance:setRecordList(arg_11_0.recordList)
end

function var_0_0.addOption(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0.curErrorIndex ~= 0 and not arg_12_3 then
		if arg_12_0.curErrorIndex == 999 then
			GameFacade.showToastString(luaLang("v1a4_role37_puzzle_monkeybanana_not_enough"))
		else
			GameFacade.showToastString(luaLang("v1a4_role37_puzzle_error_tip"))
		end

		return
	end

	if arg_12_0.operList[arg_12_2] then
		arg_12_0:repleaceOption(arg_12_1, arg_12_2)

		return
	end

	if tabletool.len(arg_12_0.operList) >= arg_12_0.maxOper then
		GameFacade.showToastString(luaLang("v1a4_role37_puzzle_oper_full"))

		return
	end

	arg_12_0.operList[arg_12_2] = arg_12_1

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.AddOption, arg_12_2)
	arg_12_0:recalculate()

	if not arg_12_3 then
		table.insert(arg_12_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Add,
			arg_12_2
		})
	end

	arg_12_0:checkReply()
end

function var_0_0.exchangeOption(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0.operList[arg_13_2] then
		arg_13_0:moveOption(arg_13_1, arg_13_2)

		return
	end

	local var_13_0 = arg_13_0.operList[arg_13_1]

	arg_13_0.operList[arg_13_1] = arg_13_0.operList[arg_13_2]
	arg_13_0.operList[arg_13_2] = var_13_0

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ExchangeOption, arg_13_1, arg_13_2)
	arg_13_0:recalculate()

	if not arg_13_3 then
		table.insert(arg_13_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Exchange,
			arg_13_2,
			arg_13_1
		})
	end

	arg_13_0:checkReply()
end

function var_0_0.removeOption(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.operList[arg_14_1]

	arg_14_0.operList[arg_14_1] = nil

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RemoveOption, arg_14_1)
	arg_14_0:recalculate()

	if not arg_14_2 then
		table.insert(arg_14_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Remove,
			var_14_0,
			arg_14_1
		})
	end

	arg_14_0:checkReply()
end

function var_0_0.repleaceOption(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0.operList[arg_15_2]

	arg_15_0.operList[arg_15_2] = arg_15_1

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RepleaceOption, arg_15_1, arg_15_2)
	arg_15_0:recalculate()

	if not arg_15_3 then
		table.insert(arg_15_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Repleace,
			var_15_0,
			arg_15_2
		})
	end

	arg_15_0:checkReply()
end

function var_0_0.moveOption(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.operList[arg_16_2] = arg_16_0.operList[arg_16_1]
	arg_16_0.operList[arg_16_1] = nil

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.MoveOption, arg_16_1, arg_16_2)
	arg_16_0:recalculate()

	if not arg_16_3 then
		table.insert(arg_16_0.controllRecords, {
			Role37PuzzleEnum.ControlType.Move,
			arg_16_2,
			arg_16_1
		})
	end

	arg_16_0:checkReply()
end

function var_0_0.rollBack(arg_17_0)
	if #arg_17_0.controllRecords == 0 then
		return
	end

	local var_17_0 = arg_17_0.controllRecords[#arg_17_0.controllRecords]
	local var_17_1 = var_17_0[1]

	arg_17_0.controllRecords[#arg_17_0.controllRecords] = nil

	if var_17_1 == Role37PuzzleEnum.ControlType.Add then
		arg_17_0:removeOption(var_17_0[2], true)
	elseif var_17_1 == Role37PuzzleEnum.ControlType.Exchange then
		arg_17_0:exchangeOption(var_17_0[2], var_17_0[3], true)
	elseif var_17_1 == Role37PuzzleEnum.ControlType.Remove then
		arg_17_0:addOption(var_17_0[2], var_17_0[3], true)
	elseif var_17_1 == Role37PuzzleEnum.ControlType.Repleace then
		arg_17_0:repleaceOption(var_17_0[2], var_17_0[3], true)
	elseif var_17_1 == Role37PuzzleEnum.ControlType.Move then
		arg_17_0:moveOption(var_17_0[2], var_17_0[3], true)
	end
end

function var_0_0.reset(arg_18_0)
	arg_18_0:initParam()
	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.Reset)
end

function var_0_0.recalculate(arg_19_0)
	arg_19_0:initVariable()

	arg_19_0.recordList = {}

	local var_19_0 = tabletool.len(arg_19_0.operList)

	if var_19_0 == 0 then
		if arg_19_0.curErrorIndex ~= 0 then
			arg_19_0:setCurErrorIndex(0)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_19_0.curErrorIndex)
		end
	else
		local var_19_1 = 0

		for iter_19_0 = 1, var_19_0 do
			local var_19_2 = arg_19_0.operList[iter_19_0 + var_19_1]

			while var_19_2 == nil do
				var_19_1 = var_19_1 + 1
				var_19_2 = arg_19_0.operList[iter_19_0 + var_19_1]
			end

			if arg_19_0:RunLogic(var_19_2, var_19_1 + iter_19_0) then
				arg_19_0:_addRecord(var_19_2, var_19_1 + iter_19_0)
			else
				break
			end
		end
	end

	arg_19_0:_updateRecord()
end

function var_0_0.getOperList(arg_20_0)
	return arg_20_0.operList
end

function var_0_0.getFirstGapIndex(arg_21_0)
	local var_21_0 = tabletool.len(arg_21_0.operList)

	for iter_21_0 = 1, var_21_0 do
		if not arg_21_0.operList[iter_21_0] then
			return iter_21_0
		end
	end

	return var_21_0 + 1
end

function var_0_0.RunLogic(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		arg_22_0:_snailMove(arg_22_1, arg_22_2)

		return true
	elseif arg_22_0.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		return arg_22_0:_monkeyBanana(arg_22_1, arg_22_2)
	elseif arg_22_0.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		return arg_22_0:_wolfSheepDish(arg_22_1, arg_22_2)
	else
		return true
	end
end

function var_0_0._snailMove(arg_23_0, arg_23_1)
	if arg_23_1 == Role37PuzzleEnum.OperType.One then
		arg_23_0.remainDis = arg_23_0.remainDis - 3

		if arg_23_0.remainDis < 0 then
			arg_23_0.remainDis = 0
		end
	elseif arg_23_1 == Role37PuzzleEnum.OperType.Two then
		arg_23_0.remainDis = arg_23_0.remainDis + 2

		if arg_23_0.remainDis > arg_23_0.maxDis then
			arg_23_0.remainDis = arg_23_0.maxDis
		end
	elseif arg_23_1 == Role37PuzzleEnum.OperType.Three then
		arg_23_0.passDay = arg_23_0.passDay + 1
	end
end

function var_0_0._monkeyBanana(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = 0

	if arg_24_1 == Role37PuzzleEnum.OperType.One then
		local var_24_1 = arg_24_0.maxHandle - arg_24_0.handleBa
		local var_24_2 = arg_24_0.routeBaList[arg_24_0.curPos] - var_24_1

		if var_24_2 < 0 then
			arg_24_0.handleBa = arg_24_0.handleBa + arg_24_0.routeBaList[arg_24_0.curPos]
			arg_24_0.routeBaList[arg_24_0.curPos] = 0
		else
			arg_24_0.handleBa = arg_24_0.maxHandle
			arg_24_0.routeBaList[arg_24_0.curPos] = var_24_2
		end
	elseif arg_24_1 == Role37PuzzleEnum.OperType.Two then
		if arg_24_0.curPos + 3 <= arg_24_0.maxPos then
			arg_24_0.curPos = arg_24_0.curPos + 3

			local var_24_3 = arg_24_0.handleBa - 3

			if var_24_3 >= 0 then
				arg_24_0.handleBa = var_24_3
			else
				arg_24_0.handleBa = 0
			end
		else
			var_24_0 = arg_24_2

			arg_24_0:_directAddRecord(luaLang("v1a4_role37_puzzle_monkeybanana_arrive_destination"))
		end
	elseif arg_24_1 == Role37PuzzleEnum.OperType.Four then
		local var_24_4 = arg_24_0.curPos - 1

		arg_24_0.curPos = 1
		arg_24_0.handleBa = arg_24_0.handleBa - var_24_4

		if arg_24_0.handleBa < 0 then
			arg_24_0.handleBa = 0
		end
	elseif arg_24_1 == Role37PuzzleEnum.OperType.Five then
		arg_24_0.routeBaList[arg_24_0.curPos] = arg_24_0.routeBaList[arg_24_0.curPos] + arg_24_0.handleBa
		arg_24_0.handleBa = 0
	end

	if arg_24_0.curErrorIndex ~= var_24_0 then
		arg_24_0:setCurErrorIndex(var_24_0)
		Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_24_0.curErrorIndex)
	end

	return arg_24_0.curErrorIndex == 0
end

function var_0_0._wolfSheepDish(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = 0

	if arg_25_1 == Role37PuzzleEnum.OperType.One or arg_25_1 == Role37PuzzleEnum.OperType.Two or arg_25_1 == Role37PuzzleEnum.OperType.Three then
		local var_25_1 = tabletool.indexOf(arg_25_0.curBank, Role37PuzzleEnum.AnimalRules[arg_25_1])

		if var_25_1 and #arg_25_0.boat == 0 then
			table.remove(arg_25_0.curBank, var_25_1)

			arg_25_0.boat[1] = Role37PuzzleEnum.AnimalRules[arg_25_1]
			arg_25_0.lastPick = arg_25_0.curBank
		else
			var_25_0 = arg_25_2

			if not var_25_1 then
				arg_25_0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_pick_fault"))
			else
				arg_25_0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_boat_full"), false)
			end
		end
	elseif arg_25_1 == Role37PuzzleEnum.OperType.Four then
		arg_25_0.curBank = arg_25_0.leftBank

		if #arg_25_0.rightBank == 2 and math.abs(arg_25_0.rightBank[2] - arg_25_0.rightBank[1]) == 1 then
			var_25_0 = arg_25_2

			arg_25_0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_eat"), false)
		end
	elseif arg_25_1 == Role37PuzzleEnum.OperType.Five then
		arg_25_0.curBank = arg_25_0.rightBank

		if #arg_25_0.leftBank == 2 and math.abs(arg_25_0.leftBank[2] - arg_25_0.leftBank[1]) == 1 then
			var_25_0 = arg_25_2

			arg_25_0:_directAddRecord(luaLang("v1a4_role37_puzzle_animal_eat"), false)
		end
	elseif arg_25_1 == Role37PuzzleEnum.OperType.Six and arg_25_0.boat[1] then
		table.insert(arg_25_0.curBank, arg_25_0.boat[1])

		arg_25_0.boat[1] = nil

		if arg_25_0.lastPick and arg_25_0.lastPick ~= arg_25_0.curBank then
			arg_25_0.lastPick = nil
			arg_25_0.moveCnt = arg_25_0.moveCnt + 1
		end
	end

	if arg_25_0.curErrorIndex ~= var_25_0 then
		arg_25_0:setCurErrorIndex(var_25_0)
		Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_25_0.curErrorIndex)
	end

	return arg_25_0.curErrorIndex == 0
end

function var_0_0.getBankDesc(arg_26_0, arg_26_1)
	local var_26_0 = ""

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		local var_26_1 = luaLang(Role37PuzzleEnum.AnimalStr[iter_26_1])

		var_26_0 = var_26_0 .. var_26_1
	end

	if arg_26_1 == arg_26_0.leftBank then
		if not string.nilorempty(var_26_0) then
			var_26_0 = formatLuaLang("v1a4_role37_puzzle_leftbank_leave", var_26_0) .. ","
		end
	elseif arg_26_1 == arg_26_0.rightBank then
		if not string.nilorempty(var_26_0) then
			var_26_0 = formatLuaLang("v1a4_role37_puzzle_rightbank_leave", var_26_0) .. ","
		end
	elseif not string.nilorempty(var_26_0) then
		var_26_0 = formatLuaLang("v1a4_role37_puzzle_boat_leave", var_26_0) .. ","
	end

	return var_26_0
end

function var_0_0.getSortError5(arg_27_0)
	local var_27_0 = ""
	local var_27_1 = tabletool.indexOf(arg_27_0.operList, 1)
	local var_27_2 = tabletool.indexOf(arg_27_0.operList, 2)
	local var_27_3 = tabletool.indexOf(arg_27_0.operList, 4)
	local var_27_4 = tabletool.indexOf(arg_27_0.operList, 5)
	local var_27_5 = tabletool.indexOf(arg_27_0.operList, 6)

	if var_27_1 ~= 5 then
		var_27_0 = var_27_0 .. " " .. arg_27_0.operGroupCfg[1].name
	end

	if var_27_2 > 3 then
		var_27_0 = var_27_0 .. " " .. arg_27_0.operGroupCfg[2].name
	end

	if var_27_3 == 1 or var_27_3 == 5 or math.abs(var_27_3 - var_27_1) == 1 then
		var_27_0 = var_27_0 .. " " .. arg_27_0.operGroupCfg[4].name
	end

	if not arg_27_0.operList[var_27_4 - 1] or arg_27_0.operList[var_27_4 - 1] ~= 2 then
		var_27_0 = var_27_0 .. " " .. arg_27_0.operGroupCfg[5].name
	end

	if var_27_5 == 1 or var_27_5 == 5 then
		var_27_0 = var_27_0 .. " " .. arg_27_0.operGroupCfg[6].name
	end

	return var_27_0
end

function var_0_0.getSortError7(arg_28_0)
	local var_28_0 = ""
	local var_28_1 = tabletool.indexOf(arg_28_0.operList, 1)
	local var_28_2 = tabletool.indexOf(arg_28_0.operList, 2)
	local var_28_3 = tabletool.indexOf(arg_28_0.operList, 3)
	local var_28_4 = tabletool.indexOf(arg_28_0.operList, 4)
	local var_28_5 = tabletool.indexOf(arg_28_0.operList, 5)
	local var_28_6 = tabletool.indexOf(arg_28_0.operList, 6)
	local var_28_7 = tabletool.indexOf(arg_28_0.operList, 7)

	if math.abs(var_28_1 - var_28_2) == 1 then
		var_28_0 = var_28_0 .. " " .. arg_28_0.operGroupCfg[1].name
	end

	if math.abs(var_28_2 - var_28_1) ~= math.abs(var_28_3 - var_28_5) then
		var_28_0 = var_28_0 .. " " .. arg_28_0.operGroupCfg[2].name
	end

	if math.abs(var_28_5 - var_28_3) < 4 then
		var_28_0 = var_28_0 .. " " .. arg_28_0.operGroupCfg[3].name
	end

	if var_28_4 == 1 or var_28_4 > 3 then
		var_28_0 = var_28_0 .. " " .. arg_28_0.operGroupCfg[4].name
	end

	if math.abs(var_28_5 - var_28_3) == 1 then
		var_28_0 = var_28_0 .. " " .. arg_28_0.operGroupCfg[5].name
	end

	if math.abs(var_28_6 - var_28_7) ~= 1 then
		var_28_0 = var_28_0 .. " " .. arg_28_0.operGroupCfg[6].name
	end

	if var_28_6 < var_28_7 then
		var_28_0 = var_28_0 .. " " .. arg_28_0.operGroupCfg[7].name
	end

	return var_28_0
end

function var_0_0.getResultDesc(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.operGroupCfg[arg_29_1].operDesc .. ","

	if arg_29_0.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		local var_29_1 = {
			arg_29_0.remainDis,
			arg_29_0.passDay
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_snailmove_result"), var_29_1)
	elseif arg_29_0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules5 then
		local var_29_2 = arg_29_0.operGroupCfg[arg_29_1].name
		local var_29_3 = {
			var_29_2,
			arg_29_2
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), var_29_3)
	elseif arg_29_0.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		local var_29_4
		local var_29_5 = arg_29_0.routeBaList[1]
		local var_29_6 = arg_29_0.routeBaList[4]
		local var_29_7 = arg_29_0.maxPos - arg_29_0.curPos

		if var_29_5 > 0 and var_29_6 > 0 then
			local var_29_8 = {
				var_29_7,
				arg_29_0.handleBa,
				var_29_5,
				var_29_6
			}

			var_29_4 = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result1"), var_29_8)
		elseif var_29_5 > 0 and var_29_6 == 0 then
			local var_29_9 = {
				var_29_7,
				arg_29_0.handleBa,
				var_29_5
			}

			var_29_4 = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result2"), var_29_9)
		elseif var_29_5 == 0 and var_29_6 > 0 then
			local var_29_10 = {
				var_29_7,
				arg_29_0.handleBa,
				var_29_6
			}

			var_29_4 = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result3"), var_29_10)
		else
			local var_29_11 = {
				var_29_7,
				arg_29_0.handleBa
			}

			var_29_4 = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_monkeybanana_result4"), var_29_11)
		end

		return var_29_0 .. var_29_4
	elseif arg_29_0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules7 then
		local var_29_12 = arg_29_0.operGroupCfg[arg_29_1].name
		local var_29_13 = {
			var_29_12,
			arg_29_2
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), var_29_13)
	elseif arg_29_0.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		local var_29_14

		if arg_29_0.curBank == arg_29_0.leftBank then
			var_29_14 = luaLang("v1a4_role37_puzzle_animal_leftbank") .. ","
		else
			var_29_14 = luaLang("v1a4_role37_puzzle_animal_rightbank") .. ","
		end

		local var_29_15 = arg_29_0:getBankDesc(arg_29_0.leftBank)
		local var_29_16 = arg_29_0:getBankDesc(arg_29_0.rightBank)
		local var_29_17 = arg_29_0:getBankDesc(arg_29_0.boat)
		local var_29_18 = string.format(luaLang("v1a4_role37_puzzle_animal_movecnt"), arg_29_0.moveCnt)

		return var_29_0 .. var_29_14 .. var_29_15 .. var_29_17 .. var_29_16 .. var_29_18
	elseif arg_29_0.puzzleId == Role37PuzzleEnum.PuzzleId.Final then
		local var_29_19 = arg_29_0.operGroupCfg[arg_29_1].name
		local var_29_20 = {
			var_29_19,
			arg_29_2
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_role37_puzzle_sortbyrules_result"), var_29_20)
	end

	return ""
end

function var_0_0.checkReply(arg_30_0)
	local var_30_0 = tabletool.len(arg_30_0.operList)

	if arg_30_0.puzzleId == Role37PuzzleEnum.PuzzleId.SnailMove then
		local var_30_1 = 0
		local var_30_2 = 3
		local var_30_3 = 0

		for iter_30_0 = 1, var_30_0 do
			local var_30_4 = arg_30_0.operList[iter_30_0 + var_30_1]

			while var_30_4 == nil do
				var_30_1 = var_30_1 + 1
				var_30_4 = arg_30_0.operList[iter_30_0 + var_30_1]
			end

			local var_30_5 = var_30_4 - var_30_2

			if var_30_5 == 0 then
				if var_30_4 == 3 then
					arg_30_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_updown"))
				else
					arg_30_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_single"))
				end

				var_30_3 = iter_30_0 + var_30_1

				break
			elseif var_30_5 == 2 then
				arg_30_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_down"))

				var_30_3 = iter_30_0 + var_30_1

				break
			elseif var_30_5 == -1 then
				if var_30_4 == 1 then
					arg_30_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_single"))
				elseif var_30_4 == 2 then
					arg_30_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_snailmove_up"))
				end

				var_30_3 = iter_30_0 + var_30_1

				break
			else
				var_30_3 = 0
			end

			var_30_2 = var_30_4
		end

		if arg_30_0.curErrorIndex ~= var_30_3 then
			arg_30_0:setCurErrorIndex(var_30_3)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_30_0.curErrorIndex)
		end

		if arg_30_0.remainDis == 0 and arg_30_0.passDay == 6 then
			arg_30_0:Finish(true)

			return
		end
	elseif arg_30_0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules5 then
		local var_30_6 = {}
		local var_30_7 = 0

		for iter_30_1, iter_30_2 in pairs(arg_30_0.operList) do
			if var_30_6[iter_30_2] then
				arg_30_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_sortbyrules_only"))

				var_30_7 = iter_30_1

				break
			else
				var_30_6[iter_30_2] = 1
				var_30_7 = 0
			end
		end

		if arg_30_0.curErrorIndex ~= var_30_7 then
			arg_30_0:setCurErrorIndex(var_30_7)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_30_0.curErrorIndex)
		end

		if var_30_0 == 5 and arg_30_0.curErrorIndex == 0 then
			local var_30_8 = arg_30_0:getSortError5()

			if string.nilorempty(var_30_8) then
				arg_30_0:Finish(true)

				return
			else
				local var_30_9 = string.format(luaLang("v1a4_role37_puzzle_sortbyrules_error"), var_30_8)

				arg_30_0:_directAddRecord(var_30_9, true)
			end
		end
	elseif arg_30_0.puzzleId == Role37PuzzleEnum.PuzzleId.MonkeyBanana then
		if arg_30_0.curPos == 7 then
			if arg_30_0.handleBa >= 3 then
				arg_30_0:Finish(true)

				return
			else
				arg_30_0:setCurErrorIndex(999)
				arg_30_0:_directAddRecord(luaLang("v1a4_role37_puzzle_monkeybanana_not_enough"), true)
			end
		end
	elseif arg_30_0.puzzleId == Role37PuzzleEnum.PuzzleId.SortByRules7 then
		local var_30_10 = {}
		local var_30_11 = 0

		for iter_30_3, iter_30_4 in pairs(arg_30_0.operList) do
			if var_30_10[iter_30_4] then
				arg_30_0:_repelaceRecord(luaLang("v1a4_role37_puzzle_sortbyrules_only"))

				var_30_11 = iter_30_3

				break
			else
				var_30_10[iter_30_4] = 1
				var_30_11 = 0
			end
		end

		if arg_30_0.curErrorIndex ~= var_30_11 then
			arg_30_0:setCurErrorIndex(var_30_11)
			Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.ErrorOperChange, arg_30_0.curErrorIndex)
		end

		if var_30_0 == 7 and arg_30_0.curErrorIndex == 0 then
			local var_30_12 = arg_30_0:getSortError7()

			if string.nilorempty(var_30_12) then
				arg_30_0:Finish(true)

				return
			else
				local var_30_13 = string.format(luaLang("v1a4_role37_puzzle_sortbyrules_error"), var_30_12)

				arg_30_0:_directAddRecord(var_30_13, true)
			end
		end
	elseif arg_30_0.puzzleId == Role37PuzzleEnum.PuzzleId.WolfSheepDish then
		if #arg_30_0.rightBank == 3 then
			if arg_30_0.moveCnt > 5 then
				GameFacade.showToastString(luaLang("v1a4_role37_puzzle_animal_movecnt_notenough"))

				return
			end

			arg_30_0:Finish(true)

			return
		end
	elseif arg_30_0.puzzleId == Role37PuzzleEnum.PuzzleId.Final and var_30_0 == 10 and arg_30_0:matchOperList() then
		arg_30_0:Finish(true)

		return
	end

	if arg_30_0.puzzleCfg.puzzleType == Role37PuzzleEnum.PuzzleType.Logic and arg_30_0:isOperateFull() then
		arg_30_0:Finish(false)

		return
	end
end

function var_0_0.matchOperList(arg_31_0)
	local var_31_0 = true

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.matchList) do
		if arg_31_0.operList[iter_31_0] ~= iter_31_1 then
			var_31_0 = false

			break
		end
	end

	return var_31_0
end

function var_0_0.Finish(arg_32_0, arg_32_1)
	arg_32_0.isSucess = arg_32_1

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.PuzzleResult, arg_32_1)
end

function var_0_0.isOperateFull(arg_33_0)
	return tabletool.len(arg_33_0.operList) >= arg_33_0.maxStep
end

function var_0_0.getResult(arg_34_0)
	return arg_34_0.isSucess
end

function var_0_0.getPuzzleCfg(arg_35_0)
	return arg_35_0.puzzleCfg
end

function var_0_0.getOperGroupCfg(arg_36_0)
	return arg_36_0.operGroupCfg
end

function var_0_0.getOperGroupList(arg_37_0)
	return arg_37_0.operGroupList
end

function var_0_0.getShapeImage(arg_38_0, arg_38_1)
	return arg_38_0.operGroupCfg[arg_38_1].shapeImg
end

function var_0_0.getMaxOper(arg_39_0)
	return arg_39_0.maxOper
end

function var_0_0.setCurErrorIndex(arg_40_0, arg_40_1)
	arg_40_0.curErrorIndex = arg_40_1

	if arg_40_1 ~= 0 then
		arg_40_0.errorCnt = arg_40_0.errorCnt + 1
	end
end

function var_0_0.getCurErrorIndex(arg_41_0)
	return arg_41_0.curErrorIndex
end

function var_0_0.setErrorCnt(arg_42_0, arg_42_1)
	arg_42_0.errorCnt = arg_42_1
end

function var_0_0.getErrorCnt(arg_43_0)
	return arg_43_0.errorCnt
end

function var_0_0.getOperAudioId(arg_44_0, arg_44_1)
	return arg_44_0.operGroupCfg[arg_44_1].audioId
end

var_0_0.instance = var_0_0.New()

return var_0_0
