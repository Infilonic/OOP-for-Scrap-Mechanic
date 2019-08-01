class [[Player]] extends [[WorldObject]] {
    public = {
        __construct = function (self, player)
            self.player = self.worldObject
            self.character = new [[Character]](self.player:getCharacter())
        end;

        getCharacter = function (self)
            return self.character
        end;

        setCharacter = function (self, character)
            assertType(character, [[Character]])

            self.character = character
            self.player:setCharacter(character.character)
        end;

        getName = function (self)
            return self.player:getName()
        end;

        getInventory = function (self)
            return new [[Container]](self.player:getInventory())
        end;

        placeLift = function (self, creation, position, level, rotation)
            assertType(creation, [[Creation]])
            assertType(creation, [[userdata]])
            assertType(creation, [[userdata]])
            assertType(creation, [[userdata]])

            self.player:placeLift(creation:toTable(), position, level, rotation)
        end;

        removeLift = function (self)
            self.player:removeLift()
        end;

        equals = function (self, player)
            assertType(player, [[Player]])

            return self.base.equals(self, player)
        end
    }
}
