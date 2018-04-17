# Prof Review

[![Maintainability](https://api.codeclimate.com/v1/badges/f321390d0b4f870e9d5e/maintainability)](https://codeclimate.com/github/lyc4n/prof-review/maintainability)

An app that allows students to review professors

# Features

- CRUD backend for creating professors, users, and subjects
- Rating/reviewing professors
- Professor page with summary of ratings on handled subjects

# Technologies

- Ruby - 2.3.1 / Ruby on Rails - 5.1.6
- ReactJS
- Sqlite

# Setup

1. Install RVM and ruby 2.3.1
2. Clone the project
    ```sh
    git clone https://github.com/lyc4n/prof-review.git
    ```
3. cd into the project (this will create the gemset and ask you to install ruby 2.3.1 if you don't have it)
    ```sh
    cd prof-review
    ```
4. Run bundle install
    ```
    bundle install
    ```
5. Create the database
   ```sh
    rails db:create
   ```
6. Run migrations
   ```sh
   rails db:migrate
   ```
7. Seed the database
   ```sh
   rails db:seed
   ```
   - This will create AdminUser, User, Professor, and Subject records.
   - The generated AdminUser will have the following login detail and can login
       through /admin (once the server is running)

     - admin@example.com
     - password

8. Make sure you have [yarn](https://yarnpkg.com/en/) installed

9. Install js dependencies
    ```sh
    yarn
    ```
10. Run webpack-server
    ```sh
    ./bin/webpack-dev-server
    ```

11. Run rails server on another terminal tab
    ```sh
    rails s
    ```

# Running test

1. Run
   ```sh
   rspec
   ```

# TODOs

- [ ] Complete feature test
- [ ] Let user see other reviews for a class
