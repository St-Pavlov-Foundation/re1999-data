module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceListHeroItem", package.seeall)

slot0 = class("DestinyStoneGiftPickChoiceListHeroItem", LuaCompBase)
slot1 = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._imagerare = gohelper.findChildImage(slot0._go, "rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0._go, "heroicon")
	slot0._imagecareer = gohelper.findChildImage(slot0._go, "career")
	slot0._txtname = gohelper.findChildText(slot0._go, "name")
	slot0._goexskill = gohelper.findChild(slot1, "#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot1, "#go_exskill/#image_exskill")
	slot0._goRankBg = gohelper.findChild(slot1, "Rank")
	slot0._goranks = slot0:getUserDataTb_()

	for slot5 = 1, 3 do
		slot0._goranks[slot5] = gohelper.findChild(slot1, "Rank/rank" .. slot5)
	end

	slot0:addEvents()
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.setLock(slot0)
	slot0._btnClick:RemoveClickListener()
end

function slot0.refreshUI(slot0)
	if not HeroConfig.instance:getHeroCO(slot0._mo.id) then
		logError("DestinyStoneGiftPickChoiceListHeroItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(slot0._mo.id))

		return
	end

	slot0:refreshBaseInfo(slot1)
	slot0:refreshExSkill()
end

function slot0.refreshBaseInfo(slot0, slot1)
	if not SkinConfig.instance:getSkinCo(slot1.skinId) then
		logError("DestinyStoneGiftPickChoiceListHeroItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(slot1.skinId))

		return
	end

	slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot2.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. slot1.career)

	slot9 = slot1.rare

	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[slot9]))

	slot0._txtname.text = slot1.name

	for slot9 = 1, 3 do
		slot10 = slot9 == slot0._mo.rank - 1

		gohelper.setActive(slot0._goranks[slot9], slot10)

		slot5 = false or slot10
	end

	gohelper.setActive(slot0._goRankBg, slot5)
end

function slot0.refreshExSkill(slot0)
	if not slot0._mo:hasHero() or slot0._mo:getSkillLevel() <= 0 then
		gohelper.setActive(slot0._goexskill, false)

		return
	end

	gohelper.setActive(slot0._goexskill, true)

	slot0._imageexskill.fillAmount = uv0[slot0._mo:getSkillLevel()] or 1
end

function slot0.onDestroy(slot0)
	if not slot0._isDisposed then
		slot0._simageicon:UnLoadImage()
		slot0:removeEvents()

		slot0._isDisposed = true
	end
end

return slot0
