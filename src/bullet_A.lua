local bullet_A=class("bullet_A", function()
	return cc.Sprite:create("acorn.png")
end)
function bullet_A.create()       --定义create函数
  local bt=bullet_A.new() 
  return bt
end
function bullet_A:ctor()
	self.speed=5
	self.atk=2
	self.hp=1
	self.deltax=0
local circle = cc.PhysicsBody:createCircle(self:getContentSize().width/2)
	circle:setCategoryBitmask(0x00000002)
    circle:setContactTestBitmask(0x00000001)
    circle:setCollisionBitmask(0x00000000)
	   self:setPhysicsBody(circle)
end
return bullet_A