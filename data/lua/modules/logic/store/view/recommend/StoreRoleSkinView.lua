module("modules.logic.store.view.recommend.StoreRoleSkinView", package.seeall)

slot0 = class("StoreRoleSkinView", StoreRecommendBaseSubView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_bg")
	slot0._simagesignature1 = gohelper.findChildSingleImage(slot0.viewGO, "view/left/role1/#simage_signature1")
	slot0._simagesignature2 = gohelper.findChildSingleImage(slot0.viewGO, "view/left/role2/#simage_signature2")
	slot0._txtdurationTime = gohelper.findChildText(slot0.viewGO, "view/right/time/#txt_durationTime")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/right/#btn_buy")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
end

function slot0._btnbuyOnClick(slot0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(slot0.config and slot0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = slot0.config and slot0.config.name or "StoreRoleSkinView"
	})
	GameFacade.jumpByAdditionParam(slot0.config.systemJumpCode)
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.config = slot0.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreRoleSkinView)
	slot0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(slot0.config)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
