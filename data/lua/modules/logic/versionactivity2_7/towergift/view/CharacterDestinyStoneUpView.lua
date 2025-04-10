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
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnoncefull:AddClickListener(slot0._btnoncefullOnClick, slot0)
	slot0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, slot0._onUnlockStoneReply, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnoncefull:RemoveClickListener()
	slot0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, slot0._onUnlockStoneReply, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
end

function slot0._btnoncefullOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.CharacterDestinyStoneUpView, MsgBoxEnum.BoxType.Yes_No, slot0._useStoneUpTicket, nil, , slot0, nil, )
end

function slot0._useCallback(slot0)
end

function slot0._useStoneUpTicket(slot0)
	slot1 = {}

	table.insert(slot1, {
		materialId = TowerGiftEnum.StoneUpTicketId,
		quantity = 1
	})
	ItemRpc.instance:sendUseItemRequest(slot1, slot0._curStoneMo.stoneId)
end

function slot0._onItemChanged(slot0)
	gohelper.setActive(slot0._gooncefull, false)
	gohelper.setActive(slot0._gohasoncefull, true)
	slot0:_playAnim()
	DestinyStoneGiftPickChoiceController.instance:dispatchEvent(DestinyStoneGiftPickChoiceEvent.hadStoneUp)
end

function slot0._playAnim(slot0)
	if slot0._isSlotMaxLevel then
		slot0._animator:Play("allup", 0, 0)
		slot0:_refreshStoneItem()
	elseif not slot0._curStoneMo.isUnlock then
		slot0._animator:Play("allup", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_unlock)

		function slot0._cb()
			TaskDispatcher.cancelTask(uv0._cb, uv0)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_checkpoint_doom_disappear)
		end

		TaskDispatcher.runDelay(slot0._cb, slot0, 2.6)
		slot0:_refreshStoneItem()
	else
		slot0._animator:Play("allup", 0, 0)
		TaskDispatcher.runDelay(slot0._onPlayAnimBack, slot0, 2.6)
	end
end

function slot0._onPlayAnimBack(slot0)
	TaskDispatcher.cancelTask(slot0._onPlayAnimBack, slot0)

	if slot0._effectItems then
		for slot4, slot5 in ipairs(slot0._effectItems) do
			gohelper.setActive(slot5.gounlock, slot0._heroMO.destinyStoneMo:isCanPlayAttrUnlockAnim(slot0._curStoneMo.stoneId, slot4))
		end
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_checkpoint_doom_disappear)
	slot0:_refreshStoneItem()
end

function slot0._onUnlockStoneReply(slot0, slot1, slot2)
	if slot0._curStoneMo then
		slot0._curStoneMo:refresUnlock(true)
	end

	slot0:_refreshStoneItem()
	gohelper.setActive(slot0._root, true)
	gohelper.setActive(slot0._gounlockstone, false)
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
	slot0._curStoneMo = slot0.viewParam.stoneMo
	slot0._destinyStoneMo = slot0._heroMO.destinyStoneMo
	slot0._isSlotMaxLevel = slot0._destinyStoneMo:isSlotMaxLevel()

	if slot0._curStoneMo then
		if not slot0._unlockStoneView then
			slot0._unlockStoneView = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gounlockstone, CharacterDestinyUnlockStoneComp)

			slot0._unlockStoneView:setStoneView(slot0)
		end

		slot0._unlockStoneView:onUpdateMo(slot0._heroMO.heroId, slot0._curStoneMo.stoneId)
		slot0:_refreshStoneItem()
	end

	gohelper.setActive(slot0._root, true)
end

function slot0._refreshStoneItem(slot0)
	if slot0._curStoneMo then
		slot0._levelCos = slot0._curStoneMo:getFacetCo()
		slot1 = slot0._curStoneMo.conusmeCo

		if slot0._levelCos then
			for slot5, slot6 in ipairs(slot0._effectItems) do
				slot6.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(slot6.txt.gameObject, SkillDescComp)

				slot6.skillDesc:updateInfo(slot6.txt, slot0._levelCos[slot5].desc, slot0._heroMO.heroId)
				slot6.skillDesc:setTipParam(0, Vector2(300, 100))

				slot8 = slot0._curStoneMo.isUnlock and slot5 <= slot0._heroMO.destinyStoneMo.rank
				slot9 = slot6.txt.color
				slot9.a = slot8 and 1 or 0.43
				slot6.txt.color = slot9

				if slot8 then
					slot10 = slot6.unlockicon.color
					slot10.a = slot8 and 1 or 0.43
					slot6.unlockicon.color = slot10
				else
					slot10 = slot6.lockicon.color
					slot10.a = slot8 and 1 or 0.43
					slot6.lockicon.color = slot10
				end

				gohelper.setActive(slot6.lockicon.gameObject, not slot8)
				gohelper.setActive(slot6.unlockicon.gameObject, slot8)
			end
		end

		gohelper.setActive(slot0._goEquip, slot0._curStoneMo.isUse)

		if slot1 then
			slot0._txtstonename.text, slot3 = slot0._curStoneMo:getNameAndIcon()

			slot0._simagestone:LoadImage(slot3)

			slot4 = CharacterDestinyEnum.SlotTend[slot1.tend]

			UISpriteSetMgr.instance:setUiCharacterSprite(slot0._imageicon, slot4.TitleIconName)

			slot0._txtstonename.color = GameUtil.parseColor(slot4.TitleColor)
		end

		slot0._imgstone.color = slot0._curStoneMo.isUnlock and Color.white or Color(0.5, 0.5, 0.5, 1)
	end

	if not slot0._pointItems then
		slot0._pointItems = slot0:getUserDataTb_()
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
	TaskDispatcher.cancelTask(slot0._cb, slot0)
	TaskDispatcher.cancelTask(slot0._onPlayAnimBack, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	slot0._simagestone:UnLoadImage()
end

return slot0
