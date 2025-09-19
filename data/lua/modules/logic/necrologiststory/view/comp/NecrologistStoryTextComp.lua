module("modules.logic.necrologiststory.view.comp.NecrologistStoryTextComp", package.seeall)

local var_0_0 = class("NecrologistStoryTextComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.txtGO = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.textComponent = gohelper.findChildTextMesh(arg_1_1, "")
	arg_1_0.txtHyperLink = NecrologistStoryHelper.addHyperLinkClick(arg_1_0.textComponent)
	arg_1_0.typewriterSpeed = 30
	arg_1_0.typewriterTime = 1 / arg_1_0.typewriterSpeed
end

function var_0_0.setTextNormal(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.metaText = arg_2_1
	arg_2_0.finishCallback = arg_2_2
	arg_2_0.callbackObj = arg_2_3

	arg_2_0:onTextFinish()
end

function var_0_0.setTextWithTypewriter(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0:clearTextTimer()

	arg_3_0.metaText = arg_3_1
	arg_3_0.charList = arg_3_0:getUCharArr(arg_3_1)
	arg_3_0.charIndex = 1
	arg_3_0.charCount = #arg_3_0.charList
	arg_3_0.tagStack = {}
	arg_3_0.tagCount = 0
	arg_3_0.frameCallback = arg_3_2
	arg_3_0.finishCallback = arg_3_3
	arg_3_0.callbackObj = arg_3_4

	arg_3_0:setText(LuaUtil.emptyStr)
	TaskDispatcher.runRepeat(arg_3_0._showTypewriterText, arg_3_0, arg_3_0.typewriterTime)
end

function var_0_0._showTypewriterText(arg_4_0)
	if arg_4_0:isDone() then
		arg_4_0:onTextFinish()

		return
	end

	local var_4_0 = arg_4_0:getTypewriterShowText()

	if var_4_0 then
		arg_4_0.curText = var_4_0
		arg_4_0.textComponent.text = var_4_0

		if arg_4_0.frameCallback then
			arg_4_0.frameCallback(arg_4_0.callbackObj)
		end
	else
		arg_4_0:_showTypewriterText()
	end
end

function var_0_0.setText(arg_5_0, arg_5_1)
	arg_5_0.curText = arg_5_1
	arg_5_0.textComponent.text = arg_5_1
end

function var_0_0.isDone(arg_6_0)
	return arg_6_0.charIndex > arg_6_0.charCount
end

function var_0_0.onTextFinish(arg_7_0)
	arg_7_0:clearTextTimer()

	if not arg_7_0.charCount then
		arg_7_0.charCount = 0
	end

	arg_7_0.charIndex = arg_7_0.charCount + 1

	arg_7_0:setText(arg_7_0.metaText)
	arg_7_0:doFinishCallback()
end

function var_0_0.doFinishCallback(arg_8_0)
	local var_8_0 = arg_8_0.finishCallback
	local var_8_1 = arg_8_0.callbackObj

	if var_8_0 then
		var_8_0(var_8_1)
	end
end

function var_0_0.getTypewriterShowText(arg_9_0)
	if arg_9_0:isDone() then
		return arg_9_0.metaText
	end

	local var_9_0
	local var_9_1 = arg_9_0.charIndex
	local var_9_2 = arg_9_0.charList[var_9_1]
	local var_9_3 = #arg_9_0.tagStack

	if string.sub(var_9_2, 1, 1) == "<" then
		if string.sub(var_9_2, 2, 2) ~= "/" then
			table.insert(arg_9_0.tagStack, var_9_2)
		elseif var_9_3 > 0 then
			table.remove(arg_9_0.tagStack)
		end
	else
		var_9_0 = arg_9_0.curText

		if var_9_3 > 0 then
			if arg_9_0.tagCount == var_9_3 then
				local var_9_4 = ""

				for iter_9_0 = var_9_3, 1, -1 do
					local var_9_5 = arg_9_0.tagStack[iter_9_0]

					var_9_4 = var_9_4 .. string.gsub(var_9_5, "<", "</")
				end

				local var_9_6 = -string.len(var_9_4) - 1

				var_9_0 = string.format("%s%s%s", string.sub(var_9_0, 1, var_9_6), var_9_2, var_9_4)
			else
				for iter_9_1, iter_9_2 in ipairs(arg_9_0.tagStack) do
					var_9_0 = var_9_0 .. iter_9_2
				end

				var_9_0 = var_9_0 .. var_9_2

				for iter_9_3 = var_9_3, 1, -1 do
					local var_9_7 = arg_9_0.tagStack[iter_9_3]

					var_9_0 = var_9_0 .. string.gsub(var_9_7, "<", "</")
				end
			end
		else
			var_9_0 = var_9_0 .. var_9_2
		end

		arg_9_0.tagCount = var_9_3
	end

	arg_9_0.charIndex = arg_9_0.charIndex + 1

	return var_9_0
end

function var_0_0.getUCharArr(arg_10_0, arg_10_1)
	local var_10_0 = {}

	if LuaUtil.isEmptyStr(arg_10_1) then
		return var_10_0
	end

	local var_10_1 = 1
	local var_10_2 = #arg_10_1

	while var_10_1 <= var_10_2 do
		if string.sub(arg_10_1, var_10_1, var_10_1) == "<" then
			local var_10_3 = string.find(arg_10_1, ">", var_10_1)

			if var_10_3 then
				table.insert(var_10_0, string.sub(arg_10_1, var_10_1, var_10_3))

				var_10_1 = var_10_3 + 1
			else
				table.insert(var_10_0, string.sub(arg_10_1, var_10_1, var_10_1))

				var_10_1 = var_10_1 + 1
			end
		else
			local var_10_4 = string.sub(arg_10_1, var_10_1, var_10_1)

			if string.byte(var_10_4) > 127 then
				local var_10_5 = string.byte(var_10_4)
				local var_10_6 = 1

				if var_10_5 >= 194 and var_10_5 <= 223 then
					var_10_6 = 2
				elseif var_10_5 >= 224 and var_10_5 <= 239 then
					var_10_6 = 3
				elseif var_10_5 >= 240 and var_10_5 <= 244 then
					var_10_6 = 4
				end

				var_10_4 = string.sub(arg_10_1, var_10_1, var_10_1 + var_10_6 - 1)
				var_10_1 = var_10_1 + var_10_6
			else
				var_10_1 = var_10_1 + 1
			end

			table.insert(var_10_0, var_10_4)
		end
	end

	return var_10_0
end

function var_0_0.clearTextTimer(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._showTypewriterText, arg_11_0)
end

function var_0_0.getTextStr(arg_12_0)
	return arg_12_0.curText
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:clearTextTimer()
end

return var_0_0
