class Car
  def initialize(name, model)
    @name = name
    @model = model
  end

  def fake_method(size)
    size.each do |i|
      puts i
    end
  end
end
