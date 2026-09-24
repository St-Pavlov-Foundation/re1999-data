-- chunkname: @modules/logic/matchgame/controller/MatchGameHelper.lua

module("modules.logic.matchgame.controller.MatchGameHelper", package.seeall)

local MatchGameHelper = _M

function MatchGameHelper.setCharacterElement(elementId, imageIcon, txtName)
	if imageIcon then
		UISpriteSetMgr.instance:setMatchGameSprite(imageIcon, string.format("icon_career%s", elementId), true)
	end

	if txtName then
		txtName.text = luaLang("p_herogroupcareertip_career" .. elementId)
	end
end

function MatchGameHelper.setCharacterAttr(attrType, imageIcon, txtName)
	local attrCo = lua_activity244_character_attr.configDict[attrType]

	if imageIcon then
		local icon = attrCo and attrCo.icon

		UISpriteSetMgr.instance:setCommonSprite(imageIcon, icon)
	end

	if txtName then
		local name = attrCo and attrCo.name

		txtName.text = name
	end
end

function MatchGameHelper.setItemIcon(itemId, imageIcon, imageRare, iconType)
	local itemCo = lua_activity244_item.configDict[itemId]
	local quality = itemCo and itemCo.quality

	if imageRare then
		UISpriteSetMgr.instance:setCommonSprite(imageRare, "bgequip" .. quality)
	end

	if imageIcon then
		iconType = iconType or MatchGameEnum.ItemIconType.Small

		if iconType == MatchGameEnum.ItemIconType.Small then
			UISpriteSetMgr.instance:setMatchGameSprite(imageIcon, string.format("%s_1", itemCo.icon), true)
		elseif iconType == MatchGameEnum.ItemIconType.Large then
			UISpriteSetMgr.instance:setMatchGameSprite(imageIcon, string.format("%s", itemCo.icon), true)
		end
	end
end

function MatchGameHelper.getEpisodeConditionList(episodeId)
	local episodeCo = lua_activity244_episode.configDict[episodeId]
	local matchLevelId = episodeCo and episodeCo.matchLevelId
	local conditionList = MatchGameConfig.instance:getLevelConditionList(matchLevelId)

	if not conditionList then
		return
	end

	local contentList = {}

	for _, conditionParam in ipairs(conditionList) do
		local handleFunc = MatchGameHelper.conditionProcessFuncMap[tonumber(conditionParam[1])]

		if handleFunc then
			local content = handleFunc(conditionParam)

			table.insert(contentList, content)
		end
	end

	return contentList, conditionList
end

function MatchGameHelper.getConditionContent_MatchElementNum(paramList)
	local elementConfig = MatchGameFightConfig.instance:getElementConfig(paramList[2])

	return GameUtil.getSubPlaceholderLuaLang(luaLang("matchgame_fight_goal_match"), {
		paramList[3],
		elementConfig.name
	})
end

function MatchGameHelper.getConditionContent_KillAll(paramList)
	return luaLang("matchgame_fight_goal_killAll")
end

function MatchGameHelper.getConditionContent_RoundNum(paramList)
	return GameUtil.getSubPlaceholderLuaLang(luaLang("matchgame_fight_goal_roundNum"), {
		paramList[2]
	})
end

MatchGameHelper.conditionProcessFuncMap = {
	[MatchGameFightEnum.FightTargetType.MatchElementNum] = MatchGameHelper.getConditionContent_MatchElementNum,
	[MatchGameFightEnum.FightTargetType.KillAll] = MatchGameHelper.getConditionContent_KillAll,
	[MatchGameFightEnum.FightTargetType.RoundNum] = MatchGameHelper.getConditionContent_RoundNum
}

function MatchGameHelper.isChapterUnlock(chapterId)
	local chapterCo = lua_activity244_chapter.configDict[chapterId]

	if not chapterCo then
		return
	end

	return MatchGameHelper.isConditionUnlock(chapterCo.unlock)
end

function MatchGameHelper.isConditionUnlock(conditionStr)
	local unlockList = GameUtil.splitString2(conditionStr)

	if unlockList then
		for _, unlockParam in ipairs(unlockList) do
			local unlockType = unlockParam[1]
			local checkFunc = MatchGameHelper.unlockParamFuncMap[unlockType]

			if checkFunc then
				local result, toastId, toastParam = checkFunc(unlockParam)

				if not result then
					return result, toastId, toastParam
				end
			else
				logError(string.format("三消缺少对应的解锁条件判断方法 unlockType = %s", unlockType))
			end
		end
	end

	return true
end

function MatchGameHelper._isConditionPass_StarNum(conditionParam)
	local starNum = tonumber(conditionParam[2]) or 0

	return starNum <= MatchGameModel.instance:getCurRewardScore(MatchGameEnum.RewardType.Normal)
end

function MatchGameHelper._isConditionPass_PassEpisode(conditionParam)
	local episodeId = tonumber(conditionParam[2]) or 0
	local status = MatchGameModel.instance:getEpisodeStatus(episodeId)

	return status == MatchGameEnum.EpisodeStatus.Finish
end

MatchGameHelper.unlockParamFuncMap = {
	[MatchGameEnum.UnlockType.StarNum] = MatchGameHelper._isConditionPass_StarNum,
	[MatchGameEnum.UnlockType.PassEpisode] = MatchGameHelper._isConditionPass_PassEpisode
}

return MatchGameHelper
