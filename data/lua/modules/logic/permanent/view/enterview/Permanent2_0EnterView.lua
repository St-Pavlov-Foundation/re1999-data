﻿-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_0EnterView.lua

module("modules.logic.permanent.view.enterview.Permanent2_0EnterView", package.seeall)

local Permanent2_0EnterView = class("Permanent2_0EnterView", BaseView)

function Permanent2_0EnterView:onInitView()
	self._btnEntranceRole1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	self._goReddot1 = gohelper.findChild(self.viewGO, "Left/EntranceRole1/#go_Reddot1")
	self._btnEntranceRole2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	self._goReddot2 = gohelper.findChild(self.viewGO, "Left/EntranceRole2/#go_Reddot2")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "logo/#btn_Play")
	self._goReddot3 = gohelper.findChild(self.viewGO, "Right/#go_Reddot3")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Achievement")
	self._btnEntranceDungeon = gohelper.findChildButtonWithAudio(self.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Permanent2_0EnterView:addEvents()
	self:addClickCb(self._btnEntranceRole1, self._btnEntranceRole1OnClick, self)
	self:addClickCb(self._btnEntranceRole2, self._btnEntranceRole2OnClick, self)
	self:addClickCb(self._btnPlay, self._btnPlayOnClick, self)
	self:addClickCb(self._btnAchievement, self._btnAchievementOnClick, self)
	self:addClickCb(self._btnEntranceDungeon, self._btnEntranceDungeonOnClick, self)
end

function Permanent2_0EnterView:_btnEntranceRole1OnClick()
	RoleActivityController.instance:enterActivity(VersionActivity2_0Enum.ActivityId.Joe)
end

function Permanent2_0EnterView:_btnEntranceRole2OnClick()
	RoleActivityController.instance:enterActivity(VersionActivity2_0Enum.ActivityId.Mercuria)
end

function Permanent2_0EnterView:_btnPlayOnClick()
	local param = {}

	param.isVersionActivityPV = true

	StoryController.instance:playStory(self.actCfg.storyId, param)
end

function Permanent2_0EnterView:_btnAchievementOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function Permanent2_0EnterView:_btnEntranceDungeonOnClick()
	VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView()
end

function Permanent2_0EnterView:_editableInitView()
	self.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity2_0Enum.ActivityId.EnterView)

	gohelper.setActive(self._btnAchievement.gameObject, false)
end

function Permanent2_0EnterView:onOpen()
	local act1MO = ActivityConfig.instance:getActivityCo(VersionActivity2_0Enum.ActivityId.Joe)
	local act2MO = ActivityConfig.instance:getActivityCo(VersionActivity2_0Enum.ActivityId.Mercuria)

	if act1MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot1, act1MO.redDotId, act1MO.id)
	end

	if act2MO.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goReddot2, act2MO.redDotId, act2MO.id)
	end

	RedDotController.instance:addMultiRedDot(self._goReddot3, {
		{
			id = RedDotEnum.DotNode.V2a0DungeonTask
		},
		{
			id = RedDotEnum.DotNode.V2a0DungeonEnter
		}
	})
end

function Permanent2_0EnterView:onClose()
	PermanentModel.instance:undateActivityInfo(self.actCfg.id)
end

return Permanent2_0EnterView
