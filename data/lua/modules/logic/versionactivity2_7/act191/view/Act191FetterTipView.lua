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
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)

	slot0.tag = slot0.viewParam.tag
	slot0.fetterCoList = Activity191Config.instance:getRelationCoList(slot0.tag)
	slot1 = slot0.fetterCoList[0]
	slot0._txtName.text = slot1.name
	slot0._txtDesc.text = slot1.desc

	Activity191Helper.setFetterIcon(slot0._imageIcon, slot1.icon)

	if slot0.viewParam.isFight then
		slot0.activeCnt = slot0.viewParam.count or 0

		for slot5, slot6 in ipairs(slot0.fetterCoList) do
			if slot6.activeNum <= slot0.self.activeCnt then
				gohelper.findChildText(gohelper.cloneInPlace(slot0._goFetterDesc), "").text = string.format("<color=#9c8052>（%d/%d）%s</color>", slot0.activeCnt, slot6.activeNum, slot6.desc)
			else
				slot8.text = string.format("（<color=#ad2319>%d</color>/%d）%s", slot0.activeCnt, slot6.activeNum, slot6.desc)
			end

			slot0:_fixHeight(slot8)
		end

		gohelper.setActive(slot0._goFetterDesc, false)
		gohelper.setActive(slot0._scrollHeros, false)

		return
	end

	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if slot0.viewParam.isPreview then
		for slot5, slot6 in ipairs(slot0.fetterCoList) do
			slot8 = gohelper.findChildText(gohelper.cloneInPlace(slot0._goFetterDesc), "")
			slot8.text = string.format("<color=#9c8052>（%d）%s</color>", slot6.activeNum, slot6.desc)

			slot0:_fixHeight(slot8)
		end

		slot0.fetterHeroList = Activity191Config.instance:getFetterHeroList(slot0.tag)
	elseif slot0.viewParam.isEnemy then
		slot2 = slot0.gameInfo:getNodeDetailMo().matchInfo
		slot0.fetterHeroList = slot2:getFetterHeroList(slot0.tag)
		slot0.activeCnt = slot2:getTeamFetterCntDic()[slot0.tag] or 0

		for slot7, slot8 in ipairs(slot0.fetterCoList) do
			if slot8.activeNum <= slot0.activeCnt then
				gohelper.findChildText(gohelper.cloneInPlace(slot0._goFetterDesc), "").text = string.format("<color=#9c8052>（%d/%d）%s</color>", slot0.activeCnt, slot8.activeNum, slot8.desc)
			else
				slot10.text = string.format("（<color=#ad2319>%d</color>/%d）%s", slot0.activeCnt, slot8.activeNum, slot8.desc)
			end

			slot0:_fixHeight(slot10)
		end
	else
		slot0.fetterHeroList = slot0.gameInfo:getFetterHeroList(slot0.tag)
		slot0.activeCnt = slot0.gameInfo:getTeamFetterCntDic()[slot0.tag] or 0

		for slot6, slot7 in ipairs(slot0.fetterCoList) do
			if slot7.activeNum <= slot0.activeCnt then
				gohelper.findChildText(gohelper.cloneInPlace(slot0._goFetterDesc), "").text = string.format("<color=#9c8052>（%d/%d）%s</color>", slot0.activeCnt, slot7.activeNum, slot7.desc)
			else
				slot9.text = string.format("（<color=#ad2319>%d</color>/%d）%s", slot0.activeCnt, slot7.activeNum, slot7.desc)
			end

			slot0:_fixHeight(slot9)
		end
	end

	gohelper.setActive(slot0._goFetterDesc, false)
	slot0:refreshHeroHead()
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose(), slot0.fetterCoList[0].name)
end

function slot0.refreshHeroHead(slot0)
	for slot4, slot5 in ipairs(slot0.fetterHeroList) do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, gohelper.cloneInPlace(slot0._goHeroItem)), Act191HeroHeadItem)

		slot8:setFetterEnable(false)
		slot8:setData(nil, slot5.config.id)
		slot8:setClickEnable(false)

		if slot5.inBag == 0 then
			slot8:setNotOwn()
		elseif slot5.inBag == 2 then
			slot8:setActivation(true)
		end
	end

	slot0._scrollHeros.horizontalNormalizedPosition = 0

	gohelper.setActive(slot0._goHeroItem, false)
end

function slot0._fixHeight(slot0, slot1)
	MonoHelper.addNoUpdateLuaComOnceToGo(slot1.gameObject, FixTmpBreakLine):refreshTmpContent(slot1)
end

return slot0
