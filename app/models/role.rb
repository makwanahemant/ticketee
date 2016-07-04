class Role < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def roles
    {
      'Manager' => 'manager',
      'Editor' => 'Editor',
      'Viewer' => 'Viewer'
    }
  end
 
 
end
