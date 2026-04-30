-- chunkname: @modules/logic/sodache/view/inside/SodacheMapMonsterAttrView.lua

module("modules.logic.sodache.view.inside.SodacheMapMonsterAttrView", package.seeall)

local SodacheMapMonsterAttrView = class("SodacheMapMonsterAttrView", BaseView)

function SodacheMapMonsterAttrView:onInitView()
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "root/#image_icon")
	self._gocareer = gohelper.findChild(self.viewGO, "root/basebg/#image_career")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
end

function SodacheMapMonsterAttrView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function SodacheMapMonsterAttrView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function SodacheMapMonsterAttrView:onOpen()
	self._simageIcon:LoadImage(ResUrl.getSodacheSingleBg("sodache_chess_05", "chess"))
	recthelper.setSize(self._simageIcon.transform, 150, 408)

	local insideMo = SodacheModel.instance:getInsideMo()

	gohelper.CreateObjList(self, self._createCareer, insideMo.prop.bossCareerIds, nil, self._gocareer)
end

function SodacheMapMonsterAttrView:_createCareer(obj, data, index)
	local icon = gohelper.findChildImage(obj, "")

	UISpriteSetMgr.instance:setCommonSprite(icon, "career_" .. data)
end

function SodacheMapMonsterAttrView:onClickModalMask()
	self:closeThis()
end

return SodacheMapMonsterAttrView
