module("modules.logic.versionactivity2_7.act191.view.item.Act191ShopItem", package.seeall)

slot0 = class("Act191ShopItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.shopView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.anim = slot1:GetComponent(gohelper.Type_Animator)
	slot0.type1 = gohelper.findChild(slot1, "type1")
	slot0.type2 = gohelper.findChild(slot1, "type2")
	slot0.type3 = gohelper.findChild(slot1, "type3")
	slot0.txtCost = gohelper.findChildText(slot1, "cost/txt_Cost")
	slot0.goSoldOut = gohelper.findChild(slot1, "go_SellOut")
	slot0.goMax = gohelper.findChild(slot1, "go_Max")
	slot0.goUp = gohelper.findChild(slot1, "go_Up")
	slot0.goSelect = gohelper.findChild(slot1, "go_Select")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "btn_Click")
	slot0.headItemList = {}

	for slot6 = 1, 4 do
		slot0.headItemList[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.shopView:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, gohelper.findChild(slot6 == 1 and slot0.type1 or slot0.type2, "role" .. (slot6 == 1 and slot6 or slot6 - 1))), Act191HeroHeadItem, {
			noClick = true,
			noFetter = true
		})
	end

	slot0.simageCollection = gohelper.findChildSingleImage(slot1, "type3/collectionicon")
	slot0.goTag1 = gohelper.findChild(slot1, "type3/go_Tag1")
	slot0.txtTag1 = gohelper.findChildText(slot1, "type3/go_Tag1/txt_Tag1")
	slot0.goTag2 = gohelper.findChild(slot1, "type3/go_Tag2")
	slot0.txtTag2 = gohelper.findChildText(slot1, "type3/go_Tag2/txt_Tag2")
	slot0.goFetter = gohelper.findChild(slot1, "fetter/go_Fetter")
	slot0.fetterItemList = {}

	for slot6 = 1, 3 do
		slot0.fetterItemList[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0.goFetter), Act191FetterIconItem)
	end
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
end

function slot0.setIndex(slot0, slot1)
	slot0.index = slot1
end

function slot0.setData(slot0, slot1, slot2)
	slot0.maxMark = false
	slot0.expMark = false

	for slot6 = 1, 3 do
		gohelper.setActive(slot0["type" .. slot6], false)
	end

	slot0.soldOut = slot2
	slot0.cost = slot1.cost
	slot0.heroList = slot1.heroList
	slot0.itemList = slot1.itemList
	slot0.heroCnt = #slot0.heroList
	slot0.itemCnt = #slot0.itemList
	slot0.isHeroShop = slot0.heroCnt > 0

	if slot0.isHeroShop then
		if slot0.heroCnt == 1 then
			slot0.headItemList[1]:setData(nil, slot0.heroList[1])

			if not slot0.soldOut and Activity191Model.instance:getActInfo():getGameInfo():getHeroInfoInWarehouse(slot0.headItemList[1].config.roleId, true) then
				slot0.maxMark = slot6.star == Activity191Enum.CharacterMaxStar
				slot0.expMark = slot6.star ~= Activity191Enum.CharacterMaxStar
			end

			slot0:refreshFetter(slot0.headItemList[1].config)
			gohelper.setActive(slot0.type1, true)
		else
			slot0.headItemList[2]:setData(nil, slot0.heroList[1])
			slot0.headItemList[3]:setData(nil, slot0.heroList[2])
			slot0.headItemList[4]:setData(nil, slot0.heroList[3])
			slot0:refreshFetter(slot0.headItemList[2].config)
			gohelper.setActive(slot0.type2, true)
		end
	elseif Activity191Config.instance:getCollectionCo(slot0.itemList[1]) then
		slot0.simageCollection:LoadImage(ResUrl.getRougeSingleBgCollection(slot4.icon))
		gohelper.setActive(slot0.type3, true)

		if string.nilorempty(slot4.label) then
			gohelper.setActive(slot0.goTag1, false)
			gohelper.setActive(slot0.goTag2, false)
		else
			for slot9 = 1, 2 do
				slot10 = string.split(slot4.label, "#")[slot9]
				slot0["txtTag" .. slot9].text = slot10

				gohelper.setActive(slot0["goTag" .. slot9], slot10)
			end
		end
	end

	if slot3.coin < slot0.cost then
		SLFramework.UGUI.GuiHelper.SetColor(slot0.txtCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0.txtCost, "#211f1f")
	end

	slot0.txtCost.text = slot0.cost

	gohelper.setActive(slot0.goMax, slot0.maxMark)
	gohelper.setActive(slot0.goUp, slot0.expMark)
	gohelper.setActive(slot0.goSoldOut, slot0.soldOut)
	gohelper.setActive(slot0.go, true)
end

function slot0.refreshFetter(slot0, slot1)
	slot2 = string.split(slot1.tag, "#")

	for slot6 = 1, 3 do
		if slot2[slot6] then
			slot0.fetterItemList[slot6]:setData(slot2[slot6])
		end

		gohelper.setActive(slot0.fetterItemList[slot6].go, slot6 <= #slot2)
	end
end

function slot0.onClick(slot0)
	if slot0.soldOut then
		return
	end

	if slot0.isHeroShop then
		Activity191Controller.instance:openHeroTipView({
			showBuy = true,
			index = slot0.index,
			cost = slot0.cost,
			toastId = slot0.expMark and ToastEnum.Act191LevelUp or ToastEnum.Act191BuyTip,
			heroList = slot0.heroList
		})
	else
		slot1.itemId = slot0.itemList[1]

		Activity191Controller.instance:openCollectionTipView(slot1)
	end
end

function slot0.playFreshAnim(slot0)
	slot0.anim:Play("fresh", 0, 0)
end

return slot0
