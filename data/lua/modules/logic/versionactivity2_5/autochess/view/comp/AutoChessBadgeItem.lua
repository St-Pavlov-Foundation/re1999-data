module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessBadgeItem", package.seeall)

slot0 = class("AutoChessBadgeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.btnClick = gohelper.findButtonWithAudio(slot1)
	slot0.goEmpty = gohelper.findChild(slot1, "root/#go_Empty")
	slot0.goUnlock = gohelper.findChild(slot1, "root/#go_Unlock")
	slot0.simageBadgeU = gohelper.findChildSingleImage(slot1, "root/#go_Unlock/#simage_BadgeU")
	slot0.goProgress = gohelper.findChild(slot1, "root/#go_Unlock/#go_Progress")
	slot0.imageProgress = gohelper.findChildImage(slot1, "root/#go_Unlock/#go_Progress/#image_Progress")
	slot0.txtProgress = gohelper.findChildText(slot1, "root/#go_Unlock/#go_Progress/#txt_Progress")
	slot0.goLock = gohelper.findChild(slot1, "root/#go_Lock")
	slot0.simageBadgeL = gohelper.findChildSingleImage(slot1, "root/#go_Lock/#simage_BadgeL")
	slot0.txtUnlock = gohelper.findChildText(slot1, "root/#go_Lock/#txt_Unlock")
	slot0.txtName = gohelper.findChildText(slot1, "root/Name/#txt_Name")
	slot0.goReward = gohelper.findChild(slot1, "#go_Reward")
	slot0.goRewardItem = gohelper.findChild(slot1, "#go_Reward/Content/#go_RewardItem")

	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
end

function slot0.onDestroy(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end

	slot0.simageBadgeL:UnLoadImage()
	slot0.simageBadgeU:UnLoadImage()
end

function slot0.setData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.rankId = slot1
	slot0.actId = Activity182Model.instance:getCurActId()
	slot0.config = lua_auto_chess_rank.configDict[slot0.actId][slot1]
	slot0.curScore = slot2
	slot0.notReward = slot3
	slot0.showProgress = slot4
	slot0.needClick = slot5

	if slot0.config then
		slot0:refreshUI()
	else
		slot0.txtName.text = luaLang("autochess_badgeitem_noget")

		gohelper.setActive(slot0.goUnlock, false)
		gohelper.setActive(slot0.goLock, false)
		gohelper.setActive(slot0.goReward, false)
	end

	gohelper.setActive(slot0.goEmpty, not slot0.config)
end

function slot0.refreshUI(slot0)
	slot0.needScore = lua_auto_chess_rank.configDict[Activity182Model.instance:getCurActId()][slot0.rankId - 1] and slot2.score or 0
	slot0.unlock = slot0.needScore <= slot0.curScore

	if slot0.unlock then
		slot0.simageBadgeU:LoadImage(ResUrl.getAutoChessIcon(slot0.config.icon, "badgeicon"))

		if not slot0.showProgress or slot0.config.score == 0 then
			gohelper.setActive(slot0.goProgress, false)
		else
			slot0.imageProgress.fillAmount = slot0.curScore / slot0.config.score
			slot0.txtProgress.text = string.format("%d/%d", slot0.curScore, slot0.config.score)

			gohelper.setActive(slot0.goProgress, true)
		end
	else
		slot0.simageBadgeL:LoadImage(ResUrl.getAutoChessIcon(slot0.config.icon, "badgeicon"))

		slot0.txtUnlock.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("autochess_badgeitem_unlock"), slot0.curScore, slot0.needScore)
	end

	slot0.txtName.text = slot0.config.name

	if slot0.notReward then
		gohelper.setActive(slot0.goReward, false)
	else
		for slot7, slot8 in ipairs(DungeonConfig.instance:getRewardItems(slot0.config.reward)) do
			slot9 = gohelper.cloneInPlace(slot0.goRewardItem, slot7)

			gohelper.setActive(gohelper.findChild(slot9, "go_receive"), slot0.unlock)

			slot11 = IconMgr.instance:getCommonItemIcon(slot9)

			gohelper.setAsFirstSibling(slot11.go)
			slot11:setMOValue(slot8[1], slot8[2], slot8[3], nil, true)
			slot11:setCountFontSize(32)
			recthelper.setAnchorY(slot11:getCountBg().transform, 50)
		end

		gohelper.setActive(slot0.goReward, #slot3 ~= 0)
	end

	gohelper.setActive(slot0.goRewardItem, false)
	gohelper.setActive(slot0.goUnlock, slot0.unlock)
	gohelper.setActive(slot0.goLock, not slot0.unlock)
end

function slot0.onClick(slot0)
	if slot0.needClick then
		ViewMgr.instance:openView(ViewName.AutoChessBadgeView)
	end
end

function slot0.playProgressAnim(slot0, slot1, slot2)
	slot0.config = lua_auto_chess_rank.configDict[slot0.actId][slot1]
	slot0.curScore = slot2

	slot0:refreshUI()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(Activity182Model.instance:getActMo().score, slot2, 1, slot0.frameCallback, slot0.finishCallback, slot0, nil, EaseType.Linear)
end

function slot0.frameCallback(slot0, slot1)
	slot0.txtProgress.text = string.format("%d/%d", slot1, slot0.config.score)
	slot0.imageProgress.fillAmount = slot1 / slot0.config.score
end

function slot0.finishCallback(slot0)
	slot0.tweenId = nil
end

return slot0
