module("modules.logic.scene.survival.entity.SurvivalRainEntity", package.seeall)

local var_0_0 = class("SurvivalRainEntity", LuaCompBase)
local var_0_1 = UnityEngine.Shader

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.onLoadedFunc = arg_1_1.onLoadedFunc
	arg_1_0.callBackContext = arg_1_1.callBackContext
	arg_1_0._param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._rainComp = arg_2_1:GetComponent("ZProj.SurvivalRain")
	arg_2_0._rainLoader = PrefabInstantiate.Create(arg_2_0._param and arg_2_0._param.effectRoot or arg_2_1)
	arg_2_0._textureLoader = SequenceAbLoader.New()

	if GameResMgr.IsFromEditorDir then
		local var_2_0 = SLFramework.FileHelper.GetDirFilePaths("Assets/ZResourcesLib/survival/common/rain")

		if var_2_0 then
			for iter_2_0 = 0, var_2_0.Length - 1 do
				local var_2_1 = var_2_0[iter_2_0]

				if string.sub(var_2_1, -4) == ".png" then
					local var_2_2 = SLFramework.FileHelper.GetFileName(var_2_1, true)

					arg_2_0._textureLoader:addPath("survival/common/rain/" .. var_2_2)
				end
			end
		end
	else
		arg_2_0._textureLoader:addPath("survival/common/rain")
	end

	arg_2_0._textureLoader:startLoad(arg_2_0._onAbLoaded, arg_2_0)
end

function var_0_0.onStart(arg_3_0)
	arg_3_0._rainComp.enabled = false
	arg_3_0._inited = true

	arg_3_0:_setRainParam()
end

function var_0_0._onAbLoaded(arg_4_0)
	arg_4_0._abLoaded = true

	arg_4_0:_setRainParam()

	if arg_4_0.onLoadedFunc then
		arg_4_0.onLoadedFunc(arg_4_0.callBackContext)
	end
end

function var_0_0.setCurRain(arg_5_0, arg_5_1)
	if not arg_5_0._rainLoader then
		return
	end

	if arg_5_0._rainId == arg_5_1 then
		return
	end

	local var_5_0 = arg_5_0._rainId

	arg_5_0._rainId = arg_5_1

	if arg_5_0._inited and arg_5_0._abLoaded then
		arg_5_0:_resetParam(var_5_0)
		arg_5_0:_setRainParam()
	end
end

function var_0_0._setRainParam(arg_6_0)
	if not arg_6_0._rainId or not arg_6_0._inited or not arg_6_0._abLoaded then
		return
	end

	local var_6_0 = SurvivalRainParam[arg_6_0._rainId]

	if not var_6_0 then
		return
	end

	var_0_1.DisableKeyword("_SURVIAL_SCENE")
	var_0_1.DisableKeyword("_ENABLE_SURVIVAL_RAIN_DISTORTION")
	var_0_1.DisableKeyword("_ENABLE_SURVIVAL_RAIN_GLITCH")

	arg_6_0._rainComp.enabled = true
	arg_6_0._rainComp.enabled = false

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_1 = SurvivalRainParam.ParamToShaderFunc[iter_6_0]

		if var_6_1 == var_0_1.SetGlobalTexture then
			local var_6_2 = arg_6_0:getTexture(iter_6_1)

			if var_6_2 then
				var_6_1(iter_6_0, var_6_2)
			end
		elseif var_6_1 then
			var_6_1(iter_6_0, iter_6_1)
		end
	end

	if var_6_0.KeyWord then
		var_0_1.EnableKeyword(var_6_0.KeyWord)
	end

	local var_6_3 = string.format("survival/common/rain/survival_rain%d.prefab", arg_6_0._rainId)

	if arg_6_0._rainLoader:getPath() ~= var_6_3 then
		arg_6_0._rainLoader:dispose()
		arg_6_0._rainLoader:startLoad(var_6_3)
	end
end

function var_0_0.getTexture(arg_7_0, arg_7_1)
	local var_7_0 = "survival/common/rain/" .. arg_7_1 .. ".png"
	local var_7_1

	if GameResMgr.IsFromEditorDir then
		var_7_1 = arg_7_0._textureLoader:getAssetItem(var_7_0)
	else
		var_7_1 = arg_7_0._textureLoader:getAssetItem("survival/common/rain")
	end

	if not var_7_1 then
		return
	end

	return var_7_1:GetResource(var_7_0)
end

function var_0_0._resetParam(arg_8_0, arg_8_1)
	local var_8_0 = SurvivalRainParam[arg_8_1]

	if not var_8_0 then
		return
	end

	if var_8_0.KeyWord then
		var_0_1.DisableKeyword(var_8_0.KeyWord)
	end
end

function var_0_0.onDestroy(arg_9_0)
	if arg_9_0._rainId and arg_9_0._inited and arg_9_0._abLoaded then
		arg_9_0:_resetParam(arg_9_0._rainId)

		arg_9_0._rainId = nil
	end

	if arg_9_0._rainLoader then
		arg_9_0._rainLoader:dispose()

		arg_9_0._rainLoader = nil
	end

	if arg_9_0._textureLoader then
		arg_9_0._textureLoader:dispose()

		arg_9_0._textureLoader = nil
	end
end

return var_0_0
