require "templates"

room = {}

tile_base = 32
room_w_h = 8*tile_base
box_img = love.graphics.newImage( "assets/img/crate.jpg" )
ladder_img = love.graphics.newImage( "assets/img/ladder.jpg" )
stone_img = { love.graphics.newImage( "assets/img/stone.jpg" ), love.graphics.newImage( "assets/img/stone_gold.jpg" ) }
--stone_img = {} -- get random tiling stone img 

function room.generate_room( room_type, room_x, room_y )
	local room_offset_x = (room_x-1)*room_w_h
	local room_offset_y = (room_y-1)*room_w_h
	local objects = {}
	local template = templates.get_template( room_type )

	for k,v in pairs( template ) do
		if v.block == 1 then
            table.insert( objects,
                new_block( tile_base*( v.x + 0.5 )+room_offset_x, tile_base*( v.y + 0.5 )+room_offset_y, "static", { 255, 255, 255 }, stone_img[ love.math.random( 1, #stone_img ) ] ) )
		elseif v.block == 2 then
			table.insert( objects,	
            	new_block( tile_base*( v.x + 0.5 )+room_offset_x, tile_base*( v.y + 0.5 )+room_offset_y, "dynamic", { 255, 255, 255 }, box_img, 0, 1 ) )
		elseif  v.block == "L" then
            table.insert( objects,
                new_block( tile_base*( v.x + 0.5 )+room_offset_x, tile_base*( v.y + 0.5 )+room_offset_y, "static", { 255, 255, 255 }, ladder_img ) )
		elseif v.block == "R" then

            local rand_int = nil
            rand_int = love.math.random( 0, 3 )
 			if rand_int == 1 then
                table.insert( objects,
                    new_block( tile_base*( v.x + 0.5 )+room_offset_x, tile_base*( v.y + 0.5 )+room_offset_y, "dynamic", { 255, 255, 255 }, box_img, 0, 1 ) )
            else
                table.insert( objects,
                    new_block( tile_base*( v.x + 0.5 )+room_offset_x, tile_base*( v.y + 0.5 )+room_offset_y, "static", { 255, 50, 255 }, stone_img[ love.math.random( 1, #stone_img ) ] ) )
            end

        end

	end

	return objects
end

function new_block( x, y, block_type, color, image, ... )
    local block = {}
    local radius = 0.64
    block.body = love.physics.newBody( world, x, y, block_type )
    block.shape = love.physics.newRectangleShape( radius, radius, tile_base-radius*2, tile_base-radius*2 )
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
