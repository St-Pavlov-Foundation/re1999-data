-- chunkname: @modules/logic/versionactivity4_1/common/VersionActivity4_1ViewDefine.lua

module("modules.logic.versionactivity4_1.common.VersionActivity4_1ViewDefine", package.seeall)

local VersionActivity4_1ViewDefine = class("VersionActivity4_1ViewDefine")

function VersionActivity4_1ViewDefine.init(module_views)
	VersionActivity4_1ViewDefine.initEnter(module_views)
	VersionActivity4_1ViewDefine.initDungeon(module_views)
	VersionActivity4_1ViewDefine.initDungeonMiscView(module_views)
	VersionActivity4_1ViewDefine.initEvelyn(module_views)
	VersionActivity4_1ViewDefine.initPeiShiTaView(module_views)
end

function VersionActivity4_1ViewDefine.initEnter(module_views)
	module_views.VersionActivity4_1EnterView = {
		destroy = 0,
		container = "VersionActivity4_1EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_enter/v4a1_enterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/versionactivity_4_1/v4a1_enter/v4a1_dungeonenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v4a1_bossrush/v4a1_bossrush_enterview.prefab"
				},
				{
					"modules/arcade_survivor/ui/viewres/arcade_survivor_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_4_1/v4a1_peishita/v4a1_peishita_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_4_1/v4a1_season/v4a1_season_enterview.prefab"
				},
				{
					"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
				},
				{
					"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
				},
				{
					"ui/viewres/tower/towermainentryview.prefab"
				},
				{
					"ui/viewres/activity/show/activiyweekwalkheartshowview.prefab"
				},
				{
					"ui/viewres/cloudredemption/cloudredemption_enterview.prefab"
				}
			}
		}
	}
end

function VersionActivity4_1ViewDefine.initDungeon(module_views)
	module_views.VersionActivity4_1StoreView = {
		destroy = 0,
		container = "VersionActivityFixedStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_storeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					CurrencyView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity4_1TaskView = {
		destroy = 0,
		container = "VersionActivityFixedTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_taskview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			"ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_taskitem.prefab"
		}
	}
	module_views.VersionActivity4_1DungeonMapView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapViewContainer1",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_mapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_dungeonmap_direction.prefab",
			normalSceneItem = "ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_mapepisodeitem3.prefab",
			spSceneItem = "ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_mapepisodeitem4.prefab",
			spItem = "ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_mapepisodeitem2.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity4_1DungeonMapLevelView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapLevelViewContainer1",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_dungeonmaplevelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					CurrencyView.prefabPath
				}
			},
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
end

function VersionActivity4_1ViewDefine.initDungeonMiscView(module_views)
	module_views.VersionActivity4_1DungeonReportFullView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonReportFullViewContainer1",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_dungeonreport_fullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity4_1DungeonReportTipsView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonReportTipsViewContainer1",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_dungeon/v4a1_dungeonreport_tipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.VersionActivity4_1DungeonFragmentInfoView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonFragmentInfoViewContainer1",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonfragmentinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

function VersionActivity4_1ViewDefine.initEvelyn(module_views)
	module_views.EvelynLevelView = {
		destroy = 0,
		container = "EvelynLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_levelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_levelitem.prefab"
		}
	}
	module_views.EvelynTaskView = {
		bgBlur = 0,
		container = "EvelynTaskViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_taskview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_taskitem.prefab"
		}
	}
	module_views.EvelynGameView = {
		destroy = 0,
		container = "EvelynGameViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_gameview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_sourceitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_toolsitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_productitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_endingitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_lineitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_detailitem.prefab"
		}
	}
	module_views.EvelynPanelView = {
		destroy = 0,
		container = "EvelynPanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_panelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_sourceitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_toolsitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_productitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_endingitem.prefab",
			"ui/viewres/versionactivity_4_1/v4a1_yifulin/v4a1_yifulin_lineitem.prefab"
		}
	}
end

function VersionActivity4_1ViewDefine.initPeiShiTaView(module_views)
	module_views.PeiShiTaGameView = {
		destroy = 0,
		container = "PeiShiTaGameViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_peishita/v4a1_peishita_gameview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.PeiShiTaLevelView = {
		destroy = 0,
		container = "PeiShiTaLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_peishita/v4a1_peishita_levelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_4_1/v4a1_peishita/v4a1_peishita_levelitem.prefab"
		}
	}
	module_views.PeiShiTaTaskView = {
		bgBlur = 0,
		container = "PeiShiTaTaskViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_peishita/v4a1_peishita_taskview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_4_1/v4a1_peishita/v4a1_peishita_taskitem.prefab"
		}
	}
	module_views.PeiShiTaResultView = {
		destroy = 0,
		container = "PeiShiTaResultViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_peishita/v4a1_peishita_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
end

return VersionActivity4_1ViewDefine
