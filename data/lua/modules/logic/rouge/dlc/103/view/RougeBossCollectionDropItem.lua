module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropItem", package.seeall)

slot0 = class("RougeBossCollectionDropItem", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.go = slot1
	slot0.parent = slot2

	slot0:_editableInitView()
end

function slot0._editableInitView(slot0)
	slot0.animator = slot0.go:GetComponent(gohelper.Type_Animator)
	slot0._goselect = gohelper.findChild(slot0.go, "#go_select")
	slot0._goenchantlist = gohelper.findChild(slot0.go, "#go_enchantlist")
	slot0._gohole = gohelper.findChild(slot0.go, "#go_enchantlist/#go_hole")
	slot0._gridLayout = gohelper.findChild(slot0.go, "Grid")
	slot0._gogriditem = gohelper.findChild(slot0.go, "Grid/#go_grid")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.go, "#simage_collection")
	slot0._txtname = gohelper.findChildText(slot0.go, "#txt_name")
	slot0._scrollreward = gohelper.findChild(slot0.go, "scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._godescContent = gohelper.findChild(slot0.go, "scroll_desc/Viewport/#go_descContent")
	slot0._scrollbossattr = gohelper.findChildScrollRect(slot0.go, "#scroll_bossattr")
	slot0._gobossDescContent = gohelper.findChild(slot0.go, "#scroll_bossattr/Viewport/#go_bossDescContent")
	slot0._txtbossattrdesc = gohelper.findChildText(slot0.go, "#scroll_bossattr/Viewport/#go_bossDescContent/go_bossattritem/#txt_desc")
	slot0._gotags = gohelper.findChild(slot0.go, "tagcontent/tags")
	slot0._gotagitem = gohelper.findChild(slot0.go, "tagcontent/tags/#go_tagitem")
	slot0._gotips = gohelper.findChild(slot0.go, "#go_tips")
	slot0._gotipscontent = gohelper.findChild(slot0.go, "#go_tips/#go_tipscontent")
	slot0._gotipitem = gohelper.findChild(slot0.go, "#go_tips/#go_tipscontent/#txt_tagitem")
	slot0._btnopentagtips = gohelper.findChildButtonWithAudio(slot0.go, "tagcontent/#btn_opentagtips")
	slot0._btnclosetagtips = gohelper.findChildButtonWithAudio(slot0.go, "#go_tips/#btn_closetips")
	slot0._btnfresh = gohelper.findChildButtonWithAudio(slot0.go, "#scroll_bossattr/#btn_fresh")
	slot0._gofreshicon_drak = gohelper.findChild(slot0.go, "#scroll_bossattr/#btn_fresh/dark")
	slot0._gofreshicon_light = gohelper.findChild(slot0.go, "#scroll_bossattr/#btn_fresh/light")
	slot0.holeGoList = slot0:getUserDataTb_()

	table.insert(slot0.holeGoList, slot0._gohole)

	slot0.gridList = slot0:getUserDataTb_()
	slot0._itemInstTab = slot0:getUserDataTb_()
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.go)

	slot0.click:AddClickListener(slot0.onClickSelf, slot0)
	slot0._btnopentagtips:AddClickListener(slot0._opentagtipsOnClick, slot0)
	slot0._btnclosetagtips:AddClickListener(slot0._closetagtipsOnClick, slot0)
	slot0._btnfresh:AddClickListener(slot0._btnfreshOnClick, slot0)

	slot0._bossviewportclick = gohelper.findChildClickWithDefaultAudio(slot0.go, "#scroll_bossattr/Viewport")

	slot0._bossviewportclick:AddClickListener(slot0.onClickSelf, slot0)

	slot0._bossdescclick = gohelper.getClickWithDefaultAudio(slot0._txtbossattrdesc.gameObject)

	slot0._bossdescclick:AddClickListener(slot0.onClickSelf, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectDropChange, slot0.onSelectDropChange, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.ShowMonsterRuleDesc, slot0.switchShowMonsterRuleDesc, slot0)
end

function slot0.onClickSelf(slot0)
	slot0.parent:selectPos(slot0.index)
	slot0:refreshSelect()
end

function slot0._opentagtipsOnClick(slot0)
	gohelper.setActive(slot0._gotips, true)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(slot0.collectionId, nil, slot0._gotipscontent, slot0._gotipitem)
end

function slot0._closetagtipsOnClick(slot0)
	gohelper.setActive(slot0._gotips, false)
end

function slot0._btnfreshOnClick(slot0)
	if not slot0._canFresh then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.RefreshRougeBossCollection)
	slot0.animator:Play("open", 0, 0)
	RougeRpc.instance:sendRougeRefreshMonsterRuleRequest(RougeModel.instance:getSeason(), slot0.index)
end

function slot0.onSelectDropChange(slot0)
	slot0.select = slot0.parent:isSelect(slot0.index)

	slot0:refreshSelect()
end

function slot0.setParentScroll(slot0, slot1)
	slot0._scrollreward.parentGameObject = slot1
end

function slot0.update(slot0, slot1, slot2, slot3, slot4)
	slot0.select = false
	slot0.index = slot1
	slot0.collectionId = tonumber(slot2)
	slot0.collectionCo = RougeCollectionConfig.instance:getCollectionCfg(slot0.collectionId)
	slot0.monsterRuleId = tonumber(slot3)
	slot0.monsterRuleCo = RougeDLCConfig103.instance:getMonsterRuleConfig(slot0.monsterRuleId)
	slot0.isShowMonsterRule = slot4

	slot0:refreshHole()
	RougeCollectionHelper.loadShapeGrid(slot0.collectionId, slot0._gridLayout, slot0._gogriditem, slot0.gridList)
	RougeCollectionHelper.loadCollectionTags(slot0.collectionId, slot0._gotags, slot0._gotagitem)
	slot0._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0.collectionId))

	slot0._txtname.text = RougeCollectionConfig.instance:getCollectionName(slot0.collectionId)

	slot0:refreshCollectionDesc()
	slot0:refreshSelect()
end

function slot0.refreshHole(slot0)
	gohelper.setActive(slot0._goenchantlist, slot0.collectionCo.holeNum > 0)

	if slot1 > 1 then
		for slot5 = 1, slot1 do
			if not slot0.holeGoList[slot5] then
				table.insert(slot0.holeGoList, gohelper.cloneInPlace(slot0._gohole))
			end

			gohelper.setActive(slot6, true)
		end

		for slot5 = slot1 + 1, #slot0.holeGoList do
			gohelper.setActive(slot0.holeGoList[slot5], false)
		end
	end
end

function slot0.refreshEffectDesc(slot0)
	slot0._allClicks = slot0._allClicks or slot0:getUserDataTb_()
	slot0._clickLen = slot0._clickLen or 0

	for slot4 = 1, slot0._clickLen do
		slot0._allClicks[slot4]:RemoveClickListener()
	end

	slot0._clickLen = 0
	slot5 = slot0._itemInstTab

	RougeCollectionDescHelper.setCollectionDescInfos2(slot0.collectionId, nil, slot0._godescContent, slot5)

	slot0._clickLen = slot0._scrollreward.gameObject:GetComponentsInChildren(typeof(SLFramework.UGUI.UIClickListener), true).Length

	for slot5 = 0, slot0._clickLen - 1 do
		slot0._allClicks[slot5 + 1] = slot1[slot5]

		slot0._allClicks[slot5 + 1]:AddClickListener(slot0.onClickSelf, slot0)
		gohelper.addUIClickAudio(slot0._allClicks[slot5 + 1].gameObject)
	end
end

function slot0.refreshBossAttrDesc(slot0)
	slot0._txtbossattrdesc.text = SkillHelper.addLink(slot0.monsterRuleCo and slot0.monsterRuleCo.desc or "")

	SkillHelper.addHyperLinkClick(slot0._txtbossattrdesc)
end

function slot0.refreshFreshBtn(slot0)
	slot0._canFresh = RougeMapModel.instance:getMonsterRuleRemainCanFreshNum() and slot1 > 0

	gohelper.setActive(slot0._gofreshicon_light, slot0._canFresh)
	gohelper.setActive(slot0._gofreshicon_drak, not slot0._canFresh)
end

function slot0.refreshCollectionDesc(slot0)
	gohelper.setActive(slot0._scrollreward.gameObject, not slot0.isShowMonsterRule)
	gohelper.setActive(slot0._scrollbossattr.gameObject, slot0.isShowMonsterRule)

	if slot0.isShowMonsterRule then
		slot0:refreshBossAttrDesc()
		slot0:refreshFreshBtn()
	else
		slot0:refreshEffectDesc()
	end
end

function slot0.switchShowMonsterRuleDesc(slot0, slot1)
	slot0.animator:Play("open", 0, 0)

	slot0.isShowMonsterRule = slot1

	slot0:refreshCollectionDesc()
end

function slot0.refreshSelect(slot0)
	gohelper.setActive(slot0._goselect, slot0.select)
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refreshEffectDesc()
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.show(slot0)
	if slot0.go.activeInHierarchy then
		return
	end

	slot0.animator:Play("open", 0, 0)
	gohelper.setActive(slot0.go, true)
end

function slot0.onClose(slot0)
	slot0.animator:Play(slot0.select and "close" or "normal", 0, 0)
end

function slot0.destroy(slot0)
	if slot0._clickLen then
		for slot4 = 1, slot0._clickLen do
			slot0._allClicks[slot4]:RemoveClickListener()
		end
	end

	slot0.click:RemoveClickListener()
	slot0._btnopentagtips:RemoveClickListener()
	slot0._btnclosetagtips:RemoveClickListener()
	slot0._btnfresh:RemoveClickListener()
	slot0._bossdescclick:RemoveClickListener()
	slot0._bossviewportclick:RemoveClickListener()
	slot0._simagecollection:UnLoadImage()
	slot0:__onDispose()
end

return slot0
