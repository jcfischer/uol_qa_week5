
line = "Hello World how are you World"


def count_words file, word
  File.open(file) do |f|
    count_words_in_file f, word
  end
end

def count_words_in_file f, word
  counter = 0
  f.each do |line|
    counter += number_of_occurences_of_word_in_line line, word
  end
  counter
end

def number_of_occurences_of_word_in_line line, word
  line.split(/\s+/).count { |w| w == word }
end



puts number_of_occurences_of_word_in_line "World", line

puts count_words __FILE__, "def"
