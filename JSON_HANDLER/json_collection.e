note
	description: "Summary description for {JSON_COLLECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_COLLECTION

create
	make

feature  -- Initialization

	identifier : STRING
	documents : ARRAYED_LIST [JSON_OBJECT]
	file_by_line : ARRAYED_LIST [STRING]


	make(collection_info : ARRAYED_LIST [STRING] ; id : STRING )
			-- Run application.
		do

			create documents.make (0)
			create file_by_line.make(0)
			create identifier.make_from_string (id)
			file_by_line := collection_info
			create_collection
		end


feature --Functions
-- ====================================================================================
	create_json (headers: ARRAYED_LIST [STRING]; types: ARRAYED_LIST [STRING];values: ARRAYED_LIST [STRING]) : JSON_OBJECT
	    local
	    	json: JSON_OBJECT
	    	i: INTEGER_32
	    	max: INTEGER_32
	    	temp_header: JSON_STRING
	    	temp_number: STRING
	    	temp_value: JSON_VALUE
	    	fd: FORMAT_DOUBLE



	    	do
	    		create json.make_empty
	    		create fd.make (10, 2)
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
	    	types: ARRAYED_LIST [STRING]
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
			    temp_json := create_json(headers,types,get_values(file_by_line.at (i)))
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
	    	print("Collection: " +identifier + "%N")
	    	across documents as document loop
			    print(document.item.representation + "%N")
			end
			print("End of Collection"+"%N")
	    end
end
