class [[Creation]] {
    private = {
        bodies = nil;
        uuid = nil;
        destructable = true;
        buildable = true;
        paintable = true;
        connectable = true;
        liftable = true;
        usable = true;
        erasble = true;
        lastChangedTick = 0;
    };

    public = {
        __construct = function (self, bodies)
            assertType(bodies, [[List]])

            self.bodies = bodies
            self.uuid = sm.uuid.new()
            self.lastChangedTick = sm.game.getCurrentTick()
        end;

        iterate = function (self)
            return self.bodies.iterate()
        end;

        getBodies = function (self)
            return self.bodies
        end;

        getUuid = function (self)
            return self.uuid
        end;

        setLastChangedTick = function (self, tick)
            assertType(tick, [[number]])

            self.lastChangedTick = tick
        end;

        updateState = function (self)
            if self:hasChanged() then
                self.lastChangedTick = sm.game.getCurrentTick()
            end
        end;

        hasChanged = function (self)
            local creationChanged = false

            for _, body in self:iterate() do
                if body:hasChanged(self.lastChangedTick) then
                    creationChanged = true
                    break
                end
            end

            return creationChanged
        end;

        isDynamic = function (self)
            return not self:isStatic()
        end;

        isStatic = function (self)
            local static = false

            for _, body in ipairs(self.bodies) do
                static = body:isStatic()

                if static then
                    break
                end
            end

            return static
        end;

        isDestructable = function (self)
            return self.destructable
        end;

        setDestructable = function (self, destructable)
            assertType(destructable, [[boolean]])

            self.bodies.foreach(function (body) body:setDestructable(destructable) end)
            self.destructable = destructable
        end;

        isBuildable = function (self)
            return self.buildable
        end;

        setBuildable = function (self, buildable)
            assertType(buildable, [[boolean]])

            self.bodies.foreach(function (body) body:setBuildable(buildable) end)
            self.buildable = buildable
        end;

        isPaintable = function (self)
            return self.paintable
        end;

        setPaintable = function (self, paintable)
            assertType(paintable, [[boolean]])

            self.bodies.foreach(function (body) body:setPaintable(paintable) end)
            self.paintable = paintable
        end;

        isConnectable = function (self)
            return self.connectable
        end;

        setConnectable = function (self, connectable)
            assertType(connectable, [[boolean]])

            self.bodies.foreach(function (body) body:setConnectable(connectable) end)
            self.connectable = connectable
        end;

        isLiftable = function (self)
            return self.liftable
        end;

        setLiftable = function (self, liftable)
            assertType(liftable, [[boolean]])

            self.bodies.foreach(function (body) body:setLiftable(liftable) end)
            self.liftable = liftable
        end;

        isUsable = function (self)
            return self.usable
        end;

        setUsable = function (self, usable)
            assertType(usable, [[boolean]])

            self.bodies.foreach(function (body) body:setUsable(usable) end)
            self.usable = usable
        end;

        isErasable = function (self)
            return self.erasble
        end;

        setErasable = function (self, erasble)
            assertType(erasble, [[boolean]])

            self.bodies.foreach(function (body) body:setErasable(erasble) end)
            self.erasble = erasble
        end;

        equals = function (self, creation)
            assertType(creation, [[Creation]])

            return self:getUuid() == creation.getUuid()
        end
    }
}
