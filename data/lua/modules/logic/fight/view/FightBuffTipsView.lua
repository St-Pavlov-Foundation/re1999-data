module("modules.logic.fight.view.FightBuffTipsView", package.seeall)

slot0 = class("FightBuffTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobuffinfocontainer = gohelper.findChild(slot0.viewGO, "root/#go_buffinfocontainer/buff")
	slot0._scrollbuff = gohelper.findChildScrollRect(slot0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	slot0._gobuffitem = gohelper.findChild(slot0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	slot0._btnclosebuffinfocontainer = gohelper.findChildButton(slot0.viewGO, "root/#go_buffinfocontainer/#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosebuffinfocontainer:AddClickListener(slot0._onCloseBuffInfoContainer, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosebuffinfocontainer:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0.rectTrScrollBuff = slot0._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrBuffContent = gohelper.findChildComponent(slot0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(slot0._gobuffitem, false)

	slot0._buffItemList = {}
end

function slot0._onCloseBuffInfoContainer(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "root/tips"), true)
	slot0:_updateBuffs(FightDataHelper.entityMgr:getById(slot0.viewParam.entityId or slot0.viewParam))

	if slot0.viewParam.viewname and slot0.viewParam.viewname == "FightView" then
		slot0:_setPos(slot1)
	else
		recthelper.setAnchorX(slot0._gobuffinfocontainer.transform, slot1.side == FightEnum.EntitySide.MySide and 207 or -161)
	end
end

function slot0._setPos(slot0, slot1)
	slot0.enemyBuffTipPosY = 80
	slot5 = recthelper.rectToRelativeAnchorPos(slot0.viewParam.iconPos, slot0._gobuffinfocontainer.transform.parent)
	slot6 = recthelper.getWidth(slot0._scrollbuff.transform)
	slot7 = recthelper.getHeight(slot0._scrollbuff.transform)
	slot8 = 0
	slot9 = 0

	if slot1.side == FightEnum.EntitySide.MySide then
		slot8 = slot5.x - slot0.viewParam.offsetX
		slot9 = slot5.y + slot0.viewParam.offsetY
	else
		slot8 = slot5.x + slot3
		slot9 = slot0.enemyBuffTipPosY
	end

	slot10 = UnityEngine.Screen.width * 0.5
	slot11 = 10
	slot12 = {
		min = -slot10 + slot6 + slot11,
		max = slot10 - slot6 - slot11
	}

	recthelper.setAnchor(slot0._gobuffinfocontainer.transform, GameUtil.clamp(slot8, slot12.min, slot12.max), slot9)
end

function slot0._updateBuffs(slot0, slot1)
	slot0:updateBuffDesc(slot1, slot0._buffItemList, slot0._gobuffitem, slot0, slot0.getCommonBuffTipScrollAnchor)
end

slot0.Interval = 10

function slot0.getCommonBuffTipScrollAnchor(slot0, slot1, slot2)
	slot5 = slot0.rectTrScrollBuff
	slot7, slot8 = recthelper.uiPosToScreenPos2(slot5)
	slot9, slot10 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(slot7, slot8, slot1, CameraMgr.instance:getUICamera(), nil, )
	slot2.pivot = CommonBuffTipEnum.Pivot.Right
	slot15 = slot9

	recthelper.setAnchor(slot2, recthelper.getWidth(slot2) <= GameUtil.getViewSize() / 2 + slot9 - recthelper.getWidth(slot5) / 2 - uv0.Interval and slot15 - slot11 - uv0.Interval or slot15 + slot11 + uv0.Interval + slot13, slot10 + math.min(recthelper.getHeight(slot5), recthelper.getHeight(slot0.rectTrBuffContent)) / 2)
end

slot0.filterTypeKey = {
	[2.0] = true
}
slot1 = 635
slot2 = 597
slot3 = 300

function slot0.updateBuffDesc(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = FightBuffHelper.filterBuffType(tabletool.copy(slot1 and slot1:getBuffList() or {}), uv0.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(slot6)
	table.sort(slot6, function (slot0, slot1)
		if slot0.time ~= slot1.time then
			return slot0.time < slot1.time
		end

		return slot0.id < slot1.id
	end)

	for slot10, slot11 in ipairs(slot2) do
		gohelper.setActive(slot11.go, false)
	end

	slot7 = slot6 and #slot6 or 0
	slot8 = 0
	slot9 = -1
	slot10 = uv1
	slot11 = uv2
	slot12 = {}

	for slot16 = 1, slot7 do
		if lua_skill_buff.configDict[slot6[slot16].buffId] and slot18.isNoShow == 0 then
			slot19 = lua_skill_bufftype.configDict[slot18.typeId]

			if not slot2[slot8 + 1] then
				slot20 = slot4:getUserDataTb_()
				slot20.go = gohelper.cloneInPlace(slot3, "buff" .. slot8)
				slot20.getAnchorFunc = slot5
				slot20.viewClass = slot4

				table.insert(slot2, slot20)
			end

			slot21 = slot20.go

			gohelper.setActive(slot21, true)
			uv0.showBuffTime(gohelper.findChildText(slot21, "title/txt_time"), slot17, slot18, slot1)

			slot23 = gohelper.findChildText(slot21, "txt_desc")

			SkillHelper.addHyperLinkClick(slot23, uv0.onClickBuffHyperLink, slot20)

			slot24 = gohelper.findChildText(slot21, "title/txt_name")
			slot24.text = slot18.name
			slot25 = slot24.preferredWidth
			slot26 = FightBuffGetDescHelper.getBuffDesc(slot17)

			recthelper.setHeight(slot21.transform, GameUtil.getTextHeightByLine(slot23, slot26, 52.1) + 62)

			slot23.text = slot26

			if gohelper.findChildImage(slot21, "title/simage_icon") then
				UISpriteSetMgr.instance:setBuffSprite(slot28, slot18.iconId)
			end

			slot29 = gohelper.findChild(slot21, "txt_desc/image_line")
			slot30 = gohelper.findChild(slot21, "title/txt_name/go_tag")
			slot31 = gohelper.findChildText(slot21, "title/txt_name/go_tag/bg/txt_tagname")

			if lua_skill_buff_desc.configDict[slot19.type] then
				slot31.text = slot32.name
				slot25 = slot25 + slot31.preferredWidth
			end

			gohelper.setActive(slot30, slot32)
			gohelper.setActive(slot29, slot8 ~= slot7)

			slot4._scrollbuff.verticalNormalizedPosition = 1
			slot12[#slot12 + 1] = slot23.transform
			slot12[#slot12 + 1] = gohelper.findChild(slot21, "title").transform
			slot12[#slot12 + 1] = slot21.transform
			slot12[#slot12 + 1] = slot23
			slot12[#slot12 + 1] = slot17

			if uv3 < slot25 then
				slot38 = uv2 + slot25 - uv3
				slot10 = math.max(slot10, slot38)
				slot11 = math.max(slot11, slot38)
			end
		end
	end

	if #slot12 > 0 then
		for slot16 = 0, #slot12 - 1, 5 do
			slot19 = slot12[slot16 + 3]
			slot20 = slot12[slot16 + 4]

			recthelper.setWidth(slot12[slot16 + 2], slot11 - 10)
			recthelper.setWidth(slot12[slot16 + 1], slot11 - 46)
			ZProj.UGUIHelper.RebuildLayout(slot19)
			recthelper.setWidth(slot19, slot11)

			slot20.text = FightBuffGetDescHelper.getBuffDesc(slot12[slot16 + 5])
			slot20.text = slot20.text

			recthelper.setHeight(slot19, slot20.preferredHeight + 52.1 + 10)
		end
	end

	for slot16 in pairs(slot12) do
		rawset(slot12, slot16, nil)
	end

	slot12 = nil

	ZProj.UGUIHelper.RebuildLayout(slot0.rectTrBuffContent)
end

function slot0.onClickBuffHyperLink(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(slot1, slot0.getAnchorFunc, slot0.viewClass)
end

function slot0.showBuffTime(slot0, slot1, slot2, slot3)
	if FightBuffHelper.isCountContinueChanelBuff(slot1) then
		slot0.text = string.format(luaLang("enemytip_buff_time"), slot1.exInfo)

		return
	end

	if slot1 and FightConfig.instance:hasBuffFeature(slot1.buffId, FightEnum.BuffFeature.CountUseSelfSkillContinueChannel) then
		slot0.text = string.format(luaLang("enemytip_buff_time"), slot1.exInfo)

		return
	end

	if FightBuffHelper.isDuduBoneContinueChannelBuff(slot1) then
		slot0.text = string.format(luaLang("buff_tip_duration"), slot1.exInfo)

		return
	end

	if FightBuffHelper.isDeadlyPoisonBuff(slot1) then
		slot0.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("buff_tip_round_and_layer"), slot1.duration, FightSkillBuffMgr.instance:getStackedCount(slot1.entityId, slot1))

		return
	end

	slot4 = lua_skill_bufftype.configDict[slot2.typeId]
	slot5, slot6 = FightSkillBuffMgr.instance:buffIsStackerBuff(slot2)

	if slot5 then
		if slot6 == FightEnum.BuffIncludeTypes.Stacked12 then
			slot0.text = string.format(luaLang("enemytip_buff_stacked_count"), FightSkillBuffMgr.instance:getStackedCount(slot3.id, slot1)) .. " " .. string.format(luaLang("enemytip_buff_time"), slot1.duration)
		else
			slot0.text = slot7
		end
	elseif slot1.duration == 0 then
		if slot1.count == 0 then
			slot0.text = luaLang("forever")
		else
			slot7 = slot1.count
			slot8 = "enemytip_buff_count"

			if string.split(slot4 and slot4.includeTypes or "", "#")[1] == "11" then
				slot8 = "enemytip_buff_stacked_count"
				slot7 = slot1.layer
			end

			slot0.text = string.format(luaLang(slot8), slot7)
		end
	elseif slot1.count == 0 then
		slot0.text = string.format(luaLang("enemytip_buff_time"), slot1.duration)
	else
		slot7 = slot1.count
		slot8 = "round_or_times"

		if string.split(slot4 and slot4.includeTypes or "", "#")[1] == "11" then
			slot8 = "round_or_stacked_count"
			slot7 = slot1.layer
		end

		slot0.text = GameUtil.getSubPlaceholderLuaLang(luaLang(slot8), {
			slot1.duration,
			slot7
		})
	end
end

return slot0
