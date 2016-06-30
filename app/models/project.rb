class Project < ApplicationRecord
  has_many :tickets, dependent: :delete_all # :delete_all for fact execution
  #has_many :tickets, dependent: :destroy # culling the project
                                         # it will delete all the tickets when
                                         # project is deleted
  validates :name, presence: true, uniqueness: true

end
