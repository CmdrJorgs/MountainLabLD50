local ExplodedState = Class{_include = BaseState}

function ExplodedState:is_exploded()
    return true
end

return ExplodedState