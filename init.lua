return function(parents, methods)
    local methods_
    if methods then methods_ = methods else methods_ = parents end
    local class_ = methods_
	local instance = {}
	instance.init = class_.init
    instance.methods = {}
	for i,parent in ipairs(parents) do
		for name,method in pairs(parent.methods) do
			if name ~= "init" then
				instance.methods[name] = method
                class_[name] = method
			end
		end
	end
    for name,method in pairs(methods_) do
        instance.methods[name] = method
        class_[name] = method
    end
	function instance:new(...)
		class_:init(...)
		return class_
	end
	instance = setmetatable(instance, {__call=instance.new})
	return instance
end
