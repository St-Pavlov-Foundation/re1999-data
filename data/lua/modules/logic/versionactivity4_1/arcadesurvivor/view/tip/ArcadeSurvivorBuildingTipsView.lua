-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/tip/ArcadeSurvivorBuildingTipsView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.tip.ArcadeSurvivorBuildingTipsView", package.seeall)

local ArcadeSurvivorBuildingTipsView = class("ArcadeSurvivorBuildingTipsView", ArcadeSurvivorTipsChildViewBase)

function ArcadeSurvivorBuildingTipsView:init(go)
	self.viewGO = go
	self._scrollbuilding = gohelper.findChildScrollRect(self.viewGO, "building/#scroll_building")
	self._gobuildingitem = gohelper.findChild(self.viewGO, "building/#scroll_building/viewport/content/#go_buildingitem")
	self._gobtn = gohelper.findChild(self.viewGO, "building/#scroll_building/viewport/content/#go_btn")
	self._btnenter = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "building/#scroll_building/viewport/content/#go_btn/#btn_enter")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorBuildingTipsView:addEventListeners()
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
end

function ArcadeSurvivorBuildingTipsView:removeEventListeners()
	self._btnenter:RemoveClickListener()
end

function ArcadeSurvivorBuildingTipsView:_btnenterOnClick()
	if self._tipView then
		self._tipView:closeThis()
	end

	ArcadeSurvivorController.instance:enterInteractive(self._buildingId)
end

function ArcadeSurvivorBuildingTipsView:_editableInitView()
	ArcadeSurvivorBuildingTipsView.super._editableInitView(self)

	self._items = self:getUserDataTb_()
	self._txtname = gohelper.findChildText(self._gobuildingitem, "title/txt_name")
	self._txtdec = gohelper.findChildText(self._gobuildingitem, "txt_desc")
end

function ArcadeSurvivorBuildingTipsView:onUpdateMO(mo, tipview)
	self._buildingId = mo.buildingId

	ArcadeSurvivorBuildingTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeSurvivorBuildingTipsView:isPlayOpenAnim()
	return not self._buildingId or self._buildingId ~= self._mo.buildingId or self._isChange
end

function ArcadeSurvivorBuildingTipsView:refreshView()
	local mo = self._buildingId and ArcadeSurvivorHallModel.instance:getInteractiveMO(self._buildingId)

	if not mo then
		return
	end

	local cfg = mo:getCfg()

	self._txtname.text = cfg and cfg.name or ""

	local difficulty = ArcadeSurvivorConfig.instance:getHallUnitDifficulty(self._buildingId)
	local enterViewName = ArcadeSurvivorConfig.instance:getHallUnitEnterViewName(self._buildingId)
	local enterDifficultyView = enterViewName == ViewName.ArcadeSurvivorDifficultyView
	local finishLevelCount = ArcadeSurvivorOutSideModel.instance:getFinishDifficultyCount(difficulty, enterDifficultyView)

	self._txtdec.text = GameUtil.getSubPlaceholderLuaLangOneParam(cfg and cfg.desc or "", finishLevelCount)
end

function ArcadeSurvivorBuildingTipsView:onDestroy()
	return
end

return ArcadeSurvivorBuildingTipsView
