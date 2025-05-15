module("modules.logic.survival.view.map.SurvivalTalentGetView", package.seeall)

local var_0_0 = class("SurvivalTalentGetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_close")
	arg_1_0._imageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Reward/#image_reward")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Reward/#txt_name")
	arg_1_0._txtskill = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Reward/#txt_skill")
	arg_1_0._txtdec = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Reward/#txt_dec")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.onClickModalMask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_ask)

	local var_4_0 = lua_survival_talent.configDict[arg_4_0.viewParam.talentId]

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0.groupId
	local var_4_2 = lua_survival_talent_group.configDict[var_4_1]

	arg_4_0._imageicon:LoadImage(ResUrl.getSurvivalTalentIcon(var_4_2.folder .. "/icon_tianfu_" .. var_4_0.pos))

	arg_4_0._txtname.text = var_4_0.name
	arg_4_0._txtskill.text = var_4_0.desc1
	arg_4_0._txtdec.text = var_4_0.desc2
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

return var_0_0
