module("modules.logic.rouge.dlc.103.view.RougeMapBossCollectionComp", package.seeall)

slot0 = class("RougeMapBossCollectionComp", BaseViewExtended)

function slot0.definePrefabUrl(slot0)
	slot0:setPrefabUrl("ui/viewres/rouge/dlc/103/rougedistortruleview.prefab")
end

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "Bg/normal")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "Bg/hard")
	slot0._gocollection = gohelper.findChild(slot0.viewGO, "#go_collection")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "#go_collection/#go_collectionitem")
	slot0._btnfresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fresh")
	slot0._txtrule = gohelper.findChildText(slot0.viewGO, "RuleView/Viewport/Content/#txt_rule")
	slot0._gopic = gohelper.findChild(slot0.PARENT_VIEW.viewGO, "#go_layer_right/#go_pic")
	slot0._gofreshnormal = gohelper.findChild(slot0.viewGO, "fresh_normal")
	slot0._gofreshhard = gohelper.findChild(slot0.viewGO, "fresh_hard")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfresh:AddClickListener(slot0._btnfreshOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfresh:RemoveClickListener()
end

function slot0._btnfreshOnClick(slot0)
	if not slot0._selectLayerId or not slot0._canFreshMapRule then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.RefreshRougeMapRule)

	slot1 = slot0._layerChoiceInfo and slot0._layerChoiceInfo:getMapRuleCo()
	slot2 = slot1 and slot1.type

	gohelper.setActive(slot0._gofreshnormal, slot2 == RougeDLCEnum103.MapRuleType.Normal)
	gohelper.setActive(slot0._gofreshhard, slot2 == RougeDLCEnum103.MapRuleType.Hard)
	RougeRpc.instance:sendRougeRefreshMapRuleRequest(RougeModel.instance:getSeason(), slot0._selectLayerId)
end

function slot0._editableInitView(slot0)
	slot0._collectionItemTab = slot0:getUserDataTb_()
	slot0._gofresh_light = gohelper.findChild(slot0.viewGO, "#btn_fresh/light")
	slot0._gofresh_dark = gohelper.findChild(slot0.viewGO, "#btn_fresh/dark")

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLayerChange, slot0.onSelectLayerChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, slot0.onChangeMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, slot0.onChangeMapInfo, slot0)
end

function slot0.onOpen(slot0)
	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	slot0:initData(RougeMapModel.instance:getSelectLayerId())
	slot0:refresh()
end

function slot0.initData(slot0, slot1)
	slot0._selectLayerId = slot1
	slot0._layerChoiceInfo = RougeMapModel.instance:getLayerChoiceInfo(slot0._selectLayerId)
	slot0._mapRuleCanFreshNum = slot0._layerChoiceInfo and slot0._layerChoiceInfo:getMapRuleCanFreshNum()
	slot0._canFreshMapRule = slot0._mapRuleCanFreshNum and slot0._mapRuleCanFreshNum > 0
	slot0._isPathSelect = RougeMapModel.instance:isPathSelect()
end

function slot0.refresh(slot0)
	gohelper.setActive(slot0._gopic, not slot0._isPathSelect)

	if not slot0._isPathSelect then
		return
	end

	slot0:refreshFreshBtn()
	slot0:refreshMapRuleInfos()
	slot0:refreshCollections()
end

function slot0.refreshFreshBtn(slot0)
	gohelper.setActive(slot0._gofresh_light, slot0._canFreshMapRule)
	gohelper.setActive(slot0._gofresh_dark, not slot0._canFreshMapRule)
end

function slot0.refreshMapRuleInfos(slot0)
	slot1 = slot0._layerChoiceInfo and slot0._layerChoiceInfo:getMapRuleCo()
	slot2 = slot1 and slot1.type
	slot0._txtrule.text = SkillHelper.buildDesc(slot1 and slot1.desc or "")

	SkillHelper.addHyperLinkClick(slot0._txtrule)
	gohelper.setActive(slot0._gonormal, slot2 == RougeDLCEnum103.MapRuleType.Normal)
	gohelper.setActive(slot0._gohard, slot2 == RougeDLCEnum103.MapRuleType.Hard)
end

function slot0.refreshCollections(slot0)
	slot0._collectionCfgIds = slot0._layerChoiceInfo and slot0._layerChoiceInfo:getCurLayerCollection()
	slot1 = {
		[slot7] = true
	}

	for slot5, slot6 in ipairs(slot0._collectionCfgIds or {}) do
		slot0:_getOrCreateCollectionItem(slot5).simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot6))
		UISpriteSetMgr.instance:setRougeSprite(slot7.imagebg, "rouge_episode_collectionbg_" .. tostring(RougeCollectionConfig.instance:getCollectionCfg(slot6) and slot8.showRare))
		gohelper.setActive(slot7.viewGO, true)
	end

	for slot5, slot6 in pairs(slot0._collectionItemTab) do
		if not slot1[slot6] then
			gohelper.setActive(slot6.viewGO, false)
		end
	end
end

function slot0._getOrCreateCollectionItem(slot0, slot1)
	if not slot0._collectionItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._gocollectionitem, "collection_" .. slot1)
		slot2.imagebg = gohelper.findChildImage(slot2.viewGO, "#image_bg")
		slot2.simageicon = gohelper.findChildSingleImage(slot2.viewGO, "#simage_collection")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "#btn_click")

		slot2.btnclick:AddClickListener(slot0._btncollectionOnClick, slot0, slot1)

		slot0._collectionItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._btncollectionOnClick(slot0, slot1)
	if not slot0._collectionCfgIds[slot1] then
		return
	end

	RougeController.instance:openRougeCollectionTipView({
		interactable = false,
		collectionCfgId = slot2,
		viewPosition = RougeEnum.CollectionTipPos.MapRule
	})
end

function slot0._releaseAllCollectionItems(slot0)
	for slot4, slot5 in pairs(slot0._collectionItemTab) do
		slot5.simageicon:UnLoadImage()
		slot5.btnclick:RemoveClickListener()
	end
end

function slot0.onSelectLayerChange(slot0, slot1)
	slot0:initData(slot1)
	gohelper.setActive(slot0._gofreshnormal, false)
	gohelper.setActive(slot0._gofreshhard, false)
	TaskDispatcher.cancelTask(slot0.refresh, slot0)
	TaskDispatcher.runDelay(slot0.refresh, slot0, RougeMapEnum.WaitMapRightRefreshTime)
end

function slot0.onChangeMapInfo(slot0)
	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	slot0:initData(RougeMapModel.instance:getSelectLayerId())
	slot0:refresh()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refresh, slot0)
	slot0:_releaseAllCollectionItems()
end

return slot0
