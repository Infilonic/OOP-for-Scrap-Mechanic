typeAbstraction = {
	create = function (typeName)
		local concreteTypeAbstraction = {
			type = typeName,
			definitionTable = {},
			baseType = ""
		}

		return concreteTypeAbstraction
	end
}
