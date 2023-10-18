export type Tab<K, V> = { [K]: V }
export type AnyTab = Tab<any, any>

type InternalAnyIterNoMeta = {
    _extend: (InternalAnyIter) -> AnyIter,
    _next: (InternalAnyIter) -> (any?, any?),
    _advanceBy: (InternalAnyIter, number) -> number,
    _skip: (InternalAnyIter, number) -> AnyIter,
    _nth: (InternalAnyIter, number) -> (any?, any?),
    _last: (InternalAnyIter) -> (any?, any?),
    _map: (InternalAnyIter, (any, any) -> any) -> AnyIter,
    _find: (InternalAnyIter, (any, any) -> boolean) -> (any?, any?),
    _filter: (InternalAnyIter, (any, any) -> boolean) -> AnyIter,
    _fold: <A>(InternalAnyIter, A, (A, any, any) -> A) -> A,
    _reduce: <A>(InternalAnyIter, (A, any, any) -> any) -> A,
    _count: (InternalAnyIter) -> number,
    _sum: (InternalAnyIter) -> number,
    _min: (InternalAnyIter) -> number,
    _max: (InternalAnyIter) -> number,
    _collect: (InternalAnyIter) -> AnyTab,
    _take: (InternalAnyIter, number) -> AnyIter,
    _all: (InternalAnyIter, (any, any) -> boolean) -> boolean,
    _any: (InternalAnyIter, (any, any) -> boolean) -> boolean,
    _inspect: (InternalAnyIter, (any, any) -> any) -> AnyIter,
    _forEach: (InternalAnyIter, (any, any) -> any) -> (),
    _keys: (InternalAnyIter) -> AnyIter,
    _values: (InternalAnyIter) -> AnyIter,
}

type ExternalAnyIterNoMeta = {
    AdvanceBy: (ExternalAnyIter, number) -> number,
    Next: (ExternalAnyIter) -> (any?, any?),
    Nth: (ExternalAnyIter, number) -> (any?, any?),
    Skip: (ExternalAnyIter, number) -> AnyIter,
    Map: (ExternalAnyIter, (any, any) -> any) -> AnyIter,
    Last: (ExternalAnyIter) -> (any?, any?),
    Filter: (ExternalAnyIter, (any, any) -> boolean) -> AnyIter,
    Find: (ExternalAnyIter, (any, any) -> boolean) -> (any?, any?),
    Reduce: <A>(ExternalAnyIter, (A, any, any) -> any) -> A,
    Fold: <A>(ExternalAnyIter, A, (A, any, any) -> A) -> A,
    Sum: (ExternalAnyIter) -> number,
    Count: (ExternalAnyIter) -> number,
    Max: (ExternalAnyIter) -> number,
    Min: (ExternalAnyIter) -> number,
    Collect: (ExternalAnyIter) -> AnyTab,
    All: (ExternalAnyIter, (any, any) -> boolean) -> boolean,
    Take: (ExternalAnyIter, number) -> AnyIter,
    Any: (ExternalAnyIter, (any, any) -> boolean) -> boolean,
    Inspect: (ExternalAnyIter, (any, any) -> any) -> AnyIter,
    ForEach: (ExternalAnyIter, (any, any) -> any) -> (),
    Keys: (ExternalAnyIter) -> AnyIter,
    Values: (ExternalAnyIter) -> AnyIter,
}

type InternalIterNoMeta<K, V> = {
    _extend: (InternalIter<K, V>) -> AnyIter,
    _next: (InternalIter<K, V>) -> (K?, V?),
    _advanceBy: (InternalIter<K, V>, number) -> number,
    _skip: (InternalIter<K, V>, number) -> Iter<K, V>,
    _nth: (InternalIter<K, V>, number) -> (K?, V?),
    _last: (InternalIter<K, V>) -> (K?, V?),
    _map: (InternalIter<K, V>, (V, K) -> any) -> Iter<K, V>,
    _find: (InternalIter<K, V>, (V, K) -> boolean) -> (K?, V?),
    _filter: (InternalIter<K, V>, (V, K) -> boolean) -> Iter<K, V>,
    _fold: <A>(InternalIter<K, V>, A, (A, V, K) -> A) -> A,
    _reduce: <A>(InternalIter<K, V>, (A, V, K) -> V) -> A,
    _count: (InternalIter<K, V>) -> number,
    _sum: (InternalIter<K, V>) -> number,
    _min: (InternalIter<K, V>) -> number,
    _max: (InternalIter<K, V>) -> number,
    _collect: (InternalIter<K, V>) -> Tab<K, V>,
    _take: (InternalIter<K, V>, number) -> Iter<K, V>,
    _all: (InternalIter<K, V>, (V, K) -> boolean) -> boolean,
    _any: (InternalIter<K, V>, (V, K) -> boolean) -> boolean,
    _inspect: (InternalIter<K, V>, (V, K) -> any) -> Iter<K, V>,
    _forEach: (InternalIter<K, V>, (V, K) -> any) -> (),
    _keys: (InternalIter<K, V>) -> Iter<K, V>,
    _values: (InternalIter<K, V>) -> Iter<K, V>,
}

type ExternalIterNoMeta<K, V> = {
    AdvanceBy: (ExternalIter<K, V>, number) -> number,
    Next: (ExternalIter<K, V>) -> (V?, K?),
    Nth: (ExternalIter<K, V>, number) -> (V?, K?),
    Skip: (ExternalIter<K, V>, number) -> Iter<K, V>,
    Map: (ExternalIter<K, V>, (V, K) -> any) -> Iter<K, V>,
    Last: (ExternalIter<K, V>) -> (V?, K?),
    Filter: (ExternalIter<K, V>, (V, K) -> boolean) -> Iter<K, V>,
    Find: (ExternalIter<K, V>, (V, K) -> boolean) -> (V?, K?),
    Reduce: <A>(ExternalIter<K, V>, (A, V, K) -> V) -> A,
    Fold: <A>(ExternalIter<K, V>, A, (A, V, K) -> A) -> A,
    Sum: (ExternalIter<K, V>) -> number,
    Count: (ExternalIter<K, V>) -> number,
    Max: (ExternalIter<K, V>) -> number,
    Min: (ExternalIter<K, V>) -> number,
    Collect: (ExternalIter<K, V>) -> Tab<K, V>,
    All: (ExternalIter<K, V>, (V, K) -> boolean) -> boolean,
    Take: (ExternalIter<K, V>, number) -> Iter<K, V>,
    Inspect: (ExternalIter<K, V>, (V, K) -> any) -> Iter<K, V>,
    Any: (ExternalIter<K, V>, (V, K) -> boolean) -> boolean,
    Keys: (ExternalIter<K, V>) -> Iter<K, V>,
    ForEach: (ExternalIter<K, V>, (V, K) -> any) -> (),
    Values: (ExternalIter<K, V>) -> Iter<K, V>,
}

type AnyIterMeta = {
    __iter: () -> () -> (any?, any?),
}

type IterMeta<K, V> = {
    __iter: () -> () -> (K?, V?),
}

export type InternalAnyIter = typeof(setmetatable({} :: InternalAnyIterNoMeta, {} :: AnyIterMeta))
export type ExternalAnyIter = typeof(setmetatable({} :: ExternalAnyIterNoMeta, {} :: AnyIterMeta))

export type InternalIter<K, V> = typeof(setmetatable({} :: InternalIterNoMeta<K, V>, {} :: IterMeta<K, V>))
export type ExternalIter<K, V> = typeof(setmetatable({} :: ExternalIterNoMeta<K, V>, {} :: IterMeta<K, V>))

export type AnyIter = InternalAnyIter & ExternalAnyIter
export type Iter<K, V> = InternalIter<K, V> & ExternalIter<K, V>

return nil