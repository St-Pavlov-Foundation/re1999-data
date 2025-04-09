module("modules.logic.versionactivity2_7.act191.define.Activity191Helper", package.seeall)

slot0 = class("Activity191Helper")

function slot0.setFetterIcon(slot0, slot1)
	UISpriteSetMgr.instance:setBuffSprite(slot0, slot1)
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

function slot0.getPlayerPrefs(slot0, slot1)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. Activity191Model.instance:getCurActId() .. slot0, slot1)
end

function slot0.setPlayerPrefs(slot0, slot1)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. Activity191Model.instance:getCurActId() .. slot0, slot1)
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
		return
	end

	for slot6, slot7 in ipairs(slot0) do
		if slot7[slot1] == slot2 then
			return slot7
		end
	end
end

function slot0.getWithBuildBattleHeroInfo(slot0, slot1)
	if not uv0.matchKeyInArray(slot0, "index", slot1) then
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
	if not uv0.matchKeyInArray(slot0, "index", slot1) then
		slot2 = Activity191Module_pb.Act191SubHeroInfo()
		slot2.index = slot1
		slot2.heroId = 0

		table.insert(slot0, slot2)
	end

	return slot2
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
		for slot11 = #Activity191Config.instance:getRelationCoList(slot5), 0, -1 do
			if slot7[slot11].activeNum <= slot6 then
				slot1[#slot1 + 1] = {
					config = slot12,
					count = slot6
				}

				break
			end
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if slot0.config.tagBg == slot1.config.tagBg then
			return slot1.count < slot0.count
		else
			return slot1.config.tagBg < slot0.config.tagBg
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

return slot0
