note
	description: "Summary description for {TERMINAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TERMINAL

create
	make

feature  -- Initialization
	json_manager : JSON_MANAGER

	make
		do
			create json_manager.make
			start_menu
		end

feature -- Functions
-- ====================================================================================
	start_menu
		do
			Io.put_string ("WELCOME TO JSON HANDLER %N")
			Io.new_line
			Io.put_string ("What do you want to do?... %N")
			Io.new_line
			Io.put_string ("1.Load a csv file %N")
			Io.put_string ("2.Save as a JSON file %N")
			Io.put_string ("3.Save as a csv file %N")
			Io.put_string ("4.Execute a SELECT query %N")
			Io.put_string ("5.Project a given JSON structure %N")
			Io.put_string ("6.Exit %N")
			Io.new_line
			Io.new_line
			Io.put_string ("Select an option (Choose a number from 1-6):  ")
			Io.read_integer


			if Io.last_integer = 1 then
				load_csv_menu
			elseif Io.last_integer = 2 then
				save_json_menu
			elseif Io.last_integer = 3 then
				save_csv_menu
			elseif Io.last_integer = 4 then
				select_menu
			elseif Io.last_integer = 5 then
				print("about to project a JSON")
			elseif Io.last_integer = 6 then
				Io.new_line
				Io.put_string ("Quitting...")
			else
				print("Invalid option selected")
			end
		end
-- ====================================================================================
	load_csv_menu
		do
			Io.new_line
			Io.new_line
			Io.new_line
			Io.put_string ("LOAD A CSV FILE %N")
			Io.new_line
			Io.put_string ("For usage execute the command with the following syntax... %N")
			Io.put_string ("load [Name for storage] [Path] %N")
			Io.new_line
			Io.new_line
			Io.put_string ("Enter command: ")
			Io.read_line
			get_load_values
			Io.new_line
			Io.new_line
			Io.put_string ("Press any key to go back to start menu...")
			Io.read_line
			Io.new_line
			Io.new_line
			start_menu
		end

-- ====================================================================================
	select_menu
		do
			Io.new_line
			Io.new_line
			Io.new_line
			Io.put_string ("SELECT QUERY MENU %N")
			Io.new_line
			Io.put_string ("For usage execute the command with the following syntax... %N")
			Io.put_string ("select [Name of Collection] [New JSON] [Llave] = [Valor] %N")
			Io.new_line
			Io.new_line
			Io.put_string ("Enter command: ")
			Io.read_line
			get_select_values
			Io.new_line
			Io.new_line
			Io.put_string ("Press any key to go back to start menu...")
			Io.read_line
			Io.new_line
			Io.new_line
			start_menu
		end
-- ====================================================================================
	save_json_menu
		do
			Io.new_line
			Io.new_line
			Io.new_line
			Io.put_string ("SAVE A JSON FILE %N")
			Io.new_line
			Io.put_string ("For usage execute the command with the following syntax... %N")
			Io.put_string ("save [Name of structure] [Storage Path] %N")
			Io.new_line
			Io.new_line
			Io.put_string ("Enter command: ")
			Io.read_line
			get_save_json_values
			Io.new_line
			Io.new_line
			Io.put_string ("Press any key to go back to start menu...")
			Io.read_line
			Io.new_line
			Io.new_line
			start_menu
		end

-- ====================================================================================

	save_csv_menu
		do
			Io.new_line
			Io.new_line
			Io.new_line
			Io.put_string ("SAVE A CSV FILE %N")
			Io.new_line
			Io.put_string ("For usage execute the command with the following syntax... %N")
			Io.put_string ("savecsv [Name of structure] [Storage Path] %N")
			Io.new_line
			Io.new_line
			Io.put_string ("Enter command: ")
			Io.read_line
			get_save_csv_values
			Io.new_line
			Io.new_line
			Io.put_string ("Press any key to go back to start menu...")
			Io.read_line
			Io.new_line
			Io.new_line
			start_menu
		end

-- ====================================================================================

	get_select_values
	local
		identifier : STRING
		values : ARRAYED_LIST [STRING]
		new_collection : JSON_COLLECTION
		do
			create values.make(0)
			values := get_words(io.last_string)
			values := get_select_words(values)
			new_collection := json_manager.collections.select_collection(values.at (2),values.at (3),values.at (4),values.at (5))
			json_manager.store_collection(new_collection)



		end

-- ====================================================================================
	get_save_json_values
	local
		path : STRING
		identifier : STRING
		words : ARRAYED_LIST [STRING]
		temp_collection : JSON_COLLECTION
		do
			create words.make(0)
			words := get_words(io.last_string)

			identifier := words.at (2)
			path := words.at (3)
			temp_collection := json_manager.collections.get_collection(identifier)
			json_manager.file_manager.write_file(path,temp_collection.get_collection_as_string_json)
			Io.new_line
			Io.put_string("Saving collection as a JSON file at: "+path)


		end

-- ====================================================================================
	get_save_csv_values
	local
		path : STRING
		identifier : STRING
		words : ARRAYED_LIST [STRING]
		temp_collection : JSON_COLLECTION
		do
			create words.make(0)
			words := get_words(io.last_string)

			identifier := words.at (2)
			path := words.at (3)
			temp_collection := json_manager.collections.get_collection(identifier)

			json_manager.file_manager.write_file(path,temp_collection.get_collection_as_string_csv)
			Io.new_line
			Io.put_string("Saving collection as a CSV file at: "+path)


		end

-- ====================================================================================
	get_load_values
	local
		path : STRING
		identifier : STRING
		words : ARRAYED_LIST [STRING]
		do
			create words.make(0)
			words := get_words(io.last_string)

			identifier := words.at (2)
			path := words.at (3)
			if json_manager.collections.is_in_hash (identifier) then
				Io.new_line
				Io.put_string ("Collection already exists in the data set...")

			else
				json_manager.load_file (path)
				json_manager.save_to_hash (identifier)
			end
			json_manager.reset_load
			Io.new_line
			Io.put_string ("Number of collections in data set: ")
			io.put_integer (json_manager.collections.get_colleciton_quantity)
		end
-- ====================================================================================
	get_words(string : STRING) : ARRAYED_LIST [STRING]
	local
		words : ARRAYED_LIST [STRING]
		word : STRING
		do
			create word.make_empty
			create words.make (0)
			across string as char loop
			    if char.item = ' '
				then
				    words.extend (word)
				    word := ""
				else
				    word.append_character (char.item)
				end
			end
			words.extend (word)
			RESULT := words
		end
-- ====================================================================================

	get_select_words(words : ARRAYED_LIST [STRING]) : ARRAYED_LIST [STRING]
	local
		words_res : ARRAYED_LIST [STRING]
		word : STRING
		size : INTEGER
		i : INTEGER
		do
			create words_res.make(0)
			create word.make_empty
			size := words.count

			from
			    i := 1
			until
			    i > size
			loop
			    if i <= 4 then
			    	words_res.extend (words.at (i))
			    elseif i > 5 then
			    	word.append (" "+words.at (i))
			    end
			    i := i + 1
			end

			if not (word.is_empty) then
				word.remove_head (1)
				words_res.extend (word)
			end
			RESULT := words_res
		end

-- ====================================================================================
	print_elements (a_list: LIST[STRING])
				-- Print every elements on `a_list`
			do
				across a_list as ic loop
					print (ic.item.out + "%N")
				end
			end
-- ====================================================================================
end
