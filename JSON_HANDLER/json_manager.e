note
	description: "Summary description for {JSON_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_MANAGER

create
	make

feature --Initialization
	file_manager : FILE_MANAGER
	collections : JSON_HASH

	make
		do
			create file_manager.make
			create collections.make
		end

feature -- Functions
-- ====================================================================================
	load_file (path : STRING)
		do
			file_manager.read_file(path)
			io.put_new_line
			io.put_string("File loaded succesfully!!"+"%N")
			io.put_new_line
			io.put_string("File content..."+"%N")
			file_manager.print_file
		end
-- ====================================================================================
	save_to_hash(identifier : STRING)

	local
		temp_collection : JSON_COLLECTION

		do
			create temp_collection.make (file_manager.file_by_line,identifier)
			if collections.add_collection (temp_collection)
			then
				io.put_new_line
			    io.put_string("Colleciton added successfully"+ "%N")
			    io.put_new_line
			    io.put_string("Collection content..."+"%N")
			    temp_collection.print_collection
			else
				io.put_new_line
			    io.put_string("Colleciton already exists in HashTable"+ "%N")
			    io.put_new_line
			end

		end
-- ====================================================================================
	reset_load
		do
			file_manager.file_by_line.chain_wipe_out
		end

-- ====================================================================================
end
