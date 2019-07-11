class [[KeyValuePair]] {
    public = {
        __construct = function (self, key, value)
            self.key = key
            self.value = value
        end;

        getKey = function (self)
            return self.key
        end;

        getValue = function (self)
            return self.value
        end;
    }
}
