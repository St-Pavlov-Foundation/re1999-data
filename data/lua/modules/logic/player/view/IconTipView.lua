module("modules.logic.player.view.IconTipView", package.seeall)

slot0 = class("IconTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagetop = gohelper.findChildSingleImage(slot0.viewGO, "window/bg/#simage_top")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "window/bg/#simage_bottom")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "window/right/useState/#btn_change")
	slot0._txtnameCn = gohelper.findChildText(slot0.viewGO, "window/right/#txt_nameCn")
	slot0._gousing = gohelper.findChild(slot0.viewGO, "window/right/useState/#go_using")
	slot0._simageheadIcon = gohelper.findChildSingleImage(slot0.viewGO, "window/right/#simage_headIcon")
	slot0._goframenode = gohelper.findChild(slot0.viewGO, "window/right/#simage_headIcon/#go_framenode")
	slot0._btncloseBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "window/top/#btn_closeBtn")
	slot0._btnSwitchLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "window/right/Btn_SwitchLeft")
	slot0._btnSwitchRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "window/right/Btn_SwitchRight")
	slot0._loader = MultiAbLoader.New()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncloseBtn:AddClickListener(slot0._btncloseBtnOnClick, slot0)
	slot0._btnSwitchLeft:AddClickListener(slot0._btnSwitchBtnOnClick, slot0, false)
	slot0._btnSwitchRight:AddClickListener(slot0._btnSwitchBtnOnClick, slot0, true)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncloseBtn:RemoveClickListener()
	slot0._btnSwitchLeft:RemoveClickListener()
	slot0._btnSwitchRight:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	slot1 = nil

	if slot0._curSwitchIndex and slot0._switchHeadIdList then
		if slot0._switchHeadIdList[slot0._curSwitchIndex] == nil then
			logError("不存在的镀层头像索引")

			return
		end
	else
		slot1 = IconTipModel.instance:getSelectIcon()
	end

	PlayerRpc.instance:sendSetPortraitRequest(slot1)
end

function slot0._btncloseBtnOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnSwitchBtnOnClick(slot0, slot1)
	slot2 = slot0._curSwitchIndex

	if slot0._switchHeadIdList[(not slot1 or math.min(slot2 + 1, slot0._switchHeadIdCount)) and math.max(slot2 - 1, 1)] == nil then
		logError("index outof range")

		return
	end

	IconTipModel.instance:setSelectIcon(slot3)
	slot0:_refreshSwitchBtnState(slot2)
	slot0:_setHeadIcon(lua_item.configDict[slot3])
end

function slot0._editableInitView(slot0)
	slot1 = PlayerModel.instance:getPlayinfo()

	IconTipModel.instance:setSelectIcon(slot1.portrait)
	IconTipModel.instance:setIconList(slot1.portrait)
	slot0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	slot0._buttonbg = gohelper.findChildClick(slot0.viewGO, "maskbg")

	slot0._buttonbg:AddClickListener(slot0._btncloseBtnOnClick, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot3 = PlayerModel.instance:getPlayinfo().portrait
	slot0._usedIcon = slot3

	gohelper.setActive(slot0._btnconfirm.gameObject, IconTipModel.instance:getSelectIcon() ~= slot3)
	gohelper.setActive(slot0._gousing, slot1 == slot3)

	slot4 = lua_item.configDict[slot1]
	slot0._txtnameCn.text = slot4.name

	slot0:_setHeadIcon(slot4)
	gohelper.setActive(slot0._btnSwitchLeft.gameObject, false)
	gohelper.setActive(slot0._btnSwitchRight.gameObject, false)

	slot0._curSwitchIndex = nil
	slot0._switchHeadIdList = nil
	slot0._switchHeadIdCount = nil

	if string.nilorempty(slot4.effect) then
		return
	end

	if string.splitToNumber(slot4.effect, "#") == nil then
		return
	end

	if #slot5 <= 0 then
		return
	end

	slot0._switchHeadIdCount = 0
	slot0._switchHeadIdList = {}

	for slot10, slot11 in ipairs(slot5) do
		if ItemModel.instance:getById(slot11) ~= nil then
			table.insert(slot0._switchHeadIdList, slot11)

			slot0._switchHeadIdCount = slot0._switchHeadIdCount + 1
		end
	end

	if slot0._switchHeadIdCount <= 0 then
		return
	end

	slot7 = nil

	for slot11, slot12 in ipairs(slot0._switchHeadIdList) do
		if slot12 == slot1 then
			slot7 = slot11
		end
	end

	if slot7 == nil then
		logError("没有找到编号为 ：" .. slot1 .. "的镀层头像")

		return
	end

	slot0:_refreshSwitchBtnState(slot7)
end

function slot0._setHeadIcon(slot0, slot1)
	if slot1 == nil then
		logError("头像为空")

		return
	end

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageheadIcon)
	end

	slot0._liveHeadIcon:setLiveHead(slot1.id)

	if #string.split(slot1.effect, "#") > 1 then
		if slot1.id == tonumber(slot2[#slot2]) then
			gohelper.setActive(slot0._goframenode, true)

			if not slot0.frame then
				slot0._loader:addPath("ui/viewres/common/effect/frame.prefab")
				slot0._loader:startLoad(slot0._onLoadCallback, slot0)
			end
		end
	else
		gohelper.setActive(slot0._goframenode, false)
	end
end

function slot0._refreshSwitchBtnState(slot0, slot1)
	slot0._curSwitchIndex = slot1

	gohelper.setActive(slot0._btnSwitchLeft.gameObject, slot1 > 1)
	gohelper.setActive(slot0._btnSwitchRight.gameObject, slot1 < slot0._switchHeadIdCount)
	gohelper.setActive(slot0._btnconfirm, slot0._switchHeadIdList[slot1] ~= slot0._usedIcon)
end

function slot0._onLoadCallback(slot0)
	gohelper.clone(slot0._loader:getFirstAssetItem():GetResource(), slot0._goframenode, "frame")

	slot0.frame = gohelper.findChild(slot0._goframenode, "frame")
	slot0.frame:GetComponent(gohelper.Type_Image).enabled = false
	slot5 = 1.41 * recthelper.getWidth(slot0._simageheadIcon.transform) / recthelper.getWidth(slot0.frame.transform)

	transformhelper.setLocalScale(slot0.frame.transform, slot5, slot5, 1)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, slot0._refreshUI, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.SetPortrait, slot0._refreshUI, slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(PlayerController.instance, PlayerEvent.SelectPortrait, slot0._refreshUI, slot0)
	slot0:removeEventCb(PlayerController.instance, PlayerEvent.SetPortrait, slot0._refreshUI, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageheadIcon:UnLoadImage()
	slot0._buttonbg:RemoveClickListener()

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
