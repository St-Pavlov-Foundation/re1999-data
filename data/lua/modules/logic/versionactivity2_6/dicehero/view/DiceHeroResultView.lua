module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroResultView", package.seeall)

slot0 = class("DiceHeroResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#btn_restart")
end

function slot0.addEvents(slot0)
	slot0._btnClick:AddClickListener(slot0._onClickClose, slot0)
	slot0._btnquitgame:AddClickListener(slot0.closeThis, slot0)
	slot0._btnrestart:AddClickListener(slot0._onClickRestart, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClick:RemoveClickListener()
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gosuccess, slot0.viewParam.status == DiceHeroEnum.GameStatu.Win)
	gohelper.setActive(slot0._gofail, slot0.viewParam.status == DiceHeroEnum.GameStatu.Lose)

	slot2 = lua_dice_level.configDict[DiceHeroModel.instance.lastEnterLevelId]
	slot0.co = slot2
	slot3 = false

	if slot2 then
		slot3 = slot0.viewParam.status == DiceHeroEnum.GameStatu.Lose and slot2.mode == 1
	end

	gohelper.setActive(slot0._gobtns, slot3)
	gohelper.setActive(slot0._btnClick, not slot3)

	if slot0.viewParam.status == DiceHeroEnum.GameStatu.Win then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_pkls_challenge_fail)
	end
end

function slot0._onClickRestart(slot0)
	DiceHeroStatHelper.instance:resetGameDt()
	DiceHeroRpc.instance:sendDiceHeroEnterFight(slot0.co.id, slot0._onEnterFight, slot0)
end

function slot0._onClickClose(slot0)
	if slot0.co then
		if DiceHeroModel.instance:getGameInfo(slot0.co.chapter):hasReward() and slot1.currLevel == DiceHeroModel.instance.lastEnterLevelId then
			ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
				co = slot0.co
			})
		elseif slot0.co.mode == 2 and slot0.viewParam.status == DiceHeroEnum.GameStatu.Win and slot0.co.dialog ~= 0 then
			ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
				co = slot0.co
			})
		end
	end

	slot0:closeThis()
end

function slot0._onEnterFight(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0._restart = true

	ViewMgr.instance:openView(ViewName.DiceHeroGameView)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	if not slot0._restart then
		ViewMgr.instance:closeView(ViewName.DiceHeroGameView)
	end

	DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None

	if DiceHeroModel.instance.isUnlockNewChapter then
		ViewMgr.instance:closeView(ViewName.DiceHeroLevelView)
	end
end

return slot0
