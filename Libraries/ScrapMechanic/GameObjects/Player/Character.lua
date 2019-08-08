class [[Character]] extends [[WorldObject]] {
    private = {
        character = nil;
        player = nil
    };

    public = {
        __construct = function (self, character)
            self.base:__construct(character)
            self.character = self.worldObject
            self.player = new [[Player]](self.character:getPlayer())
        end;

        getWorldPosition = function (self)
            return self.character:getWorldPosition()
        end;

        getVelocity = function (self)
            return self.character:getVelocity()
        end;

        getDirection = function (self)
            return self.character:getDirection()
        end;

        getMass = function (self)
            return self.character:getMass()
        end;

        getPlayer = function (self)
            return self.player
        end;

        isSprinting = function (self)
            return self.character:isSprinting()
        end;

        isAiming = function (self)
            return self.character:isAiming()
        end;

        isCrouching = function (self)
            return self.character:isCrouching()
        end
    }
}
