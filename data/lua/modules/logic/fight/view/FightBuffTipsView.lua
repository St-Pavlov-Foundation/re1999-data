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

	slot1 = FightDataHelper.entityMgr:getById(slot0.viewParam)

	slot0:_updateBuffs(slot1)
	recthelper.setAnchorX(slot0._gobuffinfocontainer.transform, slot1.side == FightEnum.EntitySide.MySide and 207 or -161)
end

function slot0._updateBuffs(slot0, slot1)
	uv0.updateBuffDesc(slot1, slot0._buffItemList, slot0._gobuffitem, slot0, slot0.getCommonBuffTipScrollAnchor)
end

function slot0.getCommonBuffTipScrollAnchor(slot0, slot1, slot2)
	slot3 = CameraMgr.instance:getUICamera()
	slot2.pivot = CommonBuffTipEnum.Pivot.Right
	slot4, slot5 = recthelper.worldPosToAnchorPos2(slot0.rectTrScrollBuff.position, slot1, slot3, slot3)

	recthelper.setAnchor(slot2, slot4 - recthelper.getWidth(slot0.rectTrScrollBuff) / 2, slot5 + recthelper.getHeight(slot0.rectTrScrollBuff) / 2)
end

slot0.filterTypeKey = {
	[2.0] = true
}

function slot0.updateBuffDesc(slot0, slot1, slot2, slot3, slot4)
	slot5 = FightBuffHelper.filterBuffType(tabletool.copy(slot0 and slot0:getBuffList() or {}), uv0.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(slot5)
	table.sort(slot5, function (slot0, slot1)
		if slot0.time ~= slot1.time then
			return slot0.time < slot1.time
		end

		return slot0.id < slot1.id
	end)

	for slot9, slot10 in ipairs(slot1) do
		gohelper.setActive(slot10.go, false)
	end

	slot6 = slot5 and #slot5 or 0
	slot7 = 0

	for slot11 = 1, slot6 do
		if lua_skill_buff.configDict[slot5[slot11].buffId] and slot13.isNoShow == 0 then
			slot14 = lua_skill_bufftype.configDict[slot13.typeId]

			if not slot1[slot7 + 1] then
				slot15 = slot3:getUserDataTb_()
				slot15.go = gohelper.cloneInPlace(slot2, "buff" .. slot7)
				slot15.getAnchorFunc = slot4
				slot15.viewClass = slot3

				table.insert(slot1, slot15)
			end

			slot16 = slot15.go

			gohelper.setActive(slot16, true)
			uv0.showBuffTime(gohelper.findChildText(slot16, "title/txt_time"), slot12, slot13, slot0)

			slot18 = gohelper.findChildText(slot16, "txt_desc")

			SkillHelper.addHyperLinkClick(slot18, uv0.onClickBuffHyperLink, slot15)

			gohelper.findChildText(slot16, "title/txt_name").text = slot13.name
			slot19 = FightBuffGetDescHelper.getBuffDesc(slot12)

			recthelper.setHeight(slot16.transform, GameUtil.getTextHeightByLine(slot18, slot19, 52.1) + 62)

			slot18.text = slot19

			if gohelper.findChildImage(slot16, "title/simage_icon") then
				UISpriteSetMgr.instance:setBuffSprite(slot21, slot13.iconId)
			end

			slot22 = gohelper.findChild(slot16, "txt_desc/image_line")
			slot23 = gohelper.findChild(slot16, "title/txt_name/go_tag")

			if lua_skill_buff_desc.configDict[slot14.type] then
				gohelper.findChildText(slot16, "title/txt_name/go_tag/bg/txt_tagname").text = slot25.name
			end

			gohelper.setActive(slot23, slot25)
			gohelper.setActive(slot22, slot7 ~= slot6)

			slot3._scrollbuff.verticalNormalizedPosition = 1
		end
	end
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
