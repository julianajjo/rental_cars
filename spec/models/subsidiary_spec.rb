require 'rails_helper'

RSpec.describe Subsidiary, type: :model do
  describe 'validates mandatory fields' do
    it 'should have a name' do
      sub = Subsidiary.new(name: '')

      result = sub.valid?

      expect(result). to eq false
      expect(sub.errors[:name]).to include 'não pode ficar em branco'
    end

    it 'should have a address' do
      sub = Subsidiary.new(address: '')

      result = sub.valid?

      expect(result). to eq false
      expect(sub.errors[:address]).to include 'não pode ficar em branco'
    end

    it 'should have a cnpj' do
      sub = Subsidiary.new(cnpj: '')

      result = sub.valid?

      expect(result). to eq false
      expect(sub.errors[:cnpj]).to include 'não pode ficar em branco'
    end
  end

  describe 'validate unique fields' do
    it 'should have unique name' do
      Subsidiary.create!(name: 'Paulista', address: 'Avenida Paulista', cnpj: '77658541000136')

      sub = Subsidiary.new(name: 'Paulista')

      result = sub.valid?

      expect(result).to be false
      expect(sub.errors[:name]).to include('já está em uso')
    end
    
    it 'should have unique cnpj' do
      Subsidiary.create!(name: 'Paulista', address: 'Avenida Paulista', cnpj: '77658541000136')

      sub = Subsidiary.new(cnpj: '77658541000136')

      result = sub.valid?

      expect(result).to be false
      expect(sub.errors[:cnpj]).to include('já está em uso')
    end
  end

  describe 'validate cnpj rules' do
    it 'should have a valid cnpj with 14 numbers' do
      sub = Subsidiary.new(name: 'Paulista', address: 'Avenida Paulista, 1000', cnpj: '000')

      result = sub.valid?

      expect(result).to be false
      expect(sub.errors[:cnpj]).to include('deve ter 14 números')
    end

    it 'should have a valid cnpj' do
      sub = Subsidiary.new(name: 'Paulista', address: 'Avenida Paulista, 1000', cnpj: '11111111111111')

      result = sub.valid?

      expect(result).to be false
      expect(sub.errors[:cnpj]).to include('não é válido')
    end
  end
end
