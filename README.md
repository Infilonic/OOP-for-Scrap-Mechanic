# Lua syntax extension for Scrap Mechanic
Ever wanted to write cleaner code, that not only looks good, but helps you to write more reusable code?

## What is this?
This project enables familiar object oriented syntax in Lua for the game Scrap Mechanic. Right now the project does not support many features known in other languages like C#, Java etc.

Because the Scrap Mechanic developers, only provide a limited Lua environment, it is currently (14.05.2019) not possible to implement more advanced functionalities, like more advanced access modifiers, finalizers etc.

## Features
- Familiar syntax which allows the creation of classes
	- `class [[Object]] { ... }`
	- `class [[Generic]] extends [[Object]] { ... }`
	- `new [[Object]]()`
- Supports constructors
- Supports inheritance
- Supports access modifiers
- Ability to override base methods
- Ability to call overriden base methods `self.base.someBaseFunction(self)`

```lua
class [[Object]] {
    private = {
        var1 = 0;
        var2 = 0
    };

    public = {
        __construct = function (self, arg1, arg2)
            self.var1 = arg1
            self.var2 = arg2
        end;

        calculate = function (self)
            return self.var1 + self.var2
        end
    }
}

obj = new [[Object]](arg1, arg2)
result = obj.calculate()
```
```lua
class [[Animal]] {
    public = {
        __construct = function (self)
        end;
    }
}

class [[Wolf]] extends [[Animal]] {
    private = {
        furrColor = ""
    };

    public = {
        furrColor = "";
        __construct = function (self, furrColor)
            self.furrColor = furrColor
        end;

        getFurrColor = function (self)
            return self.furrColor
        end
    }
}

class [[Dog]] extends [[Wolf]] {
    private = {
        breed = ""
    };

    public = {
        breed = "";
        __construct = function (self, furrColor, breed)
            self.base.__construct(self, furrColor)
            self.breed = breed
        end;

        getBreed = function (self)
            return self.breed
        end
    }
}
```

# Contributing
Create a pull request in order to contribute to the project. A contribution guide will follow.
