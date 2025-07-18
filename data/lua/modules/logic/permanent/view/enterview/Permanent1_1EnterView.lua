﻿module("modules.logic.permanent.view.enterview.Permanent1_1EnterView", package.seeall)

local var_0_0 = class("Permanent1_1EnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._btnEntranceRole1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	arg_1_0._goReddot1 = gohelper.findChild(arg_1_0.viewGO, "Left/EntranceRole1/#go_Reddot1")
	arg_1_0._btnEntranceRole2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	arg_1_0._goReddot2 = gohelper.findChild(arg_1_0.viewGO, "Left/EntranceRole2/#go_Reddot2")
	arg_1_0._btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Play")
	arg_1_0._btnEntranceDungeon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")
	arg_1_0._goReddot3 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Reddot3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEntranceRole1:AddClickListener(arg_2_0._btnEntranceRole1OnClick, arg_2_0)
	arg_2_0._btnEntranceRole2:AddClickListener(arg_2_0._btnEntranceRole2OnClick, arg_2_0)
	arg_2_0._btnPlay:AddClickListener(arg_2_0._btnPlayOnClick, arg_2_0)
	arg_2_0._btnEntranceDungeon:AddClickListener(arg_2_0._btnEntranceDungeonOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEntranceRole1:RemoveClickListener()
	arg_3_0._btnEntranceRole2:RemoveClickListener()
	arg_3_0._btnPlay:RemoveClickListener()
	arg_3_0._btnEntranceDungeon:RemoveClickListener()
end

function var_0_0._btnEntranceRole1OnClick(arg_4_0)
	local var_4_0 = ActivityConfig.instance:getActivityCo(VersionActivityEnum.ActivityId.Act108).confirmCondition

	if string.nilorempty(var_4_0) then
		MeilanniController.instance:openMeilanniMainView({
			checkStory = true
		})
	else
		local var_4_1 = string.split(var_4_0, "=")
		local var_4_2 = tonumber(var_4_1[2])
		local var_4_3 = PlayerModel.instance:getPlayinfo().userId
		local var_4_4 = PlayerPrefsKey.EnterRoleActivity .. "#" .. tostring(VersionActivityEnum.ActivityId.Act108) .. "#" .. tostring(var_4_3)
		local var_4_5 = PlayerPrefsHelper.getNumber(var_4_4, 0) == 1

		if OpenModel.instance:isFunctionUnlock(var_4_2) or var_4_5 then
			MeilanniController.instance:openMeilanniMainView({
				checkStory = true
			})
		else
			local var_4_6 = OpenConfig.instance:getOpenCo(var_4_2)
			local var_4_7 = DungeonConfig.instance:getEpisodeDisplay(var_4_6.episodeId)
			local var_4_8 = DungeonConfig.instance:getEpisodeCO(var_4_6.episodeId).name
			local var_4_9 = var_4_7 .. var_4_8

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(var_4_4, 1)
				MeilanniController.instance:openMeilanniMainView({
					checkStory = true
				})
			end, nil, nil, nil, nil, nil, var_4_9)
		end
	end
end

function var_0_0._btnEntranceRole2OnClick(arg_6_0)
	Activity109ChessController.instance:openEntry(VersionActivityEnum.ActivityId.Act109)
end

function var_0_0._btnPlayOnClick(arg_7_0)
	local var_7_0 = {}

	var_7_0.isVersionActivityPV = true

	StoryController.instance:playStory(arg_7_0.actCfg.storyId, var_7_0)
end

function var_0_0._btnEntranceDungeonOnClick(arg_8_0)
	VersionActivityDungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.actCfg = ActivityConfig.instance:getActivityCo(VersionActivityEnum.ActivityId.Act105)
end

function var_0_0.onOpen(arg_10_0)
	local var_10_0 = ActivityConfig.instance:getActivityCo(VersionActivityEnum.ActivityId.Act108)
	local var_10_1 = ActivityConfig.instance:getActivityCo(VersionActivityEnum.ActivityId.Act109)
	local var_10_2 = ActivityConfig.instance:getActivityCo(VersionActivityEnum.ActivityId.Act113)

	if var_10_0.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_10_0._goReddot1, var_10_0.redDotId)
	end

	if var_10_1.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_10_0._goReddot2, var_10_1.redDotId)
	end

	if var_10_2.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_10_0._goReddot3, var_10_2.redDotId)
	end
end

function var_0_0.onClose(arg_11_0)
	PermanentModel.instance:undateActivityInfo(arg_11_0.actCfg.id)
end

return var_0_0
