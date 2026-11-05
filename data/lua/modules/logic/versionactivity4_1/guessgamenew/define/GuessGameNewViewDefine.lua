-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/define/GuessGameNewViewDefine.lua

module("modules.logic.versionactivity4_1.guessgamenew.define.GuessGameNewViewDefine", package.seeall)

local GuessGameNewViewDefine = {}

function GuessGameNewViewDefine.init(module_views)
	module_views.GuessGameNewMainView = {
		destroy = 0,
		container = "GuessGameNewMainViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_mainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		preloader = module_views_preloader
	}
	module_views.GuessGameNewPlayView = {
		destroy = 0,
		container = "GuessGameNewPlayViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playtasktipview.prefab"
				}
			},
			{
				{
					"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playrolesview.prefab"
				}
			}
		},
		otherRes = {
			"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playgiftitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playroleitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playnpcitem.prefab"
		}
	}
	module_views.GuessGameNewPlayPlayerGuessView = {
		bgBlur = 3,
		container = "GuessGameNewPlayPlayerGuessViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playguessview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playtasktipview.prefab"
				}
			},
			{
				{
					"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playrolesview.prefab"
				}
			}
		},
		otherRes = {
			"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playgiftitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playroleitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playnpcitem.prefab"
		}
	}
	module_views.GuessGameNewPlayNpcGuessView = {
		bgBlur = 3,
		container = "GuessGameNewPlayNpcGuessViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playnpcguessview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playtasktipview.prefab"
				}
			},
			{
				{
					"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playrolesview.prefab"
				}
			}
		},
		otherRes = {
			"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playgiftitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playroleitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playnpcitem.prefab"
		}
	}
	module_views.GuessGameNewPlayRoundTipsView = {
		destroy = 0,
		container = "GuessGameNewPlayRoundTipsViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playroundtipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.GuessGameNewPlayRoleTipsView = {
		destroy = 0,
		container = "GuessGameNewPlayRoleTipsViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playroletipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.GuessGameNewPlayResultView = {
		bgBlur = 1,
		container = "GuessGameNewPlayResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_guessgamenew/v4a1_guessgamenew_playresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
end

return GuessGameNewViewDefine
