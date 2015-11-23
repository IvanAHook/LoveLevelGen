templates = {
    ["1"] = {},
    ["2"] = {},
    ["3"] = {}
}

function templates.get_templates_from_file( file )

	local template = {}
	y = 1
	for line in love.filesystem.lines( file ) do
		for x = 0, string.len( line ) do
			if string.sub( line, x, x ) == "N" then
                local room_type = string.sub( line, x+1, x+1 )
				table.insert( templates[ room_type ], template )
				template = {}
				y = 0
				break
			elseif string.sub( line, x, x ) == "1" then
				table.insert( template, { block = 1, x = x, y = y } )
			elseif string.sub( line, x, x ) == "0" then
				table.insert( template, { block = 0, x = x, y = y } )
			elseif string.sub( line, x, x ) == "L" then
				table.insert( template, { block = "L", x = x, y = y } )
			elseif string.sub( line, x, x ) == "R" then
				table.insert( template, { block = "R", x = x, y = y } )
			elseif string.sub( line, x, x ) == "X" then
				table.insert( template, { block = "X", x = x, y = y } )
			end
		end
		y = y+1
	end

end

function templates.get_template( room_type )
	return templates[ room_type ][ love.math.random( 1, #templates[ room_type ] ) ]
end
