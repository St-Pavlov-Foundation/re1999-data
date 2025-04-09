module("modules.logic.versionactivity2_7.act191.view.Act191ShopHeroGroupView", package.seeall)

slot0 = class("Act191ShopHeroGroupView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnChangeName = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/horizontal/#drop_HeroGroup/#btn_ChangeName")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnChangeName:AddClickListener(slot0._btnChangeNameOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnChangeName:RemoveClickListener()
end

function slot0._btnChangeNameOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Act191ModifyNameView)
end

function slot0._editableInitView(slot0)
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.actId = Activity191Model.instance:getCurActId()
	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	slot0:initDrop()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.ModifyTeamName, slot0.refreshDropValue, slot0)
	slot0:refreshDropValue()
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
end

function slot0.onDestroyView(slot0)
	slot0.dropClick:RemoveClickListener()
	slot0.dropHeroGroup:RemoveOnValueChanged()
end

function slot0.initDrop(slot0)
	slot0.dropHeroGroup = gohelper.findChildDropdown(slot0.viewGO, "btnContain/horizontal/#drop_HeroGroup")

	slot0.dropHeroGroup:AddOnValueChanged(slot0.onDropValueChanged, slot0)

	slot0.trDropArrow = gohelper.findChildComponent(slot0.dropHeroGroup.gameObject, "arrow", typeof(UnityEngine.Transform))
	slot0.dropClick = gohelper.getClick(slot0.dropHeroGroup.gameObject)

	slot0.dropClick:AddClickListener(function ()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, slot0)

	slot0.dropExtend = DropDownExtend.Get(slot0.dropHeroGroup.gameObject)

	slot0.dropExtend:init(slot0.onDropShow, slot0.onDropHide, slot0)

	slot0.initDropDone = true
end

function slot0.onDropShow(slot0)
	transformhelper.setLocalScale(slot0.trDropArrow, 1, -1, 1)
end

function slot0.onDropHide(slot0)
	transformhelper.setLocalScale(slot0.trDropArrow, 1, 1, 1)
end

function slot0.onDropValueChanged(slot0, slot1)
	if not slot0.initDropDone then
		return
	end

	slot0.gameInfo:setCurTeamIndex(slot1 + 1)
end

function slot0.refreshDropValue(slot0)
	for slot6 = 1, 4 do
	end

	slot0.dropHeroGroup:ClearOptions()
	slot0.dropHeroGroup:AddOptions({
		[slot6] = Activity191Model.instance:getActInfo(slot0.actId):getGameInfo():getTeamInfo(slot6).name
	})
	slot0.dropHeroGroup:SetValue(slot0.gameInfo.curTeamIndex - 1)
end

return slot0
