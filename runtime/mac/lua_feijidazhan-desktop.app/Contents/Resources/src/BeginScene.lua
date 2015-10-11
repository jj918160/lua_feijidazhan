local BeginScene=class("BeginScene", function()
	return cc.Scene:create()
end)
function BeginScene.create()       
  local main=BeginScene:new() 
  return main
end

function BeginScene:ctor() 

 local bg=cc.Sprite:create("bg1_startcg.jpg")
 bg:setPosition(480,320)
 self:addChild(bg)

print(1)
 -- local edgeBody = cc.PhysicsBody:createEdgeBox({width=800,height=640}, cc.PhysicsMaterial( 1,1 ,0), 3)
 --    local edgeNode = cc.Node:create()
 --    edgeNode:setPosition( 480 , 320)
 --    edgeNode:setPhysicsBody(edgeBody)
 --    self:addChild(edgeNode)


 local function menuCallbegin()
    game_layer=require "gamelayer"
    
    local  a = game_layer:create()
    local sceneGame = cc.Scene:createWithPhysics()
    local edgeBody = cc.PhysicsBody:createEdgeBox({width=800,height=640}, cc.PhysicsMaterial( 1,1 ,0), 3)
    local edgeNode = cc.Node:create()
    edgeNode:setPosition( 480 , 320)
    edgeNode:setPhysicsBody( edgeBody)
    sceneGame:addChild( edgeNode)
    --sceneGame:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)

    local gravity = cc.vertex2F(0,0)
    sceneGame:getPhysicsWorld():setGravity(gravity)
    sceneGame:addChild(a,0,1)
    cc.Director:getInstance():replaceScene(sceneGame)
   
          
        end


print(2)
  local menubaohuItem = cc.MenuItemImage:create("start_menu.png", "start_menu2.png")
        menubaohuItem:setPosition(480,100)
        menubaohuItem:registerScriptTapHandler(menuCallbegin)
        menuPopup = cc.Menu:create(menubaohuItem)
        menuPopup:setPosition(0,0)
        self:addChild(menuPopup)
print(3)
end


return BeginScene