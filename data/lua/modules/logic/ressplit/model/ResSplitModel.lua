-- chunkname: @modules/logic/ressplit/model/ResSplitModel.lua

module("modules.logic.ressplit.model.ResSplitModel", package.seeall)

local ResSplitModel = class("ResSplitModel", BaseModel)

function ResSplitModel:init(characterIdDic, chapterIdDic, audioDic, storyIdDic, guideIdDic, videoDic, pathDic, seasonDic, skinIdDic)
	self._excludeDic = {}
	self._includeDic = {}
	self._excludeStoryIdsDic = {}
	self.audioDic = audioDic
	self._includeCharacterIdDic = characterIdDic
	self._includeChapterIdDic = chapterIdDic
	self._includeStoryIdDic = storyIdDic
	self._includeGuideIdDic = guideIdDic
	self._includeSkinDic = skinIdDic or {}
	self._includeSkillDic = {}
	self._includeTimelineDic = {}
	self.includeSeasonDic = seasonDic
	self._innerBGMWenDic = {}

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "effects/prefabs", false)

	for path, v in pairs(videoDic) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Video, path, false)
	end

	for path, v in pairs(pathDic) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Path, path, false)
	end
end

function ResSplitModel:isExcludeCharacter(characterId)
	return self._includeCharacterIdDic[characterId] ~= true
end

function ResSplitModel:addIncludeChapter(chapterId)
	self._includeChapterIdDic[chapterId] = true
end

function ResSplitModel:isExcludeChapter(chapterId)
	return self._includeChapterIdDic[chapterId] ~= true
end

function ResSplitModel:isExcludeSkin(skinId)
	return self._includeSkinDic[skinId] ~= true
end

function ResSplitModel:isExcludeStoryId(storyId)
	return self._includeStoryIdDic[storyId] ~= true
end

function ResSplitModel:addIncludeStory(storyId)
	self._includeStoryIdDic[storyId] = true
end

function ResSplitModel:addIncludeSkin(skinId)
	self._includeSkinDic[skinId] = true
end

function ResSplitModel:addIncludeSkill(skillId)
	self._includeSkillDic[skillId] = true
end

function ResSplitModel:addInnerBGMWenDic(path)
	self._innerBGMWenDic[path] = true
end

function ResSplitModel:getInnerBGMWenDic()
	return self._innerBGMWenDic
end

function ResSplitModel:addIncludeTimeline(timeline)
	self._includeTimelineDic[timeline] = true
end

function ResSplitModel:getIncludeSkill()
	return self._includeSkillDic
end

function ResSplitModel:getIncludeGuide()
	return self._includeGuideIdDic
end

function ResSplitModel:getIncludeTimelineDic()
	return self._includeTimelineDic
end

function ResSplitModel:setExclude(type, path, isExclude)
	if self._excludeDic[type] == nil then
		self._excludeDic[type] = {}
	end

	local dic = self._excludeDic[type]

	if dic[path] ~= false then
		dic[path] = isExclude
	end
end

function ResSplitModel:checkIncludePath(path)
	if path == nil then
		return false, "path is nil"
	end

	if type(path) ~= "string" then
		return true, nil
	end

	if path == "" then
		return false, "path is empty"
	end

	if string.find(path, "//", 1, true) then
		return false, "path has empty segment"
	end

	for segment in string.gmatch(path, "[^/]+") do
		if segment == "nil" or string.sub(segment, 1, 4) == "nil." then
			return false, "path has nil segment"
		end
	end

	return true, nil
end

function ResSplitModel:setInclude(type, path)
	local isLegal, reason = self:checkIncludePath(path)

	if not isLegal then
		local caller = debug.getinfo(2, "Sl")

		logError(string.format("ResSplitModel:setInclude 忽略非法路径 type:%s path:%q reason:%s caller:%s:%d", tostring(type), tostring(path), reason or "", caller and caller.short_src or "?", caller and caller.currentline or 0))

		return false
	end

	if self._includeDic[type] == nil then
		self._includeDic[type] = {}
	end

	local dic = self._includeDic[type]

	dic[path] = true

	return true
end

function ResSplitModel:getExcludeDic(type)
	return self._excludeDic[type]
end

function ResSplitModel:getIncludeDic(type)
	return self._includeDic[type]
end

ResSplitModel.instance = ResSplitModel.New()

return ResSplitModel
