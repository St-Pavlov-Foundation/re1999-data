module("modules.logic.versionactivity2_7.act191.view.Act191EnemyInfoView", package.seeall)

slot0 = class("Act191EnemyInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._imageLevel = gohelper.findChildImage(slot0.viewGO, "left_container/Title/#image_Level")
	slot0._scrollteam = gohelper.findChildScrollRect(slot0.viewGO, "left_container/#scroll_team")
	slot0._goHeroItem = gohelper.findChild(slot0.viewGO, "left_container/#scroll_team/viewport/content/#go_HeroItem")
	slot0._goMain = gohelper.findChild(slot0.viewGO, "left_container/#scroll_team/viewport/content/#go_Main")
	slot0._goSub = gohelper.findChild(slot0.viewGO, "left_container/#scroll_team/viewport/content/#go_Sub")
	slot0._goFetter = gohelper.findChild(slot0.viewGO, "left_container/#scroll_team/viewport/content/#go_Fetter")
	slot0._goRightContainer = gohelper.findChild(slot0.viewGO, "#go_RightContainer")
	slot0._imageRare = gohelper.findChildImage(slot0.viewGO, "#go_RightContainer/go_SingleHero/character/#image_Rare")
	slot0._simageIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_RightContainer/go_SingleHero/character/#simage_Icon")
	slot0._imageCareer = gohelper.findChildImage(slot0.viewGO, "#go_RightContainer/go_SingleHero/character/#image_Career")
	slot0._imageDmgtype = gohelper.findChildImage(slot0.viewGO, "#go_RightContainer/go_SingleHero/#image_Dmgtype")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "#go_RightContainer/go_SingleHero/name/#txt_Name")
	slot0._goFetterIcon = gohelper.findChild(slot0.viewGO, "#go_RightContainer/go_SingleHero/tag/#go_FetterIcon")
	slot0._goCEmpty1 = gohelper.findChild(slot0.viewGO, "#go_RightContainer/Collection1/#go_CEmpty1")
	slot0._goCollection1 = gohelper.findChild(slot0.viewGO, "#go_RightContainer/Collection1/#go_Collection1")
	slot0._imageCRare1 = gohelper.findChildImage(slot0.viewGO, "#go_RightContainer/Collection1/#go_Collection1/#image_CRare1")
	slot0._simageCIcon1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_RightContainer/Collection1/#go_Collection1/#simage_CIcon1")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

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
	slot0:addClickCb(gohelper.findButtonWithAudio(slot0._goCollection1), slot0.onClickCollection, slot0)

	slot0._fetterItemList = {}
	slot0.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goRightContainer, Act191CharacterInfo)
	slot0._fetterIconItemList = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.nodeDetailMo = slot0.viewParam
	slot0.matchMo = slot0.nodeDetailMo.matchInfo
	slot6 = string.lower(lua_activity191_match_rank.configDict[slot0.matchMo.rank].fightLevel)
	slot5 = "act191_level_" .. slot6

	UISpriteSetMgr.instance:setAct174Sprite(slot0._imageLevel, slot5)

	slot0.heroItemDic = {}

	for slot5, slot6 in pairs(slot0.matchMo.heroMap) do
		if not slot0.selectMain then
			slot0.selectMain = slot5
		end

		slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, gohelper.clone(slot0._goHeroItem, slot0._goMain)), Act191HeroHeadItem)

		slot10:setData(nil, slot0.matchMo:getRoleCo(slot6.heroId).id)
		slot10:setOverrideClick(slot0.onClickHero, slot0, slot5)

		slot0.heroItemDic[slot5] = slot10
	end

	slot0.subHeroItemDic = {}

	for slot5, slot6 in pairs(slot0.matchMo.subHeroMap) do
		slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, gohelper.clone(slot0._goHeroItem, slot0._goSub)), Act191HeroHeadItem)

		slot10:setData(nil, slot0.matchMo:getRoleCo(slot6).id)
		slot10:setOverrideClick(slot0.onClickSubHero, slot0, slot5)

		slot0.subHeroItemDic[slot5] = slot10
	end

	gohelper.setActive(slot0._goHeroItem, false)
	slot0:onClickHero(slot0.selectMain, true)
	slot0:refreshFetter()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshCharacter(slot0, slot1)
	slot2 = slot0.matchMo:getRoleCo(slot1)

	UISpriteSetMgr.instance:setAct174Sprite(slot0._imageRare, "act174_rolebg_" .. slot2.quality)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imageCareer, "lssx_" .. slot2.career)
	slot0._simageIcon:LoadImage(Activity191Helper.getHeadIconSmall(slot2))

	slot0._txtName.text = slot2.name

	slot0.characterItem:setData(slot2)

	for slot8, slot9 in ipairs(string.split(slot2.tag, "#")) do
		if not slot0._fetterIconItemList[slot8] then
			slot0._fetterIconItemList[slot8] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goFetterIcon), Act191FetterIconItem)
		end

		slot10:setData(slot9)
		slot10:setEnemyView()
		gohelper.setActive(slot0._fetterIconItemList[slot8].go, true)
	end

	for slot8 = #slot4 + 1, #slot0._fetterIconItemList do
		gohelper.setActive(slot0._fetterIconItemList[slot8].go, false)
	end

	gohelper.setActive(slot0._goFetterIcon, false)
end

function slot0.refreshFetter(slot0)
	for slot4, slot5 in ipairs(slot0._fetterItemList) do
		gohelper.setActive(slot5.go, false)
	end

	for slot6, slot7 in ipairs(Activity191Helper.getActiveFetterInfoList(slot0.matchMo:getTeamFetterCntDic())) do
		if not slot0._fetterItemList[slot6] then
			slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.FetterItem, slot0._goFetter), Act191FetterItem)

			slot8:setEnemyView()

			slot0._fetterItemList[slot6] = slot8
		end

		slot8:setData(slot7.config, slot7.count)
		gohelper.setActive(slot8.go, true)
	end
end

function slot0.onClickHero(slot0, slot1, slot2)
	if not slot2 and slot0.selectMain == slot1 then
		return
	else
		slot0.selectMain = slot1
		slot0.selectSub = 0
	end

	for slot6, slot7 in pairs(slot0.heroItemDic) do
		slot7:setActivation(slot6 == slot1)
	end

	for slot6, slot7 in pairs(slot0.subHeroItemDic) do
		slot7:setActivation(false)
	end

	slot3 = slot0.matchMo.heroMap[slot1]

	slot0:refreshCharacter(slot3.heroId)

	if slot3.itemUid1 ~= 0 then
		slot4 = slot0.matchMo:getItemCo(slot3.itemUid1)

		slot0._simageCIcon1:LoadImage(ResUrl.getRougeSingleBgCollection(slot4.icon))
		UISpriteSetMgr.instance:setAct174Sprite(slot0._imageCRare1, "act174_propitembg_" .. slot4.rare)
	end

	gohelper.setActive(slot0._goCEmpty1, slot3.itemUid1 == 0)
	gohelper.setActive(slot0._goCollection1, slot3.itemUid1 ~= 0)
end

function slot0.onClickSubHero(slot0, slot1)
	if slot0.selectSub == slot1 then
		return
	else
		slot0.selectSub = slot1
		slot0.selectMain = 0

		for slot5, slot6 in pairs(slot0.heroItemDic) do
			slot6:setActivation(false)
		end

		for slot5, slot6 in pairs(slot0.subHeroItemDic) do
			slot6:setActivation(slot5 == slot1)
		end
	end

	slot0:refreshCharacter(slot0.matchMo.subHeroMap[slot1])
	gohelper.setActive(slot0._goCEmpty1, true)
	gohelper.setActive(slot0._goCollection1, false)
end

function slot0.onClickCollection(slot0)
	if slot0.selectMain and slot0.matchMo.heroMap[slot0.selectMain].itemUid1 ~= 0 then
		Activity191Controller.instance:openCollectionTipView({
			itemId = slot0.matchMo:getItemCo(slot2).id
		})
	end
end

return slot0
