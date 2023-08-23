import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export type AutoScalingCanisterSharedFunctionHook = ActorMethod<
  [string],
  string
>;
export type CountOfWord = bigint;
export type Host = string;
export type KindOfWord = bigint;
export type Path = string;
export type PathIdx = bigint;
export type ScalingLimitType = { 'heapSize' : bigint } |
  { 'count' : bigint };
export interface ScalingOptions {
  'autoScalingHook' : AutoScalingCanisterSharedFunctionHook,
  'sizeLimit' : ScalingLimitType,
}
export interface Service {
  'batchPut' : ActorMethod<
    [
      Array<
        [
          Host,
          Array<Path>,
          Array<Title>,
          Array<CountOfWord>,
          Array<KindOfWord>,
          Array<[Word, [Array<Tf>, Array<PathIdx>]]>,
        ]
      >,
    ],
    undefined
  >,
  'getNextKeysForParallelSearchTitle' : ActorMethod<[bigint], Array<string>>,
  'getPK' : ActorMethod<[], string>,
  'isStatusComplete' : ActorMethod<[], boolean>,
  'search' : ActorMethod<
    [Array<Word>],
    Array<[Host, Array<[Title, Path, bigint, bigint, Array<Tf>]>]>
  >,
  'searchTitle' : ActorMethod<
    [Array<string>, [] | [string], bigint],
    Array<[Host, Array<[Title, Path, bigint, bigint, Array<Tf>]>]>
  >,
  'skExists' : ActorMethod<[string], boolean>,
  'transferCycles' : ActorMethod<[], undefined>,
}
export type Tf = number;
export type Title = string;
export type Word = string;
export interface _SERVICE extends Service {}
