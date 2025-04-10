module("modules.logic.versionactivity2_7.act191.view.Act191InitBuildView", package.seeall)

slot0 = class("Act191InitBuildView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollbuild = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_build")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity191Model.instance:getCurActId()
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.nextStep, slot0)
	slot0:clearIconList()
end

function slot0.refreshUI(slot0)
	slot0:initBuildSelectItem()

	slot0._scrollbuild.horizontalNormalizedPosition = 0
end

function slot0.clearIconList(slot0)
	if slot0.collectionIconList then
		for slot4, slot5 in ipairs(slot0.collectionIconList) do
			slot5:UnLoadImage()
		end
	end
end

function slot0.initBuildSelectItem(slot0)
	slot0.buildCoList = lua_activity191_init_build.configDict[slot0.actId]
	slot0.collectionIconList = slot0:getUserDataTb_()
	slot0.bagAnimList = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onInitBuildItem, slot0.buildCoList, gohelper.findChild(slot0.viewGO, "#scroll_build/Viewport/Content"), gohelper.findChild(slot0.viewGO, "#scroll_build/Viewport/Content/SelectItem"))
end

function slot0._onInitBuildItem(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "name/txt_name").text = slot2.name or ""

	slot0:addClickCb(gohelper.findChildButtonWithAudio(slot1, "btn_select"), slot0.selectInitBuild, slot0, slot3)

	slot7 = gohelper.findChild(slot1, "collection/collectionitem")

	for slot12, slot13 in ipairs(string.splitToNumber(slot2.hero, "#")) do
		slot16 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], gohelper.cloneInPlace(gohelper.findChild(slot1, "hero/heroitem"))), Act191HeroHeadItem)

		slot16:setData(nil, slot13)
		slot16:setPreview()
	end

	for slot13, slot14 in ipairs(string.splitToNumber(slot2.item, "#")) do
		slot15 = gohelper.cloneInPlace(slot7)
		slot16 = Activity191Config.instance:getCollectionCo(slot14)
		slot18 = gohelper.findChildSingleImage(slot15, "collectionicon")

		slot18:LoadImage(ResUrl.getRougeSingleBgCollection(slot16.icon))
		UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot15, "rare"), "act174_propitembg_" .. slot16.rare)
		slot0:addClickCb(gohelper.findChildButtonWithAudio(slot15, "collectionicon"), slot0.clickCollection, slot0, slot14)

		slot0.collectionIconList[#slot0.collectionIconList + 1] = slot18
	end

	gohelper.setActive(slot6, false)
	gohelper.setActive(slot7, false)

	slot0.bagAnimList[slot3] = slot1:GetComponent(gohelper.Type_Animator)
	gohelper.findChildText(slot1, "Coin/txt_Coin").text = slot2.coin
end

function slot0.selectInitBuild(slot0, slot1)
	Activity191Rpc.instance:sendSelect191InitBuildRequest(slot0.actId, slot0.buildCoList[slot1].style, slot0.buildReply, slot0)

	slot0.selectIndex = slot1
end

function slot0.buildReply(slot0, slot1, slot2)
	if slot2 == 0 then
		if slot0.selectIndex and slot0.bagAnimList[slot3] then
			slot0.bagAnimList[slot3]:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(slot0.nextStep, slot0, 0.67)

		slot0.selectIndex = nil

		Activity191Helper.setPlayerPrefs(-999, "Act191GameCostTime", Activity191Helper.getPlayerPrefs(-999, "Act191GameCostTime", 0) + 1)
	end
end

function slot0.clickCollection(slot0, slot1)
	Activity191Controller.instance:openCollectionTipView({
		itemId = slot1
	})
end

function slot0.nextStep(slot0)
	Activity191Controller.instance:enterGame()
	ViewMgr.instance:closeView(slot0.viewName)
end

return slot0
