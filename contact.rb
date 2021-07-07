class Contact
  @@contacts = []
  @@id = 1

  # This method should initialize the contact's attributes
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
    @id = @@id
    @@id +=1
  end

  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note



  # This method should call the initializer, 
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note)
    puts "========================================"
    puts "NEW CONTACT ADDED:"
    new_contact=Contact.new(first_name, last_name, email, note)
    @@contacts << new_contact
    p new_contact

  end

  # This method should return all of the existing contacts
  def self.all
    puts "========================================"
    puts "CONTACTS STORED:"
    p @@contacts
  end

  # This method should accept an id as an argument
  # and return the contact who has that id
  # two methods below, the first one works but is vulnerable since IDs could change

  def self.find(id_number)
    @@contacts[id_number-1]
  end

  # def self.find(id_number)
  #   puts "========================================"
  #   puts "Found the following matches for your search of ID number #{id_number}:"
  #   @@contacts.each do |contact|
  #     if contact.id == id_number
  #       puts ""      
  #       p contact
  #     else
  #       puts "None found"
  #     end
  #   end
  # end

  # This method should allow you to specify 
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  
  # def update -- changed to MODIFY in order to reflect description of CRM in doc

  # The reason the commented out method does not work and doesn't make sense is that with an instance method, you have to have the instance already, you have the object
  # You are calling it w/ that specific instance and so you don't need to iterate through the array to find it
  # you already have the instance: "self" contains that instance, and then you can can specify the instance variables that you want to read/modify
   
  #def modify(id_number, contact_attribute, new_value)
  #   puts "========================================"
  #   puts "MODIFYING SELECTED CONTACT"
    # @@contacts.each do |contact|
    #   if contact.id == id_number && contact_attribute==1
    #     contact.first_name=new_value
    #     p contact
    #   elsif contact.id == id_number && contact_attribute==2
    #     contact.last_name=new_value
    #   elsif contact.id == id_number && contact_attribute==3
    #       contact.email=new_value
    #     elsif contact.id == id_number && contact_attribute==4
    #       contact.note=new_value
    #   end
    # end
    def modify(contact_attribute, new_value)
    puts "========================================"
    puts "MODIFYING SELECTED CONTACT"
    case contact_attribute
    when 1
      self.first_name=new_value
    when 2
      self.last_name=new_value
    when 3
      self.email=new_value
    when 4
      self.note=new_value
    end
    p self
  end


  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty
  def self.find_by (attribute, value)
    found = 0
    @@contacts.each do |contact|
      if attribute == "first name" && contact.first_name==value
        found +=1
        p contact
      elsif attribute == "last name" && contact.last_name==value
        found +=1
        p contact
      elsif attribute == "email" && contact.email==value
        found +=1
        p contact
      elsif attribute == "note" && contact.note==value
        found +=1
        p contact
      end
    end
      if found==0 
        puts ""
        puts "No results found."
      else
        puts ""
        puts "#{found} result(s) found."
      end
  end

  # This method should delete all of the contacts
  def self.delete_all
    @@contacts=[]
    p @@contacts
    puts "All contacts deleted."
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  # def delete(id_number)
  #   @@contacts.select! do |contact| contact.id != id_number
  #   end
  # end

def delete
  @@contacts.delete(self) 
end

  # Feel free to add other methods here, if you need them.



end

# puts "Creating Contacts"
# Contact.create('Betty', 'Maker', 'bettymakes@gmail.com', 'Loves Pokemon')
# Contact.create("Funny","Guy","laughing@yahoo.com", "not so funny")
# Contact.create("Dorian","Gray","pictures@outlook.com","a bit vain")
# puts "-------------------------------------------------------------------"
# puts "Displaying Contacts"
# p Contact.all
# puts "-------------------------------------------------------------------"
# puts "Testing Find by ID"
# p Contact.find(3)
# puts "-------------------------------------------------------------------"
# puts "Testing Find by Attribute: search first name = Betty"
# p Contact.find_by("first name", "Betty")
# puts "Testing Find by Attribute: search last name = Gray"
# p Contact.find_by("last name","Gray")
# puts "-------------------------------------------------------------------"
