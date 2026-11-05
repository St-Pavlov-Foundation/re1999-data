-- chunkname: @modules/logic/versionactivity4_1/enter/view/VersionActivity4_1EnterViewTabItem1.lua

module("modules.logic.versionactivity4_1.enter.view.VersionActivity4_1EnterViewTabItem1", package.seeall)

local VersionActivity4_1EnterViewTabItem1 = class("VersionActivity4_1EnterViewTabItem1", VersionActivity4_1EnterViewTabItemBase)

function VersionActivity4_1EnterViewTabItem1:init(go)
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

function VersionActivity4_1EnterViewTabItem1:_getTagPath()
	return "#go_tag"
end

function VersionActivity4_1EnterViewTabItem1:addEventListeners()
	VersionActivity4_1EnterViewTabItem1.super.addEventListeners(self)
	self.clickCollider:AddMouseUpListener(self.onClickCollider, self)
end

function VersionActivity4_1EnterViewTabItem1:removeEventListeners()
	VersionActivity4_1EnterViewTabItem1.super.removeEventListeners(self)
	self.clickCollider:RemoveMouseUpListener()
end

function VersionActivity4_1EnterViewTabItem1:onClickCollider()
	if not self:checkIsTopView() then
		return
	end

	if self._isDrag then
		return
	end

	self:onClick()
end

function VersionActivity4_1EnterViewTabItem1:checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]

		return viewName == ViewName.VersionActivity4_1EnterView
	end
end

function VersionActivity4_1EnterViewTabItem1:onClick()
	VersionActivity4_1EnterViewTabItem1.super.onClick(self)

	if self.isSelect then
		return
	end

	if self.actId == VersionActivity4_1Enum.ActivityId.Dungeon then
		self._audioId = AudioMgr.instance:trigger(AudioEnum4_1.VersionActivity4_1.play_ui_shiji_4_1_open_2)
	end
end

function VersionActivity4_1EnterViewTabItem1:setDrag(isDrag)
	self._isDrag = isDrag
end

return VersionActivity4_1EnterViewTabItem1
