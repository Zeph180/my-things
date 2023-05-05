require './app'

def main
  response = App.new

  loop do
    user_answer = App.new.menu
    choice user_answer, response
  end
end

main
