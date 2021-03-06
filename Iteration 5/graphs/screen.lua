Screen = { 
			w = nil,
			h = nil,
			downLimit = nil
		 }


function loadScreen()
	Screen.w = love.window.getWidth()
	Screen.h = love.window.getHeight()
	Screen.downLimit = Screen.h-(Screen.h/5)
end	 
		 
function drawMainScreen()
	if (#marsList > 0 or ovni.visible) and player.tries > 0 then
		drawEntities()
		drawPlayerStats()		
	elseif player.tries <= 0 then
		love.graphics.draw(imageBank.loser, 0, 0)
		love.graphics.print(player.score, 150, 350, 0, 2.5 )
	elseif CurrentLevel > #level  then
		love.graphics.draw(imageBank.win, 0, 0)
		love.graphics.print(player.score, 150, 350, 0, 2.5 )
	end
end

function drawEntities()
	-- // MARS GUYS //
	for m = 1, #marsList do
		love.graphics.draw( imageBank.mars[marsList[m].tGuy], marsList[m].x, marsList[m].y  )
	--	love.graphics.print( "Life: "..marsList[m].life, marsList[m].x, marsList[m].y + marsList[m].h + 2 )
	end
	
	-- // PLAYER //
	love.graphics.draw( imageBank.player, player.mov.x, player.mov.y )
	
	-- // BULLETS //
	local wMul = 1
	
	for b = 1, #bts["mars"] do
		if bts["mars"][b].tGuy == 100 then wMul = 2 else wMul = 1 end
	
		love.graphics.setColor( marsTypes[bts["mars"][b].tGuy].r , marsTypes[bts["mars"][b].tGuy].g , marsTypes[bts["mars"][b].tGuy].b , 255)
		love.graphics.rectangle("fill", bts["mars"][b].x - 2, bts["mars"][b].y, bts["mars"][b].w*wMul, bts["mars"][b].h*wMul ) 
	end
	
	love.graphics.setColor( 255, 255, 255, 255 )
	
	for b = 1, #bts["player"] do
		love.graphics.rectangle("fill", bts["player"][b].x - 2, bts["player"][b].y, bts["player"][b].w, bts["player"][b].h) 
	end
	
	-- // BUNKERS //
	if level[CurrentLevel].bunker then 
		drawBunkers()		
	end
	
	-- // OVNI //
	if level[CurrentLevel].ovni and ovni.visible then	
		drawOvni()	
--		love.graphics.print( "Life: "..ovni.life, ovni.mov.x, ovni.mov.y + ovni.dimens.h + 2 )
	end
	
end

function drawHearts()

	for h = 0.5, player.life, 1 do
		love.graphics.draw(imageBank.heartL, 20 + (h-0.5)*imageBank.heartW + 5, 410)
	end

	for h = 1, player.life do	
		love.graphics.draw(imageBank.heartR, 20 + imageBank.heartWL + (h-1)*imageBank.heartW + 5, 410)
	end
end

function drawPlayerStats()
	love.graphics.line( 0,Screen.downLimit , Screen.w,Screen.downLimit )

	drawHearts()
		
	love.graphics.print("POWER: "..player.atk, 200, 410)	
	
	love.graphics.print("LEVEL "..CurrentLevel, 30, 450)
	love.graphics.print("COINS: ", 30, 473)
	for h = 1, player.tries do
		love.graphics.draw(imageBank.tries, 50 + h*imageBank.triesW + 5, 470)
	end
	
	love.graphics.print("SCORE: ", 200, 450)
	love.graphics.print(player.score, 200, 470)
end