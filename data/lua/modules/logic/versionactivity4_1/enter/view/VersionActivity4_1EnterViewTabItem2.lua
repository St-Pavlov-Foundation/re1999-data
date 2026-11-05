-- chunkname: @modules/logic/versionactivity4_1/enter/view/VersionActivity4_1EnterViewTabItem2.lua

module("modules.logic.versionactivity4_1.enter.view.VersionActivity4_1EnterViewTabItem2", package.seeall)

local VersionActivity4_1EnterViewTabItem2 = class("VersionActivity4_1EnterViewTabItem2", VersionActivity4_1EnterViewTabItemBase)

function VersionActivity4_1EnterViewTabItem2:init(go)
	if gohelper.isNil(go) then
		return
	end

	self.go = go
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)
	self.clickCollider = ZProj.BoxColliderClickListener.Get(go)

	self.clickCollider:SetIgnoreUI(true)

	self.click = gohelper.getClickWithDefaultAudio(self.go)

	self:_editableInitView()
	gohelper.setActive(self.go, true)
end

function VersionActivity4_1EnterViewTabItem2:_editableInitView()
	VersionActivity4_1EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivity4_1EnterViewTabItem2:addEventListeners()
	VersionActivity4_1EnterViewTabItem2.super.addEventListeners(self)
	self.clickCollider:AddMouseUpListener(self.onClickCollider, self)
end

function VersionActivity4_1EnterViewTabItem2:removeEventListeners()
	VersionActivity4_1EnterViewTabItem2.super.removeEventListeners(self)
	self.clickCollider:RemoveMouseUpListener()
end

function VersionActivity4_1EnterViewTabItem2:_getTagPath()
	return "#go_tag"
end

function VersionActivity4_1EnterViewTabItem2:afterSetData()
	VersionActivity4_1EnterViewTabItem2.super.afterSetData(self)

	self.redDotIcon = RedDotController.instance:addRedDot(self.goRedDot, self.activityCo.redDotId, VersionActivity4_1Enum.CharacterActId[self.actId] and self.actId or self.redDotUid)

	local nameStr = self.activityCo and self.activityCo.name or ""
	local nameEnStr = self.activityCo and self.activityCo.nameEn or ""
	local cnWidth = GameUtil.getPreferredWidth(self.txtName, nameStr)
	local enWidth = GameUtil.getPreferredWidth(self.txtName, nameEnStr)
	local width = math.max(cnWidth, enWidth)

	width = math.max(width, 290)
	self.txtName.text = nameStr
	self.txtNameEn.text = nameEnStr

	recthelper.setWidth(self.rectTr, width)
end

function VersionActivity4_1EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity4_1EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)

	local enColor = GameUtil.parseColor(tabSetting.enColor)

	enColor.a = tabSetting.enAlpha or 1
	self.txtNameEn.color = enColor
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

function VersionActivity4_1EnterViewTabItem2:onClickCollider()
	if not self:checkIsTopView() then
		return
	end

	if self._isDrag then
		return
	end

	local posY = recthelper.getAnchorY(self.go.transform)
	local contentPosY = recthelper.getAnchorY(self.go.transform.parent)
	local viewportH = recthelper.getHeight(self.go.transform.parent.parent)
	local deltaY = posY + contentPosY

	if math.abs(deltaY) < viewportH - 160 then
		local targetPosY = viewportH - 160 - 60

		if deltaY < -targetPosY then
			recthelper.setAnchorY(self.go.transform.parent, contentPosY - (deltaY + targetPosY))
		end

		self:onClick()
	end
end

function VersionActivity4_1EnterViewTabItem2:checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]

		return viewName == ViewName.VersionActivity4_1EnterView
	end
end

function VersionActivity4_1EnterViewTabItem2:setDrag(isDrag)
	self._isDrag = isDrag
end

return VersionActivity4_1EnterViewTabItem2
