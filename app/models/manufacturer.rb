class Manufacturer < ApplicationRecord
  validates :name, presence: { message: 'Nome não pode ficar em branco' }
  validates :name, uniqueness: { message: 'Nome já está em uso'}
end
