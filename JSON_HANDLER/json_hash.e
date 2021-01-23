note
	description: "Summary description for {JSON_HASH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_HASH

create
	make

feature  -- Initialization

	collections : ARRAYED_LIST [JSON_COLLECTION]
	identifiers : ARRAYED_LIST [STRING]

	make
			-- Run application.
		do
			create collections.make (0)
			create identifiers.make (0)
		end



feature --Functions

-- ====================================================================================
	add_collection(new_collection : JSON_COLLECTION) : BOOLEAN

		do

			if is_in_hash(new_collection.identifier)
			then
				RESULT := FALSE

			else
				collections.extend (new_collection)
			    identifiers.extend (new_collection.identifier)
			    RESULT := TRUE

			end
		end
-- ====================================================================================

	get_collection(identifier : STRING) : JSON_COLLECTION
	local
		res : JSON_COLLECTION
		index : INTEGER
		do
			create res.make_empty
			if is_in_hash(identifier)
			then
				index := get_index_of(identifier)
				res := collections.at (index)
			end
			RESULT := res
		end
-- ====================================================================================
	get_index_of(identifier : STRING): INTEGER
	local
		i : INTEGER
		cont : INTEGER

		do
			cont := 1

			across collections as collection loop
			    if collection.item.identifier.is_equal (identifier)
			    then
			    	i := cont
			    else
			    	cont := cont + 1
			    end
			end
			RESULT := i
		end
-- ====================================================================================

	project_collection (identifier : STRING ; new_coll_id : STRING ; atributes : ARRAYED_LIST[STRING]) : JSON_COLLECTION
	local
		new_collection : JSON_COLLECTION
		selected_collection : JSON_COLLECTION
		temp_json_document : JSON_OBJECT
		temp_header : JSON_STRING
	do
		create new_collection.make_empty
		selected_collection := get_collection(identifier)
		new_collection.set_identifier (new_coll_id)
		new_collection.set_types (selected_collection.get_header_types(atributes))

		across selected_collection.documents as document loop
			create temp_json_document.make_empty
			across atributes as atribute loop
				create temp_header.make_from_string (atribute.item)
				if attached document.item.item (temp_header) as value then
					temp_json_document.put (value, temp_header)
				end
			end
			new_collection.add_document (temp_json_document)
		end
		RESULT := new_collection
	end

-- ====================================================================================
	select_collection(identifier : STRING; new_coll_id : STRING ; key : STRING ; search_value : STRING) : JSON_COLLECTION
	local
		json_key : JSON_STRING
		selected_collection : JSON_COLLECTION
		result_collection : JSON_COLLECTION
		temp_document : JSON_OBJECT


		do
			create json_key.make_from_string (key)
			create result_collection.make_empty
			selected_collection := get_collection(identifier)
			result_collection.set_identifier (new_coll_id)
			result_collection.set_types(selected_collection.types)


			across selected_collection.documents as document loop
				if attached document.item.item (json_key) as value then

					if match_checker(value,search_value)  then

						result_collection.add_document (document.item)
					end
				end
			end
			Io.new_line
			Io.put_string ("Query Result:")
			Io.new_line
			result_collection.print_collection

			RESULT := result_collection

		end

-- ====================================================================================
	match_checker(value : JSON_VALUE ; search_value : STRING) : BOOLEAN
	local
		temp_string_value : STRING
		flag : BOOLEAN
		fd: FORMAT_DOUBLE


		do
			create fd.make (10, 2)
			flag := FALSE

			if value.is_number then
				temp_string_value := fd.formatted (value.representation.to_real_64)
				temp_string_value.adjust

				if temp_string_value.is_equal (search_value) then
					flag := TRUE
				end
			elseif value.is_string then

				if string_formatter(value.representation).is_equal (search_value) then
					flag := TRUE
				end
			elseif value.is_null then
				print("Im a null")
			else
				if(boolean_formatter(search_value).is_equal(value.representation)) then
					flag := TRUE
				end
			end

			RESULT:= flag
		end
-- ====================================================================================

	boolean_formatter(value : STRING) : STRING
		do
			if value.is_equal ("S") or value.is_equal ("s") or value.is_equal ("TRUE") or value.is_equal ("true") or value.is_equal ("True") then
				RESULT := "true"
			else
				RESULT := "false"
			end
		end

-- ====================================================================================
	is_in_hash(identifier : STRING) : BOOLEAN
	local
		flag : BOOLEAN
	do
		flag := False
		across identifiers as id loop
   			if id.item.is_equal (identifier) then
   				flag := TRUE
   			end
		end
		RESULT:= flag
	end

-- ====================================================================================

	string_formatter(string : STRING) : STRING
		do
			string.remove_head (1)
			string.remove_tail (1)
			RESULT := string
		end

-- ====================================================================================
	print_hash
	do
		across collections as collection loop
			collection.item.print_collection
		end
	end

-- ====================================================================================
	get_colleciton_quantity : INTEGER
		    local
		    	max : INTEGER
		    do
		    	max := 0
		    	across collections as e loop
				    max := max +1
				end
				RESULT := max
		    end
-- ====================================================================================
	print_elements (a_list: LIST[STRING])
				-- Print every elements on `a_list`
			do
				across a_list as ic loop
					print (ic.item.out + "%N")
				end
			end
end
