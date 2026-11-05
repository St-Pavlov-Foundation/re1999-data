-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/develop/ArcadeSurvivorDevelopViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.develop.ArcadeSurvivorDevelopViewContainer", package.seeall)

local ArcadeSurvivorDevelopViewContainer = class("ArcadeSurvivorDevelopViewContainer", BaseViewContainer)

function ArcadeSurvivorDevelopViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeSurvivorDevelopView.New())
	table.insert(views, TabViewGroupFit.New(1, "#go_view"))
	table.insert(views, TabViewGroup.New(2, "#go_currency"))

	return views
end

function ArcadeSurvivorDevelopViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "root/#scroll_talent"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		scrollParam.prefabUrl = "root/#go_item"
		scrollParam.cellClass = ArcadeSurvivorTalentItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirH
		scrollParam.cellWidth = 508
		scrollParam.cellHeight = 900
		scrollParam.cellSpaceH = 26

		local talentScrollView = LuaListScrollView.New(ArcadeSurvivorTalentListModel.instance, scrollParam)
		local multiView = {
			ArcadeSurvivorHeroView.New(),
			(MultiView.New({
				ArcadeSurvivorTalentView.New(),
				talentScrollView
			}))
		}

		return multiView
	elseif tabContainerId == 2 then
		self._currencyView = ArcadeSurvivorCurrencyView.New({
			ArcadeSurvivorEnum.Currency.Diamond
		})

		return {
			self._currencyView
		}
	end
end

function ArcadeSurvivorDevelopViewContainer:refreshCurrencyView()
	self._currencyView:refreshView()
end

function ArcadeSurvivorDevelopViewContainer:selectActTab(jumpTabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, jumpTabId)
end

return ArcadeSurvivorDevelopViewContainer
