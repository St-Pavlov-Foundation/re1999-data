module("modules.logic.turnback.view.new.view.TurnbackReviewView", package.seeall)

slot0 = class("TurnbackReviewView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollTabList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TabList")
	slot0._gotabitem = gohelper.findChild(slot0.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem")
	slot0._trstabitemContent = gohelper.findChild(slot0.viewGO, "#scroll_TabList/Viewport/Content").transform
	slot0._txtunlocktab = gohelper.findChildText(slot0.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem/Unlock/#txt_unlocktab")
	slot0._txtlockedtab = gohelper.findChildText(slot0.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem/Locked/#txt_lockedtab")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem/#go_reddot")
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._simagecgold = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#simage_cgold")
	slot0._simagezoneold = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#simage_cgold/masknode/#simage_zoneold")
	slot0._gomasknodeold = gohelper.findChild(slot0.viewGO, "#go_ui/#simage_cgold/masknode")
	slot0._simagecg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#simage_cg")
	slot0._simagezone = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#simage_cg/masknode/#simage_zone")
	slot0._gomasknode = gohelper.findChild(slot0.viewGO, "#go_ui/#simage_cg/masknode")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "#go_ui/#btn_click/#go_drag")
	slot0._btnprev = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#btn_prev")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#btn_next")
	slot0._txtchapter = gohelper.findChildText(slot0.viewGO, "#go_ui/desc/#txt_chapter")
	slot0._txttitleName = gohelper.findChildText(slot0.viewGO, "#go_ui/desc/#txt_titleName")
	slot0._txttitleNameEn = gohelper.findChildText(slot0.viewGO, "#go_ui/desc/#txt_titleNameEn")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_ui/desc/#txt_desc")
	slot0._btnpage = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/page/btn")
	slot0._txtcurindex = gohelper.findChildText(slot0.viewGO, "#go_ui/page/#txt_curindex")
	slot0._txttotalpage = gohelper.findChildText(slot0.viewGO, "#go_ui/page/#txt_curindex/#txt_totalpage")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#btn_goto")
	slot0._txtcurchapter = gohelper.findChildText(slot0.viewGO, "#go_ui/#btn_goto/#txt_curchapter")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_ui/#go_btns")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._cgType = HandbookEnum.CGType.Dungeon
	slot0._topItemList = {}
	slot0._selectChapter = 1
	slot0.centerBannerPosX = 0

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

slot0.bannerWidth = 1420
slot0.moveDistance = 100
slot0.LayoutSpace = 100

function slot0.addEvents(slot0)
	slot0._btnprev:AddClickListener(slot0._btnprevOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0._btnpage:AddClickListener(slot0._btnpageOnClick, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0.onDungeonUpdate, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnprev:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btngoto:RemoveClickListener()
	slot0._btnpage:RemoveClickListener()
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0.onDungeonUpdate, slot0)
end

function slot0._btnpageOnClick(slot0)
	if not string.nilorempty(slot0._lastEpisodeId) then
		JumpController.instance:jumpTo("17#3#" .. slot0._selectChapter)
	end
end

function slot0._btngotoOnClick(slot0)
	if not string.nilorempty(slot0._jumpEpisodeId) then
		JumpController.instance:jumpTo(JumpEnum.JumpView.DungeonViewWithEpisode .. "#" .. slot0._jumpEpisodeId)
		TaskDispatcher.cancelTask(slot0.autoSwitch, slot0)
	end
end

function slot0._editableInitView(slot0)
	slot0._cimagecg = slot0._simagecg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	slot0._imageZone = gohelper.findChildImage(slot0.viewGO, "#go_ui/#simage_cg/masknode/#simage_zone")
	slot0._cimagecgold = slot0._simagecgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	slot0._imageZoneOld = gohelper.findChildImage(slot0.viewGO, "#go_ui/#simage_cgold/masknode/#simage_zoneold")

	gohelper.setActive(slot0._simagecg.gameObject, false)
	gohelper.setActive(slot0._simagecgold.gameObject, false)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godrag)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	gohelper.addUIClickAudio(slot0._btnprev.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)
	gohelper.addUIClickAudio(slot0._btnnext.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	slot0.loadedCgList = {}
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._startPos = slot2.position.x
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot0._startPos < slot2.position.x and slot3 - slot0._startPos >= 100 then
		slot0:_btnprevOnClick(true)
	elseif slot3 < slot0._startPos and slot0._startPos - slot3 >= 100 then
		slot0:_btnnextOnClick(true)
	end
end

function slot0._focusItem(slot0)
	if #slot0._topItemList * 428 - recthelper.getWidth(slot0._scrollTabList.transform) < 0 then
		return
	end

	if slot5 >= (slot0._selectChapter - 1) * slot2 then
		ZProj.TweenHelper.DOAnchorPosX(slot0._trstabitemContent, -(slot0._selectChapter - 1) * slot2, 0.26)
	else
		ZProj.TweenHelper.DOAnchorPosX(slot0._trstabitemContent, -slot5, 0.26)
	end
end

function slot0._btnprevOnClick(slot0, slot1)
	slot2, slot3 = slot0:getFirstCGIdAndEpisodeId(slot0._selectChapter)

	if slot2 == slot0._cgId then
		if slot0._selectChapter ~= slot0._unlockChapterList[1] then
			slot0._selectChapter = slot0._selectChapter - 1

			if slot0._selectChapter == 7 then
				slot0._selectChapter = slot0._selectChapter - 1
			end
		else
			slot0._selectChapter = slot0._unlockChapterList[#slot0._unlockChapterList]
		end

		slot0:_focusItem()
	end

	if not HandbookModel.instance:getPrevCG(slot0._cgId, slot0._cgType) then
		return
	end

	slot0._cgId = slot4.id
	slot0._episodeId = slot4.episodeId
	slot0._cimagecg.enabled = false
	slot0._cimagecgold.enabled = false

	gohelper.setActive(slot0._gomasknode, false)
	gohelper.setActive(slot0._gomasknodeold, false)
	slot0:_refreshTop()

	if slot1 then
		slot0._animator:Play("switch_right", 0, 0)
	else
		slot0._animator:Play("switch_left", 0, 0)
	end

	TaskDispatcher.runDelay(slot0._afterPlayAnim, slot0, 0.16)
end

function slot0._afterPlayAnim(slot0)
	TaskDispatcher.cancelTask(slot0.autoSwitch, slot0)
	TaskDispatcher.cancelTask(slot0._afterPlayAnim, slot0)

	slot0._cimagecg.enabled = true
	slot0._cimagecgold.enabled = true

	gohelper.setActive(slot0._gomasknode, true)
	gohelper.setActive(slot0._gomasknodeold, true)
	slot0:_refreshUI()
	slot0:autoMoveBanner()
end

function slot0._btnnextOnClick(slot0, slot1)
	slot2 = HandbookConfig.instance:getCGDictByChapter(slot0._selectChapter)
	slot4 = false

	if slot0._selectChapter ~= slot0._unlockChapterList[#slot0._unlockChapterList] then
		if slot2[#slot2].id == slot0._cgId then
			slot0._selectChapter = slot0._selectChapter + 1

			if slot0._selectChapter == 7 then
				slot0._selectChapter = slot0._selectChapter + 1
			end

			slot0:_focusItem()
		end
	elseif HandbookModel.instance:getCGUnlockCount(slot0._selectChapter, slot0._cgType) == HandbookModel.instance:getCGUnlockIndexInChapter(slot0._selectChapter, slot0._cgId, slot0._cgType) then
		slot4 = true
		slot0._selectChapter = 1
		slot0._cgId = HandbookConfig.instance:getCGDictByChapter(slot0._selectChapter)[1].id

		slot0:_focusItem()
	end

	slot5 = HandbookModel.instance:getNextCG(slot0._cgId, slot0._cgType)

	if slot4 then
		slot5 = HandbookConfig.instance:getCGConfig(slot0._cgId)
	end

	if not slot5 then
		return
	end

	slot0._cgId = slot5.id
	slot0._episodeId = slot5.episodeId
	slot0._cimagecg.enabled = false
	slot0._cimagecgold.enabled = false

	gohelper.setActive(slot0._gomasknode, false)
	gohelper.setActive(slot0._gomasknodeold, false)
	slot0:_refreshTop()

	if slot1 then
		slot0._animator:Play("switch_left", 0, 0)
	else
		slot0._animator:Play("switch_right", 0, 0)
	end

	TaskDispatcher.runDelay(slot0._afterPlayAnim, slot0, 0.16)
end

function slot0._initTop(slot0)
	slot0._chapterList = {}
	slot0._cgConfigList = HandbookConfig.instance:getDungeonCGList()
	slot0._unlockChapterList = {}
	slot0._dungeonChapterList = {}
	slot0._dungeonChapterDict = HandbookConfig.instance:getCGDict()

	for slot4, slot5 in ipairs(slot0._cgConfigList) do
		if HandbookModel.instance:isCGUnlock(slot5.id) and not tabletool.indexOf(slot0._unlockChapterList, slot5.storyChapterId) then
			table.insert(slot0._unlockChapterList, slot6)

			if #slot0._unlockChapterList == tabletool.len(slot0._dungeonChapterDict) then
				break
			end
		end
	end

	for slot4, slot5 in pairs(slot0._unlockChapterList) do
		table.insert(slot0._dungeonChapterList, HandbookConfig.instance:getStoryChapterConfig(slot5))
	end

	slot0._selectChapter = slot0._unlockChapterList[#slot0._unlockChapterList]
	slot0._cgId, slot0._episodeId = slot0:getFirstCGIdAndEpisodeId(slot0._selectChapter)

	for slot4, slot5 in ipairs(slot0._dungeonChapterList) do
		if not slot0._topItemList[slot4] then
			slot6 = slot0:getUserDataTb_()
			slot6.go = gohelper.cloneInPlace(slot0._gotabitem, "chapter" .. slot5.id)

			gohelper.setActive(slot6.go, true)

			slot6.config = slot5
			slot6.chapterId = slot5.id
			slot6.golock = gohelper.findChild(slot6.go, "Locked")
			slot6.txtlockname = gohelper.findChildText(slot6.go, "Locked/#txt_lockedtab")
			slot6.gounlock = gohelper.findChild(slot6.go, "Unlock")
			slot6.goselected = gohelper.findChild(slot6.go, "Unlock/image_Selected")
			slot6.gonormal = gohelper.findChild(slot6.go, "Unlock/image_Normal")
			slot6.txtunlockname = gohelper.findChildText(slot6.go, "Unlock/#txt_unlocktab")
			slot6.btn = gohelper.findChildButton(slot6.go, "btn_click")

			slot6.btn:AddClickListener(slot0._btnTopOnClick, slot0, slot6)
			table.insert(slot0._topItemList, slot6)
		end

		slot6.txtlockname.text = slot5.name
		slot6.txtunlockname.text = slot5.name
		slot6.unlock = slot0:checkDungeonUnlock(slot6.chapterId)

		gohelper.setActive(slot6.gounlock, slot6.unlock)
		gohelper.setActive(slot6.golock, not slot6.unlock)

		slot7 = slot6.chapterId == slot0._selectChapter

		gohelper.setActive(slot6.goselected, slot7)
		gohelper.setActive(slot6.gonormal, not slot7)
	end
end

function slot0._btnTopOnClick(slot0, slot1)
	if not slot1.unlock then
		return
	end

	slot2 = slot1.chapterId
	slot0._selectChapter = slot2
	slot0._cgId, slot0._episodeId = slot0:getFirstCGIdAndEpisodeId(slot2)

	slot0:_refreshTop()
	slot0:_refreshUI()
	slot0:_focusItem()
	slot0:autoMoveBanner()
end

function slot0.getEpisodeName(slot0, slot1)
	if not slot2 or not (DungeonConfig.instance:getEpisodeCO(slot1) and DungeonConfig.instance:getChapterCO(slot2.chapterId)) then
		return nil
	end

	if string.nilorempty(slot2.name) then
		for slot9, slot10 in pairs(DungeonConfig.instance:getChainEpisodeDict()) do
			if slot9 == slot1 then
				slot3 = DungeonConfig.instance:getEpisodeCO(slot10) and DungeonConfig.instance:getChapterCO(slot2.chapterId)
			end
		end
	end

	slot5 = slot3.chapterIndex
	slot6, slot7 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot3.id, slot2.id)

	if not slot0._jumpEpisodeId then
		slot0._jumpEpisodeId = slot2.id
	else
		slot0._jumpEpisodeId = slot0._lastEpisodeId
	end

	return string.format("%s-%s %s", slot5, slot6, slot2.name)
end

function slot0.getFirstCGIdAndEpisodeId(slot0, slot1)
	slot2 = HandbookConfig.instance:getCGDictByChapter(slot1)

	return slot2[1].id, slot2[1].episodeId
end

function slot0.checkDungeonUnlock(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._unlockChapterList) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0._refreshTop(slot0)
	for slot4, slot5 in ipairs(slot0._topItemList) do
		slot6 = slot5.chapterId == slot0._selectChapter

		gohelper.setActive(slot5.goselected, slot6)
		gohelper.setActive(slot5.gonormal, not slot6)
	end
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:_initTop()
	slot0:_refreshUI()
	slot0:_initRightBtn()
	slot0:_focusItem()
	slot0:autoMoveBanner()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_paiqian_open)
end

function slot0._initRightBtn(slot0)
	slot0._jumpEpisodeId = nil
	slot0.playerInfo = PlayerModel.instance:getPlayinfo()
	slot0._lastEpisodeId = slot0.playerInfo.lastEpisodeId
	slot0._txtcurchapter.text = slot0:getEpisodeName(slot0._lastEpisodeId)
end

function slot0._refreshUI(slot0)
	UIBlockMgr.instance:startBlock("loadZone")

	if StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image) then
		slot0._simagezone:LoadImage(ResUrl.getStoryRes(slot2.path), slot0._onZoneImageLoaded, slot0)
	else
		gohelper.setActive(slot0._simagezone.gameObject, false)

		slot0._cimagecg.vecInSide = Vector4.zero

		slot0:_startLoadOriginImg()
	end

	slot0._txttitleName.text = slot1.name
	slot0._txttitleNameEn.text = slot1.nameEn
	slot0._txtdesc.text = slot1.desc
	slot0._txtcurindex.text = HandbookModel.instance:getCGUnlockIndexInChapter(slot0._selectChapter, slot0._cgId, slot0._cgType)
	slot0._txttotalpage.text = "/" .. HandbookModel.instance:getCGUnlockCount(slot0._selectChapter, slot0._cgType)
	slot0._txtchapter.text = slot0:getEpisodeName(slot0._episodeId)
end

function slot0._startLoadOriginImg(slot0)
	slot0._simagecg:LoadImage(slot0:getImageName(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType)), slot0.onLoadedImage, slot0)
end

function slot0._onZoneImageLoaded(slot0)
	slot0._imageZone:SetNativeSize()
	slot0:_startLoadOriginImg()
end

function slot0.getImageName(slot0, slot1)
	if not tabletool.indexOf(slot0.loadedCgList, slot1.id) then
		table.insert(slot0.loadedCgList, slot1.id)
	end

	slot0.lastLoadImageId = slot1.id

	if StoryBgZoneModel.instance:getBgZoneByPath(slot1.image) then
		return ResUrl.getStoryRes(slot2.sourcePath)
	end

	return ResUrl.getStoryBg(slot1.image)
end

function slot0.onLoadedImage(slot0)
	if StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image) then
		gohelper.setActive(slot0._simagezone.gameObject, true)
		transformhelper.setLocalPosXY(slot0._simagezone.gameObject.transform, slot2.offsetX, slot2.offsetY)

		slot4 = StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image)
		slot0._cimagecg.vecInSide = Vector4(recthelper.getWidth(slot0._imageZone.transform), recthelper.getHeight(slot0._imageZone.transform), slot4.offsetX, slot4.offsetY)

		slot0:_loadOldZoneImage()
	else
		gohelper.setActive(slot0._simagezoneold.gameObject, false)
		slot0:_startLoadOldImg()
	end

	gohelper.setActive(slot0._simagecg.gameObject, true)

	if #slot0.loadedCgList <= 10 then
		return
	end

	slot0.loadedCgList = {
		slot0.lastLoadImageId
	}

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)
end

function slot0._loadOldZoneImage(slot0)
	if StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image) then
		slot0._simagezoneold:LoadImage(ResUrl.getStoryRes(slot2.path), slot0._onZoneImageOldLoaded, slot0)
	else
		gohelper.setActive(slot0._simagezoneold.gameObject, false)

		slot0._cimagecgold.vecInSide = Vector4.zero

		slot0:_startLoadOldImg()
	end
end

function slot0._onZoneImageOldLoaded(slot0)
	slot0._imageZoneOld:SetNativeSize()
	slot0:_startLoadOldImg()
end

function slot0._startLoadOldImg(slot0)
	slot0._simagecgold:LoadImage(slot0:getImageName(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType)), slot0._onLoadOldFinished, slot0)
end

function slot0._onLoadOldFinished(slot0)
	UIBlockMgr.instance:endBlock("loadZone")

	if StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image) then
		gohelper.setActive(slot0._simagezoneold.gameObject, true)
		transformhelper.setLocalPosXY(slot0._simagezoneold.gameObject.transform, slot2.offsetX, slot2.offsetY)

		slot4 = StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image)
		slot0._cimagecgold.vecInSide = Vector4(recthelper.getWidth(slot0._imageZoneOld.transform), recthelper.getHeight(slot0._imageZoneOld.transform), slot4.offsetX, slot4.offsetY)
	end

	gohelper.setActive(slot0._simagecg.gameObject, false)
	gohelper.setActive(slot0._simagecgold.gameObject, true)
end

function slot0.autoMoveBanner(slot0)
	TaskDispatcher.cancelTask(slot0.autoSwitch, slot0)
	TaskDispatcher.runRepeat(slot0.autoSwitch, slot0, 3)
end

function slot0.autoSwitch(slot0)
	slot0:_btnnextOnClick()
end

function slot0.onDungeonUpdate(slot0)
	slot0:_initTop()
	slot0:_refreshUI()
	slot0:_initRightBtn()
	slot0:_focusItem()
	slot0:autoMoveBanner()
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("loadZone")
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()

	for slot4, slot5 in ipairs(slot0._topItemList) do
		slot5.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(slot0._afterPlayAnim, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagecg:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.autoSwitch, slot0)
	TaskDispatcher.cancelTask(slot0._afterPlayAnim, slot0)
end

return slot0
