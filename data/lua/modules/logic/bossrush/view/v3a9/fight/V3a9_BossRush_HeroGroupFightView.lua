-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroGroupFightView.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroGroupFightView", package.seeall)

local V3a9_BossRush_HeroGroupFightView = class("V3a9_BossRush_HeroGroupFightView", BaseView)

function V3a9_BossRush_HeroGroupFightView:onInitView()
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "container/btnContain/horizontal/#btn_Start")
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "container/btnContain/horizontal/#drop_herogroup")
	self._btnmodifyname = gohelper.findChildButtonWithAudio(self.viewGO, "container/btnContain/horizontal/#drop_herogroup/#btn_changename")
	self._dropherogrouparrow = gohelper.findChild(self.viewGO, "container/btnContain/horizontal/#drop_herogroup/arrow").transform
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "herogroupcontain/subTitle/txt_TeamLvlS/#btn_Detail")
	self._goDetail = gohelper.findChild(self.viewGO, "herogroupcontain/subTitle/txt_TeamLvlS/#go_Detail")
	self._btnCloseDetail = gohelper.findChildButtonWithAudio(self.viewGO, "herogroupcontain/subTitle/txt_TeamLvlS/#go_Detail/#btn_CloseDetail")
	self._goBonds = gohelper.findChild(self.viewGO, "herogroupcontain/#go_Bonds")
	self._btncloth = gohelper.findChildButtonWithAudio(self.viewGO, "container/btnContain/btnCloth")
	self._txtclothname = gohelper.findChildText(self.viewGO, "container/btnContain/btnCloth/#txt_clothName")
	self._txtclothnameen = gohelper.findChildText(self.viewGO, "container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_HeroGroupFightView:addEvents()
	self._btnstart:AddClickListener(self._onClickStart, self)
	self._btncloth:AddClickListener(self._btnclothOnClock, self)
	self._btnDetail:AddClickListener(self._btnDetailOnClick, self)
	self._btnCloseDetail:AddClickListener(self._btnCloseDetailOnClick, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupName, self._initFightGroupDrop, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, self._onHeroGroupExit, self)
	self:addEventCb(HeroGroupPresetController.instance, HeroGroupPresetEvent.UpdateGroupName, self._onUpdateGroupName, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onModifyHeroGroup, self)
	self:addEventCb(V3a9_BossRushController.instance, V3a9_BossRushEvent.onRefreshExpandBond, self._onRefreshExpandBond, self)
end

function V3a9_BossRush_HeroGroupFightView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btncloth:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnCloseDetail:RemoveClickListener()
end

function V3a9_BossRush_HeroGroupFightView:_btnDetailOnClick()
	self:_showExpandBondsTip(true)
end

function V3a9_BossRush_HeroGroupFightView:_btnCloseDetailOnClick()
	self:_showExpandBondsTip(false)
end

function V3a9_BossRush_HeroGroupFightView:_showExpandBondsTip(isShow)
	gohelper.setActive(self._goDetail, isShow)
end

function V3a9_BossRush_HeroGroupFightView:_btnclothOnClock()
	if self._stageMo:isChallenge() then
		GameFacade.showToast(ToastEnum.BossRushHeroGroupCantEdit)

		return
	end

	local clothUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)

	if clothUnlock or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView, {
			groupModel = V3a9_BossRushModel.instance
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function V3a9_BossRush_HeroGroupFightView:_modifyName()
	local groupId = V3a9_BossRushModel.instance:getHeroGroupSnapshotType()
	local subId = V3a9_BossRushModel.instance:getSelectGroupIndex()
	local param = {
		groupId = groupId,
		subId = subId
	}

	HeroGroupPresetController.instance:openHeroGroupPresetModifyNameView(param)
end

function V3a9_BossRush_HeroGroupFightView:_onUpdateGroupName()
	self:_initFightGroupDrop()
end

function V3a9_BossRush_HeroGroupFightView:_onClickStart()
	self:_enterFight()
end

function V3a9_BossRush_HeroGroupFightView:_enterFight()
	if HeroGroupModel.instance.episodeId then
		self._closeWithEnteringFight = true

		local result = V3a9_BossRushModel.instance:setFightHeroGroup(self._actId)

		if result then
			self.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			local fightParam = FightModel.instance:getFightParam()

			if self._replayMode then
				fightParam.isReplay = true
				fightParam.multiplication = self._multiplication

				DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, self._multiplication, nil, true)
			else
				fightParam.isReplay = false
				fightParam.multiplication = 1

				DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function V3a9_BossRush_HeroGroupFightView:_onModifyHeroGroup()
	self:_refreshCloth()
end

function V3a9_BossRush_HeroGroupFightView:_initFightGroupDrop()
	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if heroGroupType then
		self._dropherogroup.dropDown.enabled = false

		gohelper.setActive(self._btnmodifyname.gameObject, false)
		gohelper.setActive(self._dropherogrouparrow.gameObject, false)

		return
	end
end

function V3a9_BossRush_HeroGroupFightView:_refreshBtns()
	return
end

function V3a9_BossRush_HeroGroupFightView:_onHeroGroupExit()
	self:closeThis()
end

function V3a9_BossRush_HeroGroupFightView:_editableInitView()
	self._expandBondsExpandPanel = MonoHelper.addNoUpdateLuaComOnceToGo(self._goBonds, V3a9_BossRush_ExpandBondsExpandPanel)

	local path = self.viewContainer:getSetting().otherRes[2]
	local itemRes = self.viewContainer:getRes(path)
	local tiproot = gohelper.findChild(self.viewGO, "tipRoot")

	self._expandBondsExpandPanel:setItemRes(itemRes, tiproot)
	self._expandBondsExpandPanel:setParam(14, true)

	self._heroContainAnim = SLFramework.AnimatorPlayer.Get(self._goherogroupcontain)
	self._iconGO = self:getResInst(self.viewContainer:getSetting().otherRes[3], self._btncloth.gameObject)
end

function V3a9_BossRush_HeroGroupFightView:onUpdateParam()
	return
end

function V3a9_BossRush_HeroGroupFightView:PlayCloseAnim(cb, cbObj)
	self._heroContainAnim.enabled = true

	self._heroContainAnim:Play(UIAnimationName.Close, cb, cbObj)
end

function V3a9_BossRush_HeroGroupFightView:onOpen()
	local stage, actId = V3a9_BossRushModel.instance:getEnterActStage()

	self._stage = stage
	self._actId = actId
	self._stageMo = V3a9_BossRushModel.instance:getStageMo(self._actId, self._stage)

	self:_checkEquipClothSkill()
	self:_refreshCloth()
	self:_initFightGroupDrop()
	self:_refreshBtns()
	self:_showExpandBondsTip(false)
	self._expandBondsExpandPanel:onOpen()
end

function V3a9_BossRush_HeroGroupFightView:_onEscapeBtnClick()
	if not self._gomask.gameObject.activeInHierarchy then
		self.viewContainer:_closeCallback()
	end
end

function V3a9_BossRush_HeroGroupFightView:_refreshCloth()
	local clothShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local curGroupMO = V3a9_BossRushModel.instance:getCurGroupMO()
	local cloth_id = curGroupMO.clothId

	cloth_id = PlayerClothModel.instance:getSpEpisodeClothID() or cloth_id

	local clothMO = PlayerClothModel.instance:getById(cloth_id)

	gohelper.setActive(self._txtclothname.gameObject, clothMO)

	if clothMO then
		local clothConfig = lua_cloth.configDict[clothMO.clothId]
		local clothLv = clothMO.level or 0

		self._txtclothname.text = clothConfig.name
		self._txtclothnameen.text = clothConfig.enname
	end

	for _, clothCO in ipairs(lua_cloth.configList) do
		local icon = gohelper.findChild(self._iconGO, tostring(clothCO.id))

		if not gohelper.isNil(icon) then
			gohelper.setActive(icon, clothCO.id == cloth_id)
		end
	end

	gohelper.setActive(self._btncloth.gameObject, true)
end

function V3a9_BossRush_HeroGroupFightView:_checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local curGroupMO = V3a9_BossRushModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(curGroupMO.clothId) then
		return
	end

	local list = PlayerClothModel.instance:getList()

	for _, clothMO in ipairs(list) do
		if PlayerClothModel.instance:hasCloth(clothMO.id) then
			V3a9_BossRushModel.instance:replaceCloth(clothMO.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			V3a9_BossRushController.instance:saveCurGroupData(curGroupMO)

			break
		end
	end
end

function V3a9_BossRush_HeroGroupFightView:_onRefreshExpandBond()
	self._expandBondsExpandPanel:refreshExpandBonds()
end

function V3a9_BossRush_HeroGroupFightView:onClose()
	V3a9_BossRushController.instance:closeExpandBondsTipView()
end

function V3a9_BossRush_HeroGroupFightView:onDestroyView()
	return
end

return V3a9_BossRush_HeroGroupFightView
