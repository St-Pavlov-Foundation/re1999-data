module("modules.logic.store.view.recommend.GiftPacksView", package.seeall)

slot0 = class("GiftPacksView", StoreRecommendBaseSubView)

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
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._btn = gohelper.findChildClickWithAudio(slot0.viewGO, "view/#simage_bg")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_bg")

	slot0._simagebg:LoadImage(ResUrl.getStoreGiftPackBg("bg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0._onClick(slot0)
	GameFacade.jumpByAdditionParam("10170")
	AudioMgr.instance:trigger(2000001)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "713",
		[StatEnum.EventProperties.RecommendPageName] = "精选组合推荐"
	})
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
