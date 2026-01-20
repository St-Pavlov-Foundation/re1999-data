-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem_StartEndImpl.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem_StartEndImpl", package.seeall)

local V3a4_Chg_GameItem_StartEndImpl = class("V3a4_Chg_GameItem_StartEndImpl", V3a4_Chg_GameItem_ObjBase)
local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V3a4_Chg_GameItem_StartEndImpl:ctor(...)
	V3a4_Chg_GameItem_StartEndImpl.super.ctor(self, ...)
end

function V3a4_Chg_GameItem_StartEndImpl:_editableInitView()
	self._Image_Group = gohelper.findChild(self.viewGO, "Image_Group")
	self._Image_GroupTrans = self._Image_Group.transform
	self._numAnimTxt = gohelper.findChildText(self.viewGO, "Num")
	self._numAnimTxtGo = self._numAnimTxt.gameObject
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animator = self._animatorPlayer.animator

	V3a4_Chg_GameItem_StartEndImpl.super._editableInitView(self)

	self._numAnimTxt.text = ""

	self:stopDeltaNumAnim()
end

function V3a4_Chg_GameItem_StartEndImpl:setNum(num)
	self._txtNum.text = num <= 0 and "-" or num
end

function V3a4_Chg_GameItem_StartEndImpl:playDeltaNumAnim(deltaNum)
	gohelper.setActive(self._numAnimTxtGo, true)

	local str = deltaNum > 0 and "+" .. deltaNum or tostring(deltaNum)

	self._numAnimTxt.text = str
end

function V3a4_Chg_GameItem_StartEndImpl:stopDeltaNumAnim()
	gohelper.setActive(self._numAnimTxtGo, false)
end

function V3a4_Chg_GameItem_StartEndImpl:playAnim(name, cb, cbObj)
	self._animator.enabled = true

	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a4_Chg_GameItem_StartEndImpl:playIdleAnim(cb, cbObj)
	self._animator.enabled = true

	self:playAnim(UIAnimationName.Idle, cb, cbObj)
end

function V3a4_Chg_GameItem_StartEndImpl:animatorPlayer()
	return self._animatorPlayer
end

return V3a4_Chg_GameItem_StartEndImpl
