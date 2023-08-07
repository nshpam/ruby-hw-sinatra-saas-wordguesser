class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  attr_accessor :word,:guesses,:wrong_guesses

  def guess(letter)

    # letter is Empty and None
    if letter.nil? || letter.empty? || letter == ""
      raise ArgumentError, "Please input the letter."
    end

    # letter is not a single alphabet
    if letter.length != 1 then
      raise ArgumentError, "Please input only one alphabet."
    end

    # letter is alphabet
    unless letter.match?(/[A-Za-z]/) then
      raise ArgumentError, "Please input only alphabet."
    end

    letter = letter.downcase

    if @word.include?(letter) and not guesses.include?(letter) then
      @guesses = @guesses+letter
      return true
    elsif not @word.include?(letter) and not wrong_guesses.include?(letter) then
      @wrong_guesses = @wrong_guesses+letter
      return true
    end
    return false
  end

  def check_str
    chars = @guesses.split('')
    chars.each { |c|
      if not @word.match?(c) then
        return false
      end
    }
    if @word.length == @guesses.length then
      return true
    else
      return false
    end
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7 then
      :lose
    elsif check_str == true then
      puts(check_str)
      :win
    else
      :play
    end
  end

  def word_with_guesses
    display = @word.chars.map { |letter| @guesses.include?(letter) ? letter : '-' }
    display.join('')
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end


end

# Check List Created By Sirapa Sangna
# [/] The computer picks a random word
# [] The player guesses letters in order to guess the word
# [] If the player guesses the word before making seven wrong guesses of letters, 
#    they win; otherwise they lose. (Guessing the same letter repeatedly is simply ignored.)
# [] A letter that has already been guessed or is a non-alphabet character is considered 
#    "invalid", i.e. it is not a "valid" guess
