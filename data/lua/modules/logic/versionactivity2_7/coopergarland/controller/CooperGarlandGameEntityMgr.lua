module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandGameEntityMgr", package.seeall)

slot0 = class("CooperGarlandGameEntityMgr", BaseController)

function slot0.onInit(slot0)
	slot0:clearAllMap()
end

function slot0.reInit(slot0)
	slot0:clearAllMap()
end

function slot0.clearAllMap(slot0)
	slot0._panelRoot = nil
	slot0._ballRoot = nil
	slot0._compRoot = nil
	slot0._wallRoot = nil
	slot0._panelGo = nil

	if slot0._ballEntity then
		slot0._ballEntity:destroy()
	end

	slot0._ballEntity = nil

	slot0:_clearCompAndWall()

	slot0._initMapCb = nil
	slot0._initMapCbObj = nil

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0._hasLoadedRes = false

	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameRes)
end

function slot0.enterMap(slot0)
	slot0:clearAllMap()
	slot0:_startLoadRes()
end

function slot0._startLoadRes(slot0)
	if slot0._loader then
		slot0._loader:dispose()
	end

	slot0._loader = MultiAbLoader.New()

	UIBlockMgr.instance:startBlock(CooperGarlandEnum.BlockKey.LoadGameRes)

	if string.nilorempty(next(CooperGarlandEnum.ResPath)) and string.nilorempty(next(CooperGarlandConfig.instance:getAllComponentResPath())) then
		slot0:_loadResFinished()
	else
		for slot5, slot6 in pairs(CooperGarlandEnum.ResPath) do
			slot0._loader:addPath(slot6)
		end

		for slot5, slot6 in ipairs(slot1) do
			slot0._loader:addPath(slot6)
		end

		slot0._loader:startLoad(slot0._loadResFinished, slot0)
	end
end

function slot0._loadResFinished(slot0)
	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameRes)

	slot0._hasLoadedRes = true

	slot0:tryInitMap(slot0._panelRoot, slot0._ballRoot, slot0._initMapCb, slot0._initMapCbObj)
end

function slot0.tryInitMap(slot0, slot1, slot2, slot3, slot4)
	slot0._panelRoot = slot1
	slot0._ballRoot = slot2
	slot0._initMapCb = slot3
	slot0._initMapCbObj = slot4

	slot0:_initMap()
end

function slot0._initMap(slot0)
	if not slot0._hasLoadedRes or gohelper.isNil(slot0._panelRoot) or gohelper.isNil(slot0._ballRoot) then
		return
	end

	if slot0._loader:getAssetItem(CooperGarlandEnum.ResPath.UIPanel) then
		slot0._panelGo = gohelper.clone(slot1:GetResource(), slot0._panelRoot)
		slot2 = slot0._panelGo.transform
		slot3, slot4, slot5 = transformhelper.getLocalPos(slot2)

		transformhelper.setLocalPos(slot2, slot3, slot4, CooperGarlandEnum.Const.PanelPosZ)

		slot0._panelScale = transformhelper.getLocalScale(slot2)
		slot0._wallRoot = gohelper.findChild(slot0._panelGo, "#go_walls")
		slot0._compRoot = gohelper.findChild(slot0._panelGo, "#go_comps")
		slot0._floorColliderThickness = gohelper.findChild(slot0._panelGo, "#go_boundary/floor"):GetComponent(typeof(UnityEngine.BoxCollider)).size.z
		slot0._boundaryColliderHeightZ = gohelper.findChild(slot0._panelGo, "#go_boundary/top"):GetComponent(typeof(UnityEngine.BoxCollider)).size.z
	end

	if slot0._initMapCb then
		slot0._initMapCb(slot0._initMapCbObj)
	end

	slot0._initMapCb = nil
	slot0._initMapCbObj = nil

	slot0:_setupMap()
end

function slot0._setupMap(slot0)
	slot1 = nil

	for slot7, slot8 in ipairs(CooperGarlandConfig.instance:getMapComponentList(CooperGarlandGameModel.instance:getMapId())) do
		if slot0._loader:getAssetItem(CooperGarlandConfig.instance:getComponentTypePath(CooperGarlandConfig.instance:getMapComponentType(slot2, slot8))) and not CooperGarlandGameModel.instance:isFinishedStoryComponent(slot2, slot8) then
			slot13 = slot9 == CooperGarlandEnum.ComponentType.Wall

			if slot13 then
				slot0._wallDict[slot8] = MonoHelper.addLuaComOnceToGo(gohelper.clone(slot11:GetResource(), slot13 and slot0._wallRoot or slot0._compRoot), CooperGarlandComponentEntity, {
					mapId = slot2,
					componentId = slot8,
					componentType = slot9
				})
			else
				slot0._compDict[slot8] = slot15
			end

			if slot9 == CooperGarlandEnum.ComponentType.Start then
				slot1 = slot15:getWorldPos()
			end
		end
	end

	CooperGarlandStatHelper.instance:setupMap()
	slot0:setBallVisible(slot1)
	CooperGarlandController.instance:setStopGame(false)
	CooperGarlandController.instance:dispatchEvent(CooperGarlandEvent.GuideOnEnterMap, slot2)
end

function slot0.resetMap(slot0)
	if slot0._compDict then
		for slot4, slot5 in pairs(slot0._compDict) do
			slot5:reset()
		end
	end

	slot0:resetBall()
end

function slot0.resetBall(slot0)
	if slot0._ballEntity then
		slot0._ballEntity:reset()
	end
end

function slot0.changeMap(slot0)
	slot0:_clearCompAndWall()
	slot0:setBallVisible()
	slot0:_setupMap()
end

function slot0._clearCompAndWall(slot0)
	if slot0._wallDict then
		for slot4, slot5 in pairs(slot0._wallDict) do
			slot5:destroy()
		end
	end

	slot0._wallDict = {}

	if slot0._compDict then
		for slot4, slot5 in pairs(slot0._compDict) do
			slot5:destroy()
		end
	end

	slot0._compDict = {}
end

function slot0.removeComp(slot0, slot1)
	if slot0._compDict[slot1] then
		slot0._compDict[slot1]:setRemoved()
	end
end

function slot0.setBallVisible(slot0, slot1)
	if slot1 and not slot0._ballEntity and slot0._loader:getAssetItem(CooperGarlandEnum.ResPath.Ball) then
		slot4 = gohelper.clone(slot2:GetResource(), slot0._ballRoot)
		slot5 = gohelper.findChild(slot4, "#go_ball")
		slot7 = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.BallScale, true)

		transformhelper.setLocalScale(slot4.transform, slot7, slot7, slot7)

		slot0._ballSize = slot5:GetComponentInChildren(typeof(UnityEngine.Renderer)).bounds.size.x * slot4.transform.localScale.x
		slot0._ballEntity = MonoHelper.addLuaComOnceToGo(slot5, CooperGarlandBallEntity, {
			mapId = CooperGarlandGameModel.instance:getMapId()
		})
	end

	if slot0._ballEntity then
		slot0._ballEntity:setVisible(slot1)
	end
end

function slot0.playBallDieVx(slot0)
	if slot0._ballEntity then
		slot0._ballEntity:playDieVx()
	end
end

function slot0.checkBallFreeze(slot0, slot1)
	if slot0._ballEntity then
		slot0._ballEntity:checkFreeze(slot1)
	end
end

function slot0.isBallCanTriggerComp(slot0)
	slot1 = false

	if slot0._ballEntity then
		slot1 = slot0._ballEntity:isCanTriggerComp()
	end

	return slot1
end

function slot0.getPanelGo(slot0)
	return slot0._panelGo
end

function slot0.getBallPosZ(slot0)
	return CooperGarlandEnum.Const.PanelPosZ - slot0._floorColliderThickness * slot0._panelScale - slot0._ballSize / 2 + CooperGarlandEnum.Const.BallPosOffset
end

function slot0.getCompPosZ(slot0, slot1)
	slot2 = 0

	if not slot1 then
		slot2 = -slot0._floorColliderThickness
	end

	return slot2
end

function slot0.getCompColliderSizeZ(slot0)
	return slot0._boundaryColliderHeightZ
end

function slot0.getCompColliderOffsetZ(slot0, slot1)
	slot2 = slot0._boundaryColliderHeightZ / 2

	return -(slot1 and slot2 or slot2 - slot0._floorColliderThickness)
end

function slot0.getRemoveCompList(slot0)
	slot1 = {}

	if slot0._compDict then
		for slot5, slot6 in pairs(slot0._compDict) do
			if slot6:getIsRemoved() then
				slot1[#slot1 + 1] = slot5
			end
		end
	end

	return slot1
end

function slot0.getBallVelocity(slot0)
	slot1 = Vector3.zero

	if slot0._ballEntity then
		slot1 = slot0._ballEntity:getVelocity()
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
