module("modules.logic.character.view.CharacterDataCultureView", package.seeall)

local var_0_0 = class("CharacterDataCultureView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simagecentericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_centericon")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon")
	arg_1_0._simagerighticon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_mask")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "content/scrollview/viewport/content/#go_content")
	arg_1_0._goconversation = gohelper.findChild(arg_1_0.viewGO, "content/scrollview/viewport/content/#go_conversation")
	arg_1_0._gofirst = gohelper.findChild(arg_1_0.viewGO, "content/scrollview/viewport/content/#go_first")
	arg_1_0._txtfirst = gohelper.findChildText(arg_1_0.viewGO, "content/scrollview/viewport/content/#go_first/bg/#txt_first")
	arg_1_0._txtindenthelper = gohelper.findChildText(arg_1_0.viewGO, "content/scrollview/viewport/content/#txt_indenthelper")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/scrollview")
	arg_1_0._txttitle1 = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_title1")
	arg_1_0._txttitle2 = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_title2")
	arg_1_0._txttitleen1 = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_titleen1")
	arg_1_0._txttitleen3 = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_titleen3")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_pic")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/pageicon/#btn_next")
	arg_1_0._btnprevious = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/pageicon/#btn_previous")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "content/#go_mask")
	arg_1_0._goCustomRedIcon = gohelper.findChild(arg_1_0.viewGO, "content/scrollview/viewport/content/#go_customredicon")
	arg_1_0._txtCustomContent = gohelper.findChildText(arg_1_0.viewGO, "content/scrollview/viewport/content/#txt_customcontent")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnprevious:AddClickListener(arg_2_0._btnpreviousOnClick, arg_2_0)
	arg_2_0._scrollview:AddOnValueChanged(arg_2_0._onContentScrollValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnprevious:RemoveClickListener()
	arg_3_0._scrollview:RemoveOnValueChanged()
end

function var_0_0._btnnextOnClick(arg_4_0)
	if arg_4_0._selectIndex and arg_4_0._selectIndex ~= 0 then
		arg_4_0:_itemOnClick(math.max(1, math.min(3, arg_4_0._selectIndex + 1)))
	end
end

function var_0_0._btnpreviousOnClick(arg_5_0)
	if arg_5_0._selectIndex and arg_5_0._selectIndex ~= 0 then
		arg_5_0:_itemOnClick(math.max(1, math.min(3, arg_5_0._selectIndex - 1)))
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_6_0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	arg_6_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_6_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_6_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_6_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))

	arg_6_0._scrollcontent = gohelper.findChild(arg_6_0._scrollview.gameObject, "viewport/content")
	arg_6_0._items = {}

	for iter_6_0 = 1, 3 do
		local var_6_0 = arg_6_0:getUserDataTb_()

		var_6_0.go = gohelper.findChild(arg_6_0.viewGO, "content/container/go_item" .. iter_6_0)
		var_6_0.index = iter_6_0
		var_6_0.gochapteron = gohelper.findChild(var_6_0.go, "go_chapteron")
		var_6_0.gochapteroff = gohelper.findChild(var_6_0.go, "go_chapteroff")
		var_6_0.gotreasurebox = gohelper.findChild(var_6_0.go, "go_treasurebox")
		var_6_0.gochapterunlock = gohelper.findChild(var_6_0.go, "go_chapterunlock")
		var_6_0.txtunlockconditine = gohelper.findChildText(var_6_0.go, "go_chapterunlock/txt_unlockconditine")
		var_6_0.btn = SLFramework.UGUI.UIClickListener.Get(var_6_0.go)

		var_6_0.btn:AddClickListener(arg_6_0._itemOnClick, arg_6_0, var_6_0.index)
		table.insert(arg_6_0._items, var_6_0)
	end

	arg_6_0._txtcontent = arg_6_0._gocontent:GetComponent(typeof(ZProj.CustomTMP))

	arg_6_0._txtcontent:SetOffset(0, -13, false, true)
	arg_6_0._txtcontent:SetSize(5)
	arg_6_0._txtcontent:SetAlignment(0, -2)

	arg_6_0._txtconversation = arg_6_0._goconversation:GetComponent(typeof(ZProj.CustomTMP))

	arg_6_0._txtconversation:SetOffset(0, -13, false, true)
	arg_6_0._txtconversation:SetSize(5)
	arg_6_0._txtconversation:SetAlignment(0, -2)

	arg_6_0._scrollHeight = recthelper.getHeight(arg_6_0._scrollview.transform)

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItemFail, arg_6_0._unlockItemCallbackFail, arg_6_0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItem, arg_6_0._unlockItemCallback, arg_6_0)
end

function var_0_0._itemOnClick(arg_7_0, arg_7_1)
	if arg_7_0._selectIndex == arg_7_1 then
		return
	end

	local var_7_0 = CharacterDataConfig.instance:getCharacterDataCO(arg_7_0._heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, arg_7_1)

	if arg_7_0._items[arg_7_1]._lock then
		local var_7_1 = string.splitToNumber(var_7_0.unlockConditine, "#")
		local var_7_2 = ""

		if var_7_1[1] == CharacterDataConfig.unlockConditionEpisodeID then
			var_7_2 = DungeonConfig.instance:getEpisodeCO(var_7_1[2]).name
		elseif var_7_1[1] == CharacterDataConfig.unlockConditionRankID then
			var_7_2 = {
				var_7_1[2] - 1
			}
		else
			var_7_2 = var_7_1[2]
		end

		GameFacade.showToast(var_7_0.lockText, var_7_2)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Ui_Role_Story_Switch)
		arg_7_0:_refreshSelect(arg_7_1)
		arg_7_0:_refreshDesc(arg_7_1)

		arg_7_0._selectIndex = arg_7_1
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:_refreshUI()
end

function var_0_0.onOpen(arg_9_0)
	gohelper.setActive(arg_9_0.viewGO, true)
	arg_9_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function var_0_0._unlockItemCallback(arg_10_0, arg_10_1, arg_10_2)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if arg_10_2 >= 5 then
		arg_10_0:_refreshSelect(arg_10_0._selectIndex)
	end
end

function var_0_0._unlockItemCallbackFail(arg_11_0)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0._refreshUI(arg_12_0)
	if arg_12_0._heroId and arg_12_0._heroId == CharacterDataModel.instance:getCurHeroId() then
		arg_12_0:_statEnd()
		arg_12_0:_statStart()

		return
	end

	arg_12_0._heroId = CharacterDataModel.instance:getCurHeroId()
	arg_12_0.heroMo = HeroModel.instance:getByHeroId(arg_12_0._heroId)

	arg_12_0:_initInfo()
end

function var_0_0._initInfo(arg_13_0)
	arg_13_0._selectIndex = 0

	for iter_13_0 = 1, 3 do
		local var_13_0 = CharacterDataConfig.instance:getCharacterDataCO(arg_13_0._heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, iter_13_0)
		local var_13_1 = CharacterDataConfig.instance:checkLockCondition(var_13_0)

		gohelper.setActive(arg_13_0._items[iter_13_0].golock, var_13_1)

		arg_13_0._items[iter_13_0]._lock = var_13_1

		if var_13_1 then
			local var_13_2 = string.splitToNumber(var_13_0.unlockConditine, "#")
			local var_13_3 = {}

			if var_13_2[1] == CharacterDataConfig.unlockConditionEpisodeID then
				var_13_3 = {
					DungeonConfig.instance:getEpisodeCO(var_13_2[2]).name
				}
			elseif var_13_2[1] == CharacterDataConfig.unlockConditionRankID then
				var_13_3 = {
					var_13_2[2] - 1
				}
			else
				var_13_3 = {
					var_13_2[2]
				}
			end

			local var_13_4 = ToastConfig.instance:getToastCO(var_13_0.lockText).tips
			local var_13_5 = GameUtil.getSubPlaceholderLuaLang(var_13_4, var_13_3)

			arg_13_0._items[iter_13_0].txtunlockconditine.text = var_13_5
		elseif arg_13_0._selectIndex == 0 then
			arg_13_0._selectIndex = iter_13_0
		end
	end

	gohelper.setActive(arg_13_0._btnnext.gameObject, arg_13_0._selectIndex and arg_13_0._selectIndex ~= 3)
	gohelper.setActive(arg_13_0._btnprevious.gameObject, arg_13_0._selectIndex and arg_13_0._selectIndex ~= 1)
	arg_13_0:_refreshSelect(arg_13_0._selectIndex)
	arg_13_0:_refreshDesc(arg_13_0._selectIndex)
end

function var_0_0._refreshDesc(arg_14_0, arg_14_1)
	arg_14_0:_statEnd()
	arg_14_0:_statStart()

	if arg_14_1 == 0 then
		gohelper.setActive(arg_14_0._scrollview.gameObject, false)
		gohelper.setActive(arg_14_0._txttitle1.gameObject, false)
		gohelper.setActive(arg_14_0._txttitle2.gameObject, false)
		gohelper.setActive(arg_14_0._txttitleen1.gameObject, false)
		gohelper.setActive(arg_14_0._txttitleen3.gameObject, false)
		gohelper.setActive(arg_14_0._txttitleen4.gameObject, false)
		gohelper.setActive(arg_14_0._simagepic.gameObject, false)

		return
	end

	if arg_14_0._items[arg_14_1]._lock then
		return
	end

	arg_14_0._config = CharacterDataConfig.instance:getCharacterDataCO(arg_14_0._heroId, arg_14_0.heroMo.skin, CharacterEnum.CharacterDataItemType.Culture, arg_14_1)

	local var_14_0 = arg_14_0._config.title
	local var_14_1 = not string.nilorempty(var_14_0) and string.split(var_14_0, "\n") or {}

	arg_14_0._txttitle1.text = var_14_1[1] or ""
	arg_14_0._txttitle2.text = var_14_1[2] or ""

	gohelper.setActive(arg_14_0._txttitleen1.gameObject, arg_14_1 ~= 3)
	gohelper.setActive(arg_14_0._txttitleen3.gameObject, arg_14_1 == 3)

	if arg_14_1 == 3 then
		local var_14_2 = HeroConfig.instance:getHeroCO(arg_14_0._heroId)

		arg_14_0._txttitleen3.text = "[UTTU" .. luaLang("multiple") .. tostring(var_14_2.name) .. "]"
	else
		arg_14_0._txttitleen1.text = arg_14_0._config.titleEn
	end

	local var_14_3 = var_14_1[2] and {
		-282.6,
		-134.5
	} or {
		-254,
		-151.3
	}

	recthelper.setAnchor(arg_14_0._txttitle1.transform, var_14_3[1], var_14_3[2])
	recthelper.setAnchorY(arg_14_0._txttitleen1.transform, var_14_1[2] and -216.5 or -181.5)
	gohelper.setActive(arg_14_0._gocontent, arg_14_1 ~= 3 and arg_14_0._config.isCustom ~= 1)
	gohelper.setActive(arg_14_0._gofirst, arg_14_1 ~= 3 and arg_14_0._config.isCustom ~= 1)
	gohelper.setActive(arg_14_0._txtCustomContent.gameObject, arg_14_0._config.isCustom == 1)
	gohelper.setActive(arg_14_0._goconversation, arg_14_1 == 3 and arg_14_0._config.isCustom ~= 1)
	gohelper.setActive(arg_14_0._goCustomRedIcon, false)

	local var_14_4 = arg_14_0._config.text

	if arg_14_1 == 3 then
		local var_14_5 = arg_14_0:_getAfterContent(var_14_4)
		local var_14_6 = GameUtil.getMarkText(var_14_5)
		local var_14_7 = GameUtil.getMarkIndexList(var_14_5)

		arg_14_0._txtconversation:SetText(var_14_6, var_14_7)
	elseif arg_14_0._config.isCustom == 1 then
		arg_14_0._txtCustomContent.text = var_14_4

		TaskDispatcher.runDelay(arg_14_0._setCustomRedIconPos, arg_14_0, 0.01)
	else
		local var_14_8, var_14_9 = arg_14_0:_getFormatStr(var_14_4)
		local var_14_10 = GameUtil.getMarkText(var_14_9)
		local var_14_11 = GameUtil.getMarkIndexList(var_14_9)

		arg_14_0._txtfirst.text = var_14_8

		arg_14_0._txtfirst:ForceMeshUpdate(true, true)
		arg_14_0._txtfirst:GetRenderedValues()
		arg_14_0._txtcontent:SetText(var_14_10, var_14_11)
	end

	arg_14_0._scrollview.verticalNormalizedPosition = 1

	if arg_14_1 == 1 then
		arg_14_0._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu1.png"))
	elseif arg_14_1 == 2 then
		arg_14_0._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu2.png"))
	else
		arg_14_0._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu3.png"))
	end

	gohelper.setActive(arg_14_0._scrollview.gameObject, true)
	gohelper.setActive(arg_14_0._txttitle1.gameObject, true)
	gohelper.setActive(arg_14_0._txttitle2.gameObject, true)
	gohelper.setActive(arg_14_0._simagepic.gameObject, true)
	ZProj.UGUIHelper.RebuildLayout(arg_14_0._scrollcontent.transform)

	arg_14_0._couldScroll = recthelper.getHeight(arg_14_0._scrollcontent.transform) > arg_14_0._scrollHeight and true or false

	gohelper.setActive(arg_14_0._gomask, arg_14_0._couldScroll)
end

function var_0_0._setCustomRedIconPos(arg_15_0)
	gohelper.setActive(arg_15_0._goCustomRedIcon, true)

	local var_15_0 = arg_15_0._txtCustomContent:GetTextInfo(arg_15_0._config.text)
	local var_15_1 = var_15_0.characterInfo[var_15_0.lineInfo[0].firstVisibleCharacterIndex]
	local var_15_2 = var_15_1.bottomLeft
	local var_15_3 = var_15_1.topLeft
	local var_15_4 = var_15_1.bottomRight
	local var_15_5 = var_15_1.topRight
	local var_15_6 = (var_15_2.x + var_15_4.x) * 0.5
	local var_15_7 = (var_15_2.y + var_15_3.y) * 0.5
	local var_15_8 = arg_15_0._txtCustomContent.transform:TransformPoint(var_15_6, var_15_7, 0)

	arg_15_0._goCustomRedIcon.transform.position = var_15_8
end

function var_0_0._refreshSelect(arg_16_0, arg_16_1)
	for iter_16_0 = 1, 3 do
		gohelper.setActive(arg_16_0._items[iter_16_0].gochapteron, false)
		gohelper.setActive(arg_16_0._items[iter_16_0].gochapteroff, false)
		gohelper.setActive(arg_16_0._items[iter_16_0].gotreasurebox, false)
		gohelper.setActive(arg_16_0._items[iter_16_0].gochapterunlock, false)

		local var_16_0 = CharacterDataConfig.instance:getCharacterDataCO(arg_16_0._heroId, arg_16_0.heroMo.skin, CharacterEnum.CharacterDataItemType.Culture, iter_16_0)
		local var_16_1 = iter_16_0 == 3 and 4 + iter_16_0 or 5 + iter_16_0
		local var_16_2 = iter_16_0 == arg_16_1
		local var_16_3 = CharacterDataConfig.instance:checkLockCondition(var_16_0)
		local var_16_4 = HeroModel.instance:checkGetRewards(arg_16_0._heroId, var_16_1)
		local var_16_5 = HeroModel.instance:checkGetRewards(arg_16_0._heroId, 4 + iter_16_0)

		if var_16_2 then
			gohelper.setActive(arg_16_0._items[iter_16_0].gochapteron, true)
			gohelper.setActive(arg_16_0._btnnext.gameObject, arg_16_1 ~= 3 and var_16_4)
			gohelper.setActive(arg_16_0._btnprevious.gameObject, arg_16_1 ~= 1)

			if not var_16_5 and not string.nilorempty(var_16_0.unlockRewards) then
				if var_16_3 then
					local var_16_6 = string.splitToNumber(var_16_0.unlockConditine, "#")
					local var_16_7 = ""

					if var_16_6[1] == CharacterDataConfig.unlockConditionEpisodeID then
						var_16_7 = DungeonConfig.instance:getEpisodeCO(var_16_6[2]).name
					elseif var_16_6[1] == CharacterDataConfig.unlockConditionRankID then
						var_16_7 = var_16_6[2] - 1
					else
						var_16_7 = var_16_6[2]
					end

					GameFacade.showToast(var_16_0.lockText, var_16_7)
				elseif not var_16_5 then
					UIBlockMgr.instance:startBlock("playRewardsAnimtion")
					UIBlockMgrExtend.setNeedCircleMv(false)
					HeroRpc.instance:sendItemUnlockRequest(arg_16_0._heroId, var_16_0.id)
				end
			end
		elseif var_16_3 then
			gohelper.setActive(arg_16_0._items[iter_16_0].gochapterunlock, true)
		elseif var_16_5 or string.nilorempty(var_16_0.unlockRewards) then
			gohelper.setActive(arg_16_0._items[iter_16_0].gochapteroff, true)
		else
			gohelper.setActive(arg_16_0._items[iter_16_0].gotreasurebox, true)
		end
	end
end

function var_0_0.onClose(arg_17_0)
	gohelper.setActive(arg_17_0.viewGO, false)
	arg_17_0:_statEnd()
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simagebg:UnLoadImage()
	arg_18_0._simagecentericon:UnLoadImage()
	arg_18_0._simagelefticon:UnLoadImage()
	arg_18_0._simagerighticon:UnLoadImage()
	arg_18_0._simagerighticon2:UnLoadImage()
	arg_18_0._simagemask:UnLoadImage()

	for iter_18_0 = 1, 3 do
		arg_18_0._items[iter_18_0].btn:RemoveClickListener()
	end

	arg_18_0._simagepic:UnLoadImage()
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItemFail, arg_18_0._unlockItemCallbackFail, arg_18_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItem, arg_18_0._unlockItemCallback, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._setCustomRedIconPos, arg_18_0)
end

function var_0_0._getFormatStr(arg_19_0, arg_19_1)
	if string.nilorempty(arg_19_1) then
		return "", ""
	end

	local var_19_0 = arg_19_1
	local var_19_1 = string.gsub(var_19_0, "<.->", "")
	local var_19_2 = string.trim(var_19_1)
	local var_19_3 = utf8.next(var_19_2, 1)
	local var_19_4 = var_19_2:sub(1, var_19_3 - 1)
	local var_19_5 = string.gsub(arg_19_1, var_19_4, "", 1)

	return var_19_4, string.format("<size=28><space=2.82em></size> %s", var_19_5)
end

function var_0_0._getAfterContent(arg_20_0, arg_20_1)
	arg_20_1 = string.gsub(arg_20_1, "：", ":")

	local var_20_0 = {}
	local var_20_1

	for iter_20_0, iter_20_1 in ipairs(string.split(arg_20_1, "\n")) do
		local var_20_2 = string.split(iter_20_1, ":")

		if var_20_2 and #var_20_2 >= 2 and not tabletool.indexOf(var_20_0, var_20_2[1]) then
			table.insert(var_20_0, var_20_2[1])
		end
	end

	local var_20_3 = 0
	local var_20_4

	for iter_20_2, iter_20_3 in ipairs(var_20_0) do
		local var_20_5 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_20_0._txtindenthelper, iter_20_3)

		if var_20_3 < var_20_5 then
			var_20_3 = var_20_5
		end
	end

	local var_20_6 = HeroConfig.instance:getHeroCO(arg_20_0._heroId)
	local var_20_7 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_20_0._txtindenthelper, var_20_6.name)
	local var_20_8 = math.max(var_20_3, var_20_7) / 28 * 5 + 3
	local var_20_9 = {}
	local var_20_10 = {}

	table.insert(var_20_9, var_20_6.name .. ":")
	table.insert(var_20_10, string.format("<indent=0%%%%><color=#943308><b>%s</b></color>：</indent><indent=%d%%%%>", var_20_6.name, var_20_8))

	for iter_20_4, iter_20_5 in ipairs(var_20_0) do
		table.insert(var_20_9, iter_20_5 .. ":")
		table.insert(var_20_10, string.format("<indent=0%%%%><color=#352725><b>%s</b></color>:</indent><indent=%d%%%%>", iter_20_5, var_20_8))
	end

	for iter_20_6 = 1, #var_20_9 do
		arg_20_1 = string.gsub(arg_20_1, var_20_9[iter_20_6], var_20_10[iter_20_6])
	end

	return arg_20_1
end

function var_0_0._statStart(arg_21_0)
	arg_21_0._viewTime = ServerTime.now()
end

function var_0_0._statEnd(arg_22_0)
	if not arg_22_0._heroId then
		return
	end

	if arg_22_0._viewTime then
		local var_22_0 = ServerTime.now() - arg_22_0._viewTime
		local var_22_1 = arg_22_0.viewParam and type(arg_22_0.viewParam) == "table" and arg_22_0.viewParam.fromHandbookView

		CharacterController.instance:statCharacterData(StatEnum.EventName.ReadHeroCulture, arg_22_0._heroId, arg_22_0._config and arg_22_0._config.id, var_22_0, var_22_1)
	end

	arg_22_0._viewTime = nil
end

function var_0_0._onContentScrollValueChanged(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._gomask, arg_23_0._couldScroll and not (gohelper.getRemindFourNumberFloat(arg_23_0._scrollview.verticalNormalizedPosition) <= 0))
end

return var_0_0
