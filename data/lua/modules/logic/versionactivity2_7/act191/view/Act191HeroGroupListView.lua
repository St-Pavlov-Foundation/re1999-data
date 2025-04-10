module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupListView", package.seeall)

slot0 = class("Act191HeroGroupListView", BaseView)

function slot0.onInitView(slot0)
	slot0.imageLevel = gohelper.findChildImage(slot0.viewGO, "herogroupcontain/mainTitle/image_Level")
	slot0.heroContainer = gohelper.findChild(slot0.viewGO, "herogroupcontain/heroContainer")
	slot0.scrollFetter = gohelper.findChildScrollRect(slot0.viewGO, "herogroupcontain/scroll_Fetter")
	slot0.goFetterContent = gohelper.findChild(slot0.viewGO, "herogroupcontain/scroll_Fetter/Viewport/go_FetterContent")
	slot0.fetterItemList = {}

	slot0:initHeroInfoItem()
	slot0:initHeroAndEquipItem()

	slot0.animSwitch = gohelper.findChild(slot0.viewGO, "herogroupcontain"):GetComponent(gohelper.Type_Animator)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, slot0.refreshTeam, slot0)

	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	slot0:refreshTeam()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.heroItemList) do
		CommonDragHelper.instance:unregisterDragObj(slot5.go)
	end

	for slot4, slot5 in ipairs(slot0.equipItemList) do
		CommonDragHelper.instance:unregisterDragObj(slot5.go)
	end

	TaskDispatcher.cancelTask(slot0.refreshTeam, slot0)
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

	gohelper.setActive(goHeroInfo, false)
end

function slot0.initHeroAndEquipItem(slot0)
	slot0.heroPosTrList = slot0:getUserDataTb_()
	slot0.equipPosTrList = slot0:getUserDataTb_()
	slot1 = gohelper.findChild(slot0.viewGO, "herogroupcontain/recordPos")

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
		slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot2, "hero" .. slot7), Act191HeroGroupItem1, slot0)

		slot9:setIndex(slot7)

		slot0.heroItemList[slot7] = slot9

		CommonDragHelper.instance:registerDragObj(slot9.go, slot0._onBeginDrag, nil, slot0._onEndDrag, slot0._checkDrag, slot0, slot7)

		if slot7 <= 4 then
			slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot3, "equip" .. slot7), Act191HeroGroupItem2, slot0)

			slot10:setIndex(slot7)

			slot0.equipItemList[slot7] = slot10

			CommonDragHelper.instance:registerDragObj(slot10.go, slot0._onBeginDrag1, nil, slot0._onEndDrag1, slot0._checkDrag1, slot0, slot7)
		end
	end

	gohelper.setActive(slot2, false)
	gohelper.setActive(slot3, false)
end

function slot0.refreshTeam(slot0)
	slot6 = "act191_level_" .. string.lower(lua_activity191_rank.configDict[slot0.gameInfo.rank].fightLevel)

	UISpriteSetMgr.instance:setAct174Sprite(slot0.imageLevel, slot6)

	for slot6 = 1, 8 do
		slot0:_setHeroItemPos(slot0.heroItemList[slot6], slot6)

		if slot6 <= 4 then
			slot0:_setEquipItemPos(slot0.equipItemList[slot6], slot6)
		end
	end

	slot3 = slot0.gameInfo:getTeamInfo()

	for slot7 = 1, 4 do
		slot9, slot10 = nil

		if Activity191Helper.matchKeyInArray(slot3.battleHeroInfo, slot7) then
			slot9 = slot8.heroId
			slot10 = slot8.itemUid1
		end

		slot0.heroItemList[slot7]:setData(slot9)
		slot0.equipItemList[slot7]:setData(slot10)

		slot11 = slot0.heroInfoItemList[slot7]

		if slot9 and slot9 ~= 0 then
			slot11.txtName.text = Activity191Config.instance:getRoleCoByNativeId(slot9, slot0.gameInfo:getHeroInfoInWarehouse(slot9).star).name

			gohelper.setActive(slot11.goIndex, false)
			gohelper.setActive(slot11.txtName, true)
		else
			gohelper.setActive(slot11.goIndex, true)
			gohelper.setActive(slot11.txtName, false)
		end

		slot0.heroItemList[slot7 + 4]:setData(Activity191Helper.matchKeyInArray(slot3.subHeroInfo, slot7) and slot13.heroId or 0)
	end

	slot0:refreshFetter()
end

function slot0._checkDrag(slot0, slot1)
	if not slot0.heroItemList[slot1].heroId or slot2.heroId == 0 then
		return true
	end

	return false
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if slot0._nowDragingIndex then
		return
	end

	slot0._nowDragingIndex = slot1

	gohelper.setAsLastSibling(slot0.heroItemList[slot1].go)
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if slot0._nowDragingIndex ~= slot1 then
		return
	end

	slot0._nowDragingIndex = nil
	slot3 = slot0.heroItemList[slot1]

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not Activity191Helper.calcIndex(slot2.position, slot0.heroPosTrList) or slot4 == slot1 then
		slot0:_setHeroItemPos(slot3, slot1, true, function ()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	slot5 = slot0.heroItemList[slot4]

	gohelper.setAsLastSibling(slot5.go)

	slot0._tweenId = slot0:_setHeroItemPos(slot5, slot1, true)

	slot0:_setHeroItemPos(slot3, slot4, true, function ()
		if uv0._tweenId then
			ZProj.TweenHelper.KillById(uv0._tweenId)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)
		uv0.gameInfo:exchangeHero(uv1, uv2)
	end, slot0)
end

function slot0._setHeroItemPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = recthelper.rectToRelativeAnchorPos(slot0.heroPosTrList[slot2].position, slot0.heroContainer.transform)

	if slot1 and slot1.resetEquipPos then
		slot1:resetEquipPos()
	end

	if slot3 then
		return ZProj.TweenHelper.DOAnchorPos(slot1.go.transform, slot7.x, slot7.y, 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1.go.transform, slot7.x, slot7.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0._checkDrag1(slot0, slot1)
	if not slot0.equipItemList[slot1].itemUid or slot2.itemUid == 0 then
		return true
	end

	return false
end

function slot0._onBeginDrag1(slot0, slot1, slot2)
	if slot0._nowDragingIndex then
		return
	end

	slot0._nowDragingIndex = slot1

	gohelper.setAsLastSibling(slot0.equipItemList[slot1].go)
end

function slot0._onEndDrag1(slot0, slot1, slot2)
	if slot0._nowDragingIndex ~= slot1 then
		return
	end

	slot0._nowDragingIndex = nil
	slot3 = slot0.equipItemList[slot1]

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not Activity191Helper.calcIndex(slot2.position, slot0.equipPosTrList) or slot4 == slot1 then
		slot0:_setEquipItemPos(slot3, slot1, true, function ()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	slot5 = slot0.equipItemList[slot4]

	gohelper.setAsLastSibling(slot5.go)

	slot0._tweenId = slot0:_setEquipItemPos(slot5, slot1, true)

	slot0:_setEquipItemPos(slot3, slot4, true, function ()
		if uv0._tweenId then
			ZProj.TweenHelper.KillById(uv0._tweenId)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)
		uv0.gameInfo:exchangeItem(uv1, uv2)
	end, slot0)
end

function slot0._setEquipItemPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = recthelper.rectToRelativeAnchorPos(slot0.equipPosTrList[slot2].position, slot0.heroContainer.transform)

	if slot1 and slot1.resetEquipPos then
		slot1:resetEquipPos()
	end

	if slot3 then
		return ZProj.TweenHelper.DOAnchorPos(slot1.go.transform, slot7.x, slot7.y, 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1.go.transform, slot7.x, slot7.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0.refreshFetter(slot0)
	for slot4, slot5 in ipairs(slot0.fetterItemList) do
		gohelper.setActive(slot5.go, false)
	end

	for slot6, slot7 in ipairs(Activity191Helper.getActiveFetterInfoList(slot0.gameInfo:getTeamFetterCntDic())) do
		if not slot0.fetterItemList[slot6] then
			slot0.fetterItemList[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.FetterItem, slot0.goFetterContent), Act191FetterItem)
		end

		slot8:setData(slot7.config, slot7.count)
		slot8:setExtraParam({
			fromView = slot0.viewName,
			index = slot6
		})
		gohelper.setActive(slot8.go, true)
	end

	slot0.scrollFetter.horizontalNormalizedPosition = 0
end

return slot0
