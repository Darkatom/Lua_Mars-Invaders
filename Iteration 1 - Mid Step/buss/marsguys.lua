
marsList = {}
marsRemoval = {}

function addGuy( x , y , w )
	local guy = {}
	
	guy.w = w
	guy.h = w
	
	guy.x = x
	guy.y = y
	
	guy.vel = 5
	guy.life = 1
	
	marsList[#marsList + 1] = guy
end

function updateMarsGuys()
	removeTheDeadMarsGuys()

end

function removeTheDeadMarsGuys()
	for m = #marsRemoval, 1, -1 do
		table.remove( marsList, marsRemoval[m] )
	end
	marsRemoval= {}
end

function addMarsToRemoval( index )
	table.insert(marsRemoval, index)
end
