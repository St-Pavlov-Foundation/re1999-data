module("modules.logic.fight.view.FightCommonalitySlider2", package.seeall)

slot0 = class("FightCommonalitySlider2", FightBaseView)

function slot0.onInitView(slot0)
	slot0._slider = gohelper.findChildImage(slot0.viewGO, "slider/sliderbg/sliderfg")
	slot0._sliderText = gohelper.findChildText(slot0.viewGO, "slider/sliderbg/#txt_slidernum")
end

function slot0.onOpen(slot0)
	slot0:_refreshData()
	slot0:com_registMsg(FightMsgId.FightProgressValueChange, slot0._refreshData)
	slot0:com_registMsg(FightMsgId.FightMaxProgressValueChange, slot0._refreshData)
	slot0:com_registFightEvent(FightEvent.OnBuffUpdate, slot0._onBuffUpdate)
end

function slot0._refreshData(slot0)
	if slot0._lastMax ~= (FightDataHelper.fieldMgr.progressMax <= FightDataHelper.fieldMgr.progress) then
		gohelper.setActive(slot0._max, slot3)
	end

	slot4 = slot1 / slot2
	slot0._sliderText.text = Mathf.Clamp(slot4 * 100, 0, 100) .. "%"

	ZProj.TweenHelper.KillByObj(slot0._slider)
	ZProj.TweenHelper.DOFillAmount(slot0._slider, slot4, 0.2 / FightModel.instance:getUISpeed())

	slot0._lastMax = slot3

	if FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId] == 2 and FightDataHelper.entityMgr:getEnemyVertin() then
		for slot11, slot12 in pairs(slot6.buffDic) do
			if slot12.buffId == 9260101 then
				slot0._sliderText.text = slot12.duration

				break
			end
		end
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot3 == 9260101 then
		slot0:_refreshData()
	end
end

function slot0.onClose(slot0)
	ZProj.TweenHelper.KillByObj(slot0._slider)
end

return slot0
