module("modules.logic.permanent.view.enterview.Permanent1_3EnterView", package.seeall)

slot0 = class("Permanent1_3EnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._btnEntranceRole1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	slot0._goReddot1 = gohelper.findChild(slot0.viewGO, "Left/EntranceRole1/#go_Reddot1")
	slot0._btnEntranceRole2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	slot0._goReddot2 = gohelper.findChild(slot0.viewGO, "Left/EntranceRole2/#go_Reddot2")
	slot0._btnPlay = gohelper.findChildButtonWithAudio(slot0.viewGO, "Title/#btn_Play")
	slot0._btnEntranceDungeon = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")
	slot0._goReddot3 = gohelper.findChild(slot0.viewGO, "Right/#go_Reddot3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEntranceRole1:AddClickListener(slot0._btnEntranceRole1OnClick, slot0)
	slot0._btnEntranceRole2:AddClickListener(slot0._btnEntranceRole2OnClick, slot0)
	slot0._btnPlay:AddClickListener(slot0._btnPlayOnClick, slot0)
	slot0._btnEntranceDungeon:AddClickListener(slot0._btnEntranceDungeonOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEntranceRole1:RemoveClickListener()
	slot0._btnEntranceRole2:RemoveClickListener()
	slot0._btnPlay:RemoveClickListener()
	slot0._btnEntranceDungeon:RemoveClickListener()
end

function slot0._btnEntranceRole1OnClick(slot0)
	if string.nilorempty(ActivityConfig.instance:getActivityCo(VersionActivity1_3Enum.ActivityId.Act304).confirmCondition) then
		Activity1_3ChessController.instance:openMapView()
	elseif OpenModel.instance:isFunctionUnlock(tonumber(string.split(slot2, "=")[2])) or PlayerPrefsHelper.getNumber(PlayerPrefsKey.EnterRoleActivity .. "#" .. tostring(VersionActivity1_3Enum.ActivityId.Act304) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), 0) == 1 then
		Activity1_3ChessController.instance:openMapView()
	else
		slot8 = OpenConfig.instance:getOpenCo(slot4)

		GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function ()
			PlayerPrefsHelper.setNumber(uv0, 1)
			Activity1_3ChessController.instance:openMapView()
		end, nil, , , , , DungeonConfig.instance:getEpisodeDisplay(slot8.episodeId) .. DungeonConfig.instance:getEpisodeCO(slot8.episodeId).name)
	end
end

function slot0._btnEntranceRole2OnClick(slot0)
	JiaLaBoNaController.instance:openMapView()
end

function slot0._btnPlayOnClick(slot0)
	StoryController.instance:playStory(slot0.actCfg.storyId)
end

function slot0._btnEntranceDungeonOnClick(slot0)
	VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0._editableInitView(slot0)
	slot0.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity1_3Enum.ActivityId.EnterView)
end

function slot0.onOpen(slot0)
	slot2 = ActivityConfig.instance:getActivityCo(VersionActivity1_3Enum.ActivityId.Act306)
	slot3 = ActivityConfig.instance:getActivityCo(VersionActivity1_3Enum.ActivityId.Dungeon)

	if ActivityConfig.instance:getActivityCo(VersionActivity1_3Enum.ActivityId.Act304).redDotId ~= 0 then
		RedDotController.instance:addRedDot(slot0._goReddot1, slot1.redDotId)
	end

	if slot2.redDotId ~= 0 then
		RedDotController.instance:addRedDot(slot0._goReddot2, slot2.redDotId)
	end

	if slot3.redDotId ~= 0 then
		RedDotController.instance:addRedDot(slot0._goReddot3, slot3.redDotId)
	end
end

function slot0.onClose(slot0)
	PermanentModel.instance:undateActivityInfo(slot0.actCfg.id)
end

return slot0
