require 'gtk3'
require 'synthesizer.rb'

class App
  def initialize
    @synth = Synthesizer::Simple.new
  end

  def run 
    # Create a window
    window = Gtk::Window.new("Synth UI")
    window.set_size_request(400, 250)

    # Create a box to hold the sliders and labels
    box = Gtk::Box.new(:vertical, 10)
    box.margin = 10
    window.add(box)

    # Frequency slider and label
    frequency_label = Gtk::Label.new("Frequency:")
    box.pack_start(frequency_label, expand: false, fill: false, padding: 0)

    frequency_slider = Gtk::Scale.new(:horizontal, 20, 2000, 1)
    frequency_slider.set_value(@synth.frequency)
    frequency_slider.signal_connect("value-changed") do |widget|
      @synth.frequency = widget.value
    end
    box.pack_start(frequency_slider, expand: false, fill: false, padding: 0)

    # Amplitude slider and label
    amplitude_label = Gtk::Label.new("Amplitude:")
    box.pack_start(amplitude_label, expand: false, fill: false, padding: 0)

    amplitude_slider = Gtk::Scale.new(:horizontal, 0, 1, 0.01)
    amplitude_slider.set_value(@synth.amplitude)
    amplitude_slider.signal_connect("value-changed") do |widget|
      @synth.amplitude = widget.value
    end
    box.pack_start(amplitude_slider, expand: false, fill: false, padding: 0)

    # Waveform selector
    waveform_label = Gtk::Label.new("Waveform:")
    box.pack_start(waveform_label, expand: false, fill: false, padding: 0)

    waveform_combo = Gtk::ComboBoxText.new
    waveform_combo.append_text("Sine")
    waveform_combo.append_text("Square")
    waveform_combo.append_text("Sawtooth")
    waveform_combo.set_active(0)
    waveform_combo.signal_connect("changed") do |widget|
      case widget.active_text
      when "Sine"
        @synth.waveform = :sine
      when "Square"
        @synth.waveform = :square
      when "Sawtooth"
        @synth.waveform = :sawtooth
      end
    end
    box.pack_start(waveform_combo, expand: false, fill: false, padding: 0)

    # Start and stop buttons
    start_button = Gtk::Button.new(label: "Start")
    start_button.signal_connect("clicked") do |widget|
      @synth.start
    end
    box.pack_start(start_button, expand: false, fill: false, padding: 0)

    stop_button = Gtk::Button.new(label: "Stop")
    stop_button.signal_connect("clicked") do |widget|
      @synth.stop
    end
    box.pack_start(stop_button, expand: false, fill: false, padding: 0)

    # Show the window
    window.show_all
    Gtk.main
  end
end
