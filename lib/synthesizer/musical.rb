module Synthesizer 
  module Musical 

    # Convert a letter notation to a frequency
    def letter_to_frequency(note)
      # Map note letters to frequencies (adjust this as needed for your desired tuning)
      note_frequencies = {
        "C"  => 261.63,
        "C#" => 277.18,
        "D"  => 293.66,
        "D#" => 311.13,
        "E"  => 329.63,
        "F"  => 349.23,
        "F#" => 369.99,
        "G"  => 392.00,
        "G#" => 415.30,
        "A"  => 440.00,
        "A#" => 466.16,
        "B"  => 493.88
      }

      # Look up the frequency for the given note
      note_frequencies[note]
    end
  end
end
