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
	slot0.actInfo = Activity191Model.instance:getActInfo()
	slot0.gameInfo = slot0.actInfo:getGameInfo()
end

function slot0.onOpen(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.actInfo.triggerEffectPushList) do
		if slot7.effectId[1] and not string.nilorempty(slot7.param) and lua_activity191_effect.configDict[slot7.effectId[1]] then
			slot9 = nil

			if slot8.type == Activity191Enum.EffectType.Hero or slot8.type == Activity191Enum.EffectType.HeroByHero or slot8.type == Activity191Enum.EffectType.HeroByTag then
				slot9 = slot1
			elseif slot8.type == Activity191Enum.EffectType.Item or slot8.type == Activity191Enum.EffectType.ItemByItem or slot8.type == Activity191Enum.EffectType.ItemByTag then
				slot9 = slot2
			end

			if slot9 then
				for slot14, slot15 in ipairs(cjson.decode(slot7.param)) do
					if slot9[slot15] then
						slot9[slot15] = slot9[slot15] + 1
					else
						slot9[slot15] = 1
					end
				end
			end
		end
	end

	slot3 = {}
	slot4 = {}

	for slot8, slot9 in pairs(slot1) do
		slot3[#slot3 + 1] = Activity191Config.instance:getRoleCo(slot8)
	end

	for slot8, slot9 in pairs(slot2) do
		slot4[#slot4 + 1] = Activity191Config.instance:getCollectionCo(slot8)
	end

	for slot8 = 1, #slot3 do
		slot9 = slot3[slot8]
		slot10 = gohelper.cloneInPlace(slot0._goHero)

		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, gohelper.findChild(slot10, "head")), Act191HeroHeadItem, {
			exSkill = true
		}):setData(slot9.roleId)

		slot14 = gohelper.findChild(slot10, "go_lvlup")
		slot16 = 0

		if slot0.gameInfo:getHeroInfoInWarehouse(slot9.roleId) then
			slot16 = slot15.star ~= slot1[slot9.id] and slot17 or slot17 - 1
		end

		gohelper.setActive(slot14, slot16 ~= 0)

		for slot22 = 1, 5 do
			if slot22 ~= 3 then
				slot23 = gohelper.findChild(slot10, "go_attribute/attribute" .. slot22)

				gohelper.setActive(gohelper.findChild(slot23, "txt_attribute/go_up"), slot16 ~= 0)

				slot27 = Activity191Enum.AttrIdList[slot22]
				gohelper.findChildText(slot23, "txt_attribute").text = string.format("<color=%s>%s</color>", slot16 == 0 and "#C3AA87" or "#E27444", lua_activity191_template.configDict[slot9.id][Activity191Config.AttrIdToFieldName[slot27]])
				gohelper.findChildText(slot23, "name").text = HeroConfig.instance:getHeroAttributeCO(slot27).name
			end
		end

		slot0:addClickCb(gohelper.findChildButtonWithAudio(slot10, "btn_Click"), slot0.onClickHero, slot0, slot9.id)
	end

	for slot8 = 1, #slot4 do
		for slot13 = 1, slot2[slot4[slot8].id] do
			slot14 = gohelper.cloneInPlace(slot0._goCollection)

			UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot14, "image_Rare"), "act174_propitembg_" .. slot9.rare)
			gohelper.findChildSingleImage(slot14, "simage_Icon"):LoadImage(ResUrl.getRougeSingleBgCollection(slot9.icon))
		end
	end

	gohelper.setActive(slot0._goHero, false)
	gohelper.setActive(slot0._goCollection, false)
	gohelper.setActive(slot0._goHeroRoot, #slot3 ~= 0)
	gohelper.setActive(slot0._goCollectionRoot, #slot4 ~= 0)
end

function slot0.onClose(slot0)
	slot0.actInfo:clearTriggerEffectPush()
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
