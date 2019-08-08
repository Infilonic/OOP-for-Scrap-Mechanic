syntaxExtension = {
    version = 0.0;
    initialized = false;
    primitiveTypes = {};

    init = function (self)
        if not self.initialized then
            compiler:compile()
            self:initializeScrapMechanicObjects()
            self.initialized = true
            class = smClass
        end
    end;

    initializeScrapMechanicObjects = function (self)
        local function initSubClassesRecursive(typeName)
            local node = self.typeManager.typeNodeCollection.get(typeName)
            _G[node.getTypeName()] = smClass(self.instantiator.createScriptableInstance(node.getTypeName())())

            if node.hasChildren() then
                for _, node in node.getChildren().iterate() do
                    initSubClassesRecursive(node.getTypeName())
                end
            end
        end

        initSubClassesRecursive("Scriptable")
    end
}

smClass = class

dofile("./PrimitiveTypes/Init.lua")
dofile("./TypeManager/Utility.lua")
dofile("./TypeManager/TypeManager.lua")
dofile("./Compiler/Compiler.lua")
dofile("./Instantiator/Instatiator.lua")
dofile("./ReservedKeywords/InitKeywords.lua")

-- System libraries
dofile("./Libraries/System/InitLibrary.lua")
dofile("./Libraries/ScrapMechanic/InitLibrary.lua")
