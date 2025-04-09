module("modules.logic.fight.config.FightRightBottomElementEnum", package.seeall)

slot0 = _M
slot1 = 0

function slot2()
	uv0 = uv0 + 1

	return uv0
end

slot0.Elements = {
	ASFD = slot2(),
	BloodPool = slot2()
}
slot0.Priority = {
	slot0.Elements.BloodPool,
	slot0.Elements.ASFD
}
slot0.ElementsSizeDict = {
	[slot0.Elements.BloodPool] = Vector2(180, 170),
	[slot0.Elements.ASFD] = Vector2(100, 170)
}
slot0.ElementsNodeName = {
	[slot0.Elements.BloodPool] = "bloodpool",
	[slot0.Elements.ASFD] = "asfd"
}

return slot0
