class [[Interactable]] extends [[WorldObject]] {
    private = {
        interactable = nil
    };

    public = {
        __construct = function (self, interactable)
            self.base:__construct(interactable)
            self.interactable = self.worldObject
        end;

        getInteractableType = function (self)
            return self.interactable:getType()
        end;

        getColorNormal = function (self)
            return self.interactable:getColorNormal()
        end;

        getColorHighlight = function (self)
            return self.interactable:getColorHighlight()
        end;

        getMaxParentCount = function (self)
            return self.interactable:getMaxParentCount()
        end;

        getMaxChildCount = function (self)
            return self.interactable:getMaxChildCount()
        end;

        isActive = function (self)
            return self.interactable:isActive()
        end;

        setActive = function (self, active)
            assertType(active, [[boolean]])

            self.interactable:setActive(active)
        end;

        getPower = function (self)
            return self.interactable:getPower()
        end;

        setPower = function (self, power)
            assertType(power, [[number]])

            self.interactable:setPower(power)
        end;

        getShape = function (self)
            return new [[Shape]](self.interactable:getShape())
        end;

        getBody = function (self)
            return new [[Body]](self.interactable:getBody())
        end;

        getSingleParent = function (self)
            return new [[Interactable]](self.interactable:getSingleParent())
        end;

        getParents = function (self)
            return table.toList(self.interactable:getParents())
        end;

        getChildren = function (self)
            return table.toList(self.interactable:getChildren())
        end;

        getJoints = function (self)
            return table.toList(self.interactable:getJoints())
        end;

        getBearings = function (self)
            return table.toList(self.interactable:getBearings())
        end;

        getPistons = function (self)
            return table.toList(self.interactable:getPistons())
        end;

        getPoseWeight = function (self, index)
            assertType(index, [[number]])

            return self.interactable:getPoseWeight()
        end;

        setPoseWeight = function (self, index, weight)
            assertType(index, [[number]])
            assertType(weight, [[number]])

            self.interactable:setPoseWeight(index, weight)
        end;

        getUvFrameIndex = function (self)
            return self.interactable:getUvFrameIndex()
        end;

        setUvFrameIndex = function (self, index)
            assertType(index, [[number]])

            self.interactable:setUvFrameIndex(index)
        end;

        setAnimProgress = function (self, name, progress)
            assertType(name, [[string]])
            assertType(progress, [[number]])

            self.interactable:setAnimProgress(name, progress)
        end;

        setAnimEnabled = function (self, name, enabled)
            assertType(name, [[string]])
            assertType(enabled, [[boolean]])

            self.interactable:setAnimEnabled(name, enabled)
        end;

        getLocalBonePosition = function (self, name)
            assertType(name, [[string]])

            return self.interactable:getLocalBonePosition(name)
        end;

        getWorldBonePosition = function (self, name)
            assertType(name, [[string]])

            return self.interactable:getWorldBonePosition(name)
        end;

        getContainer = function (self, index)
            index = index or 0
            assertType(index, [[number]])

            return self.interactable:getContainer(index)
        end
    }
}
