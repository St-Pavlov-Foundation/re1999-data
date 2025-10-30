﻿-- chunkname: @modules/logic/fight/view/preview/SkillEditorCharacterSkinSelectView.lua

module("modules.logic.fight.view.preview.SkillEditorCharacterSkinSelectView", package.seeall)

local SkillEditorCharacterSkinSelectView = class("SkillEditorCharacterSkinSelectView", BaseView)

function SkillEditorCharacterSkinSelectView:ctor()
	return
end

function SkillEditorCharacterSkinSelectView:onInitView()
	self._actionViewGO = gohelper.findChild(self.viewGO, "selectSkin")
	self._itemGOParent = gohelper.findChild(self.viewGO, "selectSkin/scroll/content")
	self._itemGOPrefab = gohelper.findChild(self.viewGO, "selectSkin/scroll/item")
	self._btnselectSkinID = gohelper.findChildButton(self.viewGO, "scene/Grid/btnSelectSkin")
end

function SkillEditorCharacterSkinSelectView:addEvents()
	SLFramework.UGUI.UIClickListener.Get(self._actionViewGO):AddClickListener(self._hideThis, self)
	self:addClickCb(self._btnselectSkinID, self._showThis, self)
end

function SkillEditorCharacterSkinSelectView:removeEvents()
	SLFramework.UGUI.UIClickListener.Get(self._actionViewGO):RemoveClickListener()
end

function SkillEditorCharacterSkinSelectView:onOpen()
	return
end

function SkillEditorCharacterSkinSelectView:_hideThis()
	gohelper.setActive(self._actionViewGO, false)
end

function SkillEditorCharacterSkinSelectView:_showThis()
	gohelper.setActive(self._actionViewGO, true)

	local scene = GameSceneMgr.instance:getCurScene()

	if SkillEditorMgr.instance.cur_select_entity_id then
		self._attacker = scene.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		self._attacker = scene.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if not self._attacker then
		logError("所选对象错误，请从新选择对象")

		return
	end

	self.entity_mo = self._attacker:getMO()

	local skin_list = SkinConfig.instance:getCharacterSkinCoList(self.entity_mo.modelId) or {}

	gohelper.CreateObjList(self, self.OnItemShow, skin_list, self._itemGOParent, self._itemGOPrefab)

	if #skin_list == 0 then
		logError("所选对象没有可选皮肤")
		self:_hideThis()
	end
end

function SkillEditorCharacterSkinSelectView:OnItemShow(obj, data, index)
	local transform = obj.transform
	local text = transform:Find("Text"):GetComponent(gohelper.Type_TextMesh)

	text.text = data.name

	local obj_button = obj:GetComponent(typeof(SLFramework.UGUI.ButtonWrap))

	self:removeClickCb(obj_button)
	self:addClickCb(obj_button, self.OnItemClick, self, data)
end

function SkillEditorCharacterSkinSelectView:OnItemClick(config)
	local side = SkillEditorMgr.instance.cur_select_side
	local _type, info = SkillEditorMgr.instance:getTypeInfo(side)

	info.skinIds[self.entity_mo.position] = config.id

	SkillEditorMgr.instance:setTypeInfo(side, _type, info.ids, info.skinIds, info.groupId)

	local tag = side == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	local tar_entity = entityMgr:getEntity(self._attacker.id)

	if tar_entity.skill then
		tar_entity.skill:stopSkill()
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, tar_entity.id)
	entityMgr:removeUnit(tag, self._attacker.id)

	self.entity_mo.skin = config.id

	if FightDataHelper.entityMgr:isSub(self.entity_mo.id) then
		entityMgr:buildSubSpine(self.entity_mo)
	else
		entityMgr:buildSpine(self.entity_mo)
	end
end

return SkillEditorCharacterSkinSelectView
