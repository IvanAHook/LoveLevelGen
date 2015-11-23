require "templates"

room = {}

tile_base = 20
room_w_h = 8*tile_base

function room.generate_room( room_type, room_x, room_y )
	local room_offset_x = room_x*room_w_h
	local room_offset_y = room_y*room_w_h
	local objects = {}
	local template = templates.get_template( 0 )

	generate_obstacles( template, 3, 3 )

	for k,v in pairs( template ) do
		if v.block == 1 then
			local block = {}
			block.body = love.physics.newBody( world, v.x*tile_base+tile_base/2+room_offset_x, v.y*tile_base+tile_base/2+room_offset_y )
			block.shape = love.physics.newRectangleShape( 0, 0, tile_base, tile_base )
			block.fixture = love.physics.newFixture( block.body, block.shape )
			block.color = { 0, 0, 0 }
			table.insert( objects, block )
		end
		if v.block == 2 then
			local block = {}
			block.body = love.physics.newBody( world, v.x*tile_base+tile_base/2+room_offset_x, v.y*tile_base+tile_base/2+room_offset_y, "dynamic" )
			block.shape = love.physics.newRectangleShape( 0, 0, tile_base, tile_base )
			block.fixture = love.physics.newFixture( block.body, block.shape )
			block.color = { 50, 255, 50 }
			block.fixture:setRestitution(0)
            block.fixture:setFriction(1)
			table.insert( objects, block )
		end
		if v.block == "L" then
			local block = {}
			block.body = love.physics.newBody( world, v.x*tile_base+tile_base/2+room_offset_x, v.y*tile_base+tile_base/2+room_offset_y )
			block.shape = love.physics.newRectangleShape( 0, 0, tile_base, tile_base )
			block.fixture = love.physics.newFixture( block.body, block.shape )
			block.color = { 255, 50, 50 }
			table.insert( objects, block )
		end

	end

	return objects
end

function generate_obstacles( template, x, y )
	for neighbour_x = x, x+1 do
		for neighbour_y = y, y+1 do

			local rand_int = love.math.random( 0, 3 )

			if rand_int == 1 then

				for k,v in pairs( template ) do
					if v.x == neighbour_x and v.y == neighbour_y and v.block == 0 then
						v.block = 2
					end
				end

			end

		end
	end
	return template
end

function new_block( x, y, color, block_type, ... )
	local block = {}
	block.body = love.physics.newBody( world, x, y, block_type )
	block.shape = love.physics.newRectangleShape( 0, 0, tile_base, tile_base )
	block.fixture = love.physics.newFixture( block.body, block.shape )
	block.color = color

	if #arg > 0 then
		block.fixture:setRestitution(arg[1])
    	block.fixture:setFriction(arg[2])
	end 

	return block

end