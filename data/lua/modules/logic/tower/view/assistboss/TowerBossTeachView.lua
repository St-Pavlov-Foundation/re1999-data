module("modules.logic.tower.view.assistboss.TowerBossTeachView", package.seeall)

slot0 = class("TowerBossTeachView", BaseView)

function slot0.onInitView(slot0)
	slot0._btncloseFullView = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeFullView")
	slot0._txttitleName = gohelper.findChildText(slot0.viewGO, "title/#txt_titleName")
	slot0._simagebossIcon = gohelper.findChildSingleImage(slot0.viewGO, "boss/#simage_bossIcon")
	slot0._simagebossShadow = gohelper.findChildSingleImage(slot0.viewGO, "boss/#simage_shadow")
	slot0._txtbossDesc = gohelper.findChildText(slot0.viewGO, "info/scroll_bossDesc/Viewport/Content/#txt_bossDesc")
	slot0._btnskillTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "info/#btn_skillTips")
	slot0._goskillTip = gohelper.findChild(slot0.viewGO, "#go_skillTip")
	slot0._scrollepisode = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_episode")
	slot0._goepisodeContent = gohelper.findChild(slot0.viewGO, "#scroll_episode/Viewport/#go_episodeContent")
	slot0._goepisodeItem = gohelper.findChild(slot0.viewGO, "#scroll_episode/Viewport/#go_episodeContent/#go_episodeItem")
	slot0._goepisodeSelect = gohelper.findChild(slot0.viewGO, "#go_episodeSelect")
	slot0._txtepisodeDesc = gohelper.findChildText(slot0.viewGO, "#go_episodeSelect/scroll_episodeDesc/Viewport/Content/#txt_episodeDesc")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_episodeSelect/#btn_start")
	slot0._txtstart = gohelper.findChildText(slot0.viewGO, "#go_episodeSelect/#btn_start/txt")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseFullView:AddClickListener(slot0._btncloseFullViewOnClick, slot0)
	slot0._btnskillTips:AddClickListener(slot0._btnskillTipsOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseFullView:RemoveClickListener()
	slot0._btnskillTips:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseFullViewOnClick(slot0)
	slot0:_btncloseOnClick()
end

function slot0._btnskillTipsOnClick(slot0)
	if not slot0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSkillTipsView, {
		bossId = slot0.bossId
	})
end

function slot0._btnstartOnClick(slot0)
	if not TowerConfig.instance:getBossTeachConfig(slot0.towerId, slot0.selectTeachId) then
		return
	end

	TowerController.instance:enterFight({
		towerType = slot0.towerType,
		towerId = slot0.towerId,
		layerId = 0,
		episodeId = slot1.episodeId,
		difficulty = slot1.teachId
	})
	TowerBossTeachModel.instance:setLastFightTeachId(slot1.teachId)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onEpisodeItemClick(slot0, slot1)
	if slot0.selectTeachId == slot1.config.teachId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_main_switch_scene_2_2)

	slot0.selectTeachId = slot1.config.teachId

	slot0:refreshSelectUI()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goepisodeItem, false)
	NavigateMgr.instance:addEscape(ViewName.TowerBossTeachView, slot0.closeThis, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play__ui_main_fit_scane_2_2)
	slot0:initData()
	slot0:refreshUI()
end

function slot0.initData(slot0)
	slot0.towerType = slot0.viewParam.towerType
	slot0.towerId = slot0.viewParam.towerId
	slot0.towerConfig = TowerConfig.instance:getBossTowerConfig(slot0.towerId)
	slot0.bossConfig = TowerConfig.instance:getAssistBossConfig(slot0.towerConfig.bossId)
	slot0.bossId = slot0.towerConfig.bossId
	slot0.skinConfig = FightConfig.instance:getSkinCO(slot0.bossConfig.skinId)
	slot0.towerInfo = TowerModel.instance:getTowerInfoById(slot0.towerType, slot0.towerId)
	slot0.lastFightTeachId = slot0.viewParam.lastFightTeachId or 0
	slot0.episodeItemMap = slot0:getUserDataTb_()
	slot0.allTeachConfigList = TowerConfig.instance:getAllBossTeachConfigList(slot0.towerId)
end

function slot0.refreshUI(slot0)
	slot0._simagebossIcon:LoadImage(slot0.bossConfig.bossPic)
	slot0._simagebossShadow:LoadImage(slot0.bossConfig.bossShadowPic)

	slot0._txttitleName.text = slot0.towerConfig.name
	slot0._txtbossDesc.text = slot0.bossConfig.bossDesc

	slot0:createAndRefreshEpisodeItem()
	slot0:refreshSelectUI()
end

function slot0.createAndRefreshEpisodeItem(slot0)
	for slot4, slot5 in ipairs(slot0.allTeachConfigList) do
		if not slot0.episodeItemMap[slot5.teachId] then
			slot6 = {
				config = slot5,
				isFinish = false,
				go = gohelper.cloneInPlace(slot0._goepisodeItem)
			}
			slot6.simageBoss = gohelper.findChildSingleImage(slot6.go, "boss/image_boss")
			slot6.goSelect = gohelper.findChild(slot6.go, "go_select")
			slot6.txtEpisodeName = gohelper.findChildText(slot6.go, "name/txt_episodeName")
			slot6.goFinishIcon = gohelper.findChild(slot6.go, "name/txt_episodeName/go_finishIcon")
			slot6.btnClick = gohelper.findChildClickWithAudio(slot6.go, "btn_click")

			slot6.btnClick:AddClickListener(slot0.onEpisodeItemClick, slot0, slot6)

			slot0.episodeItemMap[slot5.teachId] = slot6
		end

		gohelper.setActive(slot6.go, true)
		slot6.simageBoss:LoadImage(ResUrl.monsterHeadIcon(slot0.skinConfig and slot0.skinConfig.headIcon))

		slot6.txtEpisodeName.text = slot5.name
		slot6.isFinish = slot0.towerInfo:isPassBossTeach(slot5.teachId)

		gohelper.setActive(slot6.goFinishIcon, slot6.isFinish)
	end

	if not slot0.selectTeachId then
		slot0.selectTeachId = slot0.lastFightTeachId > 0 and slot0.lastFightTeachId or TowerBossTeachModel.instance:getFirstUnFinishTeachId(slot0.bossId)
	end
end

function slot0.refreshSelectUI(slot0)
	for slot4, slot5 in pairs(slot0.episodeItemMap) do
		gohelper.setActive(slot5.goSelect, slot5.config.teachId == slot0.selectTeachId)

		slot6 = slot5.config.teachId == slot0.selectTeachId and 1 or 0.9

		transformhelper.setLocalScale(slot5.go.transform, slot6, slot6, slot6)
	end

	gohelper.setActive(slot0._goepisodeSelect, true)

	slot0._txtepisodeDesc.text = TowerConfig.instance:getBossTeachConfig(slot0.towerId, slot0.selectTeachId) and slot1.desc or ""
	slot0._txtstart.text = slot0.episodeItemMap[slot0.selectTeachId].isFinish and luaLang("towerbossteachpass") or luaLang("towerbossteachstart")
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0.episodeItemMap) do
		slot5.btnClick:RemoveClickListener()
		slot5.simageBoss:UnLoadImage()
	end

	slot0._simagebossIcon:UnLoadImage()
	slot0._simagebossShadow:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
