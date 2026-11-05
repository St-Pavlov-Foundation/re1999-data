-- chunkname: @modules/logic/scene/SortingLayers.lua

module("modules.logic.scene.SortingLayers", package.seeall)

local SortingLayers = {
	Default = "Default",
	Scene = "Scene",
	SceneFront = "SceneFront",
	Unit = "Unit"
}

function SortingLayers.unitTest()
	local go = UnityEngine.GameObject.New()
	local meshRenderer = gohelper.onceAddComponent(go, gohelper.Type_MeshRender)

	meshRenderer.sortingLayerName = SortingLayers.Unit
	meshRenderer.sortingOrder = 123
end

return SortingLayers
