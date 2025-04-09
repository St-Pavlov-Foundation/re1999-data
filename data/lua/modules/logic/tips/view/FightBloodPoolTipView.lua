module("modules.logic.tips.view.FightBloodPoolTipView", package.seeall)

slot0 = class("FightBloodPoolTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "root/layout/#txt_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/layout/#txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.click = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "close_block")

	slot0.click:AddClickListener(slot0.closeThis, slot0)
end

function slot0.onOpen(slot0)
	slot0._txttitle.text = lua_fight_xcjl_const.configDict[6].value2
	slot3 = lua_skill.configDict[FightHelper.getBloodPoolSkillId()]
	slot4 = string.format("【%s】", slot3.name)
	slot0._txtdesc.text = string.format("%s\n\n%s:%s", GameUtil.getSubPlaceholderLuaLangTwoParam(lua_fight_xcjl_const.configDict[7].value2, lua_fight_xcjl_const.configDict[3].value, slot4), slot4, FightConfig.instance:getSkillEffectDesc(nil, slot3))
end

function slot0.onDestroyView(slot0)
	if slot0.click then
		slot0.click:RemoveClickListener()

		slot0.click = nil
	end
end

return slot0
