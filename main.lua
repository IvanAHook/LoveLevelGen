io.stdout:setvbuf("no")

require "level"
require "templates"

use_template = true

function love.load()
	templates.get_templates_from_file( "templates.txt" )
	if use_template then
		level.use_template = use_template
		level.generate_level_with_templates( 2, 2 )
	else
		level.use_template = use_template
		level.generate_level( 2, 2 )		
	end
	

end

function love.keypressed( key )
	if key == "r" then
		level.generate_level( 2, 2 )
	end
end

function love.update(dt)

end

function love.draw()
    level.draw()
end