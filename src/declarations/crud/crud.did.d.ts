import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Post { 'creator' : Principal, 'message' : string }
export interface _SERVICE {
  'createPost' : ActorMethod<[string], undefined>,
  'deletePost' : ActorMethod<[string], boolean>,
  'getPost' : ActorMethod<[string], [] | [Post]>,
  'getPosts' : ActorMethod<[], Array<[string, Post]>>,
  'updatePost' : ActorMethod<[string, string], boolean>,
}
