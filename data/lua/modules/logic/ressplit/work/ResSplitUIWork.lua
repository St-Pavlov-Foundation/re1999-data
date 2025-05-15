module("modules.logic.ressplit.work.ResSplitUIWork", package.seeall)

local var_0_0 = class("ResSplitUIWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = {
		"activity",
		"backpack",
		"battlepass",
		"character",
		"common",
		"commonbufftipview",
		"currency",
		"dungeon",
		"effect",
		"equip",
		"enemyinfo",
		"fight",
		"gift",
		"guide",
		"handbook",
		"help",
		"herogroup",
		"login",
		"mail",
		"main",
		"messagebox",
		"notice",
		"player",
		"power",
		"room",
		"rpcblock",
		"scene",
		"sdk",
		"settings",
		"signin",
		"skin",
		"social",
		"store",
		"story",
		"storynavigate",
		"summon",
		"summonresultview",
		"task",
		"teach",
		"tips",
		"toast",
		"video",
		"turnback",
		"gm",
		"newwelfare",
		"share",
		"headicon_",
		"headskinicon_",
		"signature",
		"loading",
		"message",
		"nickname",
		"propitem",
		"textures",
		"data_pic"
	}
	local var_1_1 = SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. "/ui/viewres/")
	local var_1_2 = {}

	for iter_1_0 = 0, var_1_1.Length - 1 do
		local var_1_3 = var_1_1[iter_1_0]

		if not string.find(var_1_3, ".meta") then
			local var_1_4 = false

			for iter_1_1, iter_1_2 in pairs(var_1_0) do
				if var_1_3 == "Assets/ZResourcesLib/ui/viewres/" .. iter_1_2 then
					var_1_4 = true

					break
				end
			end

			if var_1_4 == false then
				local var_1_5 = string.gsub(var_1_3, "Assets/ZResourcesLib/", "") .. "/"

				table.insert(var_1_2, var_1_5)
			end
		end
	end

	local var_1_6 = SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. "/singlebg/")
	local var_1_7 = {}

	for iter_1_3 = 0, var_1_6.Length - 1 do
		local var_1_8 = var_1_6[iter_1_3]

		if not string.find(var_1_8, ".meta") then
			local var_1_9 = false

			for iter_1_4, iter_1_5 in pairs(var_1_0) do
				if string.find(var_1_8, "Assets/ZResourcesLib/singlebg/" .. iter_1_5) then
					var_1_9 = true

					break
				end
			end

			if var_1_9 == false then
				local var_1_10 = string.gsub(var_1_8, "Assets/ZResourcesLib/", "") .. "/"

				table.insert(var_1_7, var_1_10)
			end
		end
	end

	for iter_1_6, iter_1_7 in pairs(var_1_2) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, iter_1_7, true)
	end

	for iter_1_8, iter_1_9 in pairs(var_1_7) do
		ResSplitModel.instance:setExclude(ResSplitEnum.SinglebgFolder, iter_1_9, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, iter_1_9, true)
	end

	arg_1_0:onDone(true)
end

return var_0_0
