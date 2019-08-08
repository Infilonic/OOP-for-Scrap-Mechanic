class [[Object]] {
    public = {
        __construct = function (self)
        end;

        toString = function (self)
            return self:getType()
        end;

        getType = function (self)
            return self.fullQualifiedTypeName
        end;

        getIdentifier = function (self)
            return tostring(self)
        end;

        equals = function (self, obj)
            return self:getIdentifier() == obj.getIdentifier()
        end
    }
}
