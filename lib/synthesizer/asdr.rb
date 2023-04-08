module Synthesizer
  class ASDR
    def initialize
      @waveform = :sine
      @frequency = 440.0
      @amplitude = 0.5
      @phase = 0.0
      @attack_time = 0.1
      @decay_time = 0.1
      @sustain_level = 0.5
      @release_time = 0.2
    end

    def play_note(note)
      envelope = generate_envelope
      waveform = generate_waveform(note)
      waveform = apply_envelope(waveform, envelope)
      Audio.play(waveform)
    end

    def generate_waveform(note)
      frequency = calculate_frequency(note)
      phase_increment = frequency / Audio.sample_rate
      waveform = []
      (0..Audio.buffer_size).each do |i|
        phase = @phase + i * phase_increment
        sample = generate_sample(phase)
        waveform << sample
      end
      waveform
    end

    def apply_envelope(waveform, envelope)
      waveform.map.with_index do |sample, i|
        envelope_value = envelope[i]
        sample * envelope_value
      end
    end

    def generate_envelope
      envelope = []
      attack_samples = (@attack_time * Audio.sample_rate).to_i
      decay_samples = (@decay_time * Audio.sample_rate).to_i
      release_samples = (@release_time * Audio.sample_rate).to_i
      sustain_level = @sustain_level * @amplitude
      (0..Audio.buffer_size).each do |i|
        if i < attack_samples
          envelope_value = i / attack_samples.to_f
        elsif i < attack_samples + decay_samples
          decay_index = i - attack_samples
          decay_value = (1 - sustain_level) * (1 - decay_index / decay_samples.to_f) + sustain_level
          envelope_value = decay_value
        elsif i >= Audio.buffer_size - release_samples
          release_index = Audio.buffer_size - i - 1
          release_value = envelope[Audio.buffer_size - release_samples] * release_index / release_samples.to_f
          envelope_value = release_value
        else
          envelope_value = sustain_level
        end
        envelope << envelope_value
      end
      envelope
    end

    # The rest of the code remains the same
  end
end
