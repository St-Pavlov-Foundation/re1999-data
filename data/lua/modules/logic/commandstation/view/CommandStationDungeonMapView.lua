module("modules.logic.commandstation.view.CommandStationDungeonMapView", package.seeall)

local var_0_0 = class("CommandStationDungeonMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_commandstation")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_2_0.setEpisodeListVisible, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_2_0._onUpdateDungeonInfo, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_2_0._loadSceneFinish, arg_2_0)
end

function var_0_0._loadSceneFinish(arg_3_0, arg_3_1)
	arg_3_0.mapCfg = arg_3_1[1]
	arg_3_0.sceneGo = arg_3_1[2]
	arg_3_0.mapScene = arg_3_1[3]
	arg_3_0.episodeConfig = arg_3_1.episodeConfig

	arg_3_0:refreshView()
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._initBtn(arg_5_0)
	if arg_5_0._loader then
		return
	end

	local var_5_0 = "ui/viewres/commandstation/commandstation_dungeonmapenteritem.prefab"

	arg_5_0._loader = PrefabInstantiate.Create(arg_5_0._goroot)

	arg_5_0._loader:startLoad(var_5_0, arg_5_0._onResLoaded, arg_5_0)
end

function var_0_0._onResLoaded(arg_6_0)
	arg_6_0._btnGo = arg_6_0._loader:getInstGO()
	arg_6_0._btnEnter = gohelper.findChildButtonWithAudio(arg_6_0._btnGo, "#btn_enter")

	arg_6_0._btnEnter:AddClickListener(arg_6_0.onClickEnter, arg_6_0)

	arg_6_0._gored = gohelper.findChild(arg_6_0._btnGo, "#btn_enter/#go_reddot")
	arg_6_0._goFinish = gohelper.findChild(arg_6_0._btnGo, "#btn_enter/inside/finish")
	arg_6_0._goFinishEffect = gohelper.findChild(arg_6_0._btnGo, "#btn_enter/inside/finish/#saoguang")

	gohelper.setActive(arg_6_0._goFinishEffect, false)

	arg_6_0._goNotFinish = gohelper.findChild(arg_6_0._btnGo, "#btn_enter/inside/unfinish")
	arg_6_0._txt = gohelper.findChildText(arg_6_0._btnGo, "#btn_enter/inside/finish/time/#txt_time")
	arg_6_0._anim = arg_6_0._btnGo:GetComponent("Animator")

	arg_6_0:refreshView()

	if arg_6_0._anim then
		arg_6_0._anim:Play("open", 0, 0)
	end
end

function var_0_0.refreshView(arg_7_0)
	if not arg_7_0.viewParam then
		return
	end

	arg_7_0.chapterId = arg_7_0.viewParam.chapterId

	arg_7_0:onActStateChange()
	arg_7_0:_updateInfo()

	if arg_7_0._gored then
		-- block empty
	end
end

function var_0_0._updateInfo(arg_8_0, arg_8_1)
	if gohelper.isNil(arg_8_0._txt) or not arg_8_0.episodeConfig then
		return
	end

	arg_8_0._versionId = nil
	arg_8_0._timeId = nil

	local var_8_0 = arg_8_0.episodeConfig.chainEpisode > 0 and arg_8_0.episodeConfig.chainEpisode or arg_8_0.episodeConfig.id
	local var_8_1 = DungeonModel.instance:hasPassLevelAndStory(var_8_0)

	if arg_8_1 and not arg_8_0._isFinished and var_8_1 then
		gohelper.setActive(arg_8_0._goFinishEffect, false)
		gohelper.setActive(arg_8_0._goFinishEffect, true)
	end

	arg_8_0._isFinished = var_8_1

	gohelper.setActive(arg_8_0._goFinish, var_8_1)
	gohelper.setActive(arg_8_0._goNotFinish, not var_8_1)

	if var_8_1 then
		local var_8_2 = CommandStationConfig.instance:getTimeGroupByEpisodeId(var_8_0)
		local var_8_3 = var_8_2 and var_8_2.id or 0

		arg_8_0._versionId = var_8_2 and var_8_2.versionId
		arg_8_0._timeId = CommandStationConfig.instance:getTimeIdByEpisodeId(var_8_0)

		if var_8_3 > 0 then
			arg_8_0._txt.text = CommandStationConfig.instance:getTimePointName(var_8_3)
		else
			arg_8_0._txt.text = ""
		end
	end
end

function var_0_0._playAnim(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	return
end

function var_0_0._playAnim2(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_0._anim then
		arg_10_0._anim:Play(arg_10_1, arg_10_2, arg_10_3)
	end
end

function var_0_0.onOpen(arg_11_0)
	if arg_11_0.episodeConfig then
		arg_11_0:refreshView()
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	if arg_12_0.episodeConfig then
		arg_12_0:refreshView()
	end
end

function var_0_0.onOpenView(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.DungeonMapLevelView then
		arg_13_0:_playAnim("close", 0, 0)
	end
end

function var_0_0.onCloseViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.DungeonMapLevelView then
		arg_14_0:_playAnim("open", 0, 0)
	end
end

function var_0_0.setEpisodeListVisible(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 and arg_15_0._showRoot

	if not gohelper.isNil(arg_15_0._btnEnter) then
		arg_15_0._btnEnter.button.interactable = var_15_0
	end

	if var_15_0 then
		arg_15_0:_playAnim2("open", 0, 0)
	else
		arg_15_0:_playAnim2("close", 0, 0)
	end
end

function var_0_0._checkShowRoot(arg_16_0)
	arg_16_0._showRoot = arg_16_0:_isShowRoot()

	if arg_16_0._showRoot then
		arg_16_0:_initBtn()
		gohelper.setActive(arg_16_0._goroot, true)
	else
		gohelper.setActive(arg_16_0._goroot, false)
	end
end

function var_0_0._isShowRoot(arg_17_0)
	return CommandStationController.instance:chapterInCommandStation(arg_17_0.chapterId)
end

function var_0_0.onActStateChange(arg_18_0)
	arg_18_0:_checkShowRoot()
end

function var_0_0.onClickEnter(arg_19_0)
	if arg_19_0._versionId and arg_19_0._timeId then
		CommandStationMapModel.instance:setVersionId(arg_19_0._versionId)
		CommandStationMapModel.instance:setTimeId(arg_19_0._timeId)

		if not ViewMgr.instance:isOpen(ViewName.CommandStationMapView) then
			module_views_preloader.CommandStationMapViewPreload(function()
				CommandStationController.instance:openCommandStationMapView()
			end)
		else
			CommandStationController.instance:openCommandStationMapView()
		end

		return
	end

	GameFacade.showToast(ToastEnum.CommandStationTip1)
end

function var_0_0.onClose(arg_21_0)
	if arg_21_0._loader then
		arg_21_0._loader:dispose()

		arg_21_0._loader = nil
	end

	if arg_21_0._btnEnter then
		arg_21_0._btnEnter:RemoveClickListener()
	end
end

function var_0_0._onUpdateDungeonInfo(arg_22_0)
	arg_22_0:_updateInfo(true)
end

return var_0_0
