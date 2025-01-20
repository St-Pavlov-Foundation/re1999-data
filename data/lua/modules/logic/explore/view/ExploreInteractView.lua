module("modules.logic.explore.view.ExploreInteractView", package.seeall)

slot0 = class("ExploreInteractView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnfullscreen = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fullscreen")
	slot0._gochoicelist = gohelper.findChild(slot0.viewGO, "#go_choicelist")
	slot0._gochoiceitem = gohelper.findChild(slot0.viewGO, "#go_choicelist/#go_choiceitem")
	slot0._txttalkinfo = gohelper.findChildText(slot0.viewGO, "go_normalcontent/txt_contentcn")
	slot0._txttalker = gohelper.findChildText(slot0.viewGO, "#txt_talker")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	NavigateMgr.instance:addSpace(ViewName.ExploreInteractView, slot0.onClickFull, slot0)
	slot0._btnfullscreen:AddClickListener(slot0.onClickFull, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, slot0.OnStoryDialogSelect, slot0)
end

function slot0.removeEvents(slot0)
	NavigateMgr.instance:removeSpace(ViewName.ExploreInteractView)
	slot0._btnfullscreen:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, slot0.OnStoryDialogSelect, slot0)
end

function slot0.onClickFull(slot0)
	if slot0._hasIconDialogItem and slot0._hasIconDialogItem:isPlaying() then
		slot0._hasIconDialogItem:conFinished()

		return
	end

	if not slot0._btnDatas[1] then
		slot0._curStep = slot0._curStep + 1

		if slot0.config[slot0._curStep] then
			slot0:onStep()
		else
			if slot0.viewParam.callBack then
				slot0.viewParam.callBack(slot0.viewParam.callBackObj)
			end

			slot0:closeThis()
		end
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)

	slot0.config = ExploreConfig.instance:getDialogueConfig(slot0.viewParam.id)

	if not slot0.config then
		logError("对话配置不存在，id：" .. tostring(slot0.viewParam.id))
		slot0:closeThis()

		return
	end

	slot0._curStep = 1

	slot0:onStep()
end

function slot0.onStep(slot0)
	if not slot0.config[slot0._curStep] or slot1.interrupt == 1 then
		if slot0.viewParam.callBack then
			slot0.viewParam.callBack(slot0.viewParam.callBackObj)
		end

		slot0:closeThis()

		return
	end

	slot2 = string.gsub(slot1.desc, " ", " ")

	if not slot0._hasIconDialogItem then
		slot0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(slot0.viewGO, TMPFadeIn)
	end

	slot0._hasIconDialogItem:playNormalText(slot2)

	if slot1.audio and slot1.audio > 0 then
		GuideAudioMgr.instance:playAudio(slot1.audio)
	else
		GuideAudioMgr.instance:stopAudio()
	end

	slot0._txttalker.text = slot1.speaker

	if not string.nilorempty(slot1.acceptButton) then
		table.insert({}, {
			accept = true,
			text = slot1.acceptButton
		})
	end

	if not string.nilorempty(slot1.refuseButton) then
		table.insert(slot3, {
			accept = false,
			text = slot1.refuseButton
		})
	end

	if not string.nilorempty(slot1.selectButton) then
		for slot8, slot9 in ipairs(GameUtil.splitString2(slot1.selectButton)) do
			table.insert(slot3, {
				jumpStep = tonumber(slot9[2]),
				text = slot9[1]
			})
		end
	end

	gohelper.CreateObjList(slot0, slot0._createItem, slot3, slot0._gochoicelist, slot0._gochoiceitem)

	slot0._btnDatas = slot3
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "info").text = slot2.text
	slot5 = gohelper.findChildButtonWithAudio(slot1, "click")

	slot0:removeClickCb(slot5)
	slot0:addClickCb(slot5, slot0.onBtnClick, slot0, slot2)

	if gohelper.findChild(slot1, "#go_pcbtn") then
		PCInputController.instance:showkeyTips(slot6, nil, , slot3)
	end
end

function slot0.OnStoryDialogSelect(slot0, slot1)
	if slot1 <= #slot0._btnDatas and slot1 > 0 then
		slot0:onBtnClick(slot0._btnDatas[slot1])
	end
end

function slot0.onBtnClick(slot0, slot1)
	if slot1.jumpStep then
		slot0._curStep = slot1.jumpStep

		slot0:onStep()
	else
		if slot1.accept then
			if slot0.viewParam.callBack then
				slot0.viewParam.callBack(slot0.viewParam.callBackObj)
			end
		elseif slot0.viewParam.refuseCallBack then
			slot0.viewParam.refuseCallBack(slot0.viewParam.refuseCallBackObj)
		end

		slot0:closeThis()
	end
end

function slot0.onClose(slot0)
	GuideAudioMgr.instance:stopAudio()
end

return slot0
