module("modules.logic.explore.view.ExploreBonusSceneRecordView", package.seeall)

slot0 = class("ExploreBonusSceneRecordView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._item = gohelper.findChild(slot0.viewGO, "mask/Scroll View/Viewport/Content/#go_chatitem")
	slot0._itemContent = gohelper.findChild(slot0.viewGO, "mask/Scroll View/Viewport/Content")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot3, slot4 = next(ExploreSimpleModel.instance:getChapterMo(slot0.viewParam.chapterId).bonusScene)
	slot6 = {}
	slot7 = nil

	for slot11, slot12 in ipairs(slot4) do
		if ExploreConfig.instance:getDialogueConfig(slot3)[slot11] then
			if not string.nilorempty(slot13.bonusButton) then
				-- Nothing
			end

			table.insert(slot6, {
				desc = slot13.desc,
				options = string.split(slot13.bonusButton, "|"),
				index = slot12
			})

			if not string.nilorempty(slot13.picture) then
				slot7 = slot13.picture
			end
		end
	end

	if not string.nilorempty(slot7) then
		slot0._simageicon:LoadImage(ResUrl.getExploreBg("file/" .. slot7))
	end

	gohelper.CreateObjList(slot0, slot0.onCreateItem, slot6, slot0._itemContent, slot0._item)
end

function slot0.onCreateItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChildTextMesh(slot1, "info"), slot2.desc)
	gohelper.setActive(gohelper.findChild(slot1, "bg"), slot2.options)

	if slot2.desc then
		slot4.text = slot2.desc
	end

	if slot2.options then
		for slot9 = 1, 3 do
			slot10 = gohelper.findChildTextMesh(slot5, "txt" .. slot9)

			if slot2.options[slot9] then
				slot10.text = slot2.options[slot9]

				gohelper.setActive(gohelper.findChild(slot5, "txt" .. slot9 .. "/play"), slot2.index == slot9)
				SLFramework.UGUI.GuiHelper.SetColor(slot10, slot2.index == slot9 and "#445D42" or "#3D3939")
			else
				gohelper.setActive(slot10, false)
			end
		end
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	slot0._simageicon:UnLoadImage()
end

return slot0
