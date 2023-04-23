export const idlFactory = ({ IDL }) => {
  const IndexCanister = IDL.Service({
    'autoScaleServiceCanister' : IDL.Func([IDL.Text], [IDL.Text], []),
    'createServiceCanisterByPk' : IDL.Func([IDL.Text], [IDL.Opt(IDL.Text)], []),
    'getCanistersByPK' : IDL.Func([IDL.Text], [IDL.Vec(IDL.Text)], ['query']),
  });
  return IndexCanister;
};
export const init = ({ IDL }) => { return []; };
