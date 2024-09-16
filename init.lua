return function(parents, methods)
    local methods_ = methods or parents
    local class_ = methods_
    local instance = {}
    
    -- Copy methods from parents to instance and class_
    for _, parent in ipairs(parents) do
        for name, method in pairs(parent) do
            if name == "__init" then
                instance.init = method
                class_.init = method
            else
                instance[name] = method
                class_[name] = method
            end
        end
    end
    
    -- Copy methods from methods_ to instance and class_
    for name, method in pairs(methods_) do
        instance[name] = method
        class_[name] = method
    end

    -- Define the `new` method
    function instance:new(...)
        local obj = setmetatable({}, {__index = class_})
        if class_.init then
            class_.init(obj, ...)
        end
        return obj
    end

    -- Set the metatable for instance to allow calling as a constructor
    return setmetatable(instance, {__call = instance.new})
end
