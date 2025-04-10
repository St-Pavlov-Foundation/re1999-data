module("modules.logic.versionactivity2_7.act191.view.Act191GetView", package.seeall)

slot0 = class("Act191GetView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollGet = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_Get")
	slot0._goHeroRoot = gohelper.findChild(slot0.viewGO, "#scroll_Get/Viewport/Content/#go_HeroRoot")
	slot0._goHero = gohelper.findChild(slot0.viewGO, "#scroll_Get/Viewport/Content/#go_HeroRoot/#go_Hero")
	slot0._goCollectionRoot = gohelper.findChild(slot0.viewGO, "#scroll_Get/Viewport/Content/#go_CollectionRoot")
	slot0._goCollection = gohelper.findChild(slot0.viewGO, "#scroll_Get/Viewport/Content/#go_CollectionRoot/collectionitem/#go_Collection")
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
	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
end

function slot0.onOpen(slot0)
	slot0.triggerParams = slot0.viewParam
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.triggerParams) do
		for slot11, slot12 in ipairs(cjson.decode(slot6)) do
			if slot1[slot12] then
				slot1[slot12] = slot1[slot12] + 1
			else
				slot1[slot12] = 1
			end
		end
	end

	slot2 = {}
	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		if lua_activity191_role.configDict[slot7] then
			slot2[#slot2 + 1] = slot9
		else
			slot3[#slot3 + 1] = Activity191Config.instance:getCollectionCo(slot7)
		end
	end

	for slot7 = 1, #slot2 do
		slot8 = slot2[slot7]
		slot9 = gohelper.cloneInPlace(slot0._goHero)

		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, gohelper.findChild(slot9, "head")), Act191HeroHeadItem, {
			exSkill = true
		}):setData(nil, slot8.id)

		slot13 = gohelper.findChild(slot9, "go_lvlup")
		slot15 = 0

		if slot0.gameInfo:getHeroInfoInWarehouse(slot8.roleId) then
			slot15 = slot14.star ~= slot1[slot8.id] and slot16 or slot16 - 1
		end

		gohelper.setActive(slot13, slot15 ~= 0)

		for slot21 = 1, 5 do
			if slot21 ~= 3 then
				slot22 = gohelper.findChild(slot9, "go_attribute/attribute" .. slot21)

				gohelper.setActive(gohelper.findChild(slot22, "txt_attribute/go_up"), slot15 ~= 0)

				slot26 = Activity191Enum.AttrIdList[slot21]
				gohelper.findChildText(slot22, "txt_attribute").text = string.format("<color=%s>%s</color>", slot15 == 0 and "#C3AA87" or "#E27444", lua_activity191_template.configDict[slot8.id][Activity191Config.AttrIdToFieldName[slot26]])
				gohelper.findChildText(slot22, "name").text = HeroConfig.instance:getHeroAttributeCO(slot26).name
			end
		end

		slot0:addClickCb(gohelper.findChildButtonWithAudio(slot9, "btn_Click"), slot0.onClickHero, slot0, slot8.id)
	end

	for slot7 = 1, #slot3 do
		for slot12 = 1, slot1[slot3[slot7].id] do
			slot13 = gohelper.cloneInPlace(slot0._goCollection)

			UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot13, "image_Rare"), "act174_propitembg_" .. slot8.rare)
			gohelper.findChildSingleImage(slot13, "simage_Icon"):LoadImage(ResUrl.getRougeSingleBgCollection(slot8.icon))
		end
	end

	gohelper.setActive(slot0._goHero, false)
	gohelper.setActive(slot0._goCollection, false)
	gohelper.setActive(slot0._goHeroRoot, #slot2 ~= 0)
	gohelper.setActive(slot0._goCollectionRoot, #slot3 ~= 0)
end

function slot0.onClose(slot0)
	Activity191Model.instance:getActInfo():cleanTriggerParams()
	Activity191Controller.instance:nextStep()
end

function slot0.onClickHero(slot0, slot1)
	Activity191Controller.instance:openHeroTipView({
		heroList = {
			slot1
		}
	})
end

return slot0
