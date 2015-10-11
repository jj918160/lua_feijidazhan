print=release_print
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")
-- CC_USE_DEPRECATED_API = true
require "cocos.init"

-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
end

local function initGLView()
    local director = cc.Director:getInstance()
    local glView = director:getOpenGLView()
    if nil == glView then
        glView = cc.GLViewImpl:create("Lua Empty Test")
        director:setOpenGLView(glView)
    end

    director:setOpenGLView(glView)

    glView:setDesignResolutionSize(960, 640, cc.ResolutionPolicy.NO_BORDER)

    --turn on display FPS
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)
end

local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    initGLView()

   

    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()

   local begin_scene=require "BeginScene"
   local  a = begin_scene:create()
  
     cc.Director:getInstance():replaceScene(a)
--     game_layer=require "gamelayer"
    
--     local  a = game_layer:create()

--     local sceneGame = cc.Scene:createWithPhysics()
--     local edgeBody = cc.PhysicsBody:createEdgeBox({width=800,height=640}, cc.PhysicsMaterial( 1,1 ,0), 3)
-- local edgeNode = cc.Node:create()
-- edgeNode:setPosition( 480 , 320)
-- edgeNode:setPhysicsBody( edgeBody)
-- sceneGame:addChild( edgeNode)

--     sceneGame:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
--       local gravity = cc.vertex2F(0,0)
--      sceneGame:getPhysicsWorld():setGravity(gravity)
--     sceneGame:addChild(a)
--     cc.Director:getInstance():runWithScene(sceneGame)
end

xpcall(main, __G__TRACKBACK__)
