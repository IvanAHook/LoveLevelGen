require "templates"

room = {}

tile_base = 20
room_w_h = 8*tile_base
box_image = love.graphics.newImage( "assets/img/crate.jpg" )


function room.generate_room( room_type, room_x, room_y )
	local room_offset_x = room_x*room_w_h
	local room_offset_y = room_y*room_w_h
	local objects = {}
	local template = templates.get_template( 0 )

	for k,v in pairs( template ) do
		if v.block == 1 then
            table.insert( objects, new_block( v.x*tile_base+tile_base/2+room_offset_x, v.y*tile_base+tile_base/2+room_offset_y, "static", { 0, 0, 0 }, nil ) )
		elseif v.block == 2 then
            -- no block 2 atm
		elseif  v.block == "L" then
            table.insert( objects, new_block( v.x*tile_base+tile_base/2+room_offset_x, v.y*tile_base+tile_base/2+room_offset_y, "static", { 255, 50, 50 }, nil ) )
		elseif v.block == "R" then
            local rand_int = nil
            rand_int = love.math.random( 0, 3 )
 			if rand_int == 1 then
                table.insert( objects, new_block( v.x*tile_base+tile_base/2+room_offset_x, v.y*tile_base+tile_base/2+room_offset_y, "dynamic", { 255, 255, 255 }, box_image, 0, 1 ) )
            else
                table.insert( objects, new_block( v.x*tile_base+tile_base/2+room_offset_x, v.y*tile_base+tile_base/2+room_offset_y, "static", { 255, 50, 255 }, nil ) )
            end
        end

	end

	return objects
end

function new_block( x, y, block_type, color, image, ... )
    local block = {}
    block.body = love.physics.newBody( world, x, y, block_type )
    block.shape = love.physics.newRectangleShape( 0, 0, tile_base, tile_base )
    block.fixture = love.physics.newFixture( block.body, block.shape )
    block.color = color
    if image ~= nil then
        block.image = image
    end
    if args ~= nil and #args < 0 then
        block.fixture:setRestitution( args[1] )
        block.fixture:setFriction( args[2] )
    end
    return block
end

function generate_obstacles( room, x, y ) -- make all the random blocks into their own table?
    local random_blocks = {}

    for k, v in pairs( room ) do
        if v.block == "R" then
            local rand_int = nil
            rand_int = love.math.random( 0, 3 )
 			if rand_int == 1 then
                v.block = 2
            else
                v.block = 1
            end
        end
    end

	return room
end
