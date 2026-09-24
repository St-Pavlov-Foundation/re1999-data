-- chunkname: @modules/logic/main/controller/work/CasualSkinGiftPatWork.lua

module("modules.logic.main.controller.work.CasualSkinGiftPatWork", package.seeall)

local CasualSkinGiftPatWork = class("CasualSkinGiftPatWork", ActivityRoleSignWorkBase)

function CasualSkinGiftPatWork:onGetViewNames()
	local viewName = PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)

	if not string.nilorempty(viewName) then
		return {
			viewName
		}
	end

	return {
		ViewName.CasualSkinGift_PanelView
	}
end

function CasualSkinGiftPatWork:onGetActIds()
	local actId = PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)

	if actId and actId > 0 then
		return {
			actId
		}
	end

	return {
		(ActivityType101Config.instance:getCasualSkinGiftActId())
	}
end

return CasualSkinGiftPatWork
