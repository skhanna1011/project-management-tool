# A poro decorator class that provides 2 hash generators
#   called as_json and as_short_json
# Override attributes_for_output and attributes_for_short_output
#   These attributes are picked from the child decorator first and if not
#   found there are delegated to the model.  Exception is raised when an attr
#   is expected but not found.

class ApplicationDecorator

  def initialize(model)
    @model = model
  end

  def as_json(options = {})
    options[:only] ||=  attributes_for_output
    _json(options)
  end

  def as_short_json(options = {})
    options[:only] ||=  attributes_for_short_output
    _json(options)
  end

  attr_reader :model

  private

  def attributes_for_output
    raise "attributes_for_output is not implemented by child class #{self.class}"
  end

  def attributes_for_short_output
    raise "attributes_for_short_output is not implemented by child class #{self.class}"
  end

  def _json(options)
    keys = options[:only].map(&:to_s).uniq
    result = model.as_json(options).merge(_hash(self, keys))
    result.merge!(_hash(model, keys - result.keys))
    remaining_keys = keys - result.keys
    raise "#{model.class} or #{self.class} has no attr called #{remaining_keys.map(&:inspect).to_sentence} " unless remaining_keys.empty?
    result
  end

  def _hash(obj, keys)
    Hash[ keys.select{ |attr| obj.respond_to?(attr) }.map{ |attr| [attr.to_s, obj.public_send(attr)] } ]
  end

end
