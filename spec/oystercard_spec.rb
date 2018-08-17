require 'oystercard'

describe Oystercard do

  let(:station){ double :station }
  let(:exit_station){ double :exit_station }
  subject { described_class.new(0, journey_log) }
  let(:journey_log) { double :journey_log }

  it 'sets default value to 0' do
    expect(subject.balance).to eq 0
  end

  describe '#add_money' do

    it 'adds money to the oystercard' do
      expect(subject).to respond_to(:add_money).with(1).argument
    end

    it 'adds £50 to oystercard' do
      expect(subject.add_money(50)).to eq subject.balance
    end

    it 'tops up the balance by 1' do
      expect { subject.add_money(1) }.to change{ subject.balance }.by 1
    end

    it 'caps the oystercard limit to £90' do
      max_balance = Oystercard::MAX_LIMIT
      subject.add_money(max_balance)
      expect { subject.add_money(1) }.to raise_error "max limit of #{max_balance} reached"
    end
  end

  describe '#touch_in' do

    it 'responds to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'returns true if touch_in' do
      allow(journey_log).to receive(:start)
      subject.add_money(5)
      subject.touch_in(station)
      allow(journey_log).to receive(:in_journey?).and_return true
      expect(subject.journey_log.in_journey?).to eq true
    end

    it 'stores the entry station when touched-in' do
      allow(journey_log).to receive(:start)
      subject.add_money(10)
      subject.touch_in(station)
      allow(journey_log).to receive(:entry_station).and_return station
      expect(subject.journey_log.entry_station).to eq station
    end

  end

  describe "#touch_out" do

    it "responds to touch_out" do
      expect(subject).to respond_to(:touch_out)
    end

    it "returns false if touch_out" do
      allow(journey_log).to receive(:finish)
      allow(journey_log).to receive(:fare).and_return Oystercard::MAX_LIMIT
      subject.touch_out(exit_station)
      allow(journey_log).to receive(:in_journey?).and_return false
      expect(subject.journey_log.in_journey?).to eq false
    end

    it "returns the correct balance after touch-out" do
      allow(journey_log).to receive(:finish)
      allow(journey_log).to receive(:start)
      allow(journey_log).to receive(:fare).and_return Oystercard::MIN_CHARGE
      subject.add_money(10)
      subject.touch_in(station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -Oystercard::MIN_CHARGE
    end

    it "stores the exit station when touch-out" do
      allow(journey_log).to receive(:finish)
      allow(journey_log).to receive(:fare).and_return Oystercard::MIN_CHARGE
      allow(journey_log).to receive(:exit_station).and_return exit_station
      subject.touch_out(exit_station)
      expect(subject.journey_log.exit_station).to eq exit_station
    end

  end

  describe "#journey-list" do
    it "stores a list of stations on journey" do
      allow(journey_log).to receive(:journey_arr).and_return ( [{:entry => station, :exit => exit_station}] )
      expect(subject.journey_log.journey_arr).to eq ( [{:entry => station, :exit => exit_station}] )
    end
  end
end
