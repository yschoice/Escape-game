-----------------------------------------------------------------------------------------
--
-- miniGame.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/bedroom_wrong.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local textBg = display.newRect(display.contentWidth/2, display.contentHeight*0.4, 500, 130 )
	textBg:setFillColor(0, 0, 0)

	local failureText = display.newText( "Failure", display.contentWidth/2, display.contentHeight*0.4)
	failureText.size = 140
	failureText:setFillColor(1,0,0)

	local replay = display.newText("다시 하기", display.contentWidth/2, display.contentHeight*0.6)
	replay:setFillColor(0, 0, 0)
	replay.size = 100

	function replay:tap( event )
      composer.gotoScene( 'bedroom_puzzle' )
 	end

	replay:addEventListener("tap", replay)

	sceneGroup:insert(background)
	sceneGroup:insert(textBg)
	sceneGroup:insert(failureText)
	sceneGroup:insert(replay)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene