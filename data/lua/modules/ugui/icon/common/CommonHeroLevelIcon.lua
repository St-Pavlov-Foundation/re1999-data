-- chunkname: @modules/ugui/icon/common/CommonHeroLevelIcon.lua

module("modules.ugui.icon.common.CommonHeroLevelIcon", package.seeall)

local CommonHeroLevelIcon = class("CommonHeroLevelIcon", LuaCompBase)

function CommonHeroLevelIcon:init(go)
	self.go = go
	self.viewGO = go

	self:onInitView()
end

CommonHeroLevelIcon.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function CommonHeroLevelIcon:onInitView()
	self.transform = self.viewGO.transform
	self._gorole = gohelper.findChild(self.viewGO, "#go_role")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#go_role/#image_rare")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "#go_role/#simage_heroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "#go_role/#image_career")
	self._goexskill = gohelper.findChild(self.viewGO, "#go_role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "#go_role/#go_exskill/#image_exskill")
	self._gorank = gohelper.findChild(self.viewGO, "#go_role/#go_rank")
	self._txtlv = gohelper.findChildText(self.viewGO, "#go_role/#txt_lv")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")

	local clickarea = gohelper.findChild(self.viewGO, "go_click")

	self._btnclick = SLFramework.UGUI.UIClickListener.Get(clickarea)
	self._isShowLevel = true
	self._isShowRank = true
	self._isShowExSkill = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonHeroLevelIcon:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CommonHeroLevelIcon:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function CommonHeroLevelIcon:_btnclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self._clickCb then
		if self._clickCbObj then
			self._clickCb(self._clickCbObj, self._mo)
		else
			self._clickCb(self._mo)
		end
	end
end

function CommonHeroLevelIcon:onUpdateMO(mo)
	self._mo = mo

	self:_refreshHero()
end

function CommonHeroLevelIcon:_refreshHero()
	local heroConfig = HeroConfig.instance:getHeroCO(self._mo.heroId)
	local skinConfig = SkinConfig.instance:getSkinCo(self._mo.skin)

	self._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(heroConfig.career))
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "equipbar" .. CharacterEnum.Color[heroConfig.rare])
	self:_showLevel()
	self:_showRank()
	self:_showExSkill()
end

function CommonHeroLevelIcon:setClickCallback(cb, cbobj)
	self._clickCb = cb
	self._clickCbObj = cbobj
end

function CommonHeroLevelIcon:setShowLevel(isShow)
	self._isShowLevel = isShow

	self:_showLevel()
end

function CommonHeroLevelIcon:_showLevel()
	local isShow = self._isShowLevel

	gohelper.setActive(self._txtlv, isShow)

	if isShow and self._mo then
		local level = self._mo.level or 1
		local showLevel = HeroConfig.instance:getShowLevel(level)

		if self._txtlv then
			self._txtlv.text = "Lv." .. showLevel
		end
	end
end

function CommonHeroLevelIcon:setShowRank(isShow)
	self._isShowRank = isShow

	self:_showRank()
end

function CommonHeroLevelIcon:_showRank()
	local isShow = self._isShowRank
	local tmpRank = self._mo.rank and tonumber(self._mo.rank) or 0

	tmpRank = tmpRank - 1

	gohelper.setActive(self._gorank, isShow and tmpRank > 0)

	if isShow and self._mo and tmpRank > 0 then
		if not self._goRankIconTab then
			self._goRankIconTab = self:getUserDataTb_()

			for i = 1, 10 do
				local goRankIcon = gohelper.findChild(self._gorank, "rank" .. i)

				if gohelper.isNil(goRankIcon) then
					break
				end

				self._goRankIconTab[i] = goRankIcon
			end
		end

		for i, goRankIcon in pairs(self._goRankIconTab) do
			gohelper.setActive(goRankIcon, i == tmpRank)
		end
	end
end

function CommonHeroLevelIcon:setShowExSkill(isShow)
	self._isShowExSkill = isShow
end

function CommonHeroLevelIcon:_showExSkill()
	local isShow = self._isShowExSkill

	gohelper.setActive(self._goexskill, isShow)

	if isShow and self._mo then
		local exSkillLevel = self._mo.exSkillLevel or 0

		if exSkillLevel <= 0 then
			gohelper.setActive(self._goexskill, false)

			return
		end

		self._imageexskill.fillAmount = CommonHeroLevelIcon.exSkillFillAmount[exSkillLevel] or 1
	end
end

function CommonHeroLevelIcon:onDestroy()
	self._simageheroicon:UnLoadImage()

	self._clickCb = nil
	self._clickCbObj = nil
end

return CommonHeroLevelIcon
