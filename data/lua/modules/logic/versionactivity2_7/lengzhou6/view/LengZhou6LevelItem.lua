module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6LevelItem", package.seeall)

slot0 = class("LengZhou6LevelItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "#go_Normal")
	slot0._goEvenLine = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_EvenLine")
	slot0._goLockedevenLine = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_EvenLine/#go_Locked_evenLine")
	slot0._goUnlockedevenLine = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_EvenLine/#go_Unlocked_evenLine")
	slot0._goOddLine = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_OddLine")
	slot0._goLockedoddLine = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_OddLine/#go_Locked_oddLine")
	slot0._goUnlockedoddLine = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_OddLine/#go_Unlocked_oddLine")
	slot0._goType1 = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_Type1")
	slot0._goLocked1 = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_Type1/#go_Locked_1")
	slot0._goNormal1 = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_Type1/#go_Normal_1")
	slot0._goCompleted1 = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_Type1/#go_Completed_1")
	slot0._goType2 = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_Type2")
	slot0._goLocked2 = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_Type2/#go_Locked_2")
	slot0._goNormal2 = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_Type2/#go_Normal_2")
	slot0._goCompleted2 = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_Type2/#go_Completed_2")
	slot0._imageStageNum = gohelper.findChildImage(slot0.viewGO, "#go_Normal/#image_StageNum")
	slot0._txtStageName = gohelper.findChildText(slot0.viewGO, "#go_Normal/#txt_StageName")
	slot0._goEndless = gohelper.findChild(slot0.viewGO, "#go_Endless")
	slot0._txtEndless = gohelper.findChildText(slot0.viewGO, "#go_Endless/#txt_Endless")
	slot0._txtLv = gohelper.findChildText(slot0.viewGO, "#go_Endless/#txt_Lv")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Endless/#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.LengZhou6EndLessClear, MsgBoxEnum.BoxType.Yes_No, slot0._endLessClear, nil, , slot0)
end

function slot0._endLessClear(slot0)
	UIBlockHelper.instance:startBlock(LengZhou6Enum.BlockKey.OneClickResetLevel)
	LengZhou6Controller.instance:finishLevel(slot0._episodeId, "")
end

function slot0._editableInitView(slot0)
	slot0._clickLister = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)

	slot0._clickLister:AddClickListener(slot0._onClick, slot0)

	slot0.ani = slot0.viewGO:GetComponent(gohelper.Type_Animator)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._onClick(slot0)
	if slot0._episodeId == nil then
		return
	end

	if not slot0._episode:unLock() then
		ToastController.instance:showToast(23)

		return
	end

	LengZhou6Controller.instance:clickEpisode(slot0._episodeId)
end

function slot0.initEpisodeId(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._episodeId = slot2
	slot0._episode = LengZhou6Model.instance:getEpisodeInfoMo(slot2)

	slot0:initView()
end

function slot0.initView(slot0)
	if slot0._episode == nil or slot0._episodeId == nil then
		return
	end

	if not slot0._episode:isEndlessEpisode() then
		slot0._txtStageName.text = slot0._episode:getEpisodeName()

		UISpriteSetMgr.instance:setHisSaBethSprite(slot0._imageStageNum, "v2a7_hissabeth_level_stage_0" .. slot0._index)
	else
		slot0._txtEndless.text = slot0._episode:getEpisodeName()
	end
end

function slot0.refreshState(slot0)
	slot1 = slot0._episode:isDown()
	slot2 = slot0._episode:unLock()
	slot4 = slot0._episode:isEndlessEpisode()
	slot5 = slot0._episode:haveEliminate()
	slot0._aniName = "open"

	if slot0._episode.isFinish then
		slot0._aniName = "finish"
	elseif slot2 then
		slot0._aniName = "unlock"
	end

	gohelper.setActive(slot0._goEvenLine, not slot1)
	gohelper.setActive(slot0._goOddLine, slot1)
	gohelper.setActive(slot0._goNormal, not slot4)
	gohelper.setActive(slot0._goEndless, slot4)

	if not slot4 then
		gohelper.setActive(slot0._goLocked1, not slot2)
		gohelper.setActive(slot0._goLocked2, not slot2)
		gohelper.setActive(slot0._goLockedevenLine, not slot2)
		gohelper.setActive(slot0._goLockedoddLine, not slot2)
		gohelper.setActive(slot0._goUnlockedevenLine, slot2)
		gohelper.setActive(slot0._goUnlockedoddLine, slot2)
		gohelper.setActive(slot0._goNormal1, slot2)
		gohelper.setActive(slot0._goNormal2, slot2)
		gohelper.setActive(slot0._goCompleted1, slot3)
		gohelper.setActive(slot0._goCompleted2, slot3)
		gohelper.setActive(slot0._goType1, not slot5)
		gohelper.setActive(slot0._goType2, slot5)
	else
		slot7 = false

		if not string.nilorempty(slot0._episode.progress) then
			if slot0._episode:getEndLessBattleProgress() and slot8 == LengZhou6Enum.BattleProgress.selectFinish or slot0._episode:getLevel() ~= 1 then
				slot7 = true
			end
		end

		if slot7 then
			slot0._txtLv.text = string.format("Lv.%s", slot0._episode:getLevel())
		else
			slot0._txtLv.text = ""
		end

		gohelper.setActive(slot0._btnreset.gameObject, slot7)
	end
end

function slot0.finishStateEnd(slot0)
	return slot0._aniName == "finish"
end

function slot0.updateInfo(slot0, slot1)
	if slot0._episode == nil or slot0._episodeId == nil then
		return
	end

	slot0:refreshState()
	gohelper.setActive(slot0.viewGO, slot0._episode:canShowItem())

	if slot1 then
		slot0:playAni(slot0._aniName)
	end
end

function slot0.playAni(slot0, slot1)
	if slot0.ani and slot1 then
		slot0.ani:Play(slot1, 0, 0)
	end
end

function slot0.onDestroyView(slot0)
	if slot0._clickLister ~= nil then
		slot0._clickLister:RemoveClickListener()

		slot0._clickLister = nil
	end
end

return slot0
