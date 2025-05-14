module("modules.logic.character.view.CharacterDataItemView", package.seeall)

local var_0_0 = class("CharacterDataItemView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simagecentericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_centericon")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon")
	arg_1_0._simagerighticon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_mask")
	arg_1_0._gopointercontainer = gohelper.findChild(arg_1_0.viewGO, "content/bottom/#go_pointcontainer")
	arg_1_0._gopointeritem = gohelper.findChild(arg_1_0.viewGO, "content/bottom/#go_pointcontainer/#go_pointitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onLeftPageClick(arg_4_0)
	if not arg_4_0.needShowPageBtn then
		return
	end

	if arg_4_0.skinIndex <= 1 then
		return
	end

	arg_4_0.skinIndex = arg_4_0.skinIndex - 1
	arg_4_0.skinId = arg_4_0.skinList[arg_4_0.skinIndex]

	arg_4_0.contentAnimator:Play("switch_left", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_character_data_item_page)
end

function var_0_0.onRightPageClick(arg_5_0)
	if not arg_5_0.needShowPageBtn then
		return
	end

	if arg_5_0.skinIndex >= arg_5_0.skinLen then
		return
	end

	arg_5_0.skinIndex = arg_5_0.skinIndex + 1
	arg_5_0.skinId = arg_5_0.skinList[arg_5_0.skinIndex]

	arg_5_0.contentAnimator:Play("switch_right", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_character_data_item_page)
end

function var_0_0.initItem(arg_6_0)
	arg_6_0.itemList = arg_6_0:getUserDataTb_()

	local var_6_0

	for iter_6_0 = 1, 3 do
		local var_6_1 = arg_6_0:getUserDataTb_()

		var_6_1.itemGo = gohelper.findChild(arg_6_0.viewGO, "content/itembg" .. iter_6_0)
		var_6_1.animator = var_6_1.itemGo:GetComponent(typeof(UnityEngine.Animator))
		var_6_1.itemshow = gohelper.findChild(var_6_1.itemGo, "go_itemshow")
		var_6_1.itemlock = gohelper.findChild(var_6_1.itemGo, "go_itemlock")
		var_6_1.lockicon = gohelper.findChild(var_6_1.itemlock, "go_lockicon")
		var_6_1.unlocktxt = gohelper.findChildText(var_6_1.lockicon, "unlocktext")
		var_6_1.treasurego = gohelper.findChild(var_6_1.itemGo, "go_itemlock/go_treasure")
		var_6_1.goitemshow = gohelper.findChild(var_6_1.itemGo, "go_itemshow")
		var_6_1.title1 = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemname1")
		var_6_1.title2 = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemname2")
		var_6_1.titleen = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemnameen")
		var_6_1.text = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/descScroll/Viewport/descContent/itemtext")
		var_6_1.icon = gohelper.findChildSingleImage(var_6_1.itemGo, "go_itemshow/itemicon")
		var_6_1.goimageestimate = gohelper.findChild(var_6_1.itemGo, "go_itemshow/itemtxtbg/estimate/image_estimate")
		var_6_1.imageestimate = gohelper.findChildImage(var_6_1.itemGo, "go_itemshow/itemtxtbg/estimate/image_estimate/image_estimate")
		var_6_1.txtestimate = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/estimate/txt_estimate")
		var_6_1.treasurebtn = gohelper.findChildButtonWithAudio(var_6_1.itemlock, "clickarea")

		var_6_1.treasurebtn:AddClickListener(arg_6_0._onTreasureBtnClick, arg_6_0, iter_6_0)
		table.insert(arg_6_0.itemList, var_6_1)
	end
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._gopointeritem, false)

	arg_7_0.goContent = gohelper.findChild(arg_7_0.viewGO, "content")

	arg_7_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_7_0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	arg_7_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_7_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_7_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_7_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	arg_7_0:initItem()

	arg_7_0._effectsList = arg_7_0:getUserDataTb_()
	arg_7_0._dataList = {}

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItemFail, arg_7_0._unlockItemCallbackFail, arg_7_0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItem, arg_7_0._unlockItemCallback, arg_7_0)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:_refreshUI()
end

function var_0_0.onOpen(arg_9_0)
	gohelper.setActive(arg_9_0.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_pieces_open)

	arg_9_0._heroId = CharacterDataModel.instance:getCurHeroId()
	arg_9_0.heroMo = HeroModel.instance:getByHeroId(arg_9_0._heroId)

	arg_9_0:initSkinInfo()
	arg_9_0:_statStart()
	arg_9_0:_refreshUI()
end

function var_0_0.sortSkin(arg_10_0, arg_10_1)
	return arg_10_0 < arg_10_1
end

function var_0_0.initSkinInfo(arg_11_0)
	local var_11_0 = arg_11_0.heroMo.skinInfoList
	local var_11_1 = CharacterDataConfig.instance:geCharacterSkinIdList(arg_11_0._heroId)

	arg_11_0.skinList = {
		CharacterDataConfig.DefaultSkinDataKey
	}

	local var_11_2 = CharacterDataConfig.instance:getDataConfig()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if tabletool.indexOf(var_11_1, iter_11_1.skin) then
			local var_11_3 = var_11_2[arg_11_0._heroId][iter_11_1.skin]

			if var_11_3 and var_11_3[CharacterEnum.CharacterDataItemType.Item] then
				table.insert(arg_11_0.skinList, iter_11_1.skin)
			end
		end
	end

	arg_11_0.skinId = arg_11_0.skinList[1]

	table.sort(arg_11_0.skinList, var_0_0.sortSkin)

	arg_11_0.skinIndex = 1
	arg_11_0.skinLen = #arg_11_0.skinList
	arg_11_0.needShowPageBtn = arg_11_0.skinLen > 1

	if arg_11_0.needShowPageBtn then
		arg_11_0.contentAnimator = arg_11_0.goContent:GetComponent(typeof(UnityEngine.Animator))
		arg_11_0.contentAnimatorEvent = arg_11_0.goContent:GetComponent(typeof(ZProj.AnimationEventWrap))

		arg_11_0.contentAnimatorEvent:AddEventListener("refresh", arg_11_0._refreshUI, arg_11_0)
	end

	arg_11_0:initPointItem()
	arg_11_0:initPageBtnItem()
end

function var_0_0.initPointItem(arg_12_0)
	if not arg_12_0.needShowPageBtn then
		return
	end

	arg_12_0.pointItemList = arg_12_0.pointItemList or arg_12_0:getUserDataTb_()

	local var_12_0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.skinList) do
		local var_12_1 = arg_12_0.pointItemList[iter_12_0]

		if not var_12_1 then
			var_12_1 = {
				go = gohelper.cloneInPlace(arg_12_0._gopointeritem, "point_" .. iter_12_0)
			}
			var_12_1.gonormalstar = gohelper.findChild(var_12_1.go, "#go_nomalstar")
			var_12_1.golightstar = gohelper.findChild(var_12_1.go, "#go_lightstar")
			var_12_1.click = gohelper.getClick(var_12_1.go)

			var_12_1.click:AddClickListener(arg_12_0.pointOnClick, arg_12_0, iter_12_0)
			table.insert(arg_12_0.pointItemList, var_12_1)
		end

		gohelper.setActive(var_12_1.go, true)
	end

	for iter_12_2 = #arg_12_0.skinList + 1, #arg_12_0.pointItemList do
		gohelper.setActive(arg_12_0.pointItemList[iter_12_2].go, false)
	end
end

function var_0_0.initPageBtnItem(arg_13_0)
	arg_13_0.btnLeftPage = gohelper.findChildClick(arg_13_0.viewGO, "content/#btn_leftpage")
	arg_13_0.btnRightPage = gohelper.findChildClick(arg_13_0.viewGO, "content/#btn_rightpage")

	if not arg_13_0.needShowPageBtn then
		return
	end

	arg_13_0.btnLeftPage:AddClickListener(arg_13_0.onLeftPageClick, arg_13_0)
	arg_13_0.btnRightPage:AddClickListener(arg_13_0.onRightPageClick, arg_13_0)
end

function var_0_0.pointOnClick(arg_14_0, arg_14_1)
	arg_14_0.skinIndex = arg_14_1
	arg_14_0.skinId = arg_14_0.skinList[arg_14_0.skinIndex]

	arg_14_0:_refreshUI()
end

function var_0_0.initDrag(arg_15_0)
	if #arg_15_0.skinList <= 1 then
		return
	end

	arg_15_0._itemDrag = SLFramework.UGUI.UIDragListener.Get(arg_15_0.goContent)

	arg_15_0._itemDrag:AddDragBeginListener(arg_15_0._onDragBegin, arg_15_0)
	arg_15_0._itemDrag:AddDragEndListener(arg_15_0._onDragEnd, arg_15_0)
end

function var_0_0._onDragBegin(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.startDragPosX = arg_16_2.position.x
end

function var_0_0._onDragEnd(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2.position.x

	if math.abs(var_17_0 - arg_17_0.startDragPosX) > 30 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

		if var_17_0 > arg_17_0.startDragPosX then
			arg_17_0.skinIndex = arg_17_0.skinIndex - 1

			if arg_17_0.skinIndex < 1 then
				arg_17_0.skinIndex = #arg_17_0.skinList
			end
		else
			arg_17_0.skinIndex = arg_17_0.skinIndex + 1

			if arg_17_0.skinIndex > #arg_17_0.skinList then
				arg_17_0.skinIndex = 1
			end
		end

		arg_17_0.skinId = arg_17_0.skinList[arg_17_0.skinIndex]

		arg_17_0:_refreshUI()
	end
end

function var_0_0._refreshUI(arg_18_0)
	arg_18_0:refreshItem()
	arg_18_0:refreshPointItem()
	arg_18_0:refreshPageBtn()
end

function var_0_0._unlockItemCallback(arg_19_0, arg_19_1, arg_19_2)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if arg_19_2 >= 2 and arg_19_2 <= 4 then
		arg_19_0.itemList[arg_19_2 - 1].treasurebtn:RemoveClickListener()

		arg_19_0._dataList[arg_19_2 - 1].isGetRewards = true
	end
end

function var_0_0._unlockItemCallbackFail(arg_20_0)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.refreshItem(arg_21_0)
	local var_21_0
	local var_21_1
	local var_21_2
	local var_21_3
	local var_21_4
	local var_21_5
	local var_21_6
	local var_21_7

	for iter_21_0 = 1, 3 do
		local var_21_8 = arg_21_0.itemList[iter_21_0]
		local var_21_9 = arg_21_0._dataList[iter_21_0]

		if not var_21_9 then
			var_21_9 = {}
			arg_21_0._dataList[iter_21_0] = var_21_9
		end

		var_21_9.itemId = iter_21_0 + 1

		local var_21_10 = CharacterDataConfig.instance:getCharacterDataCO(arg_21_0._heroId, arg_21_0.skinId, CharacterEnum.CharacterDataItemType.Item, iter_21_0)
		local var_21_11 = CharacterDataConfig.instance:checkLockCondition(var_21_10)
		local var_21_12 = HeroModel.instance:checkGetRewards(arg_21_0._heroId, var_21_9.itemId)

		var_21_9.islock = var_21_11
		var_21_9.isGetRewards = var_21_12

		if var_21_11 then
			gohelper.setActive(var_21_8.itemshow, false)
			gohelper.setActive(var_21_8.itemlock, true)
			gohelper.setActive(var_21_8.lockicon, true)
			gohelper.setActive(var_21_8.treasurego, false)

			local var_21_13 = string.splitToNumber(var_21_10.unlockConditine, "#")
			local var_21_14 = {}

			if var_21_13[1] == CharacterDataConfig.unlockConditionEpisodeID then
				var_21_14 = {
					DungeonConfig.instance:getEpisodeCO(var_21_13[2]).name
				}
			elseif var_21_13[1] == CharacterDataConfig.unlockConditionRankID then
				var_21_14 = {
					var_21_13[2] - 1
				}
			else
				var_21_14 = {
					var_21_13[2]
				}
			end

			local var_21_15 = ToastConfig.instance:getToastCO(var_21_10.lockText).tips
			local var_21_16 = GameUtil.getSubPlaceholderLuaLang(var_21_15, var_21_14)

			var_21_8.unlocktxt.text = var_21_16
		else
			arg_21_0:_setItemTitlePos(var_21_8.title1, var_21_8.title2, var_21_8.titleen, var_21_10.title)

			var_21_8.titleen.text = var_21_10.titleEn
			var_21_8.text.text = LuaUtil.replaceSpace(var_21_10.text)

			arg_21_0:_refreshEstimate(var_21_8, var_21_10)
			var_21_8.icon:LoadImage(ResUrl.getCharacterDataPic(var_21_10.icon))

			if string.nilorempty(var_21_10.unlockRewards) then
				gohelper.setActive(var_21_8.itemshow, true)
				gohelper.setActive(var_21_8.itemlock, false)
			elseif var_21_12 then
				gohelper.setActive(var_21_8.itemshow, true)
				gohelper.setActive(var_21_8.itemlock, false)
			else
				arg_21_0:addAniEffect(var_21_8.goitemshow, var_21_9.itemId, arg_21_0._heroId)
				gohelper.setActive(var_21_8.itemshow, false)
				gohelper.setActive(var_21_8.itemlock, true)
				gohelper.setActive(var_21_8.lockicon, false)
				gohelper.setActive(var_21_8.treasurego, true)
				arg_21_0:checkAndCloneMaterialIfNeed(var_21_8.treasurego, iter_21_0)
			end
		end
	end
end

function var_0_0.checkAndCloneMaterialIfNeed(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._cloneMaterialMap and arg_22_0._cloneMaterialMap[arg_22_2] then
		return
	end

	arg_22_0._cloneMaterialMap = arg_22_0._cloneMaterialMap or {}
	arg_22_0._cloneMaterialMap[arg_22_2] = true

	local var_22_0 = gohelper.findChildImage(arg_22_1, "image")
	local var_22_1 = var_22_0.material

	var_22_0.material = UnityEngine.Object.Instantiate(var_22_1)

	local var_22_2 = var_22_0.gameObject:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	var_22_2.mas:Clear()
	var_22_2.mas:Add(var_22_0.material)
end

function var_0_0.refreshPointItem(arg_23_0)
	if not arg_23_0.pointItemList then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.pointItemList) do
		gohelper.setActive(iter_23_1.gonormalstar, iter_23_0 ~= arg_23_0.skinIndex)
		gohelper.setActive(iter_23_1.golightstar, iter_23_0 == arg_23_0.skinIndex)
	end
end

function var_0_0.refreshPageBtn(arg_24_0)
	if not arg_24_0.needShowPageBtn then
		gohelper.setActive(arg_24_0.btnLeftPage.gameObject, false)
		gohelper.setActive(arg_24_0.btnRightPage.gameObject, false)

		return
	end

	gohelper.setActive(arg_24_0.btnLeftPage.gameObject, arg_24_0.skinIndex ~= 1)
	gohelper.setActive(arg_24_0.btnRightPage.gameObject, arg_24_0.skinIndex ~= arg_24_0.skinLen)
end

function var_0_0._onTreasureBtnClick(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._dataList[arg_25_1]

	if var_25_0.islock then
		local var_25_1 = CharacterDataConfig.instance:getCharacterDataCO(arg_25_0._heroId, arg_25_0.heroMo.skin, CharacterEnum.CharacterDataItemType.Item, arg_25_1)
		local var_25_2 = string.splitToNumber(var_25_1.unlockConditine, "#")
		local var_25_3 = ""

		if var_25_2[1] == CharacterDataConfig.unlockConditionEpisodeID then
			var_25_3 = DungeonConfig.instance:getEpisodeCO(var_25_2[2]).name
		elseif var_25_2[1] == CharacterDataConfig.unlockConditionRankID then
			var_25_3 = var_25_2[2] - 1
		else
			var_25_3 = var_25_2[2]
		end

		GameFacade.showToast(var_25_1.lockText, var_25_3)
	elseif not var_25_0.isGetRewards then
		local var_25_4 = arg_25_0.itemList[arg_25_1]

		gohelper.setActive(var_25_4.itemshow, true)
		gohelper.setActive(var_25_4.itemlock, false)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("playRewardsAnimtion")
		arg_25_0:playAniEffect(var_25_0.itemId)
		var_25_4.animator:Play(UIAnimationName.Unlock)
		TaskDispatcher.runDelay(function()
			HeroRpc.instance:sendItemUnlockRequest(arg_25_0._heroId, var_25_0.itemId)
		end, nil, 2)
	end
end

function var_0_0._refreshEstimate(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_2.estimate

	if string.nilorempty(var_27_0) then
		gohelper.setActive(arg_27_1.goimageestimate.gameObject, false)

		arg_27_1.txtestimate.text = luaLang("notestimate")
	else
		gohelper.setActive(arg_27_1.goimageestimate.gameObject, true)

		local var_27_1 = string.split(var_27_0, "#")
		local var_27_2 = var_27_1[1]
		local var_27_3 = var_27_1[2]

		UISpriteSetMgr.instance:setUiCharacterSprite(arg_27_1.imageestimate, "fh" .. tostring(var_27_2))

		arg_27_1.txtestimate.text = string.format("%s", tostring(var_27_3))
	end
end

function var_0_0.addAniEffect(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = HeroModel.instance:getByHeroId(arg_28_3).itemUnlock

	if arg_28_0:checkItemIsLock(var_28_0, arg_28_2) and not arg_28_0._effectsList[arg_28_2] then
		arg_28_0._effectsList[arg_28_2] = arg_28_0:getUserDataTb_()

		local var_28_1 = arg_28_1:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)

		if var_28_1 then
			local var_28_2 = var_28_1:GetEnumerator()

			while var_28_2:MoveNext() do
				if not gohelper.findChildTextMesh(var_28_2.Current.gameObject, "") then
					local var_28_3 = UIEffectManager.instance:getUIEffect(var_28_2.Current.gameObject, typeof(Coffee.UIEffects.UIDissolve))

					table.insert(arg_28_0._effectsList[arg_28_2], var_28_3)
				end
			end
		end

		for iter_28_0, iter_28_1 in ipairs(arg_28_0._effectsList[arg_28_2]) do
			iter_28_1.width = 0.2
			iter_28_1.softness = 1
			iter_28_1.color = "#956C4B"
			iter_28_1.effectFactor = 0
		end
	end
end

function var_0_0.playAniEffect(arg_29_0, arg_29_1)
	if not arg_29_0._effectsList[arg_29_1] then
		return
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._effectsList[arg_29_1]) do
		iter_29_1.effectFactor = 1
	end

	arg_29_0._tweenIds = arg_29_0._tweenIds or {}

	if arg_29_0._tweenIds[arg_29_1] then
		ZProj.TweenHelper.KillById(arg_29_0._tweenIds[arg_29_1])

		arg_29_0._tweenIds[arg_29_1] = nil
	end

	local var_29_0 = ZProj.TweenHelper.DOTweenFloat(0, 2.85, 2.85, function(arg_30_0)
		if arg_30_0 >= 0.35 then
			local var_30_0 = arg_29_0._effectsList[arg_29_1]

			if not var_30_0 then
				return
			end

			for iter_30_0, iter_30_1 in ipairs(var_30_0) do
				iter_30_1.effectFactor = 1 - (arg_30_0 - 0.35) / 2.5
			end
		end
	end)

	arg_29_0._tweenIds[arg_29_1] = var_29_0
end

function var_0_0.checkItemIsLock(arg_31_0, arg_31_1, arg_31_2)
	for iter_31_0, iter_31_1 in pairs(arg_31_1) do
		if iter_31_1 == arg_31_2 then
			return false
		end
	end

	return true
end

function var_0_0._statStart(arg_32_0)
	arg_32_0._viewTime = ServerTime.now()
end

function var_0_0._statEnd(arg_33_0)
	if not arg_33_0._heroId then
		return
	end

	if arg_33_0._viewTime then
		local var_33_0 = ServerTime.now() - arg_33_0._viewTime
		local var_33_1 = arg_33_0.viewParam and type(arg_33_0.viewParam) == "table" and arg_33_0.viewParam.fromHandbookView

		CharacterController.instance:statCharacterData(StatEnum.EventName.ReadHeroItem, arg_33_0._heroId, nil, var_33_0, var_33_1)
	end

	arg_33_0._viewTime = nil
end

function var_0_0._setItemTitlePos(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = not string.nilorempty(arg_34_4) and string.split(arg_34_4, "\n") or {}
	local var_34_1 = -1.18
	local var_34_2 = -23.2
	local var_34_3 = 13.2
	local var_34_4 = -30.17

	if GameUtil.getTabLen(var_34_0) > 1 then
		local var_34_5 = {
			-21.7,
			-21.7,
			-24.8,
			-24.8
		}
		local var_34_6 = {
			62.1,
			52.221,
			60.6,
			46.9
		}
		local var_34_7 = {
			-52.32,
			-81.1,
			-73.4,
			-73.4
		}
		local var_34_8 = GameUtil.utf8len(GameUtil.trimInput(arg_34_4))
		local var_34_9 = var_34_8 - 6 <= 4 and var_34_8 - 6 or 4

		var_34_1 = var_34_5[var_34_9]
		var_34_2 = var_34_7[var_34_9]
		var_34_3 = 30
		var_34_4 = -47.03

		local var_34_10 = var_34_6[var_34_9]

		recthelper.setAnchorX(arg_34_2.transform, var_34_10)

		arg_34_2.text = var_34_0[2]
	else
		arg_34_2.text = ""
	end

	arg_34_1.text = var_34_0[1]

	recthelper.setAnchor(arg_34_1.transform, var_34_1, var_34_3)
	recthelper.setAnchor(arg_34_3.transform, var_34_2, var_34_4)
end

function var_0_0.onClose(arg_35_0)
	gohelper.setActive(arg_35_0.viewGO, false)
	arg_35_0:_statEnd()
end

function var_0_0.onDestroyView(arg_36_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItemFail, arg_36_0._unlockItemCallbackFail, arg_36_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItem, arg_36_0._unlockItemCallback, arg_36_0)

	if arg_36_0._itemDrag then
		arg_36_0._itemDrag:RemoveDragBeginListener()
		arg_36_0._itemDrag:RemoveDragEndListener()
	end

	arg_36_0._simagebg:UnLoadImage()
	arg_36_0._simagecentericon:UnLoadImage()
	arg_36_0._simagelefticon:UnLoadImage()
	arg_36_0._simagerighticon:UnLoadImage()
	arg_36_0._simagerighticon2:UnLoadImage()
	arg_36_0._simagemask:UnLoadImage()

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.itemList) do
		iter_36_1.icon:UnLoadImage()
		iter_36_1.treasurebtn:RemoveClickListener()
	end

	if arg_36_0.pointItemList then
		for iter_36_2, iter_36_3 in ipairs(arg_36_0.pointItemList) do
			iter_36_3.click:RemoveClickListener()
		end
	end

	if arg_36_0._tweenIds then
		for iter_36_4, iter_36_5 in pairs(arg_36_0._tweenIds) do
			ZProj.TweenHelper.KillById(iter_36_5)
		end

		arg_36_0._tweenIds = nil
	end

	if arg_36_0.needShowPageBtn then
		arg_36_0.btnLeftPage:RemoveClickListener()
		arg_36_0.btnRightPage:RemoveClickListener()
		arg_36_0.contentAnimatorEvent:RemoveAllEventListener()
	end
end

return var_0_0
