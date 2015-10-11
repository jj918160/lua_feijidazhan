local Player=class("Player", function()
return cc.Sprite:create("my_1.png")
end)

Player.mp=20

function Player.create()       --定义create函数
  local plane=Player.new() 
  return plane
end

function Player:ctor()
  local visibleSize = cc.Director:getInstance():getVisibleSize()

  self.die=false
  self.bttype=1
  self.level=1
  self.hp=20
  self.atk=10
  self.Direction=0
  self.speed=3
  self.life=1
  self:setPosition(visibleSize.width/2,30)
  size={width=self:getContentSize().width/2,height=self:getContentSize().height/2}
   local box = cc.PhysicsBody:createBox(size,cc.PhysicsMaterial(1,1,0))
--vertexes={cc.p(100,100),cc.p(300,100),cc.p(300,300),cc.p(200,400),cc.p(100,300)}
  --local Polygon=cc.PhysicsBody:createPolygon(vertexes,5,cc.PhysicsMaterial(1,1,0))
  polygon=cc.PhysicsBody:createPolygon({
    cc.p(-50,30),cc.p(50,30),cc.p(50,0),cc.p(0,-50),cc.p(-50,0)
    })
     self:setPhysicsBody(polygon)
     polygon:setCategoryBitmask(0x00000002)
    polygon:setContactTestBitmask(0x00000001)
    polygon:setCollisionBitmask(0x00000000)
    polygon:setGroup(1)

    function tick()
    if self.die==true then return end 
    rock=self:getParent():getChildByTag(2):getChildByTag(2)
    self.Direction=rock.dir
    if  self.Direction==1 and self:getPositionX()+self.speed<840 then
        	self:setPositionX(self:getPositionX()+ self.speed)
    elseif  self.Direction==2 and self:getPositionY()+self.speed<610 then
        	self:setPositionY(self:getPositionY()+ self.speed)
    elseif  self.Direction==3 and self:getPositionX()-self.speed>140 then
        	self:setPositionX(self:getPositionX()- self.speed)
    elseif  self.Direction==4 and self:getPositionY()-self.speed>30 then  
    	    self:setPositionY(self:getPositionY()- self.speed)
        end    
 end
  cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick, 0, false)
end
   

return Player