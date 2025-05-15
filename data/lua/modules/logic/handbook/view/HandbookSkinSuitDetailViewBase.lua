module("modules.logic.handbook.view.HandbookSkinSuitDetailViewBase", package.seeall)

local var_0_0 = class("HandbookSkinSuitDetailViewBase", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._skinItemRoot = gohelper.findChild(arg_1_0.viewGO, "#go_scroll/#go_storyStages")
	arg_1_0._imageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._textSkinThemeDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_scroll/Viewport/#go_storyStages/#txt_Descr")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO)
end

function var_0_0._getPhotoRootGo(arg_5_0, arg_5_1)
	arg_5_0._skinItemGoList = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, arg_5_1 do
		arg_5_0._skinItemGoList[iter_5_0] = gohelper.findChild(arg_5_0.viewGO, "#go_scroll/Viewport/#go_storyStages/handbookskinitem/photo" .. iter_5_0)
	end
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.refreshUI(arg_7_0)
	return
end

function var_0_0.refreshBtnStatus(arg_8_0)
	return
end

function var_0_0._refreshDesc(arg_9_0)
	arg_9_0._textSkinThemeDescr.text = arg_9_0._skinSuitCfg.des
end

function var_0_0._refreshBg(arg_10_0)
	return
end

function var_0_0._refreshSkinItems(arg_11_0)
	arg_11_0._skinItemList = {}

	for iter_11_0 = 1, #arg_11_0._skinIdList do
		local var_11_0 = arg_11_0._skinItemGoList[iter_11_0]

		if var_11_0 then
			local var_11_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0, HandbookSkinItem, arg_11_0)

			var_11_1:setData(arg_11_0._skinThemeGroupId)
			var_11_1:refreshItem(arg_11_0._skinIdList[iter_11_0])
			table.insert(arg_11_0._skinItemList, var_11_1)
		end
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
