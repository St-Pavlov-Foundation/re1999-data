module("modules.logic.tower.view.bosstower.TowerBossSelectView", package.seeall)

slot0 = class("TowerBossSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnbossHandbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "bossHandbook/#btn_bossHandbook")
	slot0.bossContainer = gohelper.findChild(slot0.viewGO, "root/bosscontainer")
	slot0._gohandBookNewEffect = gohelper.findChild(slot0.viewGO, "bossHandbook/#saoguang")
	slot0._scrollBoss = gohelper.findChildScrollRect(slot0.viewGO, "root/#scroll_boss")
	slot0._gobossContent = gohelper.findChild(slot0.viewGO, "root/#scroll_boss/Viewport/#go_bossContent")
	slot0._gobossItem = gohelper.findChild(slot0.viewGO, "root/#scroll_boss/Viewport/#go_bossContent/#go_bossItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbossHandbook:AddClickListener(slot0._btnbossHandbookOnClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.onTowerTaskUpdated, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, slot0.onTowerUpdate, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbossHandbook:RemoveClickListener()
	slot0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.onTowerTaskUpdated, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerUpdate, slot0.onTowerUpdate, slot0)
end

function slot0._btnbossHandbookOnClick(slot0)
	TowerController.instance:openAssistBossView()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gohandBookNewEffect, false)
	gohelper.setActive(slot0._gobossItem, false)

	slot0.itemList = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Boss)
	slot0:refreshView()
	TaskDispatcher.runDelay(slot0.checkShowEffect, slot0, 0.6)
end

function slot0.onTowerTaskUpdated(slot0)
	slot0:refreshTask()
end

function slot0.onTowerUpdate(slot0)
	slot0:refreshView()
end

function slot0.onLocalKeyChange(slot0)
	if slot0.itemList then
		for slot4, slot5 in ipairs(slot0.itemList) do
			slot5.item:refreshTag()
		end
	end
end

function slot0.refreshView(slot0)
	slot0:refreshBossList()
	slot0:refreshTime()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._gobossHandbook, tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossHandbookOpen)) <= TowerPermanentModel.instance:getCurPermanentPassLayer())
end

function slot0.refreshBossList(slot0)
	slot0.bossOpenMOList = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	if #slot0.bossOpenMOList > 1 then
		table.sort(slot0.bossOpenMOList, TowerAssistBossModel.sortBossList)
	end

	slot0:initBossList()

	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5.item:updateItem(slot0.bossOpenMOList and slot0.bossOpenMOList[slot4])
	end
end

function slot0.initBossList(slot0)
	for slot4 = 1, #slot0.bossOpenMOList do
		if not slot0.itemList[slot4] then
			slot5 = {
				go = gohelper.clone(slot0._gobossItem, slot0._gobossContent)
			}
			slot5.item = slot0:createItem(slot4, slot5.go)
			slot0.itemList[slot4] = slot5
		end

		gohelper.setActive(slot5.go, true)

		slot5.go.name = "boss" .. slot0.bossOpenMOList[slot4].id
	end

	for slot4 = #slot0.bossOpenMOList + 1, #slot0.itemList do
		gohelper.setActive(slot0.itemList[slot4].go, false)
	end

	slot0._scrollBoss.horizontalNormalizedPosition = 0
end

function slot0.createItem(slot0, slot1, slot2)
	recthelper.setAnchorY(slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.itemRes, slot2).transform, slot1 % 2 == 0 and -70 or 0)

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot4, TowerBossSelectItem)
end

function slot0.refreshTime(slot0)
	slot2, slot3 = nil

	for slot7, slot8 in pairs(TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)) do
		if slot8.status == TowerEnum.TowerStatus.Open and (slot2 == nil or slot8.nextTime < slot2) then
			slot3 = slot8.towerId
			slot2 = slot8.nextTime
		end
	end

	for slot7, slot8 in ipairs(slot0.itemList) do
		slot8.item:refreshTime(slot3)
	end
end

function slot0.refreshTask(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5.item:refreshTask()
	end
end

function slot0.checkShowEffect(slot0)
	gohelper.setActive(slot0._gohandBookNewEffect, TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.TowerBossSelectHandBookEffect, 0) == 0)
end

function slot0.onClose(slot0)
	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.TowerBossSelectHandBookEffect, 1)
	TaskDispatcher.cancelTask(slot0.checkShowEffect, slot0)
end

function slot0.onDestroyView(slot0)
	TowerModel.instance:cleanTrialData()
end

return slot0
