module("modules.logic.scene.SceneMacro", package.seeall)

slot0 = class()
SceneType.Summon = 4
SceneType.SelectFb = 5
SceneType.Adventure = 8
SceneType.Newbie = 9
SceneType.Room = 10
SceneType.Explore = 11
SceneType.PushBox = 12
SceneType.Cachot = 13
SceneType.Rouge = 14
SceneType.NameDict = {}

for slot4, slot5 in pairs(SceneType) do
	SceneType.NameDict[slot5] = slot4
end

SceneTag.UnitCamera = "UnitCamera"
SceneTag.UICamera = "UICamera"
SceneTag.UnitPlayer = "UnitPlayer"
SceneTag.UnitMonster = "UnitMonster"
SceneTag.UnitNpc = "UnitNpc"
SceneTag.FightStartTrigger = "FightStartTrigger"
SceneTag.NPCTrigger = "NPCTrigger"
SceneTag.RoomMapBlock = "RoomMapBlock"
SceneTag.RoomEmptyBlock = "RoomEmptyBlock"
SceneTag.RoomInventoryBlock = "RoomInventoryBlock"
SceneTag.RoomFakeBlock = "RoomFakeBlock"
SceneTag.RoomBuilding = "RoomBuilding"
SceneTag.RoomCharacter = "RoomCharacter"
SceneTag.RoomResource = "RoomResource"
SceneTag.RoomInitBuilding = "RoomInitBuilding"
SceneTag.RoomPartBuilding = "RoomPartBuilding"
SceneTag.RoomLand = "RoomLand"
SceneLayer.UI3D = "UI3D"
SceneLayer.Unit = "Unit"
SceneLayer.Scene = "Scene"
SceneLayer.SceneEffect = "SceneEffect"
SceneLayer.Nothing = "Nothing"
SceneLayer.Monster = "Monster"
SceneLayer.Ignore = "Ignore"
SceneLayer.UI3DAfterPostProcess = "UI3DAfterPostProcess"

return slot0
