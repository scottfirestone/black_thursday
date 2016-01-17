class Customer
  attr_reader :data, :id, :first_name, :last_name

  def initialize(data)
    @data       = data
    @id         = data[:id].to_i
    @first_name = data[:first_name].capitalize
    @last_name  = data[:last_name].capitalize
  end

  def created_at
    Time.parse(data[:created_at]) if data[:created_at]
  end

  def updated_at
    Time.parse(data[:updated_at]) if data[:updated_at]
  end
end
