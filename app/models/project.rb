class Project
  include MongoMapper::Document

  key :name, String, :required => true

  has_many :error_reports, :class_name => 'Error'

  has_many :members

  validate :need_members
  validate :need_admin_members

  def add_admin_member(user)
    members.build(:user => user, :admin => true)
  end

  private

  def need_members
    errors.add(:members, 'need_member') if members.empty?
  end

  def need_admin_members
    errors.add(:members, 'need_admin_member') unless members.any?{ |m| m.admin }
  end
end
