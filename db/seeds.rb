User.create(username: 'torianne', email: 'torianne@gmail.com', password: 'password')

User.create(username: 'kevcraw', email: 'kevcraw@gmail.com', password: 'password1')

User.create(username: 'coachflu', email: 'coachflu@gmail.com', password: 'password2')

User.create(username: 'torrnado', email: 'torrnado@gmail.com', password: 'tornado1')

City.create(name: 'Houston')

City.create(name: 'Austin')

City.create(name: 'New Orleans')

City.create(name: 'Jacksonville')

City.create(name: 'Moab')

Trip.create(length_of_visit: '1 day', city_id: 1, user_id: 1)

Trip.create(length_of_visit: '3 days', city_id: 2, user_id: 1)

Trip.create(length_of_visit: '4 days', city_id: 3, user_id: 2)

Trip.create(length_of_visit: '2 days', city_id: 4, user_id: 3)

Trip.create(length_of_visit: '2 days', city_id: 5, user_id: 2)

Trip.create(length_of_visit: '1 week', city_id: 2, user_id: 4)

Trip.create(length_of_visit: '2 months', city_id: 4, user_id: 4)

Trip.create(length_of_visit: '6 days', city_id: 3, user_id: 3)
