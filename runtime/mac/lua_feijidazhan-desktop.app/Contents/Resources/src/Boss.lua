local Boss=class("Boss", function()
	return cc.Sprite:create("boss1.png")
end)

function Boss.create()       --定义create函数
  local bs=Boss.new(level)
  return bs
end

function Boss:ctor()
	self.speed=5
	self.atk=2
	self.hp=250
	   local circle = cc.PhysicsBody:createCircle(self:getContentSize().width/2)
	circle:setCategoryBitmask(0x00000001)
    circle:setContactTestBitmask(0x00000002)
    circle:setCollisionBitmask(0x00000000)
	   self:setPhysicsBody(circle)
end

function Boss:changepic(filename)
self:initWithFile(filename)
end

function Boss:mainLogic(_level)
if _level==1 then --第一关
self:setPosition(480,700)

self:runAction(cc.Sequence:create(cc.MoveBy:create(3,cc.p(0,-200)),cc.MoveTo:create(2,cc.p(200,500)),
cc.CallFunc:create(function()
          self:runAction(cc.RepeatForever:create(
	cc.Sequence:create(cc.MoveBy:create(4,cc.p(560,0)),cc.MoveBy:create(4,cc.p(-560,0)))))
        end,self)
	))


        
elseif _level==2 then --第二关

else --第三关

end	
end

return Boss