syntaxConstructor = {
    version = 0.0;
    initSMObjects = function (self)
        for k, _ in pairs(self.manager.compiledClasses) do
            _G[k] = smInit(new(k)())
        end
        class = smInit
    end
}

dofile("./SCManager/SyntaxConstructorManager.lua")
dofile("./SCCompiler/SyntaxConstructorCompiler.lua")
dofile("./SCInstantiator/SyntaxConstructorInstatiator.lua")
dofile("./ReservedKeywords/InitKeywords.lua")
dofile("./BaseClasses/InitBaseClasses.lua")