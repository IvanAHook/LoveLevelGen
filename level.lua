
require "room"
require "templates"

level = {}
level.rooms = { --make function to get index in 2d grid
				--[[0, 0, 0, 0,  -- 1, 2, 3, 4,
				0, 0, 0, 0,  --	5, 6, 7, 8,
				0, 0, 0, 0,  --	9, 10, 11, 12,
				0, 0, 0, 0]] --	13, 14, 15, 16
	 			}

--local room = love.math.random( 1, 4 )
--local room_type = love.math.random( 1, 5 )
--get_room( room , 1 ) = function() if room_type == 5 then return 2 else return 1 end end

function level.load()
end

function level.update(dt)
end

function get_room( x, y )
	return level.rooms[ x + 4*(y-1) ]
end

function level.generate_level( rooms_x, rooms_y )
	for k, v in pairs(level.rooms) do level.rooms[k] = nil end

	for x = 0, rooms_x-1 do
		for y = 0, rooms_y-1 do
			local room = room.generate_room( tostring( love.math.random( 1, 3 ) ), x, y )
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
