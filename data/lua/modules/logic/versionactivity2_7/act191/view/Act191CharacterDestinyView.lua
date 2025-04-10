module("modules.logic.versionactivity2_7.act191.view.Act191CharacterDestinyView", package.seeall)

slot0 = class("Act191CharacterDestinyView", BaseView)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "root/#image_icon")
	slot0._txtstonename = gohelper.findChildText(slot0.viewGO, "root/#txt_stonename")
	slot0._simagestone = gohelper.findChildSingleImage(slot0.viewGO, "root/go_stone/#simage_stone")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "root/effectItem")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.config = slot0.viewParam.config
	slot0.stoneId = slot0.viewParam.stoneId
	slot0._levelCos = CharacterDestinyConfig.instance:getDestinyFacetCo(slot0.stoneId)
	slot0.conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(slot0.stoneId)
	slot0._effectItems = slot0:getUserDataTb_()

	for slot4 = 1, CharacterDestinyEnum.EffectItemCount do
		slot5 = gohelper.findChild(slot0._goeffect, slot4)
		slot6 = slot0:getUserDataTb_()
		slot6.go = slot5
		slot6.txt = gohelper.findChildText(slot5, "txt_dec")
		slot6.canvasgroup = slot5:GetComponent(typeof(UnityEngine.CanvasGroup))
		slot0._effectItems[slot4] = slot6
	end

	slot0:_refreshStoneItem()
end

function slot0._refreshStoneItem(slot0)
	for slot4, slot5 in ipairs(slot0._effectItems) do
		slot5.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(slot5.txt.gameObject, Act191SkillDescComp)

		slot5.skillDesc:updateInfo(slot5.txt, slot0._levelCos[slot4].desc, slot0.config)
		slot5.skillDesc:setTipParam(0, Vector2(300, 100))
	end

	slot0._txtstonename.text = slot0.conusmeCo.name

	slot0._simagestone:LoadImage(ResUrl.getDestinyIcon(slot0.conusmeCo.icon))

	slot2 = CharacterDestinyEnum.SlotTend[slot0.conusmeCo.tend]

	UISpriteSetMgr.instance:setUiCharacterSprite(slot0._imageicon, slot2.TitleIconName)

	slot0._txtstonename.color = GameUtil.parseColor(slot2.TitleColor)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
