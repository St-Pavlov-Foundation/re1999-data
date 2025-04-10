module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6SkillItem", package.seeall)

slot0 = class("LengZhou6SkillItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goSkillEmpty = gohelper.findChild(slot0.viewGO, "#go_SkillEmpty")
	slot0._goHaveSkill = gohelper.findChild(slot0.viewGO, "#go_HaveSkill")
	slot0._imageSkillIIcon = gohelper.findChildImage(slot0.viewGO, "#go_HaveSkill/SkillIconMask/#image_SkillIIcon")
	slot0._imagecd = gohelper.findChildImage(slot0.viewGO, "#go_HaveSkill/SkillIconMask/#image_cd")
	slot0._txtcd = gohelper.findChildText(slot0.viewGO, "#go_HaveSkill/SkillIconMask/#image_cd/#txt_cd")
	slot0._imageSkillSmallIcon = gohelper.findChildImage(slot0.viewGO, "#go_HaveSkill/#image_SkillSmallIcon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_HaveSkill/#image_SkillSmallIcon/#txt_num")
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
	slot0._skillClick = SLFramework.UGUI.UIClickListener.Get(slot0._imageSkillIIcon.gameObject)

	slot0._skillClick:AddClickListener(slot0._click, slot0)

	slot0._skillSelectClick = SLFramework.UGUI.UIClickListener.Get(slot0._imagechange.gameObject)

	slot0._skillSelectClick:AddClickListener(slot0._selectClick, slot0)

	slot0._goSelect = gohelper.findChild(slot0.viewGO, "#go_HaveSkill/SkillIconMask/vx_select")
	slot0._goComing = gohelper.findChild(slot0.viewGO, "#go_HaveSkill/SkillIconMask/vx_coming")
	slot0._goCanuse = gohelper.findChild(slot0.viewGO, "#go_HaveSkill/SkillIconMask/vx_canuse")
	slot0._goCanchange = gohelper.findChild(slot0.viewGO, "#go_SkillNeedChange/vx_canchange")
end

function slot0._click(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if slot0._skill == nil then
		return
	end

	if not LengZhou6EliminateController.instance:getPerformIsFinish() then
		return
	end

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.OnClickSkill, slot0._skill)
end

function slot0._selectClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

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

	gohelper.setActive(slot0._goComing, false)
	gohelper.setActive(slot0._goSelect, false)
	gohelper.setActive(slot0._goCanuse, false)
	gohelper.setActive(slot0._goCanchange, false)
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

	slot0:updateCanChangeActive()
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
		slot3 = string.split(slot2, "#")

		UISpriteSetMgr.instance:setHisSaBethSprite(slot0._imageSkillIIcon, slot3[1])

		if slot3[2] ~= nil then
			UISpriteSetMgr.instance:setHisSaBethSprite(slot0._imageSkillSmallIcon, slot3[2])
		end

		gohelper.setActive(slot0._imageSkillSmallIcon.gameObject, slot4)
	end

	if slot1.effect ~= nil then
		if string.split(slot3, "#")[1] == LengZhou6Enum.SkillEffect.DealsDamage then
			slot0._txtnum.text = tonumber(slot4[2])
		end

		gohelper.setActive(slot0._txtnum, slot4[1] == LengZhou6Enum.SkillEffect.DealsDamage)
	end
end

function slot0.updateSkillInfo(slot0)
	if slot0._configId == nil then
		return
	end

	if slot0._skill ~= nil and slot0._skill:getEffect()[1] == LengZhou6Enum.SkillEffect.DealsDamage then
		slot0._txtnum.text = slot0._skill:getTotalValue()
	end

	if LengZhou6Config.instance:getEliminateBattleSkill(slot0._configId) and slot1.type ~= LengZhou6Enum.SkillType.active then
		gohelper.setActive(slot0._imagecd.gameObject, false)

		return
	end

	slot3 = (slot0._skill and slot0._skill:getCd() or 0) > 0

	gohelper.setActive(slot0._imagecd.gameObject, slot3)

	if slot3 then
		slot0._txtcd.text = slot2
	else
		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.PlayerSkillCanUse)
		gohelper.setActive(slot0._goSelect, true)

		if slot0._lastInCd then
			AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_refresh)
		end
	end

	slot0._lastInCd = slot3

	gohelper.setActive(slot0._goCanuse, slot0._selectIsFinish and not slot3)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.updateInfo(slot0)
	slot0:updateSkillInfo()
end

function slot0.showEnemySkillRound(slot0, slot1)
	if slot0._goComing then
		gohelper.setActive(slot0._goComing, slot1)
	end
end

function slot0.updateCanChangeActive(slot0)
	slot1 = true

	if slot0._selectIsFinish then
		slot1 = false
	end

	if slot0._configId ~= nil and LengZhou6Config.instance:getEliminateBattleSkill(slot0._configId) and slot2.type == LengZhou6Enum.SkillType.enemyActive then
		slot1 = false
	end

	gohelper.setActive(slot0._goCanchange, slot1)
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
