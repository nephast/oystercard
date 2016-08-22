require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe '#initialize' do
    it 'instantiates with a balance of 0' do
      expect(oystercard.balance).to eq described_class::DEFAULT_BALANCE
    end

    it 'has a default limit' do
      expect(oystercard.limit).to eq described_class::DEFAULT_LIMIT
    end

    it 'sets a given limit' do
      oystercard = Oystercard.new 100
      expect(oystercard.limit).to eq 100
    end

    it 'sets a given balance' do
      oystercard = Oystercard.new 100, 50
      expect(oystercard.balance).to eq 50
    end

    it 'raises an error when instantiated balance is larger than limit' do
      msg = 'Balance cannot be larger than limit'
      expect {Oystercard.new 50, 100}.to raise_error msg
    end

  end

  describe '#top_up' do

    it 'confirms new balance after top-up' do
      msg = "Your new balance is 10"
      expect(oystercard.top_up(10)).to eq msg
    end

    it 'updates the balance' do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it 'raises error if limit reached' do
      oystercard.top_up(90)
      msg = 'Balance limit reached'
      expect {oystercard.top_up(1)}.to raise_error msg
    end
  end

  describe '#deduct' do
    it 'will reduce the balance by a specified amount' do
      oystercard.top_up(50)
      oystercard.deduct(5)
      expect(oystercard.balance).to eq 45
    end

    it 'will raise an error when there is insufficient balance' do
      msg = "Insufficient funds"
      expect {oystercard.deduct(5)}.to raise_error msg
    end
  end

end
