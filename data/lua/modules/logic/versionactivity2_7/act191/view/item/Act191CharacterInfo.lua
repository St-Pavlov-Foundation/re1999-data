module("modules.logic.versionactivity2_7.act191.view.item.Act191CharacterInfo", package.seeall)

slot0 = class("Act191CharacterInfo", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0.goSkill = gohelper.findChild(slot1, "go_characterinfo/go_skill")
	slot0.txtPassiveName = gohelper.findChildText(slot1, "go_characterinfo/passiveskill/bg/txt_passivename")
	slot0.btnPassiveSkill = gohelper.findChildButtonWithAudio(slot1, "go_characterinfo/passiveskill/btn_passiveskill")
	slot5 = slot0.onClickPassiveSkill

	slot0:addClickCb(slot0.btnPassiveSkill, slot5, slot0)

	for slot5 = 1, 5 do
		slot6 = gohelper.findChild(slot1, "go_characterinfo/attribute/go_attribute/attribute" .. slot5)
		slot0["txtAttr" .. slot5] = gohelper.findChildText(slot6, "txt_attribute")
		slot0["txtAttrName" .. slot5] = gohelper.findChildText(slot6, "name")
	end

	slot0.goPassiveSkill = gohelper.findChild(slot1, "go_characterinfo/passiveskill/go_passiveskills")

	for slot5 = 1, 3 do
		slot0["goPassiveSkill" .. slot5] = gohelper.findChild(slot0.goPassiveSkill, "passiveskill" .. slot5)
	end

	slot0._detailPassiveTables = {}
	slot0.goDetail = gohelper.findChild(slot1, "go_detailView")
	slot0.btnCloseDetail = gohelper.findChildButtonWithAudio(slot0.goDetail, "btn_detailClose")
	slot0.goDetailItem = gohelper.findChild(slot0.goDetail, "scroll_content/viewport/content/go_detailpassiveitem")

	slot0:addClickCb(slot0.btnCloseDetail, slot0.onClickCloseDetail, slot0)

	slot0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goSkill, Act191SkillContainer)
end

function slot0.onDestroy(slot0)
end

function slot0.setData(slot0, slot1)
	slot0.config = slot1
	slot0.passiveSkillIds = Activity191Config.instance:getHeroPassiveSkillIdList(slot1.id)

	for slot6 = 1, 5 do
		slot7 = Activity191Enum.AttrIdList[slot6]
		slot0["txtAttrName" .. slot6].text = HeroConfig.instance:getHeroAttributeCO(slot7).name
		slot0["txtAttr" .. slot6].text = lua_activity191_template.configDict[slot1.id][Activity191Config.AttrIdToFieldName[slot7]]
	end

	if lua_skill.configDict[slot0.passiveSkillIds[1]] then
		slot0.txtPassiveName.text = slot3.name
	end

	slot4 = nil

	for slot8 = 1, 3 do
		gohelper.setActive(slot0["goPassiveSkill" .. slot8], slot8 <= (slot1.type == Activity191Enum.CharacterType.Hero and #SkillConfig.instance:getheroranksCO(slot1.roleId) - 1 or 0))
	end

	slot0._skillContainer:onUpdateMO(slot1)
end

function slot0.onClickPassiveSkill(slot0)
	if slot0.config.type == Activity191Enum.CharacterType.Hero then
		ViewMgr.instance:openView(ViewName.Act191CharacterTipView, {
			id = slot0.config.id,
			tipPos = Vector2.New(851, -59),
			buffTipsX = 1603,
			anchorParams = {
				Vector2.New(0, 0.5),
				Vector2.New(0, 0.5)
			}
		})
	else
		slot0:refreshPassiveDetail()
		gohelper.setActive(slot0.goDetail, true)
	end
end

function slot0.refreshPassiveDetail(slot0)
	for slot5 = 1, #slot0.passiveSkillIds do
		if lua_skill.configDict[tonumber(slot0.passiveSkillIds[slot5])] then
			if not slot0._detailPassiveTables[slot5] then
				slot9 = gohelper.cloneInPlace(slot0.goDetailItem, "item" .. slot5)
				slot8 = slot0:getUserDataTb_()
				slot8.go = slot9
				slot8.name = gohelper.findChildText(slot9, "title/txt_name")
				slot8.icon = gohelper.findChildSingleImage(slot9, "title/simage_icon")
				slot8.desc = gohelper.findChildText(slot9, "txt_desc")

				SkillHelper.addHyperLinkClick(slot8.desc, slot0.onClickHyperLink, slot0)

				slot8.line = gohelper.findChild(slot9, "txt_desc/image_line")

				table.insert(slot0._detailPassiveTables, slot8)
			end

			slot8.name.text = slot7.name
			slot8.desc.text = SkillHelper.getSkillDesc(slot0.config.name, slot7)

			gohelper.setActive(slot8.go, true)
			gohelper.setActive(slot8.line, slot5 < slot1)
		else
			logError(string.format("被动技能配置没找到, id: %d", slot6))
		end
	end

	for slot5 = slot1 + 1, #slot0._detailPassiveTables do
		gohelper.setActive(slot0._detailPassiveTables[slot5].go, false)
	end
end

function slot0.onClickCloseDetail(slot0)
	gohelper.setActive(slot0.goDetail, false)
end

function slot0.onClickHyperLink(slot0, slot1)
	CommonBuffTipController:openCommonTipViewWithCustomPos(slot1, Vector2.New(40, 0))
end

return slot0
