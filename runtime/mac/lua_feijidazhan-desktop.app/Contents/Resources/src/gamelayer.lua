local gamelayer=class("gamelayer", function()
	return cc.Layer:create()
end)
function gamelayer.create()       
  local main=gamelayer.new() 
  return main
end

function gamelayer:ctor() 
   bullet=require "bullet_A"    --我的子弹
  enebullet=require "bullet_B"  --敌人的子弹
 self.createdbs=false
 self.boss=nil
 function create_boss()
  print("create")
  if self.createdbs==false then
 boss=require "Boss"
 local bs1=boss:create()
 self:addChild(bs1,2)
 bs1:changepic("boss2.png")
 bs1:mainLogic(1)
 self.createdbs=true 
 self.boss=bs1
end
 end
  cc.Director:getInstance():getScheduler():scheduleScriptFunc(create_boss,120,false)
--BOSS开火
function boss_fire()
  if self.createdbs==true then 
    for i=1,5 do
          b=self.boss
          bt=enebullet:create()
          bt.deltax=i-5/2
          table.insert(tab_enemy_bullet,bt)
          bt:setPosition(b:getPositionX(),b:getPositionY()+
          b:getContentSize().height/2)
          self:addChild(bt) 
        end
    end
end
cc.Director:getInstance():getScheduler():scheduleScriptFunc(boss_fire,3, false)


tab_bullet={}              --玩家子弹
tab_enemy={}               --敌人数组
tab_enemy_bullet={}        --敌人子弹数组
tab_item={}                --道具数组
	 maplayer=require "map"       --地图
    local bg = maplayer:create()
     self:addChild(bg)
    player=require "player"     -- 玩家
    local b=player:create()
    self:addChild(b,0,1)
    ui=require "ui_layer"        --ui界面
    local c=ui:create()
    self:addChild(c,5,2)
   
--玩家开火
  function tick()
    if b.die==true then return end
    --------------子弹1-－－－－－－－－－－－
    if b.bttype==1 then
    	    for i=0,b.level-1 do
    	    bt=bullet:create()
          bt.deltax=i-(b.level-1)/2
          table.insert(tab_bullet,bt)
          bt:setPosition(b:getPositionX(),b:getPositionY()+
    	    b:getContentSize().height/2)
          self:addChild(bt) 
          end
       end
   
  --------------子弹2-－－－－－－－－－－－
    if b.bttype==2 then
    if b.level<=5 then 
      for i=1,b.level do
        bt=bullet:create()
        bt:initWithFile("myb_1.png")
      table.insert(tab_bullet,bt)
  bt:setPosition(b:getPositionX()+(b.level-1)%5*(-10)+(i-1)%5*20,
  b:getPositionY()+b:getContentSize().height/2+math.floor((i-1)/5)*20)
          self:addChild(bt) 
        end
else
        for i=1,5 do
        bt=bullet:create()
        bt:initWithFile("myb_1.png")
      table.insert(tab_bullet,bt)
  bt:setPosition(b:getPositionX()+(i-1)%5*20-40,
  b:getPositionY()+b:getContentSize().height/2)
          self:addChild(bt) 
        end
   l=b.level-5
   for i=1, l do
         bt=bullet:create()
        bt:initWithFile("myb_1.png")
      table.insert(tab_bullet,bt)
  bt:setPosition(b:getPositionX()+(l-1)%5*(-10)+(i-1)%5*20,
  b:getPositionY()+b:getContentSize().height/2+20)
          self:addChild(bt) 
   end
 end 
end
--------------子弹3-－－－－－－－－－－－
if b.bttype==3 then
bt=bullet:create()
 local frameWidth = 21
        local frameHeight = 50

        -- create dog animate
        local texturebulletC = cc.Director:getInstance():getTextureCache():addImage("p-f01.png")
        local rect = cc.rect(0, 0, frameWidth, frameHeight)
        local frame0 = cc.SpriteFrame:createWithTexture(texturebulletC, rect)
        rect = cc.rect(frameWidth, 0, frameWidth, frameHeight)
        local frame1 = cc.SpriteFrame:createWithTexture(texturebulletC, rect)
        local animation = cc.Animation:createWithSpriteFrames({frame0,frame1}, 0.5)
        local animate = cc.Animate:create(animation)
        bt:runAction(cc.RepeatForever:create(animate))
           bt.atk=2*b.level
           bt.hp=2*b.level
          table.insert(tab_bullet,bt)
          bt:setPosition(b:getPositionX(),b:getPositionY()+
          b:getContentSize().height/2)
          bt:setScaleX(b.level/2)
      local box = cc.PhysicsBody:createBox({width=frameWidth*b.level/4,height=50},cc.PhysicsMaterial(1,1,0))
      box:setCategoryBitmask(0x00000002)
      box:setContactTestBitmask(0x00000001)
      box:setCollisionBitmask(0x00000000)
      bt:setPhysicsBody(box)
   
          self:addChild(bt) 

end
end
  cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick, 0.5, false)

     function bulletupdate() 
      --子弹移动
      for k,v in pairs(tab_bullet) do
      if (v:getPositionY()>650) or v.hp<=0 then
        v:runAction(cc.RemoveSelf:create())
        table.remove(tab_bullet,k)
       else
        v:setPositionY(v:getPositionY()+v.speed)
        v:setPositionX(v:getPositionX()+v.deltax)
      end
    end
--释放敌机删除
       for k1,v1 in pairs(tab_enemy) do
      if v1.candelete==true or v1.hp<=0 then
        v1:runAction(cc.RemoveSelf:create())
        table.remove(tab_enemy,k1)
      end
    end
--释放子弹删除
        for k2,v2 in pairs(tab_enemy_bullet) do
      if (v2:getPositionY()<-10) or v2.hp<=0 then
        v2:runAction(cc.RemoveSelf:create())
        table.remove(tab_enemy_bullet,k2)
       else
        v2:setPositionY(v2:getPositionY()-v2.speed)
        v2:setPositionX(v2:getPositionX()+v2.deltax)
      end
    end
--查看boss
    if self.createdbs and self.boss.hp<0 then 
      self.boss:runAction(cc.RemoveSelf:create())
      self.boss=nil
      self.createdbs=false
    end
  end
  
  cc.Director:getInstance():getScheduler():scheduleScriptFunc(bulletupdate, 0, false)
--创建敌机    
enemy=require "Enemy_A"
 function create_enemy()
   ene=enemy:create()
   table.insert(tab_enemy,ene)
   self:addChild(ene)
  end
 cc.Director:getInstance():getScheduler():scheduleScriptFunc(create_enemy,2, false)
--创建物品
Item=require "Item"
 function create_Item()
  ran=math.random()
  if ran<0.2 then
   ite=Item:create()
   table.insert(tab_item,ite)
   self:addChild(ite)
   end
  end
 cc.Director:getInstance():getScheduler():scheduleScriptFunc(create_Item,5, false)
--吃物品
function eat_item()
   for k,v in pairs(tab_item) do
    if v.candelete==true then
          v:runAction(cc.RemoveSelf:create())
          table.remove(tab_item,k)
    end
    local player=self:getChildByTag(1)
  -- print((v:getPositionX()-player:getPositionX())^2+(v:getPositionY()-player:getPositionY())^2)
    if (v:getPositionX()-player:getPositionX())^2+(v:getPositionY()-player:getPositionY())^2<5000 then 
      print("eat")
      v:runAction(cc.RemoveSelf:create())
      table.remove(tab_item,k)
      player.bttype=v.ittype
      player.level=player.level+1
      if player.level>10 then player.level=10 end
    end
  end
end
cc.Director:getInstance():getScheduler():scheduleScriptFunc(eat_item,0, false)


--敌机开火
 function enemy_fire()
    for k,v in pairs(tab_enemy) do
      if (v.fire_cd_now<=0) then
         ebt=enebullet:create()
         if v.tp==3 then 
          local player=self:getChildByTag(1)
         ebt.deltax=(v:getPositionX()-player:getPositionX())*5/(player:getPositionY()-v:getPositionY())
         --ebt.deltax=(player:getPositionY()-v:getPositionY())*5/(v:getPositionX()-player:getPositionX())
          print("deltax:--"..ebt.deltax)
       end
        table.insert(tab_enemy_bullet,ebt)
        ebt:setPosition(v:getPositionX(),v:getPositionY()-
      v:getContentSize().height/2)
     self:addChild(ebt)
     v.fire_cd_now=v.fire_cd
     else
       v.fire_cd_now=v.fire_cd_now-1
      end
    end
  end
cc.Director:getInstance():getScheduler():scheduleScriptFunc(enemy_fire,0, false)

 



local function onContactBegin(contact)
local node1 = contact:getShapeA():getBody():getNode()
local node2 = contact:getShapeB():getBody():getNode()
--if node1.strong==false then  
   node1.hp=node1.hp-node2.atk
 --end
--if node2.strong and node2.strong==false then 
   node2.hp=node2.hp-node1.atk
--end
   print(node1.hp)
   print(node2.hp)
   return true
end

-- -- 注册
 local contactListener = cc.EventListenerPhysicsContact:create();
 contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN);
--contactListener:registerScriptHandler(onContactPreSolve, cc.Handler.EVENT_PHYSICS_CONTACT_PRESOLVE);
 
 local dispatcher = cc.Director:getInstance():getEventDispatcher()
 dispatcher:addEventListenerWithSceneGraphPriority(contactListener, self)

end
return gamelayer