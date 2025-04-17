module("modules.logic.versionactivity2_7.act191.view.Act191EnhancePickView", package.seeall)

slot0 = class("Act191EnhancePickView", BaseView)

function slot0.onInitView(slot0)
	slot0._goSelectItem = gohelper.findChild(slot0.viewGO, "scroll_view/Viewport/Content/#go_SelectItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function Act174ForcePickView._onEscBtnClick(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goSelectItem, false)

	slot0.actId = Activity191Model.instance:getCurActId()
	slot0.maxFreshNum = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.MaxFreshNum].value)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.nodeDetailMo = slot0.viewParam
	slot0.enhanceItemList = {}

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.freshIndex = nil

	for slot4, slot5 in ipairs(slot0.nodeDetailMo.enhanceList) do
		slot6 = slot0.enhanceItemList[slot4] or slot0:creatEnhanceItem(slot4)
		slot7 = Activity191Config.instance:getEnhanceCo(slot0.actId, slot5)

		slot6.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(slot7.icon))

		slot6.txtName.text = slot7.title

		if lua_activity191_effect.configDict[string.splitToNumber(slot7.effects, "|")[1]] then
			if slot10.type == Activity191Enum.EffectType.EnhanceHero then
				slot6.txtDesc.text = Activity191Helper.buildDesc(SkillHelper.addLink(slot7.desc), Activity191Enum.HyperLinkPattern.EnhanceDestiny, slot10.typeParam)

				SkillHelper.addHyperLinkClick(slot6.txtDesc, Activity191Helper.clickHyperLinkDestiny)
			elseif slot10.type == Activity191Enum.EffectType.EnhanceItem then
				slot6.txtDesc.text = Activity191Helper.buildDesc(slot8, Activity191Enum.HyperLinkPattern.EnhanceItem, slot10.typeParam .. "#")

				SkillHelper.addHyperLinkClick(slot6.txtDesc, Activity191Helper.clickHyperLinkItem)
			else
				slot6.txtDesc.text = slot8
			end
		else
			slot6.txtDesc.text = slot8
		end

		gohelper.setActive(slot6.btnFresh, (slot0.nodeDetailMo.enhanceNumList[slot4] or 0) < slot0.maxFreshNum)
	end
end

function slot0.creatEnhanceItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.cloneInPlace(slot0._goSelectItem, "enhanceItem" .. slot1)
	slot2.anim = slot3:GetComponent(gohelper.Type_Animator)
	slot2.buffIcon = gohelper.findChildSingleImage(slot3, "simage_bufficon")
	slot2.txtName = gohelper.findChildText(slot3, "txt_name")
	slot2.txtDesc = gohelper.findChildText(slot3, "scroll_desc/Viewport/go_desccontent/txt_desc")

	slot0:addClickCb(gohelper.findChildButtonWithAudio(slot3, "btn_select"), slot0.clickBuy, slot0, slot1)

	slot2.btnFresh = gohelper.findChildButtonWithAudio(slot3, "btn_Fresh")

	slot0:addClickCb(slot2.btnFresh, slot0.clickFresh, slot0, slot1)

	slot0.enhanceItemList[slot1] = slot2

	gohelper.setActive(slot3, true)

	return slot2
end

function slot0.clickBuy(slot0, slot1)
	if slot0.selectIndex then
		return
	end

	slot0.selectIndex = slot1

	Activity191Rpc.instance:sendSelect191EnhanceRequest(slot0.actId, slot1, slot0.onSelectEnhance, slot0)
end

function slot0.clickFresh(slot0, slot1)
	if slot0.freshIndex then
		return
	end

	slot0.freshIndex = slot1

	Activity191Rpc.instance:sendFresh191EnhanceRequest(slot0.actId, slot1, slot0.onFreshEnhance, slot0)
end

function slot0.onSelectEnhance(slot0, slot1, slot2)
	if slot2 == 0 then
		if slot0.enhanceItemList[slot0.selectIndex] then
			slot3.anim:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(slot0.delayClose, slot0, 0.67)
	end
end

function slot0.delayClose(slot0)
	slot0.selectIndex = nil

	if not Activity191Controller.instance:checkOpenGetView() then
		Activity191Controller.instance:nextStep()
	end

	slot0:closeThis()
end

function slot0.onFreshEnhance(slot0, slot1, slot2)
	if slot2 == 0 then
		if slot0.freshIndex then
			slot0.enhanceItemList[slot0.freshIndex].anim:Play("switch", 0, 0)
		end

		slot0.nodeDetailMo = Activity191Model.instance:getActInfo():getGameInfo():getNodeDetailMo()

		TaskDispatcher.runDelay(slot0.refreshUI, slot0, 0.16)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.delayClose, slot0)
end

return slot0
