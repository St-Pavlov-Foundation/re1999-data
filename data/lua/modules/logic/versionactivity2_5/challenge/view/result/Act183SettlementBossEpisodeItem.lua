module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementBossEpisodeItem", package.seeall)

slot0 = class("Act183SettlementBossEpisodeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtbossbadge = gohelper.findChildText(slot1, "root/right/#txt_bossbadge")
	slot0._simageboss = gohelper.findChildSingleImage(slot1, "root/right/#simage_boss")
	slot0._gobossheros = gohelper.findChild(slot1, "root/right/#go_bossheros")
	slot0._gobuffs = gohelper.findChild(slot1, "root/right/buffs/#go_buffs")
	slot0._gobuffitem = gohelper.findChild(slot1, "root/right/buffs/#go_buffs/#go_buffitem")
	slot0._gostars = gohelper.findChild(slot1, "root/right/BossStars/#go_Stars")
	slot0._gostaritem = gohelper.findChild(slot1, "root/right/BossStars/#go_Stars/#go_Staritem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._herogroupComp = MonoHelper.addLuaComOnceToGo(slot0._gobossheros, Act183SettlementBossEpisodeHeroComp)
end

function slot0.setHeroTemplate(slot0, slot1)
	if slot0._herogroupComp then
		slot0._herogroupComp:setHeroTemplate(slot1)
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	slot0._bossEpisodeId = slot2:getEpisodeId()

	Act183Helper.setBossEpisodeResultIcon(slot0._bossEpisodeId, slot0._simageboss)
	slot0:refreshUseBadge(slot2)
	slot0:refreshHeroGroup(slot2)
	slot0:refreshEpisodeStars(slot2)

	slot3, slot4, slot5, slot6 = slot1:getBossEpisodeConditionStatus()
	slot0._unlockConditionMap = Act183Helper.listToMap(slot4)
	slot0._passConditionMap = Act183Helper.listToMap(slot5)
	slot0._chooseConditionMap = Act183Helper.listToMap(slot6)

	gohelper.CreateObjList(slot0, slot0.refreshBossEpisodeCondition, slot3 or {}, slot0._gobuffs, slot0._gobuffitem)
end

function slot0.refreshUseBadge(slot0, slot1)
	gohelper.setActive(slot0._txtbossbadge.gameObject, slot1:getUseBadgeNum() > 0)

	slot0._txtbossbadge.text = slot2
end

function slot0.refreshBossEpisodeCondition(slot0, slot1, slot2, slot3)
	Act183Helper.setEpisodeConditionStar(gohelper.onceAddComponent(slot1, gohelper.Type_Image), slot0._unlockConditionMap[slot2] ~= nil, slot0._chooseConditionMap[slot2] ~= nil)
end

function slot0.refreshEpisodeStars(slot0, slot1)
	for slot7 = 1, slot1:getTotalStarCount() do
		slot9 = gohelper.onceAddComponent(gohelper.cloneInPlace(slot0._gostaritem, "star_" .. slot7), gohelper.Type_Image)

		UISpriteSetMgr.instance:setCommonSprite(slot9, "zhuxianditu_pt_xingxing_001", true)
		SLFramework.UGUI.GuiHelper.SetColor(slot9, slot7 <= slot1:getFinishStarCount() and "#F77040" or "#87898C")
		gohelper.setActive(slot8, true)
	end
end

function slot0.refreshHeroGroup(slot0, slot1)
	if slot0._herogroupComp then
		slot0._herogroupComp:onUpdateMO(slot1)
	end
end

function slot0.onDestroy(slot0)
end

return slot0
