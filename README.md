# Customer Relationship Manager (CRM) Assignment

## What You Will Learn

We'll be covering the following concepts:

* Classes and creating new instances of classes
* Instance methods versus class methods
* Along similar lines, instance variables versus local variables
* Getters and setters (methods that let us get and set variables inside of a class)
* And in general, Object Oriented Programming (OOP)
* Using User Stories to guide your development

## Getting Started

0. Fork the this repository on Github to your account.
0. Clone the repo onto your own computer.

## The Assignment

The assignment is to implement a customer relationship management (CRM) application.

Be sure to start by reading over the entire assignment to get a general overview of what you have to do.

### User Stories

Software developers use "user stories" as a guide to know what to implement. They serve as descriptions of the interactions that users should be able to have with the application. Below we have written out all of the user stories for the CRM. Use these as a to-do list or guide when making your app.

* As a user, upon starting the CRM, I am presented with a prompt to **add**, **modify**, **delete**, **display all**, **search by attribute**,  and **exit**.
* As a user, if I select **add** I am prompted to enter a 'first name', 'last name', 'email' and 'note'.
* As a user, if I select **modify** I am prompted to enter an id for the contact to be modified.
* As a user, when I enter the id of the user I want to modify I am then prompted to select which attribute I want to change from the list 'first name', 'last name', 'email', or 'note'.
* As a user, when I enter the attribute I want to change I am then prompted to enter a new value for the attribute.
* As a user, if I select **delete** I am then prompted to enter the id of the contact I want to delete.
* As a user, if I select **display all** I am then shown all of the contacts that exist.
* As a user, if **search by attribute** is selected, I am prompted to select which attribute I want to search by.
* As a user, when I choose which attribute I want to search by, I am then prompted to enter the search term.
* As a user, when I enter the search term I am then presented with the first contact who matches my search.
* As a user, if I select **exit** I am returned to the command line.

Below is a guide on how to get started, how to implement the first few user stories, and some examples of how to work with classes, objects, instance variables and other things you will need.  However, this guide is not meant to be enough to get you through this assignment from start to finish.  Writing your first multi-class program is challenging and we anticipate that you will get stuck more than once in the process.  Asking for help is encouraged and expected!

### Creating a Contact class

First, let's get to the crux of this app: How are we going to store all of the contacts' information?

We could store it into an array or hash. Something like this:

```ruby
contacts = [
  {
    first_name: 'Betty',
    last_name: 'Maker',
    email: 'bettymakes@gmail.com',
    note: 'Loves Pokemon.'
  },
  {
    first_name: 'Octo',
    last_name: 'Cat',
    email: 'octocat@github.com',
    note: 'Is it an octopus? Is it a cat?'
  }
]
```

We can do better though. We could make a class called `Contact`.

What are classes and why do we use them? It's similar to the reason why we use methods – they let us organize our code.

Imagine if we had dozens of methods floating around with no structure – classes let us organize these methods into categories.

Open up the provided `contact.rb` file. You'll see that it's got a bunch of empty methods waiting for you to implement them.

Go ahead and implement the `initialize` method in the `Contact` class:

*Note: Vertical dots indicate omitted code for brevity's sake.*

```ruby
class Contact
  .
  .
  .
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end
  .
  .
  .
end
```

Now whenever we want to make a new contact, we could do something like this:

```ruby
contact = Contact.new('Betty', 'Maker', 'bettymakes@gmail.com', 'Loves Pokemon')
```

#### Using Getters and Setters

What if after we want to find out what the contact's email is after we've created it?  Or change the notes?

```ruby
contact = Contact.new(
  'Betty',
  'Maker',
  'bettymakes@gmail.com',
  'Loves Pokemon'
)
# How can I get contact's email?
# Then how can I change contact's note to 'Loves HTML & CSS'?
```

We need some attribute 'getters' (or 'readers') and 'setters' (or 'writers') inside the `Contact` class. In this scenario we need to be able to 'get' the email and 'set' the note of a contact.

```ruby
class Contact
  .
  .
  .
  # a getter (*get* the value of an attribute)
  def email
    @email
  end

  # a setter (*set* the value of an attribute)
  def note=(note)
    @note = note
  end
  .
  .
  .
end

# now we can do this:
contact.email # => 'bettymakes@gmail.com'
contact.note = 'Loves HTML & CSS'
```

Instead of writing out these methods ourselves like we did in the above code snippet, we could just use `attr_accessor`, `attr_reader`, and `attr_writer`.

These are special Ruby methods that will automatically create getters and setters for you.

* `attr_accessor` will give you both getters and setters,
* `attr_reader` gives you just getters, and
* `attr_writer` gives you just setters.

```ruby
class Contact
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note
  .
  .
  .
end
```

After you add `attr_reader` and `attr_accessor`, be sure to remove the `email` and `note=` methods if you actually implemented them in your class. As mentioned before, the getters and setters will be automatically created for you.

If you don't add getters and setters to your class's attributes then you won't be able to access or update those attributes from the code outside of your class definition:

```ruby
class Contact
.
.
.
  #no getters or setters here!
.
.
.
end

contact.email # this is cause an error!
contact.note = "new note" # this will also cause an error!
```

#### Storing all new Contacts in a list

We need to store our newly created `Contact` objects somewhere. Since it will be a list of contacts, the best object type to use would be an `Array`, since it represents an ordered list of objects. We want our `Contact` class to keep track of this list, so we'll store it in a **class variable**.

#### Class variables

A class variable is a variable that's declared at the class level and shared across all objects of the same type. In our case, we'll setup a class variable to store the array of all the contacts we create. We'll also create a class variable called `@@id` to ensure that our contacts each have a unique identifier.

```ruby
class Contact
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note

  @@contacts = []
  @@id = 1
  .
  .
  .
end
```

These variables will be available to all `Contact` object instances.

#### Add a method to create new Contacts

Adding a contact to our CRM has two steps: first we need to make ("instantiate") a new contact object and then we need to save it into the list of contacts. We want to keep our methods focused and simple so we'll separate the functionality of instantiating an object from the functionality of adding it to our list with a new **class method**.

#### Class methods

So far, all of the methods we've created were **instance methods**. Instance methods can only be used by a specific instance of an object, not the class itself (hence the name!).  Put another way, and instance method is an action that an instance knows how to perform.

Class methods are performed by the class itself and are usually reserved for actions that operate on the whole set of objects of that type. Instantiating a new contact and storing it in the list of all contacts affects the collection of all contacts so it's a good use case for a class method. It wouldn't make senese to give that responsibility to any single contact object.  You can call a class method on the name of the class itself, eg. `Contact.super_fun_class_method`. 

You define a class method by prefixing the name of the method with `self`.

What purpose do class methods serve and why would we want to use them? This is a great example of where object oriented design comes into play. Instance methods should involve logic that only make sense being applied to *an instance* of something, such as updating the email of *a specific person*.  A class method involves logic that should be applied on the whole scale of the model, such as cleaning up the email addresses of all the contacts. So the first example would be `some_contact.update_email(email)` and the second `Contact.clean_email_addresses`.

Go ahead and implement the `create` method as follows:

```ruby
# remember, we preface the method name with 'self.' if it is a class method
def self.create(first_name, last_name, email, note)
  new_contact = Contact.new(first_name, last_name, email, note)
  @@contacts << new_contact
  return new_contact
end
```

Our initialize method should be responsible for setting the first name, last name, email, and note that get passed in from the `create` method.  Additionally, it should set the id of the contact and increment the class `@@id` variable so that the next contact will get a different id.

```ruby
def initialize(first_name, last_name, email, note)
  .
  .
  .
  @id = @@id
  @@id += 1 # this way the next contact will get a different id
end
```

#### Other Methods

The implementation of the following methods are left up to you:

* `self.all`
* `self.find`
* `self.find_by`
* `self.delete_all`
* `full_name`
* `update`
* `delete`

### Creating a CRM Class

Open up the provided `crm.rb` file, and again you'll see that it has a bunch of empty methods waiting for you to implement them.

#### Creating the Menu

If you look at our user stories, you'll see we need to be able to prompt the user to select from a main menu. The code for that might look something like this:

```ruby
def main_menu
  while true # repeat indefinitely
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
  end
end

def print_main_menu
  puts '[1] Add a new contact'
  puts '[2] Modify an existing contact'
  puts '[3] Delete a contact'
  puts '[4] Display all the contacts'
  puts '[5] Search by attribute'
  puts '[6] Exit'
  puts 'Enter a number: '
end
```

We have two methods: `print_main_menu` prints out the menu and `main_menu` calls `print_main_menu` and then stores the user input (a number) into a variable called `user_selected`. That variable then gets passed as an argument into a method we haven't defined yet called `call_option`.

What do you think `call_option` should do? Remember, `user_selected` is going to be a number. What we want to do in this method is call other methods based on the number. We've started off this method for you:

```ruby
def call_option(user_selected)
  case user_selected
  when 1 then add_new_contact
  when 2 then modify_existing_contact
  # Finish off the rest for 3 through 6
  # To be clear, the methods add_new_contact and modify_existing_contact
  # haven't been implemented yet
  end
end
```

*Question:* What should happen when option 6 is selected? Hint: Google 'How to exit a Ruby program'.

#### Menu Actions

You will need to implement several methods for the menu to call.

  * `add_new_contact`
  * `modify_existing_contact`
  * `delete_contact`
  * `display_all_contacts`
  * `search_by_attribute`

The `add_new_contact` method might looks something like this:

```ruby
def add_new_contact
  print 'Enter First Name: '
  first_name = gets.chomp

  print 'Enter Last Name: '
  last_name = gets.chomp

  print 'Enter Email Address: '
  email = gets.chomp

  print 'Enter a Note: '
  note = gets.chomp

  Contact.create(first_name, last_name, email, note)
end
```

#### Other Methods

Implementation of the following methods are you to you.

* `modify_existing_contact`
* `delete_contact`
* `display_all_contacts`
* `search_by_attribute`

#### Requiring Files

Note that the `CRM` class needs to makes use of the `Contact` class, for example in the `add_new_contact` method. Many of the other methods in the `CRM` class will also make use of the `Contact` class.

Classes work together to make the entire program functional. We let classes use other classes by *importing* a file. The way this is done is using a method called `require_relative`, and basically what it does is get that file and stick it right in that line where the `require_relative` method was called.

Open up **`crm.rb`** and insert the following `require_relative` statement:

```ruby
require_relative 'contact'

class CRM
  .
  .
  .
end
```

Now, the `CRM` class will be able to make use of the `Contact` class.

#### Using the CRM class

Now how do we call methods that are inside of classes? Like this:

```ruby
a_crm_app = CRM.new
a_crm_app.main_menu
```

If we wanted to call `print_main_menu` instead, that would look like:

```ruby
a_crm_app.print_main_menu
```

When we do:

```ruby
a_crm_app = CRM.new
```

We're creating a *new instance* of the class CRM, and we're saving that new instance into a variable called `a_crm_app`. This is just like having a blueprint of a house, and every time you build a house off the blueprint you create a new instance of a house.

Then we can **call** the methods that we defined inside the class **on** the instance. `main_menu` and `print_main_menu` are methods inside of the class CRM, and we can call them on `a_crm_app`, which is an instance of the class. For example, `a_crm_app.main_menu` tells `a_crm_app` to perform the `main_menu` action.

#### Passing in Arguments when Initializing

When we want to create a new instance of a class, we call a method named `new` (as in `CRM.new`). In some cases we want it so that arguments have to be passed in, for example the new instance you make has to be given a name. In other words, you want to see something like this: `CRM.new("My CRM App")`.

For this to be done we need to manipulate a method named `initialize` in the class.

```ruby
class CRM
  .
  .
  .
  def initialize(name)
    puts "Okay, this CRM has the name " + name
  end
  .
  .
  .
end
```

`initialize` and `new` are synonymous, so when you call `new`, you're calling `initialize`.

#### Instance Variables versus Local Variables

This bridges us over into another great point for OOP: instance variables.

```ruby
class CRM
  .
  .
  .
  def initialize(name_being_passed_in)
    name = name_being_passed_in
  end

  # Can I access name here, outside of the method?
  # No, and this is because the variable only has a local scope.

  .
  .
  .
end
```

How could we make it so that the variable `name` would be available outside of the `initialize` method? We could make it an instance variable, and the way we do this is by prepending the symbol `@` in front of the name. Like this:

```ruby
class CRM
  .
  .
  .

  def initialize(name_being_passed_in)
    @name = name_being_passed_in
  end

  # Now I can access name here, outside of the method.
  # It's a Ruby thing, if a variable starts with the symbol @,
  # I can access it outside of the method it was defined in.

  .
  .
  .
end
```

And why would we want to do this?

Why of course, to do something like this, just like in the `Contact` class:

```ruby
class CRM

  def initialize(name)
    @name = name # this is how the variable naming is normally done BTW
  end

  def what_is_the_name_of_this_CRM_again
    "Oh master, how could you forget? It was " + @name
  end
  .
  .
  .
end
```

You don't have to implement the `what_is_the_name_of_this_CRM_again` method, it was just for fun to show you how the `@name` instance variable can be used.



### Running the Program

Run the CRM program at the command line:

```bash
ruby crm.rb
```

If all goes well, you will be presented with the main menu, from where you can then manually try out your program.  

If nothing happens, maybe you forgot to create an instance of the CRM outside of the class definition, or maybe you forgot to tell that instance to do anything.  Which method should you call in order to start the program?

### What We've Learned

* Writing classes and creating new instances of them
* Instance methods
* Manipulating the initialize method
* Instance variables (for example `@name`)
* Getters and setters
* Class variables
* Class methods
* How to "import" a file with `require_relative`

And that is our first practical look at OOP! Please feel free to take your application to the next level by adding your own functionality where you see fit.

### Tips & Tricks

To enhance the user experience of your program, you can use `puts "\e[H\e[2J"` to clear your terminal screen.

### Additional Resources

* [Stack Overflow: `attr_accessor`, `attr_reader`, `attr_writer`](http://stackoverflow.com/questions/5046831/why-use-rubys-attr-accessor-attr-reader-and-attr-writer)
* [Blog - User Stories](http://codesqueeze.com/the-easy-way-to-writing-good-user-stories/)
* [Instance Method versus Class Method – Stack Overflow](http://stackoverflow.com/questions/11655593/ruby-on-rails-should-i-use-class-method-or-instance-method-and-why)

## Submitting Your Work


Have fun and don't forget to work alongside a partner!

