note
	description: "JSON_HANDLER application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	terminal : TERMINAL

	make
		do
			create terminal.make
		end

end
