module("modules.logic.versionactivity1_2.jiexika.model.Activity114FeaturesModel", package.seeall)

slot0 = class("Activity114FeaturesModel", ListScrollModel)

function slot0.onFeatureListUpdate(slot0, slot1)
	for slot6 = 1, #slot1 do
	end

	slot0:setList({
		[slot6] = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, slot1[slot6])
	})
end

slot0.instance = slot0.New()

return slot0
