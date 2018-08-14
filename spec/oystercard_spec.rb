require 'oystercard'

describe Oystercard do
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
       expect(subject).not_to be_in_journey
     end

  end

  describe "#touch_out" do

    it "responds to touch_out" do
      expect(subject).to respond_to(:touch_out)
    end

    it "returns false if touch_out" do
      expect(subject.touch_out).to eq false
    end

    it "returns the correct balance after touch-out" do
      subject.add_money(10)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by -Oystercard::MIN_CHARGE
    end
  end

  describe "#in_journey" do
    it "responds to in_journey?" do
      expect(subject).to respond_to(:in_journey?)
    end

    # it "responds to touch_in" do
    #   allow(subject).to receive(:in_journey).and_return(true)
    #   # subject.touch_in
    #   expect(subject.in_journey).to eq(true)
    # end

    it "responds to touch_out" do
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

    it "can touch out" do
      allow(subject).to receive(:touch_in) { true }
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
