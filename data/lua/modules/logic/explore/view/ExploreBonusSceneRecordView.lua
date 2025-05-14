module("modules.logic.explore.view.ExploreBonusSceneRecordView", package.seeall)

local var_0_0 = class("ExploreBonusSceneRecordView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._item = gohelper.findChild(arg_1_0.viewGO, "mask/Scroll View/Viewport/Content/#go_chatitem")
	arg_1_0._itemContent = gohelper.findChild(arg_1_0.viewGO, "mask/Scroll View/Viewport/Content")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.chapterId
	local var_4_1 = ExploreSimpleModel.instance:getChapterMo(var_4_0).bonusScene
	local var_4_2, var_4_3 = next(var_4_1)
	local var_4_4 = ExploreConfig.instance:getDialogueConfig(var_4_2)
	local var_4_5 = {}
	local var_4_6

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		local var_4_7 = var_4_4[iter_4_0]

		if var_4_7 then
			local var_4_8 = {
				desc = var_4_7.desc
			}

			if not string.nilorempty(var_4_7.bonusButton) then
				var_4_8.options = string.split(var_4_7.bonusButton, "|")
				var_4_8.index = iter_4_1
			end

			table.insert(var_4_5, var_4_8)

			if not string.nilorempty(var_4_7.picture) then
				var_4_6 = var_4_7.picture
			end
		end
	end

	if not string.nilorempty(var_4_6) then
		arg_4_0._simageicon:LoadImage(ResUrl.getExploreBg("file/" .. var_4_6))
	end

	gohelper.CreateObjList(arg_4_0, arg_4_0.onCreateItem, var_4_5, arg_4_0._itemContent, arg_4_0._item)
end

function var_0_0.onCreateItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = gohelper.findChildTextMesh(arg_5_1, "info")
	local var_5_1 = gohelper.findChild(arg_5_1, "bg")

	gohelper.setActive(var_5_0, arg_5_2.desc)
	gohelper.setActive(var_5_1, arg_5_2.options)

	if arg_5_2.desc then
		var_5_0.text = arg_5_2.desc
	end

	if arg_5_2.options then
		for iter_5_0 = 1, 3 do
			local var_5_2 = gohelper.findChildTextMesh(var_5_1, "txt" .. iter_5_0)
			local var_5_3 = gohelper.findChild(var_5_1, "txt" .. iter_5_0 .. "/play")

			if arg_5_2.options[iter_5_0] then
				var_5_2.text = arg_5_2.options[iter_5_0]

				gohelper.setActive(var_5_3, arg_5_2.index == iter_5_0)
				SLFramework.UGUI.GuiHelper.SetColor(var_5_2, arg_5_2.index == iter_5_0 and "#445D42" or "#3D3939")
			else
				gohelper.setActive(var_5_2, false)
			end
		end
	end
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onClose(arg_7_0)
	arg_7_0._simageicon:UnLoadImage()
end

return var_0_0
