module("modules.logic.versionactivity2_7.act191.view.item.Act191ShopItem", package.seeall)

slot0 = class("Act191ShopItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.shopView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.anim = slot1:GetComponent(gohelper.Type_Animator)
	slot0.txtCost = gohelper.findChildText(slot1, "cost/txt_Cost")
	slot0.goSoldOut = gohelper.findChild(slot1, "go_SellOut")
	slot0.goMax = gohelper.findChild(slot1, "go_Max")
	slot0.goUp = gohelper.findChild(slot1, "go_Up")
	slot0.goSelect = gohelper.findChild(slot1, "go_Select")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "btn_Click")
	slot0.headItemList = {}

	for slot5 = 1, 3 do
		slot0["type" .. slot5] = gohelper.findChild(slot1, "type" .. slot5)

		for slot10 = 1, slot5 do
			slot0.headItemList[#slot0.headItemList + 1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.shopView:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, gohelper.findChild(slot6, "role" .. slot10)), Act191HeroHeadItem)
		end
	end

	slot0.type7 = gohelper.findChild(slot1, "type7")
	slot0.simageCollection = gohelper.findChildSingleImage(slot1, "type7/collectionicon")
	slot0.goTag1 = gohelper.findChild(slot1, "type7/go_Tag1")
	slot0.txtTag1 = gohelper.findChildText(slot1, "type7/go_Tag1/txt_Tag1")
	slot0.goTag2 = gohelper.findChild(slot1, "type7/go_Tag2")
	slot0.txtTag2 = gohelper.findChildText(slot1, "type7/go_Tag2/txt_Tag2")
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.setIndex(slot0, slot1)
	slot0.index = slot1
end

function slot0.setData(slot0, slot1, slot2)
	slot3 = false
	slot4 = false

	for slot8 = 1, 3 do
		gohelper.setActive(slot0["type" .. slot8], false)
	end

	gohelper.setActive(slot0.type7, false)

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
				slot3 = slot8.star == Activity191Enum.CharacterMaxStar
				slot4 = slot8.star ~= Activity191Enum.CharacterMaxStar
			end
		elseif slot0.heroCnt == 2 then
			slot0.headItemList[2]:setData(nil, slot0.heroList[1])
			slot0.headItemList[3]:setData(nil, slot0.heroList[2])
		elseif slot0.heroCnt then
			slot0.headItemList[4]:setData(nil, slot0.heroList[1])
			slot0.headItemList[5]:setData(nil, slot0.heroList[2])
			slot0.headItemList[6]:setData(nil, slot0.heroList[3])
		end

		gohelper.setActive(slot0["type" .. slot0.heroCnt], true)
	elseif Activity191Config.instance:getCollectionCo(slot0.itemList[1]) then
		slot0.simageCollection:LoadImage(ResUrl.getRougeSingleBgCollection(slot6.icon))
		gohelper.setActive(slot0.type7, true)

		if string.nilorempty(slot6.label) then
			gohelper.setActive(slot0.goTag1, false)
			gohelper.setActive(slot0.goTag2, false)
		else
			for slot11 = 1, 2 do
				slot12 = string.split(slot6.label, "#")[slot11]
				slot0["txtTag" .. slot11].text = slot12

				gohelper.setActive(slot0["goTag" .. slot11], slot12)
			end
		end
	end

	if slot5.coin < slot0.cost then
		SLFramework.UGUI.GuiHelper.SetColor(slot0.txtCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0.txtCost, "#211f1f")
	end

	slot0.txtCost.text = slot0.cost

	gohelper.setActive(slot0.goMax, slot3)
	gohelper.setActive(slot0.goUp, slot4)
	gohelper.setActive(slot0.goSoldOut, slot0.soldOut)
	gohelper.setActive(slot0.go, true)
end

function slot0.onDestroy(slot0)
end

function slot0.onClick(slot0)
	if slot0.soldOut then
		return
	end

	if slot0.isHeroShop then
		ViewMgr.instance:openView(ViewName.Act191HeroTipView, {
			showBuy = true,
			index = slot0.index,
			cost = slot0.cost,
			heroList = slot0.heroList
		})
	else
		slot1.itemId = slot0.itemList[1]

		ViewMgr.instance:openView(ViewName.Act191ItemTipView, slot1)
	end
end

function slot0.playFreshAnim(slot0)
	slot0.anim:Play("fresh", 0, 0)
end

return slot0
