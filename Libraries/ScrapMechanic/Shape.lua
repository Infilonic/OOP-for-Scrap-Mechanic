class "Shape" extends "Generic" {
    public = {
        __construct = function (self,
            maxChildCount,
            maxParentCount,
            connectionInput,
            connectionOutput,
            colorNormal,
            colorHighlight,
            poseWeightCount)
            
            self.maxChildCount = maxChildCount
            self.maxParentCount = maxParentCount
            self.connectionInput = connectionInput
            self.connectionOutput = connectionOutput
            self.colorNormal = colorNormal
            self.colorHighlight = colorHighlight
            self.poseWeightCount = poseWeightCount
        end;
        client_onInteract = function (self)
        end;

        client_onProjectile = function (self)
        end;

        server_onProjectile = function (self)
        end;

        server_onSledgeHammer = function (self)
        end;

        server_onCollision = function (self)
        end;

        client_canInteract = function (self)
            return true
        end
    }
}