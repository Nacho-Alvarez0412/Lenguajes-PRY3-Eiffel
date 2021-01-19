note
	description: "JSON_HANDLER application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	json_manager : JSON_MANAGER

	make
		do
			create json_manager.make
			json_manager.load_file ("Resources/Integrantes.csv")
			json_manager.save_to_hash("Prueba")
		end

end
