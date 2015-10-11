local bullet_B=class("bullet_B", function()
	return cc.Sprite:create("acorn.png")
end)
function bullet_B.create()       --定义create函数
  local bt=bullet_B.new() 
  return bt
end
function bullet_B:ctor()
	self.speed=5
	self.deltax=0
	self.atk=2
	self.hp=1
	   local circle = cc.PhysicsBody:createCircle(self:getContentSize().width/2)
	circle:setCategoryBitmask(0x00000001)
    circle:setContactTestBitmask(0x00000002)
    circle:setCollisionBitmask(0x00000000)
	   self:setPhysicsBody(circle)
end
return bullet_B