module("modules.logic.fight.view.FightDouQuQuStarView", package.seeall)

slot0 = class("FightDouQuQuStarView", FightBaseView)

function slot0.onInitView(slot0)
	slot0.img = gohelper.findChildImage(slot0.viewGO, "root/quality/bg/#image_quality")
end

function slot0.addEvents(slot0)
end

function slot0.onConstructor(slot0, slot1)
	slot0.entityMO = slot1
end

function slot0.refreshEntityMO(slot0, slot1)
	slot0.entityMO = slot1

	if slot0.viewGO then
		slot0:refreshStar()
	end
end

function slot0.onOpen(slot0)
	slot0.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	slot0:refreshStar()
end

function slot0.refreshStar(slot0)
	slot2 = 0

	for slot6, slot7 in pairs(slot0.customData.teamAHeroInfo) do
		if tonumber(slot6) == slot0.entityMO.modelId then
			slot2 = string.splitToNumber(slot7, "#")[1]

			break
		end
	end

	if slot2 == 0 then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot0.img.fillAmount = slot2 / Activity191Enum.CharacterMaxStar
end

return slot0
