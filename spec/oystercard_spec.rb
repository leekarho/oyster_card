require 'oystercard'

describe Oystercard do

  let(:station){ double :station }
  let(:exit_station){ double :exit_station }

  it 'sets default value to 0' do
    expect(subject.balance).to eq 0
  end

  it "sets the journey_list to empty by default" do
    expect(Oystercard.new.journey.journey_list).to eq ( { entry: [], exit: [] } )
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
      subject.add_money(5)
      subject.journey.start(station)
      expect(subject.journey.in_journey?).to eq true
    end

    it 'stores the entry station when touched-in' do
      subject.add_money(10)
      subject.touch_in(station)
      expect(subject.journey.entry_station).to eq station
    end

  end

  describe "#touch_out" do

    it "responds to touch_out" do
      expect(subject).to respond_to(:touch_out)
    end

    it "returns false if touch_out" do
      subject.touch_out(exit_station)
      expect(subject.journey.in_journey?).to eq false
    end

    it "returns the correct balance after touch-out" do
      subject.add_money(10)
      subject.touch_in(station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -Oystercard::MIN_CHARGE
    end

    it "stores the exit station when touch-out" do
      subject.touch_out(exit_station)
      expect(subject.journey.exit_station).to eq exit_station
    end

  end

  describe "#in_journey" do
    it "responds to in_journey?" do
      expect(subject.journey).to respond_to(:in_journey?)
    end

    it "responds to touch_in" do
      subject.add_money(Oystercard::MAX_LIMIT)
      subject.touch_in(station)
      expect(subject.journey.in_journey?).to eq(true)
    end

    it "responds to touch_out" do
      subject.touch_out(station)
      expect(subject.journey.in_journey?).to eq(false)
    end

    it "can touch out" do
      allow(subject).to receive(:touch_in) { true }
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journey).not_to be_in_journey
    end
  end

  describe "#journey-list" do
    it "stores a list of stations on journey" do
      subject.add_money(Oystercard::MAX_LIMIT)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journey.journey_list).to eq ( {:entry => [station], :exit => [exit_station]} )
    end


  end
end
