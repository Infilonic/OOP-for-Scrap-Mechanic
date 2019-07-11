class [[PooledObject]] {
    public = {
        __construct = function (self, element)
            self.lastUsed = {}
            self.element = element
        end;

        refresh = function (self)
            self.lastUsed = {}
        end;

        cleanUp = function (self)
            self.element = {}
        end
    }
}
