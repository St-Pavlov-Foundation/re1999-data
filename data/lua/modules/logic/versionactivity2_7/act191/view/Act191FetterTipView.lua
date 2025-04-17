module("modules.logic.versionactivity2_7.act191.view.Act191FetterTipView", package.seeall)

slot0 = class("Act191FetterTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "title/#txt_Name")
	slot0._imageIcon = gohelper.findChildImage(slot0.viewGO, "title/#image_Icon")
	slot0._scrollDetails = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_Details")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#scroll_Details/Viewport/Content/#txt_Desc")
	slot0._goFetterDesc = gohelper.findChild(slot0.viewGO, "#scroll_Details/Viewport/Content/#go_FetterDesc")
	slot0._scrollHeros = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_Heros")
	slot0._goHeroItem = gohelper.findChild(slot0.viewGO, "#scroll_Heros/Viewport/Content/#go_HeroItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_panel_close)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	SkillHelper.addHyperLinkClick(slot0._txtDesc, Activity191Helper.clickHyperLinkSkill)
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)

	slot0.activeLvl = 0
	slot0.tag = slot0.viewParam.tag
	slot0.fetterCoList = Activity191Config.instance:getRelationCoList(slot0.tag)
	slot1 = slot0.fetterCoList[0]
	slot0._txtName.text = slot1.name

	Activity191Helper.setFetterIcon(slot0._imageIcon, slot1.icon)

	slot2 = nil

	if slot0.viewParam.isFight then
		slot0.activeCnt = slot0.viewParam.count or 0

		for slot6, slot7 in ipairs(slot0.fetterCoList) do
			SkillHelper.addHyperLinkClick(gohelper.findChildText(gohelper.cloneInPlace(slot0._goFetterDesc), ""))

			slot10 = Activity191Helper.buildDesc(SkillHelper.addLink(slot7.levelDesc), Activity191Enum.HyperLinkPattern.SkillDesc)

			if slot7.activeNum <= slot0.activeCnt then
				if slot0.activeLvl < slot7.level then
					slot0.activeLvl = slot7.level
				end

				slot9.text = string.format("<color=#9c8052>（%d/%d）%s</color>", slot0.activeCnt, slot7.activeNum, slot10)
			else
				slot9.text = string.format("（<color=#ad2319>%d</color>/%d）%s", slot0.activeCnt, slot7.activeNum, slot10)
			end

			slot0:_fixHeight(slot9)
		end

		gohelper.setActive(slot0._goFetterDesc, false)
		gohelper.setActive(slot0._scrollHeros, false)
		recthelper.setHeight(slot0._scrollDetails.gameObject.transform, 647)

		slot0._txtDesc.text = Activity191Helper.buildDesc(SkillHelper.addLink(string.gsub(slot0.fetterCoList[slot0.activeLvl].desc, "（(.-)）", "")), Activity191Enum.HyperLinkPattern.SkillDesc)

		return
	end

	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if slot0.viewParam.isPreview then
		for slot6, slot7 in ipairs(slot0.fetterCoList) do
			slot9 = gohelper.findChildText(gohelper.cloneInPlace(slot0._goFetterDesc), "")

			SkillHelper.addHyperLinkClick(slot9)

			slot9.text = string.format("<color=#9c8052>（%d）%s</color>", slot7.activeNum, Activity191Helper.buildDesc(SkillHelper.addLink(slot7.levelDesc), Activity191Enum.HyperLinkPattern.SkillDesc))

			slot0:_fixHeight(slot9)
		end

		slot0.fetterHeroList = Activity191Config.instance:getFetterHeroList(slot0.tag)
		slot2 = string.gsub(slot0.fetterCoList[0].desc, "（(.-)）", "")
	elseif slot0.viewParam.isEnemy then
		slot3 = slot0.gameInfo:getNodeDetailMo().matchInfo
		slot0.fetterHeroList = slot3:getFetterHeroList(slot0.tag)
		slot0.activeCnt = slot3:getTeamFetterCntDic()[slot0.tag] or 0

		for slot8, slot9 in ipairs(slot0.fetterCoList) do
			SkillHelper.addHyperLinkClick(gohelper.findChildText(gohelper.cloneInPlace(slot0._goFetterDesc), ""))

			slot12 = Activity191Helper.buildDesc(SkillHelper.addLink(slot9.levelDesc), Activity191Enum.HyperLinkPattern.SkillDesc)

			if slot9.activeNum <= slot0.activeCnt then
				if slot0.activeLvl < slot9.level then
					slot0.activeLvl = slot9.level
				end

				slot11.text = string.format("<color=#9c8052>（%d/%d）%s</color>", slot0.activeCnt, slot9.activeNum, slot12)
			else
				slot11.text = string.format("（<color=#ad2319>%d</color>/%d）%s", slot0.activeCnt, slot9.activeNum, slot12)
			end

			slot0:_fixHeight(slot11)
		end

		slot2 = string.gsub(slot0.fetterCoList[0].desc, "（(.-)）", "")
	else
		slot0.fetterHeroList = slot0.gameInfo:getFetterHeroList(slot0.tag)
		slot0.activeCnt = slot0.gameInfo:getTeamFetterCntDic()[slot0.tag] or 0

		for slot7, slot8 in ipairs(slot0.fetterCoList) do
			SkillHelper.addHyperLinkClick(gohelper.findChildText(gohelper.cloneInPlace(slot0._goFetterDesc), ""))

			slot11 = Activity191Helper.buildDesc(SkillHelper.addLink(slot8.levelDesc), Activity191Enum.HyperLinkPattern.SkillDesc)

			if slot8.activeNum <= slot0.activeCnt then
				if slot0.activeLvl < slot8.level then
					slot0.activeLvl = slot8.level
				end

				slot10.text = string.format("<color=#9c8052>（%d/%d）%s</color>", slot0.activeCnt, slot8.activeNum, slot11)
			else
				slot10.text = string.format("（<color=#ad2319>%d</color>/%d）%s", slot0.activeCnt, slot8.activeNum, slot11)
			end

			slot0:_fixHeight(slot10)
		end

		slot6 = false

		if not string.nilorempty(slot0.fetterCoList[slot0.activeLvl].effects) then
			for slot11, slot12 in ipairs(string.splitToNumber(slot0.fetterCoList[slot0.activeLvl].effects, "|")) do
				if slot0.gameInfo:getAct191Effect(slot12) and (not slot13["end"] or slot11 == #slot7) then
					slot2 = GameUtil.getSubPlaceholderLuaLangOneParam(slot4.desc, string.format("%d/%d", slot13.count, slot13.needCount))
					slot6 = true

					break
				end
			end
		end

		if not slot6 then
			slot2 = string.gsub(slot4.desc, "（(.-)）", "")
		end
	end

	slot0._txtDesc.text = Activity191Helper.buildDesc(SkillHelper.addLink(slot2), Activity191Enum.HyperLinkPattern.SkillDesc)

	gohelper.setActive(slot0._goFetterDesc, false)
	slot0:refreshHeroHead()
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose(), slot0.fetterCoList[0].name)
end

function slot0.refreshHeroHead(slot0)
	for slot5, slot6 in ipairs(slot0.fetterHeroList) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, gohelper.cloneInPlace(slot0._goHeroItem)), Act191HeroHeadItem, {
			noClick = true,
			noFetter = true
		}):setData(nil, slot6.config.id)

		if slot6.inBag == 0 then
			slot9:setNotOwn()
		elseif slot6.inBag == 2 then
			slot9:setActivation(true)
		end
	end

	slot0._scrollHeros.horizontalNormalizedPosition = 0

	gohelper.setActive(slot0._goHeroItem, false)
end

function slot0._fixHeight(slot0, slot1)
	MonoHelper.addNoUpdateLuaComOnceToGo(slot1.gameObject, FixTmpBreakLine):refreshTmpContent(slot1)
end

return slot0
