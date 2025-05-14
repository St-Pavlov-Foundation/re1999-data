module("modules.logic.explore.view.ExploreBonusSceneView", package.seeall)

local var_0_0 = class("ExploreBonusSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnfullscreen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fullscreen")
	arg_1_0._gochoicelist = gohelper.findChild(arg_1_0.viewGO, "#go_choicelist")
	arg_1_0._gochoiceitem = gohelper.findChild(arg_1_0.viewGO, "#go_choicelist/#go_choiceitem")
	arg_1_0._txttalkinfo = gohelper.findChildText(arg_1_0.viewGO, "#txt_talkinfo")
	arg_1_0._txttalker = gohelper.findChildText(arg_1_0.viewGO, "#txt_talker")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	NavigateMgr.instance:addSpace(ViewName.ExploreBonusSceneView, arg_2_0.onClickFull, arg_2_0)
	arg_2_0._btnfullscreen:AddClickListener(arg_2_0.onClickFull, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	NavigateMgr.instance:removeSpace(ViewName.ExploreBonusSceneView)
	arg_3_0._btnfullscreen:RemoveClickListener()
end

function var_0_0.onClickFull(arg_4_0)
	if arg_4_0._hasIconDialogItem and arg_4_0._hasIconDialogItem:isPlaying() then
		arg_4_0._hasIconDialogItem:conFinished()

		return
	end

	if not arg_4_0._btnDatas[1] then
		arg_4_0._curStep = arg_4_0._curStep + 1

		if arg_4_0.config[arg_4_0._curStep] then
			table.insert(arg_4_0.options, -1)
			arg_4_0:onStep()
		else
			if arg_4_0.viewParam.callBack then
				arg_4_0.viewParam.callBack(arg_4_0.viewParam.callBackObj, arg_4_0.options)
			end

			arg_4_0:closeThis()
		end
	end
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)

	arg_5_0.unit = arg_5_0.viewParam.unit
	arg_5_0.config = ExploreConfig.instance:getDialogueConfig(arg_5_0.viewParam.id)

	if not arg_5_0.config then
		logError("对话配置不存在，id：" .. tostring(arg_5_0.viewParam.id))
		arg_5_0:closeThis()

		return
	end

	arg_5_0.options = {}
	arg_5_0._curStep = 1

	arg_5_0:onStep()
end

function var_0_0.onStep(arg_6_0)
	local var_6_0 = arg_6_0.config[arg_6_0._curStep]
	local var_6_1 = string.gsub(var_6_0.desc, " ", " ")

	if not arg_6_0._hasIconDialogItem then
		arg_6_0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(arg_6_0.viewGO, TMPFadeIn)
	end

	arg_6_0._hasIconDialogItem:playNormalText(var_6_1)

	arg_6_0._txttalker.text = var_6_0.speaker

	local var_6_2 = {}

	if not string.nilorempty(var_6_0.bonusButton) then
		var_6_2 = string.split(var_6_0.bonusButton, "|")
	end

	gohelper.CreateObjList(arg_6_0, arg_6_0._createItem, var_6_2, arg_6_0._gochoicelist, arg_6_0._gochoiceitem)

	arg_6_0._btnDatas = var_6_2
end

function var_0_0._createItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	gohelper.findChildText(arg_7_1, "info").text = arg_7_2

	local var_7_0 = gohelper.findChildButtonWithAudio(arg_7_1, "click")

	arg_7_0:removeClickCb(var_7_0)
	arg_7_0:addClickCb(var_7_0, arg_7_0.onBtnClick, arg_7_0, arg_7_3)
end

function var_0_0.onBtnClick(arg_8_0, arg_8_1)
	table.insert(arg_8_0.options, arg_8_1)

	local var_8_0 = arg_8_0.config[arg_8_0._curStep]

	GameSceneMgr.instance:getCurScene().stat:onTriggerEggs(string.format("%d_%d", var_8_0.id, var_8_0.stepid), arg_8_0._btnDatas[arg_8_1])

	arg_8_0._btnDatas = {}

	arg_8_0:onClickFull()
end

return var_0_0
