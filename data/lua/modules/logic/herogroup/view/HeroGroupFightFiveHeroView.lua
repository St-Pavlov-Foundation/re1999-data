module("modules.logic.herogroup.view.HeroGroupFightFiveHeroView", package.seeall)

local var_0_0 = class("HeroGroupFightFiveHeroView", HeroGroupFightView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0:checkHeroList()
	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.checkHeroList(arg_2_0)
	local var_2_0 = ModuleEnum.FiveHeroEnum.MaxHeroNum
	local var_2_1 = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setMaxHeroCount(var_2_0)
	HeroSingleGroupModel.instance:setSingleGroup(var_2_1)
end

function var_0_0._getKey()
	return (string.format("%s_%s", PlayerPrefsKey.FiveHeroGroupSelectIndex, PlayerModel.instance:getPlayinfo().userId))
end

function var_0_0._initFightGroupDrop(arg_4_0)
	if not arg_4_0:_noAidHero() then
		return
	end

	local var_4_0 = {}

	for iter_4_0 = 1, 4 do
		local var_4_1 = HeroGroupSnapshotModel.instance:getHeroGroupInfo(ModuleEnum.HeroGroupSnapshotType.FiveHero, iter_4_0)
		local var_4_2 = var_4_1 and var_4_1.name

		var_4_0[iter_4_0] = not string.nilorempty(var_4_2) and var_4_2 or formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(iter_4_0))
	end

	local var_4_3 = PlayerPrefsHelper.getNumber(arg_4_0:_getKey(), 0)

	HeroGroupModel.instance:setHeroGroupSelectIndex(var_4_3 == 0 and ModuleEnum.FiveHeroEnum.FifthIndex or var_4_3)
	gohelper.setActive(arg_4_0._btnmodifyname, var_4_3 ~= 0)

	local var_4_4 = HeroGroupModel.instance:getGroupTypeName()

	if var_4_4 then
		table.insert(var_4_0, 1, var_4_4)
	else
		var_4_3 = var_4_3 - 1
	end

	arg_4_0._dropherogroup:ClearOptions()
	arg_4_0._dropherogroup:AddOptions(var_4_0)
	arg_4_0._dropherogroup:SetValue(var_4_3)
end

function var_0_0._groupDropValueChanged(arg_5_0, arg_5_1)
	PlayerPrefsHelper.setNumber(arg_5_0:_getKey(), arg_5_1)

	local var_5_0 = arg_5_1

	gohelper.setActive(arg_5_0._btnmodifyname, var_5_0 ~= 0)

	local var_5_1 = arg_5_1 == 0 and ModuleEnum.FiveHeroEnum.FifthIndex or arg_5_1

	if HeroGroupModel.instance:setHeroGroupSelectIndex(var_5_1) then
		HeroGroupModel.instance:_setSingleGroup()
		arg_5_0:_checkEquipClothSkill()
		GameFacade.showToast(arg_5_0._changeToastId or ToastEnum.SeasonGroupChanged)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(arg_5_0._goherogroupcontain, false)
		gohelper.setActive(arg_5_0._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end
end

function var_0_0.onClose(arg_6_0)
	var_0_0.super.onClose(arg_6_0)
	HeroSingleGroupModel.instance:setMaxHeroCount()
end

return var_0_0
