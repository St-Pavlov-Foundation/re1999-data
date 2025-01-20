module("modules.logic.store.view.recommend.StoreNewbieView", package.seeall)

slot0 = class("StoreNewbieView", StoreRecommendBaseSubView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btn:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "recommend"))
	slot0._btn = gohelper.getClickWithAudio(slot0.viewGO)
end

function slot0.onUpdateParam(slot0)
end

function slot0._onClick(slot0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约"
	})
	GameFacade.jumpByAdditionParam("10170#610002")
	AudioMgr.instance:trigger(2000001)
end

function slot0.onDestroyView(slot0)
end

return slot0
