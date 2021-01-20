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
	print_hash
	do
		across collections as collection loop
			collection.item.print_collection
		end
	end

-- ====================================================================================
	get_colleciton_quantity() : INTEGER
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
