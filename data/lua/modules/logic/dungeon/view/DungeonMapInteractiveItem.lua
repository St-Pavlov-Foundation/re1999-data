module("modules.logic.dungeon.view.DungeonMapInteractiveItem", package.seeall)

local var_0_0 = class("DungeonMapInteractiveItem", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goclosenormal = gohelper.findChild(arg_1_0.viewGO, "#btn_close/image")
	arg_1_0._goclosesp = gohelper.findChild(arg_1_0.viewGO, "#btn_close/v2a6_closeicon")
	arg_1_0._btnfightuiuse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fight_ui_use")
	arg_1_0._gonormalbg = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/bgimag")
	arg_1_0._gomain1_9bg = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/v2a6_descbg")
	arg_1_0._gospbg = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/v2a6_descbg2")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/bg/#txt_info")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_mask")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_mask/#go_scroll")
	arg_1_0._gochatarea = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_chatarea")
	arg_1_0._gochatitem = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_chatarea/#go_chatitem")
	arg_1_0._goimportanttips = gohelper.findChild(arg_1_0.viewGO, "rotate/bg/#go_importanttips")
	arg_1_0._txttipsinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/bg/#go_importanttips/bg/#txt_tipsinfo")
	arg_1_0._goop1 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op1")
	arg_1_0._txtdoit = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op1/bg/#txt_doit")
	arg_1_0._btndoit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op1/bg/#btn_doit")
	arg_1_0._goop2 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op2")
	arg_1_0._gofinishFight = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op2/#go_finishFight")
	arg_1_0._txtwin = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op2/#go_finishFight/bg/#txt_win")
	arg_1_0._btnwin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op2/#go_finishFight/bg/#btn_win")
	arg_1_0._gounfinishedFight = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op2/#go_unfinishedFight")
	arg_1_0._txtfight = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op2/#go_unfinishedFight/bg/#txt_fight")
	arg_1_0._btnfight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op2/#go_unfinishedFight/bg/#btn_fight")
	arg_1_0._goop3 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op3")
	arg_1_0._gounfinishtask = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op3/#go_unfinishtask")
	arg_1_0._txtunfinishtask = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op3/#go_unfinishtask/#txt_unfinishtask")
	arg_1_0._btnunfinishtask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op3/#go_unfinishtask/#btn_unfinishtask")
	arg_1_0._gofinishtask = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op3/#go_finishtask")
	arg_1_0._txtfinishtask = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op3/#go_finishtask/#txt_finishtask")
	arg_1_0._btnfinishtask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op3/#go_finishtask/#btn_finishtask")
	arg_1_0._goop4 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4")
	arg_1_0._gonext = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4/#go_next")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op4/#go_next/#btn_next")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4/#go_options")
	arg_1_0._gotalkitem = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4/#go_options/#go_talkitem")
	arg_1_0._gofinishtalk = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op4/#go_finishtalk")
	arg_1_0._btnfinishtalk = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op4/#go_finishtalk/#btn_finishtalk")
	arg_1_0._goop5 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op5")
	arg_1_0._gosubmit = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op5/#go_submit")
	arg_1_0._btnsubmit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op5/#go_submit/#btn_submit")
	arg_1_0._inputanswer = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "rotate/#go_op5/#input_answer")
	arg_1_0._goop8 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op8")
	arg_1_0._gopuzzlequestion = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op8/#go_puzzle_question")
	arg_1_0._txtpuzzlequestion = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op8/#go_puzzle_question/#txt_puzzle_question")
	arg_1_0._btnpuzzlequestion = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op8/#go_puzzle_question/#btn_puzzle_question")
	arg_1_0._gopuzzlequestionfinish = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op8/#go_puzzle_question_finish")
	arg_1_0._btnpuzzlequestionfinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op8/#go_puzzle_question_finish/#btn_puzzle_question_finish")
	arg_1_0._goop9 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op9")
	arg_1_0._gopipe = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op9/#go_pipe")
	arg_1_0._txtpuzzlepipe = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op9/#go_pipe/#txt_puzzle_pipe")
	arg_1_0._btnpuzzlepipe = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op9/#go_pipe/#btn_puzzle_pipe")
	arg_1_0._gopipefinish = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op9/#go_pipe_finish")
	arg_1_0._btnpipefinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op9/#go_pipe_finish/#btn_pipe_finish")
	arg_1_0._goop10 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op10")
	arg_1_0._gochangecolor = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op10/#go_changecolor")
	arg_1_0._txtpuzzlechangecolor = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op10/#go_changecolor/#txt_changecolor_pipe")
	arg_1_0._btnpuzzlechangecolor = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op10/#go_changecolor/#btn_puzzle_changecolor")
	arg_1_0._gochangecolorfinish = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op10/#go_changecolor_finish")
	arg_1_0._btnchangecolorfinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op10/#go_changecolor_finish/#btn_changecolor_finish")
	arg_1_0._goop12 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op12")
	arg_1_0._gomazedraw = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op12/#go_maze_draw")
	arg_1_0._txtmazedraw = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op12/#go_maze_draw/#txt_maze_draw")
	arg_1_0._btnmazedraw = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op12/#go_maze_draw/#btn_maze_draw")
	arg_1_0._gomazedrawfinish = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op12/#go_maze_draw_finish")
	arg_1_0._btnmazedrawfinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op12/#go_maze_draw_finish/#btn_maze_draw_finish")
	arg_1_0._goop13 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op13")
	arg_1_0._gocubegame = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op13/#go_cube_game")
	arg_1_0._btncubegame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op13/#go_cube_game/#btn_cube_game")
	arg_1_0._gocubegamefinish = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op13/#go_cube_game_finish")
	arg_1_0._btncubegamefinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op13/#go_cube_game_finish/#btn_cube_game_finish")
	arg_1_0._goop15 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op15")
	arg_1_0._goouijagame = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op15/#go_ouija_game")
	arg_1_0._txtouija = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op15/#go_ouija_game/#txt_ouija_game")
	arg_1_0._btnouijagame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op15/#go_ouija_game/#btn_ouija_game")
	arg_1_0._goouijagamefinish = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op15/#go_ouija_game_finish")
	arg_1_0._btnouijagamefinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op15/#go_ouija_game_finish/#btn_ouija_game_finish")
	arg_1_0._goop18 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op18")
	arg_1_0._txtdodialog = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op18/bg/#txt_dodialog")
	arg_1_0._btndodialog = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op18/bg/#btn_dodialog")
	arg_1_0._goop101 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op101")
	arg_1_0._goop101puzzle = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle")
	arg_1_0._txt101puzzle = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle/#txt_puzzle")
	arg_1_0._btn101puzzle = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle/#btn_puzzle")
	arg_1_0._goop101puzzlefinish = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle_finish")
	arg_1_0._btn101puzzlefinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle_finish/#btn_puzzle_finish")
	arg_1_0._goop102 = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op102")
	arg_1_0._txt102ok = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op102/go_102ok/#txt_102")
	arg_1_0._btn102ok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op102/go_102ok/#btn_102ok")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	arg_1_0._gonormaltitle = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/top/title")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "rotate/layout/top/title/#txt_title")
	arg_1_0._gosptitle = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/top/v2a6_title")
	arg_1_0._txtsptitle = gohelper.findChildText(arg_1_0.viewGO, "rotate/layout/top/v2a6_title/#txt_title")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnfightuiuse:AddClickListener(arg_2_0._btnfightuiuseOnClick, arg_2_0)
	arg_2_0._btndoit:AddClickListener(arg_2_0._btndoitOnClick, arg_2_0)
	arg_2_0._btnwin:AddClickListener(arg_2_0._btnwinOnClick, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnunfinishtask:AddClickListener(arg_2_0._btnunfinishtaskOnClick, arg_2_0)
	arg_2_0._btnfinishtask:AddClickListener(arg_2_0._btnfinishtaskOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnfinishtalk:AddClickListener(arg_2_0._btnfinishtalkOnClick, arg_2_0)
	arg_2_0._btnsubmit:AddClickListener(arg_2_0._btnsubmitOnClick, arg_2_0)
	arg_2_0._btnpuzzlequestion:AddClickListener(arg_2_0._btnpuzzlequestionOnClick, arg_2_0)
	arg_2_0._btnpuzzlequestionfinish:AddClickListener(arg_2_0._btnpuzzlequestionfinishOnClick, arg_2_0)
	arg_2_0._btnpuzzlepipe:AddClickListener(arg_2_0._btnpuzzlepipeOnClick, arg_2_0)
	arg_2_0._btnpipefinish:AddClickListener(arg_2_0._btnpipefinishOnClick, arg_2_0)
	arg_2_0._btnpuzzlechangecolor:AddClickListener(arg_2_0._btnpuzzlechangecolorOnClick, arg_2_0)
	arg_2_0._btnchangecolorfinish:AddClickListener(arg_2_0._btnchangecolorfinishOnClick, arg_2_0)
	arg_2_0._btnmazedraw:AddClickListener(arg_2_0._btnmazedrawOnClick, arg_2_0)
	arg_2_0._btnmazedrawfinish:AddClickListener(arg_2_0._btnmazedrawfinishOnClick, arg_2_0)
	arg_2_0._btncubegame:AddClickListener(arg_2_0._btnputcubegameOnClick, arg_2_0)
	arg_2_0._btncubegamefinish:AddClickListener(arg_2_0._btnPutCubeGameFinishOnClick, arg_2_0)
	arg_2_0._btnouijagame:AddClickListener(arg_2_0._btnOuijagameOnClick, arg_2_0)
	arg_2_0._btnouijagamefinish:AddClickListener(arg_2_0._btnOuijaGameFinishOnClick, arg_2_0)
	arg_2_0._inputanswer:AddOnEndEdit(arg_2_0._onInputAnswerEndEdit, arg_2_0)
	arg_2_0._btndodialog:AddClickListener(arg_2_0._btndodialogOnClick, arg_2_0)
	arg_2_0._btn101puzzle:AddClickListener(arg_2_0._btn101PuzzleGameOnClick, arg_2_0)
	arg_2_0._btn101puzzlefinish:AddClickListener(arg_2_0._btn101PuzzleGameFinishOnClick, arg_2_0)
	arg_2_0._btn102ok:AddClickListener(arg_2_0._btn102okOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnfightuiuse:RemoveClickListener()
	arg_3_0._btndoit:RemoveClickListener()
	arg_3_0._btnwin:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
	arg_3_0._btnunfinishtask:RemoveClickListener()
	arg_3_0._btnfinishtask:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnfinishtalk:RemoveClickListener()
	arg_3_0._btnsubmit:RemoveClickListener()
	arg_3_0._btnpuzzlequestion:RemoveClickListener()
	arg_3_0._btnpuzzlequestionfinish:RemoveClickListener()
	arg_3_0._btnpuzzlepipe:RemoveClickListener()
	arg_3_0._btnpipefinish:RemoveClickListener()
	arg_3_0._btnpuzzlechangecolor:RemoveClickListener()
	arg_3_0._btnchangecolorfinish:RemoveClickListener()
	arg_3_0._btnmazedraw:RemoveClickListener()
	arg_3_0._btnmazedrawfinish:RemoveClickListener()
	arg_3_0._btncubegame:RemoveClickListener()
	arg_3_0._btncubegamefinish:RemoveClickListener()
	arg_3_0._btnouijagame:RemoveClickListener()
	arg_3_0._btnouijagamefinish:RemoveClickListener()
	arg_3_0._inputanswer:RemoveOnEndEdit()
	arg_3_0._btndodialog:RemoveClickListener()
	arg_3_0._btn101puzzle:RemoveClickListener()
	arg_3_0._btn101puzzlefinish:RemoveClickListener()
	arg_3_0._btn102ok:RemoveClickListener()
end

function var_0_0._btnfightuiuseOnClick(arg_4_0)
	arg_4_0:_btnfightOnClick()
end

function var_0_0._btnsubmitOnClick(arg_5_0)
	local var_5_0 = arg_5_0._inputanswer:GetText()
	local var_5_1 = arg_5_0._config.param

	if not string.nilorempty(arg_5_0._config.paramLang) then
		var_5_1 = arg_5_0._config.paramLang
	end

	if var_5_0 == var_5_1 then
		arg_5_0:_onHide()
		DungeonRpc.instance:sendMapElementRequest(arg_5_0._config.id)
	else
		arg_5_0._inputanswer:SetText("")
		GameFacade.showToast(ToastEnum.DungeonMapInteractive)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btncloseOnClick(arg_6_0)
	if arg_6_0._playScrollAnim then
		return
	end

	arg_6_0:_onHide()
end

function var_0_0._closeMapInteractiveItem(arg_7_0)
	arg_7_0:_onHide()
end

function var_0_0._btnfinishtalkOnClick(arg_8_0)
	arg_8_0:_onHide()

	local var_8_0 = DungeonMapModel.instance:getDialogId()

	DungeonRpc.instance:sendMapElementRequest(arg_8_0._config.id, var_8_0)
	DungeonMapModel.instance:clearDialogId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btndoitOnClick(arg_9_0)
	arg_9_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_9_0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btndodialogOnClick(arg_10_0)
	arg_10_0:_onHide()

	local var_10_0 = tonumber(arg_10_0._config.param)

	DialogueController.instance:enterDialogue(var_10_0, arg_10_0._onPlayDialogFinished, arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._onPlayDialogFinished(arg_11_0)
	local var_11_0 = tonumber(arg_11_0._config.param)

	if not DialogueModel.instance:isFinishDialogue(var_11_0) then
		return
	end

	DungeonRpc.instance:sendMapElementRequest(arg_11_0._config.id)
end

function var_0_0._btnfightOnClick(arg_12_0)
	arg_12_0:_onHide()

	local var_12_0 = tonumber(arg_12_0._config.param)

	DungeonModel.instance.curLookEpisodeId = var_12_0

	if TeachNoteModel.instance:isTeachNoteEpisode(var_12_0) then
		TeachNoteController.instance:enterTeachNoteDetailView(var_12_0)
	else
		local var_12_1 = DungeonConfig.instance:getEpisodeCO(var_12_0)

		DungeonFightController.instance:enterFight(var_12_1.chapterId, var_12_0)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnwinOnClick(arg_13_0)
	arg_13_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_13_0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnunfinishtaskOnClick(arg_14_0)
	arg_14_0:_onHide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnfinishtaskOnClick(arg_15_0)
	arg_15_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_15_0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnnextOnClick(arg_16_0)
	if arg_16_0._playScrollAnim then
		return
	end

	arg_16_0:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnpuzzlequestionOnClick(arg_17_0)
	arg_17_0:_asynHide(ViewName.DungeonPuzzleQuestionView)
	DungeonPuzzleQuestionModel.instance:initByElementCo(arg_17_0._config)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleQuestionView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnpuzzlequestionfinishOnClick(arg_18_0)
	arg_18_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_18_0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnpuzzlepipeOnClick(arg_19_0)
	if arg_19_0._config.type == DungeonEnum.ElementType.CircuitGame then
		arg_19_0:_asynHide(ViewName.DungeonPuzzleCircuitView)
		DungeonPuzzleCircuitController.instance:openGame(arg_19_0._config)

		return
	end

	arg_19_0:_asynHide(ViewName.DungeonPuzzlePipeView)
	DungeonPuzzlePipeController.instance:openGame(arg_19_0._config)
end

function var_0_0._btn102okOnClick(arg_20_0)
	arg_20_0:_onHide()

	local var_20_0 = string.splitToNumber(arg_20_0._config.param, "#")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	StoryController.instance:playStories(var_20_0, nil, arg_20_0._onPlayStoryFinished, arg_20_0)
end

function var_0_0._onPlayStoryFinished(arg_21_0)
	DungeonRpc.instance:sendMapElementRequest(arg_21_0._config.id)
end

function var_0_0._btnpipefinishOnClick(arg_22_0)
	arg_22_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_22_0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnpuzzlechangecolorOnClick(arg_23_0)
	arg_23_0:_asynHide(ViewName.DungeonPuzzleChangeColorView)
	DungeonPuzzleChangeColorController.instance:enterDecryptChangeColor(tonumber(arg_23_0._config.param))
end

function var_0_0._btnmazedrawOnClick(arg_24_0)
	arg_24_0:_asynHide(ViewName.DungeonPuzzleMazeDrawView)
	DungeonPuzzleMazeDrawController.instance:openGame(arg_24_0._config)
end

function var_0_0._btnmazedrawfinishOnClick(arg_25_0)
	arg_25_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_25_0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btnputcubegameOnClick(arg_26_0)
	arg_26_0:_asynHide(ViewName.PutCubeGameView)
	DungeonController.instance:openPutCubeGameView(arg_26_0._config)
end

function var_0_0._btnPutCubeGameFinishOnClick(arg_27_0)
	arg_27_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_27_0._config.id)
end

function var_0_0._btnOuijagameOnClick(arg_28_0)
	arg_28_0:_asynHide(ViewName.DungeonPuzzleOuijaView)
	AudioMgr.instance:trigger(AudioEnum.PuzzleOuija.play_ui_checkpoint_boat_open)
	DungeonController.instance:openOuijaGameView(arg_28_0._config)
end

function var_0_0._btnOuijaGameFinishOnClick(arg_29_0)
	arg_29_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_29_0._config.id)
end

function var_0_0._btnchangecolorfinishOnClick(arg_30_0)
	arg_30_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_30_0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btn101PuzzleGameOnClick(arg_31_0)
	arg_31_0:_onHide()
	ViewMgr.instance:openView(ViewName.VersionActivityPuzzleView, {
		elementCo = arg_31_0._config
	})
end

function var_0_0._btn101PuzzleGameFinishOnClick(arg_32_0)
	arg_32_0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(arg_32_0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._btntalkitemOnClick(arg_33_0)
	return
end

function var_0_0._editableInitView(arg_34_0)
	DungeonMapModel.instance:setMapInteractiveItemVisible(true)

	arg_34_0._nextAnimator = arg_34_0._gonext:GetComponent(typeof(UnityEngine.Animator))
	arg_34_0._imgMask = arg_34_0._gomask:GetComponent(gohelper.Type_Image)
	arg_34_0._simagebgimage = gohelper.findChildSingleImage(arg_34_0.viewGO, "rotate/bg/bgimag")
	arg_34_0._simageanswerbg = gohelper.findChildSingleImage(arg_34_0.viewGO, "rotate/#go_op5/#input_answer")

	arg_34_0:_loadBgImage()
	arg_34_0._simageanswerbg:LoadImage(ResUrl.getDungeonInteractiveItemBg("zhangjiedatidi_071"))

	arg_34_0._goplaceholdertext = gohelper.findChild(arg_34_0.viewGO, "rotate/#go_op5/#input_answer/Text Area/Placeholder")

	SLFramework.UGUI.UIClickListener.Get(arg_34_0._inputanswer.gameObject):AddClickListener(arg_34_0._hidePlaceholderText, arg_34_0)
end

function var_0_0._loadBgImage(arg_35_0)
	arg_35_0._simagebgimage:LoadImage(ResUrl.getDungeonInteractiveItemBg("kuang1"))
end

function var_0_0._onScreenResize(arg_36_0)
	DungeonMapModel.instance.directFocusElement = true

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, arg_36_0._config.id)

	DungeonMapModel.instance.directFocusElement = false
end

function var_0_0._hidePlaceholderText(arg_37_0)
	gohelper.setActive(arg_37_0._goplaceholdertext, false)
end

function var_0_0._onInputAnswerEndEdit(arg_38_0)
	gohelper.setActive(arg_38_0._goplaceholdertext, true)
end

function var_0_0._playAnim(arg_39_0, arg_39_1, arg_39_2)
	arg_39_1:GetComponent(typeof(UnityEngine.Animator)):Play(arg_39_2)
end

function var_0_0._playBtnsQuitAnim(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(DungeonEnum.ElementType) do
		local var_40_0 = arg_40_0["_goop" .. iter_40_1]

		if var_40_0 and var_40_0.activeInHierarchy then
			local var_40_1 = var_40_0:GetComponentsInChildren(typeof(UnityEngine.Animator)):GetEnumerator()

			while var_40_1:MoveNext() do
				var_40_1.Current:Play("dungeonmap_interactive_btn_out")
			end
		end
	end
end

function var_0_0._onShow(arg_41_0)
	if arg_41_0._show then
		return
	end

	arg_41_0._show = true

	DungeonMapModel.instance:clearDialog()
	DungeonMapModel.instance:clearDialogId()
	gohelper.setActive(arg_41_0.viewGO, true)
	arg_41_0._animator:Play("dungeonmap_interactive_in")
	arg_41_0:_playAnim(arg_41_0._gonext, "dungeonmap_interactive_in")
	TaskDispatcher.cancelTask(arg_41_0._showCloseBtn, arg_41_0)
	TaskDispatcher.runDelay(arg_41_0._showCloseBtn, arg_41_0, 0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function var_0_0._showCloseBtn(arg_42_0)
	gohelper.setActive(arg_42_0._btnclose.gameObject, true)
end

function var_0_0._onOutAnimationFinished(arg_43_0)
	gohelper.setActive(arg_43_0.viewGO, false)
	UIBlockMgr.instance:endBlock("dungeonmap_interactive_out")
	gohelper.destroy(arg_43_0.viewGO)
end

function var_0_0._asynHide(arg_44_0, arg_44_1)
	if not arg_44_1 then
		logError("_asynHide viewName is nil")

		return
	end

	arg_44_0._waitCloseViewName = arg_44_1

	if not arg_44_0._show then
		return
	end

	arg_44_0:_clearScroll()

	arg_44_0._show = false

	gohelper.setActive(arg_44_0.viewGO, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
end

function var_0_0._onHide(arg_45_0)
	if not arg_45_0._show then
		return
	end

	arg_45_0:_clearScroll()

	arg_45_0._show = false

	gohelper.setActive(arg_45_0._btnclose.gameObject, false)
	UIBlockMgr.instance:startBlock("dungeonmap_interactive_out")
	arg_45_0._animator:Play("dungeonmap_interactive_out")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
	arg_45_0:_playBtnsQuitAnim()
	TaskDispatcher.runDelay(arg_45_0._onOutAnimationFinished, arg_45_0, 0.23)

	if SLFramework.FrameworkSettings.IsEditor then
		local var_45_0, var_45_1 = transformhelper.getPos(arg_45_0.viewGO.transform)
		local var_45_2 = var_45_0 - arg_45_0._elementAddX
		local var_45_3 = var_45_1 - arg_45_0._elementAddY

		if var_45_2 ~= 0 or var_45_3 ~= 0 then
			local var_45_4 = var_45_0 - arg_45_0._elementX
			local var_45_5 = var_45_1 - arg_45_0._elementY

			print(string.format("偏移坐标xy：%s#%s", string.format(var_45_4 == 0 and "%s" or "%.2f", var_45_4), string.format(var_45_5 == 0 and "%s" or "%.2f", var_45_5)))
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

function var_0_0._onViewClose(arg_46_0, arg_46_1)
	if arg_46_1 == arg_46_0._waitCloseViewName then
		arg_46_0:_cancelAsynHide()
	end
end

function var_0_0._onClickElement(arg_47_0)
	arg_47_0:_cancelAsynHide()
end

function var_0_0._cancelAsynHide(arg_48_0)
	arg_48_0._waitCloseViewName = nil

	gohelper.destroy(arg_48_0.viewGO)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

function var_0_0.init(arg_49_0, arg_49_1)
	arg_49_0.viewGO = arg_49_1
	arg_49_0._animator = arg_49_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_49_0._optionBtnList = arg_49_0:getUserDataTb_()
	arg_49_0._dialogItemList = arg_49_0:getUserDataTb_()
	arg_49_0._dialogItemCacheList = arg_49_0:getUserDataTb_()

	arg_49_0:onInitView()
	arg_49_0:addEvents()
	arg_49_0:_editableAddEvents()
end

function var_0_0._editableAddEvents(arg_50_0)
	arg_50_0:addEventCb(DungeonController.instance, DungeonEvent.closeMapInteractiveItem, arg_50_0._closeMapInteractiveItem, arg_50_0)
	arg_50_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_50_0._onScreenResize, arg_50_0)
	arg_50_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_50_0._onViewClose, arg_50_0)
	arg_50_0:addEventCb(DungeonController.instance, DungeonEvent.OnClickElement, arg_50_0._onClickElement, arg_50_0, LuaEventSystem.High)

	arg_50_0._handleTypeMap = {}
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.None] = arg_50_0._directlyComplete
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.Fight] = arg_50_0._showFight
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.Task] = arg_50_0._showTask
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.Story] = arg_50_0._playStory
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.Question] = arg_50_0._playQuestion
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.FullScreenQuestion] = arg_50_0._showPuzzleQuestion
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.PipeGame] = arg_50_0._showPuzzlePipeGame
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.ChangeColor] = arg_50_0._showPuzzleChangeColor
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.MazeDraw] = arg_50_0._showPuzzleMazeDraw
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.PutCubeGame] = arg_50_0._showPutCubeGame
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.CircuitGame] = arg_50_0._showPuzzlePipeGame
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.OuijaGame] = arg_50_0._showOuijaGame
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.PuzzleGame] = arg_50_0._showPuzzleGame
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.SpStory] = arg_50_0._showSpStory
	arg_50_0._handleTypeMap[DungeonEnum.ElementType.EnterDialogue] = arg_50_0._showEnterDialog
end

function var_0_0._showElementTitle(arg_51_0)
	local var_51_0 = arg_51_0._config.type == DungeonEnum.ElementType.SpStory and "#C5B291" or "#a28682"

	arg_51_0._txttitle.text = arg_51_0._config.title
	arg_51_0._txtsptitle.text = arg_51_0._config.title

	SLFramework.UGUI.GuiHelper.SetColor(arg_51_0._txtsptitle, var_51_0)
end

function var_0_0._refreshType(arg_52_0)
	local var_52_0 = lua_chapter_map.configDict[arg_52_0._config.mapId].chapterId

	gohelper.setActive(arg_52_0._goclosenormal, var_52_0 ~= DungeonEnum.ChapterId.Main1_9)
	gohelper.setActive(arg_52_0._goclosesp, var_52_0 == DungeonEnum.ChapterId.Main1_9)
	gohelper.setActive(arg_52_0._gonormalbg, var_52_0 ~= DungeonEnum.ChapterId.Main1_9 and arg_52_0._config.type ~= DungeonEnum.ElementType.SpStory)
	gohelper.setActive(arg_52_0._gomain1_9bg, var_52_0 == DungeonEnum.ChapterId.Main1_9 and arg_52_0._config.type ~= DungeonEnum.ElementType.SpStory)
	gohelper.setActive(arg_52_0._gospbg, arg_52_0._config.type == DungeonEnum.ElementType.SpStory)
	gohelper.setActive(arg_52_0._gonormaltitle, var_52_0 ~= DungeonEnum.ChapterId.Main1_9)
	gohelper.setActive(arg_52_0._gosptitle, var_52_0 == DungeonEnum.ChapterId.Main1_9)
end

function var_0_0._OnClickElement(arg_53_0, arg_53_1)
	arg_53_0._mapElement = arg_53_1

	if arg_53_0._show then
		arg_53_0:_onHide()

		return
	end

	arg_53_0:_onShow()

	arg_53_0._config = arg_53_0._mapElement._config
	arg_53_0._elementGo = arg_53_0._mapElement._go

	arg_53_0:_showElementTitle()
	arg_53_0:_refreshType()

	arg_53_0._elementX, arg_53_0._elementY, arg_53_0._elementZ = transformhelper.getPos(arg_53_0._elementGo.transform)

	if not string.nilorempty(arg_53_0._config.offsetPos) then
		local var_53_0 = string.splitToNumber(arg_53_0._config.offsetPos, "#")

		arg_53_0._elementAddX = arg_53_0._elementX + (var_53_0[1] or 0)
		arg_53_0._elementAddY = arg_53_0._elementY + (var_53_0[2] or 0)
	end

	arg_53_0.viewGO.transform.position = Vector3(arg_53_0._elementAddX, arg_53_0._elementAddY, 0)

	arg_53_0:_showRewards()

	local var_53_1 = not string.nilorempty(arg_53_0._config.flagText)

	gohelper.setActive(arg_53_0._goimportanttips, var_53_1)

	if var_53_1 then
		arg_53_0._txttipsinfo.text = arg_53_0._config.flagText
	end

	local var_53_2 = arg_53_0._config.type
	local var_53_3 = var_53_2 == DungeonEnum.ElementType.Story

	gohelper.setActive(arg_53_0._txtinfo.gameObject, not var_53_3)
	gohelper.setActive(arg_53_0._gochatarea, var_53_3)

	for iter_53_0, iter_53_1 in pairs(DungeonEnum.ElementType) do
		local var_53_4 = arg_53_0["_goop" .. iter_53_1]

		if var_53_4 then
			gohelper.setActive(var_53_4, iter_53_1 == var_53_2)
		end
	end

	if var_53_2 == DungeonEnum.ElementType.CircuitGame then
		gohelper.setActive(arg_53_0._goop9, true)
	end

	local var_53_5 = arg_53_0._handleTypeMap[var_53_2]

	if var_53_5 then
		var_53_5(arg_53_0)
	else
		logError("element type undefined!")
	end
end

function var_0_0._showRewards(arg_54_0)
	local var_54_0 = gohelper.findChild(arg_54_0.viewGO, "rotate/layout/top/reward")
	local var_54_1 = DungeonModel.instance:getMapElementReward(arg_54_0._config.id)
	local var_54_2 = GameUtil.splitString2(var_54_1, true, "|", "#")

	if not var_54_2 then
		gohelper.setActive(var_54_0, false)

		return
	end

	gohelper.setActive(var_54_0, true)

	for iter_54_0, iter_54_1 in ipairs(var_54_2) do
		local var_54_3 = gohelper.cloneInPlace(arg_54_0._gorewarditem)

		gohelper.setActive(var_54_3, true)
	end

	arg_54_0._rewardClick = gohelper.getClick(gohelper.findChild(var_54_0, "click"))

	arg_54_0._rewardClick:AddClickListener(arg_54_0._openRewardView, arg_54_0, var_54_2)
end

function var_0_0._openRewardView(arg_55_0, arg_55_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	DungeonController.instance:openDungeonElementRewardView(arg_55_1)
end

function var_0_0._playQuestion(arg_56_0)
	arg_56_0._txtinfo.text = arg_56_0._config.desc
end

function var_0_0._showFight(arg_57_0)
	local var_57_0 = tonumber(arg_57_0._config.param)
	local var_57_1 = DungeonModel.instance:hasPassLevel(var_57_0)

	gohelper.setActive(arg_57_0._gofinishFight, var_57_1)
	gohelper.setActive(arg_57_0._gounfinishedFight, not var_57_1)

	if var_57_1 then
		arg_57_0._txtinfo.text = arg_57_0._config.finishText
	else
		arg_57_0._txtinfo.text = arg_57_0._config.desc
		arg_57_0._txtfight.text = arg_57_0._config.acceptText
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MoveFightBtn2MapView) then
		TaskDispatcher.runDelay(arg_57_0._addToMapView, arg_57_0, 0.5)
	end
end

function var_0_0._addToMapView(arg_58_0)
	gohelper.setActive(arg_58_0._btnfightuiuse.gameObject, true)

	local var_58_0 = ViewMgr.instance:getContainer(ViewName.DungeonMapView).viewGO
	local var_58_1 = CameraMgr.instance:getMainCamera()
	local var_58_2 = arg_58_0._btnfightuiuse.transform.position
	local var_58_3 = recthelper.worldPosToAnchorPos(var_58_2, var_58_0.transform, nil, var_58_1)

	arg_58_0._btnfightuiuse.transform.parent = var_58_0.transform

	transformhelper.setLocalPosXY(arg_58_0._btnfightuiuse.transform, var_58_3.x, var_58_3.y)
end

function var_0_0._showTask(arg_59_0)
	arg_59_0._txtinfo.text = arg_59_0._config.desc

	local var_59_0 = arg_59_0._config.param
	local var_59_1 = string.splitToNumber(var_59_0, "#")
	local var_59_2 = var_59_1[3]
	local var_59_3 = ItemModel.instance:getItemConfig(var_59_1[1], var_59_1[2])
	local var_59_4 = ItemModel.instance:getItemQuantity(var_59_1[1], var_59_1[2])

	arg_59_0._finishTask = var_59_2 <= var_59_4

	gohelper.setActive(arg_59_0._gofinishtask, arg_59_0._finishTask)
	gohelper.setActive(arg_59_0._gounfinishtask, not arg_59_0._finishTask)

	if arg_59_0._finishTask then
		arg_59_0._txtfinishtask.text = string.format("%s%s<color=#00ff00>%s</color>/%s", luaLang("dungeon_map_submit"), var_59_3.name, var_59_4, var_59_2)
	else
		arg_59_0._txtunfinishtask.text = string.format("%s%s<color=#ff0000>%s</color>/%s", luaLang("dungeon_map_submit"), var_59_3.name, var_59_4, var_59_2)
	end
end

function var_0_0._showPuzzleQuestion(arg_60_0)
	local var_60_0 = DungeonMapModel.instance:hasMapPuzzleStatus(arg_60_0._config.id)

	if var_60_0 then
		arg_60_0._txtinfo.text = arg_60_0._config.finishText
	else
		arg_60_0._txtpuzzlequestion.text = arg_60_0._config.acceptText
		arg_60_0._txtinfo.text = arg_60_0._config.desc
	end

	arg_60_0._gopuzzlequestion:SetActive(not var_60_0)
	arg_60_0._gopuzzlequestionfinish.gameObject:SetActive(var_60_0)
end

function var_0_0._showPuzzlePipeGame(arg_61_0)
	local var_61_0 = DungeonMapModel.instance:hasMapPuzzleStatus(arg_61_0._config.id)

	if var_61_0 then
		arg_61_0._txtinfo.text = arg_61_0._config.finishText
	else
		arg_61_0._txtpuzzlepipe.text = arg_61_0._config.acceptText
		arg_61_0._txtinfo.text = arg_61_0._config.desc
	end

	arg_61_0._gopipe:SetActive(not var_61_0)
	arg_61_0._gopipefinish:SetActive(var_61_0)
end

function var_0_0._showPuzzleChangeColor(arg_62_0)
	local var_62_0
end

function var_0_0._showPuzzleMazeDraw(arg_63_0)
	local var_63_0 = DungeonMapModel.instance:hasMapPuzzleStatus(arg_63_0._config.id)

	if var_63_0 then
		arg_63_0._txtinfo.text = arg_63_0._config.finishText
	else
		arg_63_0._txtmazedraw.text = arg_63_0._config.acceptText
		arg_63_0._txtinfo.text = arg_63_0._config.desc
	end

	arg_63_0._gomazedraw:SetActive(not var_63_0)
	arg_63_0._gomazedrawfinish:SetActive(var_63_0)
end

function var_0_0._showPutCubeGame(arg_64_0)
	return
end

function var_0_0._showOuijaGame(arg_65_0)
	local var_65_0 = DungeonMapModel.instance:hasMapPuzzleStatus(arg_65_0._config.id)

	if var_65_0 then
		arg_65_0._txtinfo.text = arg_65_0._config.finishText
	else
		arg_65_0._txtouija.text = arg_65_0._config.acceptText
		arg_65_0._txtinfo.text = arg_65_0._config.desc
	end

	arg_65_0._goouijagame:SetActive(not var_65_0)
	arg_65_0._goouijagamefinish:SetActive(var_65_0)
end

function var_0_0._showPuzzleGame(arg_66_0)
	local var_66_0 = DungeonMapModel.instance:hasMapPuzzleStatus(arg_66_0._config.id)

	if var_66_0 then
		arg_66_0._txtinfo.text = arg_66_0._config.finishText
	else
		arg_66_0._txt101puzzle.text = arg_66_0._config.acceptText
		arg_66_0._txtinfo.text = arg_66_0._config.desc
	end

	arg_66_0._goop101puzzle:SetActive(not var_66_0)
	arg_66_0._goop101puzzlefinish:SetActive(var_66_0)
end

function var_0_0._showEnterDialog(arg_67_0)
	arg_67_0._txtinfo.text = arg_67_0._config.desc
	arg_67_0._txtdodialog.text = arg_67_0._config.acceptText
end

function var_0_0._showSpStory(arg_68_0)
	gohelper.setActive(arg_68_0._goop102, true)

	arg_68_0._txtinfo.text = arg_68_0._config.desc
	arg_68_0._txt102ok.text = arg_68_0._config.acceptText

	local var_68_0 = arg_68_0._config.type == DungeonEnum.ElementType.SpStory and "#272525" or "#FEF7EE"

	SLFramework.UGUI.GuiHelper.SetColor(arg_68_0._txtinfo, var_68_0)
end

function var_0_0._directlyComplete(arg_69_0)
	arg_69_0._txtdoit.text = arg_69_0._config.acceptText
	arg_69_0._txtinfo.text = arg_69_0._config.desc
end

function var_0_0._playNextSectionOrDialog(arg_70_0)
	arg_70_0:_clearDialog()

	if #arg_70_0._sectionList >= arg_70_0._dialogIndex then
		arg_70_0:_playNextDialog()

		return
	end

	local var_70_0 = table.remove(arg_70_0._sectionStack)

	arg_70_0:_playSection(var_70_0[1], var_70_0[2])
end

function var_0_0._playStory(arg_71_0)
	arg_71_0:_clearDialog()

	arg_71_0._sectionStack = {}
	arg_71_0._dialogId = tonumber(arg_71_0._config.param)

	arg_71_0:_playSection(0)
end

function var_0_0._playSection(arg_72_0, arg_72_1, arg_72_2)
	arg_72_0:_setSectionData(arg_72_1, arg_72_2)
	arg_72_0:_playNextDialog()
end

function var_0_0._setSectionData(arg_73_0, arg_73_1, arg_73_2)
	arg_73_0._sectionList = DungeonConfig.instance:getDialog(arg_73_0._dialogId, arg_73_1)
	arg_73_0._dialogIndex = arg_73_2 or 1
	arg_73_0._sectionId = arg_73_1
end

function var_0_0._playNextDialog(arg_74_0)
	local var_74_0 = arg_74_0._sectionList[arg_74_0._dialogIndex]

	arg_74_0._dialogIndex = arg_74_0._dialogIndex + 1

	if var_74_0.type == "dialog" then
		arg_74_0:_showDialog("dialog", var_74_0.content, var_74_0.speaker, var_74_0.audio)
	end

	if #arg_74_0._sectionStack > 0 and #arg_74_0._sectionList < arg_74_0._dialogIndex then
		local var_74_1 = table.remove(arg_74_0._sectionStack)

		arg_74_0:_setSectionData(var_74_1[1], var_74_1[2])
	end

	local var_74_2 = false
	local var_74_3 = arg_74_0._sectionList[arg_74_0._dialogIndex]

	if var_74_3 and var_74_3.type == "options" then
		arg_74_0._dialogIndex = arg_74_0._dialogIndex + 1

		local var_74_4 = string.split(var_74_3.content, "#")
		local var_74_5 = string.split(var_74_3.param, "#")

		for iter_74_0, iter_74_1 in pairs(arg_74_0._optionBtnList) do
			gohelper.setActive(iter_74_1[1], false)
		end

		for iter_74_2, iter_74_3 in ipairs(var_74_4) do
			arg_74_0:_addDialogOption(iter_74_2, var_74_5[iter_74_2], iter_74_3)
		end

		var_74_2 = true
	end

	local var_74_6 = not var_74_3 or var_74_3.type ~= "dialogend"

	arg_74_0:_refreshDialogBtnState(var_74_2, var_74_6)

	if arg_74_0._dissolveInfo then
		gohelper.setActive(arg_74_0._curBtnGo, false)
	end
end

function var_0_0._refreshDialogBtnState(arg_75_0, arg_75_1, arg_75_2)
	gohelper.setActive(arg_75_0._gooptions, arg_75_1)

	if arg_75_1 then
		arg_75_0._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(arg_75_0._gofinishtalk.gameObject, false)

		arg_75_0._curBtnGo = arg_75_0._gooptions

		return
	end

	arg_75_2 = arg_75_2 and (#arg_75_0._sectionStack > 0 or #arg_75_0._sectionList >= arg_75_0._dialogIndex)

	if arg_75_2 then
		arg_75_0._curBtnGo = arg_75_0._gonext

		gohelper.setActive(arg_75_0._gonext.gameObject, arg_75_2)
		arg_75_0._nextAnimator:Play("dungeonmap_interactive_btn_in1")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		arg_75_0._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		arg_75_0._curBtnGo = arg_75_0._gofinishtalk
	end

	gohelper.setActive(arg_75_0._gofinishtalk.gameObject, not arg_75_2)
end

function var_0_0._addDialogOption(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	local var_76_0 = arg_76_0._optionBtnList[arg_76_1] and arg_76_0._optionBtnList[arg_76_1][1] or gohelper.cloneInPlace(arg_76_0._gotalkitem)

	arg_76_0._maxOptionIndex = arg_76_1

	gohelper.setActive(var_76_0, false)

	gohelper.findChildText(var_76_0, "txt_talkitem").text = arg_76_3

	local var_76_1 = gohelper.findChildButtonWithAudio(var_76_0, "btn_talkitem")

	var_76_1:AddClickListener(arg_76_0._onOptionClick, arg_76_0, {
		arg_76_2,
		arg_76_3
	})

	if not arg_76_0._optionBtnList[arg_76_1] then
		arg_76_0._optionBtnList[arg_76_1] = {
			var_76_0,
			var_76_1
		}
	end
end

function var_0_0._onOptionClick(arg_77_0, arg_77_1)
	if arg_77_0._playScrollAnim then
		return
	end

	local var_77_0 = arg_77_1[1]
	local var_77_1 = string.format("<color=#c95318>\"%s\"</color>", arg_77_1[2])

	arg_77_0:_clearDialog()

	if arg_77_0._dialogId == 24 and var_77_0 == "5" then
		-- block empty
	else
		arg_77_0:_showDialog("option", var_77_1)
	end

	arg_77_0._showOption = true

	if #arg_77_0._sectionList >= arg_77_0._dialogIndex then
		table.insert(arg_77_0._sectionStack, {
			arg_77_0._sectionId,
			arg_77_0._dialogIndex
		})
	end

	DungeonMapModel.instance:addDialogId(var_77_0)
	arg_77_0:_playSection(var_77_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._showDialog(arg_78_0, arg_78_1, arg_78_2, arg_78_3, arg_78_4)
	DungeonMapModel.instance:addDialog(arg_78_1, arg_78_2, arg_78_3, arg_78_4)

	local var_78_0 = table.remove(arg_78_0._dialogItemCacheList) or gohelper.cloneInPlace(arg_78_0._gochatitem)

	transformhelper.setLocalPos(var_78_0.transform, 0, 0, 200)
	gohelper.setActive(var_78_0, true)
	gohelper.setAsLastSibling(var_78_0)

	gohelper.findChildText(var_78_0, "name").text = arg_78_3 and arg_78_3 .. ":" or ""

	local var_78_1 = gohelper.findChild(var_78_0, "usericon")

	gohelper.setActive(var_78_1, not arg_78_3)

	local var_78_2 = gohelper.findChildText(var_78_0, "info")

	var_78_2.text = arg_78_2

	if arg_78_3 and arg_78_4 and arg_78_4 > 0 then
		arg_78_0._audioIcon = gohelper.findChild(var_78_0, "name/laba")
		arg_78_0._audioId = arg_78_4
	end

	if arg_78_0._showOption and arg_78_0._addDialog then
		arg_78_0._dissolveInfo = {
			var_78_0,
			var_78_2,
			arg_78_2
		}
	end

	arg_78_0._showOption = false

	table.insert(arg_78_0._dialogItemList, var_78_0)

	arg_78_0._addDialog = true
end

function var_0_0._clearDialog(arg_79_0)
	arg_79_0._dialogItemList = arg_79_0:getUserDataTb_()
	arg_79_0._playScrollAnim = true

	gohelper.setActive(arg_79_0._gomask, false)
	TaskDispatcher.runDelay(arg_79_0._delayScroll, arg_79_0, 0)

	if arg_79_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_79_0._audioId)

		arg_79_0._audioId = nil
	end
end

function var_0_0._delayScroll(arg_80_0)
	gohelper.setActive(arg_80_0._gomask, true)

	arg_80_0._imgMask.enabled = true

	local var_80_0 = 0.26
	local var_80_1 = arg_80_0._curScrollGo

	if var_80_1 then
		arg_80_0._oldScrollGo = var_80_1

		ZProj.TweenHelper.DOLocalMoveY(var_80_1.transform, 229, var_80_0, arg_80_0._scrollEnd, arg_80_0, var_80_1)
	else
		var_80_0 = 0.1
	end

	local var_80_2 = gohelper.cloneInPlace(arg_80_0._goscroll)

	for iter_80_0, iter_80_1 in ipairs(arg_80_0._dialogItemList) do
		local var_80_3 = iter_80_1.transform.position

		gohelper.addChild(var_80_2, iter_80_1)

		iter_80_1.transform.position = var_80_3

		local var_80_4, var_80_5, var_80_6 = transformhelper.getLocalPos(iter_80_1.transform)

		transformhelper.setLocalPos(iter_80_1.transform, var_80_4, var_80_5, 0)
	end

	gohelper.setActive(var_80_2, true)

	arg_80_0._curScrollGo = var_80_2

	if var_80_2 then
		if arg_80_0._dissolveInfo then
			local var_80_7 = arg_80_0._dissolveInfo[2]
			local var_80_8 = arg_80_0._dissolveInfo[3]

			var_80_7.text = ""
		end

		transformhelper.setLocalPosXY(var_80_2.transform, 0, -229)
		ZProj.TweenHelper.DOLocalMoveY(var_80_2.transform, 0, var_80_0, arg_80_0._scrollEnd, arg_80_0, var_80_2)
	end
end

function var_0_0._scrollEnd(arg_81_0, arg_81_1)
	if arg_81_1 ~= arg_81_0._curScrollGo then
		gohelper.destroy(arg_81_1)
	else
		if arg_81_0._dissolveInfo then
			TaskDispatcher.runDelay(arg_81_0._onDissolveStart, arg_81_0, 0.3)

			return
		end

		arg_81_0:_onDissolveFinish()
	end
end

function var_0_0._onDissolveStart(arg_82_0)
	local var_82_0 = arg_82_0._dissolveInfo[1]

	arg_82_0._dissolveInfo[2].text = arg_82_0._dissolveInfo[3]
	arg_82_0._imgMask.enabled = false

	var_82_0:GetComponent(typeof(UnityEngine.Animation)):Play("dungeonmap_chatarea")
	TaskDispatcher.runDelay(arg_82_0._onDissolveFinish, arg_82_0, 1.3)
end

function var_0_0._onDissolveFinish(arg_83_0)
	arg_83_0:_playAudio()
	gohelper.setActive(arg_83_0._curBtnGo, true)

	arg_83_0._dissolveInfo = nil
	arg_83_0._playScrollAnim = false

	if arg_83_0._curBtnGo == arg_83_0._gooptions then
		for iter_83_0 = 1, arg_83_0._maxOptionIndex do
			local var_83_0 = (iter_83_0 - 1) * 0.03
			local var_83_1 = arg_83_0._optionBtnList[iter_83_0][1]

			if var_83_0 > 0 then
				gohelper.setActive(var_83_1, false)
				TaskDispatcher.runDelay(function()
					if not gohelper.isNil(var_83_1) then
						gohelper.setActive(var_83_1, true)
					end
				end, nil, var_83_0)
			else
				gohelper.setActive(var_83_1, true)
			end
		end
	end
end

function var_0_0._playAudio(arg_85_0)
	if not arg_85_0._audioId then
		return
	end

	gohelper.setActive(arg_85_0._audioIcon, true)

	if not arg_85_0._audioParam then
		arg_85_0._audioParam = AudioParam.New()
	end

	arg_85_0._audioParam.callback = arg_85_0._onAudioStop
	arg_85_0._audioParam.callbackTarget = arg_85_0

	AudioEffectMgr.instance:playAudio(arg_85_0._audioId, arg_85_0._audioParam)
end

function var_0_0._onAudioStop(arg_86_0, arg_86_1)
	gohelper.setActive(arg_86_0._audioIcon, false)
end

function var_0_0.setBtnClosePosZ(arg_87_0, arg_87_1)
	local var_87_0 = arg_87_0._btnclose.transform
	local var_87_1 = var_87_0.localPosition

	var_87_0.localPosition = Vector3(var_87_1.x, var_87_1.y, arg_87_1)
end

function var_0_0.setScale(arg_88_0, arg_88_1)
	transformhelper.setLocalScale(arg_88_0.viewGO.transform, arg_88_1, arg_88_1, arg_88_1)
end

function var_0_0._clearScroll(arg_89_0)
	arg_89_0._showOption = false
	arg_89_0._dissolveInfo = nil
	arg_89_0._playScrollAnim = false

	TaskDispatcher.cancelTask(arg_89_0._delayScroll, arg_89_0)

	if arg_89_0._oldScrollGo then
		gohelper.destroy(arg_89_0._oldScrollGo)

		arg_89_0._oldScrollGo = nil
	end

	if arg_89_0._curScrollGo then
		gohelper.destroy(arg_89_0._curScrollGo)

		arg_89_0._curScrollGo = nil
	end

	arg_89_0._dialogItemList = arg_89_0:getUserDataTb_()
end

function var_0_0._editableRemoveEvents(arg_90_0)
	for iter_90_0, iter_90_1 in pairs(arg_90_0._optionBtnList) do
		iter_90_1[2]:RemoveClickListener()
	end

	arg_90_0:removeEventCb(DungeonController.instance, DungeonEvent.closeMapInteractiveItem, arg_90_0._closeMapInteractiveItem, arg_90_0)
	arg_90_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_90_0._onScreenResize, arg_90_0)
	arg_90_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_90_0._onViewClose, arg_90_0)
	arg_90_0:removeEventCb(DungeonController.instance, DungeonEvent.OnClickElement, arg_90_0._onClickElement, arg_90_0)
end

function var_0_0.onDestroy(arg_91_0)
	DungeonMapModel.instance:setMapInteractiveItemVisible(false)
	TaskDispatcher.cancelTask(arg_91_0._showCloseBtn, arg_91_0)
	TaskDispatcher.cancelTask(arg_91_0._delayScroll, arg_91_0)
	TaskDispatcher.cancelTask(arg_91_0._onDissolveStart, arg_91_0)
	TaskDispatcher.cancelTask(arg_91_0._onDissolveFinish, arg_91_0)
	arg_91_0:removeEvents()
	arg_91_0:_editableRemoveEvents()
	TaskDispatcher.cancelTask(arg_91_0._addToMapView, arg_91_0)
	gohelper.destroy(arg_91_0._btnfightuiuse.gameObject)

	if arg_91_0._audioParam then
		arg_91_0._audioParam.callback = nil
		arg_91_0._audioParam.callbackTarget = nil
		arg_91_0._audioParam = nil
	end

	if arg_91_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_91_0._audioId)

		arg_91_0._audioId = nil
	end

	if arg_91_0._rewardClick then
		arg_91_0._rewardClick:RemoveClickListener()
	end

	SLFramework.UGUI.UIClickListener.Get(arg_91_0._inputanswer.gameObject):RemoveClickListener()
	arg_91_0._simagebgimage:UnLoadImage()
	arg_91_0._simageanswerbg:UnLoadImage()
end

return var_0_0
