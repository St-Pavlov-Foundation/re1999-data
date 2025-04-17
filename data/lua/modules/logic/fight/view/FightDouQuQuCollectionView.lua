module("modules.logic.fight.view.FightDouQuQuCollectionView", package.seeall)

slot0 = class("FightDouQuQuCollectionView", FightBaseView)

function slot0.onInitView(slot0)
	slot0.collectionObjList = {}
	slot0.simage_iconList = {}
	slot0.img_rareList = {}

	for slot4 = 1, 2 do
		table.insert(slot0.collectionObjList, gohelper.findChild(slot0.viewGO, "root/collection" .. slot4))
		table.insert(slot0.simage_iconList, gohelper.findChildSingleImage(slot0.viewGO, "root/collection" .. slot4 .. "/simage_Icon"))
		table.insert(slot0.img_rareList, gohelper.findChildImage(slot0.viewGO, "root/collection" .. slot4 .. "/image_Rare"))
	end
end

function slot0.addEvents(slot0)
end

function slot0.onConstructor(slot0, slot1)
	slot0.entityMO = slot1
end

function slot0.refreshEntityMO(slot0, slot1)
	slot0.entityMO = slot1

	if slot0.viewGO then
		slot0:refreshCollection()
	end
end

function slot0.onOpen(slot0)
	slot0.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	slot0:refreshCollection()
end

function slot0.refreshCollection(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(slot0.entityMO.side == FightEnum.EntitySide.MySide and slot0.customData.teamAHeroInfo or slot0.customData.teamBHeroInfo) do
		if tonumber(slot6) == slot0.entityMO.modelId then
			for slot12 = 2, #string.splitToNumber(slot7, "#") do
				if tonumber(slot8[slot12]) ~= 0 then
					table.insert(slot2, slot13)
				end
			end

			break
		end
	end

	if #slot2 == 0 then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	for slot6 = 1, #slot0.collectionObjList do
		slot7 = slot0.collectionObjList[slot6]

		if slot2[slot6] then
			gohelper.setActive(slot7, true)

			slot9 = Activity191Config.instance:getCollectionCo(slot8)

			UISpriteSetMgr.instance:setAct174Sprite(slot0.img_rareList[slot6], "act174_propitembg_" .. slot9.rare)
			slot0.simage_iconList[slot6]:LoadImage(ResUrl.getRougeSingleBgCollection(slot9.icon))
			slot0:com_registClick(gohelper.getClickWithDefaultAudio(slot7), slot0.onItemClick, slot8)
		else
			gohelper.setActive(slot7, false)
		end
	end
end

function slot0.onItemClick(slot0, slot1)
	slot2 = false

	for slot6, slot7 in ipairs(slot0.customData.updateCollectionIds) do
		if slot7 == slot1 then
			slot2 = true

			break
		end
	end

	Activity191Controller.instance:openCollectionTipView({
		itemId = slot1,
		enhance = slot2
	})
end

return slot0
