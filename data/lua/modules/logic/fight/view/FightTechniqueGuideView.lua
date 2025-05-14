module("modules.logic.fight.view.FightTechniqueGuideView", package.seeall)

local var_0_0 = class("FightTechniqueGuideView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotargetframe = gohelper.findChild(arg_1_0.viewGO, "#go_targetframe")
	arg_1_0._goguidContent = gohelper.findChild(arg_1_0.viewGO, "#go_guidContent")
	arg_1_0._goguideitem = gohelper.findChild(arg_1_0.viewGO, "#go_guidContent/#go_guideitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	TaskDispatcher.cancelTask(FightWorkFocusMonster.showCardPart, FightWorkFocusMonster)

	arg_7_0._entityMO = arg_7_0.viewParam.entity
	arg_7_0._config = arg_7_0.viewParam.config

	FightWorkFocusMonster.focusCamera(arg_7_0._entityMO.id)

	arg_7_0._is_enter_type = arg_7_0._config.invokeType == FightWorkFocusMonster.invokeType.Enter

	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)

	arg_7_0._show_des = string.split(arg_7_0._config.des, "|")
	arg_7_0._show_icon = string.split(arg_7_0._config.icon, "|")
	arg_7_0._isActivityVersion = string.split(arg_7_0._config.isActivityVersion, "|")

	gohelper.CreateObjList(arg_7_0, arg_7_0._onItemShow, arg_7_0._show_des, arg_7_0._goguidContent, arg_7_0._goguideitem)
	FightHelper.setMonsterGuideFocusState(arg_7_0._config)
end

function var_0_0._onItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1.transform
	local var_8_1 = gohelper.findChildSingleImage(arg_8_1, "simage_guideicon")
	local var_8_2 = var_8_0:Find("txt_desc"):GetComponent(gohelper.Type_TextMesh)
	local var_8_3 = var_8_0:Find("go_career").gameObject
	local var_8_4 = arg_8_0._show_des[arg_8_3]
	local var_8_5 = string.gsub(var_8_4, "%【", string.format("<color=%s>", "#F87D42"))

	var_8_2.text = string.gsub(var_8_5, "%】", "</color>")

	var_8_1:LoadImage(ResUrl.getFightTechniqueGuide(arg_8_0._show_icon[arg_8_3], arg_8_0._isActivityVersion[arg_8_3] == "1") or "")

	if not arg_8_0._images then
		arg_8_0._images = {}
	end

	table.insert(arg_8_0._images, var_8_1)

	local var_8_6 = gohelper.findChildImage(var_8_3, "image_bg")
	local var_8_7 = lua_monster.configDict[arg_8_0._entityMO.modelId].career
	local var_8_8

	if var_8_7 ~= 5 and var_8_7 ~= 6 then
		var_8_8 = FightConfig.instance:restrainedBy(var_8_7)

		local var_8_9 = {
			"#473115",
			"#192c40",
			"#243829",
			"#4d2525",
			"#462b48",
			"#564d26"
		}

		SLFramework.UGUI.GuiHelper.SetColor(var_8_6, var_8_9[var_8_8])
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(var_8_3, "image_career"), "lssx_" .. var_8_8)
	end

	gohelper.setActive(var_8_3, var_8_8 and arg_8_3 == 1)
end

function var_0_0.onClose(arg_9_0)
	FightWorkFocusMonster.cancelFocusCamera()
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._images then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._images) do
			iter_10_1:UnLoadImage()
		end
	end

	arg_10_0._images = nil
end

return var_0_0
