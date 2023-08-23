export const idlFactory = ({ IDL }) => {
  const AutoScalingCanisterSharedFunctionHook = IDL.Func(
      [IDL.Text],
      [IDL.Text],
      [],
    );
  const ScalingLimitType = IDL.Variant({
    'heapSize' : IDL.Nat,
    'count' : IDL.Nat,
  });
  const ScalingOptions = IDL.Record({
    'autoScalingHook' : AutoScalingCanisterSharedFunctionHook,
    'sizeLimit' : ScalingLimitType,
  });
  const Host = IDL.Text;
  const Path = IDL.Text;
  const Title = IDL.Text;
  const CountOfWord = IDL.Nat;
  const KindOfWord = IDL.Nat;
  const Word = IDL.Text;
  const Tf = IDL.Float64;
  const PathIdx = IDL.Nat;
  const Service = IDL.Service({
    'batchPut' : IDL.Func(
        [
          IDL.Vec(
            IDL.Tuple(
              Host,
              IDL.Vec(Path),
              IDL.Vec(Title),
              IDL.Vec(CountOfWord),
              IDL.Vec(KindOfWord),
              IDL.Vec(
                IDL.Tuple(Word, IDL.Tuple(IDL.Vec(Tf), IDL.Vec(PathIdx)))
              ),
            )
          ),
        ],
        [],
        [],
      ),
    'getNextKeysForParallelSearchTitle' : IDL.Func(
        [IDL.Nat],
        [IDL.Vec(IDL.Text)],
        ['query'],
      ),
    'getPK' : IDL.Func([], [IDL.Text], ['query']),
    'isStatusComplete' : IDL.Func([], [IDL.Bool], ['query']),
    'search' : IDL.Func(
        [IDL.Vec(Word)],
        [
          IDL.Vec(
            IDL.Tuple(
              Host,
              IDL.Vec(IDL.Tuple(Title, Path, IDL.Int, IDL.Int, IDL.Vec(Tf))),
            )
          ),
        ],
        ['query'],
      ),
    'searchTitle' : IDL.Func(
        [IDL.Vec(IDL.Text), IDL.Opt(IDL.Text), IDL.Nat],
        [
          IDL.Vec(
            IDL.Tuple(
              Host,
              IDL.Vec(IDL.Tuple(Title, Path, IDL.Int, IDL.Int, IDL.Vec(Tf))),
            )
          ),
        ],
        ['query'],
      ),
    'skExists' : IDL.Func([IDL.Text], [IDL.Bool], ['query']),
    'transferCycles' : IDL.Func([], [], []),
  });
  return Service;
};
export const init = ({ IDL }) => {
  const AutoScalingCanisterSharedFunctionHook = IDL.Func(
      [IDL.Text],
      [IDL.Text],
      [],
    );
  const ScalingLimitType = IDL.Variant({
    'heapSize' : IDL.Nat,
    'count' : IDL.Nat,
  });
  const ScalingOptions = IDL.Record({
    'autoScalingHook' : AutoScalingCanisterSharedFunctionHook,
    'sizeLimit' : ScalingLimitType,
  });
  return [
    IDL.Record({
      'owners' : IDL.Opt(IDL.Vec(IDL.Principal)),
      'partitionKey' : IDL.Text,
      'scalingOptions' : ScalingOptions,
    }),
  ];
};
