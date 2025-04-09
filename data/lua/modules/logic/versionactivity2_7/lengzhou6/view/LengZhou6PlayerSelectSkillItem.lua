module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6PlayerSelectSkillItem", package.seeall)

slot0 = class("LengZhou6PlayerSelectSkillItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_Selected")
	slot0._txtSkillDescr = gohelper.findChildText(slot0.viewGO, "#txt_SkillDescr")
	slot0._txtSkillName = gohelper.findChildText(slot0.viewGO, "#txt_SkillDescr/#txt_SkillName")
	slot0._simageSkillIIcon = gohelper.findChildSingleImage(slot0.viewGO, "#txt_SkillDescr/Skill/SkillIconMask/#simage_SkillIIcon")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "#txt_SkillDescr/#txt_Round")
	slot0._goClick = gohelper.findChild(slot0.viewGO, "#txt_SkillDescr/#go_Click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
	slot0._skillGoClick = SLFramework.UGUI.UIClickListener.Get(slot0._goClick)

	slot0._skillGoClick:AddClickListener(slot0._select, slot0)
end

function slot0._editableRemoveEvents(slot0)
	if slot0._skillGoClick then
		slot0._skillGoClick:RemoveClickListener()

		slot0._skillGoClick = nil
	end
end

function slot0._select(slot0)
	if slot0._skillId == nil then
		return
	end

	if LengZhou6GameModel.instance:playerSkillIsSelect(slot0._skillId) then
		return
	end

	LengZhou6GameModel.instance:setPlayerSelectSkillId(slot0._selectIndex, slot0._skillId)
	slot0:refreshSelect()
	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.PlayerSelectFinish, slot0._selectIndex, slot0._skillId)
end

function slot0.initSkill(slot0, slot1)
	slot0._skillId = slot1
	slot0._config = LengZhou6Config.instance:getEliminateBattleSkill(slot1)

	if slot0._config ~= nil then
		slot0:initItem()
		slot0:refreshSelect()
	end
end

function slot0.initSelectIndex(slot0, slot1)
	slot0._selectIndex = slot1
end

function slot0.refreshSelect(slot0)
	slot2 = false

	for slot6, slot7 in pairs(LengZhou6GameModel.instance:getSelectSkillId()) do
		if slot0._skillId == slot7 then
			slot2 = true
		end
	end

	gohelper.setActive(slot0._goSelected, slot2)
end

function slot0.initItem(slot0)
	if slot0._config.type == LengZhou6Enum.SkillType.active then
		slot0._txtRound.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_skill_round"), slot0._config.cd)
	else
		slot0._txtRound.text = luaLang("lengZhou6_skill_round_end")
	end

	slot0._txtSkillDescr.text = slot0._config.desc

	if slot0._config.icon ~= nil then
		slot0._simageSkillIIcon:LoadImage(slot2)
	end

	slot0._txtSkillName.text = slot1 and luaLang("v2a7_lengZhou6_endLess_activeSkill") or luaLang("v2a7_lengZhou6_endLess_unActiveSkill")
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
