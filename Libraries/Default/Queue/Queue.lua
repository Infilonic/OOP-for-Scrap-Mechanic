class "Queue" {
    public = {
        __construct = function (self)
            self.length = 0
            self.front = nil
            self.rear = nil
        end;

        enqueue = function (self, object)
            local queueElement = new "QueueElement"(object)

            if self.front == nil or self.rear == nil then
                self.front = queueElement
                self.rear = queueElement
            end

            self.rear:setSuccessor(queueElement)
            self.rear = queueElement
            self.length = self.length + 1
        end;

        dequeue = function (self)
            local queueElement = self.front

            if queueElement ~= nil and queueElement ~= queueElement:getSuccessor() then
                self.front = queueElement:getSuccessor()
                self.length = self.length - 1
            else
                self.front = nil
                self.rear = nil
                self.length = 0
            end

            return queueElement:getObject()
        end;

        getLength = function (self)
            return self.length
        end
    }
}