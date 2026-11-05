-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibraryBaseSceneComp.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibraryBaseSceneComp", package.seeall)

local V4a1_LibraryBaseSceneComp = class("V4a1_LibraryBaseSceneComp", LibSimpleSceneCompBase)

GameUtil.setInterface(V4a1_LibraryBaseSceneComp, V4a1_LibrarySceneCompInterface)

function V4a1_LibraryBaseSceneComp:ctor(...)
	V4a1_LibraryBaseSceneComp.super.ctor(self, ...)
end

return V4a1_LibraryBaseSceneComp
