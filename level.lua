
require "room"
require "templates"

level = {}
level.rooms = {}
level.random_blocks = {}

function level.load()

end

function level.update(dt)

end

function level.generate_level( rooms_x, rooms_y )
	for k, v in pairs(level.rooms) do level.rooms[k] = nil end

	for x = 0, rooms_x-1 do
		for y = 0, rooms_y-1 do
			local room = room.generate_room( tonumber( love.math.random( 1, 3 ) ), x, y )
			table.insert( level.rooms, room )
		end
	end
end

function level.draw()
	for i = 1, #level.rooms do
		for k,v in pairs( level.rooms[i] ) do
			love.graphics.setColor( v.color )
            if v.image ~= nil then
                love.graphics.draw( v.image, v.body:getX(), v.body:getY(), v.body:getAngle(),
                        1, 1, v.image:getWidth()/2, v.image:getHeight()/2 )
            else
                love.graphics.polygon( "fill", v.body:getWorldPoints( v.shape:getPoints() ) )
            end
		end
	end
end
