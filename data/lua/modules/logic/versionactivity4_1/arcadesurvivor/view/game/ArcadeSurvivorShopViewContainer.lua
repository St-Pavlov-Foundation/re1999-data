-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorShopViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorShopViewContainer", package.seeall)

local ArcadeSurvivorShopViewContainer = class("ArcadeSurvivorShopViewContainer", BaseViewContainer)

function ArcadeSurvivorShopViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeSurvivorShopView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_currency"))

	return views
end

function ArcadeSurvivorShopViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = ArcadeSurvivorCurrencyView.New({
			ArcadeSurvivorEnum.Currency.Coin
		}, true)

		return {
			self._currencyView
		}
	end
end

return ArcadeSurvivorShopViewContainer
