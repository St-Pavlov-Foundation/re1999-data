module("modules.logic.tower.view.assistboss.TowerAssistBossTalentPlanModifyView", package.seeall)

slot0 = class("TowerAssistBossTalentPlanModifyView", BaseView)

function slot0.onInitView(slot0)
	slot0._goBtnReset = gohelper.findChild(slot0.viewGO, "BOSS/layout/btn_reset")
	slot0._btnHideTalentPlan = gohelper.findChildClickWithAudio(slot0.viewGO, "#btn_hideTalentPlan")
	slot0._goTalentPlanSelect = gohelper.findChild(slot0.viewGO, "talentPlanSelect")
	slot0._btnShowTalentPlan = gohelper.findChildClickWithAudio(slot0.viewGO, "talentPlanSelect/#btn_showTalentPlan")
	slot0._txtTalentPlanName = gohelper.findChildTextMesh(slot0.viewGO, "talentPlanSelect/#btn_showTalentPlan/#txt_talentPlanName")
	slot0._goArrow = gohelper.findChild(slot0.viewGO, "talentPlanSelect/#btn_showTalentPlan/#go_arrow")
	slot0._btnChangeName = gohelper.findChildClickWithAudio(slot0.viewGO, "talentPlanSelect/#btn_changeName")
	slot0._goModifyIcon = gohelper.findChild(slot0.viewGO, "talentPlanSelect/#btn_changeName/#go_modifyIcon")
	slot0._goAutoIcon = gohelper.findChild(slot0.viewGO, "talentPlanSelect/#btn_changeName/#go_autoIcon")
	slot0._goTalentPlanContent = gohelper.findChild(slot0.viewGO, "talentPlanSelect/#go_talentPlanContent")
	slot0._goTalentPlanItem = gohelper.findChild(slot0.viewGO, "talentPlanSelect/#go_talentPlanContent/#go_talentPlanItem")
	slot0._goTalentPlanTip = gohelper.findChild(slot0.viewGO, "talentPlanSelect/#go_talentPlanTip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnShowTalentPlan:AddClickListener(slot0._onBtnShowTalentPlan, slot0)
	slot0._btnHideTalentPlan:AddClickListener(slot0._onBtnHideTalentPlan, slot0)
	slot0._btnChangeName:AddClickListener(slot0._onBtnChangeName, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ChangeTalentPlan, slot0.changeTalentPlan, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.RenameTalentPlan, slot0.RenameTalentPlan, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnShowTalentPlan:RemoveClickListener()
	slot0._btnHideTalentPlan:RemoveClickListener()
	slot0._btnChangeName:RemoveClickListener()
	slot0:removeEventCb(TowerController.instance, TowerEvent.ChangeTalentPlan, slot0.changeTalentPlan, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.RenameTalentPlan, slot0.RenameTalentPlan, slot0)
end

function slot0._onBtnChangeName(slot0)
	if slot0.curSelectTalentPlanData.isAutoPlan == 1 then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossTalentModifyNameView, {
		bossId = slot0.bossId
	})
end

function slot0._onBtnShowTalentPlan(slot0)
	if not slot0.isShowTalentPlane then
		slot0:showTalentPlane()
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_activity_dog_page)
	else
		slot0:hideTalentPlane()
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_wenming_cut)
	end
end

function slot0._onBtnHideTalentPlan(slot0)
	slot0:hideTalentPlane()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_wenming_cut)
end

function slot0.showTalentPlane(slot0)
	gohelper.setActive(slot0._goTalentPlanContent, true)
	gohelper.setActive(slot0._btnHideTalentPlan.gameObject, true)
	transformhelper.setLocalScale(slot0._goArrow.transform, 1, -1, 1)

	slot0.isShowTalentPlane = true
end

function slot0.hideTalentPlane(slot0)
	gohelper.setActive(slot0._goTalentPlanContent, false)
	gohelper.setActive(slot0._btnHideTalentPlan.gameObject, false)
	transformhelper.setLocalScale(slot0._goArrow.transform, 1, 1, 1)

	slot0.isShowTalentPlane = false
end

function slot0._editableInitView(slot0)
	slot0.talentPlanItemList = slot0:getUserDataTb_()
	slot0.curSelectTalentPlanData = nil

	gohelper.setActive(slot0._goTalentPlanItem, false)
	slot0:hideTalentPlane()

	slot0.isShowTalentPlane = false
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:initData()
	slot0:initTalentPlan()
	slot0:createOrRefreshTalentPlanItem()
	slot0:initCurSelectItem()
	slot0:_onBtnHideTalentPlan()
end

function slot0.initData(slot0)
	slot0.bossId = slot0.viewParam.bossId
	slot0.bossMo = TowerAssistBossModel.instance:getBoss(slot0.bossId)
	slot0.bossLevel = slot0.bossMo.level
	slot0.talentTree = slot0.bossMo:getTalentTree()
end

function slot0.initTalentPlan(slot0)
	slot0.talentPlanDataMap = slot0:getUserDataTb_()
	slot0.talentPlanDataList = slot0:getUserDataTb_()
	slot0.isTeach = TowerModel.instance:getCurTowerType() and slot1 == TowerEnum.TowerType.Boss and slot0.bossMo.trialLevel > 0
	slot0.isTempBoss = slot1 and slot1 == TowerEnum.TowerType.Boss and slot0.bossMo:getTempState()
	slot0.isLimitedTrial = slot1 and slot1 == TowerEnum.TowerType.Limited and slot0.bossMo.trialLevel > 0 and slot0.bossMo.level < tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

	gohelper.setActive(slot0._goTalentPlanSelect, true)

	if slot0.isTeach then
		slot0:addAutoTalentPlan({
			TowerConfig.instance:getTalentPlanConfig(slot0.bossId, slot0.bossMo.trialTalentPlan)
		})
	elseif slot0.isLimitedTrial then
		slot0:addAutoTalentPlan()
	elseif slot0.isTempBoss then
		gohelper.setActive(slot0._goTalentPlanSelect, false)
	else
		slot0:addAutoTalentPlan()
		slot0:addCustomTalentPlan()
	end

	table.sort(slot0.talentPlanDataList, function (slot0, slot1)
		if slot0.isAutoPlan ~= slot1.isAutoPlan then
			return slot1.isAutoPlan < slot0.isAutoPlan
		end

		return slot0.planId < slot1.planId
	end)
end

function slot0.addAutoTalentPlan(slot0, slot1)
	for slot6, slot7 in ipairs(slot1 or TowerConfig.instance:getAllTalentPlanConfig(slot0.bossId)) do
		slot8 = {
			planId = slot7.planId
		}
		slot8.talentIds = TowerConfig.instance:getTalentPlanNodeIds(slot0.bossId, slot8.planId, slot0.bossLevel)
		slot8.planName = slot7.planName
		slot8.isAutoPlan = 1
		slot0.talentPlanDataMap[slot8.planId] = slot8

		table.insert(slot0.talentPlanDataList, slot8)
	end
end

function slot0.addCustomTalentPlan(slot0)
	for slot5, slot6 in pairs(slot0.bossMo:getTalentPlanInfos()) do
		slot7 = {
			planId = slot6.planId,
			talentIds = slot6.talentIds,
			planName = slot6.planName,
			isAutoPlan = 0
		}
		slot0.talentPlanDataMap[slot7.planId] = slot7

		table.insert(slot0.talentPlanDataList, slot7)
	end
end

function slot0.createOrRefreshTalentPlanItem(slot0)
	for slot4 = 1, #slot0.talentPlanDataList do
		if not slot0.talentPlanItemList[slot4] then
			slot5 = {
				data = slot0.talentPlanDataList[slot4],
				go = gohelper.cloneInPlace(slot0._goTalentPlanItem)
			}
			slot5.goSelect = gohelper.findChild(slot5.go, "go_select")
			slot5.goAutoTypeIcon = gohelper.findChild(slot5.go, "txt_planName/go_autoTypeIcon")
			slot5.txtPlanName = gohelper.findChildTextMesh(slot5.go, "txt_planName")
			slot5.btnClick = gohelper.findChildClickWithAudio(slot5.go, "btn_click")

			slot5.btnClick:AddClickListener(slot0.onTalentPlanItemClick, slot0, slot5)

			slot0.talentPlanItemList[slot4] = slot5
		end

		gohelper.setActive(slot5.go, true)

		slot6 = slot5.data.isAutoPlan == 1

		SLFramework.UGUI.GuiHelper.SetColor(slot5.txtPlanName, slot6 and "#EFB785" or "#C3BEB6")

		slot5.txtPlanName.text = slot5.data.planName

		gohelper.setActive(slot5.goAutoTypeIcon, slot6)
	end
end

function slot0.initCurSelectItem(slot0)
	if slot0.isTempBoss then
		gohelper.setActive(slot0._goBtnReset, false)

		if not slot0.isTeach then
			return
		end
	end

	slot1 = 0

	for slot5, slot6 in pairs(slot0.talentPlanDataList) do
		if slot6.planId == ((not slot0.isTeach or slot0.bossMo.trialTalentPlan) and (not slot0.isLimitedTrial or TowerAssistBossModel.instance:getLimitedTrialBossLocalPlan(slot0.bossMo)) and slot0.bossMo:getCurUseTalentPlan()) then
			slot0.curSelectTalentPlanData = slot6

			break
		end
	end

	if not slot0.curSelectTalentPlanData then
		logError("当前保存的天赋id不存在： " .. slot1)

		slot0.curSelectTalentPlanData = slot0.talentPlanDataList[1]
	end

	slot0:refreshPlanUI(slot0.curSelectTalentPlanData)
end

function slot0.onTalentPlanItemClick(slot0, slot1)
	if slot0.curSelectTalentPlanData and slot0.curSelectTalentPlanData.planId == slot1.data.planId then
		slot0:_onBtnHideTalentPlan()

		return
	end

	slot0.curSelectTalentPlanData = slot1.data

	if slot0.isLimitedTrial then
		TowerController.instance:setPlayerPrefs(TowerAssistBossModel.instance:getLimitedTrialBossSaveKey(slot0.bossMo), slot0.curSelectTalentPlanData.planId)
		slot0:changeTalentPlan({
			planId = slot0.curSelectTalentPlanData.planId
		})
	elseif not slot0.isTeach then
		if not slot0.isTempBoss then
			TowerRpc.instance:sendTowerChangeTalentPlanRequest(slot0.bossId, slot1.data.planId)
		end
	end

	slot0:_onBtnHideTalentPlan()
end

function slot0.changeTalentPlan(slot0, slot1)
	slot0.curSelectTalentPlanData = slot0.talentPlanDataMap[slot1.planId]

	slot0:refreshPlanUI(slot0.curSelectTalentPlanData)
	slot0.bossMo:setCurUseTalentPlan(slot0.curSelectTalentPlanData.planId, slot0.isLimitedTrial)
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTalent)
	GameFacade.showToast(ToastEnum.TowerBossTalentPlanChange)
end

function slot0.refreshPlanUI(slot0, slot1)
	slot0.curSelectTalentPlanData = slot1

	for slot5, slot6 in pairs(slot0.talentPlanItemList) do
		gohelper.setActive(slot6.goSelect, slot6.data.planId == slot1.planId)

		if slot6.data.isAutoPlan == 1 then
			SLFramework.UGUI.GuiHelper.SetColor(slot6.txtPlanName, "#EFB785")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot6.txtPlanName, slot8 and "#EAF8FF" or "#C3BEB6")
		end
	end

	slot2 = slot0.curSelectTalentPlanData.isAutoPlan == 1
	slot0._txtTalentPlanName.text = slot0.curSelectTalentPlanData.planName

	gohelper.setActive(slot0._goModifyIcon, not slot2)
	gohelper.setActive(slot0._goAutoIcon, slot2)
	gohelper.setActive(slot0._goTalentPlanTip, slot2)
	gohelper.setActive(slot0._goBtnReset, not slot2)
	TowerAssistBossTalentListModel.instance:setAutoTalentState(slot2)
end

function slot0.saveLimitedTalent(slot0)
	TowerController.instance:setPlayerPrefs(slot0:getLimitedTrialBossSaveKey(slot0.bossMO), slot0.curSelectTalentPlanData.planId)
end

function slot0.RenameTalentPlan(slot0, slot1)
	slot0.curSelectTalentPlanData.planName = slot1

	for slot5, slot6 in pairs(slot0.talentPlanItemList) do
		if slot6.data.planId == slot0.curSelectTalentPlanData.planId then
			slot6.txtPlanName.text = slot1

			break
		end
	end

	slot0._txtTalentPlanName.text = slot1
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0.talentPlanItemList) do
		slot5.btnClick:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
