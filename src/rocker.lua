local Rocker=class("Rocker", function()
	return cc.Layer:create()
end)
function Rocker.create()       --定义create函数
  local rocker=Rocker.new() 
  return rocker
end

function Rocker:getRad(pos1)
     px1=pos1.x;
     py1=pos1.y;
     x=px1-rockerpos.x;
     y=py1-rockerpos.y;
     xie=(x^2+y^2)^(1/2);
     cosAngle=x/xie;
     rad=math.acos(cosAngle);
    if (py1<rockerpos.y) then
        rad=-rad;
    end
    return rad;
end




function Rocker:ctor()
	  rockerpos={x=200,y=100}
	  local rbg = cc.Sprite:create("CG-1086.png")
	  rbg:setPosition(rockerpos.x,rockerpos.y)
	  rbg:setOpacity(155)
	  self:addChild(rbg,0,1)
	  local rf = cc.Sprite:create("CG-7005.png")
	  rf:setPosition(rockerpos.x,rockerpos.y)
	  self:addChild(rf,1,2)
      self.dir=0
      self.PI=3.14
      -- 触摸开始
      bgr=rbg:getContentSize().width/2
local function onTouchBegan(touch, event)	
	pos=touch:getLocation()	
if cc.rectContainsPoint(rf:getBoundingBox(), pos)then
return true
end
end
-- 触摸移动
local function onTouchMoved(touch, event)
   local point =touch:getLocation()
     angle=self:getRad(point)
	 if (rockerpos.x-point.x)^2+(rockerpos.y-point.y)^2>=bgr^2 then
	 	 --angle=self:getRad(point)
	 	 deltax=math.cos(angle)*bgr
	 	 deltay=math.sin(angle)*bgr
	 	rf:setPosition(deltax+rockerpos.x,deltay+rockerpos.y)
	 else
  rf:setPosition(point)
    end
   if angle<=self.PI/4 and angle>-self.PI/4 then
     self.dir=1
    elseif angle<=self.PI*3/4 and angle>self.PI/4 then
     self.dir=2
    elseif angle>self.PI*3/4 or angle<-self.PI*3/4 then
     self.dir=3
    else 
     self.dir=4
   end
end

 
-- 触摸结束
local function onTouchEnded(touch, event)
rf:setPosition(rockerpos.x,rockerpos.y)
self.dir=0
end
 
-- 注册单点触摸
local dispatcher = cc.Director:getInstance():getEventDispatcher()
local listener = cc.EventListenerTouchOneByOne:create()
listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
dispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

return Rocker