class Simple
  def initialize
    @waveform = :sine
    @frequency = 440.0
    @amplitude = 0.5
    @phase = 0.0
  end

  def play_note(note)
    waveform = generate_waveform(note)
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

  def calculate_frequency(note)
    # Calculate frequency from note value (A4 = 440 Hz)
    440.0 * 2**((note - 69) / 12.0)
  end

  def generate_sample(phase)
    case @waveform
    when :sine
      Math.sin(2 * Math::PI * phase)
    when :square
      phase < 0.5 ? 1.0 : -1.0
    when :sawtooth
      2 * (phase - phase.floor) - 1
    end
  end
end
