module("modules.logic.explore.view.ExploreInteractView", package.seeall)

local var_0_0 = class("ExploreInteractView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnfullscreen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fullscreen")
	arg_1_0._gochoicelist = gohelper.findChild(arg_1_0.viewGO, "#go_choicelist")
	arg_1_0._gochoiceitem = gohelper.findChild(arg_1_0.viewGO, "#go_choicelist/#go_choiceitem")
	arg_1_0._txttalkinfo = gohelper.findChildText(arg_1_0.viewGO, "go_normalcontent/txt_contentcn")
	arg_1_0._txttalker = gohelper.findChildText(arg_1_0.viewGO, "#txt_talker")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	NavigateMgr.instance:addSpace(ViewName.ExploreInteractView, arg_2_0.onClickFull, arg_2_0)
	arg_2_0._btnfullscreen:AddClickListener(arg_2_0.onClickFull, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_2_0.OnStoryDialogSelect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	NavigateMgr.instance:removeSpace(ViewName.ExploreInteractView)
	arg_3_0._btnfullscreen:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_3_0.OnStoryDialogSelect, arg_3_0)
end

function var_0_0.onClickFull(arg_4_0)
	if arg_4_0._hasIconDialogItem and arg_4_0._hasIconDialogItem:isPlaying() then
		arg_4_0._hasIconDialogItem:conFinished()

		return
	end

	if not arg_4_0._btnDatas[1] then
		arg_4_0._curStep = arg_4_0._curStep + 1

		if arg_4_0.config[arg_4_0._curStep] then
			arg_4_0:onStep()
		else
			if arg_4_0.viewParam.callBack then
				arg_4_0.viewParam.callBack(arg_4_0.viewParam.callBackObj)
			end

			arg_4_0:closeThis()
		end
	end
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)

	arg_5_0.config = ExploreConfig.instance:getDialogueConfig(arg_5_0.viewParam.id)

	if not arg_5_0.config then
		logError("对话配置不存在，id：" .. tostring(arg_5_0.viewParam.id))
		arg_5_0:closeThis()

		return
	end

	arg_5_0._curStep = 1

	arg_5_0:onStep()
end

function var_0_0.onStep(arg_6_0)
	local var_6_0 = arg_6_0.config[arg_6_0._curStep]

	if not var_6_0 or var_6_0.interrupt == 1 then
		if arg_6_0.viewParam.callBack then
			arg_6_0.viewParam.callBack(arg_6_0.viewParam.callBackObj)
		end

		arg_6_0:closeThis()

		return
	end

	local var_6_1 = string.gsub(var_6_0.desc, " ", " ")

	if not arg_6_0._hasIconDialogItem then
		arg_6_0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(arg_6_0.viewGO, TMPFadeIn)
	end

	arg_6_0._hasIconDialogItem:playNormalText(var_6_1)

	if var_6_0.audio and var_6_0.audio > 0 then
		GuideAudioMgr.instance:playAudio(var_6_0.audio)
	else
		GuideAudioMgr.instance:stopAudio()
	end

	arg_6_0._txttalker.text = var_6_0.speaker

	local var_6_2 = {}

	if not string.nilorempty(var_6_0.acceptButton) then
		table.insert(var_6_2, {
			accept = true,
			text = var_6_0.acceptButton
		})
	end

	if not string.nilorempty(var_6_0.refuseButton) then
		table.insert(var_6_2, {
			accept = false,
			text = var_6_0.refuseButton
		})
	end

	if not string.nilorempty(var_6_0.selectButton) then
		local var_6_3 = GameUtil.splitString2(var_6_0.selectButton)

		for iter_6_0, iter_6_1 in ipairs(var_6_3) do
			table.insert(var_6_2, {
				jumpStep = tonumber(iter_6_1[2]),
				text = iter_6_1[1]
			})
		end
	end

	gohelper.CreateObjList(arg_6_0, arg_6_0._createItem, var_6_2, arg_6_0._gochoicelist, arg_6_0._gochoiceitem)

	arg_6_0._btnDatas = var_6_2
end

function var_0_0._createItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	gohelper.findChildText(arg_7_1, "info").text = arg_7_2.text

	local var_7_0 = gohelper.findChildButtonWithAudio(arg_7_1, "click")

	arg_7_0:removeClickCb(var_7_0)
	arg_7_0:addClickCb(var_7_0, arg_7_0.onBtnClick, arg_7_0, arg_7_2)

	local var_7_1 = gohelper.findChild(arg_7_1, "#go_pcbtn")

	if var_7_1 then
		PCInputController.instance:showkeyTips(var_7_1, nil, nil, arg_7_3)
	end
end

function var_0_0.OnStoryDialogSelect(arg_8_0, arg_8_1)
	if arg_8_1 <= #arg_8_0._btnDatas and arg_8_1 > 0 then
		arg_8_0:onBtnClick(arg_8_0._btnDatas[arg_8_1])
	end
end

function var_0_0.onBtnClick(arg_9_0, arg_9_1)
	if arg_9_1.jumpStep then
		arg_9_0._curStep = arg_9_1.jumpStep

		arg_9_0:onStep()
	else
		if arg_9_1.accept then
			if arg_9_0.viewParam.callBack then
				arg_9_0.viewParam.callBack(arg_9_0.viewParam.callBackObj)
			end
		elseif arg_9_0.viewParam.refuseCallBack then
			arg_9_0.viewParam.refuseCallBack(arg_9_0.viewParam.refuseCallBackObj)
		end

		arg_9_0:closeThis()
	end
end

function var_0_0.onClose(arg_10_0)
	GuideAudioMgr.instance:stopAudio()
end

return var_0_0
