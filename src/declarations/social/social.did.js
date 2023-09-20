export const idlFactory = ({ IDL }) => {
  const Like = IDL.Record({ 'user' : IDL.Principal, 'postId' : IDL.Text });
  return IDL.Service({
    'createPost' : IDL.Func([IDL.Text], [], []),
    'getLikes' : IDL.Func([IDL.Text], [IDL.Vec(Like)], ['query']),
    'likePost' : IDL.Func([IDL.Text], [IDL.Bool], []),
  });
};
export const init = ({ IDL }) => { return []; };
