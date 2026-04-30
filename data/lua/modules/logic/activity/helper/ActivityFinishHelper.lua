-- chunkname: @modules/logic/activity/helper/ActivityFinishHelper.lua

module("modules.logic.activity.helper.ActivityFinishHelper", package.seeall)

local ActivityFinishHelper = _M

function ActivityFinishHelper.CheckActivity13746Finish(actId)
	if ActivityType101Model.instance:isType101RewardGet(actId, 1) then
		local config = ActivityConfig.instance:getActivityCo(actId)
		local packageId = tonumber(config.patFaceParam)
		local storeGoodsMo = StoreModel.instance:getGoodsMO(packageId)

		if storeGoodsMo and storeGoodsMo:isSoldOut() then
			return true
		end
	end

	return false
end

return ActivityFinishHelper
