require 'spec_helper'

RSpec.describe Ziptz do
  let(:ziptz) { Ziptz.new }

  describe 'when inspected' do
    it 'does not show internal instance variables' do
      expect(ziptz.inspect).to match(/#<Ziptz:\d+>/)
    end
  end

  describe '#time_zone_name' do
    context 'when given a 5-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_name('97034')).to eq 'America/Los_Angeles'
      end
    end

    context 'when given a 9-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_name('97034-1234')).to eq 'America/Los_Angeles'
      end
    end

    context 'when there is no matching zipcode' do
      it 'returns nil' do
        expect(ziptz.time_zone_name('xyz')).to be_nil
      end
    end
  end

  describe '#time_zone_uses_dst?' do
    context 'when given a 5-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_name('97034')).to eq 'America/Los_Angeles'
      end
    end
  end

  describe '#time_zone_offset' do
    context 'when given a 5-digit zipcode' do
      it 'returns a boolean' do
        expect(ziptz.time_zone_uses_dst?('97034')).to eq true
        expect(ziptz.time_zone_uses_dst?('85004')).to eq false
      end
    end

    context 'when given a 9-digit zipcode' do
      it 'returns a boolean' do
        expect(ziptz.time_zone_uses_dst?('97034-1234')).to eq true
        expect(ziptz.time_zone_uses_dst?('85004-1234')).to eq false
      end
    end

    context 'when there is no matching zipcode' do
      it 'returns nil' do
        expect(ziptz.time_zone_offset('xyz')).to be_nil
      end
    end
  end

  describe '#zips' do
    context 'when given a time zone' do
      it 'returns an array of zip codes' do
        expect(ziptz.zips('Pacific/Pago_Pago')).to eq %w[96799]
      end

      it 'is case-insensitive' do
        expect(ziptz.zips('pacific/pago_pago')).to eq %w[96799]
      end

      it 'returns nil for unknown time zones' do
        expect(ziptz.zips('Glark')).to be_nil
      end
    end
  end
end
