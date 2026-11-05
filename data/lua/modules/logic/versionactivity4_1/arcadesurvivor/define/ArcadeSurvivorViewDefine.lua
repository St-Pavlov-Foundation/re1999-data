-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/define/ArcadeSurvivorViewDefine.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.define.ArcadeSurvivorViewDefine", package.seeall)

local ArcadeSurvivorViewDefine = {}

function ArcadeSurvivorViewDefine.init(module_views)
	module_views.ArcadeSurvivorHallView = {
		destroy = 0,
		container = "ArcadeSurvivorHallViewContainer",
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_hallview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					"modules/arcade_survivor/ui/viewres/arcade_survivor_currencyitem.prefab"
				}
			}
		}
	}
	module_views.ArcadeSurvivorGameView = {
		destroy = 0,
		container = "ArcadeSurvivorGameViewContainer",
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_gameview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					"modules/arcade_survivor/ui/viewres/arcade_survivor_currencyitem.prefab"
				}
			}
		}
	}
	module_views.ArcadeSurvivorGameResultView = {
		bgBlur = 3,
		container = "ArcadeSurvivorGameResultViewContainer",
		destroy = 0,
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.ArcadeSurvivorEventSelectView = {
		bgBlur = 3,
		container = "ArcadeSurvivorEventSelectViewContainer",
		destroy = 0,
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_eventselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	}
	module_views.ArcadeSurvivorShopView = {
		bgBlur = 3,
		container = "ArcadeSurvivorShopViewContainer",
		destroy = 0,
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_shopview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					"modules/arcade_survivor/ui/viewres/arcade_survivor_currencyitem.prefab"
				}
			}
		}
	}
	module_views.ArcadeSurvivorHandBookView = {
		destroy = 0,
		container = "ArcadeSurvivorHandBookViewContainer",
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_handbookview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.ArcadeSurvivorDevelopView = {
		destroy = 0,
		container = "ArcadeSurvivorDevelopViewContainer",
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_selectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		tabRes = {
			{
				{
					"modules/arcade_survivor/ui/viewres/arcade_survivor_heroview.prefab"
				},
				{
					"modules/arcade_survivor/ui/viewres/arcade_survivor_talentview.prefab"
				}
			},
			{
				{
					"modules/arcade_survivor/ui/viewres/arcade_survivor_currencyitem.prefab"
				}
			}
		}
	}
	module_views.ArcadeSurvivorTipsView = {
		destroy = 0,
		container = "ArcadeSurvivorTipsViewContainer",
		mainRes = "modules/arcade_survivor/ui/viewres/tips/arcade_survivor_tipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			ArcadeSurvivorEnum.TipTypeRes[ArcadeSurvivorEnum.TipType.Building],
			ArcadeSurvivorEnum.TipTypeRes[ArcadeSurvivorEnum.TipType.Collection],
			ArcadeSurvivorEnum.TipTypeRes[ArcadeSurvivorEnum.TipType.Hero],
			ArcadeSurvivorEnum.TipTypeRes[ArcadeSurvivorEnum.TipType.Weapon],
			ArcadeSurvivorEnum.TipTypeRes[ArcadeSurvivorEnum.TipType.Currency],
			ArcadeSurvivorEnum.TipTypeRes[ArcadeSurvivorEnum.TipType.Event]
		}
	}
	module_views.ArcadeSurvivorRewardView = {
		destroy = 0,
		container = "ArcadeSurvivorRewardViewContainer",
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_rewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			itemRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_rewarditem.prefab"
		}
	}
	module_views.ArcadeSurvivorQuitTipView = {
		destroy = 0,
		container = "ArcadeSurvivorQuitTipViewContainer",
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_quittipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.ArcadeSurvivorDifficultyView = {
		destroy = 0,
		container = "ArcadeSurvivorDifficultyViewContainer",
		mainRes = "modules/arcade_survivor/ui/viewres/arcade_survivor_difficultselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	}
end

return ArcadeSurvivorViewDefine
