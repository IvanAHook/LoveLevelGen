io.stdout:setvbuf("no")

require "level"
require "templates"


function love.load()
    flags = {}
    flags.fullscreen = false
    flags.vsync = true
    flags.fsaa = 0
    flags.resizable = false
    flags.display = 1
    flags.centered = true
    love.window.setTitle( "PCG" )
    success = love.window.setMode( 800, 600, flags )	

    love.graphics.setBackgroundColor( 255, 255, 255 )

	love.physics.setMeter( 64 )
	world = love.physics.newWorld( 0, 9.81*64, true )

	templates.get_templates_from_file( "templates.txt" )

    level.generate_level( 4, 2 )

end

function love.keypressed( key )
	if key == "r" then
        for k, v in pairs( world:getBodyList() ) do v:destroy() end
		level.generate_level( 4, 2 )
	end
end

function love.update(dt)
    world:update(dt)
end

function love.draw()
    level.draw()
end