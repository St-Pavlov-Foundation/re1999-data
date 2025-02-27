module("modules.logic.fight.view.FightWeekWalkEnemyTipsView", package.seeall)

slot0 = class("FightWeekWalkEnemyTipsView", FightBaseView)

function slot0.onInitView(slot0)
	slot0.objContent = gohelper.findChild(slot0.viewGO, "#go_enemyinfocontainer/enemy/#scroll_enemy/viewport/content")
	slot0.objItem = gohelper.findChild(slot0.viewGO, "#go_enemyinfocontainer/enemy/#scroll_enemy/viewport/content/#go_enemyitem")
	slot0.btnClose = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_enemyinfocontainer/#btn_close")
end

function slot0.addEvents(slot0)
	slot0:com_registClick(slot0.btnClose, slot0.onBtnClose)
end

function slot0.removeEvents(slot0)
end

function slot0.onBtnClose(slot0)
	slot0:closeThis()
end

function slot0.onConstructor(slot0)
end

function slot0.onOpen(slot0)
	slot1 = FightDataHelper.entityMgr:getEnemySubList()

	table.insert(slot1, 1, true)
	gohelper.CreateObjList(slot0, slot0._onItemShow, slot1, slot0.objContent, slot0.objItem)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	if slot3 == 1 then
		return
	end

	gohelper.findChildText(slot1, "#txt_name").text = slot2:getEntityName()
	gohelper.findChildText(slot1, "#txt_level").text = HeroConfig.instance:getLevelDisplayVariant(slot2.level)
	gohelper.findChildText(slot1, "hp/hp_label/image_HPFrame/#txt_hp").text = slot2.currentHp

	gohelper.setActive(gohelper.findChild(slot1, "hp/hp_label/image_HPFrame/#go_multihp"), false)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot1, "head/#image_career"), "lssx_" .. slot2.career)

	if slot2:getSpineSkinCO() then
		gohelper.getSingleImage(gohelper.findChildImage(slot1, "head/#simage_icon").gameObject):LoadImage(ResUrl.monsterHeadIcon(slot10.headIcon))
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
