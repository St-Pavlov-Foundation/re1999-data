module("modules.versionactivitybase.fixed.VersionActivityFixedHelper", package.seeall)

slot0 = class("VersionActivityFixedHelper")
slot1 = {
	big = 2,
	small = 7
}
slot2 = nil
slot3 = "%s_%s"
slot4 = "V%sa%s"
slot5 = "v%sa%s"

function slot6(slot0, slot1)
	return slot0 or uv0.big, slot1 or uv0.small
end

function slot7(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0(slot2, slot3)

	return string.format(slot0, string.format(slot1, slot4, slot5))
end

function slot8(slot0, slot1)
	slot0, slot1 = uv0(slot0, slot1)

	if not uv1 then
		uv1 = {}
	end

	if not uv1[slot0] then
		uv1[slot0] = {}
	end

	if not uv1[slot0][slot1] then
		uv1[slot0][slot1] = {}
	end

	return uv1[slot0][slot1]
end

function slot0.setMainActivitySprite(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = uv0(slot3, slot4)

	if not uv1(slot5, slot6)._MainActivitySpriteFunc then
		uv4[slot3][slot4]._MainActivitySpriteFunc = uv2("set%sMainActivitySprite", uv3, slot3, slot4)
	end

	UISpriteSetMgr.instance[slot6](UISpriteSetMgr.instance, slot0, slot1, slot2)
end

function slot0.setDungeonSprite(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = uv0(slot3, slot4)

	if not uv1(slot5, slot6)._DungeonSpriteFunc then
		uv4[slot3][slot4]._DungeonSpriteFunc = uv2("set%sDungeonSprite", uv3, slot3, slot4)
	end

	UISpriteSetMgr.instance[slot6](UISpriteSetMgr.instance, slot0, slot1, slot2)
end

function slot0.getVersionActivityEnum(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._Enum then
		uv4[slot0][slot1]._Enum = _G[uv2("VersionActivity%sEnum", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityEnterViewName(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._EnterViewName then
		uv4[slot0][slot1]._EnterViewName = ViewName[uv2("VersionActivity%sEnterView", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityStoreViewName(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._StoreViewName then
		uv4[slot0][slot1]._StoreViewName = ViewName[uv2("VersionActivity%sStoreView", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityTaskViewName(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._TaskViewName then
		uv4[slot0][slot1]._TaskViewName = ViewName[uv2("VersionActivity%sTaskView", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityDungeonEnum(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._DungeonEnum then
		uv4[slot0][slot1]._DungeonEnum = _G[uv2("VersionActivity%sDungeonEnum", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityDungeonMapViewName(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._DungeonMapViewName then
		uv4[slot0][slot1]._DungeonMapViewName = ViewName[uv2("VersionActivity%sDungeonMapView", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityDungeonMapLevelViewName(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._DungeonMapLevelView then
		uv4[slot0][slot1]._DungeonMapLevelView = ViewName[uv2("VersionActivity%sDungeonMapLevelView", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityDungeonEnterReddotId(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._DungeonEnter then
		uv4[slot0][slot1]._DungeonEnter = RedDotEnum.DotNode[uv2("%sDungeonEnter", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityDungeonTaskReddotId(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._DungeonEnter then
		uv4[slot0][slot1]._DungeonEnter = RedDotEnum.DotNode[uv2("%sDungeonTask", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityCurrencyType(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._CurrencyType then
		uv4[slot0][slot1]._CurrencyType = CurrencyEnum.CurrencyType[uv2("%sDungeon", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityAudioBgmLayer(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._AudioBgmLayer then
		uv4[slot0][slot1]._AudioBgmLayer = AudioBgmEnum.Layer[uv2("VersionActivity%sMain", uv3, slot0, slot1)]
	end

	return slot3
end

function slot0.getVersionActivityStoreRareIcon(slot0, slot1)
	slot2, slot3 = uv0(slot0, slot1)

	if not uv1(slot2, slot3)._StoreRareIcon then
		uv4[slot0][slot1]._StoreRareIcon = uv2("%s_store_quality_", uv3, slot0, slot1)
	end

	return slot3
end

function slot0._getFixed(slot0, slot1, slot2)
	slot3, slot4 = uv0(slot0, slot1)

	if not uv1(slot3, slot4)[slot2] then
		slot5 = "VersionActivity%s" .. slot2
		uv4[slot0][slot1][slot2] = _G[uv2(slot5, uv3, slot0, slot1)] or _G[string.format(slot5, "Fixed")]
	end

	return slot4
end

function slot0.getVersionActivityEnterController(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "EnterController")
end

function slot0.getVersionActivityDungeonController(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonController")
end

function slot0.getVersionActivityDungeonMapElement(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapElement")
end

function slot0.getVersionActivityDungeonMapHoleView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapHoleView")
end

function slot0.getVersionActivityDungeonMapScene(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapScene")
end

function slot0.getVersionActivityDungeonMapSceneElements(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapSceneElements")
end

function slot0.getVersionActivityDungeonMapChapterLayout(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapChapterLayout")
end

function slot0.getVersionActivityDungeonMapEpisodeItem(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapEpisodeItem")
end

function slot0.getVersionActivityDungeonMapEpisodeView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapEpisodeView")
end

function slot0.getVersionActivityDungeonMapFinishElement(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapFinishElement")
end

function slot0.getVersionActivityDungeonMapInteractView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapInteractView")
end

function slot0.getVersionActivityDungeonMapView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapView")
end

function slot0.getVersionActivityDungeonMapLevelView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonMapLevelView")
end

function slot0.getVersionActivityStoreGoodsItem(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "StoreGoodsItem")
end

function slot0.getVersionActivityStoreItem(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "StoreItem")
end

function slot0.getVersionActivityStoreView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "StoreView")
end

function slot0.getVersionActivityTaskItem(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "TaskItem")
end

function slot0.getVersionActivityTaskView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "TaskView")
end

function slot0.getVersionActivityDungeonEnterView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "DungeonEnterView")
end

function slot0.getVersionActivitySubAnimatorComp(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "SubAnimatorComp")
end

function slot0.getVersionActivityEnterBgmView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "EnterBgmView")
end

function slot0.getVersionActivityEnterView(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "EnterView")
end

function slot0.getVersionActivityEnterViewTabItem1(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "EnterViewTabItem1")
end

function slot0.getVersionActivityEnterViewTabItem2(slot0, slot1)
	return uv0._getFixed(slot0, slot1, "EnterViewTabItem2")
end

function slot0.isTargetVersion(slot0, slot1)
	return uv0.big == slot0 and uv0.small == slot1
end

return slot0
