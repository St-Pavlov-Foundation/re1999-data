module("modules.logic.versionactivity1_3.jialabona.model.JiaLaBoNaStoryListModel", package.seeall)

slot0 = class("JiaLaBoNaStoryListModel", ListScrollModel)

function slot0.init(slot0, slot1, slot2)
	slot4 = {}
	slot5 = 0

	if Activity120Config.instance:getEpisodeStoryList(slot1, slot2) then
		for slot9, slot10 in ipairs(slot3) do
			slot11 = JiaLaBoNaStoryMO.New()

			slot11:init(slot9, slot10)
			table.insert(slot4, slot11)
		end
	end

	slot0:setList(slot4)
end

slot0.instance = slot0.New()

return slot0
