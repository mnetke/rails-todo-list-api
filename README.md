# Todo List API
 1. bundle
 2. rake db:create db:migrate
 3. rails s

  letter_opener_web        /letter_opener                                                                           LetterOpenerWeb::Engine
             authenticate GET    /authenticate(.:format)                                                                  authentication#authenticate
                    users POST   /users(.:format)                                                                         users#create
                     user GET    /users/:id(.:format)                                                                     users#show
               todo_items GET    /todos/:todo_id/items(.:format)                                                          items#index
                          POST   /todos/:todo_id/items(.:format)                                                          items#create
                todo_item GET    /todos/:todo_id/items/:id(.:format)                                                      items#show
                          PATCH  /todos/:todo_id/items/:id(.:format)                                                      items#update
                          PUT    /todos/:todo_id/items/:id(.:format)                                                      items#update
                          DELETE /todos/:todo_id/items/:id(.:format)                                                      items#destroy
                    todos GET    /todos(.:format)                                                                         todos#index
                          POST   /todos(.:format)                                                                         todos#create
                     todo GET    /todos/:id(.:format)                                                                     todos#show
                          PATCH  /todos/:id(.:format)                                                                     todos#update
                          PUT    /todos/:id(.:format)                                                                     todos#update
                          DELETE /todos/:id(.:format)  
