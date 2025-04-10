module("modules.logic.versionactivity2_7.act191.view.Act191EnhanceTipView", package.seeall)

slot0 = class("Act191EnhanceTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._goRoot = gohelper.findChild(slot0.viewGO, "#go_Root")
	slot0._simageIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_Root/#simage_Icon")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "#go_Root/#txt_Name")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#go_Root/scroll_desc/Viewport/go_desccontent/#txt_Desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._onEscBtnClick(slot0)
	slot0:closeThis()

	if ViewMgr.instance:isOpen(ViewName.Act191InfoView) then
		ViewMgr.instance:closeView(ViewName.Act191InfoView)
	end
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)

	slot0.actId = Activity191Model.instance:getCurActId()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._btnClose, not slot0.viewParam.notShowBg)

	if slot0.viewParam.pos then
		recthelper.setAnchor(slot0._goRoot.transform, slot1.x, slot1.y)
	end

	if slot0.viewParam.co then
		slot0._simageIcon:LoadImage(ResUrl.getAct174BuffIcon(slot2.icon))

		slot0._txtName.text = slot2.name
		slot0._txtDesc.text = slot2.desc

		if lua_activity191_effect.configDict[tonumber(slot2.effects)] then
			if slot5.type == Activity191Enum.EffectType.EnhanceHero then
				slot0._txtDesc.text = Activity191Helper.buildDesc(SkillHelper.addLink(slot2.desc), Activity191Enum.HyperLinkPattern.EnhanceDestiny, slot5.typeParam)

				SkillHelper.addHyperLinkClick(slot0._txtDesc, Activity191Helper.clickHyperLinkDestiny)
			elseif slot5.type == Activity191Enum.EffectType.EnhanceItem then
				slot0._txtDesc.text = Activity191Helper.buildDesc(slot3, Activity191Enum.HyperLinkPattern.EnhanceItem, slot5.typeParam .. "#")

				SkillHelper.addHyperLinkClick(slot0._txtDesc, Activity191Helper.clickHyperLinkItem)
			else
				slot0._txtDesc.text = slot3
			end
		else
			slot0._txtDesc.text = slot3
		end
	end
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

return slot0
