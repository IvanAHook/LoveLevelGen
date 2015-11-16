require "templates"

room = {}
tile_base = 2
room_w_h = 8

function room.generate_room( room_type, room_x, room_y )
	local room_offset_x = room_x * tile_base * ( room_w_h + 2 )
	local room_offset_y = room_y * tile_base * ( room_w_h + 2 )
	local current_room = get_template( 1 )
	--print( room_offset_x .. "  " .. room_offset_y )
	--print( v.x * tile_base + room_x .. "  " .. v.y * tile_base + room_y )

	for k,v in pairs( current_room ) do
		print( v.x * tile_base + room_x .. "  " .. v.y * tile_base + room_y )
		v.x = v.x * tile_base + room_x --+ room_offset_x
		v.y = v.y * tile_base + room_y --+ room_offset_y
		--print(v.block)
	end

--	for x = 0, room_w_h do
--		for y = 0, room_w_h do
--			if x == 0 or x == room_w_h or y == 0 or y == room_w_h then	
--				table.insert( current_room,
--					{ block = room_type, x = x * tile_base + room_offset_x, y = y * tile_base + room_offset_y } )
--			else
--				table.insert( current_room,
--					{ block = 0, x = x * tile_base + room_offset_x, y = y * tile_base + room_offset_y } )
--			end
--		end
--	end
	return current_room
end

function get_template( type )
	local current_template = templates.get_template( 1 )
	generate_obstacles( current_template, 4, 4 )
	return current_template
end

function generate_obstacles( room, x, y )
	for neighbour_x = x-1, x+1 do
		for neighbour_y = y-1, y+1 do

			local rand_int = love.math.random( 0, 2 )

			if rand_int == 1 then

				for k,v in pairs( room ) do
					if v.x == neighbour_x and v.y == neighbour_y then
						v.block = 1
					end
				end

			end

		end
	end
end
