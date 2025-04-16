module("modules.logic.versionactivity2_7.lengzhou6.view.EliminateChessItem2_7", package.seeall)

slot0 = class("EliminateChessItem2_7", EliminateChessItem)
slot1 = {
	store = "smoke",
	fire = "fire",
	idle = "idle",
	tip = "tips",
	die = "succees"
}
slot2 = ZProj.TweenHelper
slot3 = SLFramework.UGUI.UIDragListener

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._tr = slot1.transform
	slot0._select = false
	slot0._ani = slot1:GetComponent(gohelper.Type_Animator)

	if slot0._ani then
		slot0._ani.enabled = true
	end

	slot0._img_select = gohelper.findChild(slot0._go, "#img_select")
	slot0._img_chess = gohelper.findChildImage(slot0._go, "#img_sprite")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0._go, "#btn_click")

	slot0._btnClick:AddClickListener(slot0.onClick, slot0)

	slot0._drag = UIDragListenerHelper.New()
	slot0._drag = uv0.Get(slot0._btnClick.gameObject)
end

function slot0.initData(slot0, slot1)
	slot0._data = slot1

	slot0:updateInfo()
end

function slot0.getData(slot0)
	return slot0._data
end

function slot0.updateInfo(slot0)
	if slot0._data then
		recthelper.setSize(slot0._tr, EliminateEnum_2_7.ChessWidth, EliminateEnum_2_7.ChessHeight)

		if not string.nilorempty(LengZhou6EliminateConfig.instance:getChessIconPath(slot0._data.id)) then
			UISpriteSetMgr.instance:setHisSaBethSprite(slot0._img_chess, slot1, false)
		end

		gohelper.setActiveCanvasGroup(slot0._go, slot2)
		slot0:updatePos()
		slot0:_checkSpecialSkillState()
		slot0:setNormalAnimation()
		gohelper.setActive(slot0._go, slot2)
	end
end

function slot0.setNormalAnimation(slot0)
	if slot0._data == nil then
		return
	end

	if slot0._data:getEliminateID() ~= EliminateEnum_2_7.ChessType.stone then
		slot0:playAnimation(uv0.idle)
	else
		slot0:playAnimation(uv0.store)
	end
end

function slot0.updatePos(slot0)
	if slot0._data then
		slot1, slot2 = LocalEliminateChessUtils.instance.getChessPos(slot0._data.startX, slot0._data.startY)

		transformhelper.setLocalPosXY(slot0._tr, slot1, slot2)
	end
end

function slot0.onClick(slot0)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.OnChessSelect, slot0._data.x, slot0._data.y, true)
end

function slot0.setSelect(slot0, slot1)
	slot0._select = slot1

	gohelper.setActiveCanvasGroup(slot0._img_select, slot0._select)
end

function slot0.toTip(slot0, slot1)
	if not slot1 then
		slot0:setNormalAnimation()
	else
		slot0:playAnimation(uv0.tip)
	end
end

function slot0.getGoPos(slot0)
	slot0._chessPosX, slot0._chessPosY = transformhelper.getPos(slot0._img_chess.transform)

	return slot0._chessPosX, slot0._chessPosY
end

function slot0.toDie(slot0, slot1, slot2)
	if slot2 == nil or slot2 == LengZhou6Enum.NormalEliminateEffect then
		slot0:playAnimation(uv0.die)
	elseif slot2 == LengZhou6Enum.SkillEffect.EliminationCross then
		slot0:playAnimation(uv0.fire)
	else
		slot0:playAnimation(uv0.die)
	end

	TaskDispatcher.runDelay(slot0.onDestroy, slot0, slot1)
end

function slot0.toMove(slot0, slot1, slot2, slot3, slot4)
	if slot0._data == nil then
		logNormal("EliminateChessItem2_7:toMove self._data == nil" .. slot0._go.name)
	end

	slot5, slot6 = LocalEliminateChessUtils.instance.getChessPos(slot0._data.x, slot0._data.y)
	slot0._tweenId = uv0.DOLocalMove(slot0._tr, slot5, slot6, 0, slot1, slot0._onMoveEnd, slot0, {
		cb = slot3,
		cbTarget = slot4,
		animType = slot2
	}, EaseType.OutQuart)
end

function slot0._onMoveEnd(slot0, slot1)
	if slot0._data ~= nil then
		slot0._data:setStartXY(slot0._data.x, slot0._data.y)
	end

	if slot1.cb then
		slot1.cb(slot1.cbTarget)
	end
end

function slot0.playAnimation(slot0, slot1)
	if slot0._ani then
		slot0._ani:Play(slot1, 0, 0)
	end
end

function slot0.clear(slot0)
	if slot0._go then
		LengZhou6EliminateChessItemController.instance:putChessItemGo(slot0._go)
	end

	slot0._img_select = nil
	slot0._img_chess = nil
	slot0._goClick = nil
	slot0._data = nil
	slot0._select = false
	slot0._drag = nil
end

function slot0.changeState(slot0, slot1, slot2, slot3)
	if slot0._data == nil then
		return
	end

	slot0:_checkFrostState(slot1, slot2, slot3)
	slot0:_checkSpecialSkillState(slot1)
end

function slot0._checkFrostState(slot0, slot1, slot2, slot3)
	LengZhou6EliminateController.instance:dispatchEvent(slot0._data:haveStatus(EliminateEnum_2_7.ChessState.Frost) and LengZhou6Event.ShowEffect or LengZhou6Event.HideEffect, slot2, slot3, EliminateEnum_2_7.ChessEffect.frost)
end

function slot0._checkSpecialSkillState(slot0)
	if slot0._data:haveStatus(EliminateEnum_2_7.ChessState.SpecialSkill) and not string.nilorempty(EliminateEnum_2_7.SpecialChessImage[slot0._data:getEliminateID()]) then
		UISpriteSetMgr.instance:setHisSaBethSprite(slot0._img_chess, slot3, false)
	end
end

function slot0.onDestroy(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()
	end

	if slot0._ani then
		slot0._ani = nil
	end

	slot0:clear()
	uv0.super.onDestroy(slot0)
end

return slot0
