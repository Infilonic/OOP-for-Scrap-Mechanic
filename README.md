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

## How do I use it in my Scrap Mechanic mod?
In order to use the syntax extension you have to copy the whole folder structures including the files into your scripts folder of your modification.

Your directory & file structure could look like this:
```
.
+-- Effects
|     +-- Audio
|     +-- Database
|     |     +-- EffectSets
|     +-- Particles
|     |     +-- particles.json
+-- Gui
|     +-- Language
|     |     +-- ...
|     +-- IconMap.png
|     +-- IconMap.xml
+-- Objects
|     +-- Database
|     +-- Mesh
|     +-- Textures
+-- Scripts
|     +--SyntaxExtensionLibrary // This is the folder, where the syntax extension library files go in
|     |     +-- Compiler
|     |     +-- Instantiator
|     |     +-- Libraries
|     |     +-- PrimitiveTypes
|     |     +-- ReservedKeywords
|     |     +-- TypeManager
|     |     +-- InitSyntaxExtension.lua
|     // Your own script files
+-- description.json
+-- preview.jpg
```

After you've selected an appropriate folder and copied the files in your mod, you have to load the syntax extension in your code. In order to do that, your main script files, which gets called by Scrap Mechanic, has to load in the `InitSyntaxExtension.lua` file once by running `dofile("InitSyntaxExtension.lua")`.

Depending on the path where your script file is saved, you have to navigate accordingly to the path where `InitSyntaxExtension.lua` is saved.

After you've successfully loaded the `InitSyntaxExtension.lua` file, you can start writing your classes.

In order for Scrap Mechanic to use those classes, the classes have first to be compiled.
You also need to prepare some global variables for your classes. The global variables are nothing else than concrete instances of your classes. Scrap Mechanic uses its own `class()` function to make these variables callable and to creates a new instance for each shape you create in your world.

The `syntaxExtension` object provides a function to compile and create callable global variables automatically for you.

After you've written and loaded all your classes with the `dofile(filename)` function, you can call the following function to make them accessible for Scrap Mechanic:
- `syntaxExtension:init()`

Be advised, that this function has to be called at the end of all of the other calls and operations that your other scripts run. Read the chapter "Best practices" in order to get a picture of how to create your mods with this library.

# Best Practices
This section discusses the best practices on how to use the syntax extension library in combination with Scrap Mechanic mod development.

This part requires that you're already familiar with the process of creating modifications for Scrap Mechanic, and that you know, how to create scripted parts / tools.

If you're not familiar with the creation process of a Scrap Mechanic mod, have a look at the following ressources:
- [Scrap Mechanic Wiki (Modding)](https://scrapmechanic.gamepedia.com/Modding)
- [Lua Reference Manual (v 5.1)](https://www.lua.org/manual/5.1/)
- [Scrap Mechanic Lua API](http://scrapmechanic.com/api/index.html)

As of now, Scrap Mechanic uses the LuaJIT runtime environment. The latest stable version of LuaJIT supports Lua 5.1. You're not able to use functions from versions higher than 5.1.

## How to start
It is assumed, that you start with a blank Scrap Mechanic mod, in order to have an easy and clean start with this library.

- Copy the library files in the `Scripts` folder of your Scrap Mechanic mod
- It's a good thing to put the library content in a separate folder

```
.
+-- ...
+-- Scripts
|     +-- SyntaxExtensionLibrary // Put the library content here
+-- ...
```
- Create a `Main.lua` file in the root of your `Script` folder

```
.
+-- ...
+-- Scripts
|     +-- SyntaxExtensionLibrary // Put the library content here
|     +-- Main.lua
+-- ...
```
- Load the `InitSyntaxExtension.lua` file with `dofile(filename)` in the script file `Main.lua`
- Call `syntaxExtension:init()` at the end

```lua
dofile("./SyntaxExtensionLibrary/InitSyntaxExtension.lua")
... -- // Your own mod scripts that you want to load (other classes and so on)
syntaxExtension:init()
```

## Write your own classes
It is recommended to put each class in its own file, in order to keep your classes organized. Name your files the same way as the classes they contain. Put your class files in the folder they belong to. If you're writing scripts for multiple parts, put each part-script in its own folder. You may never know, if you need additional classes for a single scripted part. In the end, the folder structure is up to you, but keep it simple and clear.

All your scripted parts in the `parts.json` should run the `Main.lua` file. Don't write your classes in the `Main.lua` file, in order to prevent cluttering the file and making it unreadable.

Set the `classname` property of the according part in your `parts.json` file, to the same name of your future class file and the class in it.

Your class could look like this. Remember, this example shows the syntax of how to create a class and how to create a concrete instance of that written class.

Create class:
```lua
class [[Example]] extends [[Object]] {
    public = {
        __construct = function (self)

        end;

        helloWorld = function (self)
            return "Hello world!"
        end;

        myPrint = function (self, text)
            print(text)
        end;

        mySecondPrint = function (self, ...)
            print(...)
        end;
    }
}
```

Because this syntax requires Lua tables, you have to put a `,` or a `; ` after each child element, in order to have a working class.

Create instance of the class and use this instance:
```lua
myObj = new [[Example]]() -- // Creates a new instance of the type Example
myObj:myPrint(myObj:helloWorld()) -- // Prints "Hello World"
myObj:mySecondPrint("String 1", "String 2") -- // Prints "String 1String 2"
```

## Use your class with your modded part
We created the `Main.lua` file in the beginning, which loads the needed files and calls the needed functions to run your created classes. In order for the syntax extension library to register and compile your classes, you have to load them also with the `dofile(filename)` function. The best place to load them is either the `Main.lua` file or a separate file, if you have many classes and want to keep the `Main.lua` file clean.

You have to load your class files before calling the `syntaxExtension:init()` function. Your `Main.lua` file might look like this
```lua
dofile("./SyntaxExtensionLibrary/InitSyntaxExtension.lua")
dofile("./Example.lua")-- // Your own mod scripts that you want to load (other classes and so on)
syntaxExtension:init()
```

To see the class in action, you have to reload your world, where your Scrap Mechanic mod is used. Right now there is no automatic way to reload all classes and recompile them.

Also there is now way to load your script files automatically, because of the limitations of the scripting environment of Scrap Mechanic.

## Example usage (World cleaner mod)
I build a small Scrap Mechanic mod to have a better demonstration on how to use this library.

First we will have a look at the `parts.json` file, which shows how to define the scripted part and again how to use the `Main.lua` file.
Then we will write a small class, which contains the logic for the world cleaning. After that, all the needed files will be loaded by the `Main.lua` script, compiled and made available as gobal variable, ready for Scrap Mechanic to use the functionalities of our class.

### Create the scripted part (parts.json)
We will keep our effort to a minimum and use the ingame models and textures for our scripted part.

```json
{
    "partList": [
        {
            "uuid": "687da9d2-b02c-4661-925c-fc605915a5ca",
            "renderable": {
                "lodList": [
                    {
                        "subMeshList": [
                            {
                                "textureList": [
                                    "$GAME_DATA/Objects/Textures/interactive/obj_interactive_logicgate_dif.tga",
                                    "$GAME_DATA/Objects/Textures/interactive/obj_interactive_logicgate_asg.tga",
                                    "$GAME_DATA/Objects/Textures/interactive/obj_interactive_logicgate_nor.tga"
                                ],
                                "material": "PoseAnimDifAsgNor"
                            },
                            {
                                "textureList": [
                                    "$GAME_DATA/Objects/Textures/interactive/obj_interactive_logicgate_dif.tga",
                                    "$GAME_DATA/Objects/Textures/interactive/obj_interactive_logicgate_asg.tga",
                                    "$GAME_DATA/Objects/Textures/interactive/obj_interactive_logicgate_nor.tga"
                                ],
                                "material": "UVAnimDifAsgNor",
                                "custom":
                                {
                                    "uv0": { "u": 0.16666667, "v": 0.1645 }
                                }
                            }
                        ],
                        "mesh": "$GAME_DATA/Objects/Mesh/interactive/obj_interactive_logicgate_off.fbx",
                         "pose0": "$GAME_DATA/Objects/Mesh/interactive/obj_interactive_logicgate_on.fbx"
                    }
                ]
            },
            "rotationSet": "PropYZ",
            "color": "FFA010",
            "box": { "x": 1, "y": 1, "z": 1 },
            "density": 250.0,
            "physicsMaterial": "Metal",
            "qualityLevel": 3,
            "sticky": "+X+Y+Z-X-Y-Z",
            "scripted": {
                "filename": "$MOD_DATA/Scripts/Main.lua",
                "classname": "WorldCleaner",
                "data": {
                    "version": 0.0
                }
            }
        }
    ]
}
```

As you might have noticed, we won't load a separate file for our part, even if we would define multiple parts with different classes and therefore files. The parts in the `parts.json` file only load the `Main.lua` script file. Otherwise, the class might not be available immediately or at all (in case the syntax extension library was never loaded). The `classname` property can take the same name as the class (and in this case also the same file name).

You can change the properties as you like (color, qualityLevel, physicsMaterial etc.).

### Create the WorldCleaner class (WorldCleaner.lua)
The file `WorldCleaner.lua` will be in the same folder as our `Main.lua` file.

The `WorldCleaner` class looks like this

```lua
class [[WorldCleaner]] extends [[Shape]] {
    public = {
        __construct = function (self)
            self.maxChildCount = 0
            self.maxParentCount = 1
            self.connectionInput = sm.interactable.connectionType.logic
            self.connectionOutput = sm.interactable.connectionType.none
        end;

        server_onCreate = function (self)
            if not self.shape:getBody():isStatic() then
                local shapes = self.shape:getBody():getCreationShapes()

                for _, shape in ipairs(shapes) do
                    shape:destroyShape()
                end
            end
        end;

        server_cleanUpWorld = function (self)
            local bodies = sm.body.getAllBodies()
            local bodyCount = #bodies
            local creationCount = #sm.body.getCreationsFromBodies(bodies)

            for _, body in ipairs(bodies) do
                for _, shape in ipairs(body:getShapes()) do
                    shape:destroyShape(0)
                end
            end

            self.network:sendToClients("client_alert", string.format("Removed: %i Creations, %i Bodies", creationCount, bodyCount))
        end;

        client_onInteract = function (self)
            self.network:sendToServer("server_cleanUpWorld")
        end;

        client_canInteract = function (self)
            return true
        end;

        client_alert = function (self, message)
            sm.gui.displayAlertText(message)
        end
    }
}
```

As you might have noticed, the `WorldCleaner` class inherits from the `Shape` class, which is an already built in type of the syntax extension library. You can extend from the `Shape` class whenever you need to create a new scripted shape with some default values and functions.

### Example usage of the Shape class
You could also use the `Shape` class to create new functionalities for your scripted part. In this case, you could even load your files after the compilation and initialization process. You have to run the function `smClass(classInstance)` in order to use your prepared object within Scrap Mechanic.

```lua
...
WorldCleanerClass = new [[Shape]]()
WorldCleanerClass.server_onCreate = function (self) -- // Overwriting the existing server_onCreate function
    -- // Your creation logic
end

WorldCleaner = smClass(WorldCleanerClass) -- // Making the class available to use for Scrap Mechanic
...
```

### Prepare Main.lua
The `Main.lua` file will look like this

```lua
dofile("./SyntaxExtension/InitSyntaxExtension.lua")
dofile("./WorldCleaner/WorldCleaner.lua")

syntaxExtension:init()
```
Have a look at the chapter "Use your class with your modded part" for an explanation on why the `Main.lua` file has to look like this.

### Test the Scrap Mechanic mod
After you've saved all files, you can start Scrap Mechanic and create a new world or load an existing one with your mod and test the scripted part.

# Contributing
Create a pull request in order to contribute to the project. A contribution guide will follow.
