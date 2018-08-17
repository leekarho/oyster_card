require 'journey_log'

describe Journey_log do

  let(:station){ double :station }
  let(:exit_station){ double :exit_station }

  it "sets the journey_arr to empty by default" do
    expect(subject.journey_arr).to eq([])
  end

  describe '#start' do
    it 'responds to one argument' do
      expect(subject).to respond_to(:start).with(1).argument
    end

    it 'stores the entry station when touched-in' do
      subject.start(station)
      subject.finish(exit_station)
      expect(subject.journey_arr[0].has_value?(exit_station)).to eq true
    end
  end

  describe '#finish' do
    it "stores the exit station when touch-out" do
      subject.start(station)
      subject.finish(exit_station)
      expect(subject.journey_arr[0].has_value?(exit_station)).to eq true
    end
  end

  describe "#journey-list" do
    it "stores a list of stations on journey" do
      subject.start(station)
      subject.finish(exit_station)
      expect(subject.journey_arr).to eq ( [{:entry => station, :exit => exit_station}] )
    end
  end

end
