class [[Body]] extends [[WorldObject]] {
    private = {
        body = nil
    };

    public = {
        __construct = function (self, body)
            self.base:__construct(body)
            self.body = self.worldObject
        end;

        getMass = function (self)
            return self.body:getMass()
        end;

        getWorldPosition = function (self)
            return self.body:getWorldPosition()
        end;

        getVelocity = function (self)
            return self.body:getVelocity()
        end;

        getAngularVelocity = function (self)
            return self.body:getAngularVelocity()
        end;

        getShapes = function (self)
            return table.toList(self.body:getShapes())
        end;

        getCreationShapes = function (self)
            return table.toList(self.body:getCreationShapes())
        end;

        getCreationBodies = function (self)
            return table.toList(self.body:getCreationBodies())
        end;

        createPart = function (self, uuid, position, z, x, forceAccept)
            assertType(uuid, [[string]])
            assertType(position, [[userdata]])
            assertType(z, [[userdata]])
            assertType(x, [[userdata]])
            assertType(forceAccept, [[boolean]])

            self.body:createPart(uuid, position, z, x, forceAccept)
        end;

        createBlock = function (self, uuid, size, position, forceAccept)
            assertType(uuid, [[string]])
            assertType(size, [[userdata]])
            assertType(position, [[userdata]])
            assertType(forceAccept, [[boolean]])

            self.body:createBlock(uuid, size, position, forceAccept)
        end;

        hasChanged = function (self, tick)
            assertType(tick, [[number]])

            return self.body:hasChanged(tick)
        end;

        isDynamic = function (self)
            return self.body:isDynamic()
        end;

        isStatic = function (self)
            return self.body:isStatic()
        end;

        isDestructable = function (self)
            return self.body:isDestructable()
        end;

        setDestructable = function (self, destructable)
            assertType(destructable, [[boolean]])

            self.body:setDestructable(destructable)
        end;

        isBuildable = function (self)
            return self.body:isBuildable()
        end;

        setBuildable = function (self, buildable)
            assertType(buildable, [[boolean]])

            self.body:setBuildable(buildable)
        end;

        isPaintable = function (self)
            return self.body:isPaintable()
        end;

        setPaintable = function (self, paintable)
            assertType(paintable, [[boolean]])

            self.body:setPaintable(paintable)
        end;

        isConnectable = function (self)
            return self.body:isConnectable()
        end;

        setConnectable = function (self, connectable)
            assertType(connectable, [[boolean]])

            self.body:setConnectable(connectable)
        end;

        isLiftable = function (self)
            return self.body:isLiftable()
        end;

        setLiftable = function (self, liftable)
            assertType(liftable, [[boolean]])

            self.body:setLiftable(liftable)
        end;

        isUsable = function (self)
            return self.body:isUsable()
        end;

        setUsable = function (self, usable)
            assertType(usable, [[boolean]])

            self.body:setUsable(usable)
        end;

        isErasable = function (self)
            return self.body:isErasable()
        end;

        setErasable = function (self, erasable)
            assertType(erasable, [[booelan]])

            self.body:setErasable(erasable)
        end
    }
}
