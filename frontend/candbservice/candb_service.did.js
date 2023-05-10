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
  const Service = IDL.Service({
    'categorySearchNewest' : IDL.Func(
        [IDL.Text, IDL.Opt(IDL.Text)],
        [IDL.Text, IDL.Opt(IDL.Text)],
        ['query'],
      ),
    'getNextKeysForParallelSearchTerm' : IDL.Func(
        [],
        [IDL.Vec(IDL.Text)],
        ['query'],
      ),
    'getPK' : IDL.Func([], [IDL.Text], ['query']),
    'isStatusComplete' : IDL.Func([], [IDL.Bool], ['query']),
    'searchCanisterId' : IDL.Func([IDL.Text, IDL.Text], [IDL.Text], ['query']),
    'searchCategory' : IDL.Func(
        [IDL.Text, IDL.Opt(IDL.Text)],
        [IDL.Text, IDL.Opt(IDL.Text)],
        ['query'],
      ),
    'searchTerm' : IDL.Func(
        [IDL.Text, IDL.Opt(IDL.Text)],
        [IDL.Text, IDL.Opt(IDL.Text)],
        ['query'],
      ),
    'searchTermForParallel' : IDL.Func(
        [IDL.Vec(IDL.Text)],
        [IDL.Text, IDL.Vec(IDL.Text)],
        ['query'],
      ),
    'searchTermWithNextKeysForParallelSearch' : IDL.Func(
        [IDL.Text],
        [IDL.Text, IDL.Vec(IDL.Text)],
        ['query'],
      ),
    'searchTermWithTarget' : IDL.Func(
        [IDL.Bool, IDL.Bool, IDL.Bool, IDL.Vec(IDL.Text), IDL.Opt(IDL.Text)],
        [IDL.Text, IDL.Opt(IDL.Text)],
        ['query'],
      ),
    'skExists' : IDL.Func([IDL.Text], [IDL.Bool], ['query']),
    'transferCycles' : IDL.Func([], [], []),
    'upload' : IDL.Func([IDL.Text], [], []),
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
