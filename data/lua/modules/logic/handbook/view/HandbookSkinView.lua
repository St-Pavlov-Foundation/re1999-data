local var_0_0 = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinView", package.seeall)

local var_0_1 = class("HandbookSkinView", BaseView)
local var_0_2 = 120
local var_0_3 = 170
local var_0_4 = 5
local var_0_5 = "up_start"
local var_0_6 = "donw_start"

function var_0_1.onInitView(arg_1_0)
	arg_1_0._skinItemRoot = gohelper.findChild(arg_1_0.viewGO, "#go_scroll/#go_storyStages")
	arg_1_0._imageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._imageSkinSuitGroupIcon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#image_Icon")
	arg_1_0._imageSkinSuitGroupEnIcon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#image_TitleEn")
	arg_1_0._textPlayerName = gohelper.findChildText(arg_1_0.viewGO, "title/#title_name")
	arg_1_0._textName = gohelper.findChildText(arg_1_0.viewGO, "title/#name")
	arg_1_0._txtFloorName = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_Name")
	arg_1_0._txtFloorThemeDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_Descr")
	arg_1_0._goFloorItemRoot = gohelper.findChild(arg_1_0.viewGO, "Right/Scroll View/Viewport/Content")
	arg_1_0._goFloorItem = gohelper.findChild(arg_1_0.viewGO, "Right/Scroll View/Viewport/Content/Buttnitem")
	arg_1_0._goSwitch = gohelper.findChild(arg_1_0.viewGO, "switch")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "#point")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "scroll")
	arg_1_0._scroll = SLFramework.UGUI.UIDragListener.Get(arg_1_0._goscroll)
	arg_1_0._itemScrollRect = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/Scroll View")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Right/Scroll View/Viewport/Content")
	arg_1_0._goScrollListArrow = gohelper.findChild(arg_1_0.viewGO, "Right/arrow")
	arg_1_0._arrowAnimator = arg_1_0._goScrollListArrow:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._scrollHeight = recthelper.getHeight(arg_1_0._itemScrollRect.transform)
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._viewAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, HandbookEvent.SkinPointChanged, arg_2_0._refresPoint, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, HandbookEvent.OnClickTarotSkinSuit, arg_2_0._onEnterTarotMode, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, HandbookEvent.OnExitTarotSkinSuit, arg_2_0._onExitTarotMode, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.OnClickSkinSuitFloorItem, arg_2_0.onClickFloorItem, arg_2_0)

	if HandbookController.instance:hasAnyHandBookSkinGroupRedDot() then
		arg_2_0._itemScrollRect:AddOnValueChanged(arg_2_0._onScrollChange, arg_2_0)
	end

	arg_2_0._scroll:AddDragBeginListener(arg_2_0._onScrollDragBegin, arg_2_0)
	arg_2_0._scroll:AddDragEndListener(arg_2_0._onScrollDragEnd, arg_2_0)
	arg_2_0._scroll:AddDragListener(arg_2_0._onScrollDragging, arg_2_0)
end

function var_0_1.removeEvents(arg_3_0)
	arg_3_0._itemScrollRect:RemoveOnValueChanged()
	arg_3_0._scroll:RemoveDragBeginListener()
	arg_3_0._scroll:RemoveDragEndListener()
	arg_3_0._scroll:RemoveDragListener()
	arg_3_0.dropClick:RemoveClickListener()
	arg_3_0._dropFilter:RemoveOnValueChanged()

	if arg_3_0.dropExtend then
		arg_3_0.dropExtend:dispose()
	end
end

function var_0_1._onScrollChange(arg_4_0, arg_4_1)
	arg_4_0:refreshTabListArrow()
end

function var_0_1._onScrollDragBegin(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.scrollDragPos = arg_5_2.position
	arg_5_0._scrollDragOffsetX = 0
	arg_5_0._scrollDragOffsetY = 0
end

function var_0_1._onScrollDragging(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.scrollDragPos then
		arg_6_0.scrollDragPos = arg_6_2.position
	end

	local var_6_0 = arg_6_2.position - arg_6_0.scrollDragPos

	arg_6_0.scrollDragPos = arg_6_2.position

	local var_6_1 = arg_6_0._skinSuitFloorCfgList[arg_6_0._curSelectedIdx].id

	if HandbookEnum.SkinSuitId2SceneType[var_6_1] == HandbookEnum.SkinSuitSceneType.Tarot then
		HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlide, var_6_0.x)
	else
		arg_6_0._scrollDragOffsetX = arg_6_0._scrollDragOffsetX + var_6_0.x
		arg_6_0._scrollDragOffsetY = arg_6_0._scrollDragOffsetY + var_6_0.y

		HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlide, -var_6_0.x, -var_6_0.y)
	end
end

function var_0_1._onScrollDragEnd(arg_7_0, arg_7_1, arg_7_2)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideEnd)

	arg_7_0._slideToOtherSuit = false
end

function var_0_1.slideToPre(arg_8_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideToPre)
end

function var_0_1.slideToNext(arg_9_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideToNext)
end

function var_0_1._editableInitView(arg_10_0)
	arg_10_0._gopointItem = gohelper.findChild(arg_10_0.viewGO, "#point/point_item")
	arg_10_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_10_0.viewGO)

	gohelper.setActive(arg_10_0._goFloorItem, false)
	gohelper.setActive(arg_10_0._goSwitch, false)

	arg_10_0._pointItemTbList = {
		arg_10_0:_createPointTB(arg_10_0._gopointItem)
	}
end

function var_0_1.onOpen(arg_11_0)
	local var_11_0 = arg_11_0.viewParam

	arg_11_0._defaultSelectedIdx = var_11_0 and var_11_0.defaultSelectedIdx or 1
	arg_11_0._curSelectedIdx = arg_11_0._defaultSelectedIdx

	arg_11_0:_createFloorItems()
	arg_11_0:_refreshDesc()

	local var_11_1 = PlayerModel.instance:getPlayinfo().name

	var_11_1 = var_11_1 and var_11_1 or ""

	local var_11_2 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("handbookskinview_playername"), var_11_1)

	arg_11_0._textPlayerName.text = var_11_2
	arg_11_0._textName.text = ""

	arg_11_0:updateFilterDrop()
end

function var_0_1.onOpenFinish(arg_12_0)
	arg_12_0:refreshTabListArrow()
end

function var_0_1.refreshTabListArrow(arg_13_0)
	arg_13_0._contentHeight = recthelper.getHeight(arg_13_0._goContent.transform)

	if arg_13_0._floorNum <= var_0_4 then
		gohelper.setActive(arg_13_0._goScrollListArrow, false)
	else
		local var_13_0 = 0

		for iter_13_0, iter_13_1 in ipairs(arg_13_0._skinSuitFloorItems) do
			if iter_13_1:hasRedDot() then
				local var_13_1 = iter_13_1.viewGO.transform.localPosition.y

				var_13_0 = math.min(var_13_1, var_13_0)
			end
		end

		local var_13_2 = math.abs(var_13_0)
		local var_13_3 = arg_13_0._goContent.transform.localPosition.y
		local var_13_4 = var_13_2 - arg_13_0._scrollHeight - var_13_3 > var_0_3 / 2

		if var_13_4 then
			arg_13_0._arrowAnimator:Play(var_0_0.Loop)
		else
			arg_13_0._arrowAnimator:Play(var_0_0.Idle)
		end

		gohelper.setActive(arg_13_0._goScrollListArrow, var_13_4)
	end
end

function var_0_1._refreshDesc(arg_14_0)
	if HandbookEnum.SkinSuitId2SceneType[arg_14_0._skinThemeCfg.id] == HandbookEnum.SkinSuitSceneType.Tarot then
		gohelper.setActive(arg_14_0._txtFloorThemeDescr.gameObject, false)
		gohelper.setActive(arg_14_0._txtFloorName.gameObject, false)
		gohelper.setActive(arg_14_0._imageSkinSuitGroupEnIcon.gameObject, false)
		gohelper.setActive(arg_14_0._imageSkinSuitGroupIcon.gameObject, false)
	else
		gohelper.setActive(arg_14_0._txtFloorThemeDescr.gameObject, true)
		gohelper.setActive(arg_14_0._txtFloorName.gameObject, true)
		gohelper.setActive(arg_14_0._imageSkinSuitGroupEnIcon.gameObject, true)
		gohelper.setActive(arg_14_0._imageSkinSuitGroupIcon.gameObject, true)

		arg_14_0._txtFloorThemeDescr.text = arg_14_0._skinThemeCfg.des
		arg_14_0._txtFloorName.text = arg_14_0._skinThemeCfg.name

		UISpriteSetMgr.instance:setSkinHandbook(arg_14_0._imageSkinSuitGroupEnIcon, arg_14_0._skinThemeCfg.nameRes, true)
		UISpriteSetMgr.instance:setSkinHandbook(arg_14_0._imageSkinSuitGroupIcon, arg_14_0._skinThemeCfg.iconRes, true)
	end
end

function var_0_1._createFloorItems(arg_15_0)
	arg_15_0._skinSuitFloorItems = {}
	arg_15_0._skinSuitFloorCfgList = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)
	arg_15_0._floorNum = #arg_15_0._skinSuitFloorCfgList

	gohelper.CreateObjList(arg_15_0, arg_15_0._createFloorItem, arg_15_0._skinSuitFloorCfgList, arg_15_0._goFloorItemRoot, arg_15_0._goFloorItem, HandbookSkinFloorItem)
end

function var_0_1._createFloorItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:onUpdateData(arg_16_2, arg_16_3)
	arg_16_1:refreshRedDot()
	arg_16_1:refreshSelectState(arg_16_3 == arg_16_0._curSelectedIdx)
	arg_16_1:refreshFloorView()
	arg_16_1:setClickAction(arg_16_0.clickFloorItemAction, arg_16_0)
	arg_16_1:refreshCurSuitIdx()

	if arg_16_0._curSelectedIdx == arg_16_3 then
		local var_16_0 = arg_16_0._skinSuitFloorCfgList[arg_16_3]

		arg_16_0._skinThemeCfg = var_16_0

		HandbookController.instance:statSkinTab(var_16_0 and var_16_0.id or arg_16_3)
	end

	arg_16_0._skinSuitFloorItems[arg_16_3] = arg_16_1
end

function var_0_1.clickFloorItemAction(arg_17_0, arg_17_1)
	if arg_17_0._tarotMode then
		return
	end

	HandbookController.instance:dispatchEvent(HandbookEvent.OnClickSkinSuitFloorItem, arg_17_1:getIdx())
end

function var_0_1.onClickFloorItem(arg_18_0, arg_18_1)
	if arg_18_0._curSelectedIdx == arg_18_1 then
		return
	end

	if arg_18_1 > arg_18_0._curSelectedIdx then
		arg_18_0._isUp = true

		arg_18_0._viewAnimatorPlayer:Play(var_0_6, arg_18_0.onClickFloorAniDone, arg_18_0)
	else
		arg_18_0._isUp = false

		arg_18_0._viewAnimatorPlayer:Play(var_0_5, arg_18_0.onClickFloorAniDone, arg_18_0)
	end

	arg_18_0._curSelectedIdx = arg_18_1
end

function var_0_1.onClickFloorAniDone(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._skinSuitFloorItems) do
		iter_19_1:refreshSelectState(iter_19_0 == arg_19_0._curSelectedIdx)
	end

	local var_19_0 = arg_19_0._skinSuitFloorCfgList[arg_19_0._curSelectedIdx]

	arg_19_0._skinThemeCfg = var_19_0

	HandbookController.instance:statSkinTab(var_19_0 and var_19_0.id or arg_19_0._curSelectedIdx)
	arg_19_0:_refreshDesc()
	TaskDispatcher.runDelay(arg_19_0.onSwitchFloorDone, arg_19_0, 0.1)
	arg_19_0:updateFilterDrop()
end

function var_0_1.onSwitchFloorDone(arg_20_0)
	local var_20_0 = arg_20_0._isUp and "donw_end" or "up_end"

	arg_20_0._viewAnimatorPlayer:Play(var_20_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SwitchSkinSuitFloorDone)
end

function var_0_1._refresPoint(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 or 1
	arg_21_2 = arg_21_2 or 0

	for iter_21_0 = #arg_21_0._pointItemTbList + 1, arg_21_2 do
		local var_21_0 = gohelper.cloneInPlace(arg_21_0._gopointItem)
		local var_21_1 = arg_21_0:_createPointTB(var_21_0, iter_21_0)

		table.insert(arg_21_0._pointItemTbList, var_21_1)
	end

	for iter_21_1 = 1, #arg_21_0._pointItemTbList do
		local var_21_2 = arg_21_0._pointItemTbList[iter_21_1]

		gohelper.setActive(var_21_2.golight, iter_21_1 == arg_21_1)
		gohelper.setActive(var_21_2.go, iter_21_1 <= arg_21_2 and arg_21_2 > 1)
	end

	if arg_21_0._dropFilter then
		arg_21_0._dropFilter:SetValue(#arg_21_0._suitCfgList - arg_21_1)
	end
end

function var_0_1._createPointTB(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getUserDataTb_()

	var_22_0.go = arg_22_1
	var_22_0.golight = gohelper.findChild(arg_22_1, "light")

	return var_22_0
end

function var_0_1._clickToSuit(arg_23_0, arg_23_1)
	arg_23_1 = arg_23_1 and arg_23_1 or 1

	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideByClick, arg_23_1)
end

function var_0_1._onEnterTarotMode(arg_24_0)
	arg_24_0._tarotMode = true

	arg_24_0._viewAnimatorPlayer:Play(var_0_0.Close)
end

function var_0_1._onExitTarotMode(arg_25_0)
	arg_25_0._tarotMode = false

	arg_25_0._viewAnimatorPlayer:Play(var_0_0.Back)
end

function var_0_1.updateFilterDrop(arg_26_0)
	if not arg_26_0._dropFilter then
		arg_26_0._dropFilter = gohelper.findChildDropdown(arg_26_0.viewGO, "Left/#drop_filter")
		arg_26_0._goDrop = arg_26_0._dropFilter.gameObject
		arg_26_0.dropArrowTr = gohelper.findChildComponent(arg_26_0._goDrop, "Arrow", gohelper.Type_Transform)
		arg_26_0.dropClick = gohelper.getClick(arg_26_0._goDrop)
		arg_26_0.dropExtend = DropDownExtend.Get(arg_26_0._goDrop)

		arg_26_0.dropExtend:init(arg_26_0.onDropShow, arg_26_0.onDropHide, arg_26_0)
		arg_26_0._dropFilter:AddOnValueChanged(arg_26_0.onDropValueChanged, arg_26_0)
		arg_26_0.dropClick:AddClickListener(function()
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
		end, arg_26_0)
	end

	arg_26_0._curskinSuitGroupCfg = arg_26_0._skinSuitFloorCfgList[arg_26_0._curSelectedIdx]
	arg_26_0._curSuitGroupId = arg_26_0._curskinSuitGroupCfg.id
	arg_26_0._suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(arg_26_0._curskinSuitGroupCfg.id)

	table.sort(arg_26_0._suitCfgList, function(arg_28_0, arg_28_1)
		if arg_28_0.show == 1 and arg_28_1.show == 0 then
			return false
		elseif arg_28_0.show == 0 and arg_28_1.show == 1 then
			return true
		else
			return arg_28_0.id < arg_28_1.id
		end
	end)
	gohelper.setActive(arg_26_0._goDrop, #arg_26_0._suitCfgList > 1)

	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._suitCfgList) do
		local var_26_1 = iter_26_1.show == 1 and arg_26_0._suitCfgList[iter_26_0].name or luaLang("skinhandbook_lock_suit")

		table.insert(var_26_0, var_26_1)
	end

	arg_26_0._dropFilter:ClearOptions()
	arg_26_0._dropFilter:AddOptions(var_26_0)
	arg_26_0._dropFilter:SetValue(#arg_26_0._suitCfgList - 1)
end

function var_0_1.onDropHide(arg_29_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookDropListOpen, false)
end

function var_0_1.onDropShow(arg_30_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookDropListOpen, true)
end

function var_0_1.onDropValueChanged(arg_31_0, arg_31_1)
	arg_31_1 = #arg_31_0._suitCfgList - arg_31_1

	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideByClick, arg_31_1)
end

function var_0_1.onClose(arg_32_0)
	return
end

function var_0_1.onDestroyView(arg_33_0)
	return
end

return var_0_1
