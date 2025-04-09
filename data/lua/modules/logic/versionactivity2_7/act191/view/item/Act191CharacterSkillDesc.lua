module("modules.logic.versionactivity2_7.act191.view.item.Act191CharacterSkillDesc", package.seeall)

slot0 = class("Act191CharacterSkillDesc", BaseChildView)

function slot0.onInitView(slot0)
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "#txt_skillevel")
	slot0._goCurlevel = gohelper.findChild(slot0.viewGO, "#go_curlevel")
	slot0._txtskillDesc = gohelper.findChildText(slot0.viewGO, "#txt_descripte")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.canvasGroup = gohelper.onceAddComponent(slot0._txtskillDesc.gameObject, gohelper.Type_CanvasGroup)
	slot0.txtlvcanvasGroup = gohelper.onceAddComponent(slot0._txtlv.gameObject, gohelper.Type_CanvasGroup)
	slot0.govx = gohelper.findChild(slot0.viewGO, "vx")

	gohelper.setActive(slot0.govx, false)

	slot0.vxAni = slot0.govx:GetComponent(typeof(UnityEngine.Animation))
	slot0.aniLength = slot0.vxAni.clip.length
end

function slot0.onUpdateParam(slot0)
end

function slot0.updateInfo(slot0, slot1, slot2, slot3)
	slot0.config = slot2
	slot0.parentView = slot1
	slot0._txtlv.text = slot3
	slot0._needUseSkillEffDescList = {}
	slot0._needUseSkillEffDescList2 = {}
	slot6, slot7, slot0._skillIndex = Activity191Config.instance:getExSkillDesc(Activity191Config.instance:getHeroLevelExSkillCo(slot0.config.id, slot3), slot0.config.id)
	slot6 = string.gsub(SkillHelper.addBracketColor(slot0:addNumColor(SkillHelper.addLink(string.gsub(slot6, "▩(%d)%%s", "CharacterSkillDescripte_skillNameDesc"))), "#7e99d0"), "CharacterSkillDescripte_skillNameDesc", slot0:_buildSkillNameLinkTag(slot7))

	gohelper.setActive(slot0._goCurlevel, false)

	slot0.canvasGroup.alpha = slot0.config.exLevel < slot3 and 0.5 or 1
	slot0.txtlvcanvasGroup.alpha = slot4 < slot3 and 0.5 or 1
	slot0._hyperLinkClick = slot0._txtskillDesc:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick:SetClickListener(slot0._onHyperLinkClick, slot0)

	slot10 = GameUtil.getTextHeightByLine(slot0._txtskillDesc, slot6, 28, -3) + 54

	recthelper.setHeight(slot0.viewGO.transform, slot10)

	slot0._txtskillDesc.text = slot6
	slot0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._txtskillDesc.gameObject, FixTmpBreakLine)

	slot0._fixTmpBreakLine:refreshTmpContent(slot0._txtskillDesc)

	return slot10
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

	if slot1 ~= "skillIndex" then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(slot1), CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif slot0._skillIndex == 0 then
		ViewMgr.instance:openView(ViewName.Act191CharacterTipView, {
			id = slot0.config.id,
			tipPos = Vector2.New(-292, -51.1),
			anchorParams = {
				Vector2.New(1, 0.5),
				Vector2.New(1, 0.5)
			},
			buffTipsX = -776
		})
	else
		ViewMgr.instance:openView(ViewName.SkillTipView, {
			super = slot0._skillIndex == 3,
			skillIdList = Activity191Config.instance:getHeroSkillIdDic(slot0.config.id)[slot0._skillIndex],
			monsterName = slot0.config.name,
			heroId = slot0.config.roleId,
			skillIndex = slot0._skillIndex
		})
	end
end

function slot0._buildSkillNameLinkTag(slot0, slot1)
	return string.format("<link=\"skillIndex\"><color=#7e99d0>【%s】</color></link>", slot1)
end

function slot0.playHeroExSkillUPAnimation(slot0)
	gohelper.setActive(slot0.govx, true)
	TaskDispatcher.runDelay(slot0.onAnimationDone, slot0, slot0.aniLength)
end

function slot0.onAnimationDone(slot0)
	gohelper.setActive(slot0.govx, false)
end

function slot0.jumpAnimation(slot0)
	slot1 = 0.782608695652174

	TaskDispatcher.cancelTask(slot0.onAnimationDone, slot0)
	TaskDispatcher.runDelay(slot0.onAnimationDone, slot0, slot0.aniLength * (1 - slot1))
	ZProj.GameHelper.SetAnimationStateNormalizedTime(slot0.vxAni, "item_vx_in", slot1)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.onAnimationDone, slot0)
	slot0.vxAni:Stop()
end

function slot0.onDestroyView(slot0)
end

return slot0
