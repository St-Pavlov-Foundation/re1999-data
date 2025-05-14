module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkItemTween", package.seeall)

local var_0_0 = class("RoleStoryDispatchTalkItemTween", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()
end

function var_0_0.playTween(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0:killTween()

	arg_2_0.callback = arg_2_3
	arg_2_0.callbackObj = arg_2_4
	arg_2_0.text = arg_2_1
	arg_2_0.content = arg_2_2
	arg_2_0.scrollContent = arg_2_5

	TaskDispatcher.runDelay(arg_2_0._delayShow, arg_2_0, 0.05)
end

function var_0_0._delayShow(arg_3_0)
	arg_3_0:initText()

	arg_3_0.canvasGroup.alpha = 1
	arg_3_0.tweenId = ZProj.TweenHelper.DOTweenFloat(1, arg_3_0.characterCount, arg_3_0.delayTime, arg_3_0.frameCallback, arg_3_0.onTextFinished, arg_3_0, nil, EaseType.Linear)

	arg_3_0:moveContent()
end

function var_0_0.moveContent(arg_4_0)
	local var_4_0 = arg_4_0.scrollContent.transform
	local var_4_1 = recthelper.getHeight(var_4_0.parent)
	local var_4_2 = recthelper.getHeight(var_4_0)
	local var_4_3 = math.max(var_4_2 - var_4_1, 0)
	local var_4_4 = recthelper.getAnchorY(arg_4_0.transform.parent) + recthelper.getHeight(arg_4_0.transform.parent)
	local var_4_5 = math.max(var_4_3, var_4_4 - var_4_1)

	arg_4_0.moveId = ZProj.TweenHelper.DOAnchorPosY(var_4_0, var_4_5, arg_4_0.delayTime * 0.8, nil, nil, nil, EaseType.Linear)
end

function var_0_0._doCallback(arg_5_0)
	local var_5_0 = arg_5_0.callback
	local var_5_1 = arg_5_0.callbackObj

	arg_5_0.callback = nil
	arg_5_0.callbackObj = nil

	if var_5_0 then
		var_5_0(var_5_1)
	end
end

function var_0_0.frameCallback(arg_6_0, arg_6_1)
	local var_6_0 = UnityEngine.Screen.width
	local var_6_1 = CameraMgr.instance:getUICamera()

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.lineInfoList) do
		local var_6_2 = iter_6_1[1]
		local var_6_3 = iter_6_1[2]
		local var_6_4 = iter_6_1[3]

		if var_6_3 <= arg_6_1 and arg_6_1 <= var_6_4 then
			local var_6_5 = arg_6_0.textInfo.characterInfo
			local var_6_6 = var_6_5[var_6_2.firstVisibleCharacterIndex]
			local var_6_7 = var_6_5[var_6_2.lastVisibleCharacterIndex]
			local var_6_8 = var_6_1:WorldToScreenPoint(arg_6_0.transform:TransformPoint(var_6_6.bottomLeft))
			local var_6_9 = var_6_8
			local var_6_10 = var_6_8.y

			for iter_6_2 = var_6_2.firstVisibleCharacterIndex, var_6_2.lastVisibleCharacterIndex do
				local var_6_11 = var_6_5[iter_6_2]
				local var_6_12 = var_6_1:WorldToScreenPoint(arg_6_0.transform:TransformPoint(var_6_11.bottomLeft))

				if var_6_10 > var_6_12.y then
					var_6_10 = var_6_12.y
				end
			end

			var_6_9.y = var_6_10

			local var_6_13 = var_6_1:WorldToScreenPoint(arg_6_0.transform:TransformPoint(var_6_6.topLeft))
			local var_6_14 = var_6_13
			local var_6_15 = var_6_13.y

			for iter_6_3 = var_6_2.firstVisibleCharacterIndex, var_6_2.lastVisibleCharacterIndex do
				local var_6_16 = var_6_5[iter_6_3]
				local var_6_17 = var_6_1:WorldToScreenPoint(arg_6_0.transform:TransformPoint(var_6_16.topLeft))

				if var_6_15 < var_6_17.y then
					var_6_15 = var_6_17.y
				end
			end

			var_6_14.y = var_6_15

			local var_6_18 = var_6_1:WorldToScreenPoint(arg_6_0.transform:TransformPoint(var_6_7.bottomRight))

			if iter_6_0 == 1 then
				arg_6_0._conMat:SetFloat(arg_6_0._LineMinYId, var_6_9.y)
				arg_6_0._conMat:SetFloat(arg_6_0._LineMaxYId, var_6_14.y + 10)

				for iter_6_4, iter_6_5 in pairs(arg_6_0._subMeshs) do
					if iter_6_5.materialForRendering then
						iter_6_5.materialForRendering:SetFloat(arg_6_0._LineMinYId, var_6_9.y)
						iter_6_5.materialForRendering:SetFloat(arg_6_0._LineMaxYId, var_6_14.y + 10)
						iter_6_5.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			else
				arg_6_0._conMat:SetFloat(arg_6_0._LineMinYId, var_6_9.y)
				arg_6_0._conMat:SetFloat(arg_6_0._LineMaxYId, var_6_14.y)

				for iter_6_6, iter_6_7 in pairs(arg_6_0._subMeshs) do
					if iter_6_7.materialForRendering then
						iter_6_7.materialForRendering:SetFloat(arg_6_0._LineMinYId, var_6_9.y)
						iter_6_7.materialForRendering:SetFloat(arg_6_0._LineMaxYId, var_6_14.y)
						iter_6_7.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			end

			local var_6_19 = arg_6_0.gameObject

			gohelper.setActive(var_6_19, false)
			gohelper.setActive(var_6_19, true)

			local var_6_20 = var_6_3 == var_6_4 and 1 or (arg_6_1 - var_6_3) / (var_6_4 - var_6_3)
			local var_6_21 = 1 - Mathf.Lerp(var_6_9.x - 10, var_6_18.x + 10, var_6_20) / var_6_0

			transformhelper.setLocalPos(arg_6_0.transform, arg_6_0._contentX, arg_6_0._contentY, var_6_21)
		end
	end
end

function var_0_0.onTextFinished(arg_7_0)
	arg_7_0:killTween()

	local var_7_0, var_7_1, var_7_2 = transformhelper.getLocalPos(arg_7_0.transform)

	transformhelper.setLocalPos(arg_7_0.transform, var_7_0, var_7_1, 0)
	arg_7_0._conMat:DisableKeyword("_GRADUAL_ON")

	for iter_7_0, iter_7_1 in pairs(arg_7_0._subMeshs) do
		if iter_7_1.materialForRendering then
			iter_7_1.materialForRendering:DisableKeyword("_GRADUAL_ON")
		end
	end

	arg_7_0:_doCallback()
end

function var_0_0.initText(arg_8_0)
	arg_8_0.transform = arg_8_0.text.transform
	arg_8_0.gameObject = arg_8_0.text.gameObject
	arg_8_0.canvasGroup = arg_8_0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_8_0._subMeshs = {}
	arg_8_0._conMat = arg_8_0.text.fontMaterial

	arg_8_0._conMat:EnableKeyword("_GRADUAL_ON")
	arg_8_0._conMat:DisableKeyword("_DISSOLVE_ON")

	local var_8_0 = UnityEngine.Shader

	arg_8_0._LineMinYId = var_8_0.PropertyToID("_LineMinY")
	arg_8_0._LineMaxYId = var_8_0.PropertyToID("_LineMaxY")
	arg_8_0._contentX, arg_8_0._contentY, _ = transformhelper.getLocalPos(arg_8_0.transform)

	local var_8_1 = arg_8_0.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_8_1 then
		local var_8_2 = var_8_1:GetEnumerator()

		while var_8_2:MoveNext() do
			local var_8_3 = var_8_2.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_8_0._subMeshs, var_8_3)
		end
	end

	arg_8_0.textInfo = arg_8_0.text:GetTextInfo(arg_8_0.content)
	arg_8_0.lineInfoList = {}

	local var_8_4 = 0

	for iter_8_0 = 1, arg_8_0.textInfo.lineCount do
		local var_8_5 = arg_8_0.textInfo.lineInfo[iter_8_0 - 1]
		local var_8_6 = var_8_4 + 1

		var_8_4 = var_8_4 + var_8_5.visibleCharacterCount

		table.insert(arg_8_0.lineInfoList, {
			var_8_5,
			var_8_6,
			var_8_4
		})
	end

	arg_8_0.characterCount = var_8_4
	arg_8_0.delayTime = arg_8_0:getDelayTime(var_8_4)
end

function var_0_0.getDelayTime(arg_9_0, arg_9_1)
	local var_9_0 = 4

	return 0.08 * arg_9_1 / var_9_0
end

function var_0_0.killTween(arg_10_0)
	if arg_10_0.tweenId then
		ZProj.TweenHelper.KillById(arg_10_0.tweenId)

		arg_10_0.tweenId = nil
	end

	if arg_10_0.moveId then
		ZProj.TweenHelper.KillById(arg_10_0.moveId)

		arg_10_0.moveId = nil
	end

	TaskDispatcher.cancelTask(arg_10_0._delayShow, arg_10_0)
end

function var_0_0.destroy(arg_11_0)
	arg_11_0:killTween()
	arg_11_0:__onDispose()
end

return var_0_0
