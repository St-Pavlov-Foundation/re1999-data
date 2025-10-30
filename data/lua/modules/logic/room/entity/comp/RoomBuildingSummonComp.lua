﻿-- chunkname: @modules/logic/room/entity/comp/RoomBuildingSummonComp.lua

module("modules.logic.room.entity.comp.RoomBuildingSummonComp", package.seeall)

local RoomBuildingSummonComp = class("RoomBuildingSummonComp", LuaCompBase)

function RoomBuildingSummonComp:ctor(entity)
	self.entity = entity
end

function RoomBuildingSummonComp:init(go)
	self.go = go
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomBuildingSummonComp:addEventListeners()
	self:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummonAnim, self._onStartSummonAnim, self)
	self:addEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, self._onDragEnd, self)
	self:addEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, self._onSummonSkip, self)
	self:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, self._onCloseGetCritter, self)
end

function RoomBuildingSummonComp:removeEventListeners()
	self:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummonAnim, self._onStartSummonAnim, self)
	self:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, self._onDragEnd, self)
	self:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, self._onSummonSkip, self)
	self:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, self._onCloseGetCritter, self)
end

function RoomBuildingSummonComp:onStart()
	return
end

function RoomBuildingSummonComp:getMO()
	return self.entity:getMO()
end

function RoomBuildingSummonComp:getBuildingGOAnimatorPlayer()
	if not self._buildingGOAnimatorPlayer then
		self._buildingGOAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self.entity:getBuildingGO())
	end

	return self._buildingGOAnimatorPlayer
end

function RoomBuildingSummonComp:getBuildingGOAnimator()
	if not self._buildingGOAnimator then
		self._buildingGOAnimator = self.entity:getBuildingGO():GetComponent(typeof(UnityEngine.Animator))
	end

	return self._buildingGOAnimator
end

function RoomBuildingSummonComp:_onStartSummonAnim(param)
	local mode = param.mode

	self.mode = mode

	local animator = self:getBuildingGOAnimatorPlayer()
	local animKeys = RoomSummonEnum.SummonMode[mode].EntityAnimKey

	local function canDrag()
		CritterSummonController.instance:onCanDrag()
	end

	if animKeys and animator then
		if mode == RoomSummonEnum.SummonType.Incubate then
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan2)
		end

		animator:Play(animKeys.operatePre, canDrag, self)
	else
		canDrag()
	end
end

function RoomBuildingSummonComp:_onDragEnd(mode, rare)
	local animator = self:getBuildingGOAnimatorPlayer()
	local animKeys = RoomSummonEnum.SummonMode[mode].EntityAnimKey

	local function finishCB()
		CritterSummonController.instance:onFinishSummonAnim(mode)
	end

	if animKeys and animator then
		local function rareAnim()
			if animator then
				animator:Play(animKeys.rare[rare], finishCB, self)
			else
				finishCB()
			end
		end

		animator:Play(animKeys.operateEnd, rareAnim, self)
	else
		finishCB()
	end
end

function RoomBuildingSummonComp:_onSummonSkip()
	local animator = self:getBuildingGOAnimator()
	local animKeys = RoomSummonEnum.SummonMode[self.mode].EntityAnimKey

	animator:Play(animKeys.operateEnd, 0, 1)
end

function RoomBuildingSummonComp:_onCloseGetCritter()
	if RoomSummonEnum.SummonType then
		for _, mode in pairs(RoomSummonEnum.SummonType) do
			if RoomSummonEnum.SummonMode[mode] then
				self:_activeEggRoot(mode, false)
			end
		end
	end
end

function RoomBuildingSummonComp:_activeEggRoot(mode, isActive)
	local eggRoot = self:_getEggRoot(mode)

	if eggRoot then
		gohelper.setActive(eggRoot, isActive)
	end
end

function RoomBuildingSummonComp:_getEggRoot(mode)
	local eggPath = RoomSummonEnum.SummonMode[mode].EggRoot

	if not self._eggRoot then
		self._eggRoot = self:getUserDataTb_()
	end

	if eggPath then
		local go = self.entity:getBuildingGO()

		self._eggRoot[mode] = gohelper.findChild(go, eggPath)

		return self._eggRoot[mode]
	end
end

return RoomBuildingSummonComp
