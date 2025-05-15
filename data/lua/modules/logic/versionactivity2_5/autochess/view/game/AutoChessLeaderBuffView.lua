module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessLeaderBuffView", package.seeall)

local var_0_0 = class("AutoChessLeaderBuffView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollDetail = gohelper.findChildScrollRect(arg_1_0.viewGO, "Detail/#scroll_Detail")
	arg_1_0._goEnergy = gohelper.findChild(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Energy")
	arg_1_0._txtEnergy = gohelper.findChildText(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Energy/#txt_Energy")
	arg_1_0._txtEnergyDesc = gohelper.findChildText(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Energy/#txt_EnergyDesc")
	arg_1_0._goFire = gohelper.findChild(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Fire")
	arg_1_0._txtFire = gohelper.findChildText(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Fire/#txt_Fire")
	arg_1_0._txtFireDesc = gohelper.findChildText(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Fire/#txt_FireDesc")
	arg_1_0._goBuff = gohelper.findChild(arg_1_0.viewGO, "Detail/#go_Buff")
	arg_1_0._txtBuffName = gohelper.findChildText(arg_1_0.viewGO, "Detail/#go_Buff/title/#txt_BuffName")
	arg_1_0._scrollBuff = gohelper.findChildScrollRect(arg_1_0.viewGO, "Detail/#go_Buff/#scroll_Buff")
	arg_1_0._txtBuffDesc = gohelper.findChildText(arg_1_0.viewGO, "Detail/#go_Buff/#scroll_Buff/viewport/content/#txt_BuffDesc")

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

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	SkillHelper.addHyperLinkClick(arg_5_0._txtEnergyDesc, arg_5_0.clcikHyperLink, arg_5_0)
	SkillHelper.addHyperLinkClick(arg_5_0._txtFireDesc, arg_5_0.clcikHyperLink, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.position

	recthelper.setAnchor(arg_6_0.viewGO.transform, var_6_0.x + 169, var_6_0.y + 380)

	arg_6_0.chessMo = AutoChessModel.instance:getChessMo()

	local var_6_1 = arg_6_0.chessMo.svrFight.mySideMaster

	if AutoChessHelper.getBuffCnt(var_6_1.buffContainer.buffs, AutoChessEnum.EnergyBuffIds) == 0 then
		gohelper.setActive(arg_6_0._goEnergy, false)
	else
		arg_6_0._txtEnergy.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_leaderbuffview_energy"), 1)

		local var_6_2 = AutoChessConfig.instance:getSkillEffectDesc(2)

		arg_6_0._txtEnergyDesc.text = AutoChessHelper.buildSkillDesc(var_6_2.desc)

		gohelper.setActive(arg_6_0._goEnergy, true)
	end

	if AutoChessHelper.getBuffCnt(var_6_1.buffContainer.buffs, AutoChessEnum.FireBuffIds) == 0 then
		gohelper.setActive(arg_6_0._goFire, false)
	else
		arg_6_0._txtFire.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_leaderbuffview_fire"), 1)

		local var_6_3 = AutoChessConfig.instance:getSkillEffectDesc(16)

		arg_6_0._txtFireDesc.text = AutoChessHelper.buildSkillDesc(var_6_3.desc)

		gohelper.setActive(arg_6_0._goFire, true)
	end
end

function var_0_0.clcikHyperLink(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = AutoChessConfig.instance:getSkillEffectDesc(tonumber(arg_7_1))

	if var_7_0 then
		arg_7_0._txtBuffName.text = var_7_0.name
		arg_7_0._txtBuffDesc.text = var_7_0.desc

		gohelper.setActive(arg_7_0._goBuff, true)
	end
end

return var_0_0
