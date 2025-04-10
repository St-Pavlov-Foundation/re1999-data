module("modules.logic.fight.view.FightDouQuQuFetterView", package.seeall)

slot0 = class("FightDouQuQuFetterView", FightBaseView)

function slot0.onInitView(slot0)
	slot0.content = gohelper.findChild(slot0.viewGO, "root/fetters/Viewport/Content")
	slot0.itemObj = gohelper.findChild(slot0.viewGO, "root/fetters/Viewport/Content/FetterItem")
end

function slot0.addEvents(slot0)
end

function slot0.onConstructor(slot0, slot1)
	slot0.entityMO = slot1
end

function slot0.refreshEntityMO(slot0, slot1)
	slot0.entityMO = slot1

	if slot0.viewGO then
		slot0:refreshFetter()
	end
end

function slot0.onOpen(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(lua_activity191_relation.configDict) do
		slot1[slot7] = slot1[slot6.tag] or {}

		table.insert(slot1[slot7], slot6)
	end

	for slot5, slot6 in pairs(slot1) do
		table.sort(slot6, function (slot0, slot1)
			return slot0.activeNum < slot1.activeNum
		end)
	end

	slot0.configDic = slot1
	slot0.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	slot0:refreshFetter()
end

function slot0.refreshFetter(slot0)
	if (slot0.entityMO.side == FightEnum.EntitySide.MySide and slot0.customData.teamATag2NumMap or slot0.customData.teamBTag2NumMap) and tabletool.len(slot1) > 0 then
		gohelper.setActive(slot0.viewGO, true)

		slot2 = {}

		for slot6, slot7 in pairs(slot1) do
			table.insert(slot2, {
				key = slot6,
				value = slot7
			})
		end

		for slot6, slot7 in ipairs(slot2) do
			for slot11, slot12 in ipairs(slot0.configDic[slot7.key]) do
				if slot12.activeNum <= slot7.value then
					slot7.active = true
				end
			end
		end

		table.sort(slot2, uv0.sortItemListData)
		slot0:com_createObjList(slot0.onItemShow, slot2, slot0.content, slot0.itemObj)
	else
		gohelper.setActive(slot0.viewGO, false)
	end
end

function slot0.sortItemListData(slot0, slot1)
	if slot0.active and not slot1.active then
		return true
	elseif not slot2 and slot3 then
		return false
	else
		return false
	end
end

function slot0.onItemShow(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildImage(slot1, "image_Bg")
	slot5 = gohelper.findChildImage(slot1, "image_Fetter")
	slot6 = gohelper.findChildText(slot1, "txt_FetterCnt")
	slot7 = slot2.key
	slot8 = slot2.value
	slot10 = 0
	slot11 = Activity191Config.instance:getRelationMaxCo(slot7)

	for slot15, slot16 in ipairs(slot0.configDic[slot7]) do
		if slot16.activeNum <= slot8 then
			slot10 = slot16.level
			slot11 = slot16
		end
	end

	slot6.text = string.format("<%s>%s</color><%s>/%s</color>", slot10 == 0 and "#ED7F7F" or "#F0E2CA", slot8, slot10 == 0 and "#838383" or "#F0E2CA", slot9.activeNum)

	UISpriteSetMgr.instance:setAct174Sprite(slot4, "act174_shop_tag_" .. slot11.tagBg)
	Activity191Helper.setFetterIcon(slot5, slot11.icon)
	slot0:com_registClick(gohelper.getClickWithDefaultAudio(slot1), slot0.onClickItem, {
		isFight = true,
		count = slot8,
		tag = slot11.tag
	})
end

function slot0.onClickItem(slot0, slot1)
	Activity191Controller.instance:openFetterTipView(slot1)
end

return slot0
