local Types = require(script.Types)

local From = require(script.Producers.From)
local Range = require(script.Producers.Range)
local Repeat = require(script.Producers.Repeat)
local Zip = require(script.Adapters.Zip)

export type Iter<K, V> = Types.Iter<K, V>
export type Iterable<K, V> = Types.Iterable<K, V>

local Iter = {}

-- Metatable Injection
local BaseIter = require(script.BaseIter)

for _, module in script.Producers:GetChildren() do
    setmetatable(require(module), BaseIter)
end

for _, module in script.Adapters:GetChildren() do
    setmetatable(require(module), BaseIter)
end

-- Producers
function Iter.From<K, V>(tab: Types.Tab<K, V>): Iter<K, V>
    return From.new(tab)
end

function Iter.Range(start: number, stop: number, step: number?): Iter<number, number>
    return Range.new(start, stop, step)
end

function Iter.Empty<K, V>(): Iter<K, V>
    return From.new({})
end

function Iter.Repeat<K, V>(value: V): Iter<K, V>
    return Repeat.new(value)
end

-- Methods
function Iter.AdvanceBy<K, V>(iter: Iter<K, V>, n: number): number
    return iter:_checkConsume():_advanceBy(n)
end

-- Consumers
function Iter.Find<K, V>(iter: Iter<K, V>, f: Types.Predicate<K, V>): (K?, V)
    return iter:_tryConsume():_find(f)
end

function Iter.Fold<K, V, A>(iter: Iter<K, V>, init: A, f: Types.Folding<K, V, A>): A
    return iter:_tryConsume():_fold(init, f)
end

function Iter.Reduce<K, V, A>(iter: Iter<K, V>, f: Types.Reduction<K, V, A>): A
    return iter:_tryConsume():_reduce(f)
end

function Iter.Any<K, V>(iter: Iter<K, V>, f: Types.Predicate<K, V>): boolean
    return iter:_tryConsume():_any(f)
end

function Iter.All<K, V>(iter: Iter<K, V>, f: Types.Predicate<K, V>): boolean
    return iter:_tryConsume():_all(f)
end

function Iter.Join<K, V>(iter: Iter<K, V>, sep: string): string
    return iter:_tryConsume():_join(sep)
end

function Iter.Count<K, V>(iter: Iter<K, V>): number
    return iter:_tryConsume():_count()
end

function Iter.Sum<K, V>(iter: Iter<K, V>): number
    return iter:_tryConsume():_sum()
end

-- Adapters
function Iter.Map<K1, K2, V1, V2>(iter: Iter<K1, V1>, f: Types.Mapping<K1, K2, V1, V2>): Iter<K2, V2>
    return iter:_tryConsume():_map(f)
end

function Iter.Skip<K, V>(iter: Iter<K, V>, n: number): Iter<K, V>
    return iter:_tryConsume():_skip(n)
end

function Iter.Take<K, V>(iter: Iter<K, V>, n: number): Iter<K, V>
    return iter:_tryConsume():_take(n)
end

function Iter.Filter<K, V>(iter: Iter<K, V>, f: Types.Predicate<K, V>): Iter<K, V>
    return iter:_tryConsume():_filter(f)
end

function Iter.Keys<K, V>(iter: Iter<K, V>): Iter<K, V>
    return iter:_tryConsume():_keys()
end

function Iter.Values<K, V>(iter: Iter<K, V>): Iter<K, V>
    return iter:_tryConsume():_values()
end

function Iter.Zip<K, V>(...: Iter<K, V>): Iter<{K}, {V}>
    return Zip.new(...)
end

return Iter