# Semantic Versioning

By Joe Fiume  
[jfiume.github.io](http://https://github.com/jfiume)

## Instructions

1. Install Gemfile dependencies with "bundle install"
2. Use the command line to input the program name.
  * ex: "ruby lib/semantic_versioning.rb "
3. Input as many commands as you like.
4. To tell the program you are done inputting and want to print the output - type: "done"
5. The results will print to the command terminal after the word "results:"
5. Run the RSpec tests with the command "bundle exec rspec"
6. Watch the tests pass
7. Enjoy!

## Discussion
* I used the following technologies: Ruby and Rspec.
* I used an array to hold the outputs for the command terminal.

## Requirements
#### Implement Semantic Versioning
Inputs from the command line are passed to the SemanticVersioning class. Then inputs are evaluated for validity. Next the inputs are evaluated for before, after and equal. At the end the terminal prints the results.

#### Tests
There are several tests to for instance methods. There is also a test for the desired output.
