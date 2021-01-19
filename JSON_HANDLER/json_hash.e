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
	is_in_hash(identifier : STRING) : BOOLEAN
	do
		across identifiers as id loop
   			if id.item.is_equal (identifier) then
   				RESULT := TRUE
   			else
   				RESULT := FALSE
   			end
		end
	end
-- ====================================================================================
	print_hash
	do
		across collections as collection loop
			collection.item.print_collection
		end
	end
end
