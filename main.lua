io.stdout:setvbuf("no")

require "level"
require "templates"


function love.load()
	love.physics.setMeter( 64 )
	world = love.physics.newWorld( 0, 9.81*64, true )

	templates.get_templates_from_file( "templates.txt" )
	level.use_template = use_template
	level.generate_level( 2, 2 )
end

function love.keypressed( key )
	if key == "r" then
		level.generate_level( 1, 1 )
	end
end

function love.update(dt)

end

function love.draw()
    level.draw()
end