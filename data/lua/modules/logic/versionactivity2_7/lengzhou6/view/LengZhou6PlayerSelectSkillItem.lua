module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6PlayerSelectSkillItem", package.seeall)

slot0 = class("LengZhou6PlayerSelectSkillItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_Selected")
	slot0._txtSkillDescr = gohelper.findChildText(slot0.viewGO, "#txt_SkillDescr")
	slot0._txtSkillName = gohelper.findChildText(slot0.viewGO, "#txt_SkillDescr/#txt_SkillName")
	slot0._imageSkillIIcon = gohelper.findChildImage(slot0.viewGO, "#txt_SkillDescr/Skill/SkillIconMask/#image_SkillIIcon")
	slot0._imageSkillSmallIcon = gohelper.findChildImage(slot0.viewGO, "#txt_SkillDescr/Skill/#image_SkillSmallIcon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#txt_SkillDescr/Skill/#image_SkillSmallIcon/#txt_num")
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

	if LengZhou6GameModel.instance:isSelectSkill(slot0._skillId) then
		return
	end

	LengZhou6GameModel.instance:setPlayerSelectSkillId(slot0._selectIndex, slot0._skillId)
	slot0:refreshSelect()
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_refresh)
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
	gohelper.setActive(slot0._goSelected, LengZhou6GameModel.instance:isSelectSkill(slot0._skillId))
end

function slot0.initItem(slot0)
	if slot0._config.type == LengZhou6Enum.SkillType.active then
		slot0._txtRound.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_skill_round"), slot0._config.cd)
	else
		slot0._txtRound.text = luaLang("lengZhou6_skill_round_end")
	end

	slot0._txtSkillDescr.text = slot0._config.desc

	if slot0._config.icon ~= nil then
		slot3 = string.split(slot2, "#")

		UISpriteSetMgr.instance:setHisSaBethSprite(slot0._imageSkillIIcon, slot3[1])

		if slot3[2] ~= nil then
			UISpriteSetMgr.instance:setHisSaBethSprite(slot0._imageSkillSmallIcon, slot3[2])
		end

		gohelper.setActive(slot0._imageSkillSmallIcon.gameObject, slot4)
	end

	if slot0._config.effect ~= nil then
		if string.split(slot3, "#")[1] == LengZhou6Enum.SkillEffect.DealsDamage then
			slot0._txtnum.text = tonumber(slot4[2])
		end

		gohelper.setActive(slot0._txtnum.gameObject, slot4[1] == LengZhou6Enum.SkillEffect.DealsDamage)
	end

	slot0._txtSkillName.text = slot0._config.name
end

function slot0.onDestroyView(slot0)
end

return slot0
