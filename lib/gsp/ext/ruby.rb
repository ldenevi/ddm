module GSP::Ext::Ruby
end

class Array
  def select_numerics
    select { |i| i.is_a?(Numeric) }
  end

  def average
    select_numerics.sum / size
  end
end
