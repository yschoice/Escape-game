-----------------------------------------------------------------------------------------
--
-- Pipe.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local timeAttack
	local bg = {}
	bg[1] = display.newImage("image/puzzle/bathroom_puzzle_bg.png")
	bg[1].x, bg[1].y = display.contentWidth/2, display.contentHeight/2
	
	local pipeGroupe = display.newGroup()
	local pipe = {}

	pipe[1] = display.newImage(pipeGroupe, "image/puzzle/pipe_1_1.png")
	pipe[1].x, pipe[1].y = display.contentWidth/2-180, display.contentHeight/2-180 --왼쪽 위

	pipe[2] = display.newImage(pipeGroupe, "image/puzzle/pipe_2_2.png")
	pipe[2].x, pipe[2].y = display.contentWidth/2-180, display.contentHeight/2 --왼쪽 중앙

	pipe[3] = display.newImage(pipeGroupe, "image/puzzle/pipe_2_1.png")
	pipe[3].x, pipe[3].y = display.contentWidth/2, display.contentHeight/2 --중앙 중앙

	pipe[4] = display.newImage(pipeGroupe, "image/puzzle/pipe_2_1.png")
	pipe[4].x, pipe[4].y = display.contentWidth/2, display.contentHeight/2-180 --중앙 위

	pipe[5] = display.newImage(pipeGroupe, "image/puzzle/pipe_2_2.png")
	pipe[5].x, pipe[5].y = display.contentWidth/2+180, display.contentHeight/2-180 -- 오른쪽 위

	pipe[6] = display.newImage(pipeGroupe, "image/puzzle/pipe_1_2.png")
	pipe[6].x, pipe[6].y = display.contentWidth/2+180, display.contentHeight/2 --오른쪽 중앙

	pipe[7] = display.newImage(pipeGroupe, "image/puzzle/pipe_1_1.png")
	pipe[7].x, pipe[7].y = display.contentWidth/2+180, display.contentHeight/2+180 --오른쪽 아래

	pipe[8] = display.newImage(pipeGroupe, "image/puzzle/pipe_2_2.png")
	pipe[8].x, pipe[8].y = display.contentWidth/2-180, display.contentHeight/2+180 --왼쪽 아래

	pipe[9] = display.newImage(pipeGroupe, "image/puzzle/pipe_1_2.png")
	pipe[9].x, pipe[9].y = display.contentWidth/2, display.contentHeight/2+180 --중앙 아래

	local time = display.newText(10, display.contentWidth * 0.9, display.contentHeight * 0.15)
	time.size = 100
	time:setFillColor(0)

	-----------게임 시작 할 때마다 랜덤으로 파이프가 돌려져 있게끔 배치, arr배열은 몇번 돌릴지를 의미---------
	local arr = {}
	for i=1,9 do
		arr[i] = math.random(4)
	end

	for i=1,9 do
		if(arr[i] == 1) then
			pipe[i]:rotate(90)
		elseif(arr[i] == 2) then
			pipe[i]:rotate(180)
		elseif(arr[i] == 3) then
			pipe[i]:rotate(270)
		end
	end

	--------------기본 글자 세팅 => 실패!
	local flag = display.newText("실패!", display.contentWidth * 0.1, display.contentHeight * 0.15)
	flag.size = 100
	flag:setFillColor(0)

	--------------탭하면 돌아가게끔 구현, 돌린 횟수 1씩 증가
	local function tapPipe(event)
		for i=1,9 do
			if(pipe[i].x-50 < event.target.x and event.target.x < pipe[i].x+50 and pipe[i].y-50 < event.target.y and event.target.y < pipe[i].y+50) then
				pipe[i]:rotate(90)
				arr[i] = arr[i] + 1
			end
		end
	end

	------------돌린 횟수 %4하여 옳은 방향인지 판단, 옳은 방향이면 score 1씩 증가, score가 7이어야만 "실패!" 플래그가 "성공!"으로 바뀜
	local function judge()
		local score = 0
		if(arr[1] % 4 == 0 or arr[1] % 4 == 2) then
			score = score + 1
		end

		if(arr[2] % 4 == 0) then
			score = score + 1
		end

		if(arr[3] % 4 == 3) then
			score = score + 1
		end

		if(arr[4] % 4 == 1) then
			score = score + 1
		end

		if(arr[5] % 4 == 2) then
			score = score + 1
		end

		if(arr[6] % 4 == 0 or arr[6] % 4 == 2) then
			score = score + 1
		end

		if(arr[7] % 4 == 0 or arr[7] % 4 == 2) then
			score = score + 1
		end

		if(score == 7) then
			flag.text = "성공!"
			time.alpha = 0
			for i=1,9 do
				pipe[i]:removeEventListener("tap", tapPipe)
				pipe[i]:removeEventListener("tap", judge)
			end
		else
			flag.text = "실패!"
		end
	end

	for i=1,9 do
		pipe[i]:addEventListener("tap", tapPipe)
		pipe[i]:addEventListener("tap", judge)
	end

	local function counter(event)
		time.text = time.text - 1

		if(time.text == '5') then
			time:setFillColor(1, 0, 0)
		end

		if(time.text == '-1') then
			time.alpha = 0
			-- if(score ~= 5) then
			-- 	시간 내에 완료하지 못했을 경우 나오는 화면 출력하면 됨
			-- end
			for i=1,9 do
				pipe[i]:removeEventListener("tap", tapPipe)
				pipe[i]:removeEventListener("tap", judge)
			end
		end


	end
	timeAttack = timer.performWithDelay(1000, counter, 11)

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
