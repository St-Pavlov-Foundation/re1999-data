module("modules.logic.versionactivity2_7.act191.view.Act191SettlementView", package.seeall)

slot0 = class("Act191SettlementView", BaseView)

function slot0.onInitView(slot0)
	slot0._imageLevel = gohelper.findChildImage(slot0.viewGO, "Left/herogroupcontain/mainTitle/#image_Level")
	slot0._scrollFetter = gohelper.findChildScrollRect(slot0.viewGO, "Left/herogroupcontain/#scroll_Fetter")
	slot0._goFetterContent = gohelper.findChild(slot0.viewGO, "Left/herogroupcontain/#scroll_Fetter/Viewport/#go_FetterContent")
	slot0._goNodeList = gohelper.findChild(slot0.viewGO, "Right/node/#go_NodeList")
	slot0._goBadgeItem = gohelper.findChild(slot0.viewGO, "Right/badge/layout/#go_BadgeItem")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "Right/score/#txt_Score")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.heroContainer = gohelper.findChild(slot0.viewGO, "Left/herogroupcontain/heroContainer")

	slot0:initHeroInfoItem()
	slot0:initHeroAndEquipItem()

	slot0.animEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	slot0.animEvent:AddEventListener("PlayBadgeAnim", slot0.playBadgeAnim, slot0)

	slot0.actInfo = Activity191Model.instance:getActInfo()

	slot0:initBadge()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)

	slot0.gameInfo = slot0.actInfo:getGameInfo()
	slot0.gameEndInfo = slot0.actInfo:getGameEndInfo()

	slot0:refreshLeft()
	slot0:refreshRight()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_fight_end)
end

function slot0.onClose(slot0)
	slot0.actInfo:clearEndInfo()
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
end

function slot0.onDestroyView(slot0)
	slot0.animEvent:RemoveEventListener("PlayBadgeAnim")
end

function slot0.initHeroInfoItem(slot0)
	slot0.heroInfoItemList = {}

	for slot4 = 1, 4 do
		slot5 = slot0:getUserDataTb_()
		slot6 = gohelper.findChild(slot0.heroContainer, "bg" .. slot4)
		slot5.goIndex = gohelper.findChild(slot6, "Index")
		slot5.txtName = gohelper.findChildText(slot6, "Name")
		slot0.heroInfoItemList[slot4] = slot5
	end
end

function slot0.initHeroAndEquipItem(slot0)
	slot0.heroPosTrList = slot0:getUserDataTb_()
	slot0.equipPosTrList = slot0:getUserDataTb_()
	slot1 = gohelper.findChild(slot0.viewGO, "Left/herogroupcontain/recordPos")

	for slot5 = 1, 8 do
		slot0.heroPosTrList[slot5] = gohelper.findChild(slot1, "heroPos" .. slot5).transform

		if slot5 <= 4 then
			slot0.equipPosTrList[slot5] = gohelper.findChild(slot1, "equipPos" .. slot5).transform
		end
	end

	slot2 = gohelper.findChild(slot0.heroContainer, "go_HeroItem")
	slot3 = gohelper.findChild(slot0.heroContainer, "go_EquipItem")
	slot0.heroItemList = {}
	slot0.equipItemList = {}

	for slot7 = 1, 8 do
		slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot2, "hero" .. slot7), Act191HeroGroupItem1)

		slot9:setIndex(slot7)

		slot0.heroItemList[slot7] = slot9

		slot0:_setHeroItemPos(slot9, slot7)

		if slot7 <= 4 then
			slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot3, "equip" .. slot7), Act191HeroGroupItem2, slot0)

			slot10:setIndex(slot7)
			slot10:setOverrideClick(slot0.clickCollection, slot0)

			slot0.equipItemList[slot7] = slot10

			slot0:_setEquipItemPos(slot10, slot7)
		end
	end

	gohelper.setActive(slot2, false)
	gohelper.setActive(slot3, false)
end

function slot0.refreshLeft(slot0)
	UISpriteSetMgr.instance:setAct174Sprite(slot0._imageLevel, "act191_level_" .. string.lower(lua_activity191_rank.configDict[Activity191Model.instance:getActInfo():getGameInfo().rank ~= 0 and slot1.rank or 1].fightLevel or ""))

	slot4 = slot1:getTeamInfo()

	for slot8 = 1, 4 do
		slot10, slot11 = nil

		if Activity191Helper.matchKeyInArray(slot4.battleHeroInfo, slot8) then
			slot10 = slot9.heroId
			slot11 = slot9.itemUid1
		end

		slot0.heroItemList[slot8]:setData(slot10)
		slot0.equipItemList[slot8]:setData(slot11)

		slot12 = slot0.heroInfoItemList[slot8]

		if slot10 and slot10 ~= 0 then
			slot12.txtName.text = Activity191Config.instance:getRoleCoByNativeId(slot10, slot1:getHeroInfoInWarehouse(slot10).star).name

			gohelper.setActive(slot12.goIndex, false)
			gohelper.setActive(slot12.txtName, true)
		else
			gohelper.setActive(slot12.goIndex, true)
			gohelper.setActive(slot12.txtName, false)
		end

		slot0.heroItemList[slot8 + 4]:setData(Activity191Helper.matchKeyInArray(slot4.subHeroInfo, slot8) and slot14.heroId or 0)
	end

	for slot10, slot11 in ipairs(Activity191Helper.getActiveFetterInfoList(slot1:getTeamFetterCntDic())) do
		slot13 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.FetterItem, slot0._goFetterContent), Act191FetterItem)

		slot13:setData(slot11.config, slot11.count)
		gohelper.setActive(slot13.go, true)
	end

	slot0._scrollFetter.horizontalNormalizedPosition = 0
end

function slot0._setHeroItemPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = recthelper.rectToRelativeAnchorPos(slot0.heroPosTrList[slot2].position, slot0.heroContainer.transform)

	if slot3 then
		return ZProj.TweenHelper.DOAnchorPos(slot1.go.transform, slot7.x, slot7.y, 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1.go.transform, slot7.x, slot7.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0._setEquipItemPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = recthelper.rectToRelativeAnchorPos(slot0.equipPosTrList[slot2].position, slot0.heroContainer.transform)

	if slot3 then
		return ZProj.TweenHelper.DOAnchorPos(slot1.go.transform, slot7.x, slot7.y, 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1.go.transform, slot7.x, slot7.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0.refreshRight(slot0)
	if slot0.gameInfo.curStage ~= 0 then
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.NodeListItem, slot0._goNodeList), Act191NodeListItem):setClickEnable(false)
	end

	slot0._txtScore.text = slot0.gameEndInfo.gainScore
end

function slot0.initBadge(slot0)
	slot0.badgeItemList = {}

	for slot6, slot7 in ipairs(slot0.actInfo:getBadgeMoList()) do
		slot9 = gohelper.cloneInPlace(slot0._goBadgeItem)
		slot0:getUserDataTb_().Icon = gohelper.findChildSingleImage(slot9, "root/image_icon")
		slot11 = gohelper.findChildText(slot9, "root/txt_score")
		gohelper.findChildText(slot9, "root/txt_num").text = slot7.count

		if slot0.actInfo:getBadgeScoreChangeDic()[slot7.id] and slot12 ~= 0 then
			slot11.text = "+" .. slot12
		end

		gohelper.setActive(slot11, slot12 ~= 0)
		slot8.Icon:LoadImage(ResUrl.getAct174BadgeIcon(slot7.config.icon, slot7:getState()))

		slot8.anim = slot9:GetComponent(gohelper.Type_Animator)
		slot8.id = slot7.id
		slot0.badgeItemList[#slot0.badgeItemList] = slot8
	end

	gohelper.setActive(slot0._goBadgeItem, false)
end

function slot0.playBadgeAnim(slot0)
	for slot5, slot6 in ipairs(slot0.badgeItemList) do
		if slot0.actInfo:getBadgeScoreChangeDic()[slot6.id] and slot7 ~= 0 then
			slot6.anim:Play("refresh")
		end
	end
end

function slot0.clickCollection(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		Activity191Controller.instance:openCollectionTipView({
			itemId = slot1
		})
	end
end

return slot0
