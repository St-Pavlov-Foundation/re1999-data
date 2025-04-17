module("modules.logic.versionactivity2_7.act191.define.Activity191Helper", package.seeall)

slot0 = class("Activity191Helper")

function slot0.setFetterIcon(slot0, slot1)
	UISpriteSetMgr.instance:setAct174Sprite(slot0, slot1)
end

function slot0.getHeadIconSmall(slot0)
	if slot0.type == Activity191Enum.CharacterType.Hero then
		return ResUrl.getHeadIconSmall(slot0.skinId)
	else
		return ResUrl.monsterHeadIcon(slot0.skinId)
	end
end

function slot0.getNodeIcon(slot0)
	if tonumber(slot0) == 0 then
		return "act191_progress_largeicon_0"
	elseif uv0.isPveBattle(slot0) then
		return "act191_progress_largeicon_2"
	elseif uv0.isPvpBattle(slot0) then
		return "act191_progress_largeicon_3"
	elseif slot0 == Activity191Enum.NodeType.RewardEvent or slot0 == Activity191Enum.NodeType.BattleEvent then
		return "act191_progress_largeicon_4"
	elseif slot0 == Activity191Enum.NodeType.MixStore then
		return "act191_progress_largeicon_5"
	elseif slot0 == Activity191Enum.NodeType.RoleShop or slot0 == Activity191Enum.NodeType.CollectionShop or tabletool.indexOf(Activity191Enum.TagShopField, slot0) then
		return "act191_progress_largeicon_6"
	elseif slot0 == Activity191Enum.NodeType.Enhance then
		return "act191_progress_largeicon_7"
	end
end

function slot0.lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(slot0)
	else
		UIBlockMgr.instance:endBlock(slot0)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function slot0.getPlayerPrefs(slot0, slot1, slot2)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. slot0 .. slot1, slot2)
end

function slot0.setPlayerPrefs(slot0, slot1, slot2)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. slot0 .. slot1, slot2)
end

function slot0.calcIndex(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if gohelper.isMouseOverGo(slot6, slot0) then
			return slot5
		end
	end
end

function slot0.matchKeyInArray(slot0, slot1, slot2)
	if not slot0 then
		logError("array is nil")

		return
	end

	for slot6, slot7 in ipairs(slot0) do
		if slot7[slot2 or "index"] == slot1 then
			return slot7
		end
	end
end

function slot0.isPveBattle(slot0)
	if tabletool.indexOf(Activity191Enum.PveFiled, slot0) then
		return true
	end
end

function slot0.isPvpBattle(slot0)
	if tabletool.indexOf(Activity191Enum.PvpFiled, slot0) then
		return true
	end
end

function slot0.isShopNode(slot0)
	if slot0 == Activity191Enum.NodeType.MixStore or slot0 == Activity191Enum.NodeType.RoleShop or slot0 == Activity191Enum.NodeType.CollectionShop or tabletool.indexOf(Activity191Enum.TagShopField, slot0) then
		return true
	end
end

function slot0.getActiveFetterInfoList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		if Activity191Config.instance:getRelationCoList(slot5) then
			for slot11 = #slot7, 0, -1 do
				if slot7[slot11].activeNum <= slot6 then
					slot1[#slot1 + 1] = {
						config = slot12,
						count = slot6
					}

					break
				end
			end
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if slot0.config.level == slot1.config.level then
			if slot0.count == slot1.count then
				return slot0.config.id < slot1.config.id
			else
				return slot1.count < slot0.count
			end
		else
			return slot1.config.level < slot0.config.level
		end
	end)

	return slot1
end

function slot0.sortRoleCo(slot0, slot1)
	if slot0.type == Activity191Enum.CharacterType.Hero ~= (slot1.type == Activity191Enum.CharacterType.Hero) then
		return slot2
	end

	if slot0.quality ~= slot1.quality then
		return slot0.quality < slot1.quality
	end

	return slot0.roleId < slot1.roleId
end

function slot0.sortFetterHeroList(slot0, slot1)
	if slot0.transfer == slot1.transfer then
		if slot0.config.quality == slot1.config.quality then
			return slot0.config.roleId < slot1.config.roleId
		else
			return slot0.config.quality < slot1.config.quality
		end
	else
		return slot0.transfer < slot1.transfer
	end
end

function slot0.getWithBuildBattleHeroInfo(slot0, slot1)
	if not uv0.matchKeyInArray(slot0, slot1) then
		slot2 = Activity191Module_pb.Act191BattleHeroInfo()
		slot2.index = slot1
		slot2.heroId = 0
		slot2.itemUid1 = 0
		slot2.itemUid2 = 0

		table.insert(slot0, slot2)
	end

	return slot2
end

function slot0.getWithBuildSubHeroInfo(slot0, slot1)
	if not uv0.matchKeyInArray(slot0, slot1) then
		slot2 = Activity191Module_pb.Act191SubHeroInfo()
		slot2.index = slot1
		slot2.heroId = 0

		table.insert(slot0, slot2)
	end

	return slot2
end

function slot0.replaceSkill(slot0, slot1)
	if slot1 and CharacterDestinyConfig.instance:getDestinyFacets(slot0, 4) and not string.nilorempty(slot2.exchangeSkills) then
		slot4 = GameUtil.splitString2(slot3, true)

		for slot8 = 1, #slot1 do
			for slot12, slot13 in ipairs(slot4) do
				if slot1[slot8] == slot13[1] then
					slot1[slot8] = slot13[2]
				end
			end
		end
	end

	return slot1
end

function slot0.buildDesc(slot0, slot1, slot2)
	slot3 = nil

	return uv0.addColor(string.gsub(slot0, slot1, (not slot2 or string.format("【<u><link=%s>%s</link></u>】", slot2, "%1")) and "【<u><link=%1>%1</link></u>】"))
end

function slot0.addColor(slot0)
	slot2 = string.format("<color=%s>%s</color>", "#C66030", "%1")

	return string.gsub(string.gsub(string.gsub(slot0, "【.-】", string.format("<color=%s>%s</color>", "#4e6698", "%1")), "[+-]?%d+%.%d+%%", slot2), "[+-]?%d+%%", slot2)
end

function slot0.clickHyperLinkDestiny(slot0)
	slot1 = string.splitToNumber(slot0, "#")

	ViewMgr.instance:openView(ViewName.Act191CharacterDestinyView, {
		config = Activity191Config.instance:getRoleCoByNativeId(slot1[1], 1),
		stoneId = slot1[2]
	})
end

function slot0.clickHyperLinkItem(slot0, slot1)
	if string.find(slot0, "#") then
		Activity191Controller.instance:openCollectionTipView({
			itemId = string.splitToNumber(slot0, "#")[1]
		})
	else
		SkillHelper.defaultClick(slot0, slot1)
	end
end

function slot0.clickHyperLinkSkill(slot0, slot1)
	if tonumber(slot0) then
		SkillHelper.defaultClick(slot0, slot1)

		return
	end

	ViewMgr.instance:openView(ViewName.Act191BuffTipView, {
		effectId = slot0,
		clickPosition = slot1
	})
end

return slot0
