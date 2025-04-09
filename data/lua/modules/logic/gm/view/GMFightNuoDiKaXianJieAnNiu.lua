module("modules.logic.gm.view.GMFightNuoDiKaXianJieAnNiu", package.seeall)

slot0 = class("GMFightNuoDiKaXianJieAnNiu", FightBaseView)

function slot0.onInitView(slot0)
	slot0.btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnStart")
end

function slot0.addEvents(slot0)
	slot0:com_registClick(slot0.btnStart, slot0.onClickStart)
end

function slot0.onClickStart(slot0)
	slot0.time = slot0.time or Time.time

	if slot0.timeLimit < Time.time - slot0.time then
		slot0.time = Time.time

		slot0:com_sendFightEvent(FightEvent.OperationForPlayEffect, slot0.effectType)
	end
end

function slot0.onOpen(slot0)
	slot0.effectType = slot0.viewParam.effectType
	slot0.timeLimit = slot0.viewParam.timeLimit
	slot0.time = 0
end

function slot0.onDestructor(slot0)
end

return slot0
