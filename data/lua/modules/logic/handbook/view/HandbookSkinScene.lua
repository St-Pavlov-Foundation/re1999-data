module("modules.logic.handbook.view.HandbookSkinScene", package.seeall)

local var_0_0 = class("HandbookSkinScene", BaseView)
local var_0_1 = "scenes/v2a8_m_s17_pftj/prefab/skin_sence_01.prefab"
local var_0_2 = {
	[20011] = ViewName.HandbookSkinSuitDetailView2_1,
	[20012] = ViewName.HandbookSkinSuitDetailView2_2,
	[20014] = ViewName.HandbookSkinSuitDetailView2_4,
	[20009] = ViewName.HandbookSkinSuitDetailView1_9,
	[20018] = ViewName.HandbookSkinSuitDetailView2_8,
	[20013] = ViewName.HandbookSkinSuitDetailView2_3,
	[20010] = ViewName.HandbookSkinSuitDetailView2_0
}
local var_0_3 = "sence1down"
local var_0_4 = "sence1up"
local var_0_5 = "sence2down"
local var_0_6 = "sence2up"

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0.onScreenResize, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.OnClickSkinSuitFloorItem, arg_2_0.onClickFloorItem, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SwitchSkinSuitFloorDone, arg_2_0.onSwitchSkinSuitFloorDone, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SkinBookSlideToPre, arg_2_0.onSlideToPre, arg_2_0)
	arg_2_0:addEventCb(HandbookController.instance, HandbookEvent.SkinBookSlideToNext, arg_2_0.onSlideToNext, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickFloorItem(arg_4_0, arg_4_1)
	if arg_4_0._curSelectedIdx == arg_4_1 then
		return
	end

	if arg_4_1 > arg_4_0._curSelectedIdx then
		arg_4_0._isUp = true

		arg_4_0._sceneAnimatorPlayer:Play(var_0_3, arg_4_0.onOriSceneAniDone, arg_4_0)
	else
		arg_4_0._isUp = false

		arg_4_0._sceneAnimatorPlayer:Play(var_0_4, arg_4_0.onOriSceneAniDone, arg_4_0)
	end

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_floor_switch)

	arg_4_0._curSelectedIdx = arg_4_1
end

function var_0_0.onOriSceneAniDone(arg_5_0)
	arg_5_0:updateSuitGroupData(arg_5_0._curSelectedIdx)
	arg_5_0:_refreshScene(arg_5_0._skinSuitGroupCfgList[arg_5_0._curSelectedIdx].id)
	arg_5_0:_createSuitItems()
end

function var_0_0.onSwitchSkinSuitFloorDone(arg_6_0)
	if arg_6_0._isUp then
		arg_6_0._sceneAnimatorPlayer:Play(var_0_5)
	else
		arg_6_0._sceneAnimatorPlayer:Play(var_0_6)
	end
end

function var_0_0.onSlideToPre(arg_7_0)
	if arg_7_0._moveToOtherSuitAni then
		return
	end

	if arg_7_0._suitIdx > 1 then
		arg_7_0:slideToSuitIdx(arg_7_0._suitIdx - 1)
	end
end

function var_0_0.onSlideToNext(arg_8_0)
	if arg_8_0._moveToOtherSuitAni then
		return
	end

	if arg_8_0._suitIdx < arg_8_0._suitCount then
		arg_8_0:slideToSuitIdx(arg_8_0._suitIdx + 1)
	end
end

function var_0_0.slideToSuitIdx(arg_9_0, arg_9_1)
	if arg_9_0._suitIdx ~= arg_9_1 then
		if arg_9_1 < arg_9_0._suitIdx then
			arg_9_0._sceneAnimator:SetFloat("Speed", 1)
			arg_9_0._sceneAnimator:Play(string.format("path_0%d_2", arg_9_1), 0, 0)
			AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_switch_2)
		else
			arg_9_0._sceneAnimator:SetFloat("Speed", 1)
			arg_9_0._sceneAnimator:Play(string.format("path_0%d_1", arg_9_0._suitIdx), 0, 0)
			AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_switch_1)
		end

		arg_9_0._moveToOtherSuitAni = true
		arg_9_0._suitIdx = arg_9_1

		TaskDispatcher.runDelay(arg_9_0._onMoveToOtherSuitAniDone, arg_9_0, 1)
		arg_9_0:_refreshPoint()
	end
end

function var_0_0._onMoveToOtherSuitAniDone(arg_10_0)
	arg_10_0._moveToOtherSuitAni = false
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = arg_11_0.viewParam

	arg_11_0.sceneVisible = true
	arg_11_0._defaultSelectedIdx = var_11_0 and var_11_0.defaultSelectedIdx or 1
	arg_11_0._skinSuitGroupCfgList = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)

	arg_11_0:updateSuitGroupData(arg_11_0._defaultSelectedIdx)
	arg_11_0:_refreshScene(arg_11_0._curskinSuitGroupCfg.id)
	arg_11_0:_createSuitItems()
	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_amb_loop)
end

function var_0_0.setSceneActive(arg_12_0, arg_12_1)
	if arg_12_0._sceneRoot then
		gohelper.setActive(arg_12_0._sceneRoot, arg_12_1)
	end
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0:onScreenResize()

	local var_14_0 = CameraMgr.instance:getSceneRoot()

	arg_14_0._sceneRoot = UnityEngine.GameObject.New("HandbookSkinScene")

	gohelper.addChild(var_14_0, arg_14_0._sceneRoot)
end

function var_0_0.onScreenResize(arg_15_0)
	return
end

function var_0_0.resetCamera(arg_16_0)
	return
end

function var_0_0.updateSuitGroupData(arg_17_0, arg_17_1)
	arg_17_0._curSelectedIdx = arg_17_1
	arg_17_0._curskinSuitGroupCfg = arg_17_0._skinSuitGroupCfgList[arg_17_0._curSelectedIdx]
	arg_17_0._curSuitGroupId = arg_17_0._curskinSuitGroupCfg.id
	arg_17_0._suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(arg_17_0._curskinSuitGroupCfg.id)
	arg_17_0._suitCount = #arg_17_0._suitCfgList

	table.sort(arg_17_0._suitCfgList, arg_17_0._suitCfgSort)

	arg_17_0._suitIdx = 1

	arg_17_0:_refreshPoint()
end

function var_0_0._refreshPoint(arg_18_0)
	arg_18_0.viewContainer:dispatchEvent(HandbookEvent.SkinPointChanged, arg_18_0._suitIdx, arg_18_0._suitCount)
end

function var_0_0._suitCfgSort(arg_19_0, arg_19_1)
	if arg_19_0.show == 1 and arg_19_1.show == 0 then
		return true
	elseif arg_19_0.show == 0 and arg_19_1.show == 1 then
		return false
	else
		return arg_19_0.id > arg_19_1.id
	end
end

function var_0_0._refreshScene(arg_20_0, arg_20_1)
	if arg_20_0._curSceneGo then
		gohelper.destroy(arg_20_0._curSceneGo)

		arg_20_0._curSceneGo = nil
	end

	local var_20_0 = HandbookConfig.instance:getSkinThemeGroupCfg(arg_20_1).scenePath

	if string.nilorempty(var_20_0) then
		var_20_0 = var_0_1
	end

	local var_20_1 = arg_20_0:getResInst(var_20_0, arg_20_0._sceneRoot)

	arg_20_0._curSceneGo = var_20_1

	local var_20_2 = gohelper.findChild(var_20_1, "cvure"):GetComponent(typeof(ZProj.SplineFollow))

	if var_20_2 == nil then
		return
	end

	local var_20_3 = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(var_20_3, true)

	local var_20_4 = CameraMgr.instance:getCameraTraceGO()

	var_20_2:Add(var_20_4.transform, 0)

	arg_20_0._cameraRootAnimator = gohelper.onceAddComponent(var_20_4, typeof(UnityEngine.Animator))

	local var_20_5 = arg_20_0.viewContainer:getSetting().otherRes[1]
	local var_20_6 = arg_20_0.viewContainer._abLoader:getAssetItem(var_20_5):GetResource()

	arg_20_0._cameraRootAnimator.runtimeAnimatorController = var_20_6

	arg_20_0._cameraRootAnimator:Rebind()

	arg_20_0._sceneAnimator = arg_20_0._curSceneGo:GetComponent(gohelper.Type_Animator)
	arg_20_0._sceneAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_20_0._curSceneGo)
end

function var_0_0._createSuitItems(arg_21_0)
	arg_21_0._suitIconRootDict = arg_21_0:getUserDataTb_()

	if arg_21_0._suitItemLoaderList and #arg_21_0._suitItemLoaderList > 0 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._suitItemLoaderList) do
			if iter_21_1 then
				iter_21_1:dispose()
			end
		end
	end

	arg_21_0._suitItemLoaderList = {}
	arg_21_0._suitId2IdxMap = {}

	for iter_21_2 = 1, #arg_21_0._suitCfgList do
		local var_21_0 = arg_21_0._suitCfgList[iter_21_2]

		arg_21_0._suitId2IdxMap[var_21_0.id] = iter_21_2

		local var_21_1 = gohelper.findChild(arg_21_0._curSceneGo, "sence/Icon/icon0" .. iter_21_2)

		if var_21_1 then
			gohelper.setLayer(var_21_1, UnityLayer.Scene, true)

			arg_21_0._suitIconRootDict[var_21_0.id] = var_21_1

			if var_21_0.highId == arg_21_0._curSuitGroupId then
				local var_21_2 = var_21_0.show and var_21_0.id or 10000
				local var_21_3 = string.format("scenes/v2a8_m_s17_pftj/prefab/icon_e/%d.prefab", var_21_2)
				local var_21_4 = PrefabInstantiate.Create(var_21_1)

				arg_21_0._suitItemLoaderList[#arg_21_0._suitItemLoaderList + 1] = var_21_4

				var_21_4:startLoad(var_21_3, function(arg_22_0)
					local var_22_0 = arg_22_0:getInstGO()

					if not gohelper.isNil(var_22_0) then
						local var_22_1 = MonoHelper.addLuaComOnceToGo(var_22_0, HandbookSkinSuitComp, {
							var_21_0.id
						})
					end
				end)

				local var_21_5 = gohelper.findChild(var_21_1, "root")

				if var_21_5 then
					gohelper.setActive(var_21_5, false)
				end
			end

			arg_21_0:addBoxColliderListener(var_21_1, var_21_0.id)
		end
	end
end

function var_0_0.addBoxColliderListener(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = var_0_0.addBoxCollider2D(arg_23_1)

	var_23_0:AddClickListener(arg_23_0.onIconMouseDown, arg_23_0, arg_23_2)
	var_23_0:AddMouseUpListener(arg_23_0.onIconMouseUp, arg_23_0, arg_23_2)
end

function var_0_0.addBoxCollider2D(arg_24_0)
	local var_24_0 = ZProj.BoxColliderClickListener.Get(arg_24_0)
	local var_24_1 = arg_24_0:GetComponent(typeof(UnityEngine.BoxCollider2D))

	if not var_24_1 then
		var_24_1 = gohelper.onceAddComponent(arg_24_0, typeof(UnityEngine.BoxCollider2D))
		var_24_1.size = Vector2(4, 4)
	end

	var_24_1.enabled = true

	var_24_0:SetIgnoreUI(true)

	return var_24_0
end

function var_0_0.onIconMouseUp(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._mouseTouchSuitId

	arg_25_0._mouseTouchSuitId = nil

	if var_25_0 == arg_25_1 then
		local var_25_1 = UnityEngine.Input.mousePosition
		local var_25_2 = math.abs(arg_25_0._mouseX - var_25_1.x)
		local var_25_3 = math.abs(arg_25_0._mouseY - var_25_1.y)
		local var_25_4 = 15

		if var_25_2 <= var_25_4 and var_25_3 <= var_25_4 then
			arg_25_0:onIconClick(arg_25_1)
		end
	end
end

function var_0_0.onIconMouseDown(arg_26_0, arg_26_1)
	arg_26_0._mouseTouchSuitId = arg_26_1

	local var_26_0 = UnityEngine.Input.mousePosition

	arg_26_0._mouseX = var_26_0.x
	arg_26_0._mouseY = var_26_0.y
end

function var_0_0.onIconClick(arg_27_0, arg_27_1)
	if arg_27_0._moveToOtherSuitAni then
		return
	end

	if not arg_27_0.sceneVisible then
		return
	end

	local var_27_0 = arg_27_0._suitId2IdxMap[arg_27_1]

	if arg_27_0._suitIdx == var_27_0 - 1 then
		arg_27_0._suitIdx = var_27_0

		local var_27_1 = var_27_0

		arg_27_0._sceneAnimator:SetFloat("Speed", 1)
		arg_27_0._sceneAnimator:Play(string.format("path_0%d_1", var_27_1 - 1), 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_switch_1)

		arg_27_0._moveToOtherSuitAni = true

		TaskDispatcher.runDelay(arg_27_0._onMoveToOtherSuitAniDone, arg_27_0, 1)
	else
		local var_27_2 = var_0_2[arg_27_1]

		if var_27_2 then
			local var_27_3 = {
				skinThemeGroupId = arg_27_1
			}

			ViewMgr.instance:openView(var_27_2, var_27_3)
		end

		AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_open)
		HandbookController.instance:statSkinSuitDetail(arg_27_1)
	end

	arg_27_0:_refreshPoint()
end

function var_0_0.playSceneEnterAni(arg_28_0, arg_28_1)
	return
end

function var_0_0.playSceneEnterAniEnd(arg_29_0)
	return
end

function var_0_0.playCloseAni(arg_30_0)
	local var_30_0 = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(var_30_0, false)

	if arg_30_0._cameraRootAnimator then
		arg_30_0._cameraRootAnimator:Rebind()
		arg_30_0._cameraRootAnimator:Play(UIAnimationName.Close, 0, 0)
	end
end

function var_0_0.onClose(arg_31_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)

	if arg_31_0._cameraRootAnimator then
		arg_31_0._cameraRootAnimator:Rebind()
		arg_31_0._cameraRootAnimator:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(var_0_0.delayRemoveAnimator, nil, 0.1)
	end
end

function var_0_0.delayRemoveAnimator(arg_32_0)
	local var_32_0 = CameraMgr.instance:getCameraTraceGO()
	local var_32_1 = gohelper.onceAddComponent(var_32_0, typeof(UnityEngine.Animator))

	if var_32_1 then
		gohelper.removeComponent(var_32_1.gameObject, typeof(UnityEngine.Animator))
	end
end

function var_0_0.onDestroyView(arg_33_0)
	if arg_33_0._sceneRoot then
		gohelper.destroy(arg_33_0._sceneRoot)

		arg_33_0._sceneRoot = nil
	end

	if arg_33_0._chapterSceneUdtbDict then
		arg_33_0._chapterSceneUdtbDict = nil
	end

	if arg_33_0._suitItemLoaderList and #arg_33_0._suitItemLoaderList > 0 then
		for iter_33_0, iter_33_1 in ipairs(arg_33_0._suitItemLoaderList) do
			if iter_33_1 then
				iter_33_1:dispose()
			end
		end
	end
end

return var_0_0
