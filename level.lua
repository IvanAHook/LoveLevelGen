
require "room"
require "templates"

level = {}
level.rooms = {}

function level.load()

end

function level.update(dt)

end

function level.generate_level( rooms_x, rooms_y )
	for k in pairs( level.rooms ) do level.rooms[k] = nil end

	for x = 0, rooms_x-1 do
		for y = 0, rooms_y-1 do
			local room = room.generate_room( love.math.random( 1, 3 ), x*160, y*160 )
			table.insert( level.rooms, room )
		end
	end
end

--function level.generate_level_with_templates( rooms_x, rooms_y )
--	for k in pairs( level.rooms ) do level.rooms [k] = nil end
--
--	for x = 0, rooms_x-1 do
--		for y = 0, rooms_y-1 do
--			print( x .. " " .. y )
--			local room = templates.get_template( 1 )
--			table.insert( level.rooms, { room = room, room_x = x*160, room_y = y*160 } )
--		end
--	end
--end

function level.draw()
	for i = 1, #level.rooms do
		for k,v in pairs( level.rooms[i] ) do
			--print( v.block .. "  " .. v.x .. "  " .. v.y )
			love.graphics.setColor( 0, 255, 255, 255 )
			love.graphics.print( v.block, v.x, v.y, 1, 1, 1, 0, 0, 0 )
		end
	end
end
