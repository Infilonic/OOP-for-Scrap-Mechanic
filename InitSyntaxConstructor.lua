syntaxConstructor = {
    version = 0.0;
    initSMObjects = function (self)
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

-- Additional libraries
dofile("./Libraries/Default/InitLibrary.lua")
dofile("./Libraries/ScrapMechanic/InitLibrary.lua")