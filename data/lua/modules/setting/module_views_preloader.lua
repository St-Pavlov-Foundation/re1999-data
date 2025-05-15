local var_0_0 = {
	DungeonView = function(arg_1_0)
		table.insert(arg_1_0, "ui/spriteassets/dungeon.asset")
		table.insert(arg_1_0, "singlebg/dungeon/full/bg1.png")
	end,
	DungeonMapView = function(arg_2_0)
		DungeonModel.instance.jumpEpisodeId = nil
	end,
	VersionActivityDungeonMapView = function(arg_3_0)
		DungeonModel.instance.jumpEpisodeId = nil
	end,
	SeasonMainView = function(arg_4_0)
		return
	end
}

function var_0_0.DungeonViewPreload(arg_5_0)
	local var_5_0 = {}

	table.insert(var_5_0, "ui/viewres/dungeon/dungeonview.prefab")
	var_0_0._startLoad(var_5_0, arg_5_0)
end

function var_0_0.VersionActivity2_8BossStoryEnterView(arg_6_0)
	local var_6_0 = VersionActivity2_8BossStorySceneView.getMap()

	table.insert(arg_6_0, string.format("scenes/%s.prefab", var_6_0.res))
end

function var_0_0.VersionActivity2_8BossActEnterView(arg_7_0)
	local var_7_0 = VersionActivity2_8BossActSceneView.getMap()

	table.insert(arg_7_0, string.format("scenes/%s.prefab", var_7_0.res))
end

function var_0_0.WeekWalkLayerViewPreload(arg_8_0)
	local var_8_0 = var_0_0._getResPathList(ViewName.WeekWalkLayerView)
	local var_8_1, var_8_2 = WeekWalkModel.instance:getInfo():getNotFinishedMap()

	if var_8_1.id <= 105 then
		table.insert(var_8_0, ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_1"))
	elseif var_8_1.id <= 205 then
		table.insert(var_8_0, ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_2"))
	else
		table.insert(var_8_0, ResUrl.getWeekWalkLayerIcon("full/bg_choose_deep"))
	end

	var_0_0._startLoad(var_8_0, arg_8_0)
end

function var_0_0.WeekWalk_2HeartLayerViewPreload(arg_9_0)
	local var_9_0 = var_0_0._getResPathList(ViewName.WeekWalk_2HeartLayerView)

	var_0_0._startLoad(var_9_0, arg_9_0)
end

function var_0_0.StoreViewPreload(arg_10_0)
	local var_10_0 = {}

	table.insert(var_10_0, module_views.StoreView.mainRes)
	var_0_0._startLoad(var_10_0, arg_10_0)
end

function var_0_0.TaskView(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(module_views.TaskView.tabRes[2]) do
		table.insert(arg_11_0, iter_11_1[1])
	end
end

function var_0_0.DungeonViewGold(arg_12_0)
	local var_12_0 = {}

	table.insert(var_12_0, "singlebg/dungeon/full/bg123.png")
	var_0_0._startLoad(var_12_0, arg_12_0)
end

function var_0_0.DungeonViewBreak(arg_13_0)
	local var_13_0 = {}

	table.insert(var_13_0, "singlebg/dungeon/full/bg123.png")
	var_0_0._startLoad(var_13_0, arg_13_0)
end

function var_0_0.DungeonViewWeekWalk(arg_14_0)
	local var_14_0 = {}

	table.insert(var_14_0, "ui/viewres/dungeon/dungeonweekwalkview.prefab")
	var_0_0._startLoad(var_14_0, arg_14_0)
end

function var_0_0.DungeonViewExplore(arg_15_0)
	local var_15_0 = {}

	table.insert(var_15_0, DungeonEnum.dungeonexploreviewPath)
	var_0_0._startLoad(var_15_0, arg_15_0)
end

function var_0_0.ExploreArchivesView(arg_16_0)
	local var_16_0 = 1401
	local var_16_1 = ViewMgr.instance:getContainer(ViewName.ExploreArchivesView)

	if var_16_1 and var_16_1.viewParam then
		var_16_0 = var_16_1.viewParam.id
	end

	table.insert(arg_16_0, string.format("ui/viewres/explore/explorearchivechapter%d.prefab", var_16_0))
end

function var_0_0.preloadMultiView(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_2) do
		local var_17_1 = var_0_0._getResPathList(iter_17_1)

		for iter_17_2, iter_17_3 in ipairs(var_17_1) do
			table.insert(var_17_0, iter_17_3)
		end
	end

	if arg_17_3 then
		for iter_17_4, iter_17_5 in ipairs(arg_17_3) do
			table.insert(var_17_0, iter_17_5)
		end
	end

	var_0_0._startLoad(var_17_0, arg_17_0, arg_17_1)
end

function var_0_0.DungeonChapterAndLevelView(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {}
	local var_18_1 = var_0_0._getResPathList(ViewName.DungeonMapView)

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		table.insert(var_18_0, iter_18_1)
	end

	if arg_18_2 then
		local var_18_2 = var_0_0._getResPathList(arg_18_2)

		for iter_18_2, iter_18_3 in ipairs(var_18_2) do
			table.insert(var_18_0, iter_18_3)
		end
	end

	var_0_0._startLoad(var_18_0, arg_18_0)
end

function var_0_0.CharacterDataVoiceView(arg_19_0)
	local var_19_0 = {}

	table.insert(var_19_0, ResUrl.getCharacterDataIcon("full/bg_di_004.png"))
	table.insert(var_19_0, "ui/viewres/character/characterdata/characterdatavoiceview.prefab")
	var_0_0._startLoad(var_19_0, arg_19_0)
end

function var_0_0.CharacterDataItemView(arg_20_0)
	local var_20_0 = {}

	table.insert(var_20_0, ResUrl.getCharacterDataIcon("full/bg_tingyongdi_006.png"))
	table.insert(var_20_0, "ui/viewres/character/characterdata/characterdataitemview.prefab")
	var_0_0._startLoad(var_20_0, arg_20_0)
end

function var_0_0.CharacterDataCultureView(arg_21_0)
	local var_21_0 = {}

	table.insert(var_21_0, ResUrl.getCharacterDataIcon("full/bg_di_004.png"))
	table.insert(var_21_0, "ui/viewres/character/characterdata/characterdatacultureview.prefab")
	var_0_0._startLoad(var_21_0, arg_21_0)
end

function var_0_0.CharacterBackpackView(arg_22_0)
	table.insert(arg_22_0, "ui/viewres/common/item/commonheroitemnew.prefab")
end

function var_0_0.FightLoadingView(arg_23_0)
	local var_23_0 = {}

	table.insert(var_23_0, "ui/viewres/fight/fightloadingview.prefab")
	var_0_0._startLoad(var_23_0, arg_23_0)
end

function var_0_0.BpViewPreLoad(arg_24_0)
	local var_24_0 = {}

	if BpModel.instance.firstShow then
		table.insert(var_24_0, "ui/viewres/battlepass/bpvideoview.prefab")
	end

	var_0_0._startLoad(var_24_0, arg_24_0)
end

function var_0_0.BpView(arg_25_0)
	local var_25_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

	if var_25_0 and var_25_0.isSp then
		local var_25_1 = ViewMgr.instance:getSetting(ViewName.BpSPView)

		if var_25_1 then
			if var_25_1.mainRes then
				table.insert(arg_25_0, var_25_1.mainRes)
			end

			if var_25_1.otherRes then
				for iter_25_0, iter_25_1 in pairs(var_25_1.otherRes) do
					table.insert(arg_25_0, iter_25_1)
				end
			end
		end
	end
end

function var_0_0.BpSPView(arg_26_0)
	local var_26_0 = ViewMgr.instance:getSetting(ViewName.BpView)

	if var_26_0 then
		if var_26_0.mainRes then
			table.insert(arg_26_0, var_26_0.mainRes)
		end

		if var_26_0.otherRes then
			for iter_26_0, iter_26_1 in pairs(var_26_0.otherRes) do
				table.insert(arg_26_0, iter_26_1)
			end
		end
	end
end

function var_0_0.SummonADView(arg_27_0)
	local var_27_0 = SummonMainController.instance:getCurPoolPreloadRes()

	if #var_27_0 > 0 then
		for iter_27_0, iter_27_1 in ipairs(var_27_0) do
			table.insert(arg_27_0, iter_27_1)
		end
	end
end

function var_0_0.EliminateLevelView(arg_28_0)
	local var_28_0 = EliminateLevelController.instance:getCurLevelNeedPreloadRes()

	if #var_28_0 > 0 then
		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			table.insert(arg_28_0, iter_28_1)
		end
	end
end

function var_0_0.V1a4_BossRushLevelDetail(arg_29_0)
	local var_29_0 = ViewMgr.instance:getContainer(ViewName.V1a4_BossRushLevelDetail)
	local var_29_1 = var_29_0 and var_29_0.viewParam

	if not var_29_1 then
		return
	end

	local var_29_2 = var_29_1.stage
	local var_29_3 = BossRushConfig.instance:getMonsterResPathList(var_29_2)

	for iter_29_0, iter_29_1 in ipairs(var_29_3) do
		table.insert(arg_29_0, iter_29_1)
	end

	table.insert(arg_29_0, BossRushConfig.instance:getBossRushLevelDetailFullBgSimage(var_29_2))
end

function var_0_0.VersionActivity2_7DungeonMapView(arg_30_0)
	local var_30_0 = VersionActivity2_7DungeonEnum.SpaceScene

	table.insert(arg_30_0, var_30_0)
end

function var_0_0.OptionalChargeView(arg_31_0)
	local var_31_0 = {
		"ui/viewres/store/optionalgiftview.prefab"
	}

	var_0_0._startLoad(var_31_0, arg_31_0)
end

function var_0_0.Season166MainView(arg_32_0)
	local var_32_0 = Season166Model.instance:getCurSeasonId()
	local var_32_1 = Season166Config.instance:getSeasonConstStr(var_32_0, Season166Enum.MainSceneUrl)

	if var_32_1 then
		table.insert(arg_32_0, var_32_1)
	end
end

function var_0_0.V2a3_WarmUp(arg_33_0)
	local var_33_0 = ViewMgr.instance:getContainer(ViewName.V2a3_WarmUp)

	if not var_33_0 then
		return
	end

	local var_33_1 = var_33_0:getEpisodeCount()

	for iter_33_0 = 1, var_33_1 do
		local var_33_2 = var_33_0:getImgResUrl(iter_33_0)

		table.insert(arg_33_0, var_33_2)
	end
end

local var_0_1 = {}

function var_0_0._startLoad(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = MultiAbLoader.New()

	var_0_1[var_34_0] = true

	UIBlockMgr.instance:startBlock("ui_preload")
	var_34_0:setPathList(arg_34_0)
	var_34_0:startLoad(function()
		var_0_1[var_34_0] = nil

		UIBlockMgr.instance:endBlock("ui_preload")
		var_34_0:dispose()
		arg_34_1(arg_34_2)
	end)
end

function var_0_0.stopPreload()
	for iter_36_0, iter_36_1 in pairs(var_0_1) do
		iter_36_0:dispose()
		logNormal("module_views_preloader dispose loader")
	end

	var_0_1 = {}
end

function var_0_0._getResPathList(arg_37_0)
	local var_37_0 = {}
	local var_37_1 = ViewMgr.instance:getSetting(arg_37_0)

	if var_37_1.mainRes then
		table.insert(var_37_0, var_37_1.mainRes)
	end

	if var_37_1.otherRes then
		for iter_37_0, iter_37_1 in pairs(var_37_1.otherRes) do
			table.insert(var_37_0, iter_37_1)
		end
	end

	if var_37_1.tabRes then
		for iter_37_2, iter_37_3 in pairs(var_37_1.tabRes) do
			for iter_37_4, iter_37_5 in pairs(iter_37_3) do
				for iter_37_6, iter_37_7 in pairs(iter_37_5) do
					table.insert(var_37_0, iter_37_7)
				end
			end
		end
	end

	if var_37_1.anim and var_37_1.anim ~= ViewAnim.Default and string.find(var_37_1.anim, ".controller") then
		table.insert(var_37_0, var_37_1.anim)
	end

	return var_37_0
end

return var_0_0
