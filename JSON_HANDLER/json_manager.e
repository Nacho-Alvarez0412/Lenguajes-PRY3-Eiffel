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
			print("File loaded succesfully!!"+"%N")
			file_manager.print_file
		end
-- ====================================================================================
	save_to_hash(identifier : STRING)

	local
		temp_collection : JSON_COLLECTION

		do
			create temp_collection.make (file_manager.file_by_line,identifier)

			temp_collection.print_collection
		end
end
