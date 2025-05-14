module("modules.logic.story.view.StoryTool", package.seeall)

function StoryTool.getFilterDia(arg_1_0)
	local var_1_0 = string.gsub(arg_1_0, "：", ":")
	local var_1_1 = string.gsub(var_1_0, "【", "[")

	return (string.gsub(var_1_1, "】", "]"))
end

function StoryTool.getFilterAlignTxt(arg_2_0)
	local var_2_0 = string.gsub(arg_2_0, "<align=\"left\">", "")
	local var_2_1 = string.gsub(var_2_0, "<align=\"center\">", "")

	return (string.gsub(var_2_1, "<align=\"right\">", ""))
end

function StoryTool.getTxtAlignment(arg_3_0)
	local var_3_0 = UnityEngine.TextAnchor.MiddleLeft

	if string.match(arg_3_0, "<align=\"left\">") then
		var_3_0 = UnityEngine.TextAnchor.MiddleLeft
	elseif string.match(arg_3_0, "<align=\"right\">") then
		var_3_0 = UnityEngine.TextAnchor.MiddleRight
	else
		var_3_0 = UnityEngine.TextAnchor.MiddleCenter
	end

	return var_3_0
end

function StoryTool.filterMarkTop(arg_4_0)
	local var_4_0 = ""
	local var_4_1 = string.split(arg_4_0, "</marktop>")

	for iter_4_0 = 1, #var_4_1 do
		local var_4_2 = string.gsub(var_4_1[iter_4_0], "(<marktop=%s>)", "")
		local var_4_3 = string.split(var_4_2, "<marktop=")
		local var_4_4 = string.split(var_4_3[2], ">")
		local var_4_5 = string.gsub(var_4_2, string.format("<marktop=%s>", var_4_4[1]), "")

		var_4_0 = var_4_0 .. var_4_5
	end

	return var_4_0
end

function StoryTool.filterSpTag(arg_5_0)
	local var_5_0 = string.gsub(arg_5_0, "<em>", "")
	local var_5_1 = string.gsub(arg_5_0, "</em>", "")
	local var_5_2 = string.gsub(var_5_1, "<speed=%d[%d.]*>", "")
	local var_5_3 = string.gsub(var_5_2, "<brace>", "{")

	return (string.gsub(var_5_3, "</brace>", "}"))
end

function StoryTool.getMarkTextIndexs(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = string.split(arg_6_0, "<em>")

	if #var_6_1 < 2 then
		return {}
	end

	local var_6_2 = {}
	local var_6_3 = GameUtil.utf8len(var_6_1[1])

	table.insert(var_6_2, var_6_3)

	for iter_6_0 = 2, #var_6_1 do
		local var_6_4 = string.split(var_6_1[iter_6_0], "</em>")
		local var_6_5 = GameUtil.utf8len(var_6_4[1])
		local var_6_6 = GameUtil.utf8len(var_6_4[2])

		table.insert(var_6_2, var_6_5 + var_6_6)

		local var_6_7 = 0

		for iter_6_1 = 1, iter_6_0 - 1 do
			var_6_7 = var_6_7 + var_6_2[iter_6_1]
		end

		for iter_6_2 = 1, var_6_5 do
			table.insert(var_6_0, var_6_7 + iter_6_2 - 1)
		end
	end

	return var_6_0
end

function StoryTool.getMarkTopTextList(arg_7_0)
	if arg_7_0 and arg_7_0 ~= "" then
		for iter_7_0, iter_7_1 in string.gmatch(arg_7_0, "<marktop=(%S+)>(%S+)</marktop>") do
			return iter_7_0, iter_7_1
		end
	end

	return "", ""
end

function StoryTool.enablePostProcess(arg_8_0)
	if not StoryController.instance._showBlur then
		PostProcessingMgr.instance:setUIPPValue("localMaskActive", arg_8_0)
	end

	if StoryController.instance._showBlur then
		return
	end

	if arg_8_0 then
		TaskDispatcher.runDelay(function()
			PostProcessingMgr.instance:setUIPPValue("bloomActive", true)
		end, nil, 0.1)
	else
		PostProcessingMgr.instance:setUIPPValue("bloomActive", false)
	end

	if StoryController.instance._showBlur then
		return
	end

	StoryModel.instance:setUIActive(arg_8_0)
end

return StoryTool
