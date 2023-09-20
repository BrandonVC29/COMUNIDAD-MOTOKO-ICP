import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Like { 'user' : Principal, 'postId' : string }
export interface _SERVICE {
  'createPost' : ActorMethod<[string], undefined>,
  'getLikes' : ActorMethod<[string], Array<Like>>,
  'likePost' : ActorMethod<[string], boolean>,
}
