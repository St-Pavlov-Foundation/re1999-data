-- chunkname: @modules/logic/activitywelfare/controller/VersionActivity3_8SelfSelectSixController.lua

module("modules.logic.activitywelfare.controller.VersionActivity3_8SelfSelectSixController", package.seeall)

local VersionActivity3_8SelfSelectSixController = class("VersionActivity3_8SelfSelectSixController", BaseController)

function VersionActivity3_8SelfSelectSixController:onInit()
	self:reInit()
end

function VersionActivity3_8SelfSelectSixController:reInit()
	return
end

function VersionActivity3_8SelfSelectSixController:openHeroChoiceView()
	local heroList = VersionActivity3_8SelfSelectSixModel.instance:getAllChoiceHeroDestinyList()

	if #heroList > 0 then
		local ignoreIds = VersionActivity3_8SelfSelectSixModel.instance:getIgnoreIds()
		local param = {
			materialId = VersionActivity3_8SelfSelectSixModel.ItemId,
			ignoreIds = ignoreIds
		}

		DestinyStoneGiftPickChoiceListModel.instance:initList(ignoreIds, heroList)
		ViewMgr.instance:openView(ViewName.DestinyStoneGiftPickChoiceView, param)
	else
		GameFacade.showToast(ToastEnum.NoHeroCanDestinyUp)
	end
end

function VersionActivity3_8SelfSelectSixController:openHeroChoicePreview()
	local heroList = VersionActivity3_8SelfSelectSixModel.instance:getAllPreviewHeroList()
	local param = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = heroList,
		ignoreIds = VersionActivity3_8SelfSelectSixModel.instance:getIgnoreIds()
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, param)
end

VersionActivity3_8SelfSelectSixController.instance = VersionActivity3_8SelfSelectSixController.New()

return VersionActivity3_8SelfSelectSixController
