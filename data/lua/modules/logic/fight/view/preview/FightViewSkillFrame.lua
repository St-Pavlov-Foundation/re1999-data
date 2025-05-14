module("modules.logic.fight.view.preview.FightViewSkillFrame", package.seeall)

local var_0_0 = class("FightViewSkillFrame", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._show = arg_1_1 and true or false
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._text = gohelper.findChildText(arg_2_0.viewGO, "Text")
	arg_2_0._goAutoProgress = gohelper.findChild(arg_2_0.viewGO, "autoprogress")
	arg_2_0._btnstop = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "btnstop")
	arg_2_0._txtRoleProgress = gohelper.findChildText(arg_2_0.viewGO, "autoprogress/left/role")
	arg_2_0._txtSkillProgress = gohelper.findChildText(arg_2_0.viewGO, "autoprogress/right/skill")

	if not gohelper.isNil(arg_2_0._text) then
		gohelper.addChild(ViewMgr.instance:getUIRoot(), arg_2_0._text.gameObject)
		gohelper.setActive(arg_2_0._text.gameObject, true)
	end

	if not gohelper.isNil(arg_2_0._goAutoProgress) then
		gohelper.addChild(ViewMgr.instance:getUIRoot(), arg_2_0._goAutoProgress)
	end

	if not gohelper.isNil(arg_2_0._btnstop) then
		gohelper.addChild(ViewMgr.instance:getUIRoot(), arg_2_0._btnstop.gameObject)
	end
end

function var_0_0.addEvents(arg_3_0)
	if not gohelper.isNil(arg_3_0._text) then
		arg_3_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_3_0._onSkillStart, arg_3_0)
		arg_3_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_3_0._onSkillFinish, arg_3_0)
		arg_3_0:addEventCb(FightController.instance, FightEvent.OnEditorPlaySpineAniStart, arg_3_0._onPlaySpineAniStart, arg_3_0)
		arg_3_0:addEventCb(FightController.instance, FightEvent.OnEditorPlaySpineAniEnd, arg_3_0._onPlaySpineAniEnd, arg_3_0)
		arg_3_0:addEventCb(FightController.instance, FightEvent.OnEditorPlayBuffStart, arg_3_0._onPlayBuffStart, arg_3_0)

		if isDebugBuild then
			arg_3_0._text.raycastTarget = true

			SLFramework.UGUI.UIClickListener.Get(arg_3_0._text.gameObject):AddClickListener(arg_3_0._onClickShow, arg_3_0)
		end
	end

	if not gohelper.isNil(arg_3_0._goAutoProgress) then
		SkillEditorMgr.instance:registerCallback(SkillEditorMgr._onSwitchEnityOrSkill, arg_3_0._onSwitchEnityOrSkill, arg_3_0)
	end

	if not gohelper.isNil(arg_3_0._btnstop) then
		arg_3_0._btnstop:AddClickListener(arg_3_0._stopFlow, arg_3_0)
	end
end

function var_0_0.removeEvents(arg_4_0)
	if not gohelper.isNil(arg_4_0._text) then
		arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_4_0._onSkillStart, arg_4_0)
		arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_4_0._onSkillFinish, arg_4_0)
		arg_4_0:removeEventCb(FightController.instance, FightEvent.OnEditorPlaySpineAniStart, arg_4_0._onPlaySpineAniStart, arg_4_0)
		arg_4_0:removeEventCb(FightController.instance, FightEvent.OnEditorPlaySpineAniEnd, arg_4_0._onPlaySpineAniEnd, arg_4_0)
		arg_4_0:removeEventCb(FightController.instance, FightEvent.OnEditorPlayBuffStart, arg_4_0._onPlayBuffStart, arg_4_0)
		TaskDispatcher.cancelTask(arg_4_0._setFrameText, arg_4_0)
		TaskDispatcher.cancelTask(arg_4_0._setAniFrameText, arg_4_0)

		if isDebugBuild then
			SLFramework.UGUI.UIClickListener.Get(arg_4_0._text.gameObject):RemoveClickListener()
		end
	end

	if not gohelper.isNil(arg_4_0._goAutoProgress) then
		SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._onSwitchEnityOrSkill, arg_4_0._onSwitchEnityOrSkill, arg_4_0)
	end

	if not gohelper.isNil(arg_4_0._btnstop) then
		arg_4_0._btnstop:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_5_0)
	if not gohelper.isNil(arg_5_0._text) then
		gohelper.destroy(arg_5_0._text.gameObject)

		arg_5_0._text = nil
	end

	if not gohelper.isNil(arg_5_0._goAutoProgress) then
		gohelper.destroy(arg_5_0._goAutoProgress)

		arg_5_0._goAutoProgress = nil
	end

	if not gohelper.isNil(arg_5_0._btnstop) then
		gohelper.destroy(arg_5_0._btnstop.gameObject)
	end
end

function var_0_0._onClickShow(arg_6_0)
	arg_6_0._show = true
end

function var_0_0._stopFlow(arg_7_0)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._StopAutoPlayFlow1)
end

function var_0_0._onSkillStart(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._show then
		return
	end

	arg_8_0._entity = arg_8_1

	TaskDispatcher.runRepeat(arg_8_0._setFrameText, arg_8_0, 0.01)
	arg_8_0:_setFrameText()
end

function var_0_0._onSkillFinish(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._show then
		return
	end

	TaskDispatcher.cancelTask(arg_9_0._setFrameText, arg_9_0)
end

function var_0_0._setFrameText(arg_10_0)
	if not arg_10_0._show then
		return
	end

	local var_10_0 = arg_10_0._entity.skill:getBinder()

	if arg_10_0._entity and arg_10_0._entity.skill and var_10_0 then
		local var_10_1 = var_10_0.CurFrame

		if var_10_1 > 0 then
			arg_10_0._text.text = "技能预览\n" .. var_10_1
		end
	end
end

function var_0_0._onPlaySpineAniStart(arg_11_0, arg_11_1)
	if not arg_11_0._show then
		return
	end

	arg_11_0._entity = arg_11_1

	TaskDispatcher.runRepeat(arg_11_0._setAniFrameText, arg_11_0, 0.01)
	arg_11_0:_setAniFrameText()
end

function var_0_0._onPlaySpineAniEnd(arg_12_0)
	if not arg_12_0._show then
		return
	end

	TaskDispatcher.cancelTask(arg_12_0._setAniFrameText, arg_12_0)
end

function var_0_0._setAniFrameText(arg_13_0)
	if not arg_13_0._show then
		return
	end

	if arg_13_0._entity and arg_13_0._entity.spine then
		arg_13_0._text.text = "小人动作\n" .. math.ceil(arg_13_0._entity.spine._skeletonAnim:GetCurFrame())
	end
end

function var_0_0._onPlayBuffStart(arg_14_0)
	if not arg_14_0._show then
		return
	end

	arg_14_0._buff_startTime = Time.time

	TaskDispatcher.runRepeat(arg_14_0._seBuffFrameText, arg_14_0, 0.01)
	arg_14_0:_seBuffFrameText()
end

function var_0_0._onPlayBuffEnd(arg_15_0)
	if not arg_15_0._show then
		return
	end

	TaskDispatcher.cancelTask(arg_15_0._seBuffFrameText, arg_15_0)
	FightController.instance:dispatchEvent(FightEvent.OnEditorPlayBuffEnd)

	arg_15_0._text.text = ""
end

function var_0_0._seBuffFrameText(arg_16_0)
	if not arg_16_0._show then
		return
	end

	arg_16_0._text.text = "buff时间\n" .. math.ceil((Time.time - arg_16_0._buff_startTime) * 60)

	if Time.time - arg_16_0._buff_startTime >= 3 then
		arg_16_0:_onPlayBuffEnd()
	end
end

function var_0_0._onSwitchEnityOrSkill(arg_17_0, arg_17_1)
	if arg_17_1 then
		local var_17_0 = arg_17_1.rolestr
		local var_17_1 = arg_17_1.skillstr

		if var_17_0 or var_17_1 then
			gohelper.setActive(arg_17_0.viewGO, false)
			gohelper.setActive(arg_17_0._goAutoProgress, true)
			gohelper.setActive(arg_17_0._btnstop.gameObject, true)

			arg_17_0._txtRoleProgress.text = var_17_0 or arg_17_0._txtRoleProgress.text
			arg_17_0._txtSkillProgress.text = var_17_1 or arg_17_0._txtSkillProgress.text
		end
	else
		gohelper.setActive(arg_17_0.viewGO, true)
		gohelper.setActive(arg_17_0._goAutoProgress, false)
		gohelper.setActive(arg_17_0._btnstop.gameObject, false)
	end
end

return var_0_0
