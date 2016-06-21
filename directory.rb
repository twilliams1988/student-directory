$students = []
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit retrun twice on name"
  #Create empty array
  $students = []
  #Get the first names
  name = gets.chomp
  # While the array is not empty, repeat this code
  while !name.empty? do
    # Add the student hash to the array
    puts "Please enter #{name}'s cohort"
    cohort = gets.chomp
    while cohort.empty? do
      puts "You must enter #{name}'s cohort"
      cohort = gets.chomp.to_sym
    end
    hobbies = []
    puts "Please enter #{name}'s hobbies, one by one followed by return."
    hobby_each = gets.chomp
    while !hobby_each.empty? do
      hobbies << hobby_each
      hobby_each = gets.chomp
    end
    puts "Please enter #{name}'s country of birth"
    country_birth = gets.chomp
    while country_birth.empty? do
      puts "You must enter #{name}'s country of birth"
      country_birth = gets.chomp
    end
    $students << {name: name, cohort: cohort, hobbies: hobbies, country_birth: country_birth}
    puts "Now we have #{$students.count} students"
    # Get another name from the user
    puts "Please enter the name of the next student"
    name = gets.chomp
  end
end

def print_header
  puts "-"*50
  puts "The students of Villains Academy".center(50)
  puts "-"*50
end

def print_name(students)
  i = 0
  while (i < students.length)
      puts "#{i+1}. #{students[i][:name]} (#{students[i][:cohort]} cohort, born in #{country_birth}, whose hobbies include: #{students[i][:hobbies].join(", ")})"
      i += 1
  end
end

=begin
def print(students)
  students.each_with_index do |student, index|
    if student[:name].length < 12
      puts "#{index.to_i + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end
=end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print_name($students)
print_footer($students)

=begin
print_header
print(students)
print_footer(students)

{name: "Dr. Hannibal Lecter", cohort: :november},
{name: "Darth Vader", cohort: :november},
{name: "Nurse Ratched", cohort: :november},
{name: "Michael Corleone", cohort: :november},
{name: "Alex DeLarge", cohort: :november},
{name: "The Wicked Witch of the West", cohort: :november},
{name: "Terminator", cohort: :november},
{name: "Freddy Krueger", cohort: :november},
{name: "The Joker", cohort: :november},
{name: "Joffrey Baratheon", cohort: :november},
{name: "Norman Bates", cohort: :november}
=end
