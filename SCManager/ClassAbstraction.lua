classAbstraction = {
	create = function (className)
		local concreteClass = {
			className = className,
			classDefinitionTable = {},
			baseClass = ""
		}

		return concreteClass
	end
}