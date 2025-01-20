module("modules.logic.ressplit.work.ResSplitUIWork", package.seeall)

slot0 = class("ResSplitUIWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = {
		"achievement",
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
	slot4 = {}

	for slot8 = 0, SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. "/ui/viewres/").Length - 1 do
		if not string.find(slot3[slot8], ".meta") then
			slot10 = false

			for slot14, slot15 in pairs(slot2) do
				if slot9 == "Assets/ZResourcesLib/ui/viewres/" .. slot15 then
					slot10 = true

					break
				end
			end

			if slot10 == false then
				table.insert(slot4, string.gsub(slot9, "Assets/ZResourcesLib/", "") .. "/")
			end
		end
	end

	slot6 = {}

	for slot10 = 0, SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. "/singlebg/").Length - 1 do
		if not string.find(slot5[slot10], ".meta") then
			slot12 = false

			for slot16, slot17 in pairs(slot2) do
				if string.find(slot11, "Assets/ZResourcesLib/singlebg/" .. slot17) then
					slot12 = true

					break
				end
			end

			if slot12 == false then
				table.insert(slot6, string.gsub(slot11, "Assets/ZResourcesLib/", "") .. "/")
			end
		end
	end

	for slot10, slot11 in pairs(slot4) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, slot11, true)
	end

	for slot10, slot11 in pairs(slot6) do
		ResSplitModel.instance:setExclude(ResSplitEnum.SinglebgFolder, slot11, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, slot11, true)
	end

	slot0:onDone(true)
end

return slot0
