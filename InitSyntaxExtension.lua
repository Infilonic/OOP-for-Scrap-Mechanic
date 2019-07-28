syntaxExtension = {
    version = 0.0;
    init = function (self)
        self.compiler:compile()

        for k, _ in pairs(self.typeManager.compiledClasses) do
            _G[k] = smClass(new(k)())
        end

        class = smClass
    end
}

smClass = class

dofile("./PrimitiveTypes/Init.lua")
dofile("./TypeManager/TypeManager.lua")
dofile("./Compiler/Compiler.lua")
dofile("./Instantiator/Instatiator.lua")
dofile("./ReservedKeywords/InitKeywords.lua")

-- System libraries
dofile("./Libraries/System/InitLibrary.lua")
dofile("./Libraries/ScrapMechanic/InitLibrary.lua")