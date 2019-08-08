class [[PooledObject]] {
    private = {
        lastUsed = 0;
    };

    public = {
        __construct = function (self)
            self.lastUsed = 0
        end;

        refresh = function (self)
            self.lastUsed = 0
        end;

        cleanUp = function (self)
            self:refresh()
        end
    }
}
