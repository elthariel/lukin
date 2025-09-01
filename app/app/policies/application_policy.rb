# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :ctx, :record

  def initialize(ctx, record)
    @ctx = ctx
    @record = record
  end

  delegate :admin?, to: :ctx

  def index?
    admin?
  end

  def show?
    admin?
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  def update?
    admin?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(ctx, scope)
      @ctx = ctx
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :ctx, :scope
  end
end
