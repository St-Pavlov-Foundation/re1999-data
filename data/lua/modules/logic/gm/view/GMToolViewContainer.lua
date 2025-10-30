﻿-- chunkname: @modules/logic/gm/view/GMToolViewContainer.lua

module("modules.logic.gm.view.GMToolViewContainer", package.seeall)

local GMToolViewContainer = class("GMToolViewContainer", BaseViewContainer)

function GMToolViewContainer:buildViews()
	local gmAddItemListParam = ListScrollParam.New()

	gmAddItemListParam.scrollGOPath = "addItem/scroll"
	gmAddItemListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	gmAddItemListParam.prefabUrl = "addItem/scroll/item"
	gmAddItemListParam.cellClass = GMAddItem
	gmAddItemListParam.scrollDir = ScrollEnum.ScrollDirV
	gmAddItemListParam.lineCount = 1
	gmAddItemListParam.cellWidth = 794
	gmAddItemListParam.cellHeight = 100
	gmAddItemListParam.cellSpaceH = 0
	gmAddItemListParam.cellSpaceV = 0

	local gmPresetListParam = ListScrollParam.New()

	gmPresetListParam.scrollGOPath = "gmcommand/img/scroll"
	gmPresetListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	gmPresetListParam.prefabUrl = "gmcommand/img/scroll/item"
	gmPresetListParam.cellClass = GMCommandItem
	gmPresetListParam.scrollDir = ScrollEnum.ScrollDirV
	gmPresetListParam.lineCount = 1
	gmPresetListParam.cellWidth = 950
	gmPresetListParam.cellHeight = 100
	gmPresetListParam.cellSpaceH = 0
	gmPresetListParam.cellSpaceV = 5

	return {
		GMToolView.New(),
		GMToolView2.New(),
		GMAddItemView.New(),
		GMCommandHistoryView.New(),
		GMCommandView.New(),
		GMToolFightView.New(),
		GMAudioTool.New(),
		GMRougeTool.New(),
		LuaListScrollView.New(GMAddItemModel.instance, gmAddItemListParam),
		LuaListScrollView.New(GMCommandModel.instance, gmPresetListParam),
		GMSubViewOldView.New(),
		GMSubViewCommon.New(),
		GMSubViewNewFightView.New(),
		GMSubViewBattle.New(),
		GMSubViewFightPlayback.New(),
		GMSubViewAudio.New(),
		GMSubViewGuide.New(),
		GMSubViewActivity.New(),
		GMSubViewSurvival.New(),
		GMSubViewRole.New(),
		GMSubViewCode.New(),
		GMSubViewRouge.New(),
		GMSubViewRouge2.New(),
		GMSubViewResource.New(),
		GMSubViewProfiler.New(),
		GMSubViewRoom.New(),
		GMSubViewEliminate.New(),
		GMSubViewEditorFight.New(),
		GMYeShuMeiBtnView.New()
	}
end

function GMToolViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GMToolViewContainer:addSubViewToggle(toggle)
	self.toggleList = self.toggleList or self:getUserDataTb_()

	table.insert(self.toggleList, toggle)
end

function GMToolViewContainer:selectToggle(toggle)
	if self.toggleList then
		for index, tog in ipairs(self.toggleList) do
			if tog == toggle then
				PlayerPrefsHelper.setNumber("GMLastSelectIndexKey", index)
			end
		end
	end
end

function GMToolViewContainer:onContainerOpenFinish()
	local lastSelectIndex = PlayerPrefsHelper.getNumber("GMLastSelectIndexKey", 1)
	local toggle = self.toggleList and self.toggleList[lastSelectIndex]

	if toggle then
		toggle.isOn = true
	end
end

return GMToolViewContainer
