
require "room"
require "templates"

level = {}
level.rooms = {}
level.rooms_template = { --make function to get index in 2d grid
				"0", "0", "0", "0",  -- 1, 2, 3, 4,
				"0", "0", "0", "0",  --	5, 6, 7, 8,
				"0", "0", "0", "0",  --	9, 10, 11, 12,
				"0", "0", "0", "0" --	13, 14, 15, 16
	 			}

function level.load()
end

function level.update(dt)
end

function get_room_type( x, y )
	return level.rooms_template[ x + 4*(y-1) ]
end

function get_room_index( x, y )
	return x + 4*(y-1)
end

function level.generate_solution_path( rooms_x, rooms_y )
	for k, v in pairs(level.rooms_template) do level.rooms_template[k] = "0" end

    local y = 1
    local x = love.math.random( 1, 4 )
    local direction
    level.rooms_template[ get_room_index( x, y ) ] = "1"

    while y <= 4 do
        if x == 4 then
            direction = 5
        else
            direction = love.math.random( 1, 5 )
        end

        if direction == 5 then
        	level.rooms_template[ get_room_index( x, y ) ] = "2"
            y = y+1
        elseif direction == ( 1 or 2 ) then
        	x = x-1
        	level.rooms_template[ get_room_index( x, y ) ] = "1"
        elseif direction == ( 3 or 4 ) then
        	x = x+1
        	level.rooms_template[ get_room_index( x, y ) ] = "1"
        end
    end
	level.generate_level( rooms_x, rooms_y )
end

function level.generate_level( rooms_x, rooms_y )
	for k, v in pairs(level.rooms) do level.rooms[k] = nil end

	for x = 1, rooms_x do
		for y = 1, rooms_y do
			local room = room.generate_room( get_room_type( x, y ), x, y )
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
