-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorHallEntity.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorHallEntity", package.seeall)

local ArcadeSurvivorHallEntity = class("ArcadeSurvivorHallEntity", LuaCompBase)

function ArcadeSurvivorHallEntity:initEntity(go, mo, loader)
	self.go = go
	self.trans = self.go.transform
	self.mo = mo
	self._posList = {}
	self.root = gohelper.findChild(go, "ani/scale")

	self:refreshPosition()
	self:_refreshTrans()

	self.loader = loader

	self:initComponents()
end

function ArcadeSurvivorHallEntity:refreshEntity(mo)
	self.mo = mo

	self:refreshPosition()
end

function ArcadeSurvivorHallEntity:initComponents()
	self:_clearComps()
	self:_addComp("effectComp", ArcadeSurvivorHallEntityEffectComp, true)
end

function ArcadeSurvivorHallEntity:_clearComps()
	if self._compList then
		for _, comp in ipairs(self._compList) do
			comp:clear()
		end
	end

	self._compList = {}
end

function ArcadeSurvivorHallEntity:_addComp(compName, compClass, useNewGO)
	local go = self.go

	if useNewGO then
		go = gohelper.findChild(self.go, compName)
		go = go or gohelper.create3d(self.go, compName)
	end

	local compInst = MonoHelper.addNoUpdateLuaComOnceToGo(go, compClass, {
		entity = self,
		compName = compName,
		loader = self.loader
	})

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function ArcadeSurvivorHallEntity:_refreshTrans()
	local mo = self:getMO()

	if not mo then
		return
	end

	local co = mo:getCfg()
	local x = co.posOffset and tonumber(co.posOffset[1])
	local y = co.posOffset and tonumber(co.posOffset[2])

	if x and y then
		transformhelper.setLocalPos(self.root.transform, x, y, mo:getPosZ())
	end

	local scaleX = 1.5
	local scaleY = 1.5

	if co.scale then
		scaleX = tonumber(co.scale[1]) or scaleX
		scaleY = tonumber(co.scale[2]) or scaleY
	end

	transformhelper.setLocalScale(self.root.transform, scaleX, scaleY, 1)
end

function ArcadeSurvivorHallEntity:showEntity(isShow)
	gohelper.setActive(self.go, isShow)
end

function ArcadeSurvivorHallEntity:isShowEntity()
	return self.go.activeSelf
end

function ArcadeSurvivorHallEntity:refreshPosition()
	if self._tweenIdMove then
		ZProj.TweenHelper.KillById(self._tweenIdMove)

		self._tweenIdMove = nil
	end

	self._posList = {}

	local mo = self:getMO()

	if not mo then
		return
	end

	local posX, posY = mo:getEntityPos()

	transformhelper.setLocalPos(self.trans, posX, posY, mo:getPosZ())

	self._gridX, self._gridY = mo:getGridPos()
end

function ArcadeSurvivorHallEntity:doMove(callback, callbackObj)
	local mo = self:getMO()

	if not mo then
		return
	end

	local posX, posY = mo:getEntityPos()
	local _posX, _posY = transformhelper.getLocalPos(self.trans)

	if _posX == posX and _posY == posY then
		callback(callbackObj)

		return
	end

	self._finishMoveCb = callback
	self._finishMoveCbObj = callbackObj

	self:_onMove({
		x = posX,
		y = posY
	})
end

function ArcadeSurvivorHallEntity:_onMove(pos)
	local pos1 = self._posList[1]

	if not pos1 or pos1.x ~= pos.x or pos1.y ~= pos.y then
		table.insert(self._posList, 1, pos)
	end

	if #self._posList == 1 then
		self:_onMoveCB(pos)
	end
end

function ArcadeSurvivorHallEntity:_onMoveCB(pos)
	local posX, posY = pos.x, pos.y

	self._tweenIdMove = ZProj.TweenHelper.DOLocalMove(self.trans, posX, posY, self.mo:getPosZ(), ArcadeSurvivorEnum.Const.HeroMoveSpeed, self._onFinishMoveCB, self, nil, EaseType.OutExpo)

	self:playMoveAni()
	self:_setRotation()

	local mo = self:getMO()

	self._gridX, self._gridY = mo:getGridPos()
end

function ArcadeSurvivorHallEntity:_onFinishMoveCB()
	local index = #self._posList

	if index > 0 then
		table.remove(self._posList, index)
	end

	index = #self._posList

	if index == 0 then
		if self._finishMoveCb and self._finishMoveCbObj then
			self._finishMoveCb(self._finishMoveCbObj)
		end

		return
	end

	local pos = self._posList[index]

	self:_onMoveCB(pos)
end

function ArcadeSurvivorHallEntity:_setRotation()
	local mo = self:getMO()
	local gridX, gridY = mo:getGridPos()

	if not self._gridX or not self._gridY then
		self._gridX, self._gridY = mo:getGridPos()
	end

	if gridX < self._gridX then
		transformhelper.setLocalRotation(self.trans, 0, 0, 0)
	elseif gridX > self._gridX then
		transformhelper.setLocalRotation(self.trans, 0, 180, 0)
	end
end

function ArcadeSurvivorHallEntity:getWorldPos()
	return self.trans.position
end

function ArcadeSurvivorHallEntity:getMO()
	return self.mo
end

function ArcadeSurvivorHallEntity:playBornAni()
	local showIds = ArcadeSurvivorConfig.instance:getActionShowIdList(ArcadeSurvivorEnum.ActionShowId.Born)

	self:_playAnim(showIds, 1)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_transmit)
end

function ArcadeSurvivorHallEntity:playMoveAni()
	local cfg = ArcadeSurvivorConfig.instance:getActionShowCfg(ArcadeSurvivorEnum.ActionShowId.Move)

	if not cfg then
		return
	end

	local showIds = cfg.showIds

	if showIds then
		self:_playAnim(showIds, 1)
	end

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_move)
end

function ArcadeSurvivorHallEntity:playIdleAnim()
	local showId = ArcadeSurvivorConfig.instance:getStateShowShowId(ArcadeSurvivorEnum.StateShowId.Idle)

	self:_playShow(showId, true)
end

function ArcadeSurvivorHallEntity:_playAnim(list, index)
	if index > #list then
		self:playIdleAnim()

		return
	end

	local effectId = list[index]

	self:_playShow(effectId, false, function()
		self:_playAnim(list, index + 1)
	end, self)
end

function ArcadeSurvivorHallEntity:_playShow(showId, isIdle, callback, callbackObj)
	local cfg = ArcadeSurvivorConfig.instance:getShowCfg(showId)

	if self.effectComp then
		self.effectComp:playShow(showId)
	end

	local animName = cfg.triggerAnimation

	if string.nilorempty(animName) then
		return
	end

	if isIdle then
		self:_playAnimator(animName)
	else
		self:_playAnimatorPlayer(cfg.triggerAnimation, callback, callbackObj)
	end
end

function ArcadeSurvivorHallEntity:_playAnimatorPlayer(animName, callback, callbackObj)
	if not self._animPlayer then
		self._animPlayer = SLFramework.AnimatorPlayer.Get(self.go)
	end

	self._animPlayer:Play(animName, callback, callbackObj)
end

function ArcadeSurvivorHallEntity:_playAnimator(animName)
	if not self._anim then
		self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	end

	self._anim.enabled = true

	self._anim:Play(animName, 0, 0)
end

function ArcadeSurvivorHallEntity:clear()
	if self._tweenIdMove then
		ZProj.TweenHelper.KillById(self._tweenIdMove)

		self._tweenIdMove = nil
	end

	self._posList = {}
end

function ArcadeSurvivorHallEntity:onDestroy()
	self:clear()
	self:_clearComps()
end

return ArcadeSurvivorHallEntity
