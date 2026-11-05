-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/ArcadeSurvivorController.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.ArcadeSurvivorController", package.seeall)

local ArcadeSurvivorController = class("ArcadeSurvivorController", BaseController)

function ArcadeSurvivorController:onInit()
	self:reInit()
end

function ArcadeSurvivorController:onInitFinish()
	return
end

function ArcadeSurvivorController:addConstEvents()
	return
end

function ArcadeSurvivorController:reInit()
	return
end

function ArcadeSurvivorController:openHallView()
	local isActOpen = ArcadeSurvivorModel.instance:isAct247Open(true)

	if not isActOpen then
		return
	end

	ArcadeSurvivorHallModel.instance:initInteractiveMODict()
	ArcadeSurvivorRpc.instance:sendArcadeSurvivorGetOutsideInfoRequest(self._openHallViewReally, self)
end

function ArcadeSurvivorController:_openHallViewReally()
	ArcadeSurvivorHallModel.instance:refreshInteractiveReddot()
	ViewMgr.instance:openView(ViewName.ArcadeSurvivorHallView)
end

function ArcadeSurvivorController:openTipView(type, param)
	param = param or {}
	param.tipType = type

	ViewMgr.instance:openView(ViewName.ArcadeSurvivorTipsView, param)
end

function ArcadeSurvivorController:openQuitTipView()
	ViewMgr.instance:openView(ViewName.ArcadeSurvivorQuitTipView)
end

function ArcadeSurvivorController:closeTipView()
	local tipViewName = ViewName.ArcadeSurvivorTipsView
	local isOpen = ViewMgr.instance:isOpen(tipViewName)

	if isOpen then
		ViewMgr.instance:closeView(tipViewName)
	end
end

function ArcadeSurvivorController:closeGameView()
	ViewMgr.instance:closeView(ViewName.ArcadeSurvivorGameView)
end

function ArcadeSurvivorController:checkDifficultyUnlock(difficulty, toastId)
	if not difficulty or difficulty <= 0 then
		return true
	end

	local isUnlock = ArcadeSurvivorOutSideModel.instance:isUnlockDifficulty(difficulty)

	if isUnlock then
		return true
	end

	if toastId and toastId > 0 then
		GameFacade.showToast(toastId)
	end

	return false
end

function ArcadeSurvivorController:enterInteractive(interactiveId)
	if not interactiveId then
		return
	end

	local toastId = ArcadeSurvivorConfig.instance:getHallUnitLockToast(interactiveId)
	local difficulty = ArcadeSurvivorConfig.instance:getHallUnitDifficulty(interactiveId)
	local isUnlock = self:checkDifficultyUnlock(difficulty, toastId)

	if not isUnlock then
		return
	end

	ArcadeSurvivorHallModel.instance:setInInteractiveHallUnitId(interactiveId)

	local enterViewName = ArcadeSurvivorConfig.instance:getHallUnitEnterViewName(interactiveId)

	if not string.nilorempty(enterViewName) then
		if interactiveId == ArcadeSurvivorHallEnum.HallInteractiveUnitId.HandBook then
			ArcadeSurvivorHandBookModel.instance:setShowCategoryType()
		end

		ViewMgr.instance:openView(enterViewName)
	elseif difficulty and difficulty > 0 then
		self:closeTipView()
		self:beginTransitionGame(difficulty)
	else
		self:dispatchEvent(ArcadeSurvivorEvent.NPCTalk, interactiveId)
	end
end

function ArcadeSurvivorController:beginTransitionGame(difficulty)
	local cfg = ArcadeSurvivorConfig.instance:getDifficultyCfg(difficulty, true)

	if not cfg then
		return
	end

	self:dispatchEvent(ArcadeSurvivorEvent.OnBeginTransitionGame, difficulty)
end

function ArcadeSurvivorController:getIsOpenInteractiveView()
	local viewNameDict = ArcadeSurvivorConfig.instance:getHallUnitEnterViewNameDict()

	for enterViewName, _ in pairs(viewNameDict) do
		local isOpen = ViewMgr.instance:isOpen(enterViewName)

		if isOpen then
			return true
		end
	end
end

function ArcadeSurvivorController:exitInteractive()
	local interactiveId = ArcadeSurvivorHallModel.instance:getInInteractiveHallUnitId()

	if interactiveId then
		local enterViewName = ArcadeSurvivorConfig.instance:getHallUnitEnterViewName(interactiveId)

		if not string.nilorempty(enterViewName) then
			local isOpen = ViewMgr.instance:isOpen(enterViewName)

			if isOpen then
				ViewMgr.instance:closeView(enterViewName)
			end
		end
	end

	ArcadeSurvivorHallModel.instance:setInInteractiveHallUnitId()
end

function ArcadeSurvivorController:onExitHall(isImmediate)
	local viewNameDict = ArcadeSurvivorConfig.instance:getHallUnitEnterViewNameDict()

	for enterViewName, _ in pairs(viewNameDict) do
		local isOpen = ViewMgr.instance:isOpen(enterViewName)

		if isOpen then
			ViewMgr.instance:closeView(enterViewName)
		end
	end

	self:dispatchEvent(ArcadeSurvivorEvent.OnExitHallView, isImmediate)
end

ArcadeSurvivorController.instance = ArcadeSurvivorController.New()

return ArcadeSurvivorController
