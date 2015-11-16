templates = {}

function templates.get_templates_from_file( file )

	local template = {}
	y = 0
	for line in love.filesystem.lines( file ) do
		for x = 0, string.len( line ) do
			if string.sub( line, x, x ) == "N" then
				for k,v in pairs( template ) do
--					print(v.block)
				end
				table.insert( templates, template )
				y = 0
			elseif string.sub( line, x, x ) == "1" then
				table.insert( template, { block = 1, x = x, y = y } )
			elseif string.sub( line, x, x ) == "0" then
				table.insert( template, { block = 0, x = x, y = y } )
			end
--			print( x .. " " .. y )
		end
		y = y+1
	end

end

function templates.get_template( type )
	return templates[ love.math.random( 1, #templates ) ]
end