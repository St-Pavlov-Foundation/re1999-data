module("modules.logic.gm.view.Checker_HeroVoiceMotion", package.seeall)

slot0 = class("Checker_HeroVoiceMotion", Checker_Hero)
slot1 = string.split
slot2 = string.format

function slot3(slot0)
	slot0._okExec = true

	slot0:appendLine(uv0("%s(%s) skin %s: ", slot0:heroName(), slot0:heroId(), slot0:skinId()))
	slot0:pushMarkLine()
	slot0:addIndent()
end

function slot4(slot0)
	slot0:subIndent()

	if slot0._okExec then
		slot0:pushIndent()
		slot0:appendWithIndex(slot0:makeColorStr("ok", Checker_Base.Color.Green), slot0:popMarkLine())
		slot0:popIndent()
	end
end

function slot5(slot0, slot1)
	slot0._okLoop = true

	slot0:appendLine(uv0("audio %s: ", slot1.audio))
	slot0:pushMarkLine()
	slot0:addIndent()
end

function slot6(slot0, slot1)
	slot0:subIndent()

	if slot0._okLoop then
		slot0:pushIndent()
		slot0:appendWithIndex(slot0:makeColorStr("ok", Checker_Base.Color.Green), slot0:popMarkLine())
		slot0:popIndent()
	else
		slot0._okExec = false
	end
end

function slot7(slot0, slot1, slot2)
	slot0._okCheck = true

	slot0:appendLine(uv0("%s: ", slot2))
	slot0:pushMarkLine()
	slot0:addIndent()
end

function slot8(slot0, slot1, slot2)
	slot0:subIndent()

	if slot0._okCheck then
		slot0:pushIndent()
		slot0:appendWithIndex(slot0:makeColorStr("ok", Checker_Base.Color.Green), slot0:popMarkLine())
		slot0:popIndent()
	else
		slot0._okLoop = false
	end
end

function slot0.ctor(slot0, ...)
	Checker_Hero.ctor(slot0, ...)
end

function slot0._onExec_Spine(slot0, slot1)
	slot0:_onExecInner(slot1, slot1.hasAnimation)
end

function slot0._onExec_Live2d(slot0, slot1)
	slot0:_onExecInner(slot1, slot1.hasAnimation)
end

function slot0._onExecInner(slot0, slot1, slot2)
	uv0(slot0)

	for slot7, slot8 in ipairs(slot0:skincharacterVoiceCOList()) do
		uv1(slot0, slot8)
		slot0:_check(slot1, slot2, slot8, "motion")
		slot0:_check(slot1, slot2, slot8, "twmotion")
		slot0:_check(slot1, slot2, slot8, "jpmotion")
		slot0:_check(slot1, slot2, slot8, "enmotion")
		slot0:_check(slot1, slot2, slot8, "krmotion")
		uv2(slot0, slot8)
	end

	uv3(slot0)
end

function slot0._check(slot0, slot1, slot2, slot3, slot4)
	uv0(slot0, slot3, slot4)
	slot0:_onCheck(slot1, slot2, slot3[slot4])
	uv1(slot0, slot3, slot4)
end

function slot0._onCheck(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot3) then
		return
	end

	for slot8 = #uv0(slot3, "|"), 1, -1 do
		slot11 = ""

		if #uv0(slot4[slot8], "#") < 2 then
			slot11 = "#action params count < 2"
		else
			slot12 = "b_" .. tostring(slot10[1])
			slot13 = tonumber(slot10[2])

			if (tonumber(slot10[3]) or 0) < -1 then
				slot11 = "loopTimes < -1"
			end

			if not slot2(slot1, slot12) then
				slot11 = "not exist animation '" .. tostring(slot12) .. "'"
			end

			if not slot13 then
				if slot11 ~= "" then
					slot11 = slot11 .. ","
				end

				slot11 = slot11 .. "time == nil"
			elseif slot13 <= 0 then
				if slot11 ~= "" then
					slot11 = slot11 .. ","
				end

				slot11 = slot11 .. "time(" .. tostring(slot13) .. ") <= 0"
			end
		end

		if slot11 ~= "" then
			slot0:appendLine("'" .. slot9 .. "': " .. slot11)

			slot0._okCheck = false
		end
	end
end

return slot0
