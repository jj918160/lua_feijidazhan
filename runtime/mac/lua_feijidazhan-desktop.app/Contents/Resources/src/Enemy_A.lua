local Enemy_A=class("Enemy_A", function()
	return cc.Sprite:create("acorn.png")
end)
function Enemy_A.create()       --定义create函数
  local eny=Enemy_A.new() 
  return eny
end

function Enemy_A:ctor()
  self.hp=5
	self.speed=5
	self.atk=5
  self.fire_cd=math.random(1,60)+60
  self.fire_cd_now=self.fire_cd
  self.candelete=false
	 ran=math.random(1,4)
   self.tp=ran

         if ran==1 then
     	self:initWithFile("ep_9.png")
     	else  
     	self:initWithFile("ep_10.png")
     end
	   local circle = cc.PhysicsBody:createCircle(self:getContentSize().width/4)
     circle:setCategoryBitmask(0x00000001)
    circle:setContactTestBitmask(0x00000002)
    circle:setCollisionBitmask(0x00000000)
	   self:setPhysicsBody(circle)
     ran2=math.random(1,3)
     
     ran3=math.random()
     
     
     if ran2==1 then
       self:setPosition(-20,ran3*500+130)
       
      self:runAction(cc.Sequence:create(cc.MoveBy:create(20,cc.p(1000,math.random()*600-300)),
        cc.CallFunc:create(function()
          self.candelete=true
        end, self))
      )
      elseif ran2==2 then
       self:setPosition(ran3*700+130,660) 
      self:runAction(cc.Sequence:create(cc.MoveBy:create(math.random(5,15),cc.p(math.random()*400-200,-700)),
        cc.CallFunc:create(function()
          self.candelete=true
        end, self))
      )
      elseif ran2==3 then
       self:setPosition(ran3*700+130,660) 
      self:runAction(cc.Sequence:create(cc.MoveTo:create(math.random(4,8),cc.p(math.random()*700+130,160)),
        cc.MoveTo:create(math.random(2,4),cc.p(math.random()*700+130,660)),
        cc.CallFunc:create(function()
          self.candelete=true
        end, self))
      )
     else 
      self:setPosition(980,ran3*500+130)
      self:runAction(cc.Sequence:create(cc.MoveBy:create(20,cc.p(-1000,math.random()*400-200)),
        cc.CallFunc:create(function()
          self.candelete=true
        end, self))
      )
       
     end
end


return Enemy_A