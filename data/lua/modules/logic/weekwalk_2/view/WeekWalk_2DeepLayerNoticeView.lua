module("modules.logic.weekwalk_2.view.WeekWalk_2DeepLayerNoticeView", package.seeall)

slot0 = class("WeekWalk_2DeepLayerNoticeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._txtlastprogress = gohelper.findChildText(slot0.viewGO, "rule/#txt_lastprogress")
	slot0._txtlastprogress2 = gohelper.findChildText(slot0.viewGO, "rule/#txt_lastprogress2")
	slot0._imageruleicon = gohelper.findChildImage(slot0.viewGO, "rule/ruleinfo/#image_ruleicon")
	slot0._imageruletag = gohelper.findChildImage(slot0.viewGO, "rule/ruleinfo/#image_ruletag")
	slot0._txtruledesc = gohelper.findChildText(slot0.viewGO, "rule/ruleinfo/#txt_ruledesc")
	slot0._simageruledescicon = gohelper.findChildSingleImage(slot0.viewGO, "rule/ruleinfo/mask/#simage_ruledescicon")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "rewards/#scroll_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "rewards/#scroll_rewards/Viewport/Content/#go_rewarditem")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "rule/ruleinfo/ScrollView/Viewport/Content/#go_ruleitem")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "rewards/#btn_start")
	slot0._btnruledetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "rule/ruleinfo/#btn_ruledetail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnruledetail:AddClickListener(slot0._btnruledetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnruledetail:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnstartOnClick(slot0)
	slot0:openWeekWalkView()
end

function slot0._btnruledetailOnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2RuleView()
end

function slot0.openWeekWalkView(slot0)
	module_views_preloader.WeekWalk_2HeartLayerViewPreload(function ()
		uv0:delayOpenWeekWalkView()
	end)
end

function slot0.delayOpenWeekWalkView(slot0)
	slot0:closeThis()
	WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView()
end

function slot0._editableInitView(slot0)
	slot0._info = WeekWalk_2Model.instance:getInfo()

	if slot0._info.isPopSettle then
		slot0._info.isPopSettle = false

		Weekwalk_2Rpc.instance:sendWeekwalkVer2MarkPreSettleRequest()
	end

	slot0._simagebg1:LoadImage(ResUrl.getWeekWalkBg("full/beijing_shen.jpg"))
	slot0._simagemask:LoadImage(ResUrl.getWeekWalkBg("zhezhao.png"))
	slot0._simagebg2:LoadImage(ResUrl.getWeekWalkBg("shenmian_tcdi.png"))
end

function slot0.onUpdateParam(slot0)
end

function slot0._getRewardList()
	slot0 = {}

	for slot4, slot5 in ipairs(lua_task_weekwalk_ver2.configList) do
		if slot5.minTypeId == WeekWalk_2Enum.TaskType.Season and WeekWalk_2TaskListModel.instance:checkPeriods(slot5) then
			slot10 = "#"

			for slot10, slot11 in ipairs(GameUtil.splitString2(slot5.bonus, true, "|", slot10)) do
				slot14 = slot11[3]

				if not slot0[string.format("%s_%s", slot11[1], slot11[2])] then
					slot0[slot15] = slot11
				else
					slot16[3] = slot16[3] + slot14
					slot0[slot15] = slot16
				end
			end
		end
	end

	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		table.insert(slot1, slot6)
	end

	table.sort(slot1, DungeonWeekWalkView._sort)

	return slot1
end

function slot0._showRewardList(slot0)
	for slot5, slot6 in ipairs(uv0._getRewardList()) do
		slot7 = gohelper.cloneInPlace(slot0._gorewarditem)

		gohelper.setActive(slot7, true)

		slot8 = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot7, "go_item"))

		slot8:setMOValue(slot6[1], slot6[2], slot6[3])
		slot8:isShowCount(true)
		slot8:setCountFontSize(31)
	end
end

function slot0.onOpen(slot0)
	if slot0.viewParam and slot0.viewParam.openFromGuide then
		gohelper.findChildText(slot0.viewGO, "rule/resettip").text = luaLang("p_weekwalkdeeplayernoticeview_title_open")

		recthelper.setAnchorY(gohelper.findChild(slot0.viewGO, "rewards").transform, -208)
		gohelper.setActive(slot0._txtlastprogress, false)
	end

	slot3 = slot0._info.prevSettle and slot2.maxLayerId
	slot4 = slot2 and slot2.maxBattleIndex

	if slot3 and lua_weekwalk_ver2.configDict[slot3] and slot4 then
		slot0._txtlastprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkdeeplayernoticeview_lastprogress"), {
			lua_weekwalk_ver2_scene.configDict[slot5.sceneId].name,
			"0" .. (slot4 or 1)
		})
	else
		slot0._txtlastprogress.text = luaLang("weekwalkdeeplayernoticeview_noprogress")
	end

	slot0._txtlastprogress2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("weekwalk_2resulttxt1"), slot2 and slot2:getTotalPlatinumCupNum() or 0)

	slot0:_showRewardList()

	slot10 = nil

	slot0._simageruledescicon:LoadImage((not (lua_weekwalk_ver2_time.configDict[slot0._info.issueId].isCn == 1) or ResUrl.getWeekWalkIconLangPath(slot8.ruleIcon)) and ResUrl.getWeekWalkBg("rule/" .. slot8.ruleIcon .. ".png"))

	if not string.nilorempty(slot8.ruleFront) then
		tabletool.addValues({}, GameUtil.splitString2(slot8.ruleFront, true, "|", "#"))
	end

	if not string.nilorempty(slot8.ruleRear) then
		tabletool.addValues(slot11, GameUtil.splitString2(slot8.ruleRear, true, "|", "#"))
	end

	slot0._ruleList = slot11

	for slot15, slot16 in ipairs(slot11) do
		slot0:_setRuleDescItem(lua_rule.configDict[slot16[2]], slot16[1])
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_installation_open)
end

function slot0._setRuleDescItem(slot0, slot1, slot2)
	slot3 = {
		"#6384E5",
		"#D05B4C",
		"#C7b376"
	}
	slot4 = gohelper.cloneInPlace(slot0._goruleitem)

	gohelper.setActive(slot4, true)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot4, "icon"), slot1.icon)

	slot6 = gohelper.findChild(slot4, "line")

	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot4, "tag"), "wz_" .. slot2)

	gohelper.findChildText(slot4, "desc").text = string.format("<color=%s>[%s]</color>%s%s", slot3[slot2], luaLang("dungeon_add_rule_target_" .. slot2), string.gsub(slot1.desc, "%【(.-)%】", "<color=#FF906A>[%1]</color>"), "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(slot1.desc, slot3[1]))
end

function slot0.onClose(slot0)
	slot0._simageruledescicon:UnLoadImage()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_close)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
