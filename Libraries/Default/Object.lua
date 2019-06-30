class "Object" {
    public = {
        __construct = function (self)
        end;

        toString = function (self)
            return tostring(self:getType())
        end;

        getType = function (self)
            return self.type
        end;

        equals = function (self, obj)
            return self == obj
        end
    }
}
