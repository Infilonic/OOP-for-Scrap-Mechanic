class [[Object]] {
    public = {
        __construct = function (self)
        end;

        toString = function (self)
            return self:getType()
        end;

        getType = function (self)
            return self.type
        end;

        getIdentifier = function (self)
            return tostring(self)
        end;

        equals = function (self, obj)
            return self == obj
        end
    }
}
