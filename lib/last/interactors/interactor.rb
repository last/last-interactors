module Last
module Interactors

class Interactor
  attr_reader :form
  attr_reader :actor

  # @param account [Form] Form object for retreiving input parameters.
  # @param actor   [Account] Resource responsible for this interaction, typically an authenticated account.
  #
  def initialize(form: nil, actor: nil)
    @form  = form
    @actor = actor
  end

  # @return [self]
  #
  def call
    command
    self
  end

  # @return [Boolean]
  #
  def failed?
    @failed || false
  end

  # @return [Boolean]
  #
  def successful?
    !failed?
  end

private

  def command; raise NoMethodError; end

  def fail
    @failed = true
  end

  def fail!(exception: InteractorError, message: nil)
    fail
    raise exception, message
  end
end

class Interactor::InteractorError
  define_method(:http_status) { 500 }
end

end
end
