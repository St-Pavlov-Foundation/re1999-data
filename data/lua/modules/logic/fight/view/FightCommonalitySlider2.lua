module("modules.logic.fight.view.FightCommonalitySlider2", package.seeall)

slot0 = class("FightCommonalitySlider2", FightBaseView)

function slot0.onInitView(slot0)
	slot0.sliderBg = gohelper.findChild(slot0.viewGO, "slider/sliderbg")
	slot0._slider = gohelper.findChildImage(slot0.viewGO, "slider/sliderbg/sliderfg")
	slot0._sliderText = gohelper.findChildText(slot0.viewGO, "slider/sliderbg/#txt_slidernum")
	slot0.effective = gohelper.findChild(slot0.viewGO, "slider/#max")
	slot0.durationText = gohelper.findChildText(slot0.viewGO, "slider/#max/#txt_round")
end

function slot0.onConstructor(slot0, slot1)
	slot0.fightRoot = slot1
end

function slot0.onOpen(slot0)
	slot0:_refreshData()
	slot0:com_registMsg(FightMsgId.FightProgressValueChange, slot0._refreshData)
	slot0:com_registMsg(FightMsgId.FightMaxProgressValueChange, slot0._refreshData)
	slot0:com_registFightEvent(FightEvent.OnBuffUpdate, slot0._onBuffUpdate)
	slot0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, slot0._refreshData)
end

function slot0._refreshData(slot0)
	if slot0._lastMax ~= (FightDataHelper.fieldMgr.progressMax <= FightDataHelper.fieldMgr.progress) then
		gohelper.setActive(slot0._max, slot3)
	end

	slot4 = slot1 / slot2
	slot0._sliderText.text = Mathf.Clamp(slot4 * 100, 0, 100) .. "%"

	ZProj.TweenHelper.KillByObj(slot0._slider)
	ZProj.TweenHelper.DOFillAmount(slot0._slider, slot4, 0.2 / FightModel.instance:getUISpeed())
	gohelper.setActive(slot0.sliderBg, true)
	gohelper.setActive(slot0.effective, false)

	slot0._lastMax = slot3
	slot5 = false

	if FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId] == 2 and FightDataHelper.entityMgr:getMyVertin() then
		for slot12, slot13 in pairs(slot7.buffDic) do
			if slot13.buffId == 9260101 then
				gohelper.setActive(slot0.sliderBg, false)
				gohelper.setActive(slot0.effective, true)

				slot0.durationText.text = slot13.duration
				slot5 = true

				break
			end
		end
	end

	slot0:checkShowScreenEffect(slot5)
end

function slot0.checkShowScreenEffect(slot0, slot1)
	if not slot0._effectRoot then
		slot0._effectRoot = gohelper.create2d(slot0.fightRoot, "FightCommonalitySlider2ScreenEffect")
		slot2 = slot0._effectRoot.transform
		slot2.anchorMin = Vector2.zero
		slot2.anchorMax = Vector2.one
		slot2.offsetMin = Vector2.zero
		slot2.offsetMax = Vector2.zero

		slot0:com_loadAsset("ui/viewres/fight/fight_weekwalk_screeneff.prefab", slot0.onScreenEffectLoaded)
	end

	gohelper.setActive(slot0._effectRoot, slot1)
end

function slot0.onScreenEffectLoaded(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	gohelper.clone(slot2:GetResource(), slot0._effectRoot)
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
