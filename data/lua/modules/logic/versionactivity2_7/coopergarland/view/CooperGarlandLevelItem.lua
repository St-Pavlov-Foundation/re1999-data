module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandLevelItem", package.seeall)

slot0 = class("CooperGarlandLevelItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goType1 = gohelper.findChild(slot0._go, "#go_Type1")
	slot0._goIcon = gohelper.findChild(slot0._go, "#go_Type1/image_Stage")
	slot0._goType2 = gohelper.findChild(slot0._go, "#go_Type2")
	slot0._goSPIcon = gohelper.findChild(slot0._go, "#go_Type2/image_Stage")
	slot0._goStageItem = gohelper.findChild(slot0._go, "#go_Type1/#go_StageItem")
	slot0._imageStageItem = gohelper.findChildImage(slot0._go, "#go_Type1/#go_StageItem")
	slot0.spStageList = slot0:getUserDataTb_()
	slot0.spStageImageList = slot0:getUserDataTb_()
	slot2 = nil
	slot3 = 0

	repeat
		if gohelper.findChild(slot0._go, string.format("#go_Type2/#go_StageItem%s", slot3 + 1)) then
			slot0.spStageList[slot3] = slot2
			slot0.spStageImageList[slot3] = slot2:GetComponent(gohelper.Type_Image)
		end
	until gohelper.isNil(slot2)

	slot0._goSelected = gohelper.findChild(slot0._go, "#go_Selected")
	slot0._goLocked = gohelper.findChild(slot0._go, "#go_Locked")
	slot0._goStar1 = gohelper.findChild(slot0._go, "Stars/#go_Star1")
	slot0._goStar2 = gohelper.findChild(slot0._go, "Stars/#go_Star2")
	slot0._goStar3 = gohelper.findChild(slot0._go, "Stars/#go_Star3")
	slot0._imageStageNum = gohelper.findChildImage(slot0._go, "#image_StageNum")
	slot0._txtStageName = gohelper.findChildText(slot0._go, "#txt_StageName")
	slot0._btnclick = gohelper.getClickWithDefaultAudio(slot0._go)
	slot0._animator = gohelper.findChildAnim(slot0._go, "")
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, slot0.refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, slot0.refreshUI, slot0)
end

function slot0._btnclickOnClick(slot0)
	CooperGarlandController.instance:clickEpisode(slot0.actId, slot0.episodeId)
end

function slot0.setData(slot0, slot1, slot2, slot3, slot4)
	slot0.actId = slot1
	slot0.episodeId = slot2
	slot0.index = slot3
	slot0.gameIndex = slot4

	slot0:setInfo()
	slot0:refreshUI()
end

function slot0.setInfo(slot0)
	slot0._txtStageName.text = CooperGarlandConfig.instance:getEpisodeName(slot0.actId, slot0.episodeId)

	UISpriteSetMgr.instance:setV2a7CooperGarlandSprite(slot0._imageStageNum, string.format("v2a7_coopergarland_level_stage_0%s", slot0.index))

	if slot0.gameIndex then
		for slot4, slot5 in ipairs(slot0.spStageList) do
			gohelper.setActive(slot5, slot0.gameIndex == slot4)
		end
	end

	gohelper.setActive(slot0._goType1, not slot0.gameIndex)
	gohelper.setActive(slot0._goType2, slot0.gameIndex)
end

function slot0.refreshUI(slot0, slot1)
	slot0:refreshStatus(slot1)
	slot0:refreshSelected()
end

function slot0.refreshStatus(slot0, slot1)
	slot2 = false

	if CooperGarlandModel.instance:isUnlockEpisode(slot0.actId, slot0.episodeId) then
		slot2 = CooperGarlandModel.instance:isFinishedEpisode(slot0.actId, slot0.episodeId)
	end

	gohelper.setActive(slot0._goStar1, not slot2)
	gohelper.setActive(slot0._goStar2, slot2 and not slot0.gameIndex)
	gohelper.setActive(slot0._goStar3, slot2 and slot0.gameIndex)

	if slot0.gameIndex then
		SLFramework.UGUI.GuiHelper.SetColor(slot0.spStageImageList[slot0.gameIndex], slot3 and "#FFFFFF" or "#969696")
		ZProj.UGUIHelper.SetGrayscale(slot0.spStageList[slot0.gameIndex], not slot3)
		ZProj.UGUIHelper.SetGrayscale(slot0._goSPIcon, not slot3)
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imageStageItem, slot4)
		ZProj.UGUIHelper.SetGrayscale(slot0._goStageItem, not slot3)
		ZProj.UGUIHelper.SetGrayscale(slot0._goIcon, not slot3)
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageStageNum, slot3 and "#FFFFFF" or "#C8C8C8")
	ZProj.UGUIHelper.SetGrayscale(slot0._imageStageNum.gameObject, not slot3)
	gohelper.setActive(slot0._goLocked, not slot3)
	slot0:_playAnim(slot1)
end

function slot0._playAnim(slot0, slot1)
	if string.nilorempty(slot1) then
		return
	end

	slot0._animator:Play(slot1, 0, 0)
end

function slot0.refreshSelected(slot0)
	gohelper.setActive(slot0._goSelected, CooperGarlandModel.instance:isNewestEpisode(slot0.actId, slot0.episodeId))
end

return slot0
