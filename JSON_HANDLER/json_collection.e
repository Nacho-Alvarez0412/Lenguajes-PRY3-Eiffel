note
	description: "Summary description for {JSON_COLLECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_COLLECTION

create
	make,
	make_empty

feature  -- Initialization

	identifier : STRING
	documents : ARRAYED_LIST [JSON_OBJECT]
	file_by_line : ARRAYED_LIST [STRING]
	types : ARRAYED_LIST [STRING]


	make(collection_info : ARRAYED_LIST [STRING] ; id : STRING )
			-- Run application.
		do

			create documents.make (0)
			create file_by_line.make(0)
			create identifier.make_from_string (id)
			file_by_line := collection_info
			create_collection
		end

	make_empty
		do
			create documents.make (0)
			create file_by_line.make(0)
			create types.make(0)
			create identifier.make_from_string ("")
		end


feature --Functions
-- ====================================================================================
	set_identifier(id : STRING)
		do
			identifier := id
		end
-- ====================================================================================
	add_document(document : JSON_OBJECT)
		do
			documents.extend (document)
		end
-- ====================================================================================
	set_types(new_types : ARRAYED_LIST [STRING])
		do
			types := new_types
		end
-- ====================================================================================
	create_json (headers: ARRAYED_LIST [STRING]; values: ARRAYED_LIST [STRING]) : JSON_OBJECT
	    local
	    	json: JSON_OBJECT
	    	i: INTEGER_32
	    	max: INTEGER_32
	    	temp_header: JSON_STRING


	    	do
	    		create json.make_empty
	    		from
				    i := 1
				    max := headers.capacity
				until
				    i > max
				loop
					create temp_header.make_from_string (headers.at (i))

				    if types.at(i).is_equal ("X") then
					    json.put_string (values.at(i),temp_header)

					elseif types.at(i).is_equal ("N") then
						json.put_real (values.at(i).to_real_64, temp_header)

					elseif types.at(i).is_equal ("B") then
					    json.put_boolean (get_bool_values(values.at(i)), temp_header)
					end
				    i := i + 1
				end

				RESULT := json
			end

-- ====================================================================================
	create_collection
	    			-- Creates new collection to add to the hash table
	    local
	    	headers: ARRAYED_LIST [STRING]
	    	temp_json: JSON_OBJECT
	    	i : INTEGER
	    	max : INTEGER

	    do
	    	create headers.make_from_iterable (get_values(file_by_line.at (1)))
	    	create types.make_from_iterable (get_values(file_by_line.at (2)))
	    	create temp_json.make_empty

			from
			    i := 3
				max := get_size_array(file_by_line)
			until
			    i = max
			loop
			    temp_json := create_json(headers,get_values(file_by_line.at (i)))
			    documents.extend (temp_json)
			    i := i + 1
			end
	    end

-- ====================================================================================
	get_size_array(array: ARRAYED_LIST [STRING]) : INTEGER
	    local
	    	max : INTEGER
	    do
	    	max := 0
	    	across file_by_line as e loop
			    max := max +1
			end
			RESULT := max
	    end

-- ====================================================================================
	get_bool_values(string: STRING) : BOOLEAN

		do
			if string.is_equal ("S")
			then
			    RESULT := TRUE
			else
			    RESULT := FALSE
			end
		end
-- ====================================================================================
	get_values(string:STRING) : ARRAYED_LIST [STRING]
	    local
	    	word: STRING
	    	headers: ARRAYED_LIST [STRING]
	    do

	    	create word.make_empty
	    	create headers.make (0)

	    	across string as char loop
	    		if char.item = ';'
				then
				    headers.extend (word)
				    word := ""
				else
				    word.append_character (char.item)
				end
			end
			headers.extend (word)
			RESULT := headers
	    end
-- ====================================================================================
	print_collection

	    do
	    	io.put_string("Collection: " +identifier + "%N")
	    	across documents as document loop
			    io.put_string(document.item.representation + "%N")
			end
			io.put_string("End of Collection"+"%N")
	    end
-- ====================================================================================
	get_collection_as_string_json : STRING
	local
		text : STRING

		do
			create text.make_empty
			text.append("["+"%N")
	    	across documents as document loop
			    text.append(document.item.representation +","+ "%N")
			end
			text.remove_tail (2)
			text.append("%N"+"]")
			RESULT := text
		end

-- ====================================================================================
	get_collection_as_string_csv : STRING
	local
		text : STRING
		headers : ARRAYED_LIST [STRING]
		content : STRING

		do
			create text.make_empty
			create headers.make (0)
			create content.make_empty

			headers := get_headers
			content := get_contents(headers)
	    	text.append (join(headers))
	    	text.append (join(types))
	    	text.append (content)
	    	RESULT := text
		end

-- ====================================================================================

	join(list : ARRAYED_LIST[STRING]) : STRING
	local
		text : STRING
		do
			create text.make_empty
			across list  as element loop
				text.append (element.item+";")
			end
			text.remove_tail (1)
			text.append ("%N")
			RESULT := text
		end

-- ====================================================================================	

	get_contents(headers : ARRAYED_LIST[STRING]) : STRING
	local
		text : STRING
		temp_header : JSON_STRING
		fd : FORMAT_DOUBLE
		temp_number : STRING
		temp_value : STRING
		do
			create text.make_empty
			create fd.make (10, 2)

			across documents as document loop
			    across headers as header loop
					create temp_header.make_from_string (header.item)
					if attached document.item.item (temp_header) as value  then
						create temp_value.make_empty
						if value.is_number then
							create temp_number.make_empty
							temp_number := fd.formatted (value.representation.to_real_64)
							temp_number.adjust
							text.append(temp_number)
						else
							temp_value := value.representation
							temp_value.remove_tail (1)
							temp_value.remove_head (1)
							text.append (temp_value)
						end
					end
					text.append (";")
				end
				text.remove_tail (1)
				text.append ("%N")
			end
			RESULT := text
		end

-- ====================================================================================			
		get_headers : ARRAYED_LIST[STRING]
		local
			temp_document : JSON_OBJECT

			do
				temp_document := documents.at (1)
				RESULT := to_string_array(temp_document.current_keys)
			end
-- ====================================================================================
	to_string_array (a_list: ARRAY[JSON_STRING]) : ARRAYED_LIST[STRING]
	local
		list : ARRAYED_LIST[STRING]
				-- Print every elements on `a_list`
			do
				create list.make(0)
				across a_list as ic loop
					list.extend (ic.item.debug_output)
				end
				RESULT := list
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
	print_elements_json (a_list: ARRAY[JSON_STRING])
				-- Print every elements on `a_list`
			do
				across a_list as ic loop
					print (ic.item.debug_output + "%N")
				end
			end
-- ====================================================================================
end
