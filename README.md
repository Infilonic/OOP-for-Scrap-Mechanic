# Lua syntax extension for Scrap Mechanic
Ever wanted to write cleaner code, that not only looks good, but helps you to write more reusable code?

## What is this?
This project enables familiar object oriented syntax in Lua for the game Scrap Mechanic. Right now the project does not support many features known in other languages like C#, Java etc.

Because the Scrap Mechanic developers, only provide a limited Lua environment, it is currently (14.05.2019) not possible to implement more advanced functionalities, like access modifiers, finalizers etc.

## Features
- Familiar syntax which allows the creation of classes
	- `class [[Object]] { ... }`
	- `class [[Generic]] extends [[Object]] { ... }`
	- `new [[Object]]()`
- Supports constructors

```lua
class [[Object]] {
    public = {
        __construct = function (self, arg1, arg2)
        end
    }
}

new [[Object]](arg1, arg2)
```

- Ability to automatically call the constructor of the base class (no need to do it yourself)
- Supports inheritance

```lua
class [[Animal]] {
    public = {
        __construct = function (self)
        end;
    }
}

class [[Wolf]] extends [[Animal]] {
    public = {
        furrColor = "";
        __construct = function (self, furrColor)
            self.furrColor = furrColor
        end
    }
}

class [[Dog]] extends [[Wolf]] {
    public = {
        breed = "";
        __construct = function (self, furrColor, breed)
            self.breed = breed
        end
    }
}
```

# Contributing
Create a pull request in order to contribute to the project. A contribution guide will follow.
