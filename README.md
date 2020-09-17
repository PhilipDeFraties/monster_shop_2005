# Monster Shop

## Table of Contents
* [Description](#description)
* [Status](#status)
* [Learning Goals](#learning-goals)
* [Installation and Setup](#installation-and-setup)
* [Technologies Used](#technologies-used)
* [Reflection](#reflection)
* [Contributors](#contributors)

## Description

"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will be able to get "shipped" by an admin. Each user role will have access to some or all CRUD functionality for application models.

## Status

This project is currently in development.

## Learning Goals

### Rails
* Create routes for namespaced routes
* Implement partials to break a page into reusable components
* Use Sessions to store information about a user and implement login/logout functionality
* Use filters (e.g. `before_action`) in a Rails controller
* Limit functionality to authorized users
* Use BCrypt to hash user passwords before storing in the database

### ActiveRecord
* Use built-in ActiveRecord methods to join multiple tables of data, calculate statistics and build collections of data grouped by one or more attributes

### Databases
* Design and diagram a Database Schema
* Write raw SQL queries (as a debugging tool for AR)

## Installation and Setup

In your terminal enter the following commands:

```
# Clone Repository
git clone https://github.com/PhilipDeFraties/monster_shop_2005.git
cd monster_shop_2005

# Install Dependencies
bundle install

# Create Database
rails db:create

# Migrate Database
rails db:migrate

# Seed Database
rails db:seed

# Run Test Suite
rspec

# Start Server
rails s
```

After following the above commands you should be able to go to localhost/3000 with your browser and see the application.

## Technologies Used

- Ruby
- GitHub
- GitHub Projects
- Atom
- Slack
- Zoom

## Reflection

__What was the context for this project?__

__What did you set out to build?__

__Why was this project challenging and therefore a really good learning experience?__

__What were some unexpected obstacles?__

## Contributors

- [Daniel Halverson](https://github.com/dhalverson)
- [Daniel Lessenden](https://github.com/D-Lessenden)
- [Philip DeFraties](https://github.com/PhilipDeFraties)
- [Ryan Barnett](https://github.com/RyanDBarnett)
