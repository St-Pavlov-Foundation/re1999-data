module("modules.logic.versionactivity2_7.act191.view.item.Act191SkillDescComp", package.seeall)

slot0 = class("Act191SkillDescComp", LuaCompBase)
slot1 = "SkillDescComp"
slot2 = "#7e99d0"

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
end

function slot0.updateInfo(slot0, slot1, slot2, slot3)
	slot0._txtComp = slot1
	slot0._config = slot3

	if slot0._skillNameList ~= nil then
		tabletool.clear(slot0._skillNameList)
	end

	slot0._hyperLinkClick = gohelper.onceAddComponent(slot0.viewGO, typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick:SetClickListener(slot0._onHyperLinkClick, slot0)

	slot0._txtComp.text = slot0:_revertSkillName(slot0:addNumColor(slot0:addLink(slot0:_replaceSkillTag(slot2, "▩(%d)%%s"))), 1)
	slot0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO.gameObject, FixTmpBreakLine)

	slot0._fixTmpBreakLine:refreshTmpContent(slot0.viewGO)
end

function slot0.setTipParam(slot0, slot1, slot2)
	slot0._skillTipAnchorX = slot1
	slot0._buffTipAnchor = slot2
end

function slot0._replaceSkillTag(slot0, slot1, slot2)
	slot3, slot4, slot5 = string.find(slot1, slot2)

	if not slot3 then
		return slot1
	end

	slot6 = nil

	if not ((tonumber(slot5) ~= 0 or Activity191Config.instance:getHeroPassiveSkillIdList(slot0._config.id)[1]) and Activity191Config.instance:getHeroSkillIdDic(slot0._config.id, true)[slot5]) then
		logError("没找到当前角色的技能：heroId:" .. slot0._config.id .. "  skillindex:" .. slot5)

		return slot1
	end

	slot9 = lua_skill.configDict[slot6].name and string.format("<color=%s><link=\"skillIndex=%s\">【%s】</link></color>", uv0, slot5, slot7) or ""

	if not slot0._skillNameList then
		slot0._skillNameList = {}
	end

	table.insert(slot0._skillNameList, slot9)

	return slot0:_replaceSkillTag(string.gsub(slot1, slot2, uv1, 1), slot2)
end

function slot0._revertSkillName(slot0, slot1, slot2)
	if not string.find(slot1, uv0) then
		return slot1
	end

	if not slot0._skillNameList[slot2] then
		return slot1
	end

	return slot0:_revertSkillName(string.gsub(slot1, uv0, slot4, 1), slot2 + 1)
end

function slot0.addLink(slot0, slot1)
	return string.gsub(string.gsub(slot1, "%[(.-)%]", slot0.addLinkCb1), "【(.-)】", slot0.addLinkCb2)
end

function slot3(slot0, slot1)
	slot1 = SkillHelper.removeRichTag(slot1)

	if not SkillConfig.instance:getSkillEffectDescCoByName(slot1) then
		return slot1
	end

	slot3 = uv0
	slot1 = string.format(slot0, slot1)

	if not slot2.notAddLink or slot2.notAddLink == 0 then
		return string.format("<color=%s><u><link=%s>%s</link></u></color>", slot3, slot2.id, slot1)
	end

	return string.format("<color=%s>%s</color>", slot3, slot1)
end

function slot0.addLinkCb1(slot0)
	return uv0("[%s]", slot0)
end

function slot0.addLinkCb2(slot0)
	return uv0("【%s】", slot0)
end

function slot0.addNumColor(slot0, slot1)
	return slot0:revertRichText(string.gsub(slot0:filterRichText(slot1), "[+-]?[%d%./%%]+", SkillHelper.getColorFormat("#deaa79", "%1")))
end

function slot0.replaceColorFunc(slot0)
	if string.find(slot0, "[<>]") then
		return slot0
	end
end

slot0.richTextList = {}
slot0.replaceText = "▩replace▩"
slot0.replaceIndex = 0

function slot0.filterRichText(slot0, slot1)
	tabletool.clear(uv0.richTextList)

	return string.gsub(slot1, "(<.->)", slot0._filterRichText)
end

function slot0._filterRichText(slot0)
	table.insert(uv0.richTextList, slot0)

	return uv0.replaceText
end

function slot0.revertRichText(slot0, slot1)
	uv0.replaceIndex = 0

	tabletool.clear(uv0.richTextList)

	return string.gsub(slot1, uv0.replaceText, slot0._revertRichText)
end

function slot0._revertRichText(slot0)
	uv0.replaceIndex = uv0.replaceIndex + 1

	return uv0.richTextList[uv0.replaceIndex] or ""
end

function slot0._onHyperLinkClick(slot0, slot1, slot2)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if not (string.match(slot1, "skillIndex=(%d)") and tonumber(slot3)) then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(slot1), slot0._buffTipAnchor or CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif slot3 == 0 then
		ViewMgr.instance:openView(ViewName.Act191CharacterTipView, {
			tag = "passiveskill",
			id = slot0._config.id,
			tipPos = Vector2.New(-292, -51.1),
			anchorParams = {
				Vector2.New(1, 0.5),
				Vector2.New(1, 0.5)
			},
			buffTipsX = -776
		})
	else
		ViewMgr.instance:openView(ViewName.SkillTipView, {
			super = slot3 == 3,
			skillIdList = Activity191Config.instance:getHeroSkillIdDic(slot0._config.id)[slot3],
			monsterName = slot0._config.name,
			heroId = slot0._config.roleId,
			anchorX = slot0._skillTipAnchorX
		})
	end
end

return slot0
