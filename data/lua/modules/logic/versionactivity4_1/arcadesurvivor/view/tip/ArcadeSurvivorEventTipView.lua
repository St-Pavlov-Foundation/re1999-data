-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/tip/ArcadeSurvivorEventTipView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.tip.ArcadeSurvivorEventTipView", package.seeall)

local ArcadeSurvivorEventTipView = class("ArcadeSurvivorEventTipView", ArcadeSurvivorTipsChildViewBase)

function ArcadeSurvivorEventTipView:init(go)
	self.viewGO = go
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_Name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "txt_Scroll/Viewport/content/#txt_Desc")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorEventTipView:addEvents()
	return
end

function ArcadeSurvivorEventTipView:removeEvents()
	return
end

function ArcadeSurvivorEventTipView:onUpdateMO(mo, tipview)
	self._showNewEvent = self._eventId ~= mo.eventId
	self._eventId = mo.eventId

	ArcadeSurvivorEventTipView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeSurvivorEventTipView:refreshView()
	local icon = ArcadeSurvivorConfig.instance:getEventPopupImage(self._eventId)

	if not string.nilorempty(icon) then
		self._simageicon:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
	end

	self._txttitle.text = ArcadeSurvivorConfig.instance:getEventTitle(self._eventId)
	self._txtdesc.text = ArcadeSurvivorConfig.instance:getEventDesc(self._eventId)
end

function ArcadeSurvivorEventTipView:isPlayOpenAnim()
	return self._showNewEvent or self._isChange
end

function ArcadeSurvivorEventTipView:onDestroy()
	self._simageicon:UnLoadImage()
end

return ArcadeSurvivorEventTipView
