module("modules.logic.survival.view.shelter.SurvivalBootyChooseNpcItem", package.seeall)

local var_0_0 = class("SurvivalBootyChooseNpcItem", ShelterTentManagerNpcItem)

function var_0_0.onClickNpcItem(arg_1_0)
	if not arg_1_0.mo then
		return
	end

	if SurvivalShelterChooseNpcListModel.instance:isQuickSelect() then
		SurvivalShelterChooseNpcListModel.instance:quickSelectNpc(arg_1_0.mo.id)
	else
		SurvivalShelterChooseNpcListModel.instance:setSelectNpc(arg_1_0.mo.id)
		arg_1_0._view.viewContainer:refreshNpcChooseView()
	end
end

function var_0_0.refreshItem(arg_2_0, arg_2_1)
	local var_2_0 = SurvivalShelterChooseNpcListModel.instance:getSelectNpc()
	local var_2_1 = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(arg_2_1.id)
	local var_2_2 = SurvivalShelterChooseNpcListModel.instance:isQuickSelect()

	gohelper.setActive(arg_2_0.goSelected, var_2_0 == arg_2_1.id and not var_2_2)
	gohelper.setActive(arg_2_0.goTips, var_2_1 ~= nil)

	if var_2_1 ~= nil then
		arg_2_0.txtBuildName.text = luaLang("SurvivalShelterChooseNpcItem_Tips")
	end

	arg_2_0.txtName.text = arg_2_1.co.name

	if not string.nilorempty(arg_2_1.co.headIcon) then
		UISpriteSetMgr.instance:setV2a2ChessSprite(arg_2_0.imageNpc, arg_2_1.co.headIcon)
	end
end

return var_0_0
