export const idlFactory = ({ IDL }) => {
  const Post = IDL.Record({ 'creator' : IDL.Principal, 'message' : IDL.Text });
  return IDL.Service({
    'createPost' : IDL.Func([IDL.Text], [], []),
    'deletePost' : IDL.Func([IDL.Text], [IDL.Bool], []),
    'getPost' : IDL.Func([IDL.Text], [IDL.Opt(Post)], ['query']),
    'getPosts' : IDL.Func([], [IDL.Vec(IDL.Tuple(IDL.Text, Post))], ['query']),
    'updatePost' : IDL.Func([IDL.Text, IDL.Text], [IDL.Bool], []),
  });
};
export const init = ({ IDL }) => { return []; };
