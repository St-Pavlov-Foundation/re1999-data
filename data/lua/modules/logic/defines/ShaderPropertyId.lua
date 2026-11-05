-- chunkname: @modules/logic/defines/ShaderPropertyId.lua

module("modules.logic.defines.ShaderPropertyId", package.seeall)

local ShaderPropertyId = _M
local Shader = UnityEngine.Shader

ShaderPropertyId.Stencil = Shader.PropertyToID("_Stencil")
ShaderPropertyId.StencilComp = Shader.PropertyToID("_StencilComp")
ShaderPropertyId.StencilOp = Shader.PropertyToID("_StencilOp")
ShaderPropertyId.LumFactor = Shader.PropertyToID("_LumFactor")
ShaderPropertyId.Scroll_LeftRamp = Shader.PropertyToID("_Scroll_LeftRamp")
ShaderPropertyId.ChangeTexture = Shader.PropertyToID("_ChangeTexture")
ShaderPropertyId.DissolveFactor = Shader.PropertyToID("_DissolveFactor")
ShaderPropertyId.FrontSceneAlpha = Shader.PropertyToID("_FrontSceneAlpha")
ShaderPropertyId.MainTex = Shader.PropertyToID("_MainTex")
ShaderPropertyId.MainTexSecond = Shader.PropertyToID("_MainTexSecond")
ShaderPropertyId.LightMap = Shader.PropertyToID("_LightMap")
ShaderPropertyId.ColorFactor = Shader.PropertyToID("_ColorFactor")
ShaderPropertyId.Alpha = Shader.PropertyToID("_Alpha")
ShaderPropertyId.Color = Shader.PropertyToID("_Color")

return ShaderPropertyId
