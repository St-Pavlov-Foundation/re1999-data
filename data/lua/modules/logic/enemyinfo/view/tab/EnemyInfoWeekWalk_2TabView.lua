module("modules.logic.enemyinfo.view.tab.EnemyInfoWeekWalk_2TabView", package.seeall)

slot0 = class("EnemyInfoWeekWalk_2TabView", UserDataDispose)

function slot0.onInitView(slot0)
	slot0.goweekwalktab = gohelper.findChild(slot0.viewGO, "#go_tab_container/#go_weekwalkhearttab")
	slot0.simagebattlelistbg = gohelper.findChildSingleImage(slot0.goweekwalktab, "#simage_battlelistbg")
	slot0.gobattleitem = gohelper.findChild(slot0.goweekwalktab, "scroll_battle/Viewport/battlelist/#go_battlebtntemplate")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0.gobattleitem, false)
end

function slot0.onOpen(slot0)
	slot0._mapId = slot0.viewParam.mapId
	slot3 = WeekWalk_2Model.instance:getInfo():getLayerInfo(slot0._mapId).battleIds
	slot4 = slot0.viewParam.selectBattleId or slot3[1]
	slot0._battleIds = slot3
	slot0._btnList = {}
	slot0._statusList = {}

	for slot11 = 1, math.min(5, #slot2.battleInfos) do
		slot13 = gohelper.cloneInPlace(slot0.gobattleitem).gameObject
		slot14 = gohelper.findChildButton(slot13, "btn")
		gohelper.findChildText(slot13, "txt").text = "0" .. slot11
		slot19 = gohelper.findChild(slot13, "star2")
		slot20 = gohelper.findChild(slot13, "star3")

		gohelper.setActive(slot19, false)
		gohelper.setActive(slot20, false)
		gohelper.setActive(WeekWalk_2Enum.MaxStar <= 2 and slot19 or slot20, true)

		slot24 = {
			gohelper.findChild(slot13, "selectIcon"),
			slot15
		}

		for slot28 = 1, slot21.transform.childCount do
			slot30 = slot22:GetChild(slot28 - 1):GetComponentInChildren(gohelper.Type_Image)
			slot30.enabled = false

			WeekWalk_2Helper.setCupEffect(slot0.tabParentView:getResInst(slot0.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot30.gameObject), slot2:getBattleInfoByBattleId(slot3[slot11]):getCupInfo(slot28))
			table.insert(slot24, slot30)
		end

		slot14:AddClickListener(slot0.selectBattleId, slot0, slot17)
		gohelper.setActive(slot13, true)
		table.insert(slot0._statusList, slot24)
		table.insert(slot0._btnList, slot14)
	end

	gohelper.setActive(slot0.goweekwalktab, true)
	slot0.enemyInfoMo:setShowLeftTab(true)
	slot0:selectBattleId(slot4)
end

function slot0.selectBattleId(slot0, slot1)
	slot0.enemyInfoMo:updateBattleId(slot1)

	if not slot0._statusList then
		return
	end

	for slot5, slot6 in ipairs(slot0._battleIds) do
		slot7 = slot6 == slot1

		if not slot0._statusList[slot5] then
			break
		end

		gohelper.setActive(slot8[1], slot7)

		if slot7 then
			SLFramework.UGUI.GuiHelper.SetColor(slot8[2], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(slot8[3], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(slot8[4], "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot8[2], "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(slot8[3], "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(slot8[4], "#C1C5B6")
		end

		if slot8[5] then
			SLFramework.UGUI.GuiHelper.SetColor(slot8[5], slot7 and "#FFFFFF" or "#C1C5B6")
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.simagebattlelistbg:UnLoadImage()

	if slot0._btnList then
		for slot4, slot5 in ipairs(slot0._btnList) do
			slot5:RemoveClickListener()
		end
	end
end

return slot0
