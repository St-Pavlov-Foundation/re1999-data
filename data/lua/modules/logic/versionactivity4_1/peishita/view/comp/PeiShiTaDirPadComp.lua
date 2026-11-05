-- chunkname: @modules/logic/versionactivity4_1/peishita/view/comp/PeiShiTaDirPadComp.lua

module("modules.logic.versionactivity4_1.peishita.view.comp.PeiShiTaDirPadComp", package.seeall)

local PeiShiTaDirPadComp = class("PeiShiTaDirPadComp", LuaCompBase)

function PeiShiTaDirPadComp:init(go)
	self.go = go
	self._inputX = 0
	self._inputY = 0
	self._btnUp = gohelper.findChildClickWithDefaultAudio(go, "#go_background/btn_up")
	self._btnDown = gohelper.findChildClickWithDefaultAudio(go, "#go_background/btn_down")
	self._btnLeft = gohelper.findChildClickWithDefaultAudio(go, "#go_background/btn_left")
	self._btnRight = gohelper.findChildClickWithDefaultAudio(go, "#go_background/btn_right")
	self._goUp = self._btnUp.gameObject
	self._goDown = self._btnDown.gameObject
	self._goLeft = self._btnLeft.gameObject
	self._goRight = self._btnRight.gameObject
	self._clickAreaTab = self:getUserDataTb_()
	self._clickAreaTab[PeiShiTaEnum.Direction.Up] = gohelper.findChild(self._goUp, "light").transform
	self._clickAreaTab[PeiShiTaEnum.Direction.Down] = gohelper.findChild(self._goDown, "light").transform
	self._clickAreaTab[PeiShiTaEnum.Direction.Left] = gohelper.findChild(self._goLeft, "light").transform
	self._clickAreaTab[PeiShiTaEnum.Direction.Right] = gohelper.findChild(self._goRight, "light").transform
	self._lightIconTab = self:getUserDataTb_()
	self._lightIconTab[PeiShiTaEnum.Direction.Up] = gohelper.findChild(self._goUp, "light")
	self._lightIconTab[PeiShiTaEnum.Direction.Down] = gohelper.findChild(self._goDown, "light")
	self._lightIconTab[PeiShiTaEnum.Direction.Left] = gohelper.findChild(self._goLeft, "light")
	self._lightIconTab[PeiShiTaEnum.Direction.Right] = gohelper.findChild(self._goRight, "light")
	self._darkIconTab = self:getUserDataTb_()
	self._darkIconTab[PeiShiTaEnum.Direction.Up] = gohelper.findChild(self._goUp, "dark")
	self._darkIconTab[PeiShiTaEnum.Direction.Down] = gohelper.findChild(self._goDown, "dark")
	self._darkIconTab[PeiShiTaEnum.Direction.Left] = gohelper.findChild(self._goLeft, "dark")
	self._darkIconTab[PeiShiTaEnum.Direction.Right] = gohelper.findChild(self._goRight, "dark")
end

function PeiShiTaDirPadComp:addEventListeners()
	self._btnUp:AddClickListener(self._onDirClick, self, PeiShiTaEnum.Direction.Up)
	self._btnDown:AddClickListener(self._onDirClick, self, PeiShiTaEnum.Direction.Down)
	self._btnLeft:AddClickListener(self._onDirClick, self, PeiShiTaEnum.Direction.Left)
	self._btnRight:AddClickListener(self._onDirClick, self, PeiShiTaEnum.Direction.Right)
	self._btnUp:AddClickDownListener(self._onDirClickDown, self, PeiShiTaEnum.Direction.Up)
	self._btnDown:AddClickDownListener(self._onDirClickDown, self, PeiShiTaEnum.Direction.Down)
	self._btnLeft:AddClickDownListener(self._onDirClickDown, self, PeiShiTaEnum.Direction.Left)
	self._btnRight:AddClickDownListener(self._onDirClickDown, self, PeiShiTaEnum.Direction.Right)
	self._btnUp:AddClickUpListener(self._onDirClickUp, self, PeiShiTaEnum.Direction.Up)
	self._btnDown:AddClickUpListener(self._onDirClickUp, self, PeiShiTaEnum.Direction.Down)
	self._btnLeft:AddClickUpListener(self._onDirClickUp, self, PeiShiTaEnum.Direction.Left)
	self._btnRight:AddClickUpListener(self._onDirClickUp, self, PeiShiTaEnum.Direction.Right)
end

function PeiShiTaDirPadComp:removeEventListeners()
	self._btnUp:RemoveClickListener()
	self._btnDown:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnUp:RemoveClickDownListener()
	self._btnDown:RemoveClickDownListener()
	self._btnLeft:RemoveClickDownListener()
	self._btnRight:RemoveClickDownListener()
	self._btnUp:RemoveClickUpListener()
	self._btnDown:RemoveClickUpListener()
	self._btnLeft:RemoveClickUpListener()
	self._btnRight:RemoveClickUpListener()
end

function PeiShiTaDirPadComp:_onDirClick(dir)
	self:refreshDirLight(dir)
	PeiShiTaGameController.instance:onMoveInput(dir)
end

function PeiShiTaDirPadComp:onUpdate()
	local inputX = UnityEngine.Input.GetAxisRaw("Horizontal")
	local inputY = UnityEngine.Input.GetAxisRaw("Vertical")

	self._isPadDown = inputX ~= 0 or inputY ~= 0

	if not self._isClickDown and not self._isPadDown then
		local enterDir = self:findPointerEnterDir()

		self:refreshDirLight(enterDir)
	elseif self._isPadDown and self._pressDir then
		self:refreshDirLight(self._pressDir)
	end

	if self._inputX == inputX and self._inputY == inputY then
		return
	end

	if not ViewMgr.instance:isOpenFinish(ViewName.PeiShiTaGameView) then
		return
	end

	self._inputX = inputX
	self._inputY = inputY
	self._pressDir = nil

	if inputX > 0 then
		self._pressDir = PeiShiTaEnum.Direction.Right
	elseif inputX < 0 then
		self._pressDir = PeiShiTaEnum.Direction.Left
	elseif inputY > 0 then
		self._pressDir = PeiShiTaEnum.Direction.Up
	elseif inputY < 0 then
		self._pressDir = PeiShiTaEnum.Direction.Down
	end

	if self._pressDir then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		PeiShiTaGameController.instance:onMoveInput(self._pressDir)
	end
end

function PeiShiTaDirPadComp:_onDirClickDown(dir)
	self._isClickDown = true

	self:refreshDirLight(dir)
end

function PeiShiTaDirPadComp:_onDirClickUp(dir)
	self._isClickDown = false

	self:refreshDirLight()
end

function PeiShiTaDirPadComp:refreshDirLight(targetDir)
	for dir, goIcon in pairs(self._lightIconTab) do
		gohelper.setActive(goIcon, dir == targetDir)
	end

	for dir, goIcon in pairs(self._darkIconTab) do
		gohelper.setActive(goIcon, dir ~= targetDir)
	end
end

function PeiShiTaDirPadComp:findPointerEnterDir()
	local mousePosition = GamepadController.instance:getMousePosition()

	for dir, tran in pairs(self._clickAreaTab) do
		if recthelper.screenPosInRect(tran, nil, mousePosition.x, mousePosition.y) then
			return dir
		end
	end
end

return PeiShiTaDirPadComp
