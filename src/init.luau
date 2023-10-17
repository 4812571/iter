local Types = require(script.Types)

export type AnyIter = Types.AnyIter
export type Iter<K, V> = Types.Iter<K, V>

local Map = require(script.Map)
local Filter = require(script.Filter)
local Fold = require(script.Fold)

local BaseIter = {}
BaseIter.__index = BaseIter

function BaseIter:__iter()
    return function()
        return self:Next()
    end
end

function BaseIter.new(isMut: boolean): AnyIter
    local self = setmetatable({}, BaseIter)

    self._isMut = isMut
    self._isConsumed = false

    return self
end

function BaseIter:_extend(): AnyIter
    self.isConsumed = true
    return BaseIter.new(self._isMut)
end

function BaseIter:_assertNotConsumed()
    assert(not self._isConsumed, "Cannot use an iter after it has been consumed")
end

function BaseIter:_assertMut()
    assert(self._isMut, "Cannot mutate a non-mutable iter")
end

function BaseIter:Next(): (any, any)
    error("This iter does not implement Next. Report this to the maintainers of iter")
end

function BaseIter:Nth(n: number): (any, any)
    assert(n >= 1, "n must be >= 1")
    self:_assertNotConsumed()
    self:AdvanceBy(n - 1)
    return self:Next()
end

function BaseIter:Last(): (any, any)
    local lastKey, lastValue = nil, nil

    for key, value in self do
        lastKey, lastValue = key, value
    end

    return lastKey, lastValue
end

function BaseIter:Find(f: (any, any) -> boolean): (any, any)
    self:_assertNotConsumed()

    for key, value in self do
        if f(key, value) then
            return key, value
        end
    end

    return nil
end

function BaseIter:AdvanceBy(n: number): number
    self:_assertNotConsumed()

    for i = 1, n do
        if self:Next() == nil then
            return i - 1
        end
    end

    return n
end

function BaseIter:Map(f: (any, any) -> any): AnyIter
    self:_assertNotConsumed()
    return Map(self, f)
end

function BaseIter:Filter(f: (any, any) -> boolean): Iter<any, any>
    self:_assertNotConsumed()
    return Filter(self, f)
end

function BaseIter:Fold(init: any, f: (any, any, any) -> any): any
    self:_assertNotConsumed()
    return Fold(self, init, f)
end

function BaseIter:Reduce(f: (any, any, any) -> any): any
    return self:Fold(self:Next(), f)
end

function BaseIter:Count(): number
    return self:Fold(0, function(acc)
        return acc + 1
    end)
end

function BaseIter:Sum(): number
    return self:Reduce(function(_, value, acc)
        return acc + value
    end)
end

function BaseIter:Min(): number
    return self:Reduce(function(_, value, acc)
        return math.min(acc, value)
    end)
end

function BaseIter:Max(): number
    return self:Reduce(function(_, value, acc)
        return math.max(acc, value)
    end)
end

function BaseIter:Collect(): { [any]: any }
    local tbl = {}

    for key, value in self do
        tbl[key] = value
    end

    return tbl
end

function BaseIter:Take(n: number): AnyIter
    local i = 0

    return self:Filter(function()
        i = i + 1
        return i <= n
    end)
end

function BaseIter:All(f: (any, any) -> boolean): boolean
    for key, value in self do
        if not f(key, value) then
            return false
        end
    end

    return true
end

function BaseIter:Any(f: (any, any) -> boolean): boolean
    for key, value in self do
        if f(key, value) then
            return true
        end
    end

    return false
end

function BaseIter:Keys(): AnyIter
    return self:Map(function(key, _value)
        return key
    end)
end

function BaseIter:Values(): AnyIter
    return self:Map(function(_key, value)
        return value
    end)
end

function BaseIter:Inspect(f: (any, any) -> any): AnyIter
    return self:Map(function(key, value)
        f(key, value)
        return value
    end)
end

function BaseIter:ForEach(f: (any, any) -> any): ()
    for key, value in self do
        f(key, value)
    end
end

local Iter = {}

function Iter.range(from: number, to: number?, step: number?)
    local base = BaseIter.new(false)

    -- If no step is provided, default to 1
    step = step or 1

    -- If no to is provided, default to math.huge
    to = to or math.huge

    local nextIndex = 1
    local nextValue = from

    function base:Next()
        if nextValue == nil then
            return nil
        end

        if nextValue > to then
            return nil
        end

        -- Get the result key and value
        local resultKey, resultValue = nextIndex, nextValue

        -- Update the next index and value
        nextIndex = nextIndex + 1
        nextValue = nextValue + step

        return resultKey, resultValue
    end
end

function Iter.from<K, V>(tab: {[K]: V}): Iter<K, V>
    if tab == Iter then
        error("You have attempted to iterate over the iter library itself. Did you accidentally use `Iter:from(...)` instead of `Iter.from(...)`?")
    end

    local base = BaseIter.new(false)
    local nextKey = next(tab)

    function base:Next()
        if nextKey == nil then
            return nil
        end

        -- Get the result key and value
        local resultKey, resultValue = nextKey, tab[nextKey]

        -- Get the next key for the next iteration
        nextKey = next(tab, nextKey)

        return resultKey, resultValue
    end

    return base :: Iter<K, V>
end

return Iter