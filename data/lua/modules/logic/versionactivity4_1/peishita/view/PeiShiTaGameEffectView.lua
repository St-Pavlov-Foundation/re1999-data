-- chunkname: @modules/logic/versionactivity4_1/peishita/view/PeiShiTaGameEffectView.lua

module("modules.logic.versionactivity4_1.peishita.view.PeiShiTaGameEffectView", package.seeall)

local PeiShiTaGameEffectView = class("PeiShiTaGameEffectView", BaseView)

function PeiShiTaGameEffectView:onInitView()
	self._goEffectInstanceRoot = gohelper.findChild(self.viewGO, "#go_UnitRoot/#go_EffectInstanceRoot")
	self._goHitEffect = gohelper.findChild(self.viewGO, "#go_UnitRoot/#go_EffectInstanceRoot/#go_HitEffect")
	self._goArchery = gohelper.findChild(self.viewGO, "#go_UnitRoot/#go_EffectInstanceRoot/#go_Archery")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeiShiTaGameEffectView:_editableInitView()
	gohelper.setActive(self._goHitEffect, false)
	gohelper.setActive(self._goArchery, false)

	self._tranArchery = self._goArchery.transform
end

function PeiShiTaGameEffectView:addEvents()
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitRemove, self._onUnitRemove, self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnArcheryEffect, self._onArcheryEffect, self)
end

function PeiShiTaGameEffectView:removeEvents()
	return
end

function PeiShiTaGameEffectView:onOpen()
	return
end

function PeiShiTaGameEffectView:_onUnitRemove(unit)
	if not unit then
		return
	end

	self:_playHitEffect(unit)
end

function PeiShiTaGameEffectView:_playHitEffect(unit)
	if unit.config.type == PeiShiTaEnum.UnitType.Drop or unit.config.type == PeiShiTaEnum.UnitType.Obstacle then
		return
	end

	gohelper.setActive(self._goHitEffect, true)

	local localX, localY = PeiShiTaGameHelper.gridToLocalPos(unit.pos.x, unit.pos.y)

	recthelper.setAnchor(self._goHitEffect.transform, localX, localY)
	AudioMgr.instance:trigger(AudioEnum4_1.PeiShiTa.play_ui_atlantis_hunter_attack)
	TaskDispatcher.cancelTask(self._hideHitEffect, self)
	TaskDispatcher.runDelay(self._hideHitEffect, self, 0.5)
end

function PeiShiTaGameEffectView:_hideHitEffect()
	gohelper.setActive(self._goHitEffect, false)
end

function PeiShiTaGameEffectView:_onArcheryEffect(startX, startY, targetX, targetY)
	gohelper.setActive(self._goArchery, true)

	local dx = targetX - startX
	local dy = targetY - startY
	local angle = math.deg(math.atan2(-dy, dx))

	transformhelper.setLocalRotation(self._tranArchery, 0, 0, angle)
	GameUtil.onDestroyViewMember_TweenId(self, "_archeryTweenId")

	local playerLocalX, playerLocalY = PeiShiTaGameHelper.gridToLocalPos(startX, startY)
	local targetLocalX, targetLocalY = PeiShiTaGameHelper.gridToLocalPos(targetX, targetY)

	recthelper.setAnchor(self._tranArchery, playerLocalX, playerLocalY)
	AudioMgr.instance:trigger(AudioEnum4_1.PeiShiTa.play_ui_atlantis_archery)

	self._archeryTweenId = ZProj.TweenHelper.DOAnchorPos(self._tranArchery, targetLocalX, targetLocalY, PeiShiTaEnum.ConstValue.ActorArcheryAnimTime, self._onPlayArcheryEffectDone, self)
end

function PeiShiTaGameEffectView:_onPlayArcheryEffectDone()
	gohelper.setActive(self._goArchery, false)
	PeiShiTaGameController.instance:dispatchEvent(PeiShiTaEvent.OnArcheryAnimDone)
end

function PeiShiTaGameEffectView:onClose()
	return
end

function PeiShiTaGameEffectView:onDestroyView()
	TaskDispatcher.cancelTask(self._hideHitEffect, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_archeryTweenId")
end

return PeiShiTaGameEffectView
