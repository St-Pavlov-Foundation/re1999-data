module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerPage", package.seeall)

slot0 = class("WeekWalk_2HeartLayerPage", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simagebgimg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgimg")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content")
	slot0._gopos = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos")
	slot0._gopos1 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos1")
	slot0._gopos2 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos2")
	slot0._gopos3 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos3")
	slot0._gopos4 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos4")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_line")
	slot0._golight1 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_line/line1/#go_light1")
	slot0._golight2 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_line/line2/#go_light2")
	slot0._golight3 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_line/line3/#go_light3")
	slot0._gotopblock = gohelper.findChild(slot0.viewGO, "#go_topblock")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, slot1)
	slot0._layerView = slot1
end

function slot0._editableInitView(slot0)
	slot0._lineCtrl = slot0._goline:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	slot0._lineValueVec4 = Vector4.New(1, 1, 1, 0)

	slot0:_initItems()
end

function slot0._initItems(slot0)
	slot1 = nil
	slot0._itemList = slot0:getUserDataTb_()

	for slot5 = 1, WeekWalk_2Enum.MaxLayer do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._layerView:getResInst(slot0._layerView.viewContainer._viewSetting.otherRes[2], slot0["_gopos" .. slot5]), WeekWalk_2HeartLayerPageItem)

		table.insert(slot0._itemList, slot8)
		slot8:onUpdateMO({
			index = slot5,
			layerView = slot0._layerView
		})

		if WeekWalk_2Model.instance:getLayerInfoByLayerIndex(slot5) and slot9.unlock then
			slot1 = slot8

			slot0:_setLineValue(WeekWalk_2Enum.LineValue[slot5])
		end
	end

	slot0:_checkUnlockAnim(slot1)
end

function slot0._setLineValue(slot0, slot1)
	slot0._lineValueVec4.z = slot1
	slot0._lineCtrl.vector_01 = slot0._lineValueVec4

	slot0._lineCtrl:SetProps()
end

function slot0._checkUnlockAnim(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot1:getLayerId() then
		return
	end

	if WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.UnlockEpisode, slot2) then
		return
	end

	WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.UnlockEpisode, slot2)

	slot0._unlockPageItem = slot1
	slot3 = slot1:getIndex()
	slot0._startValue = WeekWalk_2Enum.LineValue[slot3 - 1]
	slot0._endValue = WeekWalk_2Enum.LineValue[slot3]

	if not slot0._startValue or not slot0._endValue then
		return
	end

	slot0._unlockPageItem:setFakeUnlock(false)
	slot0:_setLineValue(slot0._startValue)
	TaskDispatcher.cancelTask(slot0._delayStartUnlockAnim, slot0)
	TaskDispatcher.runDelay(slot0._delayStartUnlockAnim, slot0, 0.6)
end

function slot0._delayStartUnlockAnim(slot0)
	slot0:_startUnlockAnim()
end

function slot0._startUnlockAnim(slot0)
	slot0._dotweenId = ZProj.TweenHelper.DOTweenFloat(slot0._startValue, slot0._endValue, 0.3, slot0._everyFrame, slot0._animFinish, slot0)
end

function slot0._everyFrame(slot0, slot1)
	slot0:_setLineValue(slot1)
end

function slot0._animFinish(slot0)
	slot0:_setLineValue(slot0._endValue)
	slot0._unlockPageItem:setFakeUnlock(true)
	slot0._unlockPageItem:playUnlockAnim()
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._delayStartUnlockAnim, slot0)

	if slot0._dotweenId then
		ZProj.TweenHelper.KillById(slot0._dotweenId)

		slot0._dotweenId = nil
	end
end

return slot0
