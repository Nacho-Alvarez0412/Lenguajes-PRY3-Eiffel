note
	description: "Summary description for {FILE_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_MANAGER

create
	make

feature  -- Initialization

	file_by_line : ARRAYED_LIST [STRING]




	make
			-- Run application.
		do
			create file_by_line.make (0)
		end
feature -- Functions

-- ====================================================================================
	read_file(stringPath : STRING)
				-- Opens a plain text file an stores it in
				-- loaded_json for later conv ersion
	local
		my_file: PLAIN_TEXT_FILE
		path: PATH
      	temp_line : STRING
	do
    	create path.make_from_string (stringPath)
	  	create my_file.make_with_path (path)

	    from
	    	my_file.open_read
		until
		    my_file.exhausted
		loop
			my_file.readline
			create temp_line.make_from_string (my_file.laststring)
			file_by_line.extend (temp_line)
		end
	      my_file.close
    end
-- ====================================================================================
    print_file

    do
    	across file_by_line as line loop
		    print(line.item + "%N")
		end

    end
-- ====================================================================================
end
