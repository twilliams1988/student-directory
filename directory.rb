#Things I could add:
#1: Blank input while loop checker for all the blank input checking.
#2: Name input method

@students = []
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit retrun twice on name"
  #Create empty array
  @students = []
  #Get the first names
  name = STDIN.gets.chop
  if name == ""
    exit_countdown
  end
  # While the array is not empty, repeat this code
  puts "Is #{name} spelt correctly? y/n"
  spell = STDIN.gets.chop.downcase
  until spell == "n" || spell == "y"
    puts "You didn't enter 'y' or 'n', please re-enter:"
    spell = STDIN.gets.chop.downcase
  end
  while spell == "n"
    puts "Please re-enter the name spelt correctly:"
    name = STDIN.gets.chop
    puts "Is #{name} spelt correctly? y/n"
    spell = STDIN.gets.chop.downcase
    until spell == "n" || spell == "y"
      puts "You didn't enter 'y' or 'n', please re-enter:"
      spell = STDIN.gets.chop.downcase
    end
  end
  while !name.empty? do
    # Add the student hash to the array
    puts "Please enter #{name}'s cohort in the format 'monthYY'"
    cohort = STDIN.gets.chop
    while cohort.empty? do
      puts "You must enter #{name}'s cohort"
      cohort = STDIN.gets.chop
    end
    $cohort_months = [ "april15", "april16", "august14",
                      "december14", "february15", "february16",
                      "january16", "july15", "june15", "may14",
                      "november15", "october14", "october15",
                      "september14", "september15", "july16",
                      "may16"]
    until $cohort_months.include?(cohort)
      puts "You did not enter a valid cohort e.g. july16"
      cohort = STDIN.gets.chop
    end
    cohort.to_sym
=begin
    hobbies = []
    puts "Please enter #{name}'s hobbies, one by one followed by return."
    hobby_each = STDIN.gets.chop
    while !hobby_each.empty? do
      hobbies << hobby_each
      hobby_each = STDIN.gets.chop
    end
=end
    puts "Please enter #{name}'s country of birth"
    country_birth = STDIN.gets.chop
    while country_birth.empty? do
      puts "You must enter #{name}'s country of birth"
      country_birth = STDIN.gets.chop
    end
    @students << {name: name, cohort: cohort, country_birth: country_birth}
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    # Get another name from the user
    puts "Please enter the name of the next student"
    name = STDIN.gets.chop
  end
end

def print_header
  puts "-"*50
  puts "The students of Villains Academy".center(50)
  puts "-"*50
end

def print_cohorts(students)
  cohort_sorted = students.group_by { |e| e[:cohort] }
  cohort_sorted.each do |k,v|
    puts "-" * 50
    print "Cohort: #{k}\t"
    puts ""
    v.each do |student|
      puts "\n\tName: #{student[:name]}\n\tBorn in: #{student[:country_birth]}"
    end
  end
end

def print_footer(names)
  if @students.count == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{names.count} great students"
  end
end

def print_menu
  # 1. print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end

def show_students
  print_header
  print_cohorts(@students)
  print_footer(@students)
end

def process(selection)
  case selection
  when "1"
    print "Taking you to the student input form"
    dot_counter
    input_students
  when "2"
    print "Printing the current list of students"
    dot_counter
    show_students
  when "3"
    print "Saving the students"
    dot_counter
    save_students
  when "4"
    print "Loading the students"
    dot_counter
    load_students
  when "9"
    exit_countdown
  else
    puts "I don't know what you meant, try again"
  end
end

def exit_countdown
  puts "The program is quitting..."
  3.downto(1) do |i|
    puts "#{i}"
    sleep 1
  end
  exit
end

def dot_counter
  print "."
  2.downto(1) do |i|
    print "."
    sleep 1
  end
  puts "."
end

def save_students
  # open file for writing
  puts "Please enter a filename in the format xxxxxxxx.csv:"
  filename = gets.chomp
  CSV.open(filename, "w") { |row|
  # iterate over the array of students
  @students.each do |student|
    students_data = [student[:name], student[:cohort], student[:country_birth]]
    row << students_data
    end
  }
  puts "Your data has been saved."
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    puts "Would you like to load a csv file? y/n?"
    load_file_yn = gets.chomp
    if load_file_yn == "y"
      load_students
    else
      interactive_menu
    end
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def load_students(filename = "students.csv")
  puts "Please enter the filename you would like to open:"
  filename = gets.chomp
  CSV.foreach(filename, "r") do |row|
    name, cohort, country_birth = row[0], row[1], row[3]
    @students << {name: name, cohort: cohort.to_sym, country_birth: country_birth}
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

#try_load_students
#interactive_menu
puts File.read(__FILE__)

#students = input_students
#print_header
#print_name(@students)
#print_cohorts(@students)
#print_footer(@students)

=begin
def print_name(students)
  i = 0
  while (i < students.length)
      puts "#{i+1}.\tName: #{students[i][:name]}\n\tCohort: #{students[i][:cohort]}\n\tBorn in: #{students[i][:country_birth]}\n\tHobbies: #{students[i][:hobbies].join(", ")}"
      i += 1
  end
end

def print_cohorts(students)
  i = 0
  while (i < students.length)
      puts "#{i+1}.\tName: #{students[i][:name]}\n\tCohort: #{students[i][:cohort]}\n\tBorn in: #{students[i][:country_birth]}\n\tHobbies: #{students[i][:hobbies].join(", ")}"
      i += 1
  end
end
=end

=begin
def print(students)
  students.each_with_index do |student, index|
    if student[:name].length < 12
      puts "#{index.to_i + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end
=end

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
