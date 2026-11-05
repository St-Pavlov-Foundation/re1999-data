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

function StoryTool.getTxtAlignment(txt, type)
	local align = UnityEngine.TextAnchor.MiddleLeft

	if string.match(txt, "<align=\"left\">") then
		align = type == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions.Left or UnityEngine.TextAnchor.MiddleLeft
	elseif string.match(txt, "<align=\"right\">") then
		align = type == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions.Right or UnityEngine.TextAnchor.MiddleRight
	else
		align = type == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions.Center or UnityEngine.TextAnchor.MiddleCenter
	end

	return align
end

function StoryTool.getFilterFullAlignTxt(txt)
	local cleaned = string.gsub(txt, "</?align%s*=?%s*\"?[^\">]*\"?>", "")

	return cleaned
end

function StoryTool.getTxtFullAlignment(txt, type)
	local value = string.match(txt, "<align%s*=%s*\"?([^\">]+)\"?>")
	local align = type == gohelper.Type_TextMesh and StoryEnum.TextAlignmentOptions[value] or StoryEnum.TextAnchor[value]

	if align then
		return type == gohelper.Type_TextMesh and TMPro.TextAlignmentOptions[align] or UnityEngine.TextAnchor[align]
	end

	return nil
end

function StoryTool.filterMarkTop(txt)
	local result = ""
	local tops = string.split(txt, "</marktop>")

	for i = 1, #tops do
		local filterTxt = string.gsub(tops[i], "(<marktop=%s>)", "")
		local marks = string.split(filterTxt, "<marktop=")
		local contents = string.split(marks[2], ">")
		local markTag = string.format("<marktop=%s>", contents[1])
		local content = string.gsub(filterTxt, markTag, "<nobr>")

		result = result .. content

		if string.find(filterTxt, markTag) then
			for j = 1, i do
				result = result .. "​"
			end

			result = result .. "</nobr>"
		end
	end

	return result
end

function StoryTool.filterSpTag(txt)
	local result = txt

	for _, cfg in ipairs(StoryEnum.SEG_TAG_CONFIGS) do
		if cfg.replace ~= nil then
			result = string.gsub(result, cfg.pattern, cfg.replace)
		end
	end

	return result
end

function StoryTool.getMarkTopTextList(txt)
	local list = {}

	if txt and txt ~= "" then
		local tops = string.split(txt, "</marktop>")

		if #tops > 1 then
			for i = 1, #tops - 1 do
				local marks = string.split(tops[i], "<marktop=")
				local contents = string.split(marks[2], ">")
				local o = contents[1] .. "|" .. contents[2]

				for j = 1, i do
					o = o .. "​"
				end

				table.insert(list, o)
			end
		end
	end

	return list
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

StoryTool.spineTbt = {
	{
		heroIcon = "300101",
		path = ResUrl.getRolesCgStory("504301_banshen")
	},
	{
		heroIcon = "507601",
		path = ResUrl.getRolesPrefabStory("507601_zhujue_p")
	},
	{
		heroIcon = "507701",
		path = ResUrl.getRolesPrefabStory("507701_zhujue_p")
	},
	{
		heroIcon = "508701",
		path = ResUrl.getRolesPrefabStory("508701_binghao_p")
	},
	{
		heroIcon = "511201",
		path = ResUrl.getRolesCgStory("511201_heipao", "v1a4_511201_heipao")
	}
}

function StoryTool.FilterStrByPatterns(str, patterns)
	local result = str

	for _, v in pairs(patterns) do
		result = result.gsub(result, v, "")
	end

	return result
end

function StoryTool.applyMaterialScheme(mat, schemeId)
	if not mat then
		return
	end

	local scheme = StoryTool.getMaterialMergedScheme(schemeId)

	if not scheme then
		return
	end

	StoryTool.applyMaterialBySchemeValues(mat, scheme.props)
end

function StoryTool.applyMaterialBySchemeValues(mat, values)
	if not mat then
		return
	end

	if not values then
		return
	end

	for propName, propDef in pairs(values) do
		local t = propDef.type
		local v = propDef.value

		if t == StoryEnum.MaterialPropType.Float then
			mat:SetFloat(propName, v)
		elseif t == StoryEnum.MaterialPropType.Color then
			mat:SetColor(propName, Color(v[1], v[2], v[3], v[4]))
		elseif t == StoryEnum.MaterialPropType.Vector then
			mat:SetVector(propName, Vector4.New(v[1], v[2], v[3], v[4]))
		elseif t == StoryEnum.MaterialPropType.Keyword then
			if v then
				mat:EnableKeyword(propName)
			else
				mat:DisableKeyword(propName)
			end
		end
	end
end

function StoryTool.getMaterialSchemeInitValues(mat, schemeId)
	if not mat then
		return
	end

	local scheme = StoryTool.getMaterialMergedScheme(schemeId)

	if not scheme then
		return
	end

	local result = {}

	for propName, propDef in pairs(scheme.props) do
		local t = propDef.type
		local value

		if t == StoryEnum.MaterialPropType.Float then
			value = mat:GetFloat(propName)
		elseif t == StoryEnum.MaterialPropType.Color then
			local c = mat:GetColor(propName)

			value = {
				c.r,
				c.g,
				c.b,
				c.a
			}
		elseif t == StoryEnum.MaterialPropType.Vector then
			local v = mat:GetVector(propName)

			value = {
				v.x,
				v.y,
				v.z,
				v.w
			}
		elseif t == StoryEnum.MaterialPropType.Keyword then
			value = mat:IsKeywordEnabled(propName)
		end

		result[propName] = {
			type = t,
			value = value
		}
	end

	return result
end

function StoryTool.lerpMaterialSchemeValues(mat, fromProps, toProps, t)
	if not mat or not fromProps or not toProps then
		return
	end

	if t < 0 then
		t = 0
	end

	if t > 1 then
		t = 1
	end

	for propName, toDef in pairs(toProps) do
		local fromDef = fromProps[propName]

		if fromDef then
			local propType = toDef.type
			local fv = fromDef.value
			local tv = toDef.value

			if propType == StoryEnum.MaterialPropType.Float then
				mat:SetFloat(propName, fv + (tv - fv) * t)
			elseif propType == StoryEnum.MaterialPropType.Color then
				mat:SetColor(propName, Color(fv[1] + (tv[1] - fv[1]) * t, fv[2] + (tv[2] - fv[2]) * t, fv[3] + (tv[3] - fv[3]) * t, fv[4] + (tv[4] - fv[4]) * t))
			elseif propType == StoryEnum.MaterialPropType.Vector then
				mat:SetVector(propName, Vector4.New(fv[1] + (tv[1] - fv[1]) * t, fv[2] + (tv[2] - fv[2]) * t, fv[3] + (tv[3] - fv[3]) * t, fv[4] + (tv[4] - fv[4]) * t))
			end
		end
	end
end

function StoryTool.getMaterialMergedScheme(schemeId)
	local scheme = StoryConfig.instance:getMaterialConfig(schemeId)

	return scheme
end

function StoryTool.findPrevVisibleChar(info, startIdx)
	if not info then
		return nil, -1
	end

	local i = startIdx

	if i >= info.characterCount then
		i = info.characterCount - 1
	end

	while i >= 0 do
		local ci = info.characterInfo[i]

		if ci and ci.isVisible then
			return ci, i
		end

		i = i - 1
	end

	return nil, -1
end

function StoryTool.findNextVisibleChar(info, startIdx)
	if not info then
		return nil, -1
	end

	local n = info.characterCount
	local i = startIdx

	if i < 0 then
		i = 0
	end

	while i < n do
		local ci = info.characterInfo[i]

		if ci and ci.isVisible then
			return ci, i
		end

		i = i + 1
	end

	return nil, -1
end

function StoryTool._findNextTag(text, startPos)
	if not text or startPos > #text then
		return nil
	end

	local bestStart, bestEnd, bestValue, bestConfig

	for _, cfg in ipairs(StoryEnum.SEG_TAG_CONFIGS) do
		if cfg.key then
			local s, e = string.find(text, cfg.pattern, startPos)

			if s and (bestStart == nil or s < bestStart) then
				bestStart = s
				bestEnd = e
				bestConfig = cfg

				if cfg.tagType == 0 then
					local captures = {
						string.match(text, cfg.pattern, startPos)
					}

					bestValue = #captures > 0 and captures[1] or nil
				end
			end
		end
	end

	if bestStart then
		return {
			startPos = bestStart,
			endPos = bestEnd,
			value = bestValue,
			config = bestConfig
		}
	end

	return nil
end

function StoryTool.parseTagSegments(rawText)
	local segments = {}
	local clueRegions = {}

	if not rawText or #rawText == 0 then
		return segments, clueRegions
	end

	local current = {}
	local valueStacks = {}

	for k, v in pairs(StoryEnum.SEG_TAG_DEFAULTS) do
		current[k] = v
		valueStacks[k] = {}
	end

	local pos = 1
	local charCursor = 0
	local segParts = {}
	local clueStack = {}

	local function flushText(text)
		if text and #text > 0 then
			table.insert(segParts, {
				text = text,
				speed = current.speed
			})

			charCursor = charCursor + GameUtil.utf8len(text)
		end
	end

	local function flushSegment()
		if #segParts > 0 then
			local speedRegions = {}
			local fullText = ""

			for _, part in ipairs(segParts) do
				if #speedRegions > 0 and speedRegions[#speedRegions].speed == part.speed then
					speedRegions[#speedRegions].text = speedRegions[#speedRegions].text .. part.text
				else
					table.insert(speedRegions, {
						speed = part.speed,
						text = part.text
					})
				end

				fullText = fullText .. part.text
			end

			table.insert(segments, {
				text = fullText,
				wait = current.wait,
				speedRegions = speedRegions
			})

			segParts = {}
		end
	end

	while pos <= #rawText do
		local hit = StoryTool._findNextTag(rawText, pos)

		if not hit then
			flushText(string.sub(rawText, pos))
			flushSegment()

			break
		end

		local cfg = hit.config

		if pos < hit.startPos then
			flushText(string.sub(rawText, pos, hit.startPos - 1))

			pos = hit.startPos
		end

		if cfg.key == "wait" then
			flushSegment()

			if cfg.tagType == 0 then
				table.insert(valueStacks.wait, current.wait)

				current.wait = tonumber(hit.value) or StoryEnum.SEG_TAG_DEFAULTS.wait
			elseif cfg.tagType == 1 then
				if #valueStacks.wait > 0 then
					current.wait = table.remove(valueStacks.wait)
				else
					current.wait = StoryEnum.SEG_TAG_DEFAULTS.wait
				end
			end
		elseif cfg.key == "clue" then
			if cfg.tagType == 0 then
				local attrs = StoryTool.parseClueValue(hit.value)

				attrs.startChar = charCursor

				table.insert(clueStack, attrs)
			elseif cfg.tagType == 1 and #clueStack > 0 then
				local c = table.remove(clueStack)

				if charCursor - 1 >= c.startChar then
					c.endChar = charCursor - 1

					table.insert(clueRegions, c)
				end
			end
		elseif cfg.tagType == 0 then
			table.insert(valueStacks[cfg.key], current[cfg.key])

			local defaultVal = StoryEnum.SEG_TAG_DEFAULTS[cfg.key]

			current[cfg.key] = type(defaultVal) == "number" and (tonumber(hit.value) or defaultVal) or hit.value
		elseif cfg.tagType == 1 then
			if #valueStacks[cfg.key] > 0 then
				current[cfg.key] = table.remove(valueStacks[cfg.key])
			else
				current[cfg.key] = StoryEnum.SEG_TAG_DEFAULTS[cfg.key]
			end
		end

		pos = hit.endPos + 1
	end

	while #clueStack > 0 do
		local c = table.remove(clueStack)

		if charCursor - 1 >= c.startChar then
			c.endChar = charCursor - 1

			table.insert(clueRegions, c)
		end
	end

	flushSegment()

	return segments, clueRegions
end

function StoryTool.parseClueValue(value)
	local attrs = {
		speed = 1
	}

	if not value then
		return attrs
	end

	local first = string.match(value, "^%s*([%d%.]+)")

	if first then
		attrs.speed = tonumber(first) or 1
	end

	for k, v in string.gmatch(value, "([%w_]+)%s*=%s*([%w#%.%-]+)") do
		if k == "color" then
			attrs[k] = v
		else
			attrs[k] = tonumber(v) or 0
		end
	end

	return attrs
end

function StoryTool.stripSegmentTags(txt)
	local result = txt

	for _, cfg in ipairs(StoryEnum.SEG_TAG_CONFIGS) do
		if cfg.key then
			result = string.gsub(result, cfg.pattern, "")
		end
	end

	return result
end

return StoryTool
