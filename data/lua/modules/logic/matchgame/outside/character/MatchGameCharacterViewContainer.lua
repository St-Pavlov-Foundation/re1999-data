-- chunkname: @modules/logic/matchgame/outside/character/MatchGameCharacterViewContainer.lua

module("modules.logic.matchgame.outside.character.MatchGameCharacterViewContainer", package.seeall)

local MatchGameCharacterViewContainer = class("MatchGameCharacterViewContainer", BaseViewContainer)

MatchGameCharacterViewContainer.ContainerTabId = 2

function MatchGameCharacterViewContainer:buildViews()
	self._containerTabView = TabViewGroup.New(MatchGameCharacterViewContainer.ContainerTabId, "#go_Container")
	self._currencyView = MatchGameCurrencyView.New("#go_Currency", MatchGameEnum.ConstId.Currency)

	return {
		self._containerTabView,
		self._currencyView,
		MatchGameCharacterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function MatchGameCharacterViewContainer:onContainerInit()
	self:addEventCb(self, ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function MatchGameCharacterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == MatchGameCharacterViewContainer.ContainerTabId then
		return {
			MatchGameDevelopView.New(),
			MatchGameTalentView.New()
		}
	end
end

function MatchGameCharacterViewContainer:getCurTabId()
	return self._containerTabView:getCurTabId()
end

function MatchGameCharacterViewContainer:updateCurrency()
	self._currencyView:updateInfo()
end

function MatchGameCharacterViewContainer:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId ~= MatchGameCharacterViewContainer.ContainerTabId then
		return
	end

	local constId = MatchGameEnum.ConstId.Currency

	if tabId == MatchGameEnum.CharacterTabType.Talent then
		constId = MatchGameEnum.ConstId.TalentCurrency
	end

	self._currencyView:updateInfo(constId)
end

return MatchGameCharacterViewContainer
