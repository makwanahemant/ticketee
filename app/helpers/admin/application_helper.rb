module Admin::ApplicationHelper
  def roles
    {
      'Manager' => 'manager',
      'Editor' => 'Editor',
      'Viewer' => 'Viewer'
    }
  end
  #
#  def roles
#    hash = {}
#    %w(manager editor viewer).each do |role|
#    Role.available_roles.each do |role|
#      hash[role.titleize] = role
#    end
#    hash
#  end
end
