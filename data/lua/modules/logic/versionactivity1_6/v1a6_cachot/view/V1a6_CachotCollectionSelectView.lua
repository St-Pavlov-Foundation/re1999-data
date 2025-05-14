module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionSelectView", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._godisableconfirm = gohelper.findChild(arg_1_0.viewGO, "#go_disableconfirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	UIBlockMgr.instance:startBlock("V1a6_CachotCollectionSelectView_Get")

	if arg_6_0._collectionItemTab and arg_6_0._collectionItemTab[arg_6_0._selectIndex] then
		local var_6_0 = arg_6_0.viewParam and arg_6_0.viewParam.selectCallback
		local var_6_1 = arg_6_0.viewParam and arg_6_0.viewParam.selectCallbackObj

		if var_6_0 and arg_6_0._selectIndex then
			var_6_0(var_6_1, arg_6_0._selectIndex)
		else
			logError(string.format("selectCallBack or selectIndex is nil, selectIndex = %s", arg_6_0._selectIndex))
		end
	else
		logError("cannot find collectionItem, index = " .. tostring(arg_6_0._selectIndex))
	end

	if arg_6_0._animatorPlayer and arg_6_0._playCollectionCloseAnimCallBack then
		arg_6_0._animatorPlayer:Play("close", arg_6_0._playCollectionCloseAnimCallBack, arg_6_0)
		arg_6_0:_closeOtherUnselectCollections()
	else
		arg_6_0:closeThis()
	end
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.collectionList

	arg_7_0:refreshGetCollectionList(var_7_0)
	arg_7_0:refreshConfirmBtnState()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_click)
end

function var_0_0.refreshGetCollectionList(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if arg_8_1 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			local var_8_1 = arg_8_0:_getOrCreateCollectionItem(iter_8_0)

			var_8_0[var_8_1] = true

			local var_8_2 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(iter_8_1)

			if var_8_2 then
				var_8_1.simageIcon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_8_2.icon))

				var_8_1.txtName.text = var_8_2 and var_8_2.name or ""

				V1a6_CachotCollectionHelper.refreshSkillDesc(var_8_2, var_8_1.goskillcontainer, var_8_1.goskillItem)
				V1a6_CachotCollectionHelper.createCollectionHoles(var_8_2, var_8_1.goEnchantList, var_8_1.goHole)
			end
		end
	end

	arg_8_0:_recycleUnUseCollectionItem(var_8_0)
end

function var_0_0._getOrCreateCollectionItem(arg_9_0, arg_9_1)
	arg_9_0._collectionItemTab = arg_9_0._collectionItemTab or {}

	local var_9_0 = arg_9_0._collectionItemTab[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:getUserDataTb_()
		var_9_0.viewGO = gohelper.cloneInPlace(arg_9_0._gocollectionitem, "collectionItem_" .. arg_9_1)
		var_9_0.animator = gohelper.onceAddComponent(var_9_0.viewGO, gohelper.Type_Animator)
		var_9_0.imageBg = gohelper.findChildImage(var_9_0.viewGO, "#simage_bg")
		var_9_0.normalBg = gohelper.findChildImage(var_9_0.viewGO, "normal")

		UISpriteSetMgr.instance:setV1a6CachotSprite(var_9_0.imageBg, "v1a6_cachot_reward_bg1")

		var_9_0.simageIcon = gohelper.findChildSingleImage(var_9_0.viewGO, "#simage_collection")
		var_9_0.txtName = gohelper.findChildText(var_9_0.viewGO, "#txt_name")
		var_9_0.goSelect = gohelper.findChild(var_9_0.viewGO, "#go_select")
		var_9_0.btnSelect = gohelper.getClickWithDefaultAudio(var_9_0.viewGO)

		var_9_0.btnSelect:AddClickListener(arg_9_0._onSelectCollection, arg_9_0, arg_9_1)

		var_9_0.goskillcontainer = gohelper.findChild(var_9_0.viewGO, "scroll_desc/Viewport/#go_skillcontainer")
		var_9_0.goskillItem = gohelper.findChild(var_9_0.viewGO, "scroll_desc/Viewport/#go_skillcontainer/#go_skillitem")
		var_9_0.goEnchantList = gohelper.findChild(var_9_0.viewGO, "#go_enchantlist")
		var_9_0.goHole = gohelper.findChild(var_9_0.viewGO, "#go_enchantlist/#go_hole")

		gohelper.setActive(var_9_0.viewGO, true)

		arg_9_0._collectionItemTab[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0._onSelectCollection(arg_10_0, arg_10_1)
	arg_10_0._selectIndex = arg_10_1

	arg_10_0:checkCollectionSelected(arg_10_1)
	arg_10_0:refreshConfirmBtnState()
end

function var_0_0.checkCollectionSelected(arg_11_0, arg_11_1)
	if arg_11_0._collectionItemTab then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._collectionItemTab) do
			gohelper.setActive(iter_11_1.goSelect, arg_11_1 == iter_11_0)
			gohelper.setActive(iter_11_1.normalBg, arg_11_1 ~= iter_11_0)
		end
	end
end

function var_0_0.refreshConfirmBtnState(arg_12_0)
	local var_12_0 = arg_12_0._selectIndex and arg_12_0._selectIndex ~= 0

	gohelper.setActive(arg_12_0._godisableconfirm, not var_12_0)
	gohelper.setActive(arg_12_0._btnconfirm.gameObject, var_12_0)
end

function var_0_0._releaseCallBackParam(arg_13_0)
	if arg_13_0.viewParam then
		arg_13_0.viewParam.selectCallback = nil
		arg_13_0.viewParam.selectCallbackObj = nil
	end
end

function var_0_0._recycleUnUseCollectionItem(arg_14_0, arg_14_1)
	if arg_14_1 and arg_14_0._collectionItemTab then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._collectionItemTab) do
			if not arg_14_1[iter_14_1] then
				gohelper.setActive(iter_14_1.viewGO, false)
			end
		end
	end
end

function var_0_0._disposeAllCollectionItems(arg_15_0)
	if arg_15_0._collectionItemTab then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._collectionItemTab) do
			if iter_15_1.btnSelect then
				iter_15_1.btnSelect:RemoveClickListener()
			end
		end
	end
end

function var_0_0._closeOtherUnselectCollections(arg_16_0)
	if arg_16_0._collectionItemTab then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._collectionItemTab) do
			if iter_16_0 ~= arg_16_0._selectIndex then
				iter_16_1.animator:Play("collectionitem_close")
			end
		end
	end
end

function var_0_0._playCollectionCloseAnimCallBack(arg_17_0)
	arg_17_0:closeThis()
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionSelectView_Get")
end

function var_0_0.onClose(arg_18_0)
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionSelectView_Get")
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0:_disposeAllCollectionItems()
	arg_19_0:_releaseCallBackParam()
end

return var_0_0
