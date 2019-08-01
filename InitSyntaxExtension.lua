syntaxExtension = {
    version = 0.0;
    initialized = false;
    init = function (self)
        if not self.initialized then
            self.compiler:compile()

            for k, _ in pairs(self.typeManager.compiledClasses) do
                local tempObj = new(k)()
                if isType(tempObj, "Generic") then
                    _G[k] = smClass(new(k)())
                end
            end

            self.initialized = true
            class = smClass
        end
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
