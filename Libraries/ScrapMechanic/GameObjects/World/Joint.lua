class [[Joint]] extends [[WorldObject]] {
    public = {
        __construct = function (self, joint)
            self.joint = self.worldObject
        end;

        createPart = function (self, uuid, position, z, x, forceCreate)
            assertType(uuid, [[string]])
            assertType(position, [[userdata]])
            assertType(z, [[number]])
            assertType(x, [[number]])
            assertType(forceCreate, [[boolean]])

            self.joint:createPart(uuid, position, z, x, forceCreate)
        end;

        createBlock = function (self, uuid, size, position, forceCreate)
            assertType(uuid, [[string]])
            assertType(size, [[userdata]])
            assertType(position, [[userdata]])
            assertType(forceCreate, [[boolean]])

            self.joint:createBlock(uuid, size, position, forceCreate)
        end;

        getJointType = function (self)
            return self.joint:getType()
        end;

        getShapeA = function (self)
            return new [[Shape]](self.joint:getShapeA())
        end;

        getShapeB = function (self)
            return new [[Shape]](self.joint:getShapeB())
        end;

        getColor = function (self)
            return self.joint:getColor()
        end;

        getAngle = function (self)
            return self.joint:getAngle()
        end;

        getAngularVelocity = function (self)
            return self.joint:getAngularVelocity()
        end;

        getAppliedImpulse = function (self)
            return self.joint:getAppliedImpulse()
        end;

        isReversed = function (self)
            return self.joint:isReversed()
        end;

        setMotorVelocity = function (self, velocity, maxImpulse)
            assertType(velocity, [[number]])
            assertType(maxImpulse, [[number]])

            self.joint:setMotorVelocity(velocity, maxImpulse)
        end;

        setTargetAngle = function (self, angle, velocity, maxImpulse)
            assertType(angle, [[number]])
            assertType(velocity, [[number]])
            assertType(maxImpulse, [[number]])

            self.joint:setTargetAngle(angle, velocity, maxImpulse)
        end;

        getLength = function (self)
            return self.joint:getLength()
        end;

        setTargetLength = function (self, length, velocity, maxImpulse)
            maxImpulse = maxImpulse or 100000
            assertType(length, [[number]])
            assertType(velocity, [[number]])
            assertType(maxImpulse, [[number]])

            self.joint:setTargetAngle(length, velocity, maxImpulse)
        end;

        equals = function (self, joint)
            assertType(joint, [[Joint]])

            return self.base.equals(self, joint)
        end
    }
}
