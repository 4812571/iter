export type Predicate<K, V> = (V, K) -> boolean
export type Mapping<K1, K2, V1, V2> = (V1, K1) -> (V2, (K1 | K2))
export type Folding<K, V, A> = (A, V, K) -> A
export type Reduction<K, V, A> = (A, V, K) -> A

type AnyIterNoMeta = {
    -- Safety
    _checkConsume: (AnyIter) -> AnyIter,
    _tryConsume: (AnyIter) -> AnyIter,

    -- Methods
    _advanceBy: (AnyIter, number) -> number,

    -- Consumers
    _find: (AnyIter, Predicate<any, any>) -> (any?, any),
    _fold: <A>(AnyIter, A, Folding<any, any, A>) -> A,
    _reduce: <A>(AnyIter, Reduction<any, any, A>) -> A,
    _any: (AnyIter, Predicate<any, any>) -> boolean,
    _all: (AnyIter, Predicate<any, any>) -> boolean,
    _join: (AnyIter, string) -> string,
    _count: (AnyIter) -> number,
    _sum: (AnyIter) -> number,

    -- Adapters
    _map: <K2, V2>(AnyIter, Mapping<any, K2, any, V2>) -> AnyIter,
    _skip: (AnyIter, number) -> AnyIter,
    _take: (AnyIter, number) -> AnyIter,
    _filter: (AnyIter, Predicate<any, any>) -> AnyIter,
    _keys: (AnyIter) -> AnyIter,
    _values: (AnyIter) -> AnyIter,
}

type IterNoMeta<K, V> = {
    -- Safety
    _checkConsume: (Iter<K, V>) -> Iter<K, V>,
    _tryConsume: (Iter<K, V>) -> Iter<K, V>,

    -- Methods
    _advanceBy: (Iter<K, V>, number) -> number,

    -- Consumers
    _find: (Iter<K, V>, Predicate<K, V>) -> (K?, V),
    _fold: <A>(Iter<K, V>, A, Folding<K, V, A>) -> A,
    _reduce: <A>(Iter<K, V>, Reduction<K, V, A>) -> A,
    _any: (Iter<K, V>, Predicate<K, V>) -> boolean,
    _all: (Iter<K, V>, Predicate<K, V>) -> boolean,
    _join: (Iter<K, V>, string) -> string,
    _count: (Iter<K, V>) -> number,
    _sum: (Iter<K, V>) -> number,

    -- Adapters
    _map: <K2, V2>(Iter<K, V>, Mapping<K, K2, V, V2>) -> AnyIter,
    _skip: (Iter<K, V>, number) -> Iter<K, V>,
    _take: (Iter<K, V>, number) -> Iter<K, V>,
    _filter: (Iter<K, V>, Predicate<K, V>) -> Iter<K, V>,
    _keys: (Iter<K, V>) -> Iter<K, V>,
    _values: (Iter<K, V>) -> Iter<K, V>,
}

type IterableMeta<K, V> = {
    __iter: () -> () -> (K?, V)
}

export type Tab<K, V> = {[K]: V}
export type AnyTab = Tab<any, any>

export type Iterable<K, V> = typeof(setmetatable({}, {} :: IterableMeta<K, V>))

export type AnyIter = AnyIterNoMeta & Iterable<any, any>
export type Iter<K, V> = IterNoMeta<K, V> & Iterable<K, V>

return nil