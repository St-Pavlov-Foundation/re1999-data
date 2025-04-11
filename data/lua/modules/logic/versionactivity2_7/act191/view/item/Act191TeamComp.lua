module("modules.logic.versionactivity2_7.act191.view.item.Act191TeamComp", package.seeall)

slot0 = class("Act191TeamComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.handleView = slot1
	slot0.handleViewName = slot1.viewName
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goHeroTeam = gohelper.findChild(slot1, "#go_HeroTeam")
	slot0.goCollectionTeam = gohelper.findChild(slot1, "#go_CollectionTeam")
	slot0.imageLevel = gohelper.findChildImage(slot1, "level/#image_Level")
	slot0.goRoleS = gohelper.findChild(slot1, "switch/role/select")
	slot0.goRoleU = gohelper.findChild(slot1, "switch/role/unselect")
	slot0.goCollectionS = gohelper.findChild(slot1, "switch/collection/select")
	slot0.goCollectionU = gohelper.findChild(slot1, "switch/collection/unselect")
	slot0.btnSwitch = gohelper.findChildButtonWithAudio(slot1, "switch/btn_Switch")
	slot0.scrollFetter = gohelper.findChildScrollRect(slot1, "#scroll_Fetter")
	slot0.goFetterContent = gohelper.findChild(slot1, "#scroll_Fetter/Viewport/#go_FetterContent")
	slot0.groupItem1List = {}
	slot0.subGroupItem1List = {}
	slot0.groupItem2List = {}
	slot0.fetterItemList = {}

	for slot5 = 1, 8 do
		slot0.groupItem1List[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.goHeroTeam, "hero" .. slot5), Act191HeroGroupItem1)

		slot0.groupItem1List[slot5]:setIndex(slot5)
		slot0.groupItem1List[slot5]:setExtraParam({
			type = "justHero",
			fromView = slot0.handleViewName
		})

		if slot5 <= 4 then
			slot0.subGroupItem1List[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.goCollectionTeam, "hero" .. slot5), Act191HeroGroupItem1)

			slot0.subGroupItem1List[slot5]:setIndex(slot5)
			slot0.subGroupItem1List[slot5]:setClickEnable(false)
			slot0.subGroupItem1List[slot5]:setExtraParam({
				type = "heroItem",
				fromView = slot0.handleViewName
			})

			slot0.groupItem2List[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.goCollectionTeam, "collection" .. slot5), Act191HeroGroupItem2)

			slot0.groupItem2List[slot5]:setIndex(slot5)
			slot0.groupItem2List[slot5]:setExtraParam({
				type = "heroItem",
				fromView = slot0.handleViewName
			})
		end
	end

	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(Activity191Enum.PrefabPath.FetterItem)
	slot0._loader:startLoad(slot0._loadFinish, slot0)

	slot0._anim = slot1:GetComponent(gohelper.Type_Animator)
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnSwitch, slot0.onClickSwitch, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, slot0.refreshTeam, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateGameInfo, slot0.refreshTeam, slot0)
end

function slot0.onStart(slot0)
	slot0:refreshTeam()
	slot0:refreshStatus()
end

function slot0.onDestroy(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	TaskDispatcher.cancelTask(slot0.refreshStatus, slot0)
end

function slot0._loadFinish(slot0)
	slot0.canFreshFetter = true

	if slot0.needFreshFetter then
		slot0:refreshFetter()

		slot0.needFreshFetter = false
	end
end

function slot0.onClickSwitch(slot0, slot1)
	slot0.editCollection = not slot0.editCollection

	if slot1 then
		slot0:refreshStatus()
	else
		slot0._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(slot0.refreshStatus, slot0, 0.16)
	end

	if not slot1 then
		Act191StatController.instance:statButtonClick(slot0.handleView.viewName, string.format("onClickSwitch_%s", slot0.editCollection and "Collection" or "Hero"))
	end
end

function slot0.refreshStatus(slot0)
	gohelper.setActive(slot0.goRoleS, not slot0.editCollection)
	gohelper.setActive(slot0.goRoleU, slot0.editCollection)
	gohelper.setActive(slot0.goCollectionS, slot0.editCollection)
	gohelper.setActive(slot0.goCollectionU, not slot0.editCollection)
	gohelper.setActive(slot0.goHeroTeam, not slot0.editCollection)
	gohelper.setActive(slot0.goCollectionTeam, slot0.editCollection)
end

function slot0.refreshTeam(slot0)
	slot1 = slot0.gameInfo:getTeamInfo()
	slot6 = "act191_level_" .. string.lower(lua_activity191_rank.configDict[slot0.gameInfo.rank].fightLevel)

	UISpriteSetMgr.instance:setAct174Sprite(slot0.imageLevel, slot6)

	for slot6 = 1, 4 do
		slot8 = Activity191Helper.matchKeyInArray(slot1.battleHeroInfo, slot6) and slot7.heroId

		slot0.groupItem1List[slot6]:setData(slot8)
		slot0.groupItem1List[slot6 + 4]:setData(Activity191Helper.matchKeyInArray(slot1.subHeroInfo, slot6) and slot9.heroId)
		slot0.subGroupItem1List[slot6]:setData(slot8)
		slot0.groupItem2List[slot6]:setData(slot7 and slot7.itemUid1)
	end

	if slot0.canFreshFetter then
		slot0:refreshFetter()
	else
		slot0.needFreshFetter = true
	end
end

function slot0.refreshFetter(slot0)
	for slot6, slot7 in ipairs(Activity191Helper.getActiveFetterInfoList(slot0.gameInfo:getTeamFetterCntDic())) do
		if not slot0.fetterItemList[slot6] then
			slot0.fetterItemList[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._loader:getFirstAssetItem():GetResource(), slot0.goFetterContent), Act191FetterItem)
		end

		slot8:setData(slot7.config, slot7.count)
		gohelper.setActive(slot8.go, true)
	end

	for slot6 = #slot2 + 1, #slot0.fetterItemList do
		gohelper.setActive(slot0.fetterItemList[slot6].go, false)
	end

	gohelper.setActive(slot0._goFetterContent, #slot2 ~= 0)

	slot0.scrollFetter.horizontalNormalizedPosition = 0
	slot0.needFreshFetter = false
end

return slot0
