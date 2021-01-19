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

	make
			-- Run application.
		do
			create collections.make (0)
		end

end
