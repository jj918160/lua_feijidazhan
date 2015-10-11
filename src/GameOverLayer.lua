
local GameOverLayer=class("GameOverLayer", function()
	return cc.Layer:create()
end)
function GameOverLayer.create()       
  local main=GameOverLayer.new() 
  return main
end

function GameOverLayer:ctor() 
 bg=cc.Sprite:create("cg3.jpg")
 bg:setPosition(480,320)
 self:addChild(bg)

 local function menuCallresume()
    cc.Director:getInstance():resume()
    self:runAction(cc.RemoveSelf:create())
    self:getParent():getChildByTag(1):getChildByTag(1).life=3
        end
 local function menuCallbegin()
   --  cc.Director:getInstance():resume()
   -- local begin=require "BeginScene"
   --  local sc= begin:create()
   -- local trans=cc.TransitionFade:create(1,sc)
   --  cc.Director:getInstance():pushScene(trans)
     cc.Director:getInstance():endToLua()
   end


  local menubaohuItem = cc.MenuItemImage:create("back_peek0.png", "back_peek1.png")
        menubaohuItem:setPosition(360,100)
        menubaohuItem:registerScriptTapHandler(menuCallbegin)

  local menubaohuItem2 = cc.MenuItemImage:create("shopReviveWord.png", "shopReviveWord2.png")
        menubaohuItem2:setPosition(600,100)
        menubaohuItem2:registerScriptTapHandler(menuCallresume)



        menuPopup = cc.Menu:create(menubaohuItem,menubaohuItem2)
        menuPopup:setPosition(0,0)
        self:addChild(menuPopup)

end


return GameOverLayer