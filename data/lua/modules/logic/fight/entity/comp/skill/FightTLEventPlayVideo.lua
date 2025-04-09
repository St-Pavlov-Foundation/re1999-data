module("modules.logic.fight.entity.comp.skill.FightTLEventPlayVideo", package.seeall)

slot0 = class("FightTLEventPlayVideo", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	slot0._resName = slot3[1]

	if not string.nilorempty(slot0._resName) then
		if slot3[2] ~= "1" and FightVideoMgr.instance:isSameVideo(slot0._resName) and FightVideoMgr.instance:isPause() then
			FightVideoMgr.instance:continue(slot0._resName)

			return
		end

		FightVideoMgr.instance:play(slot0._resName)

		if slot3[2] == "1" then
			FightVideoMgr.instance:pause()
		end
	end
end

function slot0.onTrackEnd(slot0)
	slot0:_clear()
end

function slot0.onDestructor(slot0)
	slot0:_clear()
end

function slot0._clear(slot0)
	FightVideoMgr.instance:stop()
end

return slot0
