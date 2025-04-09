module("modules.logic.versionactivity2_7.towergift.view.CharacterDestinyStoneUpView", package.seeall)

slot0 = class("CharacterDestinyStoneUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._godrag = gohelper.findChild(slot0.viewGO, "#go_drag")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "root/#image_icon")
	slot0._txtstonename = gohelper.findChildText(slot0.viewGO, "root/#txt_stonename")
	slot0._gostone = gohelper.findChild(slot0.viewGO, "root/#go_stone")
	slot0._gooncefull = gohelper.findChild(slot0.viewGO, "root/btn/#go_oncefull")
	slot0._btnoncefull = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#go_oncefull/#btn_oncefull")
	slot0._gohasoncefull = gohelper.findChild(slot0.viewGO, "root/btn/#go_hasoncefull")
	slot0._gopoint = gohelper.findChild(slot0.viewGO, "root/point/#go_point")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnoncefull:AddClickListener(slot0._btnoncefullOnClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnoncefull:RemoveClickListener()
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
end

function slot0._btnoncefullOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.EquipRefineCost, MsgBoxEnum.BoxType.Yes_No, slot0._useStoneUpTicket, nil, , slot0, nil, )
end

function slot0._useStoneUpTicket(slot0)
	slot1 = {}

	table.insert(slot1, {
		materialId = TowerGiftEnum.StoneUpTicketId,
		quantity = 1
	})
	ItemRpc.instance:sendUseItemRequest(slot1, slot0._upStoneId)
end

function slot0._onItemChanged(slot0)
	gohelper.setActive(slot0._gooncefull, false)
	gohelper.setActive(slot0._gohasoncefull, true)
	slot0:_refreshStoneItem(slot0._selectIndex)
end

function slot0._editableInitView(slot0)
	slot0._simagestone = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_stone/#simage_stone")
	slot0._simagepre = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_prestone/#btn_prestone")
	slot0._simagenext = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_nextstone/#btn_nextstone")
	slot0._gounlockstone = gohelper.findChild(slot0.viewGO, "unlockstone")
	slot0._root = gohelper.findChild(slot0.viewGO, "root")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "root/effectItem")
	slot0._imgstone = gohelper.findChildImage(slot0.viewGO, "root/#go_stone/#simage_stone")
	slot0._goEquip = gohelper.findChild(slot0.viewGO, "root/#go_stone/#equip")
	slot0._animRoot = slot0._root:GetComponent(typeof(UnityEngine.Animator))
	slot0._animPlayerRoot = ZProj.ProjAnimatorPlayer.Get(slot0._root)
	slot0._animPlayerUnlockStone = ZProj.ProjAnimatorPlayer.Get(slot0._gounlockstone)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godrag.gameObject)
end

function slot0.onUpdateParam(slot0)
end

function slot0._addEvents(slot0)
end

function slot0._removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0._effectItems = slot0:getUserDataTb_()

	for slot4 = 1, CharacterDestinyEnum.EffectItemCount do
		slot5 = gohelper.findChild(slot0._goeffect, slot4)
		slot6 = slot0:getUserDataTb_()
		slot6.go = slot5
		slot6.lockicon = gohelper.findChildImage(slot5, "#txt_dec/#go_lockicon")
		slot6.unlockicon = gohelper.findChildImage(slot5, "#txt_dec/#go_unlockicon")
		slot6.txt = gohelper.findChildText(slot5, "#txt_dec")
		slot6.gounlock = gohelper.findChild(slot5, "#unlock")
		slot6.canvasgroup = slot5:GetComponent(typeof(UnityEngine.CanvasGroup))
		slot0._effectItems[slot4] = slot6
	end

	slot0._heroMO = slot0.viewParam.heroMo
	slot0._destinyStoneMo = slot0._heroMO.destinyStoneMo
	slot0._upStoneId = slot0._destinyStoneMo:getUpStoneId()
	slot0._curUseStoneId = slot0._heroMO.destinyStoneMo.curUseStoneId

	if slot0._upStoneId then
		slot0._upStone = true
		slot0._curUseStoneId = slot0._upStoneId
	end

	slot0._facetMos = {}

	if slot0._heroMO.destinyStoneMo.stoneMoList then
		slot2 = 1
		slot3 = 1

		for slot7, slot8 in pairs(slot1) do
			if slot8.stoneId == slot0._curUseStoneId then
				slot3 = slot2
			end

			slot2 = slot2 + 1

			table.insert(slot0._facetMos, slot8)
		end

		slot0:_refreshStoneItem(slot3)
	end

	gohelper.setActive(slot0._root, true)
end

function slot0._refreshStoneItem(slot0, slot1)
	if not slot1 or slot1 == 0 then
		slot1 = 1
	end

	slot2 = #slot0._facetMos
	slot0._selectIndex = slot1
	slot0._curStoneMo = slot0._facetMos[slot1]

	if slot0._curStoneMo then
		slot0._levelCos = slot0._curStoneMo:getFacetCo()
		slot3 = slot0._curStoneMo.conusmeCo

		if slot0._levelCos then
			for slot7, slot8 in ipairs(slot0._effectItems) do
				slot8.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(slot8.txt.gameObject, SkillDescComp)

				slot8.skillDesc:updateInfo(slot8.txt, slot0._levelCos[slot7].desc, slot0._heroMO.heroId)
				slot8.skillDesc:setTipParam(0, Vector2(300, 100))

				slot10 = slot0._curStoneMo.isUnlock and slot7 <= slot0._heroMO.destinyStoneMo.rank
				slot11 = slot8.txt.color
				slot11.a = slot10 and 1 or 0.43
				slot8.txt.color = slot11

				if slot10 then
					slot12 = slot8.unlockicon.color
					slot12.a = slot10 and 1 or 0.43
					slot8.unlockicon.color = slot12
				else
					slot12 = slot8.lockicon.color
					slot12.a = slot10 and 1 or 0.43
					slot8.lockicon.color = slot12
				end

				gohelper.setActive(slot8.lockicon.gameObject, not slot10)
				gohelper.setActive(slot8.unlockicon.gameObject, slot10)
			end
		end

		gohelper.setActive(slot0._goEquip, slot0._curStoneMo.isUse)

		if slot3 then
			slot0._txtstonename.text, slot5 = slot0._curStoneMo:getNameAndIcon()

			slot0._simagestone:LoadImage(slot5)

			slot6 = CharacterDestinyEnum.SlotTend[slot3.tend]

			UISpriteSetMgr.instance:setUiCharacterSprite(slot0._imageicon, slot6.TitleIconName)

			slot0._txtstonename.color = GameUtil.parseColor(slot6.TitleColor)
		end

		slot0._imgstone.color = slot0._curStoneMo.isUnlock and Color.white or Color(0.5, 0.5, 0.5, 1)
	end

	if not slot0._pointItems then
		slot0._pointItems = slot0:getUserDataTb_()
	end

	if slot2 > 1 then
		for slot6 = 1, slot2 do
			gohelper.setActive(slot0:_getPointItem(slot6).select, slot1 == slot6)
			gohelper.setActive(slot7.go, true)
		end
	else
		for slot6, slot7 in ipairs(slot0._pointItems) do
			gohelper.setActive(slot7.go, false)
		end
	end
end

function slot0._getPointItem(slot0, slot1)
	if not slot0._pointItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gopoint, slot1)
		slot2.go = slot3
		slot2.normal = gohelper.findChild(slot3, "normal")
		slot2.select = gohelper.findChild(slot3, "select")
		slot0._pointItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClose(slot0)
	slot0._destinyStoneMo:clearUpStoneId()
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	slot0._simagestone:UnLoadImage()
end

return slot0
