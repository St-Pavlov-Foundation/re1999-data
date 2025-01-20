module("modules.logic.versionactivity2_5.enter.view.subview.VersionActivity2_5AutoChessEnterView", package.seeall)

slot0 = class("VersionActivity2_5AutoChessEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "LimitTime/#txt_LimitTime")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#txt_Desc")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Enter")
	slot0._btnAchievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Achievement")
	slot0._goTip = gohelper.findChild(slot0.viewGO, "#go_Tip")
	slot0._txtTip = gohelper.findChildText(slot0.viewGO, "#go_Tip/#txt_Tip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
	slot0._btnAchievement:AddClickListener(slot0._btnAchievementOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnAchievement:RemoveClickListener()
end

function slot0._btnEnterOnClick(slot0)
	if not slot0.actMo then
		return
	end

	AutoChessController.instance:openMainView({
		actId = slot0.actId
	})
end

function slot0._btnAchievementOnClick(slot0)
	JumpController.instance:jump(slot0.config.achievementJumpId)
end

function slot0._editableInitView(slot0)
	slot0.actId = slot0.viewContainer.activityId
	slot0.config = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot0.animComp = VersionActivity2_5SubAnimatorComp.get(slot0.viewGO, slot0)
end

function slot0.onOpen(slot0)
	slot0.animComp:playOpenAnim()

	slot0._txtDesc.text = slot0.config.actDesc

	slot0:_showLeftTime()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 1)
	Activity182Rpc.instance:sendGetAct182InfoRequest(slot0.actId, slot0.refreshUI, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.animComp:destroy()
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

function slot0.refreshUI(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot0.actMo = Activity182Model.instance:getActMo()
	slot3 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreRank].value)
	slot5 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreCnt].value)

	if slot0.actMo.rank <= slot3 then
		slot0._txtTip.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("autochess_mainview_tips1"), lua_auto_chess_rank.configDict[slot0.actId][slot3].name, slot5, string.format("（%d/%d）", slot0.actMo.doubleScoreTimes, slot5))

		gohelper.setActive(slot0._goTip, true)
	else
		gohelper.setActive(slot0._goTip, false)
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

return slot0
