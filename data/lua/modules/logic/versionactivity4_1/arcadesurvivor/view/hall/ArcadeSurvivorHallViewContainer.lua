-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorHallViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorHallViewContainer", package.seeall)

local ArcadeSurvivorHallViewContainer = class("ArcadeSurvivorHallViewContainer", BaseViewContainer)

function ArcadeSurvivorHallViewContainer:buildViews()
	local views = {}

	self._scene = ArcadeSurvivorHallScene.New()

	table.insert(views, ArcadeSurvivorHallView.New())
	table.insert(views, TabViewGroup.New(1, "Right/#go_currency"))
	table.insert(views, self._scene)

	return views
end

function ArcadeSurvivorHallViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = ArcadeSurvivorCurrencyView.New({
			ArcadeSurvivorEnum.Currency.Diamond
		})

		return {
			self._currencyView
		}
	end
end

function ArcadeSurvivorHallViewContainer:playerActOnDirection(direction)
	local canMove = self:isCanMove()

	if not direction or not canMove then
		return
	end

	self._scene:playerActOnDirection(direction)
end

function ArcadeSurvivorHallViewContainer:isCanMove()
	local isOpenInteractiveView = ArcadeSurvivorController.instance:getIsOpenInteractiveView()

	return self._scene and self._scene:isCanMove() and not isOpenInteractiveView
end

function ArcadeSurvivorHallViewContainer:getSceneView()
	return self._scene
end

return ArcadeSurvivorHallViewContainer
