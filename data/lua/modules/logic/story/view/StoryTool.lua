-- chunkname: @modules/logic/story/view/StoryTool.lua

module("modules.logic.story.view.StoryTool", package.seeall)

function StoryTool.getFilterDia(txt)
	local txt = string.gsub(txt, "：", ":")

	txt = string.gsub(txt, "【", "[")
	txt = string.gsub(txt, "】", "]")

	return txt
end

function StoryTool.getFilterAlignTxt(txt)
	local result = string.gsub(txt, "<align=\"left\">", "")

	result = string.gsub(result, "<align=\"center\">", "")
	result = string.gsub(result, "<align=\"right\">", "")

	return result
end

function StoryTool.getTxtAlignment(txt)
	local align = UnityEngine.TextAnchor.MiddleLeft

	if string.match(txt, "<align=\"left\">") then
		align = UnityEngine.TextAnchor.MiddleLeft
	elseif string.match(txt, "<align=\"right\">") then
		align = UnityEngine.TextAnchor.MiddleRight
	else
		align = UnityEngine.TextAnchor.MiddleCenter
	end

	return align
end

function StoryTool.filterMarkTop(txt)
	local result = ""
	local tops = string.split(txt, "</marktop>")

	for i = 1, #tops do
		local filterTxt = string.gsub(tops[i], "(<marktop=%s>)", "")
		local marks = string.split(filterTxt, "<marktop=")
		local contents = string.split(marks[2], ">")
		local content = string.gsub(filterTxt, string.format("<marktop=%s>", contents[1]), "")

		result = result .. content
	end

	return result
end

function StoryTool.filterSpTag(txt)
	local result = string.gsub(txt, "<em>", "")

	result = string.gsub(txt, "</em>", "")
	result = string.gsub(result, "<speed=%d[%d.]*>", "")
	result = string.gsub(result, "<brace>", "{")
	result = string.gsub(result, "</brace>", "}")

	return result
end

function StoryTool.getMarkTextIndexs(txt)
	local result = {}
	local diaStrs = string.split(txt, "<em>")

	if #diaStrs < 2 then
		return {}
	end

	local splitLengths = {}
	local length = GameUtil.utf8len(diaStrs[1])

	table.insert(splitLengths, length)

	for i = 2, #diaStrs do
		local splitStr = string.split(diaStrs[i], "</em>")
		local splitLength1 = GameUtil.utf8len(splitStr[1])
		local splitLength2 = GameUtil.utf8len(splitStr[2])

		table.insert(splitLengths, splitLength1 + splitLength2)

		local preLength = 0

		for j = 1, i - 1 do
			preLength = preLength + splitLengths[j]
		end

		for k = 1, splitLength1 do
			table.insert(result, preLength + k - 1)
		end
	end

	return result
end

function StoryTool.getMarkTopTextList(txt)
	if txt and txt ~= "" then
		for top, mark in string.gmatch(txt, "<marktop=(%S+)>(%S+)</marktop>") do
			return top, mark
		end
	end

	return "", ""
end

function StoryTool.enablePostProcess(enable)
	if not StoryController.instance._showBlur then
		PostProcessingMgr.instance:setUIPPValue("localMaskActive", enable)
	end

	if StoryController.instance._showBlur then
		return
	end

	if enable then
		TaskDispatcher.runDelay(function()
			PostProcessingMgr.instance:setUIPPValue("bloomActive", true)
		end, nil, 0.1)
	else
		PostProcessingMgr.instance:setUIPPValue("bloomActive", false)
	end

	if StoryController.instance._showBlur then
		return
	end

	StoryModel.instance:setUIActive(enable)
end

return StoryTool
