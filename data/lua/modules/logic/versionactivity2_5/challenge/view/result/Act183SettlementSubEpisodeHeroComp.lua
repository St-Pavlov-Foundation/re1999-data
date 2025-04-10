module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementSubEpisodeHeroComp", package.seeall)

slot0 = class("Act183SettlementSubEpisodeHeroComp", LuaCompBase)
slot0.HeroIconPosition = {
	{
		{
			0,
			0,
			1
		}
	},
	{
		{
			-61,
			0,
			1
		},
		{
			61,
			0,
			1
		}
	},
	{
		{
			0,
			38,
			1
		},
		{
			-61,
			-82,
			1
		},
		{
			61,
			-82,
			1
		}
	},
	{
		{
			-61,
			38,
			1
		},
		{
			61,
			38,
			1
		},
		{
			-61,
			-82,
			1
		},
		{
			61,
			-82,
			1
		}
	},
	{
		{
			-3,
			80,
			0.74
		},
		{
			84,
			80,
			0.74
		},
		{
			-87,
			-5,
			0.74
		},
		{
			-87,
			-89,
			0.74
		},
		{
			39,
			-46,
			1.58
		}
	}
}
slot0.TeamLeaderPosition = {
	1,
	2,
	3,
	4,
	5
}
slot1 = {
	[Act183Enum.EpisodeType.Boss] = {
		-52,
		-52
	},
	[Act183Enum.EpisodeType.Sub] = {
		-52,
		-52
	}
}

function slot0.init(slot0, slot1)
	slot0.go = slot1

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._heroIconTab = slot0:getUserDataTb_()
end

function slot0.setHeroTemplate(slot0, slot1)
	slot0._goherotemplate = slot1
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:refreshHeroGroup(slot1)
end

function slot0.refreshHeroGroup(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._episodeType = slot1:getEpisodeType()
	slot0._hasTeamLeader = Act183Helper.isEpisodeHasTeamLeader(slot1:getEpisodeId())
	slot5 = slot0.HeroIconPosition[slot0:_setTeamLeaderPosition(slot1) and #slot3 or 0]

	for slot9, slot10 in ipairs(slot3) do
		slot0:refreshSingleHeroItem(gohelper.clone(slot0._goherotemplate, slot0.go, "hero_" .. slot9), slot10, slot9, slot5 and slot5[slot9])
	end
end

function slot0._setTeamLeaderPosition(slot0, slot1)
	slot3 = {}
	slot5 = slot1:getHeroMos() and #slot2 or 0

	for slot9, slot10 in ipairs(slot2) do
		if slot0._hasTeamLeader and slot10:isTeamLeader() then
			table.insert({}, slot10)
		else
			table.insert(slot3, slot10)
		end
	end

	if not slot0.TeamLeaderPosition[slot5] then
		slot6 = slot5

		logWarn(string.format("未配置队长显示位置(TeamLeaderPosition)!!!默认放队尾  episodeId = %s, heroCount = %s", slot1:getEpisodeId(), slot5))
	end

	for slot10, slot11 in ipairs(slot4) do
		table.insert(slot3, slot6, slot11)
	end

	return slot3
end

function slot0.refreshSingleHeroItem(slot0, slot1, slot2, slot3, slot4)
	gohelper.setActive(slot1, true)

	slot5 = gohelper.findChildSingleImage(slot1, "simage_heroicon")

	slot5:LoadImage(slot2:getHeroIconUrl())

	slot0._heroIconTab[slot5] = true

	slot0:refreshHeroPosition(slot1, slot4)

	slot8 = slot0._hasTeamLeader and slot2:isTeamLeader()

	gohelper.setActive(gohelper.findChild(slot1, "#go_LeaderFrame"), slot8)

	if slot8 then
		slot0:onRefreshTeamLeaderHero(slot1)
	end
end

function slot0.refreshHeroPosition(slot0, slot1, slot2)
	slot5 = slot2 and slot2[3]

	transformhelper.setLocalScale(slot1.transform, slot5 or 1, slot5 or 1, slot5 or 1)
	recthelper.setAnchor(slot1.transform, slot2 and slot2[1] or 0, slot2 and slot2[2] or 0)
end

function slot0.onRefreshTeamLeaderHero(slot0, slot1)
	recthelper.setAnchor(gohelper.findChild(slot1, "#go_LeaderFrame/image_LeaderIcon").transform, uv0[slot0._episodeType] and slot3[1] or 0, slot3 and slot3[2] or 0)
end

function slot0.releaseAllSingleImage(slot0)
	if slot0._heroIconTab then
		for slot4, slot5 in pairs(slot0._heroIconTab) do
			slot4:UnLoadImage()
		end
	end
end

function slot0.onDestroy(slot0)
	slot0:releaseAllSingleImage()
end

return slot0
