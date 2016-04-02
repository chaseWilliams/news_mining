
class Array
  def to_str
    string = ''
    each do |item|
      string += "#{item}"
    end
    string
  end
end