# Lua syntax extension for Scrap Mechanic
Write cleaner, more reliable, reusable and maintainable code with the help of this library. Elevate your current projects and create complex systems with ease.

## What is this?
This project enables familiar syntax and advanced concepts known in the object oriented paradigm for Lua in the game Scrap Mechanic.

## Usage
Check the wiki pages of this repository to learn more about utilising this library.

## Features
- Familiar syntax which enables the creation of custom datatypes
	- `class [[Object]] { ... }`
	- `class [[Generic]] extends [[Object]] { ... }`
	- `new [[Generic]]()`
- Supports constructors
- Supports inheritance
- Supports access modifiers
- Ability to override base methods
- Ability to call overridden base methods `self.base.someBaseFunction(self)`

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
