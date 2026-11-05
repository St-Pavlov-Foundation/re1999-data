-- chunkname: @modules/logic/versionactivity4_1/act248/define/Act248ViewDefine.lua

module("modules.logic.versionactivity4_1.act248.define.Act248ViewDefine", package.seeall)

local Act248ViewDefine = {}

function Act248ViewDefine.init(module_views)
	module_views.Act248AvgView = {
		destroy = 0,
		container = "Act248AvgViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_avgenterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.Act248EnterView = {
		destroy = 0,
		container = "Act248EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_enterview.prefab",
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
	module_views.Act248ClueMainView = {
		destroy = 0,
		container = "Act248ClueMainViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_cluedetailsview.prefab",
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
					"ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_clueleftview.prefab"
				}
			},
			{
				{
					"ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_clueinfo.prefab"
				}
			}
		}
	}
	module_views.Act248FileView = {
		destroy = 0,
		container = "Act248FileViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_caseclosedview.prefab",
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
	module_views.Act248ReportView = {
		destroy = 0,
		container = "Act248ReportViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_casereportview.prefab",
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
			[1] = "ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_roleitem.prefab"
		}
	}
	module_views.Act248DecryptionMainView = {
		destroy = 0,
		container = "Act248DecryptionMainViewContainer",
		mainRes = "ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_deductionboardpage.prefab",
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
					"ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_clueleftview.prefab"
				}
			},
			{
				{
					"ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_clueinfo.prefab"
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_4_1/v4a1_investigation/v4a1_investigation_cluecarditem.prefab"
		}
	}
end

return Act248ViewDefine
