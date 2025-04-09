module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroDungeonMapView", package.seeall)

slot0 = class("DiceHeroDungeonMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "#go_dicebtn")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_dicebtn/#btn_enter", AudioEnum2_6.DiceHero.play_ui_wenming_alaifugameplay)
	slot0._gored = gohelper.findChild(slot0.viewGO, "#go_dicebtn/#btn_enter/#go_reddot")
	slot0._anim = gohelper.findChildAnim(slot0.viewGO, "#go_dicebtn/#btn_enter")
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0.onClickEnter, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:addEventCb(DiceHeroController.instance, DiceHeroEvent.InfoUpdate, slot0.onActStateChange, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0.setEpisodeListVisible, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:removeEventCb(DiceHeroController.instance, DiceHeroEvent.InfoUpdate, slot0.onActStateChange, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0.setEpisodeListVisible, slot0)
end

function slot0.refreshView(slot0)
	slot0.chapterId = slot0.viewParam.chapterId

	slot0:onActStateChange()
	RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.V2a6DiceHero)

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		slot0._anim:Play("close", 0, 1)
	else
		slot0._anim:Play("open", 0, 0)
	end
end

function slot0.onOpen(slot0)
	slot0:refreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0._anim:Play("close", 0, 0)
	end
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0._anim:Play("open", 0, 0)
	end
end

function slot0.setEpisodeListVisible(slot0, slot1)
	if slot1 and slot0:isShowRoot() then
		slot0._anim:Play("open", 0, 0)
	else
		slot0._anim:Play("close", 0, 0)
	end
end

function slot0.isShowRoot(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DiceHero) and slot0.chapterId == DungeonEnum.ChapterId.Main1_9 then
		return true
	end
end

function slot0.onActStateChange(slot0)
	if slot0:isShowRoot() then
		gohelper.setActive(slot0._goroot, true)
	else
		gohelper.setActive(slot0._goroot, false)
	end
end

function slot0.onClickEnter(slot0)
	ViewMgr.instance:openView(ViewName.DiceHeroMainView)
end

return slot0
