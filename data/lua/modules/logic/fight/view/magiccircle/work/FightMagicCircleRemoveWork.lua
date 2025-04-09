module("modules.logic.fight.view.magiccircle.work.FightMagicCircleRemoveWork", package.seeall)

slot0 = class("FightMagicCircleRemoveWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.magicItem = slot1
end

function slot0.onStart(slot0)
	if slot0.magicItem then
		slot0.magicItem:playAnim("close", slot0.onCloseAnimDone, slot0)
	else
		slot0:onCloseAnimDone()
	end
end

function slot0.onCloseAnimDone(slot0)
	if slot0.magicItem then
		slot0.magicItem:onRemoveMagic()
	end

	slot0:onDone(true)
end

function slot0.onDestroy(slot0)
	if slot0.magicItem then
		slot0.magicItem:onRemoveMagic()
	end

	slot0.magicItem = nil
end

return slot0
