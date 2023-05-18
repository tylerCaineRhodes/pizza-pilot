# README

# Pizza Pilot

Le Pizza Pilot is a Rails application designed for managing pizzas and their
toppings.

## Getting Started

These instructions will get you a copy of the project up and running on your
local machine for development and testing purposes.

### Prerequisites

You need to have the following installed:

- Ruby 3.2.0
- Rails 7.0.4
- PostgreSQL

### Installing

After cloning this repo, run the following commands to install dependencies and
set up your development environment:

```bash
bundle install
rails db:create db:migrate
```

This will install the necessary gems and set up your database.


### Configuration

The application uses environment variables for database configurations. Please
set the following environment variables in your development and test
environments:

- `PIZZA_PILOT_DATABASE_USERNAME`
- `PIZZA_PILOT_DATABASE_PASSWORD`

Make sure these variables match your PostgreSQL setup.

## Running the application

```bash
rails s
```

Then, open your web browser to http://localhost:3000.

## Running the tests

```bash
rspec
```

## Le Features

### Manage Le Toppings

As a pizza store owner, you can:
- View a list of available toppings
- View a topping and it's associated pizzas
- Navigate to a topping's associated pizzas
- Add a new topping
- Delete an existing topping
- When a topping is deleted it's associated pizzas are updated to remove the topping
- Update an existing topping

The application ensures that there are no duplicate toppings.

### Manage Le Pizzas
As a pizza chef, you can:

- View a list of available pizzas and their toppings
- View a pizzas and it's associated toppings
- Navigate to a pizza's associated toppings
- Create a new pizza and add toppings to it
- Delete an existing pizzas.
- Update an existing pizza and it's toppings.

The application ensures that there are no duplicate pizzas.

## Deployment
I understand using Heroku is a bit of a cop-out, but I wanted to ensure that it worked out of the box given the time constraints. I've deployed the application to Heroku at https://boiling-cliffs-23389.herokuapp.com/
## Additional Notes

Given more time, I would have preferred to create a pure JSON API in Rails and
use React or TS/JS on the frontend. This approach more closely aligns with my
experience and comfort level. However, to avoid sinking too much time and effort
into decision-making and subsequent configuration of Rails to work smoothly with
React, I opted to use ERB Rails views out of the box (for the first time). As a
result, the backend more accurately reflects my experience than the frontend,
which I was learning for the first time on the fly to ensure the application's
quality.
