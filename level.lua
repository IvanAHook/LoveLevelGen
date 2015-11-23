
require "room"
require "templates"

level = {}

function level.load()

end

function level.update(dt)

end

function level.generate_level( rooms_x, rooms_y )
	rooms = {}
	for k, v in pairs(rooms) do rooms[k] = nil end
    for k, v in pairs( world:getBodyList() ) do v:destroy() end

	for x = 0, rooms_x-1 do
		for y = 0, rooms_y-1 do
			local room = room.generate_room( love.math.random( 1, 3 ), x, y )
			table.insert( rooms, room )
		end
	end
end

function level.draw()
	for i = 1, #rooms do
		for k,v in pairs( rooms[i] ) do
			love.graphics.setColor( v.color )
			love.graphics.polygon( "fill", v.body:getWorldPoints( v.shape:getPoints() ) )
		end
	end
end
