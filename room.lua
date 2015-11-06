room = {}
tile_base = 20
room_w_h = 8

function room.generate_room( room_type, room_x, room_y )
	local room_offset_x = room_x * tile_base * ( room_w_h + 2 )
	local room_offset_y = room_y * tile_base * ( room_w_h + 2 )
	local current_room = {}

	for x = 0, room_w_h do
		for y = 0, room_w_h do
			if x == 0 or x == room_w_h or y == 0 or y == room_w_h then	
				table.insert( current_room,
					{ block = room_type, x = x * tile_base + room_offset_x, y = y * tile_base + room_offset_y } )
			else
				table.insert( current_room,
					{ block = 0, x = x * tile_base + room_offset_x, y = y * tile_base + room_offset_y } )
			end
		end
	end
	room.generate_obstacles( current_room , 4 * tile_base + room_offset_x, 4 * tile_base + room_offset_y )
	return current_room
end

function room.generate_obstacles( room, x, y )

	for neighbour_x = x-tile_base, x+tile_base do
		for neighbour_y = y-tile_base, y+tile_base do

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
