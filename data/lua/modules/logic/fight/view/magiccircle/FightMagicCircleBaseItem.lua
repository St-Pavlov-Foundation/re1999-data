module("modules.logic.fight.view.magiccircle.FightMagicCircleBaseItem", package.seeall)

slot0 = class("FightMagicCircleBaseItem", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.destroyed = nil
	slot0._aniPlayer = SLFramework.AnimatorPlayer.Get(slot0.go)
	slot0._ani = slot0.go:GetComponent(gohelper.Type_Animator)

	slot0:initView()
end

function slot0.destroy(slot0)
	slot0.destroyed = true

	if slot0._aniPlayer then
		slot0._aniPlayer:Stop()
	end

	slot0:hideGo()
	slot0:__onDispose()
end

function slot0.getUIType(slot0)
	return FightEnum.MagicCircleUIType.Normal
end

function slot0.hideGo(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.showGo(slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.initView(slot0)
end

function slot0.onCreateMagic(slot0, slot1, slot2)
	slot0:showGo()
	slot0:playAnim("open")
	slot0:refreshUI(slot1, slot2)
end

function slot0.onUpdateMagic(slot0, slot1, slot2)
	slot0:refreshUI(slot1, slot2)
end

function slot0.onRemoveMagic(slot0)
	slot0:destroy()
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	slot0._ani.speed = FightModel.instance:getSpeed()

	slot0._aniPlayer:Play(slot1, slot2, slot3)
end

function slot0.refreshUI(slot0, slot1, slot2)
end

return slot0
