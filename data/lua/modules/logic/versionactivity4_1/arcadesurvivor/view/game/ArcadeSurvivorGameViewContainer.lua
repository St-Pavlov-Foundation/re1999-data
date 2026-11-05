-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorGameViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorGameViewContainer", package.seeall)

local ArcadeSurvivorGameViewContainer = class("ArcadeSurvivorGameViewContainer", BaseViewContainer)

function ArcadeSurvivorGameViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeSurvivorGameView.New())
	table.insert(views, TabViewGroup.New(1, "Top/#go_currency"))

	return views
end

function ArcadeSurvivorGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = ArcadeSurvivorCurrencyView.New({
			ArcadeSurvivorEnum.Currency.Coin
		}, true)

		return {
			self._currencyView
		}
	end
end

return ArcadeSurvivorGameViewContainer
