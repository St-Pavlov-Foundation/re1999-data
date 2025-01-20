module("modules.logic.versionactivity2_5.autochess.view.AutoChessRankUpView", package.seeall)

slot0 = class("AutoChessRankUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._goBadgeRoot = gohelper.findChild(slot0.viewGO, "#go_BadgeRoot")
	slot0._goReward = gohelper.findChild(slot0.viewGO, "root/#go_Reward")
	slot0._goRewardItem = gohelper.findChild(slot0.viewGO, "root/#go_Reward/reward/#go_RewardItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = Activity182Model.instance:getActMo()

	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.BadgeItemPath, slot0._goBadgeRoot), AutoChessBadgeItem):setData(slot1.rank, slot1.score, true)

	if lua_auto_chess_rank.configDict[slot1.activityId][slot1.rank] then
		for slot9, slot10 in ipairs(DungeonConfig.instance:getRewardItems(slot4.reward)) do
			slot12 = IconMgr.instance:getCommonItemIcon(gohelper.cloneInPlace(slot0._goRewardItem, slot9))

			gohelper.setAsFirstSibling(slot12.go)
			slot12:setMOValue(slot10[1], slot10[2], slot10[3], nil, true)
			slot12:setCountFontSize(32)
		end

		gohelper.setActive(slot0.goReward, #slot5 ~= 0)
	end

	gohelper.setActive(slot0._goRewardItem, false)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
