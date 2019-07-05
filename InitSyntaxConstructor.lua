syntaxConstructor = {
    version = 0.0;
    init = function (self)
        self.compiler:compile()

        for k, _ in pairs(self.manager.compiledClasses) do
            _G[k] = smClass(new(k)())
        end

        class = smClass
    end
}

smClass = class

dofile("./SCManager/SyntaxConstructorManager.lua")
dofile("./SCCompiler/SyntaxConstructorCompiler.lua")
dofile("./SCInstantiator/SyntaxConstructorInstatiator.lua")
dofile("./ReservedKeywords/InitKeywords.lua")

-- System libraries
dofile("./Libraries/System/InitLibrary.lua")
dofile("./Libraries/ScrapMechanic/InitLibrary.lua")
