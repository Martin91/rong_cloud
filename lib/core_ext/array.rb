class Array
  # inspired by http://api.rubyonrails.org/classes/Array.html#method-i-extract_options-21
  def extract_options!
    last.is_a?(Hash) ? pop : {}
  end
end