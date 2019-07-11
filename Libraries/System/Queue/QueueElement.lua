class [[QueueElement]] {
    public = {
        __construct = function (self, object)
            self.object = object
        end;

        getObject = function (self)
            return self.object
        end;

        getSuccessor = function (self)
            return self.successor
        end;

        setSuccessor = function (self, successor)
            self.successor = successor
        end
    }
}
