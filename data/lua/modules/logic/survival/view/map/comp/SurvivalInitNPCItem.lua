module("modules.logic.survival.view.map.comp.SurvivalInitNPCItem", package.seeall)

local var_0_0 = class("SurvivalInitNPCItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goHaveNpc = gohelper.findChild(arg_1_1, "#go_HaveHero")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_1, "#go_Empty")
	arg_1_0._goLock = gohelper.findChild(arg_1_1, "#go_Locked")
	arg_1_0._clickThis = gohelper.getClick(arg_1_1)
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0._goHaveNpc, "#txt_PartnerName")
	arg_1_0._imagechess = gohelper.findChildImage(arg_1_0._goHaveNpc, "#image_Chess")
	arg_1_0._goAttrItem = gohelper.findChild(arg_1_0._goHaveNpc, "Scroll View/Viewport/#go_content/#go_Attr")
end

function var_0_0.setIndex(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1
end

function var_0_0.setParentView(arg_3_0, arg_3_1)
	arg_3_0._teamView = arg_3_1
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0._clickThis:AddClickListener(arg_4_0._onClickThis, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0._clickThis:RemoveClickListener()
end

function var_0_0.getNpcMo(arg_6_0)
	return arg_6_0._npcMo
end

function var_0_0.setIsLock(arg_7_0, arg_7_1)
	arg_7_0._isLock = arg_7_1

	if arg_7_1 then
		gohelper.setActive(arg_7_0._goLock, true)
		gohelper.setActive(arg_7_0._goHaveNpc, false)
		gohelper.setActive(arg_7_0._goEmpty, false)
	end
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._npcMo = arg_8_1

	local var_8_0 = arg_8_0._npcMo ~= nil

	gohelper.setActive(arg_8_0._goEmpty, not var_8_0)
	gohelper.setActive(arg_8_0._goHaveNpc, var_8_0)

	if var_8_0 then
		local var_8_1 = arg_8_1.co

		if not var_8_1 then
			return
		end

		arg_8_0._txtname.text = var_8_1.name

		UISpriteSetMgr.instance:setV2a2ChessSprite(arg_8_0._imagechess, var_8_1.headIcon, false)

		local var_8_2 = string.splitToNumber(var_8_1.tag, "#") or {}

		gohelper.CreateObjList(arg_8_0, arg_8_0._createTagItem, var_8_2, nil, arg_8_0._goAttrItem)
	end
end

function var_0_0._createTagItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = lua_survival_tag.configDict[arg_9_2]

	if not var_9_0 then
		return
	end

	local var_9_1 = gohelper.findChildTextMesh(arg_9_1, "image_TitleBG/#txt_Title")
	local var_9_2 = gohelper.findChildImage(arg_9_1, "image_TitleBG")
	local var_9_3 = gohelper.findChildTextMesh(arg_9_1, "")

	var_9_1.text = var_9_0.name
	var_9_3.text = var_9_0.desc

	UISpriteSetMgr.instance:setSurvivalSprite(var_9_2, "survivalpartnerteam_attrbg" .. var_9_0.color, false)
end

function var_0_0.showSelectEffect(arg_10_0)
	return
end

function var_0_0._onClickThis(arg_11_0)
	if arg_11_0._isLock then
		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalNPCSelectView)
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0._teamView = nil
end

return var_0_0
