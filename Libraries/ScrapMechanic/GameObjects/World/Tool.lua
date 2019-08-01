class [[Tool]] extends [[WorldObject]] {
    public = {
        __construct = function (self, tool)
            self.tool = self.worldObject
        end;

        updateAnimation = function (self, name, time, weight)
            weight = weight or -1
            assertType(name, [[string]])
            assertType(time, [[number]])
            assertType(weight, [[number]])

            self.tool:updateAnimation(name, time, weight)
        end;

        setMovementAnimation = function (self, name, animation)
            assertType(name, [[string]])
            assertType(animation, [[string]])

            self.tool:setMovementAnimation(name, animation)
        end;

        updateMovementAnimation = function (self, time, weight)
            weight = weight or -1
            assertType(time, [[number]])
            assertType(weight, [[number]])

            self.tool:updateMovementAnimation(time, weight)
        end;

        getAnimationInfo = function (self, name)
            assertType(name, [[string]])

            return self.tool:getAnimationInfo(name)
        end;

        updateJoint = function (self, name, rotation, weight)
            weight = weight or -1
            assertType(name, [[string]])
            assertType(rotation, [[userdata]])
            assertType(weight, [[number]])

            self.tool:updateJoint(name, rotation, weight)
        end;

        updateCamera = function (self, distance, fov, offset, weight)
            assertType(distance, [[number]])
            assertType(fov, [[number]])
            assertType(offset, [[userdata]])
            assertType(weight, [[number]])

            self.tool:updateAnimation(distance, fov, offset, weight)
        end;

        setTpRenderables = function (self, renderables)
            assertType(renderables, [[List]])

            self.tool:setTpRenderables(renderables:toTable())
        end;

        updateFpAnimation = function (self, name, time, weight, looping)
            weight = weight or -1
            looping = looping or false
            assertType(name, [[string]])
            assertType(time, [[number]])
            assertType(weight, [[number]])
            assertType(looping, [[boolean]])

            self.tool:updateFpAnimation(name, time, weight, looping)
        end;

        getFpAnimation = function (self, name)
            assertType(name, [[string]])

            return self.tool:getFpAnimation(name)
        end;

        setFpRenderables = function (self, renderables)
            assertType(renderables, [[List]])

            self.tool:setFpRenderables(renderables:toTable())
        end;

        updateFpCamera = function (self, fov, offset, weight, bobbing)
            assertType(fov, [[number]])
            assertType(offset, [[userdata]])
            assertType(weight, [[number]])
            assertType(bobbing, [[number]])

            self.tool:updateFpCamera(fov, offset, weight, bobbing)
        end;

        isCrouching = function (self)
            return self.tool:isCrouching()
        end;

        isSprinting = function (self)
            return self.tool:isSprinting()
        end;

        isOnGround = function (self)
            return self.tool:isOnGround()
        end;

        setBlockSprint = function (self, block)
            assertType(block, [[boolean]])

            self.tool:setBlockSprint(block)
        end;

        setMovementSlowDown = function (self, slowDown)
            assertType(slowDown, [[boolean]])

            self.tool:setMovementSlowDown(slowDown)
        end;

        isLocal = function (self)
            return self.tool:isLocal()
        end;

        isInFirstPersonView = function (self)
            return self.tool:isInFirstPersonView()
        end;

        setDispersionFraction = function (self, dispersion)
            assertType(dispersion, [[number]])

            self.tool:setDispersionFraction(dispersion)
        end;

        setCrossHairAlpha = function (self, alpha)
            assertType(alpha, [[number]])

            self.tool:setCrossHairAlpha(alpha)
        end;

        setInteractionTextSuppressed = function (self, suppressed)
            assertType(suppressed, [[boolean]])

            self.tool:setInteractionTextSuppressed(suppressed)
        end;

        getPosition = function (self)
            return self.tool:getPosition()
        end;

        getDirection = function (self)
            return self.tool:getDirection()
        end;

        getMovementVelocity = function (self)
            return self.tool:getMovementVelocity()
        end;

        getRelativeMoveDirection = function (self)
            return self.tool:getRelativeMoveDirection()
        end;

        getMovementSpeedFraction = function (self)
            self.tool:getMovementSpeedFraction()
        end;

        getTpBonePos = function (self, jointName)
            assertType(jointName, [[string]])

            self.tool:getTpBonePos(jointName)
        end;

        getFpBonePos = function (self, jointName)
            assertType(jointName, [[string]])

            self.tool:getFpBonePos(jointName)
        end;

        equals = function (self, tool)
            assertType(tool, [[Tool]])

            return self.base.equals(self, tool)
        end
    }
}
