﻿module("framework.res.PrefabInstantiate", package.seeall)

local var_0_0 = class("PrefabInstantiate", LuaCompBase)

function var_0_0.Create(arg_1_0)
	return MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._containerGO = arg_2_1
	arg_2_0._path = nil
	arg_2_0._assetItem = nil
	arg_2_0._instGO = nil
	arg_2_0._finishCallback = nil
	arg_2_0._callbackTarget = nil
end

function var_0_0.startLoad(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if gohelper.isNil(arg_3_0._containerGO) then
		logError("self._containerGO is nil, but startLoad:" .. tostring(arg_3_1))

		return
	end

	arg_3_0._path = arg_3_1
	arg_3_0._finishCallback = arg_3_2
	arg_3_0._callbackTarget = arg_3_3

	loadAbAsset(arg_3_1, false, arg_3_0._onLoadCallback, arg_3_0)
end

function var_0_0.getPath(arg_4_0)
	return arg_4_0._path
end

function var_0_0.getAssetItem(arg_5_0)
	return arg_5_0._assetItem
end

function var_0_0.getInstGO(arg_6_0)
	return arg_6_0._instGO
end

function var_0_0.dispose(arg_7_0)
	if arg_7_0._path then
		removeAssetLoadCb(arg_7_0._path, arg_7_0._onLoadCallback, arg_7_0)
	end

	if arg_7_0._assetItem then
		arg_7_0._assetItem:Release()
	end

	gohelper.destroy(arg_7_0._instGO)

	arg_7_0._path = nil
	arg_7_0._assetItem = nil
	arg_7_0._instGO = nil
	arg_7_0._finishCallback = nil
	arg_7_0._callbackTarget = nil
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0:dispose()
	arg_8_0:__onDispose()
end

function var_0_0._onLoadCallback(arg_9_0, arg_9_1)
	if arg_9_1.IsLoadSuccess then
		if gohelper.isNil(arg_9_0._containerGO) then
			logError("self._containerGO is nil, but _onLoadCallback:" .. tostring(arg_9_0._path))

			return
		end

		arg_9_0._assetItem = arg_9_1

		arg_9_0._assetItem:Retain()

		arg_9_0._instGO = gohelper.clone(arg_9_0._assetItem:GetResource(arg_9_0._path), arg_9_0._containerGO)

		if arg_9_0._finishCallback then
			if arg_9_0._callbackTarget then
				arg_9_0._finishCallback(arg_9_0._callbackTarget, arg_9_0)
			else
				arg_9_0._finishCallback(arg_9_0)
			end
		end
	end
end

return var_0_0
