class [[Shape]] extends [[WorldObject]] {
    private = {
        shape = nil
    };

    public = {
        __construct = function (self, shape)
            self.base:__construct(shape)
            self.shape = self.worldObject
        end;

        getShapeUuid = function (self)
            return self.shape:getShapeUuid()
        end;

        getColor = function (self)
            return self.shape:getColor()
        end;

        setColor = function (self, color)
            assertType(color, [[userdata]])

            self.shape:setColor(color)
        end;

        getMass = function (self)
            return self.shape:getMass()
        end;

        getMaterial = function (self)
            return self.shape:getMaterial()
        end;

        getWorldPosition = function (self)
            return self.shape:getWorldPosition()
        end;

        getLocalPosition = function (self)
            return self.shape:getLocalPosition()
        end;

        getVelocity = function (self)
            return self.shape:getVelocity()
        end;

        getXAxis = function (self)
            return self.shape:getXAxis()
        end;

        getYAxis = function (self)
            return self.shape:getYAxis()
        end;

        getZAxis = function (self)
            return self.shape:getZAxis()
        end;

        getAt = function (self)
            return self.shape:getAt()
        end;

        getRight = function (self)
            return self.shape:getRight()
        end;

        getUp = function (self)
            return self.shape:getUp()
        end;

        transformPoint = function (self, vector)
            assertType(vector, [[userdata]])

            self.shape:transformPoint(vector)
        end;

        transformRotation = function (self, quaternion)
            assertType(quaternion, [[userdata]])

            self.shape:transformPoint(quaternion)
        end;

        getBoundingBox = function (self)
            return self.shape:getBoundingBox()
        end;

        getBody = function (self)
            return new [[Body]](self.shape:getBody())
        end;

        getInteractable = function (self)
            return new [[Interactable]](self.shape:getInteractable())
        end;

        destroyPart = function (self, attackLevel)
            assertType(attackLevel, [[number]])

            self.shape:destroyPart(attackLevel)
        end;

        getWorldRotation = function (self)
            return self.shape:getWorldRotation()
        end;

        createJoint = function (self, uuid, position, direction)
            assertType(uuid, [[string]])
            assertType(position, [[userdata]])
            assertType(direction, [[userdata]])

            self.shape:createJoint(uuid, position, direction)
        end;

        destroyShape = function (self, attackLevel)
            assertType(attackLevel, [[number]])

            self.shape:destroyShape(attackLevel)
        end
    }
}
