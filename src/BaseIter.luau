-- Consumers
local Find = require(script.Parent.Consumers.Find)
local Fold = require(script.Parent.Consumers.Fold)
local Reduce = require(script.Parent.Consumers.Reduce)
local AdvanceBy = require(script.Parent.Consumers.AdvanceBy)
local Any = require(script.Parent.Consumers.Any)
local All = require(script.Parent.Consumers.All)

-- Adapters
local Map = require(script.Parent.Adapters.Map)
local Skip = require(script.Parent.Adapters.Skip)
local Take = require(script.Parent.Adapters.Take)
local Filter = require(script.Parent.Adapters.Filter)

local BaseIter = {}
BaseIter.__index = BaseIter

function BaseIter.new()
    local self = setmetatable({}, BaseIter)
    self._isConsumed = false
    return self
end

function BaseIter:_checkConsume()
    if not self._isConsumed then
        error("This iterator has not been consumed", 2)
    end

    return self
end

function BaseIter:_tryConsume()
    if self._isConsumed then
        error("This iterator has already been consumed", 2)
    end

    self._isConsumed = true

    return self
end

-- Consumers
function BaseIter:_find(f)
    return Find(self, f)
end

function BaseIter:_fold(f, init)
    return Fold(self, f, init)
end

function BaseIter:_reduce(f)
    return Reduce(self, f)
end

function BaseIter:_advanceBy(n)
    return AdvanceBy(self, n)
end



-- Adapters
function BaseIter:_map(f)
    return Map.new(self, f)
end

function BaseIter:_skip(n)
    return Skip.new(self, n)
end

function BaseIter:_take(n)
    return Take.new(self, n)
end

function BaseIter:_filter(f)
    return Filter.new(self, f)
end

function BaseIter:_any(f)
    return Any(self, f)
end

function BaseIter:_all(f)
    return All(self, f)
end

return BaseIter