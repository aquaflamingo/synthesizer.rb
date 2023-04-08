require 'synthesizer.rb'

class TerminalApp
  attr_accessor :octave

  def initialize 
    @octave = 1
    @synth = Synthesizer::Factory.make(:simple)
  end 

  # Starts at octave 3
  NOTE_KEY_MAP = {
    'a' => 55.00,   # A1
    's' => 61.74,   # B1
    'd' => 65.41,   # C2
    'f' => 73.42,   # D2
    'g' => 82.41,   # E2
    'h' => 87.31,   # F2
    'j' => 98.00,   # G2
    'k' => 110.00,  # A2
    'l' => 123.47   # B2
  }

  # Start the terminal app
  def self.run
    # Loop until the user enters 'q'
    loop do
      # Wait for user input
      input = ''

      until NOTE_MAP.key?(input)
        input += STDIN.getch
      end

      # Exit the loop if the user enters 'q'
      break if input == 'q'

      # Get the frequency of the note from the note map
      frequency = NOTE_MAP[input] * @octave

      # If the note is valid, play it
      if frequency
        @synth.play_note_frequency(frequency, 1)
      end
    end
  end
end
