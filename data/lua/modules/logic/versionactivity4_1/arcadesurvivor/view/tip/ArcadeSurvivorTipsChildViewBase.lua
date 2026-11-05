-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/tip/ArcadeSurvivorTipsChildViewBase.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.tip.ArcadeSurvivorTipsChildViewBase", package.seeall)

local ArcadeSurvivorTipsChildViewBase = class("ArcadeSurvivorTipsChildViewBase", LuaCompBase)

function ArcadeSurvivorTipsChildViewBase:init(go)
	self.viewGO = go
end

function ArcadeSurvivorTipsChildViewBase:addEventListeners()
	return
end

function ArcadeSurvivorTipsChildViewBase:removeEventListeners()
	return
end

function ArcadeSurvivorTipsChildViewBase:_editableInitView()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
end

function ArcadeSurvivorTipsChildViewBase:showView(isShow)
	self._isChange = self.viewGO.activeSelf ~= isShow

	gohelper.setActive(self.viewGO, isShow)
end

function ArcadeSurvivorTipsChildViewBase:onUpdateMO(mo, tipview)
	self._mo = mo

	if self:isPlayOpenAnim() then
		self._animPlayer:Play(UIAnimationName.Open, nil, nil)
		AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_tips_open)
	end

	self._tipView = tipview

	self:refreshView()
end

function ArcadeSurvivorTipsChildViewBase:isPlayOpenAnim()
	return true
end

function ArcadeSurvivorTipsChildViewBase:playCloseAnim(callback, callbackObj)
	self._animPlayer:Play(UIAnimationName.Close, callback, callbackObj)
end

function ArcadeSurvivorTipsChildViewBase:refreshView()
	return
end

function ArcadeSurvivorTipsChildViewBase:setAnchor(mo, x, y)
	recthelper.setAnchor(self.viewGO.transform, x, y)
end

function ArcadeSurvivorTipsChildViewBase:onDestroy()
	return
end

return ArcadeSurvivorTipsChildViewBase
