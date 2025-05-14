module("modules.logic.rouge.map.view.map.RougeMapVoiceView", package.seeall)

local var_0_0 = class("RougeMapVoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochesstalk = gohelper.findChild(arg_1_0.viewGO, "#go_chesstalk")
	arg_1_0._txtchesstalk = gohelper.findChildText(arg_1_0.viewGO, "#go_chesstalk/Scroll View/Viewport/Content/#txt_talk")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:hideVoice()

	arg_4_0.rectTr = arg_4_0._gochesstalk:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.viewRectTr = arg_4_0.viewGO:GetComponent(gohelper.Type_RectTransform)

	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onTriggerShortVoice, arg_4_0.onTriggerShortVoice, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onEndTriggerShortVoice, arg_4_0.onEndTriggerShortVoice, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onActorPosChange, arg_4_0.onActorPosChange, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onMapPosChange, arg_4_0.onMapPosChange, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onCameraSizeChange, arg_4_0.onMapPosChange, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, arg_4_0.onChangeMapInfo, arg_4_0, LuaEventSystem.High)
end

function var_0_0.onChangeMapInfo(arg_5_0)
	arg_5_0:hideVoice()
end

function var_0_0.onActorPosChange(arg_6_0, arg_6_1)
	if not arg_6_0.showIng then
		return
	end

	arg_6_0:updatePos(arg_6_1)
end

function var_0_0.onMapPosChange(arg_7_0)
	if RougeMapModel.instance:isPathSelect() then
		return
	end

	if not arg_7_0.showIng then
		return
	end

	local var_7_0 = RougeMapController.instance:getActorMap()

	if var_7_0 then
		arg_7_0:updatePos(var_7_0:getActorWordPos())
	end
end

function var_0_0.onTriggerShortVoice(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.desc

	AudioMgr.instance:trigger(arg_8_1.audioId)

	if string.nilorempty(var_8_0) then
		return
	end

	if RougeMapModel.instance:isPathSelect() then
		return
	end

	arg_8_0:showVoice()

	arg_8_0._txtchesstalk.text = var_8_0

	local var_8_1 = RougeMapController.instance:getActorMap()

	if var_8_1 then
		arg_8_0:updatePos(var_8_1:getActorWordPos())
	end
end

function var_0_0.onEndTriggerShortVoice(arg_9_0)
	arg_9_0:hideVoice()
end

function var_0_0.hideVoice(arg_10_0)
	gohelper.setActive(arg_10_0._gochesstalk, false)

	arg_10_0.showIng = false
end

function var_0_0.showVoice(arg_11_0)
	gohelper.setActive(arg_11_0._gochesstalk, true)

	arg_11_0.showIng = true
end

function var_0_0.updatePos(arg_12_0, arg_12_1)
	local var_12_0, var_12_1 = recthelper.worldPosToAnchorPos2(arg_12_1, arg_12_0.viewRectTr)
	local var_12_2

	if RougeMapModel.instance:isNormalLayer() then
		var_12_2 = RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Normal]
	else
		var_12_2 = RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Middle]
	end

	local var_12_3 = var_12_2.x
	local var_12_4 = var_12_2.y

	recthelper.setAnchor(arg_12_0.rectTr, var_12_0 + var_12_3, var_12_1 + var_12_4)
end

return var_0_0
