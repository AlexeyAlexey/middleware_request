class MiddlewareRequest::IdAndParams

  def initialize
    @unique_request_id = "#{self.object_id}" + SecureRandom.hex(10) + "#{Time.now.utc.to_i}"
  end

  def self.current=(current)
    Thread.current[:request_id_and_params] = current
  end

  def self.new_current
    Thread.current[:request_id_and_params] = RequestIdAndParams.new
  end

  def self.current
    Thread.current[:request_id_and_params] ||= RequestIdAndParams.new
  end

  def regenerate_unique_request_id
    @unique_request_id = "#{self.object_id}" + SecureRandom.hex(10) + "#{Time.now.utc.to_i}"
  end

  def unique_request_id
    @unique_request_id ||= generate_unique_request_id
  end

  def method_missing(method_name, *args, &block)
    define_method("#{method_name}=") do |value|
      instance_varible_set("@#{method_name}", value)
    end

    define_method(method_name) do 
      instance_varible_get("@#{method_name}")
    end
  end

end