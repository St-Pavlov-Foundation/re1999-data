module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6SkillItem", package.seeall)

slot0 = class("LengZhou6SkillItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goSkillEmpty = gohelper.findChild(slot0.viewGO, "#go_SkillEmpty")
	slot0._goHaveSkill = gohelper.findChild(slot0.viewGO, "#go_HaveSkill")
	slot0._simageSkillIIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_HaveSkill/SkillIconMask/#simage_SkillIIcon")
	slot0._imagecd = gohelper.findChildImage(slot0.viewGO, "#go_HaveSkill/SkillIconMask/#image_cd")
	slot0._txtcd = gohelper.findChildText(slot0.viewGO, "#go_HaveSkill/SkillIconMask/#image_cd/#txt_cd")
	slot0._goSkillNeedChange = gohelper.findChild(slot0.viewGO, "#go_SkillNeedChange")
	slot0._imagechange = gohelper.findChildImage(slot0.viewGO, "#go_SkillNeedChange/#image_change")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = 0.5
slot2 = 99999

function slot0._editableInitView(slot0)
	slot0._skillClick = SLFramework.UGUI.UIClickListener.Get(slot0._simageSkillIIcon.gameObject)

	slot0._skillClick:AddClickListener(slot0._click, slot0)

	slot0._skillSelectClick = SLFramework.UGUI.UIClickListener.Get(slot0._imagechange.gameObject)

	slot0._skillSelectClick:AddClickListener(slot0._selectClick, slot0)
end

function slot0._click(slot0)
	if slot0._skill == nil then
		return
	end

	if not LengZhou6EliminateController.instance:getPerformIsFinish() then
		return
	end

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.OnClickSkill, slot0._skill)
end

function slot0._selectClick(slot0)
	if LengZhou6GameModel.instance:getEndLessBattleProgress() == LengZhou6Enum.BattleProgress.selectSkill then
		LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.ShowSelectView, slot0._index)
	end
end

function slot0.initSkill(slot0, slot1, slot2)
	slot0._skill = slot1
	slot0._configId = nil
	slot0._index = slot2 or 1

	if slot0._skill ~= nil then
		slot0._configId = slot0._skill:getConfig().id
		slot0._skillId = slot0._skill._id
	end
end

function slot0.initSkillConfigId(slot0, slot1)
	slot0._configId = slot1
end

function slot0.selectIsFinish(slot0, slot1)
	slot0._selectIsFinish = slot1
end

function slot0.initCamp(slot0, slot1)
	slot0._camp = slot1
end

function slot0.refreshState(slot0)
	slot1 = slot0._skillId == nil

	if not (slot0._configId == nil) then
		slot0:initInfo()
	end

	if not slot1 then
		slot0:updateInfo()
	end

	gohelper.setActive(slot0._goSkillEmpty, slot2)
	gohelper.setActive(slot0._goHaveSkill, not slot2)

	if LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		slot5 = LengZhou6GameModel.instance:getEndLessBattleProgress() == LengZhou6Enum.BattleProgress.selectFinish

		gohelper.setActive(slot0._goSkillNeedChange, not slot5 and slot0._camp == LengZhou6Enum.entityCamp.player)

		if not slot5 then
			gohelper.setActive(slot0._imagecd.gameObject, false)
		end
	else
		gohelper.setActive(slot0._goSkillNeedChange, false)
	end
end

function slot0.useSkill(slot0, slot1)
	if slot0._skillId == slot1 then
		slot0._skillId = nil
		slot0._configId = nil
	end

	slot0:refreshState()
end

function slot0.initInfo(slot0)
	if LengZhou6Config.instance:getEliminateBattleSkill(slot0._configId) == nil then
		return
	end

	if slot1.icon ~= nil then
		slot0._simageSkillIIcon:LoadImage(slot2)
	end
end

function slot0.updateSkillInfo(slot0)
	slot1 = slot0._skill and slot0._skill:getCd() or 0

	gohelper.setActive(slot0._imagecd.gameObject, slot1 > 0)

	if slot1 > 0 then
		slot0._txtcd.text = slot1
	else
		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.PlayerSkillCanUse)
	end
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.updateInfo(slot0)
	slot0:updateSkillInfo()
end

function slot0.onDestroyView(slot0)
	if slot0._skillClick ~= nil then
		slot0._skillClick:RemoveClickListener()

		slot0._skillClick = nil
	end

	if slot0._skillSelectClick then
		slot0._skillSelectClick:RemoveClickListener()

		slot0._skillSelectClick = nil
	end
end

return slot0
