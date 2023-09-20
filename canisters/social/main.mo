import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";

actor PostCrud {
    type PostId = Nat32;

    // Define una estructura para representar los likes
    type Like = {
        user: Principal;
        postId: Text;
    };

    type Post = {
        creator: Principal;
        originalCreator: Principal;
        message: Text;
        likes: Buffer.Buffer<Like>; // Almacena los likes asociados al post
    };

    stable var postId: PostId = 0;
    let postList = HashMap.HashMap<Text, Post>(0, Text.equal, Text.hash);

    private func generateTaskId() : Nat32 {
        postId += 1;
        return postId;
    };

    public shared ({ caller }) func createPost(message: Text) : async () {
        // Al crear el post, el creador original es el mismo
        let post = {
            creator = caller;
            originalCreator = caller;
            message;
            likes = Buffer.Buffer<Like>(0);
        };

        postList.put(Nat32.toText(generateTaskId()), post);
        Debug.print("New post created! ID: " # Nat32.toText(postId));
    };

    // Agrega una función para dar like a un post
    public shared ({ caller }) func likePost(postId: Text) : async Bool {
        // let user: Principal = msg.caller;
        let post: ?Post = postList.get(postId);

        switch (post) {
            case (null) {
                return false; // El post no existe
            };
            case (?currentPost) {
                // Verifica si el usuario ya dio like al post
                let likesArray = Buffer.toArray<Like>(currentPost.likes);
                let currentLike = Array.find<Like>(likesArray, func like = Principal.equal(like.user, caller));
                switch (currentLike) {
                    case (null) {
                        // Agrega el like a la lista de likes del post
                        currentPost.likes.add(
                            {
                                user = caller;
                                postId;
                            }
                        );
                        postList.put(postId, currentPost); // Actualiza el post con el nuevo like
                        return true;
                    };
                    case (_) {
                        // El usuario ya dio like al post
                        return false;
                    }
                };

                /*
                if (currentPost.likes.all({like -> Bool in like.user != user})) {
                    // Agrega el like a la lista de likes del post
                    currentPost.likes.append({user: user, postId: postId});
                    postList.put(postId, currentPost); // Actualiza el post con el nuevo like
                    return true;
                } else {
                    // El usuario ya dio like al post
                    return false;
                }
                */
                return false;
            };
        };
    };

    // Agrega una función para consultar la cantidad de likes de un post
    public query func getLikes(postId: Text) : async [Like] {
        let post: ?Post = postList.get(postId);

        switch (post) {
            case (null) {
                return []; // El post no existe
            };
            case (?currentPost) {
                return Buffer.toArray<Like>(currentPost.likes); // Devuelve la lista de likes del post
            };
        };
    };
}