class FlatPolicy < ApplicationPolicy
  require 'pry'
  # NOTE: Be explicit about which records you allow access to!
  # def resolve
  #   scope.all
  # end
  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all # If users can see all flats
      # scope.where(user: user) # If users can only see their flats
      # scope.where("name LIKE 't%'") # If users can only see flats starting with `t`
      # ...
      # user.admin? ? scope.all : scope.where(user: user)
    end
  end
end