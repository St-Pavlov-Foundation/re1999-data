-- chunkname: @modules/logic/scene/RenderModes.lua

module("modules.logic.scene.RenderModes", package.seeall)

local RenderModes = {
	WorldSpace = 2,
	ScreenSpaceOverlay = 0,
	ScreenSpaceCamera = 1
}
local CSRenderModes, RenderModeT

local function _reflect()
	if not RenderModeT or not CSRenderModes then
		GameUtil.LoadAS()

		CSRenderModes = {}
		RenderModeT = tolua.findtype("UnityEngine.RenderMode")

		for eName, eValue in pairs(RenderModes) do
			if type(eValue) == "number" then
				if isDebugBuild then
					assert(CSRenderModes[eValue] == nil, string.format("CSRenderModes[%s] already exists", eName))
				end

				CSRenderModes[eValue] = tolua.getfield(RenderModeT, eName):Get(nil)
			end
		end
	end
end

function RenderModes.get(eRenderModes)
	if isDebugBuild then
		assert(tonumber(eRenderModes))
	end

	_reflect()

	return CSRenderModes[eRenderModes]
end

function RenderModes.unitTest()
	local go = UnityEngine.GameObject.New()
	local canvas = gohelper.onceAddComponent(go, typeof(UnityEngine.Canvas))

	canvas.renderMode = RenderModes.get(RenderModes.WorldSpace)
	canvas.worldCamera = CameraMgr.instance:getMainCamera()
	canvas.overrideSorting = true
	canvas.sortingLayerName = SortingLayers.Default
	canvas.sortingOrder = 123
end

return RenderModes
