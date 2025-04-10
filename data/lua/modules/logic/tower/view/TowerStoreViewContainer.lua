module("modules.logic.tower.view.TowerStoreViewContainer", package.seeall)

slot0 = class("TowerStoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TowerStoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if slot1 == 2 then
		slot0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.TowerStore
		}, slot0._onCurrencyCallback, slot0)
		slot0._currencyView.foreHideBtn = true

		return {
			slot0._currencyView
		}
	end
end

function slot0._onCurrencyCallback(slot0)
	BossRushController.instance:dispatchEvent(TowerEvent.OnHandleInStoreView)
end

return slot0
