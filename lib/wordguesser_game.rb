class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guess = ""
    @Wrong_guess = ""
    @display = ""
    @count = 0
    word.length.times do @display += '-' end
  end

  def word()
    @word
  end

  def guess (guess)
    raise ArgumentError.new("Error") if guess == nil
    raise ArgumentError.new("Error") if guess.length == 0
    raise ArgumentError.new("Error") if guess =~ /\W/
    guess.downcase!

    if word.include?(guess)
      if @guess.include?(guess)
        return false
      else
        i = 0
        word.length.times do 
          if word[i] == guess
            @display[i] = guess
          end
          i +=1
        end
          @guess =guess
      end
    else
      if @Wrong_guess.include?(guess)
        return false
      else
        @Wrong_guess = guess
      end
    end
    @count+=1
  end

  def guesses()
    @guess
  end

  def wrong_guesses()
    @Wrong_guess
  end

  def word_with_guesses()
    @display
  end

  def check_win_or_lose()
    if @count >=7
      return :lose
    else
      if @word == @display
        return :win
      else
        return :play
      end
    end
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
