# README

1. create api app
   rails new [name] --api
2. Creating a route to list records (after add route in routes.rb, run it to create)
   bin/rails routes
3. Create controller
   rails g controller [name]Controller index
4. Testing the route via cURL
   curl http://localhost:3000/[routeName]
5. creating model
   rails g model [modelName] param1:param1Type param2:param2Type
6. db migration
   rails db:migrate
7. insert data into table
   - open rails console
     rails c
   - [name].create!(param1: value, param2: value)
   - curl http://localhost:3000/[routeName]
8. Building a post endpoint
   - rails routes | grep [route name]
   - example : curl --header "Content-Type: application/json" --request POST --data '{"autor": "Manh", "title": "Rails Api"}' http://localhost:3000/books -v
