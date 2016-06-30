# The Pivot - Farmer's Market

### Turing Module 3 -- Three-person project

This project builds upon an existing implementation of an e-commerce site [Lucky Charms](https://github.com/ksk5280/lucky-charms). The original site was transformed from an individual e-commerce site selling luck into a marketplace for local produce that handles multiple, simultaneous businesses. 

* [Original Assignment](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/the_pivot.md)
* [Lucky Charms Website](https://polar-reef-22111.herokuapp.com)
* [Carrots 'n Stuff Website](https://karrots-n-stuff.herokuapp.com)


## <a name="learning-goals"></a> Learning Goals

* Adapting an improving upon an existing codebase, "brownfield" development
* Working with Multitenancy
* Implementing JavaScript
* Securing a Rails App
* Sending Email
* Creating Seed files

## <a name="technical-expectations"></a> Technical Expectations

The original site was extended so that it can handle multiple, simultaneous businesses. Each business has:

* A unique name
* A unique URL pattern (http://example.com/name-of-business)
* Unique items
* Unique orders
* Unique administrators

The new site handles the following users:

### Guest Customer

As a guest customer, I should be able to:

* Visit different businesses.
* Add items from multiple businesses into a single cart.
* Log in or create an account before completing checkout.

### Registered Customer

As an registered customer, I should be able to:

* Make purchases on any business
* Manage my account information
* View my purchase history

### Business Admin

As a business admin, I should be able to:

* Manage items on my business
* Update my business information
* Manage other business admins for your store

### Platform Admin

As a platform admin, I should be able to:

* Approve or decline the creation of new businesses
* Take a business offline / online
* Perform any functionality restricted to business admins


## <a name="base-data"></a> Base Data

The following data is pre-loaded in the marketplace:

* 20 total businesses
* 10 categories
* 50 items per category
* 100 registered customers, one with the following data:
  * Username: josh@turing.io
  * Password: password
* 10 orders per registered customer
* 1 business admins per business
  * Username: andrew@turing.io
  * Password: password
* 1 platform administrators
  * Username: jorge@turing.io
  * Password: password

Most of the data was created using the [Faker](https://github.com/stympy/faker) gem.
