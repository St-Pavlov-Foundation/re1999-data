module("modules.logic.survival.controller.work.SurvivalContinueMoveWork", package.seeall)

local var_0_0 = class("SurvivalContinueMoveWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = false
	local var_1_1 = SurvivalMapModel.instance:getSceneMo()

	if var_1_1 and (not arg_1_1 or not arg_1_1.isEnterFight) and SurvivalMapModel.instance.result == SurvivalEnum.MapResult.None and not arg_1_0.context.fastExecute then
		local var_1_2 = var_1_1.player.pos

		if type(arg_1_1.tryTrigger) == "table" then
			local var_1_3 = var_1_1:getUnitByPos(var_1_2, true)
			local var_1_4 = false

			for iter_1_0, iter_1_1 in ipairs(var_1_3) do
				if arg_1_1.tryTrigger[iter_1_1.id] then
					var_1_4 = true

					break
				end
			end

			if not var_1_4 then
				arg_1_1.tryTrigger = nil
			end
		end

		local var_1_5, var_1_6 = SurvivalMapModel.instance:getTargetPos()

		if var_1_5 or arg_1_1.tryTrigger and not var_1_1.panel then
			if arg_1_1.tryTrigger or var_1_5 == var_1_2 then
				SurvivalMapHelper.instance:tryShowEventView(var_1_2)
			else
				local var_1_7

				if var_1_6 then
					for iter_1_2, iter_1_3 in ipairs(var_1_6) do
						if iter_1_3 == var_1_2 then
							var_1_7 = var_1_6[iter_1_2 + 1]

							break
						end
					end
				end

				if not var_1_7 then
					local var_1_8 = SurvivalMapModel.instance:getCurMapCo().walkables
					local var_1_9 = SurvivalAStarFindPath.instance:findPath(var_1_2, var_1_5, var_1_8)

					if var_1_9 then
						var_1_7 = var_1_9[1]
					end
				end

				if var_1_7 then
					local var_1_10 = SurvivalHelper.instance:getDir(var_1_2, var_1_7)

					var_1_0 = true

					SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.PlayerMove, tostring(var_1_10))
				end
			end
		end
	end

	arg_1_0:onDone(true)

	if not var_1_0 then
		local var_1_11 = SurvivalMapHelper.instance:getEntity(0)

		if var_1_11 then
			var_1_11:playStopMoveAudio()
		end
	end
end

return var_0_0
