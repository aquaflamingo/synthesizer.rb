require_relative 'musical.rb' 
require 'audio'

class Simple
  include Musical 

  def initialize(waveform=:sine)
    @waveform = waveform
  end

  def play_note_letter(note, duration)
    frequency = letter_to_frequency(note)
    play_note_frequency(frequency, duration)
  end

  def play_note_frequency(note, duration)
    waveform = generate_waveform(note)
    Audio.play(waveform)
  end

  def generate_waveform(freq, duration)
    waveform = @waveform
    samples = duration * Audio::SAMPLE_RATE
    phase_increment = freq / Audio::SAMPLE_RATE
    phase = 0.0
    waveform_samples = []
    
    samples.to_i.times do |i|
      case waveform
      when :sine
        waveform_samples << Math.sin(2 * Math::PI * phase)
      when :sawtooth
        waveform_samples << ((phase * 2) - 1)
      when :square
        waveform_samples << (phase < 0.5 ? -1 : 1)
      end
      
      phase += phase_increment
      phase -= 1 if phase >= 1
    end
    
    waveform_samples
  end
end
