export type AnyIter = {
    -- Internal
    _extend: (AnyIter) -> AnyIter,

    -- Element Fetch
    Next: (AnyIter) -> (any, any),
    Nth: (AnyIter, number) -> any,
    Last: (AnyIter) -> any,
    
    -- Searching
    Find: (AnyIter, (any, any) -> boolean) -> (any, any),

    -- Map
    Map: (AnyIter, (any, any) -> any) -> AnyIter,

    -- Filter
    Filter: (AnyIter, (any, any) -> boolean) -> AnyIter,

    -- Fold
    Fold: (AnyIter, any, (any, any, any) -> any) -> any,
    Reduce: (AnyIter, (any, any, any) -> any) -> any,

    -- Numeric Folding
    Count: (AnyIter) -> number,
    Sum: (AnyIter) -> number,
    Min: (AnyIter) -> number,
    Max: (AnyIter) -> number,

    -- Collection
    Collect: (AnyIter) -> { [any]: any },
    Take: (AnyIter, number) -> AnyIter,

    -- Any & All
    All: (AnyIter, (any, any) -> boolean) -> boolean,
    Any: (AnyIter, (any, any) -> boolean) -> boolean,

    -- Looping
    Inspect: (AnyIter, (any, any) -> any) -> AnyIter,
    ForEach: (AnyIter, (any, any) -> any) -> (),

    -- Luau
    Keys: (AnyIter) -> AnyIter,
    Values: (AnyIter) -> AnyIter,
}

-- AnyIter is used to prevent type checker issues with recursive types.
-- Feel free to return a typed 'Iter' from a function, or cast an AnyIter to an Iter with known types.
export type Iter<K, V> = {
    -- Internal
    _extend: (Iter<K, V>) -> Iter<K, V>,

    -- Element Fetch
    Next: (Iter<K, V>) -> (K, V),
    Nth: (Iter<K, V>, number) -> V,
    Last: (Iter<K, V>) -> V,

    -- Searching
    Find: (Iter<K, V>, (K, V) -> boolean) -> (K, V),
    
    -- Map
    Map: (Iter<K, V>, (K, V) -> any) -> AnyIter,

    -- Filter
    Filter: (Iter<K, V>, (K, V) -> boolean) -> Iter<K, V>,

    -- Fold
    Fold: (Iter<K, V>, any, (any, K, V) -> any) -> any,
    Reduce: (Iter<K, V>, (any, K, V) -> any) -> any,

    -- Numeric Folding
    Count: (Iter<K, V>) -> number,
    Sum: (Iter<K, V>) -> number,
    Min: (Iter<K, V>) -> number,
    Max: (Iter<K, V>) -> number,

    -- Collection
    Collect: (Iter<K, V>) -> { [K]: V },
    Take: (Iter<K, V>, number) -> AnyIter,

    -- Any & All
    All: (Iter<K, V>, (K, V) -> boolean) -> boolean,
    Any: (Iter<K, V>, (K, V) -> boolean) -> boolean,

    -- Looping
    Inspect: (Iter<K, V>, (K, V) -> any) -> Iter<K, V>,
    ForEach: (Iter<K, V>, (K, V) -> any) -> (),

    -- Luau
    Keys: (Iter<K, V>) -> AnyIter,
    Values: (Iter<K, V>) -> AnyIter,
}

return nil