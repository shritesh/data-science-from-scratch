users = [
    (id = 0, name = "Hero"),
    (id = 1, name = "Dunn"),
    (id = 2, name = "Sue"),
    (id = 3, name = "Chi"),
    (id = 4, name = "Thor"),
    (id = 5, name = "Clive"),
    (id = 6, name = "Hicks"),
    (id = 7, name = "Devin"),
    (id = 8, name = "Kate"),
    (id = 9, name = "Klein")
]

friendship_pairs = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3), (3, 4),
                    (4, 5), (5, 6), (5, 7), (6, 8), (7, 8), (8, 9)]

friendships = Dict(user.id => [] for user in users)

for (i, j) in friendship_pairs
    push!(friendships[i], j)
    push!(friendships[j], i)
end

function number_of_friends(user)
    friend_ids = friendships[user.id]
    length(friend_ids)
end

total_connections = sum(number_of_friends(user) for user in users)
@assert total_connections == 24

num_users = length(users)
@assert num_users == 10

avg_connections = total_connections / num_users
@assert avg_connections == 2.4

num_friends_by_id = [(user.id, number_of_friends(user)) for user in users]
sort!(num_friends_by_id, by = id_and_friends->id_and_friends[2], rev = true)
@assert num_friends_by_id[1][2] == 3
@assert num_friends_by_id[end] == (9, 1)

foaf_ids_bad(user) = [foaf_id for friend_id in friendships[user.id] for foaf_id in friendships[friend_id]]
@assert foaf_ids_bad(users[begin]) == [0, 2, 3, 0, 1, 3]

