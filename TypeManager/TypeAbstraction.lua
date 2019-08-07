syntaxExtension.primitiveTypes.typeAbstraction = {
	new = function (typeName)
		local primitiveTypes = syntaxExtension.primitiveTypes
		local closure = {
			typeName = typeName;
			definitionTable = primitiveTypes.dictionary.new();
			baseType = "";
			getTypeName = primitiveTypes.typeAbstraction.getTypeName;
			getDefinitionTable = primitiveTypes.typeAbstraction.getDefinitionTable;
			setDefinitionTable = primitiveTypes.typeAbstraction.setDefinitionTable;
			getBaseType = primitiveTypes.typeAbstraction.getBaseType;
			setBaseType = primitiveTypes.typeAbstraction.setBaseType
		}

		local concreteTypeAbstraction = {
			getTypeName = function ()
				return closure:getTypeName()
			end;

			getDefinitionTable = function ()
				return closure:getDefinitionTable()
			end;

			setDefinitionTable = function (definitionTable)
				closure:setDefinitionTable(definitionTable)
			end;

			getBaseType = function ()
				return closure:getBaseType()
			end;

			setBaseType = function (typeName)
				closure:setBaseType(typeName)
			end
		}

		return concreteTypeAbstraction
	end;

	getTypeName = function (self)
		return self.typeName
	end;

	getDefinitionTable = function (self)
		return self.definitionTable
	end;

	setDefinitionTable = function (self, definitionTable)
		self.definitionTable = definitionTable
	end;

	getBaseType = function (self)
		return self.baseType
	end;

	setBaseType = function (self, typeName)
		self.baseType = typeName
	end
}
