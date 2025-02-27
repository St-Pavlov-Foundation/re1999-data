module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroEnterView", package.seeall)

slot0 = class("DiceHeroEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter", AudioEnum2_6.DiceHero.play_ui_wenming_alaifugameplay)
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Locked")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtLockTxt = gohelper.findChildTextMesh(slot0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	slot0._txtDescr = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_Descr")
	slot0._gored = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#go_reddot")
	slot0._btnTrial = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Try/image_TryBtn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._onEnterClick, slot0)
	slot0._btnLocked:AddClickListener(slot0._onLockClick, slot0)
	slot0._btnTrial:AddClickListener(slot0._clickTrial, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
	slot0._btnTrial:RemoveClickListener()
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.V2a6DiceHero)

	slot1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.DiceHero)

	gohelper.setActive(slot0._btnEnter, slot1)
	gohelper.setActive(slot0._btnLocked, not slot1)

	if not slot1 then
		slot0._txtLockTxt.text = string.format(luaLang("dungeon_unlock_episode_mode_sp"), DungeonConfig.instance:getEpisodeDisplay(OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.DiceHero).episodeId))
	end
end

function slot0._editableInitView(slot0)
	slot0.config = ActivityConfig.instance:getActivityCo(VersionActivity2_6Enum.ActivityId.DiceHero)
	slot0._txtDescr.text = slot0.config.actDesc
end

function slot0._onEnterClick(slot0)
	ViewMgr.instance:openView(ViewName.DiceHeroMainView)
end

function slot0._clickTrial(slot0)
	if ActivityHelper.getActivityStatus(VersionActivity2_6Enum.ActivityId.DiceHero) == ActivityEnum.ActivityStatus.Normal then
		if slot0.config.tryoutEpisode <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
	else
		slot0:_onLockClick()
	end
end

function slot0.everySecondCall(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_6Enum.ActivityId.DiceHero)
end

function slot0._onLockClick(slot0)
	slot1, slot2 = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.DiceHero)

	if slot1 and slot1 ~= 0 then
		GameFacade.showToastWithTableParam(slot1, slot2)
	end
end

return slot0
