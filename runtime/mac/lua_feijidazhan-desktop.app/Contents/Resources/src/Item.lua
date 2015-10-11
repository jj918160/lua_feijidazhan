local Item=class("Item", function()
	return cc.Sprite:create()
end)
function Item.create()       --定义create函数
  local it=Item.new() 
  return it
end

function Item:ctor()
	 self.candelete=false
	self.ittype=math.random(1,3)
	--print("type:"..self.ittype)
if self.ittype==1 then 
		self:initWithFile("head_cat.png")
elseif self.ittype==2 then
        self:initWithFile("head_dog.png")
else 
	    self:initWithFile("head_c.png")
end
local action = cc.Spawn:create(
	cc.MoveTo:create(10,cc.p(math.random()*800+80,math.random()*640)),
	cc.Blink:create(10,30))
ranx=math.random()*800+80
rany=math.random()*640
       self:setPosition(ranx,rany)
      self:runAction(cc.Sequence:create(
      	cc.MoveTo:create(10,cc.p(math.random()*800+80,math.random()*640)),
      	cc.MoveTo:create(10,cc.p(math.random()*800+80,math.random()*640)),
      	--cc.MoveTo:create(10,cc.p(math.random()*800+80,math.random()*640)),
      	action,
        cc.CallFunc:create(function()
          self.candelete=true
        end, self))
      )
end
return Item