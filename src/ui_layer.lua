local ui_layer=class("ui_layer", function()
	return cc.Layer:create()
end)
function ui_layer.create()       --定义create函数
  local ui=ui_layer.new() 
  return ui
end
ui_layer.die=false

function ui_layer:ctor()

	rocker=require "rocker" 
	local myrocker=rocker:create()
	self:addChild(myrocker,0,2)
   self.gameover=false
	--侧翼
    bg1=cc.Sprite:create("bg1_1.png")
    bg1:setPosition(40, 320)
    bg1:setFlipX(true)
    self:addChild(bg1)
    bg2=cc.Sprite:create("bg1_1.png")
    bg2:setPosition(920, 320)
    self:addChild(bg2)

    --生命
    life1=cc.Sprite:create("uiPlane0.png")
    life1:setPosition(930, 600)
    
    self:addChild(life1)
    life2=cc.Sprite:create("x_updateall.png")
    life2:setPosition(930, 560)
    self:addChild(life2)

     label = cc.Label:createWithBMFont("bitmapFontTest.fnt","5")
     label:setPosition(930, 520)
     self:addChild(label)

     --子弹等级
     labe2 = cc.Label:createWithBMFont("bitmapFontTest.fnt","Lv")
     labe2:setPosition(30, 600)
     self:addChild(labe2)

     labe3 = cc.Label:createWithBMFont("bitmapFontTest.fnt","1")
     labe3:setPosition(30, 560)
     self:addChild(labe3)

    --血条
    hpsp=cc.Sprite:create("hp.png")
    hp=cc.ProgressTimer:create(hpsp)
    
    hp:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    hp:setMidpoint(cc.p(0,0))
    hp:setBarChangeRate(cc.p(0,1))
    hp:setPosition(20, 82)
    self:addChild(hp)
    --蓝条
    mpsp=cc.Sprite:create("mp.png")
    mp=cc.ProgressTimer:create(mpsp)
    mp:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    mp:setMidpoint(cc.p(0,0))
    mp:setBarChangeRate(cc.p(0,1))
    mp:setPosition(940, 82)
    self:addChild(mp)

    --死亡动画
    sfc=cc.SpriteFrameCache:getInstance()
    sfc:addSpriteFrames("wsparticle_gold01.plist")
    animation=cc.Animation:create()
    for i=0,9 do
    	name=string.format("gold_0000%d.png",i)
    	sf=sfc:getSpriteFrame(name)
    	animation:addSpriteFrame(sf)
     end
    animation:setDelayPerUnit(0.15)
    animation:setLoops(2)
    animation:setRestoreOriginalFrame(true);
    ac=cc.AnimationCache:getInstance();
    ac:addAnimation(animation,"die")



function tick()

   player=self:getParent():getChildByTag(1)
   life=player.life
   numhp=player.hp
   nummp=player.mp
   hp:setPercentage(numhp*5)
   mp:setPercentage(nummp*5)
   label:setString(life)
     labe3:setString(player.level)
   if numhp<=0 and self.die==false then
   
   if life<=0 then 
   over_layer=require "GameOverLayer"
  
   local  a = over_layer:create()
   self:getScene():addChild(a,10)
   cc.Director:getInstance():pause()
   end
   

   player.die=true
   player:getPhysicsBody():setContactTestBitmask(0x00000000)
   self.die=true
   act=cc.AnimationCache:getInstance():getAnimation("die")
   dieact=cc.Animate:create(act)
   player:runAction(dieact)
   player.life=player.life-1
   player:runAction(cc.Sequence:create(cc.DelayTime:create(3),
cc.CallFunc:create(function()
	player.hp=20
	    self.die=false
	    player.die=false
       
          end),
   	cc.Blink:create(3,10), 
   	cc.CallFunc:create(function()
         player:getPhysicsBody():setContactTestBitmask(0x00000001)
          player.strong=false
        end)))
   end
      end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick, 0, false)


--－－－－－－－－－－－－－－－－－－－－按钮－－－－－－－－－－－－－－－－－－－－－－
--保护罩
        local function menuCallbaohuzhao()
        	player=self:getParent():getChildByTag(1)
        	if player.mp<2 or player.die==true then return end
        	player.mp=player.mp-2
           
           player:getPhysicsBody():setContactTestBitmask(0x00000000)
           baohuzhao=cc.Sprite:create("zhaozi.png")
           baohuzhao:setPosition(player:getContentSize().width/2,player:getContentSize().height/2)
           player:addChild(baohuzhao,1,2)
           player:runAction(cc.Sequence:create(cc.DelayTime:create(5),cc.CallFunc:create(function()
	       player:removeChildByTag(2)
	       player:getPhysicsBody():setContactTestBitmask(0x00000001)
          
          end)))

        end
--炸弹
        local function menuCallzhadan()
        	player=self:getParent():getChildByTag(1)
        	if player.mp<3 or player.die==true then return end
        	player.mp=player.mp-3
        
            yuanzi=cc.Sprite:create("baohu_2.png")
            yuanzi:setPosition(player:getPositionX(),player:getPositionY()+player:getContentSize().height/2)
            yuanzi:runAction(cc.Sequence:create(cc.MoveBy:create(1,cc.p(0,50)),cc.RemoveSelf:create()))
            self:addChild(yuanzi)

            zhadan=cc.Sprite:create("zhadan.png")
            zhadan:setOpacity(0)
            zhadan.hp=1000
            zhadan.atk=10
            zhadan:setPosition(player:getPositionX(),player:getPositionY()+player:getContentSize().height/2+100)
            zhadan:runAction(cc.Sequence:create(cc.DelayTime:create(1),cc.FadeIn:create(0.1),
            	cc.CallFunc:create(function()
            zhadan:runAction(cc.RepeatForever:create(cc.RotateBy:create(0.1,60)))
            local circle = cc.PhysicsBody:createCircle(zhadan:getContentSize().width/2)
            circle:setCategoryBitmask(0x00000002)
            circle:setContactTestBitmask(0x00000001)
            circle:setCollisionBitmask(0x00000000)
	        zhadan:setPhysicsBody(circle) 
	        end ),cc.DelayTime:create(5),cc.RemoveSelf:create()))
	       
            self:addChild(zhadan)
        end
        local function menuCalljiguan()
        	if player.mp<4 or player.die==true then return end
        	player.mp=player.mp-4
        player=self:getParent():getChildByTag(1)
        jgact=cc.Animation:create()
        jgact:addSpriteFrameWithFileName("jiguang.png")
        jgact:addSpriteFrameWithFileName("jiguang3.png")
        jgact:addSpriteFrameWithFileName("jiguang4.png")
        jgact:setDelayPerUnit(0.1)
        jgact:setLoops(20)
        jgact:setRestoreOriginalFrame(true);

        local spritejg = cc.Sprite:create("jiguang.png")
          spritejg.hp=1000
            spritejg.atk=10
        spritejg:setAnchorPoint(cc.p(0.5,0))
        spritejg:setPosition(player:getContentSize().width/2, player:getContentSize().height )
        local box = cc.PhysicsBody:createBox({width=30,height=640})
            box:setCategoryBitmask(0x00000002)
            box:setContactTestBitmask(0x00000001)
            box:setCollisionBitmask(0x00000000)
	        spritejg:setPhysicsBody(box) 

        local animate = cc.Animate:create(jgact)
        spritejg:runAction(cc.Spawn:create(animate,
        	cc.Sequence:create(cc.DelayTime:create(5),cc.RemoveSelf:create())))
        
        player:addChild(spritejg)

        end


        local menubaohuItem = cc.MenuItemImage:create("baohu_1.png", "baohu_2.png")
        menubaohuItem:setPosition(700,50)
        menubaohuItem:registerScriptTapHandler(menuCallbaohuzhao)
        local menuzhadanItem = cc.MenuItemImage:create("zditem.png", "baohu_2.png")
        menuzhadanItem:setPosition(780,70)
        menuzhadanItem:registerScriptTapHandler(menuCallzhadan)
        local menujiguangItem = cc.MenuItemImage:create("jgitem.png", "jgitem2.png")
        menujiguangItem:setPosition(800,130)
        menujiguangItem:registerScriptTapHandler(menuCalljiguan)

        menuPopup = cc.Menu:create(menubaohuItem,menuzhadanItem,menujiguangItem)
        menuPopup:setPosition(0,0)
        self:addChild(menuPopup)

end



return ui_layer