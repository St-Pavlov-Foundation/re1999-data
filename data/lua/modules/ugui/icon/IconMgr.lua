module("modules.ugui.icon.IconMgr", package.seeall)

local var_0_0 = class("IconMgr")

function var_0_0.preload(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._callback = arg_1_1
	arg_1_0._callbackObj = arg_1_2
	arg_1_0._resDict = {}
	arg_1_0._loader = MultiAbLoader.New()

	arg_1_0._loader:setPathList(IconMgrConfig.getPreloadList())
	arg_1_0._loader:setOneFinishCallback(arg_1_0._onOnePreloadCallback, arg_1_0)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadCallback, arg_1_0)

	arg_1_0._liveIconReferenceTimeDic = {}
	arg_1_0._liveIconCountDic = {}
end

function var_0_0.getCommonPropItemIcon(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:_getIconInstance(IconMgrConfig.UrlPropItemIcon, arg_2_1)

	if var_2_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_2_0, CommonPropItemIcon)
	end
end

function var_0_0.getCommonPropListItemIcon(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:_getIconInstance(IconMgrConfig.UrlPropItemIcon, arg_3_1)

	if var_3_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_3_0, CommonPropListItem)
	end
end

function var_0_0.getCommonPropItemIconList(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0:CreateCellList(arg_4_1, arg_4_2, arg_4_3, arg_4_4, IconMgrConfig.UrlPropItemIcon, CommonPropItemIcon)
end

function var_0_0.getCommonItemIcon(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:_getIconInstance(IconMgrConfig.UrlItemIcon, arg_5_1)

	if var_5_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0, CommonItemIcon)
	end
end

function var_0_0.getCommonEquipIcon(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:_getIconInstance(IconMgrConfig.UrlEquipIcon, arg_6_1)

	if var_6_0 then
		if arg_6_2 then
			transformhelper.setLocalScale(var_6_0.transform, arg_6_2, arg_6_2, arg_6_2)
		end

		return MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0, CommonEquipIcon)
	end
end

function var_0_0.getCommonHeroIcon(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:_getIconInstance(IconMgrConfig.UrlHeroIcon, arg_7_1)

	if var_7_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0, CommonHeroIcon)
	end
end

function var_0_0.getCommonHeroIconNew(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:_getIconInstance(IconMgrConfig.UrlHeroIconNew, arg_8_1)

	if var_8_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_8_0, CommonHeroIconNew)
	end
end

function var_0_0.getCommonHeroItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:_getIconInstance(IconMgrConfig.UrlHeroItemNew, arg_9_1)

	if var_9_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_9_0, CommonHeroItem)
	end
end

function var_0_0.getCommonPlayerIcon(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:_getIconInstance(IconMgrConfig.UrlPlayerIcon, arg_10_1)

	if var_10_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_10_0, CommonPlayerIcon)
	end
end

function var_0_0.getRoomGoodsItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2 and arg_11_2:getResInst(IconMgrConfig.UrlRoomGoodsItemIcon, arg_11_1)

	if var_11_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0, RoomGoodsItem)
	end
end

function var_0_0.getCommonTextMarkTop(arg_12_0, arg_12_1)
	return (arg_12_0:_getIconInstance(IconMgrConfig.UrlCommonTextMarkTop, arg_12_1))
end

function var_0_0.getCommonHeadIcon(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:_getIconInstance(IconMgrConfig.UrlHeadIcon, arg_13_1)

	if var_13_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_13_0, CommonHeadIcon)
	end
end

function var_0_0.getCommonCritterIcon(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:_getIconInstance(IconMgrConfig.UrlCritterIcon, arg_14_1)

	if var_14_0 then
		return MonoHelper.addNoUpdateLuaComOnceToGo(var_14_0, CommonCritterIcon)
	end
end

function var_0_0._getIconInstance(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._resDict[arg_15_1]

	if var_15_0 then
		local var_15_1 = var_15_0:GetResource(arg_15_1)

		if var_15_1 then
			return gohelper.clone(var_15_1, arg_15_2)
		else
			logError(arg_15_1 .. " prefab not in ab")
		end
	end

	logError(arg_15_1 .. " iconPrefab need preload")
end

function var_0_0._onOnePreloadCallback(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._resDict[arg_16_2.ResPath] = arg_16_2
end

function var_0_0._onPreloadCallback(arg_17_0)
	if arg_17_0._callback then
		arg_17_0._callback(arg_17_0._callbackObj)
	end

	arg_17_0._callback = nil
	arg_17_0._callbackObj = nil
end

function var_0_0.CreateCellList(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)
	local var_18_0 = arg_18_0:getModelPrefab(arg_18_5)

	gohelper.CreateObjList(arg_18_1, arg_18_2, arg_18_3, arg_18_4, var_18_0, arg_18_6)
end

function var_0_0.getModelPrefab(arg_19_0, arg_19_1)
	return arg_19_0._resDict[arg_19_1]:GetResource(arg_19_1)
end

function var_0_0.getCommonLiveHeadIcon(arg_20_0, arg_20_1)
	local var_20_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_20_1.gameObject, CommonLiveHeadIcon)

	var_20_0:init(arg_20_1)

	return var_20_0
end

function var_0_0.setHeadIcon(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8)
	arg_21_0 = tonumber(arg_21_0)
	arg_21_3 = arg_21_3 and true or false
	arg_21_4 = arg_21_4 and true or false
	arg_21_5 = arg_21_5 and true or false

	local var_21_0 = lua_item.configDict[arg_21_0]

	if var_21_0 == nil then
		return
	end

	if arg_21_6 then
		local var_21_1 = arg_21_1.gameObject:GetComponent(gohelper.Type_Image)

		ZProj.UGUIHelper.SetColorAlpha(var_21_1, arg_21_6)
	end

	local var_21_2 = tonumber(var_21_0.icon)
	local var_21_3 = var_21_0.isDynamic == IconMgrConfig.HeadIconType.Dynamic

	if var_21_3 then
		if not arg_21_2 then
			local var_21_4 = arg_21_5 and arg_21_1.transform.parent.gameObject or arg_21_1.transform.gameObject

			arg_21_2 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_21_1.gameObject, CommonLiveHeadIcon)

			arg_21_2:init(var_21_4)
		end

		arg_21_2:setLiveHead(var_21_2, arg_21_1.gameObject, arg_21_3, arg_21_5, arg_21_6)
	else
		local var_21_5 = ItemConfig.instance:getItemIconById(var_21_2)
		local var_21_6 = arg_21_3 and function()
			if arg_21_3 then
				arg_21_1.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
			end

			if arg_21_7 then
				arg_21_7(arg_21_8)
			end
		end or arg_21_7

		if arg_21_3 then
			-- block empty
		end

		local var_21_7 = arg_21_8

		arg_21_1:LoadImage(ResUrl.getPlayerHeadIcon(var_21_5), var_21_6, var_21_7)
	end

	if arg_21_2 then
		arg_21_2:setVisible(var_21_3)
	end

	if arg_21_4 then
		gohelper.setActive(arg_21_1.gameObject, not var_21_3)
	end

	return arg_21_2
end

function var_0_0.addLiveIconAnimationReferenceTime(arg_23_0, arg_23_1)
	if arg_23_0._liveIconReferenceTimeDic == nil or arg_23_0._liveIconCountDic == nil then
		arg_23_0._liveIconReferenceTimeDic = {}
		arg_23_0._liveIconCountDic = {}
	end

	logNormal("Add LiveIcon")

	if not arg_23_0._liveIconReferenceTimeDic[arg_23_1] then
		arg_23_0._liveIconCountDic[arg_23_1] = 1

		local var_23_0 = UnityEngine.Time.timeSinceLevelLoad

		arg_23_0._liveIconReferenceTimeDic[arg_23_1] = var_23_0
	else
		local var_23_1 = arg_23_0._liveIconCountDic[arg_23_1]

		arg_23_0._liveIconCountDic[arg_23_1] = var_23_1 + 1
	end
end

function var_0_0.removeHeadLiveIcon(arg_24_0, arg_24_1)
	if not arg_24_0._liveIconReferenceTimeDic[arg_24_1] then
		logNormal("Have no headLiveIcon Reference")

		return
	end

	logNormal("Remove LiveIcon")

	local var_24_0 = arg_24_0._liveIconCountDic[arg_24_1]
	local var_24_1 = math.max(0, var_24_0 - 1)

	if var_24_1 <= 0 then
		arg_24_0._liveIconReferenceTimeDic[arg_24_1] = nil
		arg_24_0._liveIconCountDic[arg_24_1] = nil
	else
		arg_24_0._liveIconCountDic[arg_24_1] = var_24_1
	end
end

function var_0_0.getLiveIconReferenceTime(arg_25_0, arg_25_1)
	if not arg_25_0._liveIconReferenceTimeDic or not arg_25_0._liveIconReferenceTimeDic[arg_25_1] then
		logError("Have no ReferenceTime id: " .. tostring(arg_25_1))

		return 0
	end

	return arg_25_0._liveIconReferenceTimeDic[arg_25_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
