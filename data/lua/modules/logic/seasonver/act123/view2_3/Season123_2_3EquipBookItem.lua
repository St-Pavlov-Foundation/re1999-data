module("modules.logic.seasonver.act123.view2_3.Season123_2_3EquipBookItem", package.seeall)

slot0 = class("Season123_2_3EquipBookItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gopos = gohelper.findChild(slot0.viewGO, "go_pos")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._simageroleicon = gohelper.findChildSingleImage(slot0.viewGO, "image_roleicon")
	slot0._txtcountvalue = gohelper.findChildText(slot0.viewGO, "go_count/bg/#txt_countvalue")
	slot0._gocount = gohelper.findChild(slot0.viewGO, "go_count")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_new")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, slot0.refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, slot0.refreshUI, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._cfg = Season123Config.instance:getSeasonEquipCo(slot0._mo.id)

	if slot0._cfg then
		slot0:refreshUI()
	end

	slot0:checkPlayAnim()
end

slot0.ColumnCount = 6
slot0.AnimRowCount = 4
slot0.OpenAnimTime = 0.06
slot0.OpenAnimStartTime = 0.05

function slot0.refreshUI(slot0)
	slot0:checkCreateIcon()
	slot0.icon:updateData(slot0._mo.id)
	slot0.icon:setColorDark(slot0._mo.count <= 0)
	slot0.icon:setIndexLimitShowState(true)
	gohelper.setActive(slot0._goselect, Season123EquipBookModel.instance.curSelectItemId == slot0._mo.id)
	gohelper.setActive(slot0._gonew, slot0._mo.isNew)

	if slot0._mo.count > 0 then
		gohelper.setActive(slot0._gocount, true)

		slot0._txtcountvalue.text = luaLang("multiple") .. tostring(slot0._mo.count)
	else
		gohelper.setActive(slot0._gocount, false)
	end
end

function slot0.checkPlayAnim(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)

	if Season123EquipBookModel.instance:getDelayPlayTime(slot0._mo) == -1 then
		slot0._animator:Play("idle", 0, 0)

		slot0._animator.speed = 1
	else
		slot0._animator:Play("open", 0, 0)

		slot0._animator.speed = 0

		TaskDispatcher.runDelay(slot0.onDelayPlayOpen, slot0, slot1)
	end
end

function slot0.onDelayPlayOpen(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)
	slot0._animator:Play("open", 0, 0)

	slot0._animator.speed = 1
end

function slot0.checkCreateIcon(slot0)
	if not slot0.icon then
		slot0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst(slot0._view.viewContainer:getSetting().otherRes[2], slot0._gopos, "icon"), Season123_2_3CelebrityCardEquip)

		slot0.icon:setClickCall(slot0.onClickSelf, slot0)
	end
end

function slot0.onClickSelf(slot0)
	if slot0._mo then
		Season123EquipBookController.instance:changeSelect(slot0._mo.id)
	end
end

function slot0.onDestroyView(slot0)
	if slot0.icon then
		slot0.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)
end

return slot0
