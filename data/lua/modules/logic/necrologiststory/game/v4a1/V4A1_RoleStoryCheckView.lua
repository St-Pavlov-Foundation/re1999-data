-- chunkname: @modules/logic/necrologiststory/game/v4a1/V4A1_RoleStoryCheckView.lua

module("modules.logic.necrologiststory.game.v4a1.V4A1_RoleStoryCheckView", package.seeall)

local V4A1_RoleStoryCheckView = class("V4A1_RoleStoryCheckView", BaseView)

function V4A1_RoleStoryCheckView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/mask")
	self.goSuccess = gohelper.findChild(self.viewGO, "root/result/success")
	self.goFail = gohelper.findChild(self.viewGO, "root/result/fail")
	self.txtNum = gohelper.findChildTextMesh(self.viewGO, "root/result/txt_num")
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	self.goTouzi = gohelper.findChild(self.viewGO, "root/guochang/touzi")
	self.touziData = {
		{
			-34,
			51,
			-122
		},
		{
			-236,
			-21,
			-161
		},
		{
			174,
			-69,
			-97
		},
		{
			118,
			-227,
			-236
		},
		{
			191,
			-195,
			-4
		},
		{
			237,
			-83,
			157
		},
		{
			104,
			45,
			-138
		},
		{
			217,
			113,
			-101
		},
		{
			161,
			175,
			-256
		},
		{
			205,
			87,
			29
		},
		{
			160,
			61,
			42
		},
		{
			128,
			-19,
			100
		},
		{
			128,
			-20,
			12
		},
		{
			235,
			155,
			-7
		},
		{
			172,
			133,
			144
		},
		{
			139,
			216,
			84
		},
		{
			167,
			-16,
			189
		},
		{
			162,
			-20,
			23
		},
		{
			248,
			-83,
			-21
		},
		{
			246,
			280,
			14
		}
	}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4A1_RoleStoryCheckView:addEvents()
	self.animEvent:AddEventListener("finish", self.onAnimFinished, self)
	self:addClickCb(self.btnClose, self.onClickClose, self)
end

function V4A1_RoleStoryCheckView:removeEvents()
	self.animEvent:RemoveAllEventListener()
	self:removeClickCb(self.btnClose)
end

function V4A1_RoleStoryCheckView:_editableInitView()
	return
end

function V4A1_RoleStoryCheckView:onAnimFinished()
	if self.isFinished then
		return
	end

	self.isFinished = true

	if self.isSuccess then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_pkls_challenge_fail)
	end
end

function V4A1_RoleStoryCheckView:onClickClose()
	if not self.isFinished then
		self.anim:Play(self.isSuccess and "succeed" or "fail")
		self:onAnimFinished()

		return
	end

	self:closeThis()
end

function V4A1_RoleStoryCheckView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_mln_no_effect)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_alf_yishi_dice_rotate)
	self:refreshParam()
	self:refreshView()
end

function V4A1_RoleStoryCheckView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V4A1_RoleStoryCheckView:refreshParam()
	local viewParam = self.viewParam or {}

	self.randomVal = viewParam.randomVal
	self.addVal = viewParam.addVal
	self.isSuccess = viewParam.isSuccess
end

function V4A1_RoleStoryCheckView:refreshView()
	gohelper.setActive(self.goSuccess, self.isSuccess)
	gohelper.setActive(self.goFail, not self.isSuccess)

	self.txtNum.text = string.format("%+d", self.addVal)

	self.anim:SetBool("isSuccess", self.isSuccess)

	local data = self.touziData[self.randomVal]

	if data then
		transformhelper.setLocalRotation(self.goTouzi.transform, data[1], data[2], data[3])
	end
end

function V4A1_RoleStoryCheckView:onClose()
	return
end

function V4A1_RoleStoryCheckView:onDestroyView()
	return
end

return V4A1_RoleStoryCheckView
